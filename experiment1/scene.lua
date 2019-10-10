local Scene = {}
Scene.create = function()
  local self = {}
  local function _0_(self)
    print("enter")
    return print(self)
  end
  self.enter = _0_
  local function _1_(self)
  end
  self.exit = _1_
  local function _2_(self, dt)
  end
  self.update = _2_
  local function _3_(self)
  end
  self.draw = _3_
  return self
end
return Scene
