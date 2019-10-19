
all: game.fnl
	fennel --compile hand.fnl > hand.lua
	fennel --compile deck.fnl > deck.lua
	fennel --compile card.fnl > card.lua
	fennel --compile pokerscore.fnl > pokerscore.lua
	fennel --compile scenemanager.fnl > scenemanager.lua
	fennel --compile loadingscene.fnl > loadingscene.lua
	fennel --compile gamescene.fnl > gamescene.lua
	fennel --compile game.fnl > game.lua
	tic80 crud.tic  -code-watch game.lua


launch:
	tic80 crud.tic  -code-watch game.lua


amal:
	tic80 crud.tic  -code-watch amal.lua

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