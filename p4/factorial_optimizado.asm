	#-- NOTA: PARA VER EL NÚMERO TOTAL DE INSTRUCCIONES QUE SE EJECUTAN
	#-- IR A TOOLS/INSTRUCTION COUNTER (ASÍ OBSERVAMOS LA OPTIMIZACIÓN)
	
	
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
	
	
fact:	#--- Comprobar la condición de terminación
	
	#--Condición de terminación
	#-- si n>1, calcula fact(n)
 	bgt $a0, 1, fact2
 	
 	#-- Si n<=1, fact(1) = 1
 	li $v0, 1
 	jr $ra
	
	
fact2:

	subu $sp, $sp, 32 # Stack frame is 32 bytes long
	sw $ra, 20($sp) # Save return address
	sw $fp, 16($sp) # Save frame pointer
	addiu $fp, $sp, 28 # Set up frame pointer
	sw $a0, 0($fp) # Save argument (n)
	
	#---- Calcular fact(n-1)
	subu $a0, $a0, 1 #-- n-1
	jal fact
	#--- v0 = fact(n-1)

	#--- n * fact(n-1)
	lw $v1, 0($fp) #-- recuperar la n
 	mul $v0, $v0, $v1 # Compute fact(n-1) * n 
 	
 	
	#-- Recuperar el marco de pila
	lw $ra, 20($sp)
 	lw $fp, 16($sp)
 	addiu $sp, $sp, 32
 	jr $ra 