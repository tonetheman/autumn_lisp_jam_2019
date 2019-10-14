
(let 
    [PokerScore {
        :SCORE_NONE -1
        :SCORE_ROYAL_FLUSH 0
        :SCORE_FLUSH 1

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
                        ;; else try to score something else
                        (if (self:is-flush? hand)
                            (set res PokerScore.SCORE_FLUSH)
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