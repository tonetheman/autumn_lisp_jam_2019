

(local Hand {
        :create (fn [deck]
            (local self {
                ;; the deck you are using in this hand
                :deck deck

                ;; the cards you pulled
                :data {}
            
                :repr (fn [self]
                    (for [_ 0 4]
                        (local tmp (. self.data _))
                        (print (tmp:repr))
                    )
                )

            
            })




        
            ;; ctor stuff here
            (for [_ 0 4]
                (tset self.data _ (deck:pop))
            )

            ;; return self
            self
        ) ;; end of create
    } ;; end of hand

)


Hand