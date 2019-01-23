 .data
DataIn1:    .ascii       ".- "
	    .align 	2
DataOut:    .ascii	"0"
	    .align 	2
Morse:	    .ascii      ".-  ","-...","-.-.","-.. ",".   ","..-.","--. ","....","..  ",".---","-.- ",".-..","--  ","-.  ","--- ",".--.","--.-",".-. ","... ","-   ","..- ","...-",".-- ","-..-","-.--","--.."
            .text   
            .globl      main
            
main:       la          $a0, DataIn1         # a0 = *DataIn  	     #input to subroutine is a pointer to morse in memory
	    la		$v0, DataOut
            la		$a1, Morse	     # a1 = *Morse
	    
	    jal		mtoa
	    li          $v1, 10             # system call for exit
            syscall                         # Exit!          
            
mtoa:	    li		$t3, 4
	    li		$t4, 0	
            li	        $a2, 65		    #load ascii value of A to a2

CompareLoop:lb		$t0, 0($a0)	    #load first byte to be converted
	    lb		$t1, 0($a1)	    #t1 = Morse to be compared to
	    bge  	$a2, 91, Error	    #if ascii value of Z has been surpassed
	    bne		$t0, $t1, NotFound 
	    beq         $t1, 32, Found
	    addi	$a1, $a1, 1	    # add 1 to address of morse code
	    addi	$a0, $a0, 1	    # add 1 to address of morse code
	    addi	$t3, $t3, -1        #go up in byte counter
	    addi	$t4, $t4, +1        #go up in byte counter
	    beqz	$t3, Found 
 	    j		CompareLoop
	    
NotFound:   add		$a1, $a1, $t3	    #add value of t3 counter to get to the first byte of next word to compared to
	    sub 	$a0, $a0, $t4
	    addi	$a2, $a2, 1         #counter go up alphabet	
	    li		$t3, 4
	    li		$t4, 0		
	    j		CompareLoop    		
Error:      addi	$a2, $zero, 33		#if we surpass Z, an exclamation mark shows an error
Found:	    sw		$a2, 0($v0)
	    jr		$ra
