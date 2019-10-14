(local Card (require :card))
(local Deck (require :deck))
(local Hand (require :hand))
(local PokerScore (require :pokerscore))

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

(for [_ 0 1000]
    (local deck (Deck.create))
    (deck:shuffle2)
    (local hand (Hand.create deck))
    ;; (print (hand:srepr))
    (local ps (PokerScore.create))
    (ps:score hand)
    ;; (print "--------------")
    ;;(print (hand:srepr))
)
