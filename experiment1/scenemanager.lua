local SceneManager = {}
SceneManager.create = function()
  local self = self
  local function _0_(self, sceneTable)
    print("sm:add")
    return table.insert(self, sceneTable)
  end
  local function _1_(self, sceneTable)
    print("sm:start")
    print(self.current)
    if (self.current == nil) then
      return print("sm:add no current")
    else
      self.current = sceneTable
      if nil then
        return print("sm:add set current")
      elseif print(self.current) then
        return (self.current):enter()
      end
    end
  end
  self = {add = _0_, current = nil, list = {}, start = _1_}
  return self
end
return SceneManager
