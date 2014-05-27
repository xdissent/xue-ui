
Template.menu.helpers
  stateCount: (state) -> Xue.Jobs.find(state: state).count()
  activeLink: (state) ->
    if XueUISession.equals 'state', state then 'active' else ''

Template.menu.events
  'click li a': (evt) ->
    state = jQuery(evt.currentTarget).attr('href').replace '#', ''
    XueUISession.set 'state', state
    evt.preventDefault()
 