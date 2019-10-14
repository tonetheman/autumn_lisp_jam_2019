
(let 
    [PokerScore {
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
                
                    false
                )

                :is-pair? (fn [self hand]
                    false
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
                    res
                )
            })
            self
        )
    }]
    PokerScore
)