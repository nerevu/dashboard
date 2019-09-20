m = require 'mithril'
stream = require 'mithril/stream'

config = require 'config'
devconfig = require 'devconfig'
helpers = require 'lib/helpers'
Metrics = require 'models/metrics'

site = config.site
author = config.author

module.exports = class Controller
  constructor: (attrs) ->
    @loaded = stream false
    @ready = stream false
    @page = stream attrs.page

    @metrics = new Metrics()
    @collections = metrics: @metrics

    @head = document.getElementsByTagName('head')[0]
    @body = document.getElementsByTagName('body')[0]

  update: (attrs) => @page attrs.page

  populate: =>
    Object.keys(@collections).forEach (name) =>
      collection = @collections[name]

      if collection.list
        collection.populateListBy?()

        if collection.populate
          collection.populate @collections
          collection.populated = true

  initSiteMeta: =>
    document.title = site.title
    keyType = 'property'

    # SEO
    helpers.addMeta @head, 'author', author.name
    helpers.addMeta @head, 'description', site.description

    if site.keywords
      helpers.addMeta @head, 'keywords', site.keywords

    # FB Open Graph
    helpers.addMeta @head, 'og:title', site.title, keyType=keyType
    helpers.addMeta @head, 'og:siteName', site.title, keyType=keyType
    helpers.addMeta @head, 'og:description', site.description

    if site.url
      helpers.addMeta @head, 'og:url', site.url, keyType=keyType

    helpers.addMeta @head, 'og:type', site.type, keyType=keyType

    if site.image
      helpers.addMeta @head, 'og:image', site.image, keyType=keyType
      helpers.addMeta @head, 'og:secure_url', site.image, keyType=keyType
      helpers.addMeta @head, 'og:image:secure_url', site.image, keyType=keyType
      helpers.addMeta @head, 'og:image:type', 'image/png', keyType=keyType
      helpers.addMeta @head, 'og:image:width', '1200', keyType=keyType
      helpers.addMeta @head, 'og:image:height', '600', keyType=keyType

    # Twitter
    helpers.addMeta @head, 'twitter:title', site.title, keyType=keyType
    helpers.addMeta @head, 'twitter:description', site.description
    helpers.addMeta @head, 'twitter:site', author.twitter
    helpers.addMeta @head, 'twitter:creator', author.twitter

    if site.image
      helpers.addMeta(
        @head, 'twitter:card', 'summary_large_image', keyType=keyType)

      helpers.addMeta @head, 'twitter:image', site.image, keyType=keyType
    else
      helpers.addMeta @head, 'twitter:card', 'summary', keyType=keyType

    if site.appID
      helpers.addMeta @head, 'fb:appId', site.appID, keyType=keyType

  addErrorHandler: ->
    window.addEventListener 'error', (event) ->
      if event
        event.preventDefault()
        console.error event.error or event.message
