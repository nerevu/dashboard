Collection = require './base/collection'
Metric = require './metric'

getStatDetails = (final, initial) ->
  change = final - initial
  absChange = Math.abs change
  perChange = absChange / initial
  options = {style: 'currency', currency: 'USD'}
  valueText = final.toLocaleString('us-US', options)
  diffValueText = absChange.toLocaleString('us-US', options)
  if valueText is '$0.00'
    valueText = '$0'
  if diffValueText is '$0.00'
    diffValueText = '$0'

  {
    value: parseFloat(final.toFixed 2)
    valueText: valueText
    difference:
      value: parseFloat(absChange.toFixed 2)
      valueText: diffValueText
      percent: parseFloat(perChange.toFixed 2)
      percentText: perChange.toLocaleString('us-US', {style: 'percent'})
      color: if change > 0 then 'success' else 'danger'
      direction: if change > 0 then 'higher' else 'lower'
  }

module.exports = class Metrics extends Collection
  constructor: ->
    super Metric, 'data', 'dashboard'
    @listByRep = null
    @listByPeriod = null
    @periods = null
    @listByPeriodAndRep = {}
    @leaders = {}

    @categories = [
      {
        id: 'total sales'
        title: 'Total Sales'
        property: 'amount'
        color: 'purple'
        backgroundColor: '#6f42c1'
        icon: 'bag'
      }, {
        id: 'periodUpsells'
        title: 'Upsells'
        property: 'periodUpsells'
        color: 'info'
        backgroundColor: '#30a2b7'
        # TODO - find an icon
        icon: 'ribbon-a'
      }, {
        id: 'profit'
        title: 'Profit'
        property: 'profit'
        color: 'success'
        backgroundColor: '#23BF08'
        icon: 'cash'
      }, {
        id: 'commission'
        title: 'Commissions'
        property: 'commission'
        color: 'warning'
        backgroundColor: '#F49917'
        icon: 'ribbon-a'
      }, {
        id: 'periodWeightedAvgSales'
        title: 'Weighted Average Sales'
        property: 'periodWeightedAvgSales'
        color: 'primary'
        backgroundColor: '#0c66c6'
        # TODO - find an icon
        icon: 'ribbon-a'
      }
    ]

    @categories.forEach (category) => @[category.id] = {}

    @populateListBy = =>
      @listPaid = @list.filter (metric) -> metric.paid
      @listByRep = _.groupBy _.orderBy(@listPaid, 'salesRep'), 'salesRep'
      @listByPeriod = _.groupBy _.orderBy(@listPaid, 'invoiceDateObj'), 'invoicePeriod'

      for period, transactionList of @listByPeriod
        @listByPeriodAndRep[period] = _.groupBy transactionList, 'salesRep'

    @getByRep = (name) => @listByRep[name] or []
    @getByPeriod = (period) => @listByPeriod[period] or []

    @populate = (collections) =>
      @reps = Object.keys @listByRep
      @periods = Object.keys @listByPeriod

      @periods.map (period, pos) =>
        stats = @listByPeriod[period]
        prevPeriod = if pos then @periods[pos - 1] else @periods[pos]

        @categories.forEach (category) =>
          if category.property not in ['periodWeightedAvgSales', 'periodUpsells']
            final = _.sumBy stats, category.property
          else if stats
            final = stats[0]?.periodUpsells
          else
            final = 0

          if pos and prevPeriod in @periods
            initial = @[category.id][prevPeriod].all.value
          else if pos
            initial = 0
          else
            initial = final

          @[category.id][period] = all: getStatDetails final, initial

        statsByRep = _.groupBy stats, 'salesRep'

        Object.entries(statsByRep).map ([rep, repStats]) =>
          @categories.forEach (category) =>
            if category.property not in ['periodWeightedAvgSales', 'periodUpsells']
              final = _.sumBy repStats, category.property
            else if repStats
              final = repStats[0]?.periodUpsells
            else
              final = 0

            if pos and prevPeriod in @periods
              initial = @[category.id][prevPeriod][rep]?.value or 0
            else if pos
              initial = 0
            else
              initial = final

            @[category.id][period][rep] = getStatDetails final, initial

        @categories.forEach (category) =>
          periodDetails = @[category.id][period]
          detailEntries = Object.entries(periodDetails)
          detailEntries.forEach ([rep, repDetails]) ->
            repDetails.name = rep
            repDetails

          filtered = detailEntries
            .filter ([rep, repDetails]) -> rep isnt 'all'
            .map ([rep, repDetails]) -> repDetails

          unless @leaders[category.id]
            @leaders[category.id] = {}

          @leaders[category.id][period] = _.orderBy filtered, 'value', 'desc'
