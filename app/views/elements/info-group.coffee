m = require 'mithril'

module.exports =
  view: (vnode) ->
    attrs = vnode.attrs

    if attrs.vertical
      margin = if attrs.pos then 'mg-t-20 pd-t-20 bd-t' else ''
    else
      margin = if attrs.pos then 'bd-sm-l pd-sm-l-20 mg-sm-l-20 mg-t-20 mg-sm-t-0' else ''

    m "div.#{margin}", [
      m 'p.mg-b-5 tx-uppercase tx-10 tx-mont tx-semibold', attrs.title
      m 'h4.tx-lato tx-inverse tx-bold mg-b-0', attrs.value
      m "span.tx-12 tx-#{attrs.color} tx-roboto", attrs.description
    ]
