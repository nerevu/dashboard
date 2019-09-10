Collection = require './base/collection'
WeightedAvgSale = require './weighted-avg-sale'

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

# Does this create what we want it to?
DAYSRANGE = _.range 0, 28 * 13, 28

module.exports = class WeightedAvgSales extends Collection
  constructor: () ->
    super WeightedAvgSale, 'data', 'sales'
    @list = null
    @listByPeriodAndRep = {}

    # Create a range of dates representing each month for the past 12 months
    @periods = _.uniq DAYSRANGE.map(subtractDays).map(formatDate)
    @periods.reverse()
    @leaders = {}

    @categories = [{
      id: 'weighted_avg_sales'
      category: 'weighted_avg_sales'
      title: 'Weighted Average Sales'
      property: 'weighted_avg_sales'
      color: 'primary'
      backgroundColor: '#F49917'
      icon: 'ribbon-a'
    }]

    @categories.forEach (category) => @[category.id] = {}

    @populateListBy = =>
      @listByRep = _.groupBy _.orderBy(@list, 'sales_rep'), 'sales_rep'
      @reps = Object.keys @listByRep
      @listByPeriod = _.groupBy @list, 'invoice_period'
      for period, arr of @listByPeriod
        @listByPeriodAndRep[period] = _.groupBy arr, 'sales_rep'

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

