m = require 'mithril'

module.exports =
  view: (vnode) ->
    attrs = vnode.attrs
    margin = if attrs.pos then 'mg-t-20 pd-t-20 bd-t' else ''

    m "div.#{margin}", [
      m 'p.mg-b-5 tx-uppercase tx-10 tx-mont tx-semibold', attrs.title
      m 'h4.tx-lato tx-inverse tx-bold mg-b-0', attrs.value
      m 'span.tx-12 tx-danger tx-roboto', attrs.description
    ]

    m 'div', [
      m 'p.mg-b-5 tx-uppercase tx-10 tx-mont tx-semibold', attrs.title
      m 'h4.tx-lato tx-inverse tx-bold mg-b-0', attrs.value
      m 'span.tx-12 tx-success tx-roboto', attrs.description
    ]
    m '.mg-t-20 pd-t-20 bd-t', [
      m 'p.mg-b-5 tx-uppercase tx-10 tx-mont tx-semibold', attrs.title
      m 'h4.tx-lato tx-inverse tx-bold mg-b-0', attrs.value
      m 'span.tx-12 tx-danger tx-roboto', attrs.description
    ]
    m '.mg-t-20 pd-t-20 bd-t', [
      m 'p.mg-b-5 tx-uppercase tx-10 tx-mont tx-semibold', attrs.title
      m 'h4.tx-lato tx-inverse tx-bold mg-b-0', attrs.value
      m 'span.tx-12 tx-success tx-roboto', attrs.description
    ]
