;using assembly language for accessing arduino memory
;to drive a seven segment display


.include "/sdcard/Download/IITH/assembly/m328Pdef.inc"
  ldi r16,0b00000101
  out TCCR0B,r16


  ldi r16,0 		;reset system status
  out SREG,r16		;init stack pointer
  ldi r16,low(RAMEND)	;0xff
  out SPL,r16
  ldi r16,high(RAMEND)	;0x08
  out SPH,r16

  ldi r16,0b00111100	;identifying output pins 2,3,4,5
  out DDRD,r16		;declaring pins as output
  ldi xl,0x00		;loading memory address lower byte into r26
  ldi xh,0x01		;loading memory address higher byte into r27
  ldi r16,0b00000000	;initializing W 
  st  x,r16		;storing W in 0x0100 address
  ldi r17,0x09		;initializing  count

  ;loading numbers 0-9 into memory locations 0x0100-0x0109

loop_cnt:
  
  inc r16		;increment register value
  inc xl		;increment address
  st  x, r16		;store number into memory
  dec r17		;decrement count
  brne loop_cnt 

;start printing numbers from 0-9

Start:

  ldi r17, 0x0A		;load the number 10 in r17
  clr xl		;reset memory to 0x0100

loop_inc:
;writing W to pin 2
  ldi r16, 0b00000010	;counter = 0
  ld  r0, x		;load number from memory

loopw:

  lsl r0		;left shift
  dec r16		;counter --
  brne loopw		;if counter !=0

  out PORTD,r0		;writing output to pins 2,3,4,5
  ldi r19,0b01000000
  call PAUSE		;calling delay

  inc xl		;incrementing address
  dec r17		;decrement decade count
  brne loop_inc 	;branch if decade count !=0
  
  rjmp Start

;delay routine
PAUSE:
lp2:
  IN r20,TIFR0
  ldi r21,0b00000010
  and r20,r21
  breq PAUSE
  OUT TIFR0,r21

  dec r19
  brne lp2
  ret
