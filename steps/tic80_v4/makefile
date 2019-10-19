all : main.fnl gamescene.fnl loadingscene.fnl
	rm -f *.lua
	fennel --compile scenemanager.fnl > scenemanager.lua
	fennel --compile gamescene.fnl > gamescene.lua
	fennel --compile loadingscene.fnl > loadingscene.lua
	fennel --compile main.fnl > main.lua

