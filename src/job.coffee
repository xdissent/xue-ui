
Deps.autorun ->
  id = XueUI.Session.get 'selected'
  Meteor.subscribe 'xue-ui-job-details', id if id?

Template.job.helpers

  title: -> @data?.title ? 'untitled'

  isState: (state) -> @state is state

  relativeDelay: -> moment(@created_at).add('ms', @delay).fromNow()

  showDetails: -> XueUI.Session.equals 'selected', @_id

  humanPriority: ->
    return n for n, p of Xue.priorities when p is @priority
    @priority

  relativeDateTime: (datetime) -> moment(datetime).fromNow()

  humanDuration: (duration) -> moment.duration(@duration).humanize()

  dataFields: -> (name: name, value: value for name, value of @data)

  errorMessage: -> @error?.split?('\n')?[0]?.replace /^Error:\s+/, ''

Template.job.events
  'click .remove': (evt) ->
    Meteor.call 'xue-ui-kill-job', @_id
    evt.stopPropagation()

  'click .contents': ->
    if XueUI.Session.equals 'selected', @_id
      return XueUI.Session.set 'selected', null
    XueUI.Session.set 'selected', @_id
