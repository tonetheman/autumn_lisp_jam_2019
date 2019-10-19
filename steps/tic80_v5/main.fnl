
;; cards array
(local cards {})

(local init 
    (fn []
        ;; cards data struct
        ;;
        (local tmp1 {
            :id 0 ;; glyph id
        })
        (local tmp2 {
            :id 2
        })
        ;; set up the array
        (tset cards 0 tmp1)
        (tset cards 1 tmp2)
    )
)

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

(init)


(global TIC 
    (fn []
        (cls 0)
        (sspr 0 0 0)
        (sspr 2 16 16)
    )
)

