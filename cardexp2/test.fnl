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

(local test-royal-flush
    (fn []
        (local deck (Deck.create))
        (tset deck.cards 0 (Card.create 0))
        (tset deck.cards 1 (Card.create 9))
        (tset deck.cards 2 (Card.create 10))
        (tset deck.cards 3 (Card.create 12))
        (tset deck.cards 4 (Card.create 11))
        (local hand (Hand.create deck))
        (local ps (PokerScore.create))
        (local score (ps:score hand))
        (print "score" score (ps:tr-score score))
        (print (hand:srepr))
    )
)

(local test-flush
   
    (fn []
        (var total_count 0)
        (var flush_count 0)
        (var rf_flush_count 0)
        (local COUNT 50000)
        (for [_ 0 COUNT]
            (local deck (Deck.create))
            (deck:shuffle2)
            (local hand (Hand.create deck))
            ;; (print (hand:srepr))
            (local ps (PokerScore.create))
            (local score (ps:score hand))
            ;; (print "--------------")
            (set total_count (+ 1 total_count))
            (if (~= score -1)
                (do
                    (if (= score PokerScore.SCORE_FLUSH)
                        (set flush_count (+ 1 flush_count))
                    )
                    ;; (print score (ps:tr-score score) (hand:srepr))
                    (if (= score PokerScore.SCORE_ROYAL_FLUSH)
                        (set rf_flush_count (+ 1 rf_flush_count))
                    )
                ) 
            )
        )

        (print "------------------")
        (print "total hands " total_count)
        (print "total flush count" flush_count (/ flush_count total_count))
        (print "total royal flush count" rf_flush_count (/ rf_flush_count total_count))
    )
)

(local suit-weirdness-table
    (fn []

        (local deck (Deck.create))
        (deck:shuffle2)
        (local hand (Hand.create deck))
        (print (hand:srepr))
        (local tmp (. hand.data 1))
        (print (tmp:srepr))
        (local tmp2 tmp.suit)
        (local tmp3 (. tmp suit)) ;; suit is not defined not going to work
        (local tmp4 (. tmp :suit)) ;; :suit is the field will work
        (print "suit is " tmp2 tmp3 tmp4)

    )
)

(test-flush)
;; (test-royal-flush)