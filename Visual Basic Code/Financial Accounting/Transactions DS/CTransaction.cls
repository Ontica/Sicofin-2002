VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CTransaction"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
'*** Empiria� ***********************************************************************************************
'*                                                                                                          *
'* Soluci�n   : Empiria� Software Components                    Sistema : Financial Accounting              *
'* Componente : Transactions DS (EFATransactionsDS)             Parte   : Data services                     *
'* Clase      : CTransaction                                    Patr�n  : Stateless Class                   *
'* Fecha      : 31/Enero/2001                                   Versi�n : 1.0       Versi�n patr�n: 1.0     *
'*                                                                                                          *
'* Descripci�n: Regresa una transacci�n mediante un ADO.Recordset o como documento XML.                     *
'*                                                                                                          *
'****************************************************** Copyright � La V�a Ontica, S.C. M�xico, 1999-2002. **
Option Explicit
Private Const ClassId As String = "CTransaction"

'************************************************************************************************************
'* M�TODOS P�BLICOS                                                                                         *
'************************************************************************************************************


