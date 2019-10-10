(var SceneManager {})
(fn SceneManager.create []
    (local self {
        :list {} ;; holds the list of scenes

        :current nil ;; holds the current scene

        :add (fn [self sceneTable]
            (print "sm:add")
            (table.insert self sceneTable)
        )
    
        ;; start a scene
        :start (fn [self sceneTable]
            ;; find the scene in the list
            ;; call exit on current scene if it is there
            ;; call enter on new scene
            (print "sm:start")
            (print self.current)
            (if (= self.current nil)
                ;; no current in this case
                (print "sm:add no current")
                (set self.current sceneTable)
                (print "sm:add set current")
                (print self.current)
                (self.current:enter)
            )
        )
    
    })
    
    self
)


SceneManager