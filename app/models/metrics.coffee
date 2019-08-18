Collection = require './base/collection'
Metric = require './metric'

getStatDetails = (final, initial) ->
  change = final - initial
  absChange = Math.abs change
  perChange = absChange / initial
  options = {style: 'currency', currency: 'USD'}

  {
    value: final
    valueText: final.toLocaleString('us-US', options)
    difference:
      value: absChange
      valueText: absChange.toLocaleString('us-US', options)
      percent: perChange
      percentText: perChange.toLocaleString('us-US', {style: 'percent'})
      color: if change > 0 then 'success' else 'error'
      direction: if change > 0 then 'higher' else 'lower'
  }

# https://stackoverflow.com/a/563442/408556
subtractDays = (days) ->
  newDate = new Date()
  newDate.setDate(newDate.getDate() - days)
  newDate

formatDate = (date) ->
  monthNum = date.getMonth() + 1

  if monthNum < 10
    monthNum = "0#{monthNum}"

  "#{monthNum}-#{date.getFullYear()}"

DAYSRANGE = _.range 0, 28 * 13, 28

module.exports = class Metrics extends Collection
  constructor: ->
    super Metric, 'realtime_data?reportType=dashboard'
    @listByRep = null
    @listByPeriod = null

    # Create a range of dates representing each month for the past 12 months
    @periods = _.uniq DAYSRANGE.map(subtractDays).map(formatDate)
    @periods.reverse()
    @leaders = {}

    @categories = [
      {
        id: 'sales'
        title: 'Sales'
        property: 'amount'
        color: 'purple'
        backgroundColor: '#6f42c1'
        icon: 'bag'
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
      }
    ]

    @categories.forEach (category) => @[category.id] = {}

    @visible =
      xs: ['invoice_number', 'amount']
      sm: ['invoice_number', 'amount', 'commission', 'sales_rep']
      md: ['invoice_number', 'amount', 'commission', 'invoice_date', 'sales_rep']
      lg: [
        'invoice_number', 'contract_number', 'po_numbers', 'amount', 'commission',
        'invoice_date', 'sales_rep'
      ]
      xl: [
        'invoice_number', 'contract_number', 'po_numbers', 'amount', 'commission',
        'invoice_date', 'invoice_period', 'sales_rep', 'errors'
      ]

    @populateListBy = =>
      @listPaid = @list.filter (metric) -> metric.paid
      @listByRep = _.groupBy _.orderBy(@listPaid, 'sales_rep'), 'sales_rep'
      @listByPeriod = _.groupBy _.orderBy(@listPaid, 'invoice_date'), 'invoice_period'

    @getByRep = (name) => @listByRep[name] or []
    @getByPeriod = (period) => @listByPeriod[period] or []

    @populate = (collections) =>
      @reps = Object.keys @listByRep
      @availPeriods = Object.keys @listByPeriod

      @periods.map (period, pos) =>
        stats = @listByPeriod[period]
        prevPeriod = if pos then @periods[pos - 1] else @periods[pos]

        @categories.forEach (category) =>
          final = _.sumBy stats, category.property

          if pos and prevPeriod in @availPeriods
            initial = @[category.id][prevPeriod].all.value
          else if pos
            initial = 0
          else
            initial = final

          @[category.id][period] = all: getStatDetails final, initial

        statsByRep = _.groupBy stats, 'sales_rep'

        Object.entries(statsByRep).map ([rep, repStats]) =>
          @categories.forEach (category) =>
            final = _.sumBy repStats, category.property

            if pos and prevPeriod in @availPeriods
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
