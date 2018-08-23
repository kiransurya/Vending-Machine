
_adc_vlu_get:

;D,44 :: 		
;D,46 :: 		
	CLRF       _adc_vlu+0
	CLRF       _adc_vlu+1
;D,47 :: 		
	BSF        ADCON0+0, 2
;D,48 :: 		
L_adc_vlu_get0:
	BTFSC      PIR1+0, 6
	GOTO       L_adc_vlu_get1
	GOTO       L_adc_vlu_get0
L_adc_vlu_get1:
;D,49 :: 		
	MOVF       ADRESH+0, 0
	MOVWF      _adc_vlu+0
	CLRF       _adc_vlu+1
;D,50 :: 		
	MOVF       _adc_vlu+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       R0+0, 0
	MOVWF      _adc_vlu+0
	MOVF       R0+1, 0
	MOVWF      _adc_vlu+1
;D,51 :: 		
	MOVF       ADRESL+0, 0
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      _adc_vlu+0
	MOVF       R0+1, 0
	MOVWF      _adc_vlu+1
;D,52 :: 		
	BCF        PIR1+0, 6
;D,53 :: 		
;D,54 :: 		
L_end_adc_vlu_get:
	RETURN
; end of _adc_vlu_get

_main:

;D,56 :: 		
;D,58 :: 		
	MOVLW      255
	MOVWF      TRISA+0
;D,59 :: 		
	MOVLW      255
	MOVWF      TRISE+0
;D,60 :: 		
	MOVLW      130
	MOVWF      ADCON1+0
;D,61 :: 		
	MOVLW      1
	MOVWF      ADCON0+0
;D,62 :: 		
	CLRF       TRISB+0
;D,63 :: 		
	CLRF       TRISC+0
;D,64 :: 		
	CLRF       TRISD+0
;D,65 :: 		
	BCF        PORTB+0, 5
;D,66 :: 		
	BCF        PORTC+0, 0
;D,67 :: 		
	BCF        PORTD+0, 1
;D,68 :: 		
	BCF        PORTB+0, 5
;D,70 :: 		
	MOVLW      65
	MOVWF      R12+0
	MOVLW      238
	MOVWF      R13+0
L_main2:
	DECFSZ     R13+0, 1
	GOTO       L_main2
	DECFSZ     R12+0, 1
	GOTO       L_main2
	NOP
;D,71 :: 		
	BSF        PORTB+0, 5
;D,72 :: 		
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main3:
	DECFSZ     R13+0, 1
	GOTO       L_main3
	DECFSZ     R12+0, 1
	GOTO       L_main3
	NOP
	NOP
;D,75 :: 		
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _irReceiverValue+0
	MOVF       R0+1, 0
	MOVWF      _irReceiverValue+1
;D,80 :: 		
	MOVLW      0
	SUBWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main51
	MOVLW      140
	SUBWF      R0+0, 0
L__main51:
	BTFSC      STATUS+0, 0
	GOTO       L_main4
;D,82 :: 		
	BCF        PORTC+0, 0
;D,84 :: 		
	GOTO       L_main5
L_main4:
;D,86 :: 		
	MOVF       _irReceiverValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main52
	MOVF       _irReceiverValue+0, 0
	SUBLW      136
L__main52:
	BTFSC      STATUS+0, 0
	GOTO       L_main6
;D,88 :: 		
	BSF        PORTC+0, 0
;D,89 :: 		
L_main6:
L_main5:
;D,94 :: 		
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main7:
	DECFSZ     R13+0, 1
	GOTO       L_main7
	DECFSZ     R12+0, 1
	GOTO       L_main7
	NOP
	NOP
;D,96 :: 		
L_main8:
;D,99 :: 		
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _irReceiverValue+0
	MOVF       R0+1, 0
	MOVWF      _irReceiverValue+1
;D,100 :: 		
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_main10:
	DECFSZ     R13+0, 1
	GOTO       L_main10
	DECFSZ     R12+0, 1
	GOTO       L_main10
	NOP
	NOP
;D,101 :: 		
	MOVLW      1
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _coinSwitchValue+0
	MOVF       R0+1, 0
	MOVWF      _coinSwitchValue+1
;D,102 :: 		
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_main11:
	DECFSZ     R13+0, 1
	GOTO       L_main11
	DECFSZ     R12+0, 1
	GOTO       L_main11
	NOP
	NOP
;D,103 :: 		
	MOVLW      2
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _zeroPositionValue1+0
	MOVF       R0+1, 0
	MOVWF      _zeroPositionValue1+1
;D,104 :: 		
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_main12:
	DECFSZ     R13+0, 1
	GOTO       L_main12
	DECFSZ     R12+0, 1
	GOTO       L_main12
	NOP
	NOP
;D,105 :: 		
	MOVLW      0
	BTFSC      PORTE+0, 0
	MOVLW      1
	MOVWF      _dispensing+0
	CLRF       _dispensing+1
;D,124 :: 		
	MOVLW      0
	SUBWF      _irReceiverValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main53
	MOVLW      140
	SUBWF      _irReceiverValue+0, 0
L__main53:
	BTFSC      STATUS+0, 0
	GOTO       L_main13
;D,126 :: 		
	BCF        PORTC+0, 0
;D,128 :: 		
L_main13:
;D,129 :: 		
	MOVF       _irReceiverValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main54
	MOVF       _irReceiverValue+0, 0
	SUBLW      136
L__main54:
	BTFSC      STATUS+0, 0
	GOTO       L_main14
;D,131 :: 		
	BSF        PORTC+0, 0
;D,133 :: 		
L_main14:
;D,138 :: 		
	BCF        PORTB+0, 5
;D,139 :: 		
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main15:
	DECFSZ     R13+0, 1
	GOTO       L_main15
	DECFSZ     R12+0, 1
	GOTO       L_main15
	NOP
	NOP
;D,141 :: 		
	MOVLW      0
	XORWF      _dispensing+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main55
	MOVLW      1
	XORWF      _dispensing+0, 0
L__main55:
	BTFSS      STATUS+0, 2
	GOTO       L_main16
;D,144 :: 		
	BSF        PORTD+0, 1
;D,146 :: 		
	CLRF       _i+0
	CLRF       _i+1
L_main17:
	MOVLW      0
	SUBWF      _i+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main56
	MOVLW      200
	SUBWF      _i+0, 0
L__main56:
	BTFSC      STATUS+0, 0
	GOTO       L_main18
;D,148 :: 		
	BSF        PORTD+0, 1
;D,149 :: 		
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_main20:
	DECFSZ     R13+0, 1
	GOTO       L_main20
	DECFSZ     R12+0, 1
	GOTO       L_main20
	NOP
	NOP
;D,150 :: 		
	BCF        PORTD+0, 1
;D,151 :: 		
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_main21:
	DECFSZ     R13+0, 1
	GOTO       L_main21
	DECFSZ     R12+0, 1
	GOTO       L_main21
	NOP
	NOP
;D,146 :: 		
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;D,153 :: 		
	GOTO       L_main17
L_main18:
;D,156 :: 		
L_main16:
;D,157 :: 		
	MOVLW      0
	XORWF      _dispensing+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main57
	MOVLW      0
	XORWF      _dispensing+0, 0
L__main57:
	BTFSS      STATUS+0, 2
	GOTO       L_main22
;D,160 :: 		
	BCF        PORTD+0, 1
;D,161 :: 		
L_main22:
;D,163 :: 		
	MOVLW      0
	SUBWF      _coinSwitchValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main58
	MOVLW      20
	SUBWF      _coinSwitchValue+0, 0
L__main58:
	BTFSS      STATUS+0, 0
	GOTO       L_main23
;D,165 :: 		
	MOVLW      1
	MOVWF      _coinSwitchToggleFlag+0
	MOVLW      0
	MOVWF      _coinSwitchToggleFlag+1
;D,166 :: 		
L_main23:
;D,168 :: 		
	MOVLW      0
	SUBWF      _coinSwitchValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main59
	MOVLW      20
	SUBWF      _coinSwitchValue+0, 0
L__main59:
	BTFSC      STATUS+0, 0
	GOTO       L_main26
	MOVF       _coinSwitchToggleFlag+0, 0
	IORWF      _coinSwitchToggleFlag+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main26
L__main48:
;D,170 :: 		
	MOVLW      65
	MOVWF      R12+0
	MOVLW      238
	MOVWF      R13+0
L_main27:
	DECFSZ     R13+0, 1
	GOTO       L_main27
	DECFSZ     R12+0, 1
	GOTO       L_main27
	NOP
;D,171 :: 		
	INCF       _coinCount+0, 1
	BTFSC      STATUS+0, 2
	INCF       _coinCount+1, 1
;D,172 :: 		
	CLRF       _coinSwitchToggleFlag+0
	CLRF       _coinSwitchToggleFlag+1
;D,173 :: 		
L_main26:
;D,174 :: 		
	BTFSS      PORTA+0, 3
	GOTO       L_main30
	MOVLW      0
	SUBWF      _irReceiverValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main60
	MOVLW      140
	SUBWF      _irReceiverValue+0, 0
L__main60:
	BTFSC      STATUS+0, 0
	GOTO       L_main30
L__main47:
;D,176 :: 		
	MOVLW      65
	MOVWF      R12+0
	MOVLW      238
	MOVWF      R13+0
L_main31:
	DECFSZ     R13+0, 1
	GOTO       L_main31
	DECFSZ     R12+0, 1
	GOTO       L_main31
	NOP
;D,177 :: 		
	INCF       _coinCount+0, 1
	BTFSC      STATUS+0, 2
	INCF       _coinCount+1, 1
;D,178 :: 		
	CLRF       _coinSwitchToggleFlag+0
	CLRF       _coinSwitchToggleFlag+1
;D,179 :: 		
L_main30:
;D,183 :: 		
	MOVLW      0
	XORWF      _coinCount+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main61
	MOVLW      1
	XORWF      _coinCount+0, 0
L__main61:
	BTFSS      STATUS+0, 2
	GOTO       L_main32
;D,187 :: 		
	MOVLW      0
	SUBWF      _numberOfNapkins+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main62
	MOVLW      2
	SUBWF      _numberOfNapkins+0, 0
L__main62:
	BTFSC      STATUS+0, 0
	GOTO       L_main34
;D,190 :: 		
L_main35:
	MOVLW      1
	MOVWF      _zeroPositionValue1+0
	MOVLW      0
	MOVWF      _zeroPositionValue1+1
;D,193 :: 		
	BSF        PORTD+0, 1
;D,195 :: 		
	CLRF       _i+0
	CLRF       _i+1
L_main37:
	MOVLW      0
	SUBWF      _i+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main63
	MOVLW      200
	SUBWF      _i+0, 0
L__main63:
	BTFSC      STATUS+0, 0
	GOTO       L_main38
;D,197 :: 		
	BSF        PORTD+0, 1
;D,198 :: 		
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_main40:
	DECFSZ     R13+0, 1
	GOTO       L_main40
	DECFSZ     R12+0, 1
	GOTO       L_main40
	NOP
	NOP
;D,199 :: 		
	BCF        PORTD+0, 1
;D,200 :: 		
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_main41:
	DECFSZ     R13+0, 1
	GOTO       L_main41
	DECFSZ     R12+0, 1
	GOTO       L_main41
	NOP
	NOP
;D,195 :: 		
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;D,202 :: 		
	GOTO       L_main37
L_main38:
;D,204 :: 		
	INCF       _numberOfNapkins+0, 1
	BTFSC      STATUS+0, 2
	INCF       _numberOfNapkins+1, 1
;D,205 :: 		
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main42:
	DECFSZ     R13+0, 1
	GOTO       L_main42
	DECFSZ     R12+0, 1
	GOTO       L_main42
	DECFSZ     R11+0, 1
	GOTO       L_main42
	NOP
;D,207 :: 		
	GOTO       L_main35
;D,208 :: 		
L_main34:
;D,212 :: 		
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _irReceiverValue+0
	MOVF       R0+1, 0
	MOVWF      _irReceiverValue+1
;D,214 :: 		
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_main43:
	DECFSZ     R13+0, 1
	GOTO       L_main43
	DECFSZ     R12+0, 1
	GOTO       L_main43
	NOP
	NOP
;D,216 :: 		
	MOVLW      0
	SUBWF      _irReceiverValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main64
	MOVLW      140
	SUBWF      _irReceiverValue+0, 0
L__main64:
	BTFSC      STATUS+0, 0
	GOTO       L_main44
;D,218 :: 		
	BCF        PORTC+0, 0
;D,219 :: 		
L_main44:
;D,220 :: 		
	MOVF       _irReceiverValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main65
	MOVF       _irReceiverValue+0, 0
	SUBLW      136
L__main65:
	BTFSC      STATUS+0, 0
	GOTO       L_main45
;D,222 :: 		
	BSF        PORTC+0, 0
;D,223 :: 		
L_main45:
;D,228 :: 		
	BCF        PORTB+0, 5
;D,229 :: 		
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main46:
	DECFSZ     R13+0, 1
	GOTO       L_main46
	DECFSZ     R12+0, 1
	GOTO       L_main46
	NOP
	NOP
;D,232 :: 		
	CLRF       _numberOfNapkins+0
	CLRF       _numberOfNapkins+1
;D,233 :: 		
	CLRF       _stepCount+0
	CLRF       _stepCount+1
;D,234 :: 		
	CLRF       _coinSwitchValue+0
	CLRF       _coinSwitchValue+1
;D,235 :: 		
	CLRF       _coinCount+0
	CLRF       _coinCount+1
;D,236 :: 		
	CLRF       _irReceiverValue+0
	CLRF       _irReceiverValue+1
;D,237 :: 		
	CLRF       _zeroPositionValue1+0
	CLRF       _zeroPositionValue1+1
;D,238 :: 		
	CLRF       _coinSwitchToggleFlag+0
	CLRF       _coinSwitchToggleFlag+1
;D,242 :: 		
L_main32:
;D,243 :: 		
	GOTO       L_main8
;D,244 :: 		
L_end_main:
	GOTO       $+0
; end of _main
