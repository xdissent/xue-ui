
Template.list.helpers

  state: -> XueUISession.get 'state'

  jobs: ->
    XueUISession.setDefault 'state', 'active'
    Xue.Jobs.find state: XueUISession.get('state'),
      sort: [['created_at', XueUISession.get('sort') ? 'asc']]
