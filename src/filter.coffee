
Meteor.subscribe 'xue-ui-job-types'

Template.filter.helpers
  types: -> XueUI.JobTypes.find {}

Template.filter.events
  'change select': (evt) ->
    val = $(evt.currentTarget).val()
    filter = if val is 'filter by' then null else val
    return if XueUI.Session.equals 'filter', filter
    XueUI.Session.set 'filter', filter
    XueUI.Session.set 'limit', 10
