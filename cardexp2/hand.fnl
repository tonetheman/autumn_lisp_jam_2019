

(local Hand {
        :create (fn [deck]
            (local self {
                ;; the deck you are using in this hand
                :deck deck

                ;; the cards you pulled
                :data {}
            
                ;; 1 to 5 see below for note
                :repr (fn [self]
                    (for [_ 1 5]
                        (local tmp (. self.data _))
                        (print (tmp:repr))
                    )
                )

                ;; 1 to 5 see below for note
                :srepr (fn [self]
                    (local ts "")
                    (for [_ 1 5]
                        (local tmp (. self.data _))
                        (.. ts (tmp:srepr))
                    )
                    ts
                )
            
            })




        
            ;; ctor stuff here
            ;; needed 1 to 5 for stupid sort
            (for [_ 1 5]
                (tset self.data _ (deck:pop))
            )

            ;; return self
            self
        ) ;; end of create
    } ;; end of hand

)


Hand