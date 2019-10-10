

local Scene = require("scene")
local s = Scene.create()
local Scene2 = require("scene2")
local s2 = Scene2.create()

local SceneManager = require("scenemanager")
local sm = SceneManager.create()
print("calling add now")
sm:add(s)
print("calling start now")
sm:start(s)



