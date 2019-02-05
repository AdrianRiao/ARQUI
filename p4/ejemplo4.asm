	.data
cad:	.asciiz "Saludos...\n"
	
	
	.text
	
	#-- Cálculos super avanzados de la muerte
	#-- Resultado está en $a0
	li $a0, 8
	
	jal subrutina_ajena
	
	#-- Usar lo que hay en el ragistro $a0
	#-- Imprimir $a0 en consola
	
	#-- Nota: No puedo asegurar que en el registro $a0 esté lo que quiero, ya que si la subrutina que estoy utilizando la 
	#-- ha hecho alguien quizás lo han modificado
	
	#-- CONVENIO: todos los registros temporales (a0, a1, a2, a3, t0-t9) se pueden machacar, por lo que no 
	#--	      deberiamos usar esos registros para datos.
	#-- CONVENIO: no te pueden modificar los registros estáticos (s0-s7).
	
	#-- Por lo que la solución a este código sería guardar mi dato importante en un registro estático y no temporal.
	
	#-- ¿Y si soy yo el que tiene que hacer la subrutina? => tendré que devolver en los registros estáticos los datos que estaban
	#-- si necesito usar esos registros tendré que volcar los datos en la pila, utilizar los registros que quiera, y volver a dejar los registros como estaban.
	
	#--- Terminar
	li $v0, 10
	syscall
