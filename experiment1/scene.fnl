
(var Scene {})
(fn Scene.create []
  (local self {})
  (set self.enter
    (fn [self]
      (print "Scene:enter" self)
    )
  )
  (set self.exit
    (fn [self]
      (print "Scene:exit" self)
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
