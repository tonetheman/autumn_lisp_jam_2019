local Scene = {}
Scene.create = function()
  local self = self
  local function _0_(self)
  end
  local function _1_(self)
    return print("enter scene2")
  end
  local function _2_(self)
    return print("exit scene2")
  end
  local function _3_(self, dt)
  end
  self = {draw = _0_, enter = _1_, exit = _2_, update = _3_}
  return self
end
return Scene
