
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