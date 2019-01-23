#Name: Paul Doherty
#Student Number: 10387129
#Assignment 2 - Problem 1
            
                              .data
DataIn:     .word      'A'
DataOut:    .word	0
Morse:	    .ascii      ".-   ","-... ","-.-. ","-..  ",".    ","..-. ","--.  ",".... ","..   ",".--- ","-.-  ",".-.. ","--   ","-.   ","---  ",".--. ","--.- ",".-.  ","...  ","-    ","..-  ","...- ",".--  ","-..- ","-.-- ","--.. "
            .text   
            .globl      main
            
main:       la          $t0, DataIn          # t0 = *DataIn
	    lw		$a1, 0($t0)          # load 1st element $t0 in $a1

            jal 	atom
            li          $v1, 10              # system call for exit
            syscall                          # Exit!             
            
atom:	    addi	$a1, $a1, -65  	     #finding position of letter in alphabet
	    la		$v0, DataOut
            la		$t8, Morse	     # t6 = *Morse
	    addi	$t2, $zero, 5	     # t2 sets size of Loop
Loop:  	    beqz	$t2, LoadLoop        # stop loop if t2 = 0
	    addi	$t2, $t2, -1  	     # decrement by 1 5 times
            add		$t8, $t8, $a1        # *Morse = *DataIn + distance from A - incrementing the morse address 
            j		Loop

LoadLoop:   lb		$t9, 0($t8)	    # load converted morse code
	    sb		$t9, 0($v0)	    # storing loaded in v0
	    beq		$t9, 32, IfEnd	    # check t9 for "space"
	    addi	$t8, $t8, 1	    # add 1 to address of morse code
	    addi	$v0, $v0, 1	    # add 1 to address of morse code
	    j		LoadLoop 
  
IfEnd:	    jr		$ra
