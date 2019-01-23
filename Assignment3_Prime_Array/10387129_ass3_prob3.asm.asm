#Name: Paul Doherty
#Student Number: 10387129
#Assignment 3 - Problem 2
.data
DataOut:	.word	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
TestNumbers:	.word	2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64
Prime:		.word	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
NotPrime:	.word	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
PrimeColour:	.word   6750003  #Green
NotPrimeColour:	.word   16711680 #red
		.text
		.globl	main
		
main:		la	$s4, DataOut		 #Pointer to DataOut
		la	$t0, TestNumbers	 #pointer to TestNumbers
		lw	$t1, 0($t0)		 #Load 1st element of TestNumbers
		la	$s0, NotPrime  		 #pointer to NotPrime
		lw	$t2, 0($s0)		 #Load 1st element of NotPrime
		la	$s1, Prime		 #pointer to Prime
		lw	$t3, 0($s1)		 #Load 1st element of Prime
		li	$t5, 63			 #Counter to test if all numbers have been tested
		li	$t6, 1			 #Loop counter for square numbers
		li	$t7, 0			 #register to hold addition number
		add	$t7, $t7, $t1		 #Load $t7 with test number  
		li	$s3, 64			 #Set maximum value for square and addition computation
		la	$t9, PrimeColour         #Loads *PrimeColour to permanent register
		lw	$s2, 0($t9)
		la	$t8, NotPrimeColour      #Loads *PrimeColour to permanent register
		lw	$s6, 0($t8)
		li	$s5, 2			 #Counter to test NotPrime
		li	$s7, 2			 #Register to colour not prime number
		
#Colour All Numbers
Colour:		sw	$s2, 0($s4)		#Store nutural colour to address
		addi	$s4, $s4, 4		#Update address of data out	
		addi	$s5, $s5, 1		#Update test counter
		bgt	$s5, $s3, CheckPrime
		j	Colour	
						
#Loop to check if testnumber is prime
CheckPrime:	beq 	$t1, $t2, Iterate	#Number is not prime so test next next value
		beq	$t2, $zero, StorePrime	#If counter equals zero then number is prime
		addi    $s0, $s0, 4		#Go to next NotPrime number
		lw	$t2, 0($s0)		#Load it to $t2
		j	CheckPrime		#If counter hasn't equalled zero then check number against new value

#Loop to store a confirmed prime number
StorePrime:	sw	$t1, 0($s1)		#Stores test number into list of Prime
		addi	$s1, $s1, 4		#Moves to next element in Prime String
		lw	$t3, 0($s1)		#Loads it to $t3
		j	Square
		
#Loop to Square Prime Number
Square:        	add	$t7, $t7, $t1		#addition
		bgt 	$t7, $s3, Iterate	#if computated value is greater than 64 then go on to next test value
		addi	$t6, $t6, 1		#If not add 1 to square counter	
		bne	$t6, $t1, Square        #Add again if condition not met, if condition met
		j	StoreNotPrime
		
#Loop to perform addition of numbers
Addition:	add	$t7, $t7, $t1		#Adds NotPrime number to itself to square number
		bgt 	$t7, $s3, Iterate	#if computated value is greater than 64 then go on to next test value
		la	$s0, NotPrime  		#pointer to NotPrime
		lw	$t2, 0($s0)		#Load 1st element of NotPrime
		j	CheckAddition


#Loop to check if Number has already been added to list
CheckAddition:	beq     $t2, $zero, StoreNotPrime
		beq	$t2, $t7, Addition 	
		addi	$s0, $s0, 4		#Move to next memory address of NotPrime
		lw	$t2, 0($s0)		#Load 1st element of NotPrime
		j	CheckAddition
		
#Loop to Store Value in NotPrime
StoreNotPrime:	sw	$t7, 0($s0)		#Store computed value in NotPrime string
		addi	$s0, $s0, 4		#Move to next memory address of NotPrime
		la	$s4, DataOut		#Pointer to DataOut
		j	FindNotPrime
		
#Loop to Load next value of TestNumber to be tested		
Iterate:	addi    $t0, $t0, 4		#Update address for next value of test number
		addi	$t5, $t5, -1
		beq	$t5, $zero, End
		lw	$t1, 0($t0)		#Load value to $t1 
		li	$t6, 1
		li	$t7, 0			#reset register to hold addition number
		add	$t7, $t7, $t1		 #Load $t7 with test number 
		la	$s0, NotPrime  		#pointer to NotPrime
		lw	$t2, 0($s0)		#Load 1st element of NotPrime 
		j	CheckPrime		#Check if new number is prime by checking not prime list

FindNotPrime:	beq	$s7, $t7, ColourNotPrime#Colour segment as it does not represent a prime number
		addi	$s4, $s4, 4		#Update DataOut
		addi	$s7, $s7, 1		#Update Finding counter
		j	FindNotPrime

#Loop to colour not prime number 				
ColourNotPrime:	sw	$s6, 0($s4)
		li	$s7, 2
		j	Addition		
		
		
End:		li      $v1, 10                 # system call for exit
                syscall 
		
		
