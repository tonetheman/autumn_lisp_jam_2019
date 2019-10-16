
;; all the poker and card logic here
(local Card (require :card))
(local Deck (require :deck))
(local Hand (require :hand))
(local PokerScore (require :pokerscore))

(local (w h) (values 240 136))

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

;; glyph lookup
;; super awkward :()
(local gl (fn [suit rank]
    (var res -1)
    (if (= suit 1) ;; hearts
        (set res (match rank
            0 0
            1 2
            2 4
            3 6
            4 8
            5 10
            6 12
            7 32
            8 34
            9 36
            10 38
            11 40
            12 42
        ))
    )
    (if (= suit 0) ;; diamonds
        (set res (match rank
            0 64
            1 66
            2 68
            3 70
            4 72
            5 74
            6 76
            7 96
            8 98
            9 100
            10 102
            11 104
            12 106
        ))
    )
    (if (= suit 3) ;; spades
        (set res (match rank
            0 128
            1 130
            2 132
            3 134
            4 136
            5 138
            6 140
            7 160
            8 162
            9 164
            10 166
            11 168
            12 170
        ))
    )
    (if (= suit 2) ;; clubs
        (set res (match rank
            0 192
            1 194
            2 196
            3 198
            4 200
            5 202
            6 204
            7 224
            8 226
            9 228
            10 230
            11 232
            12 234
        ))
    )
    res
))


(var Scene {})
(fn Scene.create [scenemanager]
    (local self
        {
            :name :gamescene

            ;; 
            :deck nil
            :hand nil
            :sm scenemanager

            ;; current card on the GUI
            :current_card 1

            :game-reset (fn [self]

                ;;(trace "about to shuffle...")
                (self.deck:reset) ;; sets current card back to 0
                (self.deck:shuffle) ;; reshuffle the deck
                (self.hand:deal)
            )

            :enter (fn [self]
                (math.randomseed (time))
                ;; create the Deck one time on enter
                (set self.deck (Deck.create))
                ;; create the hand one time on enter
                (set self.hand (Hand.create self.deck))
                ;; need to map graphics to the cards
                (self:map-cards-to-graphics)
                
                (self:game-reset)

            )

            :exit (fn [self]
                ;; (print "exit scene2" self)
            )
            
            :handle_click (fn [self]
                (trace "clik")
                (set self.mousedown false) ;; set back so we can get clicks
            )
            
            :update (fn [self dt]
                ;; mouse handling is mind numbing hard on tic80
                ;; handling repeat presses is beyond my thought patterns
                ;; (let [(mx my md) (mouse)])


                (local pressedLeft (btnp 2))
                (local pressedRight (btnp 3))
                (local pressedA (btnp 4))
                (local pressedB (btnp 5))
                (local pressedX (btnp 6))
                (local pressedY (btnp 7))

                (if pressedLeft
                    (if (> self.current_card 1)
                        (set self.current_card (- self.current_card 1))
                    )
                    
                )
                (if pressedRight
                    (if (< self.current_card 5)
                        (set self.current_card (+ self.current_card 1))
                    )
                )

                (if pressedA
                    ;; need to tell gui to no longer draw card
                    ;; and also for pulling new cards
                    (do
                        ;;(trace (.. "current card " self.current_card ))
                        (if (self.hand:get-discard self.current_card)
                            (self.hand:set-discard self.current_card false)
                            (self.hand:set-discard self.current_card true)
                        )
                        ;;(trace (.. (self.hand:get-discard self.current_card)))
                    )
                )

                (if pressedX
                    (do
                        (trace "REDEAL....")
                        (self.hand:redeal)
                    )
                )

                (if pressedB
                    (do
                        (trace "pressed b reset deck and hand")
                        (self:game-reset)
                    )
                )
            )
            
            :draw (fn [self]
                (cls 0)
                ;; woooo this works
                ;; (sspr 0 10 10)

                ;; get the first card from the deck
                ;; (local c (self.deck:get 0))
                
                ;; display the graphic
                ;; (sspr c.snum 10 10)

                (for [i 1 5]
                    (local c (self.hand:get i))
                    (sspr c.snum (* i 32) 10)
                )
                (for [i 1 5]
                    (if (self.hand:get-discard i)
                        (sspr 44 (* i 32) 10)
                    )
                )
                (rect (* self.current_card 32) 40 10 10 14)
                (print "press z to mark a card for discard" 10 100)
                (print "press a to draw new cards and score" 10 108)
            )

            :map-cards-to-graphics (fn [self]
                ;;
                (for [i 0 51]
                    (local c (. self.deck.cards i))
                    (local snum (gl c.suit c.rank))
                    (set c.snum snum)
                )
            )
        }
    
    )

    self

)



Scene