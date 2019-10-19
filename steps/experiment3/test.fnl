(local SceneManager (require :scenemanager))
(local sm (SceneManager.create))

(local fakescene
	{
		;; needed for this to work
		;; this is what is used to index it
		:name "fakescene"
		:sm sm
		:counter 0
		:msg "fake scene here"
		:enter (fn [self]
			(print "fake enter is called")
		)
		:exit (fn [self]
			(print "fake exit is called")
		)
	}
)

(local loadingscene
	{
		;; needed for this to work
		;; this is what is used to index it
		:name "loadingscene"
		:sm sm
		:counter 0
		:msg "loading scene here"
		:enter (fn [self]
			(print "loading enter is called")
		)
		:exit (fn [self]
			(print "loading exit is called")
		)
	}
)


(print "fakescene ptr" fakescene)
(print "loading scene ptr" loadingscene)

(sm:add loadingscene)
(sm:add fakescene)
(sm:start-name :fakescene)
(sm:start-name :loadingscene)


