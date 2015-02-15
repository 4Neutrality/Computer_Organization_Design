# bitter.s -- This program counts the number or 0's or 1's that 'comprise' a
# portion of an integer (in binary).
#
# @author Kevin J James
# @version 02.06.15
#
# Register Legend:
# 	$t0  - holds number value to be printed
# 	$t1  - holds byte position to be printed
# 	$t2  - holds the bit to sum to be printed
# 	$t3  - holds number value to shift
# 	$t4  - holds byte position multiplied by eight
# 	$t5  - holds value to increment by
# 	$t6  - holds counter
# 	$t7  - holds bit mask
# 	$t8  - holds value 8
# 	$a0  - holds value or address for system calls
# 	$v0  - syscall parameter

.data
# Set data values
int_request:	.asciiz "Please enter an integer > "
byte_request:	.asciiz "Please enter a Byte position (0 - 3) > "
bit_request:	.asciiz "Please enter a bit to sum (0 or 1) > "
result1:	.asciiz "The number of "
result2:	.asciiz "'s in "
result3:	.asciiz " is: "
int_binary:	.asciiz "Integer in binary is > "
nl:  		.asciiz "\n"

.text
main:
############################ PRINTING & READING ###############################
# Print request for an integer #
la $a0, int_request	# get address of, associated with int_request
li $v0, 4		# print string code number = 4
syscall			# execute system call
# Read integer from stdin #
li $v0, 5		# read integer code number = 5
syscall			# execute the system call
# Move given value into register $t0 #
move $t0, $v0		

# Print request for byte position #
la $a0, byte_request	# get address of, associated with byte_request
li $v0, 4		# print string code number = 4
syscall			# execute the system call
# Read integer from stdin #
li $v0, 5	 	# read integer code number = 5	
syscall			# execute system call
# Move byte position into register $t1 #
move $t1, $v0

# Print request for bit to sum #
la $a0, bit_request	# get address of, associated with bit_request
li $v0, 4		# print string code number = 4	
syscall			# execute system call
# Read integer from stdin #
li $v0, 5		# read integer code number = 5
syscall			# execute system call
# Move bit to sum into regiser $t2 #
move $t2, $v0

############################# SHIFTING & BIT MASK #############################
# Move num value into $t3, which will be shifted to byte position #
move $t3, $t0

# Create bit mask from bit sum value #
move $t7, $t2
sll $t7, $t2, 31	# shift left by 31 0's
sra $t7, $t7, 31	# $t7 is now all 0's or 1's
# Apply bit mask #
xor $t3, $t3, $t7

# Multiply byte position by eight to get shift amount #
sll $t4, $t1, 3		# $t4 = $t1 * 8

# Shift to desired byte position #
srlv $t3, $t3, $t4

################################### COUNTING ##################################
and $t5, $t3, 1		# $t5 = $t3 AND 1
add $t6, $t6, $t5	# increment counter
srl $t3, $t3, 1		# shift num value by 1

and $t5, $t3, 1		# $t5 = $t3 AND 1
add $t6, $t6, $t5	# increment counter
srl $t3, $t3, 1		# shift num value by 1

and $t5, $t3, 1		# $t5 = $t3 AND 1
add $t6, $t6, $t5	# increment counter
srl $t3, $t3, 1		# shift num value by 1

and $t5, $t3, 1		# $t5 = $t3 AND 1
add $t6, $t6, $t5	# increment counter
srl $t3, $t3, 1		# shift num value by 1

and $t5, $t3, 1		# $t5 = $t3 AND 1
add $t6, $t6, $t5	# increment counter
srl $t3, $t3, 1		# shift num value by 1

and $t5, $t3, 1		# $t5 = $t3 AND 1
add $t6, $t6, $t5	# increment counter
srl $t3, $t3, 1		# shift num value by 1

and $t5, $t3, 1		# $t5 = $t3 AND 1
add $t6, $t6, $t5	# increment counter
srl $t3, $t3, 1		# shift num value by 1

and $t5, $t3, 1		# $t5 = $t3 AND 1
add $t6, $t6, $t5	# increment counter
srl $t3, $t3, 1		# shift num value by 1

# Subtract counter from 8 to get bit sum #
li $t8, 8 
sub $t6, $t8, $t6	# $t6 = 8 - $t6

############################### PRINT RESULTS #################################
la $a0, result1		# get address of, associated with result1
li $v0, 4		# print string code number = 4
syscall			# execute system call
move $a0, $t2		# register $a0 gets sum bit value
li $v0, 1		# print integer code number = 1
syscall			# execute system call
la $a0, result2		# get address of, associated with result2
li $v0, 4		# print string code number = 4	
syscall			# execute system call
move $a0, $t0		# register $a0 gets value stored in register $t0
li $v0, 1		# print integer code number = 1
syscall			# execute system call
la $a0, result3		# get address of, associated with result3
li $v0, 4		# print string code number = 4
syscall			# execute system call
move $a0, $t6		# register $a0 gets counter value
li $v0, 1		# print integer code number = 1
syscall			# execute system call
li $v0, 4		# print string code number = 4
la $a0, nl		# get address of, associated with nl (newline)
syscall			# execute system call

# Exit upon completion #
li $v0, 10 		# exit code number = 10
syscall			# execute system call

# end of bitter.s
