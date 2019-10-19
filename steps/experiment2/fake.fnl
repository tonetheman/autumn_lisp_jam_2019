
(var Fake {})
(fn Fake.create []
	(local self {})
	(set self.goo
		(fn [self]
			(do
				(print "fake:goo called")
			)
		)
	)
	self
)


Fake
