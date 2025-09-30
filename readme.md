# ANNOYING OS

## What has been implemented so far?

### Visually
- Windows 11 default background
- taskbar
	- start button
	- search input line
	- more buttons (e.g. file explorer)
	- date and time
- desktop files:
	- recycle bin
	- "myFace"
	- files
- basic window layout
- color swap shader
### Functionally
- twice an hour a cuckoo clock sound will play
- right click on taskbar, wallpaper or icon = context menu
- taskbar buttons & icons are highlighted when hovering
- window:
	- closes with click on x button
	- moves with clicking left & right arrows
	- navigation through folders with mouse left click
- game master:
	- left click counter
	- 10 last keys pressed added to a list
- desktop icons detect left clicks and Game Master counts them
- left click & drag on desktop draws a selection rectangle
	- selection rectangle turns into a bubble that floats to the top of the screen
	- it can wrap around desktop icons and will then activate them
- left click on search icon = zoom to random zoom state
	- if zoom is more than 100%, screen can be scrolled by moving the cursor to the edge
- input into search bar & submit will spawn a popup
- if gamemaster list has the letters "c", "l", "i", "c", "k", hover over a taskbar button and press a key to activate it

## What is being worked on? Current problems and issues?
- Context menu doesn't place correctly when clicking item

## What are we planning to implement?
- Implementation finalized

## Credits
- Black Squirrel for the Mine Sweeper Sprites
- Piano sound effect by freesound_community from Pixabay
- Rotate woosh sound effect by floraphonic from Pixabay
- Cuckoo clock sound effect by DRAGON-STUDIO from Pixabay
- colorblind.gdshader adapted from "Replace Color" by edo0xff on godotshaders.com
- warp.gdshader adapted from "WARP" by nikita1212 / imjustnerdio on godotshaders.com
