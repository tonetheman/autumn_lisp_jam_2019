
(var Scene {})
(fn Scene.create []
  (local self {})
  (set self.enter
    (fn [self]
      (print "enter")
      (print self)
    )
  )
  (set self.exit
    (fn [self]
    )
  )
  (set self.update
    (fn [self dt]
    )
  )
  (set self.draw
    (fn [self]
    )
  )
  self
)

Scene
