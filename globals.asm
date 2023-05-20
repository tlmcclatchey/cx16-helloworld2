;
; globals.asm - Containst application-specific global variables and messages
;

; Character for the exlamation point
EXCLAMATION = '!'

; Initial prompt for asking the user name
msg_prompt: .byte "what is your name? "
_writemsg_prompt:
   lda #19
   ldx #<msg_prompt
   ldy #>msg_prompt
   jsr writemsg
   rts

; Greeting message
msg_greeting: .byte "hello, "
_writemsg_greeting:
   lda #7
   ldx #<msg_greeting
   ldy #>msg_greeting
   jsr writemsg
   rts