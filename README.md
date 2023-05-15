# Simple Woodcutter

![screenshot](screenshot.gif)

This mod chops the whole tree if you are holding an axe.

The chopping process stops if:

- You are too far away from the target (40 blocks by default)
- You take the axe out of your hand
- Your axe is destroyed
- You are dead
- You are out of the game

## Features

- Super simple. Just ~15 lines of code (without translations, settings and
  privileges)!
- Compatible with any game or mod
- Works fine with huge trees (increase `max_distance` and `max_radius` if
  needed)
- Recognizes trees and tools by their group, so it does not require any
  configuration
- I you don't have the `lumberjack` permission (in multiplayer game), trees will
  be cut 100 times slower (you can change the default `delay` in settings)

## Latest update notes

Since version `1.2.0`, chopping trees is performed with a new, more accurate
algorithm that handles trees of all sizes and shapes! 🎉
