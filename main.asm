;
; main.asm - Main entry point for HelloWorld2
;
; HelloWorld2 is a modified version of the typical Hello, World! application but
; instead of simply displaying the customary message, this application will first
; prompt the user for their name, then say "Hello, Name!"
;
; The primary intent for writing this application is trying to understand how input
; and output routines work
;
; This code is written for the 65xx processor primarily targeting the Commander X16
; architecture.
;

; include CX16 constants
.include "x16.inc"

; Set SYS2061 BASIC code
.org $080D
.segment "STARTUP"
.segment "INIT"
.segment "ONCE"
.segment "CODE"

; Jump to starting point
jmp start

; Include application-specific globals
.include "globals.asm"

; Include my shared/common routines
.include "common.asm"

;
; Application start
;
start:
   jsr _writemsg_prompt
   jsr inputmsg
   jsr writenl
   jsr _writemsg_greeting
   lda INPUTMSG_PTR
   ldx #<(INPUTMSG_PTR+1)
   ldy #>(INPUTMSG_PTR+1)
   jsr writemsg
   lda #EXCLAMATION
   jsr CHROUT
   rts