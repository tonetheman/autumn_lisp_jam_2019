
(local (W H) (values 240 136))
(local player { :sprite 0 :x 0 :y 0})

(fn init []
  (math.randomseed (time))
)

(fn update []
	(if (btnp 3)
		(set player.x (+ player.x 8))
	)
	(if (btnp 2)
		(set player.x (- player.x 8))	
	)
	(if (btnp 0)
		(set player.y (- player.y 8))
	)
	(if (btnp 1)
		(set player.y (+ player.y 8))
	)
)

(fn draw []
	(cls 0)
	(spr player.sprite player.x player.y)
)

(fn mainloop []
	(update)
	(draw)

)

(init)
(global TIC mainloop)
