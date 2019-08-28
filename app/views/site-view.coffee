m = require 'mithril'
config = require 'config'
helpers = require 'lib/helpers'
admin = require './admin-view'
salesrep = require './salesrep-view'

module.exports = (vnode, attrs) ->
  ctrl = vnode.state.ctrl
  attrs = Object.assign attrs or {}, vnode.attrs
  if ctrl.page() is 'admin' then admin vnode else salesrep vnode
