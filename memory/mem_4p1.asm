.include "/sdcard/Download/IITH/assembly/m328Pdef.inc"

;works as 1 second delay on arduino: 16 MHz (16x10^6)

sbi DDRB, 5 ;set pin 13 as output pin (DDRB pin 5)
ldi r16, 0b00000101 ;the last 3 bits define the prescaler, 101 => division by 1024
out TCCR0B, r16 
;prescalar used = 1024. So new freq. of clock cycle = (16 MHz / 1024) = 16 kHz

clr r18 ;output bits. we are only interested in bit 6 from the right.

ldi xl,0x00;loading memory address lower byte into r26
ldi xh,0x01;loading memory address higher byte into r27

ldi r16,0b00100000	;initializing W

st x,r16      ;storing W in 0x0100 address

loop:
  	ld r16,x   ;load number from memory
	eor r18, r16 		;change the output of LED
	out PORTB, r18 
	ldi r19, 0b01000000 ;times to run the loop = 64 for 1 second delay
	rcall PAUSE 		;call the PAUSE label
	rjmp loop
	
PAUSE:	;this is delay (function)
lp2:	;loop runs 64 times
		IN r16, TIFR0 ;tifr is timer interupt flag (8 bit timer runs 256 times)
		ldi r17, 0b00000010
		AND r16, r17 ;need second bit
		BREQ PAUSE 
		OUT TIFR0, r17	;set tifr flag high
	dec r19
	brne lp2
	ret

;prescalar * loop_iterations * timer_duration =~ 16 million cycles
;16 million cycles at 16 MHz = 1 second
