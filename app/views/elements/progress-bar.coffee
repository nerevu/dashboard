m = require 'mithril'

module.exports =
  view: (vnode) ->
    attrs = vnode.attrs
    margin = if attrs.pos then 'mg-t-5' else ''

    m ".row align-items-center #{margin}", [
      m '.col-5 tx-12', attrs.title
      m '.col-7', m '.progress rounded-0 mg-b-0',
        m ".progress-bar bg-#{attrs.color} wd-#{attrs.value}p lh-3", {
          'role': 'progressbar'
          'aria-valuenow': attrs.value
          'aria-valuemin': '0'
          'aria-valuemax': '100'
      }, attrs.description
    ]
