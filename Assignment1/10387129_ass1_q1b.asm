.data # data goes in data segment
D_in: .word 2,3,4 # data stored in words
D_out: .word 5,6,7
.text # code goes in text segment
.globl main # must be global symbol
main: la $t0, D_in # load address pseudo-instruction
la $t1, D_out

lw $t2, 0($t0)		#load 1st element of D_in into register $t2
addi $t2, $t2, 2	#add 2 to this value
sw $t2, 0($t1)		#store result into 1st element of D_out

lw $t2, 4($t0)		#load 2nd element of D_in into register $t2
addi $t2, $t2, 2	#add 2 to this value
sw $t2, 4($t1)		#store result into 2nd element of D_out

lw $t2, 8($t0)		#load 3rd element of D_in into register $t2
addi $t2, $t2, 2	#add 2 to this value
sw $t2, 8($t1)		#store result into 3rdd element of D_out

#
li $v0, 10 # system call for exit
syscall # Exit!