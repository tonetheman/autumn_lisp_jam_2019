
(local (w h) (values 240 136))

(var LoadingScene {})
(fn LoadingScene.create [scenemanager]
    (local self
        {
            :name :loadingscene
            
            :sm scenemanager

            :counter 0

            :msg "lispy video poker"

            :enter (fn [self]
                ;; (print "enter scene2" self)
            )

            :exit (fn [self]
                ;; (print "exit scene2" self)
            )
            
            :update (fn [self dt]
                ;; (print "update scene 2 called")
                (set self.counter (+ self.counter 1))
            
                (if (= self.counter 60)
                    (do
                        (set self.msg "yup")
                        
                        ;; need to call start for next scene...
                        (self.sm:start :gamescene)
                    )
                )
            
            )
            
            :draw (fn [self]
                (cls 0)
                (let [
                    width (print self.msg 0 -6)
                    ]
                    
                    (print self.msg (// (- 240 width) 2) (// (- 136 6) 2))
                    
                )
            )
        }
    
    )

    self

)



Scene