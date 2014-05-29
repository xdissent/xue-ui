
Deps.autorun ->
  id = XueUI.Session.get 'selected'
  Meteor.subscribe 'xue-ui-job-details', id if id?

Template.job.helpers

  title: -> @data?.title ? 'untitled'

  inactive: -> @state is 'inactive'

  active: -> @state is 'active'

  delayed: -> @state is 'delayed'

  failed: -> @state is 'failed'

  complete: -> @state is 'complete'

  killed: -> @state is 'killed'

  relativeDelay: -> moment(@created_at).add('ms', @delay).fromNow()

  showDetails: -> if XueUI.Session.equals 'selected', @_id then 'show' else ''

  humanPriority: ->
    return n for n, p of Xue.priorities when p is @priority
    @priority

  relativeDateTime: (datetime) -> moment(datetime).fromNow()

  humanDuration: (duration) -> moment.duration(@duration).humanize()

  dataFields: -> (name: name, value: value for name, value of @data)

Template.job.events
  'click .remove': (evt) ->
    Meteor.call 'xue-ui-kill-job', @_id
    evt.stopPropagation()

  'click .contents': ->
    if XueUI.Session.equals 'selected', @_id
      return XueUI.Session.set 'selected', null
    XueUI.Session.set 'selected', @_id

Template.progress.rendered = ->
  canvas = @find 'canvas'
  @ctx = canvas.getContext '2d'
  @progress ?= new Progress
  @progress.size canvas.width
  return if @handle?
  @handle = Deps.autorun =>
    job = Xue.Jobs.findOne @data._id, fields: progress: true
    return unless job?
    @progress.update(job.progress).draw @ctx

Template.progress.destroyed = -> @handle.stop() if @handle?

