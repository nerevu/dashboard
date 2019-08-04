m = require 'mithril'
stream = require 'mithril/stream'

config = require 'config'
devconfig = require 'devconfig'
helpers = require 'lib/helpers'
Metrics = require 'models/metrics'

site = config.site
$ = jQuery

module.exports = class Controller
  constructor: (attrs) ->
    @loaded = stream false
    @ready = stream false

    @metrics = new Metrics()
    @collections = metrics: @metrics

    @head = document.getElementsByTagName('head')[0]
    @body = document.getElementsByTagName('body')[0]

  populateModels: =>
    Object.keys(@collections).forEach (name) =>
      collection = @collections[name]

      if collection.list and collection.populate
        collection.populate @collections

  # <!-- Twitter -->
  # <meta name="twitter:site" content="@themepixels">
  # <meta name="twitter:creator" content="@themepixels">
  # <meta name="twitter:card" content="summary_large_image">
  # <meta name="twitter:title" content="Bracket Plus">
  # <meta name="twitter:description" content="Premium Quality and Responsive">
  # <meta name="twitter:image" content="http://g/bracketplus-social.png">

  # <!-- Facebook -->
  # <meta property="og:url" content="http://themepixels.me/bracketplus">
  # <meta property="og:title" content="Bracket Plus">
  # <meta property="og:description" content="Premium Quality and Responsive.">

  # <meta property="og:image" content="http://themepixels.me/-social.png">
  # <meta property="og:image:secure_url" content="http://themepixe-social.png">
  # <meta property="og:image:type" content="image/png">
  # <meta property="og:image:width" content="1200">
  # <meta property="og:image:height" content="600">

  # <!-- Meta -->
  # <meta name="description" content="Alegna Commission Dashboard">
  # <meta name="author" content="Nerevu Development">

  initSiteMeta: =>
    document.title = site.title
    keyType = 'property'

    # SEO
    helpers.addMeta @head, 'author', config.author
    helpers.addMeta @head, 'description', site.description

    if site.keywords
      helpers.addMeta @head, 'keywords', site.keywords

    # FB Open Graph
    helpers.addMeta @head, 'og:title', site.title, keyType=keyType
    helpers.addMeta @head, 'og:siteName', site.title, keyType=keyType
    helpers.addMeta @head, 'og:description', site.description
    helpers.addMeta @head, 'og:url', site.url, keyType=keyType
    helpers.addMeta @head, 'og:type', site.type, keyType=keyType
    helpers.addMeta @head, 'og:image', site.image, keyType=keyType

    # Twitter
    helpers.addMeta @head, 'twitter:title', site.title, keyType=keyType
    helpers.addMeta @head, 'twitter:description', site.description

    if site.image
      helpers.addMeta(
        @head, 'twitter:card', 'summary_large_image', keyType=keyType)

      helpers.addMeta @head, 'twitter:image', site.image, keyType=keyType
    else
      helpers.addMeta @head, 'twitter:card', 'summary', keyType=keyType

    if site.appID
      helpers.addMeta @head, 'fb:appId', site.appID, keyType=keyType

  updateSiteMeta: ->
    document.title = site.title
    keyType = 'property'

    helpers.updateMeta 'description', site.description
    helpers.updateMeta 'og:title', site.title, keyType=keyType
    helpers.updateMeta 'og:siteName', site.title, keyType=keyType
    helpers.updateMeta 'og:description', site.description
    helpers.updateMeta 'twitter:title', site.title, keyType=keyType
    helpers.updateMeta 'twitter:description', site.description

    if site.image
      helpers.updateMeta(
        'twitter:card', 'summary_large_image', keyType=keyType)

      helpers.updateMeta 'twitter:image', site.image, keyType=keyType
    else
      helpers.updateMeta 'twitter:card', 'summary', keyType=keyType

  addErrorHandler: ->
    window.addEventListener 'error', (event) ->
      if event
        event.preventDefault()
        console.error event.error or event.message

      m.route.set "/500"

  initalizePlugins: ->
    helpers.initGraphs()
    helpers.initPlot()
    # helpers.initSparklines()
    helpers.initBarChart()

  addListeners: =>
    # See https://www.chromestatus.com/feature/5745543795965952
    $(document).ready =>
      @ready true
      helpers.log 'document ready'

    $(window).on 'load', =>
      @loaded true
      helpers.log 'window loaded'
      @initalizePlugins()
