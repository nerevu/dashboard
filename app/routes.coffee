m = require 'mithril'

module.exports = (app) ->
  '/': render: (vnode) -> m app, vnode.attrs
