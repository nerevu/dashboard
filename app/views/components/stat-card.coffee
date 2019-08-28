m = require 'mithril'
ProgressBar = require '../elements/progress-bar'

module.exports =
  view: (vnode) ->
    attrs = vnode.attrs

    if attrs.color
      headerColor = attrs.color
      fontClass = 'tx-white'
    else
      headerColor = 'transparent'
      fontClass = ''


    m '.card stat-card shadow-base bd-0', [
      m ".card-header bg-#{headerColor} d-flex justify-content-between align-items-center", [
        m "h6.card-title tx-uppercase tx-12 mg-b-0 #{fontClass}", attrs.title
        m "span.tx-12 tx-uppercase #{fontClass}", attrs.period
      ]

      m '.card-body', [
        if attrs.subTitle
          m 'p.tx-sm tx-inverse tx-medium mg-b-0', attrs.subTitle

        if attrs.description
          m 'p.tx-12', attrs.description

        attrs.progressBarData.map (data, pos) ->
          m ProgressBar, Object.assign({pos}, data)

        if attrs.info
          m 'p.tx-11 mg-b-0 mg-t-15', attrs.info
      ]
    ]
