module.exports = class CommissionScore
  constructor: (score, id) ->
    @id = score.id or id
    @sales_rep = score['Sales Rep']
    @score = score['Commission Score']
