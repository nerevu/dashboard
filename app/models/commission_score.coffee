module.exports = class CommissionScore
  constructor: (score, id) ->
    @id = score.id or id
    @salesRep = score['Sales Rep']
    @score = score['Commission Score']
