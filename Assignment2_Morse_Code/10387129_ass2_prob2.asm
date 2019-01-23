            .data
StringIn:   .asciiz	"PAUL"
StringOut:  .ascii	"                          "
Morse:	    .ascii      ".-   ","-... ","-.-. ","-..  ",".    ","..-. ","--.  ",".... ","..   ",".--- ","-.-  ",".-.. ","--   ","-.   ","---  ",".--. ","--.- ",".-.  ","...  ","-    ","..-  ","...- ",".--  ","-..- ","-.-- ","--.. "
	    .align 	2
Newline:    .asciiz 	"\n"         	      #terminate with "\n"
            .text   
            .globl      main
              
main:       la          $a0, StringIn         # t0 = *StringIn	
	    la		$v0, StringOut

	   
	    jal		atom
	    addi        $a0, $a0, 1
	    addi	$v0, $v0, 1	     # address its being stored in, add one byte 
atom:	    lb		$a2, 0($a0)          # storing value of next letter in a2
	    beqz 	$a2, End	     # if null value seen, End
	    addi	$a2, $a2, -65  	     # finding position of letter in alphabet
            la		$t8, Morse	     # t6 = *Morse

	    addi	$t2, $zero, 5	     # t2 sets size of Loop
Loop:  	    beqz	$t2, LoadLoop        # stop loop if t2 = 0
	    addi	$t2, $t2, -1  	     # decrement by 1 5 times
            add		$t8, $t8, $a2        # *Morse = *DataIn + distance from A - incrementing the morse address 
            j		Loop

LoadLoop:   lb		$t9, 0($t8)	     # loading in converted morse code 
	    sb		$t9, 0($v0)	     # storing output in v0
	    beq		$t9, 32, IfEnd	     # if t9 = ascii value for "space"
	    addi	$t8, $t8, 1	     # add 1 to address of stored morse code
	    addi	$v0, $v0, 1	     # add 1 to address of output morse code
	    j		LoadLoop 
	    
IfEnd:      jr 		$ra
End:	    la 		$t0, Newline
	    lw		$t1, 0($t0)
	    sb		$t1, 0($v0)	    # place new line at end of string
            li          $v1, 10             # system call for exit
            syscall                         # Exit     

            
