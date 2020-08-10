EXPORT MAC_SSN_Best_Batch_Service() := MACRO

help_text:=
'<DIV STYLE="height:200px;width:920px;overflow:auto;">'+
'  <TABLE BORDER="3" BORDERCOLOR="#c0c0c0" CELLPADDING="2" CELLSPACING="1" WIDTH="900">'+
'     <CAPTION><B>This is a batch service that processes the input and identifies best possible SSN</B></CAPTION>'+
'   <TH BGCOLOR="#ffff99" WIDTH="20%"><FONT SIZE="1">batch_in Minimal Input Criteria:</FONT></TH>'+
'   <TH WIDTH="10%"> <FONT SIZE="1"><U>Option 1</U></FONT></TH>'+
'   <TH WIDTH="25%"><FONT SIZE="1"><U>Option 2</U></FONT></TH>'+
'   <TH WIDTH="25%"><FONT SIZE="1"><U>Option 3</U></FONT></TH>'+
'   <TH WIDTH="40%"></TH>'+
'   <TR ALIGN="CENTER"><TD></TD>'+
'       <TD><FONT SIZE="1">DID</FONT></TD>'+
'       <TD><FONT SIZE="1">FN, LN, ADDR, SSN<FONT SIZE="1">(9 digits)</FONT></FONT></TD>'+
'       <TD><FONT SIZE="1">FN, LN, ADDR, DOB<FONT SIZE="1">(YYYYMMDD)</FONT></FONT></TD>'+
'       <TD><FONT SIZE="1">All invalid inputs will return error 301<FONT SIZE="1">(Insufficient input)</FONT></FONT></TD>'+
'   </TR>'+
'</TABLE><BR>'+
'<TABLE BORDER="3" BORDERCOLOR="#c0c0c0" CELLPADDING="2" CELLSPACING="1" WIDTH="900">'+
'     <TH BGCOLOR="#ffff99" WIDTH="10%"><FONT SIZE="1">Input Flags:</FONT></TH>'+
'     <TH WIDTH="30%"><FONT SIZE="1"><U>isglbrequired</U></FONT></TH>'+
'     <TH WIDTH="30%"> <FONT SIZE="1"><U>display_hri</U></FONT></TH>'+
'     <TR><TD></TD>'+
'        <TD><FONT SIZE="1">- Set to FALSE by default, it will still return non glb dependent results if the glbpurpose is not entered.'+
'                 <BR><BR> - The Gov Best SSN Batch service will be supplying a value of TRUE for this field thus making the GLBPurpose'+
'                 required causing the query will fail if it is not supplied.</FONT></TD>'+
'        <TD><FONT SIZE="1">- Set to FALSE by default, we do not display any HRI codes.'+
'               Also, SSN records with other_cnt >/=4 are NOT displayed.<BR><BR> - If set to TRUE,'+
'               we display the SSN regardless of other_cnt value and we also populate the HRI_codes/desc where applicable.</FONT></TD>'+
'     </TR>'+
'</TABLE><BR>'+
'<TABLE BORDER="3" BORDERCOLOR="#c0c0c0" CELLPADDING="2" CELLSPACING="1" WIDTH="900">'+
'    <TH BGCOLOR="#ffff99" WIDTH="10%"><FONT SIZE="1">Error codes:</FONT></TH>'+
'    <TH WIDTH="30%"><FONT SIZE="1"><U>10</U></FONT></TH>'+
'    <TH WIDTH="30%"> <FONT SIZE="1"><U>301</U></FONT></TH>'+
'    <TH WIDTH="30%"> <FONT SIZE="1"><U>307</U></FONT></TH>'+
'    <TR><TD></TD>'+
'        <TD><FONT SIZE="1">No SSN record linked to the DID, or the SSN record has been suppressed due to restrictions.</FONT></TD>'+
'        <TD><FONT SIZE="1">Insufficient input see first table above.</FONT></TD>'+
'        <TD><FONT SIZE="1">If DID score linked to input PII is less than 80, we do NOT return the SSN record.'+
'                The didscorethreshold parameter may be used for testing purposes.</FONT></TD>'+
'    </TR>'+
'</TABLE><BR>'+
'<TABLE BORDER="3" BORDERCOLOR="#c0c0c0" CELLPADDING="2" CELLSPACING="1" WIDTH="900">'+
'    <TH BGCOLOR="#ffff99" WIDTH="10%"><FONT SIZE="1">output field - poss_shared_ssn:</FONT></TH>'+
'    <TH WIDTH="30%"><FONT SIZE="1"><U>Y</U></FONT></TH>'+
'    <TH WIDTH="30%"><FONT SIZE="1"><U>P</U></FONT></TH>'+
'    <TH WIDTH="30%"><FONT SIZE="1"><U>N</U></FONT></TH>'+
'    <TR><TD></TD>'+
'        <TD><FONT SIZE="1">If other_cnt >/= 4. The SSN is NOT returned unless display_hri is turned ON.</FONT></TD>'+
'        <TD><FONT SIZE="1">If other_cnt 1 - 3.</FONT></TD>'+
'        <TD><FONT SIZE="1">If other_cnt is = 0.</FONT></TD>'+
'    </TR>'+
'</TABLE><BR>'+
'<TABLE BORDER="3" BORDERCOLOR="#c0c0c0" CELLPADDING="2" CELLSPACING="1" WIDTH="900">'+
'     <TH BGCOLOR="#ffff99" WIDTH="10%"><FONT SIZE="1">output field - bureau_only_ssn:</FONT></TH>'+
'     <TH WIDTH="30%"><FONT SIZE="1"><U>Y</U></FONT></TH>'+
'     <TH WIDTH="30%"><FONT SIZE="1"><U>N</U></FONT></TH>'+
'     <TR><TD></TD>'+
'         <TD><FONT SIZE="1">ALL of the restriction safe sources for the SSN come from credit bureau'+
'                sources such as LT,TU,TN,EN,EQ,QH,WH.</FONT></TD>'+
'         <TD><FONT SIZE="1">The SSN has at least one non credit bureau source.</FONT></TD>'+
'     </TR>'+
'</TABLE>'+
'</DIV>';

#WEBSERVICE(FIELDS('applicationtype','industryclass','datarestrictionmask','ssnmask','usingkeepssns','keepoldssns',
                    'includeminors','glbpurpose','dppapurpose','didscorethreshold','display_hri','isglbrequired','batch_in'
                    ),HELP(help_text));
ENDMACRO;