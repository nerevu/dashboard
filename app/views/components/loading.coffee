m = require 'mithril'

module.exports =
  view: (vnode) ->
    attrs = vnode.attrs

    m '#pre-loader',
      m '.loader-holder',
        m 'img', attrs
