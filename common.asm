;
; common-asm - This is a common/shared asm file that can be used within multiple
; projects to reduce duplicated code. It should only contain the most common of
; routines so that there is no wasted memory usage.
;

; Newline character
NEWLINE = $0D

; Used by the do_print routine to ensure that output is uppercase
UPPERCASE = $8E

; Memory address that contains the length of the message
WRITEMSG_LEN = $0400

; Memory address where do_input stores data
INPUTMSG_PTR = $0402

;
; Write a message to the screen
;
; Parameters:
;   x - the upper byte of ram where the message starts
;   y - the lower byte of ram where the message starts
;   a - the length of the text
;
writemsg:
    stx ZP_PTR_1
    sty ZP_PTR_1+1
    sta WRITEMSG_LEN
    ldy #0
    lda #UPPERCASE
    jsr CHROUT
    @writemsg_loop:
        cpy WRITEMSG_LEN
        beq @writemsg_done
        lda (ZP_PTR_1),y
        jsr CHROUT
        iny
        bra @writemsg_loop
    @writemsg_done:
        rts

;
; Print a newline to the screen
;
writenl:
    lda #NEWLINE
    jsr CHROUT
    rts

;
; Request input from the user
; 
; Keeps reading characters from the user until a NEWLINE character is received. 
; 
; Stores result at INPUTMSG_PTR (default $0402). The first byte of the result is the input length
;
inputmsg: ; input subroutine. Saves length at INPUTMSG_PTR and data starts at following byte
    ldy #1 ; Start at 1 because we want INPUTMSG_PTR to have the Y value
    @inputmsg_loop:
        jsr CHRIN
        cmp #NEWLINE
        beq @inputmsg_done
        sta INPUTMSG_PTR,y
        iny
        bra @inputmsg_loop
    @inputmsg_done:
        dey ; Decrease for the initial 1
        sty INPUTMSG_PTR
        rts