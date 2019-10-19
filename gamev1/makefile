
naml:
	rm -f naml.fnl
	cat card.fnl > naml.fnl
	cat deck.fnl >> naml.fnl
	cat hand.fnl >> naml.fnl
	cat pokerscore.fnl >> naml.fnl
	cat scenemanager.fnl >> naml.fnl
	cat loadingscene.fnl >> naml.fnl
	cat gamescene.fnl >> naml.fnl
	cat game.fnl >> naml.fnl
	fennel --compile naml.fnl > naml.lua
	tic80 crud.tic  -code-watch naml.lua

launch:
	tic80 crud.tic  -code-watch naml.lua


