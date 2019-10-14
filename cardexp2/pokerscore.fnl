
(let 
    [PokerScore {
        :create (fn []
            (local self {

                :sort (fn [self hand]
                    (print "before sort")

                    ;; TODO:
                    ;; this will not work since hand is not the array!
                    (table.sort hand (fn [a b]
                        (print "in comp func")
                        (local res (< a.rank b.rank ))
                        (print "res and ranks" res a.rank b.rank)
                        res
                    ))
                    (print "after sort")
                )

                :score (fn [self hand]
                    (print "about to sort")
                    (self:sort hand)
                    (print "after sort")
                )
            })
            self

        )
    }]
    PokerScore
)