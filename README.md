# Mine It All

This is a [Minetest](http://www.minetest.net) mod that recreates the functionality of the Minecraft mod Veinminer. It lets you mine full veins of connected blocks in one go.

### Installation

Download this mod, and install it into the appropriate `mods` directory for your installation of Minetest. The directory should be named `mine_it_all`, like this:

```
<minetest files directory>
 |-games
   |-<any subgames you have installed>
 |-mods
   |-<any other mods and modpacks you have installed>
   |-mine_it_all
     |-init.lua
     |-LICENSE.txt
     |-mineable_nodes.lua
     |-README.md
```

Then simply open Minetest and enable the Mine It All mod in your world settings.

### Using the Mod

Once the mod is installed and activated, simply mine an ore, a tree, or any other block configred in `mineable_nodes.lua` with an appropriate tool _while sneaking_. This will mine out the block and any connected blocks of the same type and any blocks of the same type connected to _those_ blocks, etc. "Connected" means any block immediately touching the block you mined (a 3x3x3 cube with the block you mined in the center).

You'll immediately get all drops and your tool will be worn down as if you'd manually mined them all, so you're not getting out of the convenience without penalty.

### Known Issues

There's one known issue right now. If you mine a large vein with a tool that has very little durability left, the entire vein will still be mined. I will eventually fix that by stopping the mining once the durability of the tool is gone. So, enjoy the free durability while it lasts.

### Future Ideas

Ideally, I'd like to add in additional penalty for mining full veins. I might end up adding a hunger mod as a dependency to Mine It All, then make the player more hungry after mining. That's what vein miner does in Minecraft.

### License

This is mod is released under the MIT License. See `LICENSE.txt`.

