
Deps.autorun ->
  Meteor.subscribe 'xue-ui-jobs-by-state', XueUI.Session.get 'state'

Template.list.helpers

  state: -> XueUI.Session.get 'state'

  jobs: ->
    Xue.Jobs.find state: XueUI.Session.get('state'),
      sort: [['created_at', XueUI.Session.get 'sort']]
