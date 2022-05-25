lorom

; patch against JP 1.0 ROMs and derivates
;check title "ZELDANODENSETSU      "

VMADDR = $002116
VMADDL = $002116
VMADDH = $002117

VMDATA = $002118
VMDATAL = $002118
VMDATAH = $002119

DMAENABLE = $00420B

DMA0MODE = $004300
DMA0ADDRL = $004302
DMA0ADDRH = $004303
DMA0ADDRB = $004304
DMA0SIZE = $004305

org $00877E
;#_00877E: SEP #$20
;#_008780: RTS
    JMP.w $CF46

; original routine in NMI to update BG3 for HUD:
org $008B71
#_008B71: LDX.w #$7EC900>>0
#_008B74: STX.w DMA0ADDRL

#_008B77: LDA.b #$7EC900>>16
#_008B79: STA.w DMA0ADDRB

#_008B7C: LDX.w #$0180
#_008B7F: STX.w DMA0SIZE

#_008B82: LDA.b #$01
#_008B84: STA.w DMAENABLE

; free space for patch code:
org $00CF46
NULL_00CF46:
    SEP   #$20
    LDA.b $16
    BEQ .skip_BG3

    ; operate in bank $7E
    PHB
    LDA.b #$7E : PHA : PLB

    REP   #$30
    LDA.w #$4000 ; hflip bit
    STA.b $0E

    ; clear tilemap beyond $14A range up to $180
    LDA.w #$207F
    LDY.w #$7E-$4A
-
    STA.w $C700+$14A, Y
    DEY : DEY
    BPL -

    ; toggle hflip bit in each word and reverse X positions
    LDY.w #$0000
    LDX.w #$003E
-
    LDA.w $C700+$000, X
    EOR.w $0E
    STA.w $C900+$000, Y

    LDA.w $C700+$040, X
    EOR.w $0E
    STA.w $C900+$040, Y

    LDA.w $C700+$080, X
    EOR.w $0E
    STA.w $C900+$080, Y

    LDA.w $C700+$0C0, X
    EOR.w $0E
    STA.w $C900+$0C0, Y

    LDA.w $C700+$100, X
    EOR.w $0E
    STA.w $C900+$100, Y

    LDA.w $C700+$140, X
    EOR.w $0E
    STA.w $C900+$140, Y

    INY : INY
    DEX : DEX
    BPL   -

    PLB
.skip_BG3:
    SEP   #$30
    RTS

warnpc $00CFC0
