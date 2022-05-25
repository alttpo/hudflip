lorom

check title "ZELDANODENSETSU      "

VMADDR = $002116
VMADDL = $002116
VMADDH = $002117

DMAENABLE = $00420B

DMA0MODE = $004300
DMA0ADDRL = $004302
DMA0ADDRH = $004303
DMA0ADDRB = $004304
DMA0SIZE = $004305

; original routine in NMI:
org $008B6B
    JMP.w $CF46
    NOP
    NOP
    NOP

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
    LDX.w $0219
    STX.w VMADDR

    REP   #$20
    LDA.w #$4000 ; hflip bit
    STA.b $0E

    ; toggle hflip bit in each word and reverse X positions
    LDY.w #$0000
    LDX.w #$0080

flip:
    LDA.l $7EC700+$000-2, X
    EOR.w $0E
    PHX : TYX
    STA.l $7EC900+$000, X
    PLX

    LDA.l $7EC700+$080-2, X
    EOR.w $0E
    PHX : TYX
    STA.l $7EC900+$080, X
    PLX

    LDA.l $7EC700+$100-2, X
    EOR.w $0E
    PHX : TYX
    STA.l $7EC900+$100, X
    PLX

    INY : INY
    DEX : DEX
    BNE   flip

    SEP #$20
    JMP.w $8B71

warnpc $00CFC0
