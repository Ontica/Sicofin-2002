<%
	Option Explicit
	Response.CacheControl = "no-cache"
	Response.AddHeader "Pragma", "no-cache"
	Response.Expires = -1

  If (CLng(Session("uid")) = 0) Then
		Response.Redirect Application("exit_page")
	End If
	
	Dim gsEntitiesTable, gnReturnEntityId
		
	Call Main()
	
	Sub Main()
		Dim oGralLedgerUS
		'****************
		On Error Resume Next
		gnReturnEntityId = CLng(Request.QueryString("id"))
		Set oGralLedgerUS = Server.CreateObject("AOGralLedgerUS.CServer")
		Select Case Request.QueryString("order")
			Case ""
				gsEntitiesTable = oGralLedgerUS.GetSubsidiaryLedgersEntitiesHTMLTable(Session("sAppServer"), "")
			Case "1"
				gsEntitiesTable = oGralLedgerUS.GetSubsidiaryLedgersEntitiesHTMLTable(Session("sAppServer"), "Entity_Name")
			Case "2"
				gsEntitiesTable = oGralLedgerUS.GetSubsidiaryLedgersEntitiesHTMLTable(Session("sAppServer"), "Description, Entity_Name")
		End Select		
		Set oGralLedgerUS = Nothing
		If (Err.number <> 0) Then
			Session("nErrNumber") = "&H" & Hex(Err.number)
			Session("sErrSource") = Err.source
			Session("sErrDescription") = Err.description			
			Session("sErrPage") = Request.ServerVariables("URL")		  
		  Response.Redirect("/empiria/central/exceptions/exception.asp")
		End If
	End Sub
%>
<HTML>
<HEAD>
<TITLE>Banobras - Intranet corporativa</TITLE>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<meta http-equiv="Pragma" content="no-cache">
<link REL="stylesheet" TYPE="text/css" HREF="/empiria/resources/applications.css">
<SCRIPT ID=clientEventHandlersJS LANGUAGE=javascript>
<!--

function callEditor(nOperation, nItemId) {
  switch (nOperation) {
    case 1:		//Add
			window.open("entity_editor.asp", null, "height=250,width=360,location=0,resizable=0");
			return false;
    case 2:		//Edit
			window.open("entity_editor.asp?id=" + nItemId, null, "height=250,width=360,location=0,resizable=0");
			return false;
	}
	return false;
}

function refreshPage(nOrderId) {
	var sURL = 'subsidiary_ledger_entities.asp?id=<%=gnReturnEntityId%>';
  if (nOrderId == 0) {
		window.location.href = sURL;
	} else {	
		window.location.href = sURL + '?order=' + nOrderId;
	}
	return false;
}

//-->
</SCRIPT>
</HEAD>
<BODY SCROLL=NO>
<DIV STYLE="overflow:auto; float:bottom; width=100%; height=52px">
<BR>
<TABLE align=center border=0 bgcolor=Khaki cellPadding=3 cellSpacing=3 width="70%">
	<TR>
		<TD nowrap><FONT face=Arial size=3 color=maroon><STRONG>Tipos de mayores auxiliares</STRONG></FONT></TD>
	  <TD colspan=3 align=right nowrap>
			<INPUT type="button" name=cmdAddItem value="Agregar" style="WIDTH:80px" LANGUAGE=javascript onclick="return callEditor(1,0);">&nbsp;&nbsp;&nbsp;
			<INPUT type="button" name=cmdRefresh value="Actualizar" style="WIDTH:80px" LANGUAGE=javascript onclick="window.location.href=window.location.href;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<INPUT type="button" name=cmdReturn value="Cerrar" style="WIDTH:80px" LANGUAGE=javascript onclick="window.location.href = 'subsidiary_ledgers.asp?id=<%=gnReturnEntityId%>';">
		</TD>
	</TR>
</TABLE>
</DIV>
<DIV STYLE="overflow:auto; float:bottom; width=100%; height=90%">
<TABLE align=center border=1 cellPadding=3 cellSpacing=3 width="70%">
<% If Len(gsEntitiesTable) <> 0 Then %>
	<A href="#SCROLLABLE_DIV_TOP"></A>
	<TR>
	  <TD nowrap><A href="" onclick="return refreshPage(1);"><FONT color=maroon><b>Nombre</b></FONT></A></TD>
	  <TD nowrap align=center><A href="" onclick="return refreshPage(2);"><FONT color=maroon><b>Descripci�n</b></FONT></A></TD>	  
	</TR>
	<%=gsEntitiesTable%>
	<TR>
	  <TD nowrap colspan=4 align=right><A href="#SCROLLABLE_DIV_TOP">Subir</A></TD>
	</TR>	
<% Else %>
	<TR><TD colspan=4 align=center>No hay definido ning�n tipo de mayor auxiliar.</TD></TR>
<% End If %>
</TABLE>
<BR>&nbsp;
</DIV>
</BODY>
</HTML>