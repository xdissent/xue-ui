
# XXX We should be able to get these this from Xue itself
states = ['inactive', 'active', 'failed', 'complete', 'delayed', 'killed']

Meteor.publish 'xue-ui-jobs-by-state', (state) ->
  check state, String
  fields = logs: false # XXX Would love to exclude data and still get title
  fields.progress = false unless state is 'active'
  Xue.Jobs.find {state: state}, fields: fields

Meteor.publish 'xue-ui-job-details', (id) ->
  check id, String
  Xue.Jobs.find id, fields: logs: true # XXX data: true

Meteor.publish 'xue-ui-job-counts', ->
  initializing = true
  handles = []
  counts = total: 0

  changed = (state, incr) =>
    counts[state] += incr
    counts.total += incr
    return if initializing
    @changed 'xue-ui-job-counts', state, count: counts[state]
    @changed 'xue-ui-job-counts', 'total', count: counts.total

  for state in states
    do (state) ->
      counts[state] = 0
      handles.push Xue.Jobs.find(state: state).observeChanges
        added: -> changed state, 1
        removed: -> changed state, -1

  initializing = false
  @added 'xue-ui-job-counts', name, count: count for name, count of counts
  @ready()
  @onStop -> handle.stop() for handle in handles

Meteor.methods
  'xue-ui-kill-job': (id) -> Xue.Job.create({_id: id}).kill()
