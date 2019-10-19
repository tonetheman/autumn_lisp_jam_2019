# autumn lisp 2019 game jam

https://itch.io/jam/autumn-lisp-game-jam-2019

My itch.io page for this game is here: https://tonetheman.itch.io/lisp-video-poker

Source is found in src directory.

There are a lot of step directories which are intermediate work along the way to get to my source.

## dependencies
You need fennel. https://fennel-lang.org

You need tic80. https://tic.computer/

You also need to have make.

## how to build and run

This will concat all the fnl files into naml.fnl and then run the fennel compiler to make the file naml.lua.

Then tic80 will be run for the final step.

cd src
make naml

## other notes on building/running

The file crud.tic is a tic80 cart that has all of the graphics in it.

## to export and make a browser playable version
cd src
make naml

Then inside of tic80 hit escape and type export
You will need to pick a filename and tic80 will export the cart to a html file. I usually name the file index.html but you can name it whatever you want.

