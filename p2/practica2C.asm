.data

	str: .ascii "El resultado es: "


.text

## Leer dos números del usuario
	
	## Leer primer operando
	li $v0, 5
	syscall
	
	move $s1, $v0
	
	## Leer segundo operando
	li $v0, 5
	syscall
	
	move $s2, $v0
	
## Realizar la suma
	
	add $s3, $s2, $s1

## Imprimir el resultado

	la $s4, str
	
	li $v0, 4
	move $a0, $s4
	syscall
	
	li $v0, 1
	add $a0, $s3, $zero
	syscall

## Salir del programa

	li $v0, 10
	syscall
	
