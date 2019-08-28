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
    size = if attrs.infoGroup then 9 else 12

    m '.card bd-0 shadow-base pd-25 mg-t-20', [
      m '.d-md-flex justify-content-between', [
        m 'div', [
          m 'h6.tx-13 tx-uppercase tx-inverse tx-semibold tx-spacing-1', attrs.title
          m 'p', attrs.description
        ]
      ]

      m '.row mg-t-20', [
        m ".col-md-#{size}",
          m "canvas##{attrs.id}", {height: attrs.height or '400'}

        if attrs.infoGroup
          m '.col-md-3 mg-t-40 mg-sm-t-20', [
            m 'p.lead', attrs.infoGroup.title

            attrs.infoGroup.data.map (data, pos) ->
              m InfoGroup, Object.assign({vertical: true, pos}, data)
          ]
      ]
    ]
