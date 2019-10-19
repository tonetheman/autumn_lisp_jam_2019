(local Card {
    :create (fn [id]
        (local self {
            :id id
            :rank (% id 13)
            :suit (math.floor (/ id 13))
            :repr (fn []
                (local rankname (
                    match self.rank
                    0 "A"
                    1 "2"
                    2 "3"
                    3 "4"
                    4 "5"
                    5 "6"
                    6 "7"
                    7 "8"
                    8 "9"
                    9 "T"
                    10 "J"
                    11 "Q"
                    12 "K"
                ))
                (local suitname
                    (match self.suit
                    0 "D"
                    1 "H"
                    2 "C"
                    3 "S")
                )
                (print self.id rankname suitname)
            )
            :srepr (fn [self]
                            (local rankname (
                    match self.rank
                    0 "A"
                    1 "2"
                    2 "3"
                    3 "4"
                    4 "5"
                    5 "6"
                    6 "7"
                    7 "8"
                    8 "9"
                    9 "T"
                    10 "J"
                    11 "Q"
                    12 "K"
                ))
                (local suitname
                    (match self.suit
                    0 "D"
                    1 "H"
                    2 "C"
                    3 "S")
                )
                (local junk (.. rankname suitname))
                junk
            )
        })
        self
    )
})

(local Deck {
    :create (fn []
        (local self {
            ;; create cards storage here not filled out yet
            :cards {}

            ;; current position to pull the next
            ;; card from
            :current 0

            :get (fn [self i]
                (. self.cards i)
            )
            
            :set (fn [self i value]
                (tset self.cards i value)
            )
            
            :reset (fn [self]
                (set self.current 0)
            )
            
            :srepr (fn [self]
                (var ts "")
                (for [i 0 51]
                    (local c (self:get i))
                    (set ts (.. ts (c:srepr) " "))
                )
                ts
            )

            ;; print the cards
            :repr (fn [self]
                (for [i 0 51]
                    (let [c (self:get i)]
                        (c.repr)
                    )
                )
            )

            :shuffle (fn [self]
                (for [_ 0 10]
                    (for [i 0 51]
                        (let [r (math.random 51)
                            tmp1 (self:get i)
                            tmp2 (self:get r)
                            ]
                            (self:set i tmp2)
                            (self:set r tmp1)
                        )
                    )
                )
            )
            

            ;; pop a single card off the top
            ;; of the deck and return it
            ;; adjust the current position
            ;; TODO: needs error checking
            ;; in my case it does not matter
            ;; each time you get a new deck so never will hit
            ;; edge case
            :pop (fn [self]
                (local tmp self.current)
                (set self.current (+ self.current 1))
                (self:get tmp)
            )


        })

        ;;
        ;; ctor here really
        ;; fill out self.cards
        (for [i 0 51]
            (self:set i (Card.create i))
        )

        ;; return
        self
    )
})




(local Hand {
        :create (fn [deck]
            (local self {
                ;; the deck you are using in this hand
                :deck deck

                ;; the cards you pulled
                :data {}
                :discarddata {}

                :shallow-copy (fn [self]
                    (local _ {
                        :data {}
                    })
                    (for [i 1 5]
                        (tset _.data i (self:get i))
                    )
                    _
                )

                :get (fn [self i]
                    ( . self.data i)
                )
                
                :get-discard (fn [self i]
                    (. self.discarddata i)
                )
                
                :set (fn [self i value]
                    (tset self.data i value)
                )

                :set-discard (fn [self i value]
                    (tset self.discarddata i value)
                )

                ;; 1 to 5 see below for note
                :repr (fn [self]
                    (for [_ 1 5]
                        (local tmp (self:get _))
                        (print (tmp:repr))
                    )
                )

                ;; 1 to 5 see below for note
                :srepr (fn [self]
                    (var ts "")
                    (for [_ 1 5]
                        (local tmp (self:get _))
                        ;; (print (tmp:srepr))
                        (set ts (.. ts (tmp:srepr) " "))
                    )
                    ts
                )
            

                :reset-discard (fn [self]
                    (for [_ 1 5]
                        ;; we are discarding no cards
                        (self:set-discard _ false)
                    )
                )

                :deal (fn [self]
                    ;; needed 1 to 5 for stupid sort
                    (for [_ 1 5]
                        (self:set _ (deck:pop))
                    )
                    ;; when we deal we need to reset discard data
                    (self:reset-discard)
                )

                :redeal (fn [self]
                    (for [_ 1 5]
                        (if (self:get-discard _)
                            (do
                                ;; this is a discard
                                ;; get a new card now
                                (self:set _ (deck:pop))
                                ;; mark as not discarded
                                (self:set-discard _ false)
                            )
                        )
                    )
                )
                
            })




        

            ;; return self
            self
        ) ;; end of create
    } ;; end of hand

)


(local PokerScore {
        :SCORE_NONE -1
        :SCORE_ROYAL_FLUSH 0
        :SCORE_STRAIGHT_FLUSH 1
        :SCORE_FOUR_OF_KIND 2
        :SCORE_FULL_HOUSE 3
        :SCORE_FLUSH 4
        :SCORE_STRAIGHT 5
        :SCORE_THREE_OF_KIND 6
        :SCORE_TWO_PAIR 7
        :SCORE_ONE_PAIR 8

        :create (fn []
            (local self {

                :sort (fn [self hand]
                    (table.sort hand.data (fn [a b]
                        (< a.rank b.rank )
                    ))
                )
                :is-flush? (fn [self hand]
                    (var res false) ;; assume false

                    ;; get the suits
                    (let [
                        s1 (. (. hand.data 1) :suit)
                        s2 (. (. hand.data 2) :suit)
                        s3 (. (. hand.data 3) :suit)
                        s4 (. (. hand.data 4) :suit)
                        s5 (. (. hand.data 5) :suit)
                        ]

                        (do
                            ;; (print s1 s2 s3 s4 s5)

                            ;; they all have to be the same
                            ;; as suit 1
                            (if (= s1 s2)
                                (if (= s1 s3)
                                    (if (= s1 s4)
                                        (if (= s1 s5)
                                            (set res true)
                                        )
                                    )
                                )
                            )


                        )

                    )
                    res
                )
                
                :is-straight-flush? (fn [self hand]
                    (var res false)
                    
                    ;; must be a flush to start with
                    (if (self:is-flush? hand)


                        (let [
                        r1 (. (. hand.data 1) :rank)
                        r2 (. (. hand.data 2) :rank)
                        r3 (. (. hand.data 3) :rank)
                        r4 (. (. hand.data 4) :rank)
                        r5 (. (. hand.data 5) :rank)
                        ]
                            (if (and 
                                    (= r2 (+ r1 1))
                                    (= r3 (+ r2 1))
                                    (= r4 (+ r3 1))
                                    (= r5 (+ r4 1))
                                )
                                (set res true)
                            )
                        )


                    )

                    res
                )

                :is-full-house? (fn [self hand]
                    (var res false)
                    (local r1 (. (. hand.data 1) :rank))
                    (local r2 (. (. hand.data 2) :rank))
                    (local r3 (. (. hand.data 3) :rank))
                    (local r4 (. (. hand.data 4) :rank))
                    (local r5 (. (. hand.data 5) :rank))
                    (local s1 (. (. hand.data 1) :suit))
                    (local s2 (. (. hand.data 2) :suit))
                    (local s3 (. (. hand.data 3) :suit))
                    (local s4 (. (. hand.data 4) :suit))
                    (local s5 (. (. hand.data 5) :suit))

                    ;; XXXYY
                    (if (and (= s1 s2) (= s2 s3) (= s4 s5))
                        (if (and (= r1 r2) (= r2 r3) (= r4 r5))
                            (set res true)
                        )
                    )
                    ;; YYXXX
                    (if (and (= s1 s2) (= s3 s4) (= s4 s5))
                        (if (and (= r1 r2) (= r3 r4) (= r4 r5))
                            (set res true)
                        )
                    )
                    
                    res
                )

                :is-straight? (fn [self hand]
                    (var res false)
                    (let [
                    r1 (. (. hand.data 1) :rank)
                    r2 (. (. hand.data 2) :rank)
                    r3 (. (. hand.data 3) :rank)
                    r4 (. (. hand.data 4) :rank)
                    r5 (. (. hand.data 5) :rank)
                    ]
                        (do
                        
                            (if (and 
                                    (= r2 (+ r1 1))
                                    (= r3 (+ r2 1))
                                    (= r4 (+ r3 1))
                                    (= r5 (+ r4 1))
                                )
                                (set res true)
                            )
                        
                            ;; special case of high straight
                            (if (and (= 0 r1) (= 9 r2) (= 10 r3) (= 11 r4) (= 12 r5)) 
                                (set res true)
                            )

                        )
                    )

                    res
                )

                :is-three-of-kind? (fn [self hand]
                    (var res false)
                    (let [
                        r1 (. (. hand.data 1) :rank)
                        r2 (. (. hand.data 2) :rank)
                        r3 (. (. hand.data 3) :rank)
                        r4 (. (. hand.data 4) :rank)
                        r5 (. (. hand.data 5) :rank)
                    ]
                        (do
                            ;; XXXYY
                            (if (and (= r1 r2) (= r1 r3))
                                (set res true)
                            )
                            ;; YYXXX
                            (if (and (= r5 r4) (= r5 r3))
                                (set res true)
                            )
                        )
                    )
                    res
                )

                :is-two-pair? (fn [self hand]
                    (var res false)
                    (let [
                        r1 (. (. hand.data 1) :rank)
                        r2 (. (. hand.data 2) :rank)
                        r3 (. (. hand.data 3) :rank)
                        r4 (. (. hand.data 4) :rank)
                        r5 (. (. hand.data 5) :rank)
                    ]
                        (do
                            ;; XXYYZ
                            (if (and (= r1 r2) (= r3 r4))
                                (set res true)
                            )
                            ;; ZXXYY
                            (if (and (= r2 r3) (= r4 r5))
                                (set res true)
                            )
                            ;; XXZYY
                            (if (and (= r1 r2) (= r4 r5))
                                (set res true)
                            )
                        )
                    )
                    res
                )

                :is-pair? (fn [self hand]

                    (var res false)
                    (let [
                        r1 (. (. hand.data 1) :rank)
                        r2 (. (. hand.data 2) :rank)
                        r3 (. (. hand.data 3) :rank)
                        r4 (. (. hand.data 4) :rank)
                        r5 (. (. hand.data 5) :rank)
                    ]
                        (do
                            ;; XXABC
                            (if (= r1 r2)
                                (set res true)
                            )
                            ;; AXXBC
                            (if (= r2 r3)
                                (set res true)
                            )
                            ;; ABXXC
                            (if (= r3 r4)
                                (set res true)
                            )
                            ;; ABCXX
                            (if (= r4 r5)
                                (set res true)
                            )
                        )
                    )
                    res
                )

                :is-four-of-kind? (fn [self hand]
                    (var res false)
                    (let [
                        r1 (. (. hand.data 1) :rank)
                        r2 (. (. hand.data 2) :rank)
                        r3 (. (. hand.data 3) :rank)
                        r4 (. (. hand.data 4) :rank)
                        r5 (. (. hand.data 5) :rank)
                        ]
                        (if (and (= r2 r3) (= r3 r4) (= r4 r5) (~= r1 r2))
                            (set res true)
                            (if (and (= r1 r2) (= r2 r3) (= r3 r4) (~= r4 r5))
                                (set res true)
                            )
                        )
                    )
                    res
                )

                :is-royal-flush? (fn [self hand]
                    ;; (print "dbg:is-royal-flush? called")
                    (var res false)
                    ;; has to be a flush first!
                    (if (self:is-flush? hand)

                        (do
                            ;; (print "dbg:is-royal-flush? marked as flush")
                            (let [
                                r1 (. (. hand.data 1) :rank)
                                r2 (. (. hand.data 2) :rank)
                                r3 (. (. hand.data 3) :rank)
                                r4 (. (. hand.data 4) :rank)
                                r5 (. (. hand.data 5) :rank)
                                ]
                                ;; (print "dbg:is-royal-flush? after let")
                                ;; (print "dbg:is-royal-flush?" r1 r2)
                                (set res (and (= 0 r1) (= 9 r2) (= 10 r3) (= 11 r4) (= 12 r5)) )
                            )   

                        )

                    )
                    ;;(print "dbg:is-royal-flush? value of res" res)
                    res
                )

                :score (fn [self hand]
                    (self:sort hand)
                    ;;(print "dbg:score" (hand:srepr))
                    (var res PokerScore.SCORE_NONE)

                    (if (self:is-royal-flush? hand)
                        (do
                            ;; (print "dbg:score: is royal flush worked")
                            (set res PokerScore.SCORE_ROYAL_FLUSH)
                            ;;(print "RF")
                        )
                        (if (self:is-straight-flush? hand)
                            (set res PokerScore.SCORE_STRAIGHT_FLUSH)
                            (if (self:is-four-of-kind? hand)
                                (set res PokerScore.SCORE_FOUR_OF_KIND)
                                (if (self:is-full-house? hand)
                                    (set res PokerScore.SCORE_FULL_HOUSE)
                                    (if (self:is-flush? hand)
                                        (set res PokerScore.SCORE_FLUSH)
                                        (if (self:is-straight? hand)
                                            (set res PokerScore.SCORE_STRAIGHT)
                                            (if (self:is-three-of-kind? hand)
                                                (set res PokerScore.SCORE_THREE_OF_KIND)
                                                (if (self:is-two-pair? hand)
                                                    (set res PokerScore.SCORE_TWO_PAIR)
                                                    (if (self:is-pair? hand)
                                                        (set res PokerScore.SCORE_ONE_PAIR)
                                                    )
                                                )
                                            )
                                        )
                                    )
                                )

                            )
                        )
           
                    )
                
                    res
                )

                :tr-score (fn [self value]
                    ;; (print "tr-score" value)
                    (var res "no score")
                    (if (= PokerScore.SCORE_FLUSH value)
                        (set res "flush") 
                    )
                    (if (= PokerScore.SCORE_ROYAL_FLUSH value)
                        (set res "royal flush")
                    )
                    (if (= PokerScore.SCORE_FOUR_OF_KIND value)
                        (set res "four of kind")
                    )
                    (if (= PokerScore.SCORE_FULL_HOUSE value)
                        (set res "full house")
                    )
                    (if (= PokerScore.SCORE_STRAIGHT value)
                        (set res "straight")
                    )
                    (if (= PokerScore.SCORE_THREE_OF_KIND value)
                        (set res "three of kind")
                    )
                    (if (= PokerScore.SCORE_TWO_PAIR value)
                        (set res "two pair")
                    )
                    (if (= PokerScore.SCORE_ONE_PAIR value)
                        (set res "one pair")
                    )
        

                    res
                )


                ;; see here for possible payouts
                
                :pay-table (fn [self score bet]
                    (match bet
                        1 (match score
                            PokerScore.SCORE_ROYAL_FLUSH 250
                            PokerScore.SCORE_STRAIGHT_FLUSH 50
                            PokerScore.SCORE_FOUR_OF_KIND 25
                            PokerScore.SCORE_FULL_HOUSE 9
                            PokerScore.SCORE_FLUSH 6
                            PokerScore.SCORE_STRAIGHT 4
                            PokerScore.SCORE_THREE_OF_KIND 3
                            PokerScore.SCORE_TWO_PAIR 2
                            ;; MISSING pair of jacks+
                            )
                        2 (trace "got 2")
                    )
                )
            })
            self
        )
    }
)




(var SceneManager {})
(fn SceneManager.create []
    (local self {
        :data {} ;; holds the list of scenes

        :current nil ;; holds the current scene

        :update (fn [self dt]
            (if (~= self.current nil)
                (self.current:update dt)
            )
        )

        :draw (fn [self]
            (if (~= self.current nil)
                (self.current:draw)
            )
        )

        :add (fn [self sceneTable]
            (do
                ;;(print "sm:add")
                ;; (table.insert self.data sceneTable)
		        (tset self.data sceneTable.name sceneTable)
            )
        )
    
        :start (fn [self name]
            (do
                (print "called start-name" name)
                (if (~= self.current nil)
                    (self.current:exit)
                )

                (print "setting current now")
                (set self.current (. self.data name))
                (print "value of current" self.current)
                (self.current:enter)
            )
        )
    
    })
    
    self
)



(var LoadingScene {})
(fn LoadingScene.create [scenemanager]
    (local self
        {
            :name :loadingscene
            
            :sm scenemanager

            :counter 0

            :msg "lispy video poker"

            :enter (fn [self]
                ;; (print "enter scene2" self)
            )

            :exit (fn [self]
                ;; (print "exit scene2" self)
            )
            
            :update (fn [self dt]
                ;; (print "update scene 2 called")
                (set self.counter (+ self.counter 1))
            
                (if (= self.counter 60)
                    (do
                        (set self.msg "yup")
                        
                        ;; need to call start for next scene...
                        (self.sm:start :gamescene)
                    )
                )
            
            )
            
            :draw (fn [self]
                (cls 0)
                (let [
                    width (print self.msg 0 -6)
                    ]
                    
                    (print self.msg (/ (- 240 width) 2) (/ (- 136 6) 2))
                    
                )
            )
        }
    
    )

    self

)



;;
(local TRect {
    :create (fn [x y w h]
        {
            :id i ;; this will match the sprite number
            :x x
            :y y
            :w w
            :h h
  
            :hit (fn [self x y]
                (var res false)
                (if (and (>= x self.x) (<= x (+ self.x self.w)))
                    (if (and (>= y self.y) (<= y (+ self.y self.h)))
                        ;;
                        (set res true)
                    )
                )
                res
            )
        }
    )
})

(local (w h) (values 240 136))
(local offset_to_left 20)
(local cards_y_top 20) ;; top of cards for y
(local deal_v_rect (TRect.create 195 92 24 8))
(local bet1_v_rect (TRect.create 60 92 30 10))
(local bet5_v_rect (TRect.create 100 92 30 10))

(local STATE_WAITING_FOR_DEAL 0) ;; no cards dealt yet
(local STATE_WAITING_FOR_DISCARDS 1) ;; initial deal has happened                

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

(var GameScene {})
(fn GameScene.create [scenemanager]
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

            ;; rects for mouse hits
            :rects {}

            ;; state of the game
            :state STATE_WAITING_FOR_DEAL

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
    
                ;; need to create rects for the cards
                (for [i 1 5]
                    (local computedx (- (* i 42) offset_to_left))
                    (local tmp (TRect.create computedx cards_y_top 16 32))
                    (tset self.rects i tmp)
                )

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
                (trace (.. "mouse down handler" mx " " my))
            )

            ;; called one time for mouse up
            :mouse-up-handler (fn [self mx my]
                (set self.gmouse-is-down false)


                (match self.state
                STATE_WAITING_FOR_DEAL 
                    (do

                        ;; for state waiting on deal
                        ;; only deal and bet buttons work


                        ;; now check for deal button
                        (if (deal_v_rect:hit mx my)
                            (do
                                (trace "deal clicked...")
                                (self:next-hand)
                                ;; state changed to now wanting
                                ;; discards
                                (set self.state STATE_WAITING_FOR_DISCARDS)
                            )
                        )

                        ;; now check for bet buttons
                        (if (bet1_v_rect:hit mx my)
                            (do
                                (trace "bet1")
                                (set self.currentbet 1)
                            )
                        )
                        (if (bet5_v_rect:hit mx my)
                            (do
                                (trace "bet5")
                                (set self.currentbet 5)
                            )
                        )



                    )
                STATE_WAITING_FOR_DISCARDS
                    (do

                        ;; check for card interactions
                        (for [i 1 5]
                            ;; set 
                            (local d (. self.rects i))
                            (if (d:hit mx my)
                                (do
                                    (trace (.. i " " mx " "  my))
                                    (if (self.hand:get-discard i)
                                        (self.hand:set-discard i false)
                                        (self.hand:set-discard i true)
                                    )
                                )
                            )
                        )

                        ;; now check for deal button
                        ;; in this case the person is done
                        ;; and wants the score
                        (if (deal_v_rect:hit mx my)
                            (do
                                (trace "deal we are done")

                                (self.hand:redeal)
                                (local tmp (self.hand:shallow-copy))
                                (local res (self.ps:score tmp))
                                (local res-s (self.ps:tr-score res))
                                (set self._s_score res-s)
                                (self:handle-bets res)

                                (set self.state STATE_WAITING_FOR_DEAL)
                            )
                        )







                    )                
                )





                

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

                ;; not used really
                (local pressedUp (btnp 0))
                (local pressedDown (btnp 1))
                (local pressedLeft (btnp 2))
                (local pressedRight (btnp 3))
                (local pressedA (btnp 4))
                (local pressedB (btnp 5))
                (local pressedX (btnp 6))
                (local pressedY (btnp 7))

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

                ;; clear screen
                (cls 0)

                ;; draw background
                (map 0 0)

                ;; draw cards from hand
                (for [i 1 5]
                    (local c (self.hand:get i))
                    (local computedx (- (* i 42) offset_to_left))
                    ;; (trace (.. i " " computedx))
                    (sspr c.snum  computedx cards_y_top)
                )
                ;; draw flipped cards
                (for [i 1 5]
                    (if (self.hand:get-discard i)
                        (sspr 44 (- (* i 42) offset_to_left) cards_y_top)
                    )
                )
                
                ;; buttons

                ;; deal button
                (rect deal_v_rect.x deal_v_rect.y 
                    deal_v_rect.w deal_v_rect.h 14)
                (print "deal" deal_v_rect.x deal_v_rect.y 0)

                ;; bet 1
                (rect bet1_v_rect.x bet1_v_rect.y bet1_v_rect.w bet1_v_rect.h 
                    14)
                (print "bet1" bet1_v_rect.x bet1_v_rect.y 0)

                ;; bet 5
                (rect bet5_v_rect.x bet5_v_rect.y bet5_v_rect.w bet5_v_rect.h 14)
                (print "bet5" bet5_v_rect.x bet5_v_rect.y 0)

                (print (.. "bank: " (tostring self.money)) 10 112)
                (print (.. "bet: " (tostring self.currentbet)) 150 112)

                (if (~= self._s_score nil)
                    (print (.. "score : " self._s_score) 10 124)
                )


                (match self.state
                STATE_WAITING_FOR_DEAL 
                    (do
                        ;; need to show text
                        ;; click deal to start...
                        (print "make bet, click deal" 10 (/ h 2) 6 false 2)
                    )
                STATE_WAITING_FOR_DISCARDS 
                    (do
                        (local _ nil)
                    )
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

