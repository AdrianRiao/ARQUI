	.data
	
array:	.word 1,2,3,4
	
	.text
	
	li $t0, 1
	la $a1, array
	lw $a0, 0($a1)
	li $v0, 1
	
loop:
	beq, $t0, 5, end
	
	syscall
	
	
	add $a1, $a1, 4
	lw $a0, 0($a1)
	addi $t0, $t0, 1
	
	b loop
end:
	li $v0, 10
	syscall
	