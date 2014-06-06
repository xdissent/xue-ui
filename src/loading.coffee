
Template.loading.rendered = ->
  @counter ?= 0
  canvas = @find 'canvas'
  @ctx = canvas.getContext '2d'
  @loading ?= new LoadingIndicator
  @loading.size canvas.width
  return if @interval?
  @interval = Meteor.setInterval =>
    @loading.update(@counter).draw @ctx
    @counter += 1
  , 50

Template.loading.destroyed = ->
  Meteor.clearInterval @interval if @interval?
  @counter = 0
