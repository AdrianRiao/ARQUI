	.data

num1:	.space 2
num2:	.space 2

	.text
	
	la $t0, num1
	la $t1, num2
	
	
	li $v0, 5
	syscall
	sh $v0, ($t0)
	
	li $v0, 5
	syscall
	sh $v0, ($t1)

## Pasamos los datos a registros
	
	lw $s1, 0($t0)
	
	lw $s2, 0($t1)
	

## Sumamos
	
	add $s3, $s2, $s1

## Imprimir el resultado

	li $v0, 1
	add $a0, $s3, $zero
	syscall

## Salir del programa

	li $v0, 10
	syscall

## Al sumar los dos ceros que están en la memoria reservada por space nos da error.
## Es porque los datos no están alineados, es decir, el error se da cuando intentamos
## meter la direccion de num2 en un registro, ya que la dirección de memoria de num2
## no es múltiplo de 4.

## Si declaramos ahora una variable de tipo .half 0 y otra de tipo .word 0 el programa no falla.
## Esto es porque al declarar así las variables cogemos en memoria una palabra entera, aunque nos sobre espacio.


## El punto space solo lo utilizaremos para estructuras de datos, no para variables.
