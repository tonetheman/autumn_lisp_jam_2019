
;; simple version of a card
(local Foo { ;; local class Object
    :create (fn [id] ;; construct function
        (let [self { ;; return a table
            :id id   ;; keep the id passed
            :rank (% id 13) ;; computer the rank in place
            :suit (math.floor (/ id 13))
            :repr (fn [self] ;; method that will return a string repr
                (.. (tostring self.rank) "-" (tostring self.suit))
            )
        }]
        self ;; this returns from the let
            ;; thus from the create func too
        )
    )
})

(local COUNT 51) ;; number of cards in a deck
(local a {}) ;; local array to hold cards
(for [i 0 COUNT]
    (tset a i (Foo.create i)) ;; init the deck
)

;; print the array func
(local print-array (fn [a]
    (var ts "")
    (for [i 0 COUNT] ;; 
        (let [tmp (. a i)] ;; create a tmp to hold the value from the array
            (set ts (.. ts (tmp:repr) " ")) ;; print the string repr
        )
    )
    (print ts)
))

(print-array a)
(print "trying sort...")
(table.sort a (fn [a b]
    (< a.rank b.rank) ;; sort by rank of the card
))
(print "------------")
(print-array a)