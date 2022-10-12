#  Simple System stats gauges streamDeck plugin for BTT
The new BTT StreamDeck support and Plugin system are out! 
and I'm /shocked/ at the low numbers of plugins I've encountered!

Especially for this super simple purpose!
So I rolled my sleeves and got to work!

Now admittedly I'm not a MacOS developer but with some experience with Swift and Native development this was a breeze!

The way this whole thing works is by rendering a SwiftUI View into an Image and returning that to BTT (That's why I left the BasePlugin if anyone wants to experiment 😉)
It's a shame BTT doesn't accept SwiftUI Views natively (or even NSViews!) 

This was hacked together in an afternoon, so it's kinda awful looking (code wise) and may break 🤷‍
Also since I was lazy I used the new SwiftUI Gauge view, which is only available on MacOS From 13.0 (the new Ventura), Sorry!

## Example
![How it looks!](/README-IMAGES/example1.jpg?raw=true "How it looks!")

# Installation!
I tried to make this as simple as I could but without an Apple developer account I can't provide a pre-compiled notarized version 😞
So you'll have to compile yourselves!

## Step 0: Pre-Installation!
Please make sure that you have XCode installed and brew (google that 😅)

## Step 1: install dependencies
I use Carthage to handle this part,
You can install Carthage from brew
```bash
brew install carthage
```

from there all you need to do is
```bash
carthage update
```

## Step 2: Compile
This is the easy stage! just open the BetterSystemGauges.xcodeproj file and choose which plugin you what to compile
the default target ("BUILD_ALL") should make them all

## Step 3: Install
In XCode (assuming all went well 😅) you should see a Products folder in the sidebar
just choose any item from that folder that is not red, right click it and choose "Show in Finder"
from there copy all the files that have the BTT Icon (and end with .bttstreamdeckplugin) into 
```
/Library/Application Support/BetterTouchTool/Plugins/
```
You might have to create that folder!

Then just restart BTT and you should see those plugins appear when trying to add a new Stream Deck button (under a new fancy Plugin category!)

# Bugs!
There are a few bugs (ofc it's a hobby project XD):
1. The config won't refresh until you restart BTT (I'm not sure that it's my bug, BTT just forgets to update me when a change to the config happens 🙃)
2. When you set an action for this widget (something to happen when you press the button) unless you set it to trigger on button up, it won't happen (again Im not sure who's at fault here, plz hlp)
3. upon startup, sometimes the widget's won't refresh, I'm not sure why this happens. but updating any config should make everything work again

# Credits

BTT is an amazing piece of Software And I can't wait to see this whole Ecosystem grow

I also used [SystemKit](https://github.com/beltex/SystemKit) to avoid doing all the nasty kernel stuff 😛
However beltex version of SystemKit is super outdated, so I used the more updated [SystemKit](https://github.com/gao-sun/SystemKit) from gao-sun so thanks 👍

# Licence and Kofi
This is an as-is project! I would love to help anyone in need, and everything here is as free as I can make it! 
If this helped you in any way and you wanna throw some love maybe we can grab a [Kofi](https://Ko-fi.com/tht77) together?

XMR: 43sginAtKFh7Ln89t1MLFAEtp2dk2XckbdYbfkgW96a5MgLvFAgmRFbJhU57p96hgu1wYtFtcv3W9XfGsATtGnVHLnc83zx
