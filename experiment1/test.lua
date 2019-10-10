#!/usr/local/bin/lua

function test()
    local Scene = require("scene")
    local s = Scene.create()
    local Scene2 = require("scene2")
    local s2 = Scene2.create()
    
    local SceneManager = require("scenemanager")
    local sm = SceneManager.create()
    print("calling add now")
    sm:add(s)
    sm:add(s2)
    
    print("calling start now")
    sm:start(s)
    print("about to start s2")
    sm:start(s2)
    print("fin")    
end

test()


