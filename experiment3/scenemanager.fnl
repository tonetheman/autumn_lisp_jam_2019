

(fn find-in-table [tbl val]
    (var res nil)
    (each [key value (pairs tbl)]
        (do
            ;; (print "key" key "value" value)
            (if (= val value)
                (set res value)
            )
        )
    )
    res
)

(var SceneManager {})
(fn SceneManager.create []
    (local self {
        :data {} ;; holds the list of scenes

        :current nil ;; holds the current scene

        :update (fn [self dt]
            (if (~= self.current nil)
                (self.current:update dt)
            )
        )

        :draw (fn [self]
            (if (~= self.current nil)
                (self.current:draw)
            )
        )

        :add (fn [self sceneTable]
            (do
                ;;(print "sm:add")
                ;; (table.insert self.data sceneTable)
		(tset self.data sceneTable.name sceneTable)
            )
        )
    
        ;; start a scene
        :start (fn [self sceneTable]
            ;; find the scene in the list
            ;; call exit on current scene if it is there
            ;; call enter on new scene
            ;; (print "sm:start")
            ;; (print self.current)
            (if (= self.current nil)
                (do ;; current is nil
                    ;; no current in this case
                    ;;(print "sm:add no current")
                    
                    (set self.current sceneTable)
                    ;;(print "sm:add set current")
                    ;;(print self.current)
                    (self.current:enter)
                )
                (do ;; current is not nil
                    ;; exit the current scene
                    (self.current:exit)
                    ;; get the new scene
                    (set self.current (find-in-table self.data sceneTable))
                    (self.current:enter)
                    ;;(print "current after find")
                    ;;(print self.current)
                )
            )
        )
    
    })
    
    self
)


SceneManager
