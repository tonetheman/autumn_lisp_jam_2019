

(global Fake (require :fake))
(var ff nil)

(fn init []
	(do
		(print "init called")
		(set ff (Fake.create))
		(print ff)
		(ff:goo)
	)
)

(init)
