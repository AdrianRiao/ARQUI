	.text
	
	## Introducir primer valor
	li $v0, 5
	syscall
	
	##Si es cero acabo
	beq $v0, 0, end
	
	## Sino, create (val, 0)
	move $a0, $v0
	li $a1, 0
	jal create
	
	## v0 contendrá el valor del primer nodo
	move $s0, $v0 ## s0 = first_node

loop:	
	##Leer números por el usuarios
	li $v0, 5
	syscall
	
	##Si es cero acabo
	beq $v0, 0, end
	
	## Sino, meto el valor en la lista: insert_in_order(first_node, val)
	move $a0, $s0
	move $a1, $v0
	jal insert_in_order
	
	
	##Terminar
end:	
	li $v0, 10
	syscall
	
	
create:
	move $t0, $a0
	li $v0, 9
	li $a0, 8 ## Nota: Una celda de la lista ocupará 8 bytes (4 para el valor y otras 4 para el puntero)
	syscall
	
	sw $t0, 0($v0) ## first_node->val = val
	sw $zero, 4($v0) ## first_node->next = NULL
	## Retornar
	jr $ra

insert_in_order:
	## Crear pila
	subu $sp, $sp, 32
	sw $ra, 20($sp)
	sw $fp, 16($sp)
	addiu $fp, $sp, 28
	sw $a0, 0($fp)
	sw $a1, -4($fp)

in_loop:
	## Comparamos con los valores de la lista
	lw $t0, 0($a0)
	blt $a1, $t0, repeat
	
	beq $a1, $t0, end_insert
	
repeat:
	lw $a0, 4($a0)
	b in_loop
	
end_insert:
	## Recuperamos los valores de la pila y retornamos
	lw $ra, 20($sp)
	lw $v0, -16($fp)
	lw $fp, 16($sp)
	addiu $sp, $sp, 32
	
	
	
	
	
	
	
	
	
	
	
	
	
	