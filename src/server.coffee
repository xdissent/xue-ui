
# XXX We should be able to get these this from Xue itself
states = ['inactive', 'active', 'failed', 'complete', 'delayed', 'killed']

Meteor.publish 'xue-ui-jobs-by-state',
  (state, limit = 0, sort = 'asc', filter = null) ->
    check state, String
    check limit, Number
    check sort, String
    check filter, Match.OneOf null, String
    fields = logs: false # XXX Would love to exclude data and still get title
    fields.progress = false unless state is 'active'
    sel = state: state
    sel.type = filter if filter?
    Xue.Jobs.find sel,
      fields: fields, limit: limit, sort: [['created_at', sort]]

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

Meteor.publish 'xue-ui-job-types', ->
  initializing = true
  counts = {}

  handle = Xue.Jobs.find({}, type: true).observe
    added: (job) =>
      counts[job.type] = (counts[job.type] ? 0) + 1
      return if initializing
      if counts[job.type] is 1
        return @added 'xue-ui-job-types', job.type, count: counts[job.type]
      @changed 'xue-ui-job-types', job.type, count: counts[job.type]
    removed: (job) =>
      counts[job.type] -= 1
      if counts[job.type] is 0
        @removed 'xue-ui-job-types', job.type
        return delete counts[job.type]
      @changed 'xue-ui-job-types', job.type, count: counts[job.type]

  initializing = false
  @added 'xue-ui-job-types', type, count: count for type, count of counts
  @ready()
  @onStop -> handle.stop()

Meteor.methods
  'xue-ui-kill-job': (id) -> Xue.Job.create({_id: id}).kill()
