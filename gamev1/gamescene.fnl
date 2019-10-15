
(local (w h) (values 240 136))

;; my spr routine
;; only here to keep complexity down
;; needed this for 2x2 sprites
(local sspr
    (fn [id x y]
        (local colorkey 0)
        (local scale 1)
        (local flip 0)
        (local rotate 0)
        (local w 2) ;; needed cause the cards are 2x2
        (local h 2)
        (spr id x y colorkey scale flip rotate w h)
    )
)

(var Scene {})
(fn Scene.create [scenemanager]
    (local self
        {
            :name :gamescene
            
            :sm scenemanager

            :enter (fn [self]
                ;; (print "enter scene2" self)
            )

            :exit (fn [self]
                ;; (print "exit scene2" self)
            )
            
            :update (fn [self dt]
            
            )
            
            :draw (fn [self]
                (cls 0)
                ;; woooo this works
                (sspr 0 10 10)
            )
        }
    
    )

    self

)



Scene