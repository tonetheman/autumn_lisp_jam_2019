Fake = require("fake")
local ff = nil
local function init()
  print("init called")
  ff = Fake.create()
  print(ff)
  return ff:goo()
end
return init()
