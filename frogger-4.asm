#####################################################################
#
# CSC258H5S Winter 2022 Assembly Final Project
# University of Toronto, St. George
#
# Student: Jian Yun Zhuang, 1006994781
#
# Bitmap Display Configuration:
# - Unit width in pixels: 8
# - Unit height in pixels: 8
# - Display width in pixels: 256
# - Display height in pixels: 256
# - Base Address for Display: 0x10008000 ($gp)
#
# Which milestone is reached in this submission? 
# (See the assignment handout for descriptions of the milestones)
# - Milestone 3 (choose the one the applies) 
#
# Which approved additional features have been implemented?
# (See the assignment handout for the list of additional features)
# 1. Restart screen after loose
# 2. Display the number of lives remaining.
# 3. hard-feature: sink logs, and reappear logs randomaly (first row of logs)
# 4. hard-feature: picking up life booster
# 5. randomlize size of cars and logs
# Any additional information that the TA needs to know:
# - (write here, if any)
#
#####################################################################

# Demo for painting
#
# Bitmap Display Configuration:
# - Unit width in pixels: 8
# - Unit height in pixels: 8
# - Display width in pixels: 256
# - Display height in pixels: 256
# - Base Address for Display: 0x10008000 ($gp)

li $v0, 42
li $a0, 0
li $a1, 14
syscall


.data
displayAddress: .word 0x10008000
Frog_x: .word 56
Frog_y: .word 28
life: .word 3
spped: .word 0

count: .word 112
Max_1: .word 124
Car_x1: .word 0
Car_y1: .word 20
Car_1: .word 0
Scar_1: .word 0


Car_x2: .word 64
Car_y2: .word 20
Car_2: .word 64
Scar_2: .word 0

Car_x3: .word 32
Car_y3: .word 24
Car_3: .word 96
Scar_3: .word 0

Car_x4: .word 96
Car_y4: .word 24
Car_4: .word 32
Scar_4: .word 0

Boa_x1: .word 32
Boa_y1: .word 8 
Boa_1: .word 32 
Sboa_1: .word 0

Boa_x2: .word 96
Boa_y2: .word 8
Boa_2: .word 96
Sboa_2: .word 0

Boa_x3: .word 64 
Boa_y3: .word 12
Boa_3: .word 64
Sboa_3: .word 0

Boa_x4: .word 0
Boa_y4: .word 12
Boa_4: .word 128
Sboa_4: .word 0


powerup_x:.word 0
powerup_y:.word 0
powerup_e: .word 1



.text
S_size:
li $v0, 42
li $a0, 0
li $a1, 10
syscall
la $t7, Scar_1
lw $t8, 0($t7)
addi $t8, $a0, 0 #randomlized the cars 
sw $t8, 0($t7)

li $v0, 42
li $a0, 0
li $a1, 10
syscall
la $t7, Scar_2
lw $t8, 0($t7)
addi $t8, $a0, 0  #randomlized the cars 
sw $t8, 0($t7)

li $v0, 42
li $a0, 0
li $a1, 10
syscall
la $t7, Scar_3
lw $t8, 0($t7)
addi $t8, $a0, 0 #randomlized the cars 
sw $t8, 0($t7)

li $v0, 42
li $a0, 0
li $a1, 10
syscall
la $t7, Sboa_1
lw $t8, 0($t7)
addi $t8, $a0, 0 #randomlized the cars 
sw $t8, 0($t7)


li $v0, 42
li $a0, 0
li $a1, 10
syscall
la $t7, Sboa_2
lw $t8, 0($t7)
addi $t8, $a0, 0 #randomlized the cars 
sw $t8, 0($t7)

li $v0, 42
li $a0, 0
li $a1, 10
syscall
la $t7, Sboa_3
lw $t8, 0($t7)
addi $t8, $a0, 0 #randomlized the cars 
sw $t8, 0($t7)

li $v0, 42
li $a0, 0
li $a1, 10
syscall
la $t7, Sboa_4
lw $t8, 0($t7)
addi $t8, $a0, 0 #randomlized the cars 
sw $t8, 0($t7)

li $v0, 42
li $a0, 0
li $a1, 14
syscall
la $t7, Scar_4
lw $t8, 0($t7)
addi $t8, $a0, 0 #randomlized the cars 
sw $t8, 0($t7)


li $v0, 42
li $a0, 8
li $a1, 60
syscall
la $t7, powerup_x
lw $t8, 0($t7)
addi $t8, $a0, 0 #randomlized the powerup_x 
addi $t3, $zero, 4
div $t8, $t3
mfhi $t8
sll $t8,$t8 2
addi $t8, $t8, 40
sw $t8, 0($t7)


li $v0, 42
li $a0, 0
li $a1, 8
syscall

la $t7, powerup_y
lw $t8, 0($t7)
addi $t8, $a0, 20 #randomlized the powerup_y 
sw $t8, 0($t7)

j Exit

First:
lw $k0, 0xffff0000
beq $k0, 1, keyboard_input


lw $t0, displayAddress # $t0 stores the base address for display
li $a1, 0xa993ad # purple
li $a2, 0x9EC292 # green
li $a3, 0xAD5A07  # brown
li $s1, 0xF4EA78 # yellow
li $s2, 0xBDBFAE # grey

li $s5, 0xEFC1DD # Pink
li $s4, 0xA5D0CF # blue
li $s3, 0xFF5F5C # red

li $s6, 0x9EC293 # gree
li $s7, 0xFFFF04 # power

#sw $a3, 128($t0) # paint the first unit on the second row blue. Why +128?

addi $t1, $t0, 1024

Goal:
sw $s6, 0($t0)
addi $t0, $t0, 4
beq $t0, $t1, Water_S

j Goal

Water_S:
addi $t1, $t0, 1024
Water:
sw $a3, 0($t0)
addi $t0, $t0, 4
beq $t0, $t1, Safe_S
j Water


Safe_S:
addi $t1, $t0, 512
Safe:
sw $s1, 0($t0)
addi $t0, $t0, 4
beq $t0, $t1, Road_S
j Safe


Road_S:
addi $t1, $t0, 1024
Road:
sw $s2, 0($t0)
addi $t0, $t0, 4
beq $t0, $t1, Start_S
j Road

Start_S:
addi $t1, $t0, 512
Start:
sw $a2, 0($t0)
addi $t0, $t0, 4
beq $t0, $t1, Frog_S
j Start

#Painting background done
#----------------------------------------------

#Painting Frog

#Setting frog_x to t8 and frog_y to t9
Frog_S:

la $t7, powerup_e
lw $t8, 0($t7)
beq $t8, 0, Frog_SS


lw $t0, displayAddress
la $t7, powerup_x
lw $t8, 0($t7)
la $t7, powerup_y
lw $t9, 0($t7)
sll $t9, $t9, 7
add $t0, $t0, $t9
add $t0, $t0, $t8
sw $s7, 0($t0)

Frog_SS:
lw $t0, displayAddress
la $t7, Frog_x
lw $t8, 0($t7)
la $t7, Frog_y
lw $t9, 0($t7)
sll $t9, $t9, 7
add $t0, $t0, $t9
add $t0, $t0, $t8



Frog:

#t2 < t8 < t2+28
#t3 < t9 < t3+16
lw $t5, 0($t0)
beq $t5, 0x9EC293, finish
sw $s5, 0($t0)
addi $t0, $t0, 12
sw $s5, 0($t0)
addi $t0, $t0, 116
sw $s5, 0($t0)
addi $t0, $t0, 4
sw $s5, 0($t0)
addi $t0, $t0, 4
sw $s5, 0($t0)
addi $t0, $t0, 4
sw $s5, 0($t0)
addi $t0, $t0, 120
sw $s5, 0($t0)
addi $t0, $t0, 4
sw $s5, 0($t0)
addi $t0, $t0, 120
sw $s5, 0($t0)
addi $t0, $t0, 4
sw $s5, 0($t0)
addi $t0, $t0, 4
sw $s5, 0($t0)
addi $t0, $t0, 4
sw $s5, 0($t0)

#Frog Finished
#------------------------------------------

#Car
Car_S1:
lw $t0, displayAddress
la $t7, Car_x1
lw $t8, 0($t7)
la $t7, Car_y1
lw $t9, 0($t7)
sll $t9, $t9, 7
add $t0, $t0, $t9
add $t0, $t0, $t8	#get the location to t0

la $t7, Car_1
lw $t8, 0($t7)
la $t7, Max_1
lw $t9, 0($t7)
bgt $t8, $t9, Move_C2

#Update Car1_x axis, so it could move
Move_C1:
la $t7, Car_x1
lw $t8, 0($t7)
addi $t8, $t8, 4 #increment x value, so it could move next time when it gets here
addi $t1, $zero, 124
sw $t8, 0($t7)

la $t7, Car_1
lw $t8, 0($t7)
addi $t8, $t8, 4 #increment car1 value, to keep track of how many units it moved
sw $t8, 0($t7)
j Check_C1

#Run this if the car is at the edge
Move_C2:
la $t7, Car_x1
lw $t8, 0($t7)
addi $t8, $zero, 0 #reset x value, so it could move next time when it gets here
sw $t8, 0($t7)

la $t7, Car_1
lw $t8, 0($t7)
addi $t8, $zero, 0 #increment car1 value, to keep track of how many units it moved
sw $t8, 0($t7)

Check_C1:
addi $t3, $zero, 0 #set t4, to check if car runned for second time
addi $t4, $zero, 1 #set t4, to check if car runned for second time
addi $t5, $zero, 2 #set t4, to check if car runned for thir time
addi $s6, $zero, 3 #set t4, to check if car runned for fouth time

la $t7, Car_y1
lw $t6, 0($t7)
sll $t6, $t6, 7

la $t7, Scar_1
lw $t2, 0($t7)



Car:

addi $t1, $t6, 124
addi $t1, $t1, 0x10008000

addi $t8, $zero, 0 #set a count, to make 8 columns of pixels
#addi $s0, $zero, 268471292


Car_p:

beq $t8, $t2, Next
bgt $t0, $t1, rect_spe

sw $s3, 0($t0) #Make a 2 pixel column
sw $s3, 128($t0)
sw $s3, 256($t0)
sw $s3, 384($t0)
addi $t0, $t0, 4

addi $t8, $t8, 1 #increment count, to make 8 columns of pixels

j Car_p

rect_spe:
beq $t8, $t2, Next

addi $t0, $t0, -128
sw $s3, 0($t0) #Make a 2 pixel column
sw $s3, 128($t0)
sw $s3, 256($t0)
sw $s3, 384($t0)
addi $t8, $t8, 1 #increment count, to make 8 columns of pixels
j Car_p


C_Car_2:

addi $t1, $t6, 124
addi $t1, $t1, 0x10008000

addi $t2, $zero, 8
addi $t8, $zero, 1 #set a count, to make 8 columns of pixels
addi $s0, $zero, 268471292


Car_p2:

beq $t8, $t2, Next

sw $s3, 0($t0) #Make a 2 pixel column
sw $s3, 128($t0)
sw $s3, 256($t0)
sw $s3, 384($t0)
addi $t0, $t0, 4

addi $t8, $t8, 1 #increment count, to make 8 columns of pixels

j Car_p2

#rect_spe2:
#beq $t8, $t2, Next

#addi $t0, $t0, 128
#addi $t8, $t8, 1 #increment count, to make 8 columns of pixels
#j Car_p

Next:
beq $t3, $t4, Car_S3 #Meaning that we already made two cars
beq $t3, $t5, Car_S4 #Meaning that we already made three cars
beq $t3, $s6, Boa_S1   #Meaning that we already made four cars


Car_S2:
addi $t3, $zero, 0
lw $t0, displayAddress
la $t7, Car_x2
lw $t8, 0($t7)
la $t7, Car_y2
lw $t9, 0($t7)
sll $t9, $t9, 7
add $t0, $t0, $t9
add $t0, $t0, $t8

la $t7, Car_2
lw $t8, 0($t7)
la $t7, Max_1
lw $t9, 0($t7)
bgt $t8, $t9, Move_C2_2

#Update Car1_x axis, so it could move
Move_C1_2:
la $t7, Car_x2
lw $t8, 0($t7)
addi $t8, $t8, 4 #increment x value, so it could move next time when it gets here
sw $t8, 0($t7)

la $t7, Car_2
lw $t8, 0($t7)
addi $t8, $t8, 4 #increment car1 value, to keep track of how many units it moved
sw $t8, 0($t7)
j Check_C2

#Run this if the car is at the edge
Move_C2_2:
la $t7, Car_x2
lw $t8, 0($t7)
addi $t8, $zero, 0 #reset x value, so it could move next time when it gets here
sw $t8, 0($t7)

la $t7, Car_2
lw $t8, 0($t7)
addi $t8, $zero, 0 #increment car1 value, to keep track of how many units it moved
sw $t8, 0($t7)

Check_C2:

addi $t3, $zero, 1 #use t3=1 to check if we are running the car for the second time


la $t7, Car_y2
lw $t6, 0($t7)
sll $t6, $t6, 7


la $t7, Scar_2
lw $t2, 0($t7)

j Car

Car_S3:

addi $t3, $zero, 0
lw $t0, displayAddress
la $t7, Car_x3
lw $t8, 0($t7)
la $t7, Car_y3
lw $t9, 0($t7)
sll $t9, $t9, 7
add $t0, $t0, $t9
add $t0, $t0, $t8

la $t7, Car_3
lw $t8, 0($t7)
la $t7, Max_1
lw $t9, 0($t7)
bgt $t8, $t9, Move_C2_3

#Update Car1_x axis, so it could move
Move_C1_3:
la $t7, Car_x3
lw $t8, 0($t7)
addi $t8, $t8, -4 #increment x value, so it could move next time when it gets here
sw $t8, 0($t7)

la $t7, Car_3
lw $t8, 0($t7)
addi $t8, $t8, 4 #increment car1 value, to keep track of how many units it moved
sw $t8, 0($t7)
j Check_C3

#Run this if the car is at the edge
Move_C2_3:
la $t7, Car_x3
lw $t8, 0($t7)
addi $t8, $t8, 128 #reset x value, so it could move next time when it gets here
sw $t8, 0($t7)

la $t7, Car_3
lw $t8, 0($t7)
addi $t8, $zero, 0 #increment car1 value, to keep track of how many units it moved
sw $t8, 0($t7)

Check_C3:


addi $t3, $zero, 2 #use t3=2 to check if we are running the car for the third time


la $t7, Car_y3
lw $t6, 0($t7)
sll $t6, $t6, 7

la $t7, Scar_3
lw $t2, 0($t7)

j Car

Car_S4:
addi $t3, $zero, 0
lw $t0, displayAddress
la $t7, Car_x4
lw $t8, 0($t7)
la $t7, Car_y4
lw $t9, 0($t7)
sll $t9, $t9, 7
add $t0, $t0, $t9
add $t0, $t0, $t8

la $t7, Car_4
lw $t8, 0($t7)
la $t7, Max_1
lw $t9, 0($t7)
bgt $t8, $t9, Move_C2_4

#Update Car1_x axis, so it could move
Move_C1_4:
la $t7, Car_x4
lw $t8, 0($t7)
addi $t8, $t8, -4 #increment x value, so it could move next time when it gets here
sw $t8, 0($t7)

la $t7, Car_4
lw $t8, 0($t7)
addi $t8, $t8, 4 #increment car1 value, to keep track of how many units it moved
sw $t8, 0($t7)


j Check_C4

#Run this if the car is at the edge
Move_C2_4:
la $t7, Car_x4
lw $t8, 0($t7)
addi $t8, $t8, 128 #reset x value, so it could move next time when it gets here
sw $t8, 0($t7)

la $t7, Car_4
lw $t8, 0($t7)
addi $t8, $zero, 0 #increment car1 value, to keep track of how many units it moved
sw $t8, 0($t7)

Check_C4:
addi $t3, $zero, 3 #use t3=3 to check if we are running the car for the last time

la $t7, Car_y4
lw $t6, 0($t7)
sll $t6, $t6, 7
la $t7, Scar_4
lw $t2, 0($t7)


j Car


Boa_S1:
lw $t0, displayAddress
la $t7, Boa_x1
lw $t8, 0($t7)
la $t7, Boa_y1
lw $t9, 0($t7)
sll $t9, $t9, 7
add $t0, $t0, $t9
add $t0, $t0, $t8	#get the location to t0

la $t7, Boa_1
lw $t8, 0($t7)
la $t7, Max_1
lw $t9, 0($t7)
bgt $t8, $t9, Move_B2 #If at edge

#Update Boat1_x axis, so it could move
Move_B1:
la $t7, Boa_x1
lw $t8, 0($t7)
addi $t8, $t8, 4 #increment x value, so it could move next time when it gets here
addi $t1, $zero, 124
sw $t8, 0($t7)

la $t7, Boa_1
lw $t8, 0($t7)
addi $t8, $t8, 4 #increment car1 value, to keep track of how many units it moved
sw $t8, 0($t7)
j Check_B1

#Run this if the car is at the edge
Move_B2:
la $t7, Boa_x1
lw $t8, 0($t7)
addi $t8, $zero, 0 #reset x value, so it could move next time when it gets here
sw $t8, 0($t7)

la $t7, Boa_1
lw $t8, 0($t7)
addi $t8, $zero, 0 #increment Boa1 value, to keep track of how many units it moved
sw $t8, 0($t7)

Check_B1:
addi $t3, $zero, 0 #set t4, to check if car runned for second time
addi $t4, $zero, 1 #set t4, to check if car runned for second time
addi $t5, $zero, 2 #set t4, to check if car runned for thir time
addi $s6, $zero, 3 #set t4, to check if car runned for fouth time

la $t7, Boa_y1
lw $t6, 0($t7)
sll $t6, $t6, 7


Boat:

addi $t1, $t6, 124
addi $t1, $t1, 0x10008000

addi $t2, $zero, 8
addi $t8, $zero, 1 #set a count, to make 8 columns of pixels



boat_p:

beq $t8, $t2, Boa_Next
bgt $t0, $t1, boat_spe

sw $s4, 0($t0) #Make a 2 pixel column
sw $s4, 128($t0)
sw $s4, 256($t0)
sw $s4, 384($t0)
addi $t0, $t0, 4

addi $t8, $t8, 1 #increment count, to make 8 columns of pixels

j boat_p

boat_spe:
beq $t8, $t2, Boa_Next

addi $t0, $t0, -128
sw $s4, 0($t0) #Make a 2 pixel column
sw $s4, 128($t0)
sw $s4, 256($t0)
sw $s4, 384($t0)
addi $t8, $t8, 1 #increment count, to make 8 columns of pixels
j boat_p


C_boat_2:

addi $t1, $t6, 124
addi $t1, $t1, 0x10008000

addi $t2, $zero, 8
addi $t8, $zero, 1 #set a count, to make 8 columns of pixels
addi $s0, $zero, 268471292


boat_p2:

beq $t8, $t2, Next

sw $s3, 0($t0) #Make a 2 pixel column
sw $s3, 128($t0)
sw $s3, 256($t0)
sw $s3, 384($t0)
addi $t0, $t0, 4

addi $t8, $t8, 1 #increment count, to make 8 columns of pixels

j boat_p2

#rect_spe2:
#beq $t8, $t2, Next

#addi $t0, $t0, 128
#addi $t8, $t8, 1 #increment count, to make 8 columns of pixels
#j Car_p




Boa_Next:
beq $t3, $t4, Boa_S3 #Meaning that we already made two cars
beq $t3, $t5, Boa_S4 #Meaning that we already made three cars
beq $t3, $s6, Exit   #Meaning that we already made four cars

Boa_S2:
addi $t3, $zero, 0
lw $t0, displayAddress
la $t7, Boa_x2
lw $t8, 0($t7)
la $t7, Boa_y2
lw $t9, 0($t7)
sll $t9, $t9, 7
add $t0, $t0, $t9
add $t0, $t0, $t8

la $t7, Boa_2
lw $t8, 0($t7)
la $t7, Max_1
lw $t9, 0($t7)
bgt $t8, $t9, Move_B2_2

#Update Car1_x axis, so it could move
Move_B1_2:
la $t7, Boa_x2
lw $t8, 0($t7)
addi $t8, $t8, 8 #increment x value, so it could move next time when it gets here
sw $t8, 0($t7)

la $t7, Boa_2
lw $t8, 0($t7)
addi $t8, $t8, 8 #increment car1 value, to keep track of how many units it moved
sw $t8, 0($t7)
j Check_B2

#Run this if the car is at the edge
Move_B2_2:
la $t7, Boa_x2
lw $t8, 0($t7)
addi $t8, $zero, 0 #reset x value, so it could move next time when it gets here
sw $t8, 0($t7)

la $t7, Boa_2
lw $t8, 0($t7)
addi $t8, $zero, 0 #increment car1 value, to keep track of how many units it moved
sw $t8, 0($t7)

Check_B2:

addi $t3, $zero, 1 #use t3=1 to check if we are running the car for the second time


la $t7, Boa_y2
lw $t6, 0($t7)
sll $t6, $t6, 7
j Boat

Boa_S3:
addi $t3, $zero, 0
lw $t0, displayAddress
la $t7, Boa_x3
lw $t8, 0($t7)
la $t7, Boa_y3
lw $t9, 0($t7)
sll $t9, $t9, 7
add $t0, $t0, $t9
add $t0, $t0, $t8

la $t7, Boa_3
lw $t8, 0($t7)
la $t7, Max_1
lw $t9, 0($t7)
bgt $t8, $t9, Move_B2_3

#Update Car1_x axis, so it could move
Move_B1_3:
la $t7, Boa_x3
lw $t8, 0($t7)
addi $t8, $t8, -4 #increment x value, so it could move next time when it gets here
sw $t8, 0($t7)

la $t7, Boa_3
lw $t8, 0($t7)
addi $t8, $t8, 4 #increment car1 value, to keep track of how many units it moved
sw $t8, 0($t7)
j Check_B3

#Run this if the car is at the edge
Move_B2_3:
la $t7, Boa_x3
lw $t8, 0($t7)
addi $t8, $t8, 128 #reset x value, so it could move next time when it gets here
sw $t8, 0($t7)

la $t7, Boa_3
lw $t8, 0($t7)
addi $t8, $zero, 0 #increment car1 value, to keep track of how many units it moved
sw $t8, 0($t7)

Check_B3:


addi $t3, $zero, 2 #use t3=2 to check if we are running the car for the third time


la $t7, Boa_y3
lw $t6, 0($t7)
sll $t6, $t6, 7
j Boat

Boa_S4:
addi $t3, $zero, 0
lw $t0, displayAddress
la $t7, Boa_x4
lw $t8, 0($t7)
la $t7, Boa_y4
lw $t9, 0($t7)
sll $t9, $t9, 7
add $t0, $t0, $t9
add $t0, $t0, $t8

la $t7, Boa_4
lw $t8, 0($t7)
la $t7, Max_1
lw $t9, 0($t7)
bgt $t8, $t9, Move_B2_4

#Update Car1_x axis, so it could move
Move_B1_4:
la $t7, Boa_x4
lw $t8, 0($t7)
addi $t8, $t8, -4 #increment x value, so it could move next time when it gets here
sw $t8, 0($t7)

la $t7, Boa_4
lw $t8, 0($t7)
addi $t8, $t8, 4 #increment car1 value, to keep track of how many units it moved
sw $t8, 0($t7)

j Check_B4

#Run this if the car is at the edge
Move_B2_4:
la $t7, Boa_x4
lw $t8, 0($t7)
addi $t8, $t8, 128 #reset x value, so it could move next time when it gets here
sw $t8, 0($t7)

la $t7, Boa_4
lw $t8, 0($t7)
addi $t8, $zero, 0 #increment car1 value, to keep track of how many units it moved
sw $t8, 0($t7)

Check_B4:
addi $t3, $zero, 3 #use t3=3 to check if we are running the car for the last time

la $t7, Boa_y4
lw $t6, 0($t7)
sll $t6, $t6, 7


j Boat



keyboard_input:
lw $t2, 0xffff0004
beq $t2, 0x61, respond_to_A
beq $t2, 0x64, respond_to_d
beq $t2, 0x77, respond_to_w
beq $t2, 0x73, respond_to_s
beq $t2, 0x72, respond_to_r
j Exit

restart:
la $t7, Frog_x
lw $t8, 0($t7)
addi $t8, $zero, 56 #reset frog_x
sw $t8, 0($t7)

la $t7, Frog_y
lw $t8, 0($t7)
addi $t8, $zero, 28 #reset frog_y
sw $t8, 0($t7)

la $t7, life
lw $t8, 0($t7)
addi $t8, $t8, -1 #reset frog_y
sw $t8, 0($t7)

ble $t8, $zero, loose

j S_size

respond_to_A:
la $t7, Frog_x
lw $t8, 0($t7)
addi $t8, $t8, -4 #increment x value, so it could move next time when it gets here
sw $t8, 0($t7)
j Exit

respond_to_d:
la $t7, Frog_x
lw $t8, 0($t7)
addi $t8, $t8, 4 #increment x value, so it could move next time when it gets here
sw $t8, 0($t7)
j Exit

respond_to_w:
la $t7, Frog_y
lw $t8, 0($t7)
addi $t8, $t8, -4 #increment x value, so it could move next time when it gets here
sw $t8, 0($t7)
j Exit

respond_to_s:
la $t7, Frog_y
lw $t8, 0($t7)
addi $t8, $t8, 4 #increment x value, so it could move next time when it gets here
sw $t8, 0($t7)
j Exit

respond_to_r:
la $t7, Frog_x
lw $t8, 0($t7)
addi $t8, $zero, 56 #reset frog_x
sw $t8, 0($t7)

la $t7, Frog_y
lw $t8, 0($t7)
addi $t8, $zero, 28 #reset frog_y
sw $t8, 0($t7)

la $t7, life
lw $t8, 0($t7)
addi $t8, $zero, 3 #reset frog_y
sw $t8, 0($t7)

j Exit

Exit:

life_s:
lw $t0, displayAddress
addi $t0, $t0, 132
addi $t1, $zero, 0

la $t7, life
lw $t8, 0($t7)
ble $t8, $zero, loose




p_life:
ble $t8, $zero, loose
sw $s1, 0($t0)
addi $t0, $t0, 8
addi $t1, $t1, 1
beq $t1, $t8, cont
j p_life

cont:
lw $t0, displayAddress
la $t7, Frog_x
lw $t8, 0($t7)
la $t7, Frog_y
lw $t9, 0($t7)
sll $t9, $t9, 7
add $t0, $t0, $t9
add $t0, $t0, $t8

lw $t5, 0($t0)
beq $t5, 0xFF5F5C, restart
beq $t5, 0xA5D0CF, restart
beq $t5, 0xFFFF04, boost

lw $t5, 4($t0)
beq $t5, 0xFF5F5C, restart
beq $t5, 0xA5D0CF, restart
beq $t5, 0x9EC293, finish
beq $t5, 0xFFFF04, boost

lw $t5, 8($t0)
beq $t5, 0xFF5F5C, restart
beq $t5, 0xA5D0CF, restart
beq $t5, 0x9EC293, finish
beq $t5, 0xFFFF04, boost

lw $t5, 12($t0)
beq $t5, 0xFF5F5C, restart
beq $t5, 0xA5D0CF, restart
beq $t5, 0x9EC293, finish
beq $t5, 0xFFFF04, boost

lw $t5, 16($t0)
beq $t5, 0xFF5F5C, restart
beq $t5, 0xA5D0CF, loose
beq $t5, 0x9EC293, finish
beq $t5, 0xFFFF04, boost

lw $t5, 128($t0)
beq $t5, 0xFF5F5C, restart
beq $t5, 0xA5D0CF, restart
beq $t5, 0x9EC293, finish
beq $t5, 0xFFFF04, boost

lw $t5, 256($t0)
beq $t5, 0xFF5F5C, restart
beq $t5, 0xA5D0CF, restart
beq $t5, 0x9EC293, finish
beq $t5, 0xFFFF04, boost

lw $t5, 384($t0)
beq $t5, 0xFF5F5C, restart
beq $t5, 0xA5D0CF, restart
beq $t5, 0x9EC293, finish
beq $t5, 0xFFFF04, boost

li $v0, 32
li $a0, 600

lw $k0, 0xffff0000
beq $k0, 1, keyboard_input

syscall


j First

finish:
sw $s5, 0($t0)
addi $t0, $t0, 12
sw $s5, 0($t0)
addi $t0, $t0, 120
addi $t0, $t0, 128
sw $s5, 0($t0)
addi $t0, $t0, 4
sw $s5, 0($t0)
addi $t0, $t0, 120
sw $s5, 0($t0)
addi $t0, $t0, 4
sw $s5, 0($t0)
addi $t0, $t0, 4
sw $s5, 0($t0)
addi $t0, $t0, 4
sw $s5, 0($t0)

j Car_S1

loose:

lw $t1, displayAddress
addi $t0,$zero, 132



# "T"
T:
add $t0, $t0, $t1
li $t4, 0xffffff
sw $t4,0($t0)
sw $t4,4($t0)
sw $t4,8($t0)
sw $t4,12($t0)
sw $t4,16($t0)
sw $t4,136($t0)
sw $t4,264($t0)
sw $t4,392($t0)
sw $t4,520($t0)

addi $t0,$t0, 24
# "T"
y:
li $t4, 0xffffff
sw $t4,0($t0)
sw $t4,132($t0)
sw $t4,264($t0)
sw $t4,16($t0)
sw $t4,140($t0)
sw $t4,140($t0)
sw $t4,392($t0)
sw $t4,520($t0)

addi $t0,$t0, 24

p:
li $t4, 0xffffff
sw $t4,0($t0)
sw $t4,4($t0)
sw $t4,8($t0)
sw $t4,140($t0)
sw $t4,264($t0)

sw $t4,260($t0)
sw $t4,384($t0)
sw $t4,512($t0)
sw $t4,256($t0)
sw $t4,128($t0)

addi $t0,$t0, 24

E:
li $t4, 0xffffff
sw $t4,0($t0)
sw $t4,4($t0)
sw $t4,8($t0)
sw $t4,12($t0)
sw $t4,128($t0)
sw $t4,256($t0)
sw $t4,260($t0)
sw $t4,264($t0)
sw $t4,384($t0)
sw $t4,512($t0)
sw $t4,516($t0)
sw $t4,520($t0)
sw $t4,524($t0)


addi $t0,$t1, 952
addi $t0,$t0, 128
addi $t0,$t0, 128

R:
li $t4, 0xffffff
sw $t4,0($t0)
sw $t4,4($t0)
sw $t4,8($t0)
sw $t4,140($t0)
sw $t4,264($t0)

sw $t4,260($t0)
sw $t4,384($t0)
sw $t4,392($t0)
sw $t4,512($t0)
sw $t4,524($t0)

sw $t4,256($t0)

sw $t4,520($t0)
sw $t4,128($t0)

addi $t0,$t0, 756
addi $t0,$t0, 128
#T
sw $t4,0($t0)
sw $t4,4($t0)
sw $t4,8($t0)
sw $t4,12($t0)
sw $t4,16($t0)
sw $t4,136($t0)
sw $t4,264($t0)
sw $t4,392($t0)
sw $t4,520($t0)

addi $t0,$t0, 24

o:
sw $t4,4($t0)
sw $t4,8($t0)
sw $t4,128($t0)
sw $t4,140($t0)
sw $t4,256($t0)
sw $t4,384($t0)
sw $t4,268($t0)
sw $t4,396($t0)
sw $t4,516($t0)
sw $t4,520($t0)

addi $t0,$t0, 716
addi $t0,$t0, 128
#R
li $t4, 0xffffff
sw $t4,0($t0)
sw $t4,4($t0)
sw $t4,8($t0)
sw $t4,140($t0)
sw $t4,264($t0)

sw $t4,260($t0)
sw $t4,384($t0)
sw $t4,392($t0)
sw $t4,512($t0)
sw $t4,524($t0)
sw $t4,520($t0)

sw $t4,256($t0)
sw $t4,128($t0)

addi $t0,$t0, 20

#E
li $t4, 0xffffff
sw $t4,0($t0)
sw $t4,4($t0)
sw $t4,8($t0)
sw $t4,12($t0)
sw $t4,128($t0)
sw $t4,256($t0)
sw $t4,260($t0)
sw $t4,264($t0)
sw $t4,384($t0)
sw $t4,512($t0)
sw $t4,516($t0)
sw $t4,520($t0)
sw $t4,524($t0)

addi $t0,$t0, 20

#T
sw $t4,0($t0)
sw $t4,4($t0)
sw $t4,8($t0)
sw $t4,12($t0)
sw $t4,16($t0)
sw $t4,136($t0)
sw $t4,264($t0)
sw $t4,392($t0)
sw $t4,520($t0)

addi $t0,$t0, 24

#R
li $t4, 0xffffff
sw $t4,0($t0)
sw $t4,4($t0)
sw $t4,8($t0)
sw $t4,140($t0)
sw $t4,264($t0)

sw $t4,260($t0)
sw $t4,384($t0)
sw $t4,392($t0)
sw $t4,512($t0)
sw $t4,520($t0)
sw $t4,524($t0)

sw $t4,256($t0)
sw $t4,128($t0)

addi $t0,$t0, 20
#Y
li $t4, 0xffffff
sw $t4,0($t0)
sw $t4,132($t0)
sw $t4,264($t0)
sw $t4,16($t0)
sw $t4,140($t0)
sw $t4,140($t0)
sw $t4,392($t0)
sw $t4,520($t0)
lw $k0, 0xffff0000
beq $k0, 1, keyboard_input

j loose

boost:
la $t7, life
lw $t8, 0($t7)
addi $t8, $t8, 1 #reset frog_x
sw $t8, 0($t7)

la $t7, powerup_e
lw $t8, 0($t7)
addi $t8, $zero, 0 #no powerup
sw $t8, 0($t7)
j First