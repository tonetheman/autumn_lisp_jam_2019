

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
    
        :start-name (fn [self name]
            (do
                (print "called start-name" name)
                (if (~= self.current nil)
                    (self.current:exit)
                )

                (print "setting current now")
                (set self.current (. self.data name))
                (print "value of current" self.current)
                (self.current:enter)
            )
        )
    
    })
    
    self
)


SceneManager
