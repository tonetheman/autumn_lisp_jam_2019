(local Card (require :card))
(local Deck (require :deck))

(math.randomseed (os.time))

(local d (Deck.create))
(d:shuffle)
(d:repr)
