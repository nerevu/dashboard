config = require 'config'
devconfig = require 'devconfig'
helpers = require 'lib/helpers'

localFile = devconfig.storage.local

module.exports = class Collection
  constructor: (model, collectionName, reportType, options) ->
    @error = ''
    @list = null
    @listById = {}
    @reportType = reportType or 'dashboard'
    @model = model
    @name = collectionName
    @resourceName = options?.resourceName or @name
    @populated = false

  fetch: (options) =>
    helpers.log "fetching #{@name}..."
    limit = if options?.limit? then options?.limit else 0

    if localFile
      models = require "../../dev_data/#{@name}-#{@reportType}"
      promise = Promise.resolve if limit then models[...limit] else models
    else
      m = require 'mithril'

      promise = m.request
        url: "#{devconfig.urls.api}/#{@resourceName}"
        data: reportType: @reportType

    callback = (resp) =>
      result = resp.result

      if not result?.length
        throw new Error resp.message or "Received empty result!"

      @list = result.map (model, pos) => new @model model, pos
      @listById = _.groupBy @list, 'id'
      helpers.log "loaded #{@resourceName}"

    errback = (e) =>
      if e?.status is "Unauthorized" or e?.message.includes 're-authenticate' or e?.includes 'authentication error'
        @error = "Re-Authenticating with QuickBooks..."
        callbackUrl = devconfig.urls.app
        authenticationUrl = "#{devconfig.urls.api}/auth?callback_url=#{callbackUrl}"
        window.open(authenticationUrl, "_self")
      else
        @error = "Error fetching #{@name}!"
        error = e.details or e

        if error
          @error += " #{error}"

        console.error @error

    promise.then(callback).catch(errback)

  get: (id) => @listById[id]?[0]
  populate: null
