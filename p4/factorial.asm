	.data
msg:	.asciiz "El factorial de 3 es:\n"

	.text
	#-- Programa principal
	
	la $a0, msg
	li $v0, 4
	syscall
	
	#-- Calcular el factorial de 3
	li $a0, 3
	jal fact
	
	
	#-- Imprimir el resultado
	move $a0, $v0
	li $v0, 1
	syscall
	
	
	#-- Terminar
	li $v0, 10
	syscall
	
	
fact:

	subu $sp, $sp, 32 # Stack frame is 32 bytes long
	sw $ra, 20($sp) # Save return address
	sw $fp, 16($sp) # Save frame pointer
	addiu $fp, $sp, 28 # Set up frame pointer
	sw $a0, 0($fp) # Save argument (n)
	
	lw $v0, 0($fp)
 	bgtz $v0, fact_recur # fact(n-1)
 	li $v0, 1
 	b return_fact
 	
 	
fact_recur:
	lw $v1, 0($fp) # Load n
 	subu $v0, $v1, 1 # Compute n - 1
	move $a0, $v0 # Move value to $a0
 	jal fact

 	lw $v1, 0($fp) # Load n
 	mul $v0, $v0, $v1 # Compute fact(n-1) * n 
 	
return_fact:
	lw $ra, 20($sp)
 	lw $fp, 16($sp)
 	addiu $sp, $sp, 32
 	jr $ra 
