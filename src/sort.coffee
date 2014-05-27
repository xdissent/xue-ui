
Template.sort.events
  'change select': (evt) ->
    XueUISession.set 'sort', $(evt.currentTarget).val()
