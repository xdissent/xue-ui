
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
