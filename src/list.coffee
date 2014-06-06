
Deps.autorun ->
  XueUI.Session.set 'loading', true
  Meteor.subscribe 'xue-ui-jobs-by-state', XueUI.Session.get('state'),
    XueUI.Session.get('limit'), XueUI.Session.get('sort'),
    XueUI.Session.get('filter'), onReady: -> XueUI.Session.set 'loading', false

jobsCursor = ->
  sel = state: XueUI.Session.get 'state'
  filter = XueUI.Session.get 'filter'
  sel.type = filter if filter?
  Xue.Jobs.find sel,
    limit: XueUI.Session.get 'limit'
    sort: [['created_at', XueUI.Session.get 'sort']]

Template.list.helpers

  state: -> XueUI.Session.get 'state'

  jobs: -> jobsCursor()

  isLoading: -> XueUI.Session.get 'loading'

Template.list.rendered = ->
  $(window).on 'scroll', ->
    return if XueUI.Session.get 'loading'
    return if jobsCursor().count() < XueUI.Session.get 'limit'
    body = $ 'body'
    top = body.scrollTop()
    height = body.innerHeight()
    windowHeight = window.innerHeight
    pad = 30
    return unless top + windowHeight + pad >= height
    XueUI.Session.set 'limit', 10 + XueUI.Session.get 'limit'

Template.list.destroyed = ->
  $(window).off 'scroll'
