local Fake = {}
Fake.create = function()
  local self = {}
  local function _0_(self)
    return print("fake:goo called")
  end
  self.goo = _0_
  return self
end
return Fake
