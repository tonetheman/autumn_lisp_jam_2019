
;; load classes
(local SceneManager (require :scenemanager))
(local GameScene (require :gamescene))
(local LoadingScene (require :loadingscene))

(local (W H) (values 240 136))
(var gamescene nil)
(var loadingscene nil)
(var sm nil)

(fn init []
	(do
		(math.randomseed (time))

		;; note this is calling the create
		(set sm (SceneManager.create))
		(set gamescene (GameScene.create sm))
		(set loadingscene (LoadingScene.create sm))
		(sm:add gamescene)
		(sm:add loadingscene)
		(sm:start-name :loadingscene)
	)
)

;; set the global TIC function up here
(global TIC 
	(fn  []
		(sm:update)
		(sm:draw)
	)
)

;; run init one time
(init)

