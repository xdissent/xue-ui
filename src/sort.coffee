
Template.sort.events
  'change select': (evt) ->
    XueUI.Session.set 'sort', $(evt.currentTarget).val()
