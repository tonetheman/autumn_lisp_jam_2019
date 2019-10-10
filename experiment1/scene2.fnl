(var Scene {})
(fn Scene.create []
    (local self
        {
            :enter (fn [self]
                (print "enter scene2" self)
            )
            :exit (fn [self]
                (print "exit scene2" self)
            )
            :update (fn [self dt]
                (print "update scene 2 called")
            )
            :draw (fn [self]
                (print "draw scene 2 called")
            )
        }
    
    )

    self

)



Scene