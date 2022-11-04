;using assembly language for 
;output F in Qno 10 of Gate2020
.include "/sdcard/Download/IITH/assembly/m328Pdef.inc"

  
;Configuring pins 2-4 (PD2-PD4) of Arduino
;as input
  ldi r16,0b11100011  ;identifyinh input D2,D3,D4 of arduino
  out DDRD,r16

  ldi r16,0b11111111  ;activating internal pull up for D2,D3,D4 input of arduino
  out PORTD,r16

;Configuring pin 13 (PB5) of Arduino
;as output 
  ldi r16,0b00100000
  out DDRB,r16

start:
   in r16,PIND

   ldi r17,0b00000100
   ldi r18,0b00001000
   ldi r19,0b00010000

   and r17,r16  
   and r18,r16
   and r19,r16
   
   lsr r17
   lsr r17   ;P

   lsr r18
   lsr r18
   lsr r18   ;Q

   lsr r19  
   lsr r19  
   lsr r19
   lsr r19  ;R

   

   ldi r20,0b00000001
   and r20,r17
   and r20,r18  ;pQ

   ldi r21,0b00000001
   eor r21,r18  ;Q'

   and r21,r19  ;Q'R

   or r20,r21  ;F=PQ+Q'R
   
   
   ldi r23,0b00000101

   rcall looplsl
   out PORTB,r20
   rjmp start

looplsl:
  lsl r20
  dec r23
  brne looplsl
  ret
  
