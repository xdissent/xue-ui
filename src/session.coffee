
class XueUISession

  @key: (key) -> "__xue_ui_#{key}__"

  @get: (key) -> Session.get @key key

  @set: (key, value) -> Session.set @key(key), value

  @setDefault: (key, value) -> Session.setDefault @key(key), value

  @equals: (key, value) -> Session.equals @key(key), value



XueUI.Session = XueUISession
XueUI.Session.setDefault 'state', 'active'
XueUI.Session.setDefault 'sort', 'asc'
XueUI.Session.setDefault 'limit', 10
XueUI.Session.setDefault 'filter', null
XueUI.Session.setDefault 'loading', false
