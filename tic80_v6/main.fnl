
(local justblue 142)
(local bet5 174)
(local bet1 172)
(var last_mouse_value false)
(var gmouse-is-down false)

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

(local mouse-down-handler (fn [mx my]
    (set gmouse-is-down true)
    (trace (.. "mouse down handler" mx my))
))
(local mouse-up-handler (fn [mx my]
    (set gmouse-is-down false)
    (trace (.. "mouse up handler" mx my))

    (if (and (>= mx 10) (<= mx 26))
        (if (and (>= my 10) (<= my 26))
            (trace "got it")
        )
        
    )
))

(local update (fn []

    ;; mouse handling that works!
    (let [(mx my md) (mouse)]
    
        ;;(trace (.. (tostring mx) (tostring md)))
    
        (if (and md (= last_mouse_value false))
            ;; if mousedown == true and false
            ;; this is the first mouse click
            ;;(trace "first mouse click")
            (mouse-down-handler mx my)
        )

        ;; if the mouse is marked as down
        ;; and you get a false from the hardware md
        ;; this is the first mouse up
        (if (and gmouse-is-down (= md false))
            (mouse-up-handler mx my)
        )
        
        ;; remember the last mouse value
        (set last_mouse_value md)
    )
))

(local draw (fn []

    ;; 1 button
    (sspr justblue 10 32)
    (print "1" 15 35 15 false 2)

    ;; 5 button
    (sspr justblue 32 32)
    (print "5" 35 35 15 false 2)
))

(global TIC (fn []
(update)
(draw)
))
