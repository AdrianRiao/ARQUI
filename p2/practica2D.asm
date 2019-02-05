	.data

num1:	.word 100
num2:	.word 200

	.text
	
## Pasamos los datos a registros
	
	la $t0, num1
	lw $s1, 0($t0)
	
	la $t0, num2
	lw $s2, 0($t0)
	

## Sumamos
	
	add $s3, $s2, $s1

## Imprimir el resultado

	li $v0, 1
	add $a0, $s3, $zero
	syscall

## Salir del programa

	li $v0, 10
	syscall
	
	
## Si quiero cargar medias palabras (16 bits) tendré que sustituir "num1: .word 100" por "num1: .half 100"
## Luego al traerme el dato a registros tendré que sustituir "lw $s1, 0($t0)" por "lh $s1, 0($t0)"

## Si quiero cargar datos de 1byte (8 bits) tendré que sustituir "num1: .word 100" por "num1: .byte 100"
## Luego al traerme el dato a registros tendré que sustituir "lw $s1, 0($t0)" por "lb $s1, 0($t0)"
