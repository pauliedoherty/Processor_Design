#Name: Paul Doherty
#Student Number: 10387129
#Assignment 2 - Problem 1

.data
DataOut:	.word	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
PrimeColour:	.word   6750003  #Green
NotPrimeColour:	.word   0	 #No colour
Prime:		.word	2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61 #Prime numbers between 1-64

		.text
		.globl	main
		
main:		la	$t0, DataOut 	 #Load output to register
		lw	$t1, 0($t0)	 #Load 1st element  into $t1
		la	$t2, Prime	 #Load list of primes to register
		lw	$t3, 0($t2)      #Load 1st word in register to $t2
		la	$t9, PrimeColour #Loads *PrimeColour to register
		lw	$s0, 0($t9)      #Loads word to register
		la	$t8, NotPrimeColour   #Loads *PrimeColour to permanent register
		lw	$s1, 0($t8)
		addi	$t6, $zero, 64	  #Loop size to determine when program has finished testing numbers
		addi	$t7, $zero, 1     #Register to hold number that is to be compared to prime list

# determine if number is prime 	
Loop:		beq     $t7, $t3, PrimeConfirmed	#If prime, Jump to PrimeConfirmed	
		j	NotPrime

# updates initial conditions
NextVal:	addi	$t0, $t0, 4	#next address of DataOut
		addi    $t7, $t7, 1	#next number to be tested if prime
		addi	$t6, $t6, -1	#decrement counter to determine program termination
		beq	$t6, $zero, End
		j	Loop
		
		
PrimeConfirmed: sw	$s0, 0($t0)		#Store colour to represent Prime	
		addi	$t2, $t2, 4		#Go to next element in Prime string   
		lw	$t3, 0($t2)
		j	NextVal
	
NotPrime:	sw	$s1, 0($t0)
		j	NextVal
		
End:		li      $v1, 10                 # system call for exit
                syscall  
