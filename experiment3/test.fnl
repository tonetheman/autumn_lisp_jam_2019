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
	}
)

(sm:add fakescene)


