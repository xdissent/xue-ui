
Meteor.subscribe 'xue-ui-job-types'

Template.filter.helpers
  types: -> XueUI.JobTypes.find {}

Template.filter.events
  'change select': (evt) ->
    val = $(evt.currentTarget).val()
    XueUI.Session.set 'filter', if val is 'filter by' then null else val
