.data	 #data declaration of variables
D_in: .word 1,2,3,4,5,6,7,8,9,10 #data stored in words 
D_out: .word 0,0,0,0,0,0,0,0,0,0 #creates array to hold squared values
 .text       # code goes in text segment
 .globl main # must be global symbol
main: 
la $t0, D_in # load address pseudo-instruction
la $t1, D_out 
lw $t2, 0($t0)  

Loop1: beq $t2,11,end

li $t3, 0	#loads value 0 into $t3
li $t4, 0 	#loads value 0 into $t4

#Loop2 performs the incrementation of addition
Loop2:  beq $t3,$t2,squared #checks if addition has been performed correct amount of time
 add $t4,$t4,$t2	 #performs addition of value
 addi $t3,$t3,1		 #counter to keep track of how many times addition has been performed
 j Loop2
 
squared: 
sw $t4, ($t1)	#store contents of from computed address
beq $t4,100,end #check value to end code
addi $t0,$t0,4  #increment address
addi $t1,$t1,4  #increment address
lw $t2, ($t0)   #load contents from array element to $t2
 j Loop1        #jump to loop one
 end:
 li $v0, 10   