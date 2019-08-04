m = require 'mithril'

config = require 'config'
devconfig = require 'devconfig'
Controller = require "controllers/site-controller"
view = require 'views/site-view'
helpers = require 'lib/helpers'

module.exports =
  oninit: (vnode) ->
    helpers.log 'initializing app'
    vnode.state.ctrl = ctrl = new Controller vnode.attrs
    # ctrl.addErrorHandler()

    getPromises = (names) -> names.map (name) ->
      collection = ctrl[name]

      if collection?.fetch
        collection.fetch {limit: ctrl.limit}
      else
        helpers.log "No fetch method found for #{name}"
        Promise.resolve()

    fetched = Promise.all getPromises(['metrics'])
    fetched.then(ctrl.populateModels).then(m.redraw)

  oncreate: (vnode) ->
    helpers.log 'creating app'
    ctrl = vnode.state.ctrl
    ctrl.addListeners()

  onbeforeupdate: (vnode) ->
    console.log 'onbeforeupdate app'

  onupdate: (vnode) ->
    console.log 'onupdate app'
    ctrl = vnode.state.ctrl

    if ctrl.loaded()
      ctrl.initalizePlugins()

    ctrl.updateSiteMeta()

  view: view