VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CLedgerAccountTypes"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
'*** Empiria� ***********************************************************************************************
'*                                                                                                          *
'* Soluci�n   : Empiria� Software Components                    Sistema : Financial Accounting              *
'* Componente : Ledger Accounts BS (EFALedgerAcctsBS)           Parte   : Business services                 *
'* Clase      : CLedgerAccountTypes                             Patr�n  : Stateless Class                   *
'* Fecha      : 31/Diciembre/2001                               Versi�n : 1.0       Versi�n patr�n: 1.0     *
'*                                                                                                          *
'* Descripci�n: Representa los tipos de cuentas de mayor (catalogos de cuentas).                            *
'*                                                                                                          *
'****************************************************** Copyright � La V�a Ontica, S.C. M�xico, 1999-2002. **
Option Explicit
Private Const ClassId As String = "CLedgerAccountTypes"

'************************************************************************************************************
'* M�TODOS P�BLICOS                                                                                         *
'************************************************************************************************************

Public Function GetCategoryRS(sAppServer As String, Optional nCategoryId As Long = 0) As Recordset
  Dim oContext As ObjectContext, bObjectContextOK As Boolean, oRecordset As Recordset
  '***********************************************************************************************
  On Error GoTo ErrHandler
    Set oContext = GetObjectContext
    bObjectContextOK = Not (oContext Is Nothing)
    Set oRecordset = GetRecordsetDef(sAppServer, cnDefCategory, nCategoryId)
    If nCategoryId = 0 Then
      oRecordset.AddNew
    End If
    Set GetCategoryRS = oRecordset
    If bObjectContextOK Then oContext.SetComplete
  Exit Function
ErrHandler:
  If bObjectContextOK Then oContext.SetAbort
  RaiseError ClassId, "GetCategoryRS", Err.Number
End Function

Public Sub SaveStandardAccountCategory(sAppServer As String, oRecordset As Recordset, nCategoryId As Long, _
                                       sPattern As String)
  Dim oContext As ObjectContext, bObjectContextOK As Boolean
  Dim oStandardAccount As New CStdAccount
  '**************************************************************************
  On Error GoTo ErrHandler
    If (nCategoryId = 0) Then
      oRecordset!parent_id = 4
      oRecordset!is_item = 1
      oRecordset!deleted = 0
      oRecordset!Position = 4
      AppendRecordset sAppServer, oRecordset, "Category_Id", "SEC_CATEGORY_ID"
      oStandardAccount.SetPattern oRecordset!Category_Id, sPattern
    Else
      oRecordset!parent_id = 4
      oRecordset!is_item = 1
      oRecordset!deleted = 0
      oRecordset!Position = 4
      SaveRecordset sAppServer, oRecordset
    End If
  Exit Sub
ErrHandler:
  RaiseError ClassId, "SaveStandardAccountCategory", Err.Number
End Sub
