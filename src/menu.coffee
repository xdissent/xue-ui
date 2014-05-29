
Meteor.subscribe 'xue-ui-job-counts'

Template.menu.helpers
  totalCount: -> XueUI.JobCounts.findOne('total')?.count ? 0

  stateCount: (state) -> XueUI.JobCounts.findOne(state)?.count ? 0

  activeLink: (state) ->
    if XueUI.Session.equals 'state', state then 'active' else ''

Template.menu.events
  'click li a': (evt) ->
    state = jQuery(evt.currentTarget).attr('href').replace '#', ''
    XueUI.Session.set 'state', state
    evt.preventDefault()
 