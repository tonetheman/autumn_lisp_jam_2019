
(let 
    [PokerScore {
        :create (fn []
            (local self {

                :sort (fn [self hand]
                    (table.sort hand.data (fn [a b]
                        (< a.rank b.rank )
                    ))
                )

                :score (fn [self hand]
                    (self:sort hand)
                )
            })
            self

        )
    }]
    PokerScore
)