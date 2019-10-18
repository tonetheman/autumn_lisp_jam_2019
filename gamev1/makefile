
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
