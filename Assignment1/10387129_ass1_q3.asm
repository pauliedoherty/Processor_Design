            .data
DataIn1:    .word       1,2,3,4
DataIn2:    .word       1,2,3,4
Length:     .word       4
ValidFlag:  .word       2
            .text       
            .globl      main
main:       la          $t0, DataIn1        # t0 = *DataIn
	    la          $t1, DataIn2        # t0 = *DataIn
            la          $t2, Length         # t1 = *Length
            lw          $t5, 0($t1)         # t2 =  Length (counter)
            
Loop:       lw          $t3, 0($t0)         # t4 = DataIn
	    lw 		$t4, 0($t1)         # t4 = DataIn
	      
            addi        $t0, $t0, 4         # *DataIn = *DataIn + 4 (increment)
            addi	$t1, $t1, 4         # *DataIn = *DataIn + 4 (increment)
            
            addi        $t5, $t5, -1        # counter - counter -1
            bne		$t3, $t4, Invalid   #if  not equal, skip to Invalid
            bne         $t5, $zero, Loop    # if counter != 0 then go to Loop
            j		Valid		    #jump to valid if lists and length match
            
#boolean 1 which represents true is stored in register $t7 if lists and list lengths match          
Valid:      li          $t7, 1              # t7 = 1 (ValidFlag = true)
            j           End                 # goto IfEnd
            
#boolean 0 which represents false is stored in register $t7 if lists and list lengths do not match   
Invalid:    li          $t7, 0              # t7 = 0 (ValidFlag - false)

End:        la          $t8, ValidFlag      # t8 = *ValidFlag
            sw          $t7, 0($t8)         # store ValidFlag at *ValidFlag
            li          $v0, 10             # system call for exit
            syscall                         # Exit!     
                    