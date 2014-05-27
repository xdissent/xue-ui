
class XueUISession

  @key: (key) -> "__xue_ui_#{key}__"

  @get: (key) -> Session.get @key key

  @set: (key, value) -> Session.set @key(key), value

  @setDefault: (key, value) -> Session.setDefault @key(key), value

  @equals: (key, value) -> Session.equals @key(key), value
