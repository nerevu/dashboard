m = require 'mithril'
InfoGroup = require '../elements/info-group'

module.exports =
  view: (vnode) ->
    attrs = vnode.attrs

    m '.card bd-0 shadow-base pd-25 mg-t-20', [
      m 'div', [
        m 'h6.tx-13 tx-uppercase tx-inverse tx-semibold tx-spacing-1', attrs.title
        m 'p', attrs.description
      ]

      m '.d-md-flex justify-content-between', [
        m '.d-sm-flex', attrs.data.map (data, pos) ->
          m InfoGroup, Object.assign({pos}, data)
      ]
    ]
