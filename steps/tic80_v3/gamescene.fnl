
(var Scene {})

(fn Scene.create [scenemanager]
  
  (local self {})
  
  (set self.sm scenemanager)
  
  (set self.player { :sprite 0 :x 0 :y 0 })
  
  (set self.enter
    (fn [self]
      ;; (print "Scene:enter" self)
    )
  )
  
  (set self.exit
    (fn [self]
      ;; (print "Scene:exit" self)
    )
  )

  (set self.update
    (fn [self dt]
      (if (btnp 3)
        (set self.player.x (+ self.player.x 8))
      )
      (if (btnp 2)
        (set self.player.x (- self.player.x 8))	
      )
      (if (btnp 0)
        (set self.player.y (- self.player.y 8))
      )
      (if (btnp 1)
        (set self.player.y (+ self.player.y 8))
      )
    )
  )

  (set self.draw
    (fn [self]
      (cls 0)
      (spr self.player.sprite self.player.x self.player.y)
    )
  )

  self
)

Scene
