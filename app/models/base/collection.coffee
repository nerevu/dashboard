config = require 'config'
devconfig = require 'devconfig'
helpers = require 'lib/helpers'

localFile = devconfig.storage.local
# TODO: fix the way the localFile works
localFile = null

module.exports = class Collection
  constructor: (model, collectionName, reportType, options) ->
    @error = ''
    @list = null
    @listById = {}
    @model = model
    @name = collectionName
    @resourceName = options?.resourceName or @name
    @populated = false
    @reportType = reportType or 'dashboard'

  fetch: (options) =>
    helpers.log "fetching #{@name}..."
    limit = if options?.limit? then options?.limit else 0

    if localFile and @reportType isnt 'sales'
      models = require "../../dev_data/#{@name}"
      promise = Promise.resolve if limit then models[...limit] else models
    else

      m = require 'mithril'

      promise = m.request
        url: "#{devconfig.urls.api}/#{@resourceName}"
        data: {reportType: @reportType}

    callback = (resp) =>
      result = resp.result

      if not result?.length
        throw new Error resp.message or "Received empty result!"

      @list = result.map (model, pos) => new @model model, pos
      @listById = _.groupBy @list, 'id'
      helpers.log "loaded #{@resourceName}"

    errback = (e) =>
      @error = "Error fetching #{@name}!"
      error = e.details or e

      if error
        @error += " #{error}"

      console.error @error

    promise.then(callback).catch(errback)

  get: (id) => @listById[id]?[0]
  populate: null
