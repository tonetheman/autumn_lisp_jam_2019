
(global IntroScene (require :introscene))

(local (W H) (values 240 136))
(var iscene nil)

(fn init []
	(do
		(math.randomseed (time))
		(set iscene (IntroScene.create))
	)
)

(fn update []
	(iscene:update)
)

(fn draw []
	(iscene:draw)
)

(fn mainloop []
	(update)
	(draw)

)

(init)
(global TIC mainloop)
