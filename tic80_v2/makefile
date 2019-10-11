all : main.fnl introscene.fnl
	rm -f main.lua
	fennel --compile introscene.fnl > introscene.lua
	fennel --compile main.fnl > main.lua

