
(local Card (require :card))

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

Deck
