# Frogger
Implemented the popular arcade game Frogger using MIPS assembly. If you’re not familiar with this
game, you can try it out here (https://froggerclassic.appspot.com/).

Since we don't have access to physical computers with MIPS
processors (see MIPS guide here), we will test our implementation in a simulated environment within the MARS application, which simulates the bitmap 
display and keyboard input of a MIPS processor.

# How to Play Frogger
The goal of this game is to get a frog from the bottom of the screen to one of the
safe areas at the top. The game is presented in a top-down perspective where the
lower half of the play area is a road where cars and trucks move horizontally
across the screen (which you need to avoid). In the upper half of the play area is a
water area with floating turtles and logs that also travel horizontally across the
screen. Unlike the cars and trucks, the frog needs to jump on these to reach the
top of the screen.
If the frog collides with a vehicle at the bottom or falls into the water at the top, you
lose a life. The game ends when you lose three lives or when all five safe areas at
the top are filled.
# Game Controls
This game uses the WASD input keys to control the
frog through the play area:

● The "w" key makes the frog move up,

● The  "a" key makes the frog move to the left.

● The "s" key makes the frog move down,

● The  "d" key makes the frog move to the right.

This project will use the Keyboard and MMIO Simulator to take in these keyboard
inputs. In addition to the keys listed
above, it can also be helpful to have a
key such as "q" to start and restart
the game as needed.
When no key is pressed, the frog sits
at its current position on the screen. If
pressing a key moves the frog into a
vehicle in the lower half of the screen
or into the water in the upper half, the
frog is reset back to the safe row at
the bottom.
# Project Goals
The Frogger game will appear on the Bitmap Display in MARS (which you launch by
selecting it in the MARS menu: Tools → Bitmap Display). This bitmap display is meant to
simulate what would appear on a MIPS processor, given the assembly code.

#Bitmap Display
The bitmap display is a 2D array of
“units”, where each “unit” would be a
pixel on the MIPS processor. As you
can see from the image on the right,
this window allows you to specify
features of this display:

● The unit width and height is
like a zoom factor, indicating
how many pixels on the
bitmap display are used to
represent a single pixel on the
MIPS processor. In the image here, a single pixel on the MIPS processor would
appear as an 8x8 box of a single colour on the display window here.

● The display width and height in pixels specified the width and height of the box in
this bitmap display. The dimensions of computer screens can vary, so once you
specify the dimensions you would like to use, your code will calculate the positions
of the pixels to draw based on those dimensions.

● The "base address for display" indicates the location in memory that is used to
display pixels on the screen, in a pattern called row major order:
