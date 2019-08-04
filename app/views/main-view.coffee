m = require 'mithril'

module.exports = (vnode, attrs) ->
  ctrl = vnode.state.ctrl
  attrs = Object.assign attrs or {}, vnode.attrs

  [
    m('div', { 'class': 'br-pagetitle' }, [
      m('i', 'class': 'icon ion-ios-home-outline')
      m('div', [
        m('h4', 'Dashboard')
        m('p', { 'class': 'mg-b-0' }, 'Do bigger things with Bracket plus')
      ])
    ])
    m('div', { 'class': 'br-pagebody' }, [
      m('div', { 'class': 'row row-sm' }, [
        m('div', { 'class': 'col-sm-6 col-xl-3' },
          m('div', { 'class': 'bg-info rounded overflow-hidden' }, [
            m('div', { 'class': 'pd-x-20 pd-t-20 d-flex align-items-center' }, [
              m('i', 'class': 'ion ion-earth tx-60 lh-0 tx-white op-7')
              m('div', { 'class': 'mg-l-20' }, [
                m('p', {
                  'class': 'tx-10 tx-spacing-1 tx-mont tx-semibold tx-uppercase tx-white-8 mg-b-10'
                  },
                  'Today\'s Visits'
                )
                m('p', { 'class': 'tx-24 tx-white tx-lato tx-bold mg-b-0 lh-1' }, '1,975,224')
                m('span', { 'class': 'tx-11 tx-roboto tx-white-8' }, '24% higher yesterday')
              ])
            ])
            m('#ch1.ht-50 tr-y-1')
        ]))
        m('div', { 'class': 'col-sm-6 col-xl-3 mg-t-20 mg-sm-t-0' },
          m('div', { 'class': 'bg-purple rounded overflow-hidden' }, [
            m('div', { 'class': 'pd-x-20 pd-t-20 d-flex align-items-center' }, [
              m('i', 'class': 'ion ion-bag tx-60 lh-0 tx-white op-7')
              m('div', { 'class': 'mg-l-20' }, [
                m('p', { 'class': 'tx-10 tx-spacing-1 tx-mont tx-semibold tx-uppercase tx-white-8 mg-b-10' },
                  'Today Sales'
                )
                m('p', { 'class': 'tx-24 tx-white tx-lato tx-bold mg-b-0 lh-1' },
                  '$329,291')
                m('span', { 'class': 'tx-11 tx-roboto tx-white-8' },
                  '$390,212 before tax')
              ])
            ])
            m('#ch3.ht-50 tr-y-1')
        ]))
        m('div', { 'class': 'col-sm-6 col-xl-3 mg-t-20 mg-xl-t-0' },
          m('div', { 'class': 'bg-teal rounded overflow-hidden' }, [
            m('div', { 'class': 'pd-x-20 pd-t-20 d-flex align-items-center' }, [
              m('i', 'class': 'ion ion-monitor tx-60 lh-0 tx-white op-7')
              m('div', { 'class': 'mg-l-20' }, [
                m('p', { 'class': 'tx-10 tx-spacing-1 tx-mont tx-semibold tx-uppercase tx-white-8 mg-b-10' },
                  '% Unique Visits'
                )
                m('p', { 'class': 'tx-24 tx-white tx-lato tx-bold mg-b-0 lh-1' },
                  '54.45%'
                )
                m('span', { 'class': 'tx-11 tx-roboto tx-white-8' },
                  '23% average duration')
              ])
            ])
            m('#ch2.ht-50 tr-y-1')
        ]))
        m('div', { 'class': 'col-sm-6 col-xl-3 mg-t-20 mg-xl-t-0' },
          m('div', { 'class': 'bg-primary rounded overflow-hidden' }, [
            m('div', { 'class': 'pd-x-20 pd-t-20 d-flex align-items-center' }, [
              m('i', 'class': 'ion ion-clock tx-60 lh-0 tx-white op-7')
              m('div', { 'class': 'mg-l-20' }, [
                m('p', { 'class': 'tx-10 tx-spacing-1 tx-mont tx-semibold tx-uppercase tx-white-8 mg-b-10' },
                  'Bounce Rate'
                )
                m('p', { 'class': 'tx-24 tx-white tx-lato tx-bold mg-b-0 lh-1' },
                  '32.16%')
                m('span', { 'class': 'tx-11 tx-roboto tx-white-8' },
                  '65.45% on average time')
              ])
            ])
            m('#ch4.ht-50 tr-y-1')
        ]))
      ])
      m('div', { 'class': 'row row-sm mg-t-20' }, [
        m('div', { 'class': 'col-lg-8' }, [
          m('div', { 'class': 'card bd-0 shadow-base' }, [
            m('div', { 'class': 'd-md-flex justify-content-between pd-25' }, [
              m('div', [
                m('h6', { 'class': 'tx-13 tx-uppercase tx-inverse tx-semibold tx-spacing-1' },
                  'How Engaged Our Users Daily')
                m('p', 'Past 30 Days — Last Updated Oct 14, 2017')
              ])
              m('div', { 'class': 'd-sm-flex' }, [
                m('div', [
                  m('p', { 'class': 'mg-b-5 tx-uppercase tx-10 tx-mont tx-semibold' },
                    'Bounce Rate')
                  m('h4', { 'class': 'tx-lato tx-inverse tx-bold mg-b-0' },
                    '23.32%')
                  m('span', { 'class': 'tx-12 tx-success tx-roboto' },
                    '2.7% increased')
                ])
                m('div', { 'class': 'bd-sm-l pd-sm-l-20 mg-sm-l-20 mg-t-20 mg-sm-t-0' }, [
                  m('p', { 'class': 'mg-b-5 tx-uppercase tx-10 tx-mont tx-semibold' },
                    'Page Views')
                  m('h4', { 'class': 'tx-lato tx-inverse tx-bold mg-b-0' },
                    '38.20%')
                  m('span', { 'class': 'tx-12 tx-danger tx-roboto' },
                    '4.65% decreased')
                ])
                m('div', { 'class': 'bd-sm-l pd-sm-l-20 mg-sm-l-20 mg-t-20 mg-sm-t-0' }, [
                  m('p', { 'class': 'mg-b-5 tx-uppercase tx-10 tx-mont tx-semibold' },
                    'Time On Site')
                  m('h4', { 'class': 'tx-lato tx-inverse tx-bold mg-b-0' },
                    '12:30')
                  m('span', { 'class': 'tx-12 tx-success tx-roboto' },
                    '1.22% increased')
                ])
              ])
            ])
            m('div', { 'class': 'pd-l-25 pd-r-15 pd-b-25' },
              m('#ch5.ht-250 ht-sm-300'))
          ])
          m('div', { 'class': 'card bd-0 shadow-base pd-25 mg-t-20' }, [
            m('div', { 'class': 'd-md-flex justify-content-between' }, [
              m('div', [
                m('h6', { 'class': 'tx-13 tx-uppercase tx-inverse tx-semibold tx-spacing-1' },
                  'How Engaged Our Users Daily')
                m('p', 'Past 30 Days — Last Updated Oct 14, 2017')
              ])
              m('div', { 'class': 'wd-200' }, m('select', {
                'class': 'form-control select2'
                'data-placeholder': 'Choose location'
              }, [
                m('option', 'label': 'Choose one')
                m('option', {
                  'value': '1'
                  'selected': 'selected'
                }, 'New York')
                m('option', { 'value': '2' }, 'San Francisco')
                m('option', { 'value': '3' }, 'Los Angeles')
                m('option', { 'value': '4' }, 'Chicago')
                m('option', { 'value': '5' }, 'Seattle')
              ]))
            ])
            m('div', { 'class': 'row mg-t-20' }, [
              m('div', { 'class': 'col-sm-9' }, m('div',
                'class': 'ht-250 ht-sm-300'
                'id': 'ch12'))
              m('div', { 'class': 'col-sm-3 mg-t-40 mg-sm-t-0' }, [
                m('div', [
                  m('p', { 'class': 'mg-b-5 tx-uppercase tx-10 tx-mont tx-semibold' },
                    'Bounce Rate')
                  m('h4', { 'class': 'tx-lato tx-inverse tx-bold mg-b-0' },
                    '23.32%')
                  m('span', { 'class': 'tx-12 tx-success tx-roboto' },
                    '2.7% increased')
                ])
                m('div', { 'class': 'mg-t-20 pd-t-20 bd-t' }, [
                  m('p', { 'class': 'mg-b-5 tx-uppercase tx-10 tx-mont tx-semibold' },
                    'Page Views')
                  m('h4', { 'class': 'tx-lato tx-inverse tx-bold mg-b-0' },
                    '38.20%')
                  m('span', { 'class': 'tx-12 tx-danger tx-roboto' },
                    '4.65% decreased')
                ])
                m('div', { 'class': 'mg-t-20 pd-t-20 bd-t' }, [
                  m('p', { 'class': 'mg-b-5 tx-uppercase tx-10 tx-mont tx-semibold' },
                    'Time On Site')
                  m('h4', { 'class': 'tx-lato tx-inverse tx-bold mg-b-0' },
                    '12:30')
                  m('span', { 'class': 'tx-12 tx-success tx-roboto' },
                    '1.22% increased')
                ])
              ])
            ])
          ])
        ])
        m('div', { 'class': 'col-lg-4 mg-t-20 mg-lg-t-0' }, [
          m('div', { 'class': 'card shadow-base bd-0 overflow-hidden' }, [
            m('div', { 'class': 'pd-x-25 pd-t-25' }, [
              m('h6', { 'class': 'tx-13 tx-uppercase tx-inverse tx-semibold tx-spacing-1 mg-b-20' }, 'Storage Overview')
              m('p', { 'class': 'tx-10 tx-spacing-1 tx-mont tx-semibold tx-uppercase mg-b-0' }, 'As of Today')
              m('h1', { 'class': 'tx-56 tx-light tx-inverse mg-b-0' }, [
                '755'
                m('span', { 'class': 'tx-teal tx-24' }, 'gb')
              ])
              m('p', [
                m('span', { 'class': 'tx-primary' }, '80%')
                'of free space remaining'
              ])
            ])
            m('#ch6.ht-115 mg-r--1')
            m('div', { 'class': 'bg-teal pd-x-25 pd-b-25 d-flex justify-content-between' }, [
              m('div', { 'class': 'tx-center' }, [
                m('h3', { 'class': 'tx-lato tx-white mg-b-5' }, [
                  '989'
                  m('span', { 'class': 'tx-light op-8 tx-20' }, 'gb')
                ])
                m('p', { 'class': 'tx-10 tx-spacing-1 tx-mont tx-medium tx-uppercase mg-b-0 tx-white-8' }, 'Total Space')
              ])
              m('div', { 'class': 'tx-center' }, [
                m('h3', { 'class': 'tx-lato tx-white mg-b-5' }, [
                  '234'
                  m('span', { 'class': 'tx-light op-8 tx-20' }, 'gb')
                ])
                m('p', { 'class': 'tx-10 tx-spacing-1 tx-mont tx-medium tx-uppercase mg-b-0 tx-white-8' }, 'Used Space')
              ])
              m('div', { 'class': 'tx-center' }, [
                m('h3', { 'class': 'tx-lato tx-white mg-b-5' }, [
                  '80'
                  m('span', { 'class': 'tx-light op-8 tx-20' }, '%')
                ])
                m('p', { 'class': 'tx-10 tx-spacing-1 tx-mont tx-medium tx-uppercase mg-b-0 tx-white-8' }, 'Free Space')
              ])
            ])
          ])
          m('div', { 'class': 'card shadow-base bd-0 mg-t-20' },
            m('div', { 'class': 'bg-white ht-300 pos-relative overflow-hidden d-flex flex-column align-items-start rounded' }, [
              m('div', { 'class': 'pd-x-30 pd-t-30 mg-b-auto' }, [
                m('p', { 'class': 'tx-info tx-uppercase tx-11 tx-semibold tx-mont mg-b-5' }, 'Product Item #1')
                m('h5', { 'class': 'tx-inverse mg-b-20' }, 'Samsung Galaxy S8')
                m('p', { 'class': 'tx-uppercase tx-11 tx-semibold tx-mont mg-b-0' }, 'Purchases')
                m('h2', { 'class': 'tx-inverse tx-lato tx-bold mg-b-0' }, '2366')
                m('span', '53.86 purchases/month')
              ])
              m('div',
                'class': 'ht-100 tr-y-1'
                'id': 'ch10')
            ])
          )
          m('div', { 'class': 'card card-body bd-0 pd-25 bg-primary mg-t-20' }, [
            m('div', { 'class': 'd-xs-flex justify-content-between align-items-center tx-white mg-b-20' }, [
              m('h6', { 'class': 'tx-13 tx-uppercase tx-semibold tx-spacing-1 mg-b-0' }, 'Server Status')
              m('span', { 'class': 'tx-12 tx-uppercase' }, 'Oct 2017')
            ])
            m('p', { 'class': 'tx-sm tx-white tx-medium mg-b-0' }, 'Hardware Monitoring')
            m('p', { 'class': 'tx-12 tx-white-7' }, 'Intel Dothraki G125H 2.5GHz')
            m('div', { 'class': 'progress bg-white-3 rounded-0 mg-b-0' }, m('div', {
              'class': 'progress-bar bg-success wd-50p lh-3'
              'role': 'progressbar'
              'aria-valuenow': '50'
              'aria-valuemin': '0'
              'aria-valuemax': '100'
            }, '50%'))
            m('p', { 'class': 'tx-11 mg-b-0 mg-t-15 tx-white-7' }, 'Notice: Lorem ipsum dolor sit amet.')
          ])
          m('div', { 'class': 'card bd-0 mg-t-20' },
            m('div', { 'class': 'pos-absolute t-20 r-20' }, [
              m('a', {
                'class': 'tx-white-5 hover-info'
                'href': ''
              }, m('i', 'class': 'icon ion-edit tx-16'))
              m('a', {
                'class': 'tx-white-5 hover-info mg-l-7'
                'href': ''
              }, m('i', 'class': 'icon ion-stats-bars tx-20'))
              m('a', {
                'class': 'tx-white-5 hover-info mg-l-7'
                'href': ''
              }, m('i', 'class': 'icon ion-gear-a tx-20'))
            ])
          )
          m('div', { 'class': 'card bg-danger bd-0 mg-t-20' }, m('div', { 'class': 'pd-x-25 pd-t-25' }, [
            m('h6', { 'class': 'tx-13 tx-uppercase tx-white tx-medium tx-spacing-1 mg-b-10' }, 'Monthly Statistics')
            m('p', { 'class': 'mg-b-20 tx-white-6' }, 'Past 30 Days — Last Updated Oct 14, 2017')
            m('div', { 'class': 'row row-sm mg-t-20' }, [
              m('div', { 'class': 'col' }, [
                m('p', { 'class': 'mg-b-5 tx-uppercase tx-10 tx-mont tx-semibold tx-white-6' },
                  'Bounce Rate')
                m('h4', { 'class': 'tx-lato tx-white tx-bold tx-normal mg-b-0' },
                  '23.32%')
                m('span', { 'class': 'tx-12 tx-white-6 tx-roboto' },
                  '2.7% increased')
              ])
              m('div', { 'class': 'col' }, [
                m('p', {
                  'class': 'mg-b-5 tx-uppercase tx-10 tx-mont tx-semibold tx-white-6'
                  },
                  'Page Views')
                m('h4', { 'class': 'tx-lato tx-white tx-normal mg-b-0' },
                  '42.58%')
                m('span', { 'class': 'tx-12 tx-white-6 tx-roboto' },
                  '1.5% decreased')
              ])
            ])
            m('#ch13.ht-160')
          ]))
        ])
      ])
    ])
    m('footer', { 'class': 'br-footer' }, [
      m('div', { 'class': 'footer-left' }, [
        m('div', { 'class': 'mg-b-2' }, [
          'Copyright '
          m.trust('&copy;')
          ' 2017. Bracket Plus. All Rights Reserved.'
        ])
        m('div', 'Attentively and carefully made by ThemePixels.')
      ])
      m('div', { 'class': 'footer-right d-flex align-items-center' }, [])
    ])
  ]
