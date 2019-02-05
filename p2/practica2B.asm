.data

	str: .asciiz "Hello  Word!"

.text

	la $s1, str
	
	li $v0, 4
	move $a0, $s1
	syscall
	
	li $v0, 10
	syscall