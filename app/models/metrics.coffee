Collection = require './base/collection'
Metric = require './metric'

module.exports = class Metrics extends Collection
  constructor: ->
    super Metric, 'metrics'
