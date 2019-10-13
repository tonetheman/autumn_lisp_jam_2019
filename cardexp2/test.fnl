(local Card (require :card))
(local Deck (require :deck))
(local Hand (require :hand))

(math.randomseed (os.time))

(local testdeck 
    (fn []
        (local d (Deck.create))
        (d:shuffle2)
        ;; (d:repr)

        (let [ tmp (d:pop)]
            (tmp:repr)
        )
    )
)

(local deck (Deck.create))
(deck:shuffle2)
(local hand (Hand.create deck))
(hand:repr)