
;; all the poker and card logic here
(local Card (require :card))
(local Deck (require :deck))
(local Hand (require :hand))
(local PokerScore (require :pokerscore))

;; load up classes first
(local SceneManager (require :scenemanager))
(local LoadingScene (require :loadingscene))
(local GameScene (require :gamescene))

;; manages starting and stopping scenes
;; only 1 scene manager
(local sm (SceneManager.create))

(local _loadingscene (LoadingScene.create sm))
(local _gamescene (GameScene.create sm))

;; my spr routine
;; only here to keep complexity down
;; needed this for 2x2 sprites
(local sspr
    (fn [id x y]
        (local colorkey 0)
        (local scale 1)
        (local flip 0)
        (local rotate 0)
        (local w 2) ;; needed cause the cards are 2x2
        (local h 2)
        (spr id x y colorkey scale flip rotate w h)
    )
)

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
