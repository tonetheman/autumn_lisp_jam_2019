

(local Hand {
        :create (fn [deck]
            (local self {
                ;; the deck you are using in this hand
                :deck deck

                ;; the cards you pulled
                :data {}
                :discarddata {}

                :shallow-copy (fn [self]
                    (local _ {
                        :data {}
                    })
                    (for [i 1 5]
                        (tset _.data i (self:get i))
                    )
                    _
                )

                :get (fn [self i]
                    ( . self.data i)
                )
                
                :get-discard (fn [self i]
                    (. self.discarddata i)
                )
                
                :set (fn [self i value]
                    (tset self.data i value)
                )

                :set-discard (fn [self i value]
                    (tset self.discarddata i value)
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
            

                :reset-discard (fn [self]
                    (for [_ 1 5]
                        ;; we are discarding no cards
                        (self:set-discard _ false)
                    )
                )

                :deal (fn [self]
                    ;; needed 1 to 5 for stupid sort
                    (for [_ 1 5]
                        (self:set _ (deck:pop))
                    )
                    ;; when we deal we need to reset discard data
                    (self:reset-discard)
                )

                :redeal (fn [self]
                    (for [_ 1 5]
                        (if (self:get-discard _)
                            (do
                                ;; this is a discard
                                ;; get a new card now
                                (self:set _ (deck:pop))
                                ;; mark as not discarded
                                (self:set-discard _ false)
                            )
                        )
                    )
                )
                
            })




        

            ;; return self
            self
        ) ;; end of create
    } ;; end of hand

)

