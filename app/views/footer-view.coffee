m = require 'mithril'
config = require 'config'

module.exports = (vnode, attrs) ->
  ctrl = vnode.state.ctrl
  year = (new Date()).getFullYear()
  site = config.site

  m 'footer',
    m '.footer-part footer-action', [
      m '.icon-default icon-dark', m 'img', site.footer.logo
      m '.container', m '.footer-inset', m '.row', [
        m '.col-md-3 col-sm-6 col-xs-12', m '.equal-inset', [
          m 'h5', site.title
          m 'p', site.footer.description
        ]

        m '.col-md-3 col-sm-6 col-xs-12', m '.equal-inset', [
          m 'h5', 'Contact'
          m 'p', [
            site.address
            m 'a', {
              href: "tel:#{site.phone}"
              oncreate: m.route.link
              onupdate: m.route.link
            }, site.phone

            m 'a', {
              href: "mailto:#{site.email}"
              oncreate: m.route.link
              onupdate: m.route.link
            }, site.email
          ]
        ]
      ]

      m '.footer-inset-copyright',
        m '.container',
          m 'span', "Copyright © #{year} #{config.author}. All rights reserved."
    ]
