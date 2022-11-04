;logical AND, OR and XOR operations
;output displayed using 7447 IC

.include "/sdcard/Download/IITH/assembly/m328Pdef.inc"

ldi r16, 0b00111100 ;identifying output pins 2,3,4,5
out DDRD,r16		;declaring pins as output

ldi r17,0b11110000
out DDRB,r17 ;identifyinh input pins 8,9,10,11

ldi r17,0b11111111
out PORTB,r17  ;activating internal pullup for pins 8,9,10,11

start:

in r25,PINB


ldi r16,0b00000001	;initializing W
and r16,r25

ldi r17,0b00000010	;initializing X
and r17,r25
lsr r17

ldi r18,0b00000100	;initializing Y
and r18,r25
lsr r18
lsr r18

ldi r19,0b00001000	;initializing Z
and r19,r25
lsr r19
lsr r19
lsr r19

mov r20,r16
mov r21,r17
mov r22,r18
mov r23,r19

mov r4,r20
ldi r20,0b00000001
eor r20,r4  ;W'

mov r5,r20  ;value o A

mov r20,r16
mov r21,r17
mov r22,r18
mov r23,r19

mov r4,r21
ldi r21,0b00000001
eor r21,r4

mov r4,r23,
ldi r23,0b00000001
eor r23,r4

and r21,r23
and r20,r21
mov r6,r20  ;wx'z'

mov r21,r17
mov r20,r16

mov r4,r20
ldi r20,0b00000001
eor r20,r4

and r21,r20 ;w'x
or r6,r21 ;wx'z'+w'x  value of B

mov r20,r16
mov r21,r17
mov r22,r18
mov r23,r19

mov r4,r22
ldi r22,0b00000001
eor r22,r4

and r22,r20
and r22,r21
mov r7,r22  ;wxy'

mov r21,r17
mov r22,r18

mov r4,r21
ldi r21,0b00000001
eor r21,r4

and r21,r22  ;x'y

or r7,r21  ;wxy'+x'y

mov r20,r16
mov r22,r18

mov r4,r20,
ldi r20,0b00000001
eor r20,r4

and r22,r20  ;w'y
or r7,r22   ;wxy'+x'y+w'y

mov r20,r16
mov r21,r17
mov r22,r18
mov r23,r19

and r20,r21;  wx
and r20,r22;  wxy
mov r8,r20

mov r20,r16
mov r23,r19

mov r4,r20,
ldi r20,0b00000001
eor r20,r4

and r20,r23; w'z
or r8,r20
lsl r8
lsl r8
lsl r8

lsl r7
lsl r7

lsl r6

ldi r16,0b00000000
or r16,r5
or r16,r6
or r16,r7
or r16,r8


;following code is for displaying output
;shifting LSB in r16 to 2nd position
ldi r20, 0b00000010	;counter = 2

rcall loopw		;calling the loopw routine

 out PORTD,r16		;writing output to pins 2,3,4,5



rjmp Start

;loop for bit shifting
loopw:	lsl r16			;left shift
	dec r20			;counter --
	brne	loopw	;if counter != 0
	ret
