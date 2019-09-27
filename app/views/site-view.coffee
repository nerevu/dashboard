m = require 'mithril'
config = require 'config'
helpers = require 'lib/helpers'
main = require './main-view'


module.exports = (vnode, attrs) ->
  ctrl = vnode.state.ctrl
  attrs = Object.assign attrs or {}, vnode.attrs
  main vnode
