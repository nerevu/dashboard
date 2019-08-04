config = require 'config'
devconfig = require 'devconfig'
helpers = require 'lib/helpers'

localFile = devconfig.storage.local

module.exports = class Collection
  constructor: (model, collectionName, options) ->
    @error = ''
    @list = null
    @listById = {}
    @model = model
    @name = collectionName
    @resourceName = options?.resourceName or @name

  fetch: (options) =>
    helpers.log "fetching #{@name}..."
    limit = if options?.limit? then options?.limit else 0

    if localFile
      models = require "../../dev_data/#{@name}"
      promise = Promise.resolve if limit then models[...limit] else models
    else
      m = require 'mithril'

      promise = m.request(
        url: "#{devconfig.urls.api}/#{@resourceName}"
        data: {page: 0, size: limit, sort: 'id'}
      ).catch (e) =>
        console.error e.details or e
        @error = "Error fetching #{@name}!"
        []

    promise.then (resp) =>
      if not resp?.length
        resp = [{}]

      @list = resp.map (model) => new @model model
      @listById = _.groupBy @list, 'id'
      helpers.log "loaded #{@resourceName}"

  get: (id) => @listById[id]?[0]
  populate: null
