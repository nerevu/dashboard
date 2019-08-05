m = require 'mithril'
InfoGroup = require '../elements/info-group'

axisOpts =
  stacked: false
  ticks:
    beginAtZero: true
    fontSize: 10

chartOpts =
  type: 'horizontalBar'
  options:
    legend:
      display: true
      labels: display: true

    scales:
      yAxes: [axisOpts]
      xAxes: [axisOpts]

module.exports =
  oncreate: (vnode) ->
    attrs = vnode.attrs
    ctx = document.getElementById(attrs.id).getContext('2d')
    new Chart ctx, Object.assign({data: attrs.chartData}, chartOpts)

  view: (vnode) ->
    attrs = vnode.attrs
    margin = if attrs.pos then 'mg-t-20' else ''

    m ".card bd-0 shadow-base pd-25 mg-t-20 #{margin}", [
      m '.d-md-flex justify-content-between', [
        m 'div', [
          m 'h6.tx-13 tx-uppercase tx-inverse tx-semibold tx-spacing-1', attrs.title
          m 'p', attrs.description
        ]
      ]

      m '.row mg-t-20', [
        m '.col-sm-9',
          m "canvas##{attrs.id}.ht-120 ht-sm-120", {height: '180'}

        if attrs.infoGroup
          m '.col-sm-3 mg-t-40 mg-sm-t-0', [
            m 'p.lead', attrs.infoGroup.title

            attrs.infoGroup.data.map (data, pos) ->
              m InfoGroup, Object.assign({vertical: true, pos}, data)
          ]
      ]
    ]
