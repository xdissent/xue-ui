
Template.sort.events
  'change select': (evt) ->
    sort = $(evt.currentTarget).val()
    return if XueUI.Session.equals 'sort', sort
    XueUI.Session.set 'sort', sort
    XueUI.Session.set 'limit', 10
