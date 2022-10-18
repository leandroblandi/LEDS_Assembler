
;*******************************************************************************
;	Programa para encender LEDs
;	de varias formas con subrutinas						Fecha: 07-10-2022
;	- Dispositivo: PIC16F628A
;	- Perro guardian: OFF
;	- Tipo de Reloj: interno
;	- Proteccion del codigo: OFF
;*******************************************************************************


;*******************************************************************************
; Zona de dat	os
;*******************************************************************************

		__CONFIG 3F10
		LIST 	P=16F628A
		#INCLUDE <P16F628A.INC>
		ERRORLEVEL -302
	
;*******************************************************************************
; Constantes
;*******************************************************************************

		CBLOCK 0x20	; Reservamos una serie de direcciones de memoria para los alias
		
		CONTADOR1
		CONTADOR2
		CONTADOR3
		CONTADOR4
		
		ENDC

		ORG 	0x00
		
		CALL CONFIGURAR_PUERTOS
		GOTO INICIO
		


;*******************************************************************************
; Zona de codigos
;*******************************************************************************
; Subrutina principal
;********************

INICIO	CALL ENCENDER_TODOS_LOS_LEDS
		CALL ENCENDER_TODOS_LOS_LEDS

		CALL DELAY_5S
		
		CALL ENCENDER_TODOS_LOS_LEDS_1S
		CALL ENCENDER_TODOS_LOS_LEDS_1S
		
		CALL DELAY_5S
		
		CALL ENCENDER_TODOS_LOS_LEDS_1S_500MS
		CALL ENCENDER_TODOS_LOS_LEDS_1S_500MS
		
		CALL DELAY_5S
		
		CALL ENCENDER_LEDS_DE_A_UNO_500MS
		CALL ENCENDER_LEDS_DE_A_UNO_500MS
		
		CALL DELAY_5S
		
		CALL BUCLE_LEDS_500MS
		CALL BUCLE_LEDS_500MS
		
		CALL DELAY_5S
				
		GOTO INICIO


;**************************************************************************
; Subrutinas de retardo
;**************************************************************************
; Subrutina para generar retardo de 1ms
;**************************************************************************

DELAY_1MS	MOVLW D'250'			; Cargamos el valor 250 en W
			MOVWF CONTADOR1		; Cargamos el valor de W en el primer contador

RETARDO_1	NOP
			DECFSZ CONTADOR1,F	; Decrementamos en 1 el primer contador
			GOTO RETARDO_1		; Repetimos la accion hasta que sea 0
			RETURN


;****************************************************
; Subrutina para generar retardo de 250ms
;****************************************************

DELAY_250MS	MOVLW D'250'			; Cargamos el valor 250 en W
			MOVWF CONTADOR2		; Cargamos el valor de W en el segundo contador

RETARDO_2	CALL DELAY_1MS		; Esperamos 1 milisegundo por cada
			DECFSZ CONTADOR2,F	; decremento del segundo contador (1ms x 250 = 250ms)
			GOTO RETARDO_2		; Repetimos la accion hasta que sea 0
			RETURN


;****************************************************
; Subrutina para generar retardo de 1s
;****************************************************

DELAY_1S		MOVLW D'4'			; Cargamos el valor 4 en W
			MOVWF CONTADOR3		; Cargamos el valor de W en el tercer contador

RETARDO_3	CALL DELAY_250MS		; Esperamos 250 milisegundos por cada
			DECFSZ CONTADOR3,F	; decremento del tercer contador (250ms x 4 = 1000ms)
			GOTO RETARDO_3		; Repetimos la accion hasta que sea 0
			RETURN
			
DELAY_5S
			MOVLW D'5'			; Cargamos el valor de 5 en W
			MOVWF CONTADOR4		; Cargamos el valor de W en el cuarto contador

RETARDO_4
			CALL DELAY_1S		; Esperamos 1 segundo por cada
			DECFSZ CONTADOR4,F	; decremento del cuarto contador (1s x 5 = 5s)
			GOTO RETARDO_4		; Repetimos la accion hasta que sea 0
			RETURN
			
;****************************************************
; Subrutina para configurar los pines de salida
;****************************************************			

CONFIGURAR_PUERTOS	
			BSF	STATUS,RP0
			MOVLW B'11110000'		; Seteamos RB0, RB1, RB2 como salida				
			MOVWF TRISB
			BCF STATUS,RP0
			MOVLW B'00000000'		; Inicialmente, los LEDs estan inhabilitados
			MOVWF PORTB
			RETURN
		

;****************************************************
; Subrutina para encender todos los LEDs
;****************************************************

ENCENDER_TODOS_LOS_LEDS
		
		BSF STATUS,RP0		; Cambiamos al banco 1 para manejar TRISB
		
		MOVLW B'11110000'
		MOVWF TRISB
		
		BCF STATUS,RP0		; Volvemos al banco 0 para manejar PORTB
		
		MOVLW B'00001111'		; Habilitamos los pines
		MOVWF PORTB
		
		CALL DELAY_250MS		; Esperamos 1ms
		
		MOVLW B'00000000'		; Deshabilitamos todos los pines
		MOVWF PORTB
		
		CALL DELAY_1MS		; Esperamos 1 ms (es para que se vea bien en Proteus)
		
		RETURN
	
	
;**********************************************************************
; Subrutina para encender todos los LEDs con 1 segundo de intermitencia
;**********************************************************************

ENCENDER_TODOS_LOS_LEDS_1S

		BSF STATUS,RP0		; Cambiamos al banco 1 para manejar TRISB
		
		MOVLW B'11110000'
		MOVWF TRISB
		
		BCF STATUS,RP0		; Volvemos al banco 0 para manejar PORTB
		
		MOVLW B'00001111'		; Habilitamos los pines
		MOVWF PORTB
	
		CALL DELAY_1S		; Esperamos 1 segundo
	
		MOVLW B'00000000'		; Deshabilitamos todos los pines
		MOVWF PORTB
	
		CALL DELAY_1S		; Esperamos 1 segundo (es para que se vea bien en Proteus)
		
		RETURN

;******************************************************************************
; Subrutina para encender todos los LEDs con 1 segundo y 500ms de intermitencia
;******************************************************************************

ENCENDER_TODOS_LOS_LEDS_1S_500MS 

		BSF STATUS,RP0		; Cambiamos al banco 1 para manejar TRISB
		
		MOVLW B'11110000'
		MOVWF TRISB
		
		BCF STATUS,RP0		; Volvemos al banco 0 para manejar PORTB
		
		MOVLW B'00001111'		; Habilitamos los pines
		MOVWF PORTB
	
		CALL DELAY_1S		; Esperamos 1 segundo
	
		MOVLW B'00000000'		; Deshabilitamos todos los pines
		MOVWF PORTB
	
		CALL DELAY_250MS		; Esperamos 500ms
		CALL DELAY_250MS
		
		RETURN
		

;************************************************************************
; Subrutina para encender todos los leds linealmente con 500ms de retardo
;************************************************************************
		
ENCENDER_LEDS_DE_A_UNO_500MS

		BSF STATUS,RP0		; Cambiamos al banco 1 para manejar TRISB
		
		MOVLW B'11110000'
		MOVWF TRISB
		
		BCF STATUS,RP0		; Volvemos al banco 0 para manejar PORTB
		
		BSF PORTB,0			; Habilitamos el pin RB0 y esperamos 500ms
		CALL DELAY_250MS
		CALL DELAY_250MS
		
		BSF PORTB,1			; Habilitamos el pin RB1 y esperamos 500ms
		CALL DELAY_250MS
		CALL DELAY_250MS
		
		BSF PORTB,2			; Habilitamos el pin RB2 y esperamos 500ms
		CALL DELAY_250MS
		CALL DELAY_250MS
		
		BSF PORTB,3			; Habilitamos el pin RB3 y esperamos 500ms
		CALL DELAY_250MS
		CALL DELAY_250MS
		
		MOVLW B'00000000'		; Deshabilitamos todos los pines
		MOVWF PORTB
		
		CALL DELAY_250MS		; Esperamos 500ms para visualizarlo en Proteus
		CALL DELAY_250MS
	
		RETURN


;************************************************************
; Subrutina para encender todos los LEDs con 500ms de retardo 
; y apagarlos descendentemente con 500ms de retardo
;************************************************************

BUCLE_LEDS_500MS

		BSF STATUS,RP0		; Cambiamos al banco 1 para manejar TRISB
		
		MOVLW B'11110000'
		MOVWF TRISB
		
		BCF STATUS,RP0		; Volvemos al banco 0 para manejar PORTB
		
		BSF PORTB,0			; Habilitamos el pin RB0 y esperamos 500ms
		CALL DELAY_250MS
		CALL DELAY_250MS
		
		BSF PORTB,1			; Habilitamos el pin RB1 y esperamos 500ms
		CALL DELAY_250MS
		CALL DELAY_250MS
		
		BSF PORTB,2			; Habilitamos el pin RB2 y esperamos 500ms
		CALL DELAY_250MS
		CALL DELAY_250MS
		
		BSF PORTB,3			; Habilitamos el pin RB3 y esperamos 500ms
		CALL DELAY_250MS
		CALL DELAY_250MS
		
		
		BCF PORTB,3			; Deshabilitamos el pin RB3 y esperamos 500ms
		CALL DELAY_250MS
		CALL DELAY_250MS
		
		BCF PORTB,2			; Deshabilitamos el pin RB2 y esperamos 500ms
		CALL DELAY_250MS
		CALL DELAY_250MS
		
		BCF PORTB,1			; Deshabilitamos el pin RB1 y esperamos 500ms
		CALL DELAY_250MS
		CALL DELAY_250MS
		
		BCF PORTB,0			; Deshabilitamos el pin RB0 y esperamos 500ms
		CALL DELAY_250MS
		CALL DELAY_250MS
	
		RETURN	
		
		END