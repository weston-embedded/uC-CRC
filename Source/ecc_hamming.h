/*
*********************************************************************************************************
*                                               uC/CRC
*           ERROR DETECTING CODE (EDC) & ERROR CORRECTING CODE (ECC) CALCULATION UTILITIES
*
*                    Copyright 2007-2020 Silicon Laboratories Inc. www.silabs.com
*
*                                 SPDX-License-Identifier: APACHE-2.0
*
*               This software is subject to an open source license and is distributed by
*                Silicon Laboratories Inc. pursuant to the terms of the Apache License,
*                    Version 2.0 available at www.apache.org/licenses/LICENSE-2.0.
*
*********************************************************************************************************
*/

/*
*********************************************************************************************************
*
*                                      HAMMING CODE CALCULATION
*
* Filename : ecc_hamming.h
* Version  : V1.10.00
*********************************************************************************************************
*/


/*
*********************************************************************************************************
*                                               MODULE
*********************************************************************************************************
*/

#ifndef   ECC_HAMMING_PRESENT
#define   ECC_HAMMING_PRESENT


/*
*********************************************************************************************************
*                                            INCLUDE FILES
*********************************************************************************************************
*/

#include  <cpu.h>
#include  <cpu_core.h>
#include  <lib_def.h>
#include  <lib_mem.h>
#include  <crc_cfg.h>
#include  <ecc.h>


/*
*********************************************************************************************************
*                                               EXTERNS
*********************************************************************************************************
*/

#ifdef   ECC_HAMMING_MODULE
#define  ECC_HAMMING_EXT
#else
#define  ECC_HAMMING_EXT  extern
#endif


/*
*********************************************************************************************************
*                                               DEFINES
*********************************************************************************************************
*/


/*
*********************************************************************************************************
*                                             DATA TYPES
*********************************************************************************************************
*/


/*
*********************************************************************************************************
*                                          GLOBAL VARIABLES
*********************************************************************************************************
*/

extern  const  ECC_CALC  Hamming_ECC;


/*
*********************************************************************************************************
*                                               MACRO'S
*********************************************************************************************************
*/

/*
*********************************************************************************************************
*                                         FUNCTION PROTOTYPES
*********************************************************************************************************
*/

void        Hamming_Calc   (void          *p_buf,               /* Calc Hamming code.                                   */
                            CPU_SIZE_T     len,
                            void          *p_buf_ext,
                            CPU_SIZE_T     len_ext,
                            CPU_INT08U    *p_ecc,
                            ECC_ERR       *p_err);

CPU_INT08U  Hamming_Chk    (void          *p_buf,               /* Chk Hamming code.                                    */
                            CPU_SIZE_T     len,
                            void          *p_buf_ext,
                            CPU_SIZE_T     len_ext,
                            CPU_INT08U    *p_ecc,
                            ECC_ERR_LOC    err_loc_tbl[],
                            CPU_INT08U     err_loc_tbl_size,
                            ECC_ERR       *p_err);

void        Hamming_Correct(void          *p_buf,               /* Correct errors.                                      */
                            CPU_SIZE_T     len,
                            void          *p_buf_ext,
                            CPU_SIZE_T     len_ext,
                            CPU_INT08U    *p_ecc,
                            ECC_ERR       *p_err);

/*
*********************************************************************************************************
*                                        CONFIGURATION ERRORS
*********************************************************************************************************
*/

#ifndef  ECC_HAMMING_CFG_ARG_CHK_EXT_EN
#error  "ECC_HAMMING_CFG_ARG_CHK_EXT_EN         not #define'd in 'crc_cfg.h'"
#error  "                                 [MUST be DEF_ENABLED ]            "
#error  "                                 [     || DEF_DISABLED]            "

#elif  ((ECC_HAMMING_CFG_ARG_CHK_EXT_EN != DEF_DISABLED) && \
        (ECC_HAMMING_CFG_ARG_CHK_EXT_EN != DEF_ENABLED ))
#error  "ECC_HAMMING_CFG_ARG_CHK_EXT_EN   illegally #define'd in 'crc_cfg.h'"
#error  "                                 [MUST be DEF_ENABLED ]            "
#error  "                                 [     || DEF_DISABLED]            "
#endif


/*
*********************************************************************************************************
*                                             MODULE END
*********************************************************************************************************
*/

#endif                                                          /* End of HAMMING module include.                       */
