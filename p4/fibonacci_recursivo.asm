	#-- Hecho por Profesor
	
	#-- Cálculo de la secuencia de fibonacci
	#-- Usando un algoritmo recursivo
	
	#-- F(n):
	#-- Si n<=2, F(n) = 1
	#-- Si n>2, F(n) = F(n-1) + F(n-2)
	
	#-- n: 1 2 3 4 5 6 7 8 9
	#-- F(n) 1 1 2 3 5 8 13 21 35...
	
	.data
msg1:	.asciiz "Término n de Fibonacci es: "
	
	.text
	
	#--- Imprimir mensaje
	li $v0, 4
	la $a0, msg1
	syscall
	
	#--- Calcular F(n). F(10)
	li $a0, 13
	jal fibo
	#-- $v0 = F(10)
	
	#-- Imprimir el resultado
	move $a0, $v0
	li $v0, 1
	syscall
	
	#-- Terminar
	li $v0, 10
	syscall
	
	#-- Subrutina para calcular F(n)
fibo:	#-- ¡¡Recursiva!!

	#-- Comprobar la condición de terminación
	bgt $a0, 2, fibo_recur
	
	#-- Devolver 1 en los casos F(1), F(2)
	li $v0, 1
	jr $ra
	
fibo_recur:
	#--- Cuando n>2
	
	#------ Crear marco de Pila
	subu $sp, $sp, 32
	sw $ra, 20($sp)
	sw $fp, 16($sp)
	addiu $fp, $sp, 28
	
	#-- Calcular F(n-1)
	##-- Guardar n en la pila
	sw $a0, 0($fp)
	subi $a0, $a0, 1 #--- a0 = n-1
	jal fibo
	#-- v0 = F(n-1)
	
	#-- Guardar F(n-1) en la pila
	sw $v0, -4($fp)
	
	#-- Calcular F(n-2)
	lw $a0, 0($fp) #-- Recuperar n
	subi $a0, $a0, 2 #-- a0 = n-2
	jal fibo
	#-- v0 = F(n-2)
	
	#-- Calculo final: F(n-1) + F(n-2)
	lw $v1, -4($fp) #-- Recuperar F(n-1)
	add $v0, $v0, $v1 #-- Calcular F(n-2) + F(n-1)
	
	
	#--- Recuperar el marco de pila
	lw $ra, 20($sp)
	lw $fp, 16($sp)
	addiu $sp, $sp, 32
	jr $ra
