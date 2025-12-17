.MODEL SMALL
.STACK 100H
.DATA
    MSG1 DB 'Enter decimal number (0-65535): $'
    MSG2 DB 0DH,0AH,'Hexadecimal equivalent: $'
    MSG3 DB 0DH,0AH,'Invalid input! Enter digits 0-9 only$'
    NUM DW 0
    TEN DW 10

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    CALL INPUT       ; Get decimal input
    CALL CONVERSION  ; Convert to hexadecimal
    CALL OUTPUT      ; Display result
    
    MOV AH, 4CH
    INT 21H
MAIN ENDP

INPUT PROC
    ; Display prompt
    LEA DX, MSG1
    MOV AH, 09H
    INT 21H
    
    MOV NUM, 0       ; Initialize number
    
READ_DECIMAL:
    MOV AH, 01H      ; Read character
    INT 21H
    
    CMP AL, 0DH      ; Check for Enter key
    JE INPUT_DONE
    
    CMP AL, '0'      ; Validate digit
    JB INVALID_INPUT
    CMP AL, '9'
    JA INVALID_INPUT
    
    SUB AL, 30H      ; Convert ASCII to number
    MOV AH, 0
    MOV BX, AX       ; Save digit in BX
    
    MOV AX, NUM      ; Current number * 10
    MUL TEN
    
    ADD AX, BX       ; Add new digit
    MOV NUM, AX
    
    JMP READ_DECIMAL

INVALID_INPUT:
    LEA DX, MSG3
    MOV AH, 09H
    INT 21H
    MOV AH, 4CH
    INT 21H
    
INPUT_DONE:
    RET
INPUT ENDP

CONVERSION PROC
    ; Conversion is handled during output
    ; since we already have the number in binary form
    RET
CONVERSION ENDP

OUTPUT PROC
    ; Display message
    LEA DX, MSG2
    MOV AH, 09H
    INT 21H
    
    MOV BX, NUM      ; Get number to convert
    MOV CX, 4        ; Counter for 4 hex digits
    
PRINT_HEX:
    MOV DL, BH       ; Get high nibble
    SHR DL, 4
    
    CMP DL, 9        ; Convert to ASCII
    JBE NUMERIC
    ADD DL, 37H      ; Convert to A-F
    JMP DISPLAY
    
NUMERIC:
    ADD DL, 30H      ; Convert to 0-9
    
DISPLAY:
    MOV AH, 02H      ; Display character
    INT 21H
    
    SHL BX, 4        ; Shift to next nibble
    DEC CX
    JNZ PRINT_HEX
    
    RET
OUTPUT ENDP

END MAIN