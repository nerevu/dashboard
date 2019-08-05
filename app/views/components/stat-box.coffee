m = require 'mithril'

chartOpts =
  renderer: 'bar'
  stack: true

module.exports =
  oncreate: (vnode) ->
    attrs = vnode.attrs
    element = document.getElementById attrs.id
    opts = {element, series: [{data: attrs.chartData, color: 'rgba(255,255,255,0.5)'}]}
    graph = new Rickshaw.Graph Object.assign(opts, chartOpts)
    graph.render()

  view: (vnode) ->
    attrs = vnode.attrs

    m ".bg-#{attrs.color} rounded overflow-hidden", [
      m '.pd-x-20 pd-t-20 d-flex align-items-center', [
        m "i.ion ion-#{attrs.icon} tx-60 lh-0 tx-white op-7"
        m '.mg-l-20', [
          m 'p.tx-10 tx-spacing-1 tx-mont tx-semibold tx-uppercase tx-white-8 mg-b-10',
            attrs.title

          m 'p.tx-24 tx-white tx-lato tx-bold mg-b-0 lh-1', attrs.value
          m 'span.tx-11 tx-roboto tx-white-8', attrs.description
        ]
      ]

      m "##{attrs.id}.ht-50 tr-y-1"
    ]
