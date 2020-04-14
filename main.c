/*******************************************************************************
* File Name: main.c  
* Version 1.10
*
* Description:
*  Contains the main.c function.
*
*
*******************************************************************************
* Copyright 2013-2017, Cypress Semiconductor Corporation.  All rights reserved.
* You may use this file only in accordance with the license, terms, conditions, 
* disclaimers, and limitations in the end user license agreement accompanying 
* the software package with which this file was provided.
********************************************************************************/

// This code is no longer required! It's just a reference now.
// But you can uncomment this and remove the static Rust lib
// if you have issues and want to use this for testing
/*
#include <project.h>

CY_ISR(SWPin_Control)
{
    if(InputPin_Read() == 1u)
    {
        OutputPinSW_Write(0u);
    }
    else
    {
        OutputPinSW_Write(1u);
    }
    
    InputPin_ClearInterrupt();
}

int main()
{
    InputInterrupt_StartEx(SWPin_Control);
    
    CyGlobalIntEnable;
    
    for(;;){}
}
*/

/* [] END OF FILE */
