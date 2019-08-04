module.exports = class Metric
  constructor: (metric) ->
    @id = metric.id
    @background = metric.background
    @image = metric.image
    @title = metric.title
    @description = metric.description
    @price = metric.price
    @category = metric.category
