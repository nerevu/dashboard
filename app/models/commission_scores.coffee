Collection = require './base/collection'
CommissionScore = require './commission_score'

module.exports = class CommissionScores extends Collection
  constructor: ->
    super CommissionScore, 'realtime_data', 'commission_score'

    @populateListBy = =>
      @listByRep = _.groupBy _.orderBy(@list, 'sales_rep'), 'sales_rep'

    @populate = (collections) =>
      @reps = Object.keys(@listByRep)
