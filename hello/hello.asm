;hello
;using assembly language for turning LED on


.include "/sdcard/Download/IITH/assembly/m328Pdef.inc"


  ldi r16,0b00100000
  out DDRB,r16
  ldi r17,0b00100000
  out PortB,r17
Start:
  rjmp Start
