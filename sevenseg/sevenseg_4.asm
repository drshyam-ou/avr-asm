;using assembly language for 
;displaying number on
;seven segment display

.include "/sdcard/Download/IITH/assembly/m328Pdef.inc"
  ldi r16,0b00000101
  out TCCR0B,r16
  clr r18


  
;Configuring pins 2-7 (PD2-PD7) of Arduino
;as output
  ldi r16,0b11111100
  out DDRD,r16
;Configuring pin 8 (PB0) of Arduino
;as output 
  ldi r16,0b00000001
  out DDRB,r16
;Writing the number 0 to 9 on the 
;seven segment display
Start:
  
  
  ldi r17,0b00000000  ;display 0
  out PortD,r17
  ldi r17,0b00000001
  out PortB,r17
  ldi r19,0b01000000
  rcall PAUSE
 

  ldi r17,0b11100100  ;display 1
  out PortD,r17
  ldi r17,0b00000001
  out PortB,r17
  ldi r19,0b01000000
  rcall PAUSE

  ldi r17,0b10010000 ;display 2
  out PortD,r17
  ldi r17,0b00000000
  out PortB,r17
  ldi r19,0b01000000
  rcall PAUSE

  ldi r17,0b11000000 ;display 3
  out PortD,r17
  ldi r17,0b00000000
  out PortB,r17
  ldi r19,0b01000000
  rcall PAUSE
  
  
  ldi r17,0b01100100 ; display 4
  out PortD,r17
  ldi r17,0b00000000
  out PortB,r17
  ldi r19,0b01000000
  rcall PAUSE
  
  
  ldi r17,0b01001000 ; display 5
  out PortD,r17
  ldi r17,0b00000000
  out PortB,r17
  ldi r19,0b01000000
  rcall PAUSE
 
  ldi r17,0b00001100 ; display 6
  out PortD,r17
  ldi r17,0b00000000
  out PortB,r17
  ldi r19,0b01000000
  rcall PAUSE
  

  
  ldi r17,0b11100000 ; display 7
  out PortD,r17
  ldi r17,0b00000001
  out PortB,r17
  ldi r19,0b01000000
  rcall PAUSE

  ldi r17,0b00000000 ; display 8
  out PortD,r17
  ldi r17,0b00000000
  out PortB,r17
  ldi r19,0b01000000
  rcall PAUSE
  
  ldi r17,0b01100000 ; display 9
  out PortD,r17
  ldi r17,0b00000000
  out PortB,r17
  ldi r19,0b01000000
  rcall PAUSE
  rjmp start



PAUSE:
lp2:
  IN r16,TIFR0
  ldi r17,0b00000010
  AND r16,r17
  BREQ PAUSE
  OUT TIFR0,r17
  dec r19
  brne lp2
  ret
