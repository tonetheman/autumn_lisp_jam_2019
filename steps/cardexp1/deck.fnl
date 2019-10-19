
(local Card (require :card))

(local Deck {
    :create (fn []
        (local self {
            ;; create cards storage here not filled out yet
            :cards {}

            ;; print the cards
            :repr (fn [self]
                (for [i 0 52]
                    (let [c (. self.cards i)]
                        (c.repr)
                    )
                )
            )

            :shuffle (fn [self]
                ;; run the shuffle routine 10 times
                ;; why 10 really?
                (for [_ 0 10]

                    ;; real shuffle here
                    (for [i 52 2 -1]
                        (local j (math.random i))
                        (let [tmp1 (. self.cards i)
                            tmp2 (. self.cards j)]
                            (tset self.cards i tmp2)
                            (tset self.cards j tmp1)
                        )
                    )

                )
            )


        })

        ;;
        ;; ctor here really
        ;; fill out self.cards
        (for [i 0 52]
            (tset self.cards i (Card.create i))
        )

        ;; return
        self
    )
})

Deck