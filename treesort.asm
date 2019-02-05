# Sugerencia de utilización de los registros
# $s0 – Nodo raíz del árbol (root)
# $s1 – Siguiente número introducido por el usuario
# $s2 – Valor centinela (número 0)


main:

	# Paso 1: crear el nodo raíz
	
	#-- Guardar el valor centinela (0) en $s2
	#-- (Porque así me lo han suguerido)
	li $s2, 0
	
	# root = tree_node_create ($s2, 0, 0);
	move $a0, $s2
	li $a1, 0
	li $a2, 0
	jal tree_node_create
	
	#-- v0 contiene el puntero al primer nodo
	move $s0, $v0

	# Paso 2: leer números e insertarlos en el árbol hasta leer el 0
in_loop:
	
	# Leer número
	li $v0, 5
	syscall
	
	# Si leo un 0 acabo el programa
	beq $v0, 0, end_in
	
	# Si no he leido 0:
	# tree_insert (number, root);
	move $a0, $v0
	move $a1, $s0
	jal tree_insert
	
	# Repetir
	b in_loop

end_in:
	# Paso 3: imprimir los subárboles izquierdo y derecho

	lw $a0, 4($s0)
	jal tree_print # tree_print(left_tree);
	lw $a0, 8($s0)
	jal tree_print # tree_print(right_tree);
	
# end main
	li $v0, 10
	syscall


# tree_node_create (val, left, right): crear un nuevo nodo con el valor indicado y
# con los punteros a los subárboles y izquierdo y derecho indicados
tree_node_create:
	# Crear pila
	subu $sp, $sp, 32
	sw $ra, 20($sp)
	sw $fp, 16($sp)
	addiu $fp, $sp, 28
	# Guardo argumentos en la pila
	sw $a0, 0($fp)
	sw $a1, -4($fp)
	sw $a2, -16($fp)
	
	# Invocar sbrk syscall
	li $v0, 9
	li $a0, 12 # Necesitamos 12 bytes para almacenar un nodo del árbol
	syscall
	# En v0 tnedré un puntero a mi nodo creado
	
	# Comprobar si queda memoria
	beq $v0, 0, end_in
	
	# Introducir los valores del nodo en el nodo creado
	lw $a0, 0($fp)
	lw $a1, -4($fp)
	lw $a2, -16($fp)
	sw $a0, 0($v0)
	sw $a1, 4($v0)
	sw $a2, 8($v0)
	
	
	# Liberar pila
	lw $ra, 20($sp)
	lw $fp, 16($sp)
	addiu $sp, $sp, 32
	
	# Retornar
	jr $ra
	
# end tree_node_create


# tree_insert (val, root): crea un nuevo nodo y lo inserta en el árbol de forma
# ordenada
tree_insert:
	# Crear pila
	subu $sp, $sp, 32 
	sw $ra, 20($sp)
	sw $fp, 16($sp)
	addiu $fp, $sp, 28
	sw $a0, 0($fp) # Guardo val en la pila
	sw $a1, -4($fp) # Guardo root en la pila
	
	# Crear un nuevo nodo, tree_node_create (val, 0, 0);
	lw $a0, 0($fp)
	li $a1, 0
	li $a2, 0
	jal tree_node_create
	# En v0 tendré el nuevo nodo creado

	# Insertar el nuevo nodo creado implementando el siguiente algoritmo en C
	# for (;;)
	# {
	# 	root_val = root->val;
	# 	if (val <= root_val) // Recorrer subárbol izquierdo
	# 	{
	# 		ptr = root->left;
	# 		if (ptr != NULL)
	# 		{
	# 			root = ptr;
	# 			continue;
	# 		}
	# 		else
	# 		{
	# 			root->left = new_node;
	# 			break;
	# 		}
	# 	}
	# 	else // Recorrer subárbol derecho
	# 	{
	#		// Igual que para el subárbol izquierdo
	# 	}
	lw $a0, 0($fp) # a0 = val
	lw $a1, -4($fp) # a1 = root
	
bucle:
	lw $a2, 0($a1) # a2 = root->val

	ble $a0, $a2, recor_arb_izq
	bgt $a0, $a2, recor_arb_drch
	
recor_arb_izq:
	lw $t0, 4($a1)
	bne $t0, 0, continue1
	beq $t0, 0, notcontinue1
	
continue1:
	move $a1, $t0 #root = ptr;
	b bucle #continue;
notcontinue1:
	sw $v0, 4($a1)  #root->left = new_node;
	b return #break 
	
	
recor_arb_drch:
	lw $t0, 8($a1)
	bne $t0, 0, continue2
	beq $t0, 0, notcontinue2

continue2:
	move $a1, $t0 #root = ptr;
	b bucle #continue;
notcontinue2:
	sw $v0, 8($a1)  #root->left = new_node;
	b return #break
	
return:
	# Liberar pila
	lw $ra, 20($sp)
	lw $fp, 16($sp)
	addiu $sp, $sp, 32
	# Retornar
	jr $ra
# end tree_inser



# tree_print(tree): recorre el árbol de forma inorder imprimiendo el
# valor de cada nodo. Código C equivalente:
# void tree_print (tree_t *tree)
# {
# 	if (tree != NULL)
# 	{
# 		tree_print (tree->left);
# 		printf ("%d\n", tree->val);
# 		tree_print (tree->right);
# 	}
# }
tree_print:
	# Crear pila
	subu $sp, $sp, 32 
	sw $ra, 20($sp)
	sw $fp, 16($sp)
	addiu $fp, $sp, 28
	sw $a0, 0($fp)

	beq $a0, 0, done ## Caso en el que tree = NULL

	lw $a0, 4($a0)
	jal tree_print # Recursivo por la izquierda

	lw $t0, 0($fp)
	lw $a0, 0($t0)
	li $v0, 1
	syscall
	
	lw $t0, 0($fp)
	lw $a0, 8($t0)
	jal tree_print # Recursivo por la derecha

done:
	# Liberar pila
	lw $ra, 20($sp)
	lw $fp, 16($sp)
	addiu $sp, $sp, 32
	# Retornar
	jr $ra
# end tree_print
