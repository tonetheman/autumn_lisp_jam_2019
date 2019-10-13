all : card.fnl test.fnl
	fennel --compile card.fnl > card.lua
	fennel --compile deck.fnl > deck.lua
	fennel --compile hand.fnl > hand.lua
	fennel --compile test.fnl > test.lua
	lua test.lua
