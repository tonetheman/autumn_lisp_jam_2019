
;; load up classes first
(local SceneManager (require :scenemanager))
(local LoadingScene (require :loadingscene))
(local GameScene (require :gamescene))

;; manages starting and stopping scenes
;; only 1 scene manager
(local sm (SceneManager.create))

(local _loadingscene (LoadingScene.create sm))
(local _gamescene (GameScene.create sm))

(local init (fn []
    ;; add the scenes to the SceneManager
    (sm:add _loadingscene)
    (sm:add _gamescene)

    ;; start a scene
    (sm:start :loadingscene)
))

;; not used if everything is going right
(local update (fn []
))

;; not used if everything is going right
(local draw (fn []
    (cls 0)
))

;; tell the SceneManager to draw and update
(global TIC (fn []
    (sm:update)
    (sm:draw)
))

(init)
