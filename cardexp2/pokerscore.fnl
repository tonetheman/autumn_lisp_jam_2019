
(let 
    [PokerScore {
        :create (fn []
            (local self {

                :sort (fn [self hand]
                    (table.sort hand.data (fn [a b]
                        (< a.rank b.rank )
                    ))
                )
                :is-flush? (fn [self hand]
                    (var res false)

                    (let [h1 (. hand.data 1)
                        h2 (. hand.data 2) 
                        h3 (. hand.data 3) 
                        h4 (. hand.data 4) 
                        h5 (. hand.data 5)
                        s1 h1.suit
                        s2 h2.suit
                        s3 h3.suit
                        s4 h4.suit
                        s5 h5.suit
                        ]

                        (do
                            ;; (print s1 s2 s3 s4 s5)

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
                
                :score (fn [self hand]
                    (if (self:is-flush? hand)
                        (print "FLUSH")
                    )
                    (self:sort hand)
                )
            })
            self

        )
    }]
    PokerScore
)