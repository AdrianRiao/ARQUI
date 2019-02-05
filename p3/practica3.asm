	## Programa para comparar dos números
	
	.data
cad:	.asciiz "Son iguales\n"
	
	.text 
	
	## Pedir los dos números al usuario
	## Operando a: S1
	## Operando b: S2
	li $v0, 5
	syscall
	move $s1, $v0
	
	li $v0, 5
	syscall
	move $s2, $v0
	
	
	
	## Si no son igual terminar
	bne $s1, $s2, fin
	
	
	
	## Si son iguales imprimimos la cadena
	li $v0, 4
	la $a0, cad
	syscall
	
	
	
fin:	li $v0, 10
	syscall