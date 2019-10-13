(local Card {
    :create (fn [id]
        (local self {
            :id id
            :rank (% id 13)
            :suit (math.floor (/ id 13))
            :repr (fn []
                (print self.id self.rank self.suit)
            )
        })
        self
    )
})
Card