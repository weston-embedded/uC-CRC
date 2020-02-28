;********************************************************************************************************
;                                               uC/CRC
;           ERROR DETECTING CODE (EDC) & ERROR CORRECTING CODE (ECC) CALCULATION UTILITIES
;
;                    Copyright 2007-2020 Silicon Laboratories Inc. www.silabs.com
;
;                                 SPDX-License-Identifier: APACHE-2.0
;
;               This software is subject to an open source license and is distributed by
;                Silicon Laboratories Inc. pursuant to the terms of the Apache License,
;                    Version 2.0 available at www.apache.org/licenses/LICENSE-2.0.
;
;********************************************************************************************************


;********************************************************************************************************
;
;                                      HAMMING CODE CALCULATION
;
;                                                ARM
;                                            IAR Compiler
;
; Filename : ecc_hamming_a.asm
; Version  : V1.10.00
;********************************************************************************************************
; Note(s)  : (1) Assumes ARM CPU mode configured for Little Endian.
;********************************************************************************************************


;********************************************************************************************************
;                                          PUBLIC FUNCTIONS
;********************************************************************************************************

        PUBLIC Hamming_ParCalcBitWord_32


;********************************************************************************************************
;                                     CODE GENERATION DIRECTIVES
;********************************************************************************************************

        RSEG CODE:CODE:NOROOT(2)
        CODE32


;********************************************************************************************************
;                                     Hamming_ParCalcBitWord_32()
;
; Description : Calculate bit & word-wise parity for 32 4-byte words (a 128-byte buffer).
;
; Argument(s) : pbuf            Pointer to buffer that contains the data.
;
;               ppar_bit        Pointer to variable that will receive the  bit-wise parity.
;
;               ppar_word       Pointer to variable that will receive the word-wise parity.
;
; Return(s)   : none.
;
; Caller(s)   : Hamming_Calc(),
;               Hamming_Calc_XXXX().
;
; Note(s)     : none.
;********************************************************************************************************

; void  Hamming_ParCalcBitWord_32 (void        *pbuf,      @       ==>  R0
;                                  CPU_INT32U  *ppar_bit,  @       ==>  R1
;                                  CPU_INT32U  *ppar_word) @       ==>  R2
;                                               par_bit    @       ==>  R3
;                                               par_word   @       ==>  R4
;                                               cnt        @       ==>  R5



Hamming_ParCalcBitWord_32:
        STMDB       SP!, {R0, R3-R9}

        MOV         R3,  #0x00
        MOV         R4,  #0x00
        MOV         R5,  #0x20

Hamming_ParCalcBitWord_32_Loop:                                 ;   while (cnt > 0) {
        LDMIA       R0!, {R6-R9}                                ;       data_01   = *pbuf_32++;
                                                                ;       data_02   = *pbuf_32++;
                                                                ;       data_03   = *pbuf_32++;
                                                                ;       data_04   = *pbuf_32++;

        EOR         R3,  R6,  R3                                ;       par_bit  ^= data_01;
        EOR         R3,  R7,  R3                                ;       par_bit  ^= data_02;
        EOR         R3,  R8,  R3                                ;       par_bit  ^= data_03;
        EOR         R3,  R9,  R3                                ;       par_bit  ^= data_04;

        EOR         R6,  R6,  R6,  LSR #16                      ;       datum     = (data_01 >> 16) ^ data_01;
        EOR         R6,  R6,  R6,  LSR #8                       ;       datum     = (datum   >>  8) ^ datum;
        EOR         R6,  R6,  R6,  LSR #4                       ;       datum     = (datum   >>  4) ^ datum;
        EOR         R6,  R6,  R6,  LSR #2                       ;       datum     = (datum   >>  2) ^ datum;
        EOR         R6,  R6,  R6,  LSR #1                       ;       datum     = (datum   >>  1) ^ datum;
        AND         R6,  R6,  #0x01                             ;       datum    &=  DEF_BIT_00;
        ORR         R4,  R6,  R4,  LSL #1                       ;       par_word  = (par_word << 1) | datum;

        EOR         R6,  R7,  R7,  LSR #16                      ;       data_02   = (data_02 >> 16) ^ data_02;
        EOR         R6,  R6,  R6,  LSR #8                       ;       datum     = (datum   >>  8) ^ datum;
        EOR         R6,  R6,  R6,  LSR #4                       ;       datum     = (datum   >>  4) ^ datum;
        EOR         R6,  R6,  R6,  LSR #2                       ;       datum     = (datum   >>  2) ^ datum;
        EOR         R6,  R6,  R6,  LSR #1                       ;       datum     = (datum   >>  1) ^ datum;
        AND         R6,  R6,  #0x01                             ;       datum    &=  DEF_BIT_00;
        ORR         R4,  R6,  R4,  LSL #1                       ;       par_word  = (par_word << 1) | datum;

        EOR         R6,  R8,  R8,  LSR #16                      ;       data_03   = (data_03 >> 16) ^ data_03;
        EOR         R6,  R6,  R6,  LSR #8                       ;       datum     = (datum   >>  8) ^ datum;
        EOR         R6,  R6,  R6,  LSR #4                       ;       datum     = (datum   >>  4) ^ datum;
        EOR         R6,  R6,  R6,  LSR #2                       ;       datum     = (datum   >>  2) ^ datum;
        EOR         R6,  R6,  R6,  LSR #1                       ;       datum     = (datum   >>  1) ^ datum;
        AND         R6,  R6,  #0x01                             ;       datum    &=  DEF_BIT_00;
        ORR         R4,  R6,  R4,  LSL #1                       ;       par_word  = (par_word << 1) | datum;

        EOR         R6,  R9,  R9,  LSR #16                      ;       data_04   = (data_04 >> 16) ^ data_04;
        EOR         R6,  R6,  R6,  LSR #8                       ;       datum     = (datum   >>  8) ^ datum;
        EOR         R6,  R6,  R6,  LSR #4                       ;       datum     = (datum   >>  4) ^ datum;
        EOR         R6,  R6,  R6,  LSR #2                       ;       datum     = (datum   >>  2) ^ datum;
        EOR         R6,  R6,  R6,  LSR #1                       ;       datum     = (datum   >>  1) ^ datum;
        AND         R6,  R6,  #0x01                             ;       datum    &=  DEF_BIT_00;
        ORR         R4,  R6,  R4,  LSL #1                       ;       par_word  = (par_word << 1) | datum;

        SUBS        R5,  R5,  #0x04                             ;       cnt      -= 4;
        BNE         Hamming_ParCalcBitWord_32_Loop              ;   }

        STR         R3, [R1, #+0]                               ;  *ppar_bit  = par_bit;
        STR         R4, [R2, #+0]                               ;  *ppar_word = par_word;

        LDMIA       SP!, {R0, R3-R9}
        BX          LR                                          ;   return;

        END
