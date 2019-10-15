

(local Hand {
        :create (fn [deck]
            (local self {
                ;; the deck you are using in this hand
                :deck deck

                ;; the cards you pulled
                :data {}
            
                :get (fn [self i]
                    ( . self.data i)
                )
                
                :set (fn [self i value]
                    (tset self.data i value)
                )
                
                ;; 1 to 5 see below for note
                :repr (fn [self]
                    (for [_ 1 5]
                        (local tmp (self:get _))
                        (print (tmp:repr))
                    )
                )

                ;; 1 to 5 see below for note
                :srepr (fn [self]
                    (var ts "")
                    (for [_ 1 5]
                        (local tmp (self:get _))
                        ;; (print (tmp:srepr))
                        (set ts (.. ts (tmp:srepr) " "))
                    )
                    ts
                )
            
            })




        
            ;; ctor stuff here
            ;; needed 1 to 5 for stupid sort
            (for [_ 1 5]
                (self:set _ (deck:pop))
            )

            ;; return self
            self
        ) ;; end of create
    } ;; end of hand

)


Hand