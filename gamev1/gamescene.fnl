
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
        (local scale 2)
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
            :ps nil ;; PokerScore

            ;; mouse handling here
            :last_mouse_value false
            :gmouse_mouse_is_down false

            :_s_score nil ;; string version of score
            :money  200 ;; start with 200 dollars
            
            ;; current bet for the user
            :currentbet 1 ;; can be 1 or 5

            ;; current card on the GUI
            :current_card 1

            :game-reset (fn [self]

                ;;(trace "about to shuffle...")
                (self.deck:reset) ;; sets current card back to 0
                (self.deck:shuffle) ;; reshuffle the deck
                (self.hand:deal)
                (set self._s_score nil)
            )

            :next-hand (fn [self]
                (self:game-reset)
            )
            
            :enter (fn [self]
                (math.randomseed (time))
                ;; create the Deck one time on enter
                (set self.deck (Deck.create))
                ;; create the hand one time on enter
                (set self.hand (Hand.create self.deck))
                ;; need to map graphics to the cards
                (self:map-cards-to-graphics)

                (set self.ps (PokerScore.create))
                
                (self:game-reset)

            )

            :exit (fn [self]
                ;; (print "exit scene2" self)
            )

            ;; called one time for mouse down
            :mouse-down-handler (fn [self mx my]
                (set self.gmouse-is-down true)
                (trace (.. "mouse down handler" mx my))
            )

            ;; called one time for mouse up
            :mouse-up-handler (fn [self mx my]
                (set self.gmouse-is-down false)
                (trace (.. "mouse up handler" mx my))
            )


            :update (fn [self dt]

                ;; this let contains all of the mouse
                ;; handling logic for mouse down and mouse up
                (let [(mx my md) (mouse)]

                    (if (and md (= self.last_mouse_value false))
                        ;; if mousedown == true and false
                        ;; this is the first mouse click
                        ;;(trace "first mouse click")
                        (self:mouse-down-handler mx my)
                    )

                    ;; if the mouse is marked as down
                    ;; and you get a false from the hardware md
                    ;; this is the first mouse up
                    (if (and self.gmouse-is-down (= md false))
                        (self:mouse-up-handler mx my)
                    )
                    
                    ;; remember the last mouse value
                    (set self.last_mouse_value md)
                )

                (local pressedUp (btnp 0))
                (local pressedDown (btnp 1))
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
                
                ;; highlights the draw button if not down already
                ;; if already down then does nothing
                (if pressedDown
                    (trace "down")
                )

                ;; moves back up to cards
                ;; if already on cards does nothing
                (if pressedUp
                    (trace "up")
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
                        (trace "pulls new cards and scores....")
                        (self.hand:redeal)
                        (local tmp (self.hand:shallow-copy))
                        (local res (self.ps:score tmp))
                        (local res-s (self.ps:tr-score res))
                        (set self._s_score res-s)
                        (self:handle-bets res)
                    )
                )

                (if pressedY
                    (do
                        (trace "pressed Y")
                        
                        (local res 
                            (self.ps:pay-table PokerScore.SCORE_ROYAL_FLUSH 1))
                        (trace res)
                        
                    )
                )
                
                (if pressedB
                    (do
                        (trace "pressed b")
                        (self:next-hand)
                    )
                )
            )
            
            :handle-bets (fn [self score]
            )

            :draw (fn [self]
                (cls 0)

                (map 0 0)
                ;; woooo this works
                ;; (sspr 0 10 10)

                ;; get the first card from the deck
                ;; (local c (self.deck:get 0))
                
                ;; display the graphic
                ;; (sspr c.snum 10 10)

                (local offset_to_left 20)

                (for [i 1 5]
                    (local c (self.hand:get i))
                    (sspr c.snum (- (* i 42) offset_to_left)  5)
                )
                (for [i 1 5]
                    (if (self.hand:get-discard i)
                        (sspr 44 (- (* i 42) offset_to_left) 5)
                    )
                )
                
                (rect (* self.current_card 36) 40 10 10 14)

                ;; deal button
                (rect 195 72 24 8 14)
                (print "deal" 195 72 0)


                (print "use left and right to move" 10 80)
                (print "down will move to deal" 10 88)

                ;;(print "press z to mark a card for discard" 10 88)
                ;;(print "press a to draw new cards and score" 10 96)
                ;;(print "press x for next hand" 10 104)
                (print (.. "bank: " (tostring self.money)) 10 112)
                ;;(print (.. "bet:  (tostring self.currentbet)) 50 112)
                (print (.. "bet: " (tostring self.currentbet)) 150 112)

                (if (~= self._s_score nil)
                    (print (.. "score : " self._s_score) 10 124)
                )
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