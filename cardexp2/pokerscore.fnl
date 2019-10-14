
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
                    (var res false)
                    ;; has to be a flush first!
                    (if (self:is-flush? hand)
                        (let [
                            r1 (. (. hand.data 1) :rank)
                            r2 (. (. hand.data 1) :rank)
                            r3 (. (. hand.data 1) :rank)
                            r4 (. (. hand.data 1) :rank)
                            r5 (. (. hand.data 1) :rank)
                            ]
                            (set res (and (= 0 r1) (= 9 r2) (= 10 r3) (= 11 r4) (= 12 r5)) )
                        )   
                    )
                    res
                )

                :score (fn [self hand]
                    (self:sort hand)
                    (print (hand:srepr))
                    (var res PokerScore.SCORE_NONE)

                    (if (self:is-royal-flush? hand)
                        (do
                            (set res PokerScore.SCORE_ROYAL_FLUSH)
                            (print "RF")
                        )
                    )
                    (if (self:is-flush? hand)
                        (set res PokerScore.SCORE_FLUSH)
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