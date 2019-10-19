
;; load classes
(global SceneManager (require :scenemanager))
(global GameScene (require :gamescene))
(global LoadingScene (require :loadingscene))

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
		(sm:start loadingscene)
	)
)


(fn mainloop []
	(sm:update)
	(sm:draw)
)

(init)
(global TIC mainloop)
