#!/bin/bash

rm -f *.lua

fennel --compile scenemanager.fnl > scenemanager.lua
fennel --compile test.fnl > test.lua

