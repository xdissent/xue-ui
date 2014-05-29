
Deps.autorun ->
  Meteor.subscribe 'xue-ui-jobs-by-state', XueUI.Session.get 'state'

Template.list.helpers

  state: -> XueUI.Session.get 'state'

  jobs: ->
    sel = state: XueUI.Session.get 'state'
    filter = XueUI.Session.get 'filter'
    sel.type = filter if filter?
    Xue.Jobs.find sel, sort: [['created_at', XueUI.Session.get 'sort']]
