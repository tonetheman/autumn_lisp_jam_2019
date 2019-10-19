(local Card {
    :create (fn [id]
        (local self {
            :id id
            :rank (% id 13)
            :suit (math.floor (/ id 13))
            :repr (fn []
                (local rankname (
                    match self.rank
                    0 "A"
                    1 "2"
                    2 "3"
                    3 "4"
                    4 "5"
                    5 "6"
                    6 "7"
                    7 "8"
                    8 "9"
                    9 "T"
                    10 "J"
                    11 "Q"
                    12 "K"
                ))
                (local suitname
                    (match self.suit
                    0 "D"
                    1 "H"
                    2 "C"
                    3 "S")
                )
                (print self.id rankname suitname)
            )
            :srepr (fn [self]
                            (local rankname (
                    match self.rank
                    0 "A"
                    1 "2"
                    2 "3"
                    3 "4"
                    4 "5"
                    5 "6"
                    6 "7"
                    7 "8"
                    8 "9"
                    9 "T"
                    10 "J"
                    11 "Q"
                    12 "K"
                ))
                (local suitname
                    (match self.suit
                    0 "D"
                    1 "H"
                    2 "C"
                    3 "S")
                )
                (local junk (.. rankname suitname))
                junk
            )
        })
        self
    )
})
Card