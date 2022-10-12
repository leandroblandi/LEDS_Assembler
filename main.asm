
;*******************************************************************************
;	Programa para encender LEDs
;	de varias formas con subrutinas						Fecha: 07-10-2022
;	- Dispositivo: PIC16F628A
;	- Perro guardian: OFF
;	- Reloj: interno
;	- Proteccion del codigo: OFF
;*******************************************************************************


;*******************************************************************************
; Zona de dat	os
;*******************************************************************************

		__CONFIG 3F01
		LIST 	P=16F628A
		#INCLUDE <P16F628A.INC>
		ERRORLEVEL -302
		ORG 	0x00
	
	
;*******************************************************************************
; Constantes
;*******************************************************************************

CONT 	EQU 0x20
CONT2 	EQU 0x21
CONT3 	EQU 0x22


;*******************************************************************************
; Zona de codigos
;*******************************************************************************
; Subrutina principal
;********************

INICIO	CALL BUCLE_LEDS_500MS
		GOTO INICIO


;****************************************************
; Subrutina para generar retardo de 1ms
;****************************************************


DELAY_1MS	MOVLW D'250'
			MOVWF CONT

LOOP1	NOP
		DECFSZ CONT,F
		GOTO LOOP1
		RETURN


;****************************************************
; Subrutina para generar retardo de 250ms
;****************************************************

DELAY_250MS	MOVLW D'250'		; Cargamos 250 en CONT2
			MOVWF CONT2

LOOP2	CALL DELAY_1MS		; Repetimos 250 veces 1ms
		DECFSZ CONT2,F
		GOTO LOOP2	
		RETURN


;****************************************************
; Subrutina para generar retardo de 1s
;****************************************************

DELAY_1S	MOVLW D'4'			; Cargamos 4 en CONT3
		MOVWF CONT3

LOOP3	CALL DELAY_250MS		; Repetimos 4 veces el 250ms
		DECFSZ CONT3,F
		GOTO LOOP3	
		RETURN


;****************************************************
; Subrutina para encender todos los LEDs
;****************************************************

ENCENDER_TODOS_LOS_LEDS
		
		BSF STATUS,RP0		; Cambiamos al banco 1 para manejar TRISB
	
		BCF TRISB,0			; Seteamos los pines: RB0,RB1,RB2,RB3 como salidas
		BCF TRISB,1
		BCF TRISB,2
		BCF TRISB,3
		
		BCF STATUS,RP0		; Volvemos al banco 0 para manejar PORTB
		BSF PORTB,0
		BSF PORTB,1
		BSF PORTB,2
		BSF PORTB,3
		
		CALL DELAY_1MS		; Esperamos 1ms
		
		BCF PORTB,0			; Deshabilitamos los 4 pines, es decir, apagamos los LED's
		BCF PORTB,1
		BCF PORTB,2
		BCF PORTB,3
		
		CALL DELAY_1MS		; Esperamos 1 ms (es para que se vea bien en Proteus)
		
		RETURN
	
	
;**********************************************************************
; Subrutina para encender todos los LEDs con 1 segundo de intermitencia
;**********************************************************************

ENCENDER_TODOS_LOS_LEDS_1S

		BSF STATUS,RP0		; Cambiamos al banco 1 para manejar TRISB
		
		BCF TRISB,0			; Seteamos los pines: RB0,RB1,RB2,RB3 como salidas
		BCF TRISB,1
		BCF TRISB,2
		BCF TRISB,3
		
		BCF STATUS,RP0		; Volvemos al banco 0 para manejar PORTB
		
		BSF PORTB,0			; Habilitamos los 4 pines para que se enciendan los LED's
		BSF PORTB,1
		BSF PORTB,2
		BSF PORTB,3
	
		CALL DELAY_1S		; Esperamos 1 segundo
	
		BCF PORTB,0			; Deshabilitamos los 4 pines, es decir, apagamos los LED's
		BCF PORTB,1
		BCF PORTB,2
		BCF PORTB,3
	
		CALL DELAY_1S		; Esperamos 1 segundo (es para que se vea bien en Proteus)
		
		RETURN

;******************************************************************************
; Subrutina para encender todos los LEDs con 1 segundo y 500ms de intermitencia
;******************************************************************************

ENCENDER_TODOS_LOS_LEDS_1S_500MS 

		BSF STATUS,RP0		; Cambiamos al banco 1 para manejar TRISB
		
		BCF TRISB,0			; Seteamos los pines: RB0,RB1,RB2,RB3 como salidas
		BCF TRISB,1
		BCF TRISB,2
		BCF TRISB,3
		
		BCF STATUS,RP0		; Volvemos al banco 0 para manejar PORTB
		
		BSF PORTB,0			; Habilitamos los 4 pines para que se enciendan los LED's
		BSF PORTB,1
		BSF PORTB,2
		BSF PORTB,3
	
		CALL DELAY_1S		; Esperamos 1 segundo
	
		BCF PORTB,0			; Deshabilitamos los 4 pines, es decir, apagamos los LED's
		BCF PORTB,1
		BCF PORTB,2
		BCF PORTB,3
	
		CALL DELAY_250MS		; Esperamos 500ms
		CALL DELAY_250MS
		
		RETURN
		

;************************************************************************
; Subrutina para encender todos los leds linealmente con 500ms de retardo
;************************************************************************
		
ENCENDER_LEDS_DE_A_UNO_500MS

		BSF STATUS,RP0		; Cambiamos al banco 1 para manejar TRISB
		
		BCF TRISB,0			; Seteamos los pines: RB0,RB1,RB2,RB3 como salidas
		BCF TRISB,1
		BCF TRISB,2
		BCF TRISB,3
		
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
		
		BCF PORTB,0			; Deshabilitamos todos los pines en manera conjunta
		BCF PORTB,1
		BCF PORTB,2
		BCF PORTB,3
		CALL DELAY_250MS		; Esperamos 500ms para visualizarlo en Proteus
		CALL DELAY_250MS
	
		RETURN


;************************************************************
; Subrutina para encender todos los LEDs con 500ms de retardo 
; y apagarlos descendentemente con 500ms de retardo
;************************************************************

BUCLE_LEDS_500MS

		BSF STATUS,RP0		; Cambiamos al banco 1 para manejar TRISB
		
		BCF TRISB,0			; Seteamos los pines: RB0,RB1,RB2,RB3 como salidas
		BCF TRISB,1
		BCF TRISB,2
		BCF TRISB,3
		
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