EXPORT MAC_Vehicle_Tag_Types_Help_Text() := MACRO

  help_text:='<DIV STYLE="height:300px;overflow:auto;">'+
  ' <TABLE BORDER="3" BORDERCOLOR="#c0c0c0" CELLPADDING="2" CELLSPACING="1" WIDTH="800">'+
  '      <CAPTION><B>Vehicle Plate Type Sorting input field rules</B></CAPTION>'+
  '    <TH WIDTH="10%"> <FONT SIZE="1"><U>Field name</U></FONT></TH>'+
  '    <TH WIDTH="25%"><FONT SIZE="1"><U>DataType</U></FONT></TH>'+
  '    <TH WIDTH="25%"><FONT SIZE="1"><U>Description</U></FONT></TH>'+
  '    <TH WIDTH="40%">Example</TH>'+
  '    <TR ALIGN="LEFT"><TD>SortByTagTypes</TD>'+
  '      <TD><FONT SIZE="1">set of unsigned1</FONT></TD>'+
  '      <TD><FONT SIZE="1">One number per row for the vehicle tag types to sort on.<BR>Use the table index below as a reference.</FONT></TD>'+
  '      <TD><FONT SIZE="1">Using the Table below, to sort on Types - Emergency and Taxi, one would enter: '+
  '        <div style="white-space:pre;">8</div><div style="white-space:pre;">16</div></FONT></TD>'+
  '    </TR>'+
  ' </TABLE><BR>'+
  ' <TABLE BORDER="3" BORDERCOLOR="#c0c0c0" CELLPADDING="2" CELLSPACING="1" WIDTH="800">'+
  '      <CAPTION><B>Vehicle Plate Type Sorting Rules</B></CAPTION>'+
  '     <TH BGCOLOR="#ffff99" WIDTH="1%"><FONT SIZE="1">#</FONT></TH>'+
  '     <TH WIDTH="10%"> <FONT SIZE="1"><U>Description<BR>license_plate_desc</U></FONT></TH>'+
  '     <TH WIDTH="30%"><FONT SIZE="1"><U>Codes<BR>license_plate_code</U></FONT></TH>'+
  '     <TH WIDTH="30%"><FONT SIZE="1"><U>Exceptions</U></FONT></TH>'+
  '     <TR ALIGN="LEFT">'+
  '       <TD>1</TD>'+
  '       <TD><FONT SIZE="1">Agriculture</FONT></TD>'+
  '       <TD><FONT SIZE="1">[AG,AGA,AGP,AGR,ACR]</FONT></TD>'+
  '       <TD><FONT SIZE="1"></FONT></TD>'+
  '     </TR>'+
  '     <TR ALIGN="LEFT">'+
  '        <TD>2</TD>'+
  '        <TD><FONT SIZE="1">Antique</FONT></TD>'+
  '        <TD><FONT SIZE="1">[ANQ,ANT,AN,AQ,MA]</FONT></TD>'+
  '        <TD><FONT SIZE="1">[AT] for state = MS - Mississippi only</FONT></TD>'+
  '      </TR>'+
  '     <TR ALIGN="LEFT">'+
  '        <TD>3</TD>'+
  '        <TD><FONT SIZE="1">Bus</FONT></TD>'+
  '        <TD><FONT SIZE="1">[BL,BN,BU,CB,CBUS,IBR, MUB,SBUS,SB,SCB,SCH]</FONT></TD>'+
  '        <TD><FONT SIZE="1">[BC,BS,NB] for state = NE - Nebraska only<BR>[TB] for state = OH - Ohio only</FONT></TD>'+
  '     </TR>'+
  '     <TR ALIGN="LEFT">'+
  '        <TD>4</TD>'+
  '        <TD><FONT SIZE="1">Commercial</FONT></TD>'+
  '        <TD><FONT SIZE="1">[CML,COM]</FONT></TD>'+
  '        <TD><FONT SIZE="1">[NC,TC,TP] for state = NE - Nebraska only<BR>[TK] for state = OH - Ohio only </FONT></TD>'+
  '     </TR>'+
  '     <TR ALIGN="LEFT">'+
  '        <TD>5</TD>'+
  '        <TD><FONT SIZE="1">Disabled</FONT></TD>'+
  '        <TD><FONT SIZE="1">[DX,DB,HAN,HCP]</FONT></TD>'+
  '        <TD><FONT SIZE="1"></FONT></TD>'+
  '     </TR>'+
  '     <TR ALIGN="LEFT">'+
  '        <TD>6</TD>'+
  '        <TD><FONT SIZE="1">Disabled/Veteran </FONT></TD>'+
  '        <TD><FONT SIZE="1">[DAV,DMP,DMR,DV,DVP,DVR,DWP, DWR,FDR,HON,PVP, PVR,SL,VET,VFW]</FONT></TD>'+
  '        <TD><FONT SIZE="1">[BS] for state = MS - Mississippi only<BR>[MH] for state NOT = OH - Ohio</FONT></TD>'+
  '     </TR>'+
  '     <TR ALIGN="LEFT">'+
  '        <TD>7</TD>'+
  '        <TD><FONT SIZE="1">Educational/Affiliation</FONT></TD>'+
  '        <TD><FONT SIZE="1">[EA,EDU]</FONT></TD>'+
  '       <TD><FONT SIZE="1"></FONT></TD>'+
  '     </TR>'+
  '     <TR ALIGN="LEFT">'+
  '        <TD>8</TD>'+
  '        <TD><FONT SIZE="1">Emergency</FONT></TD>'+
  '        <TD><FONT SIZE="1">[EME,EMR]</FONT></TD>'+
  '        <TD><FONT SIZE="1"></FONT></TD>'+
  '     </TR>'+
  '     <TR ALIGN="LEFT">'+
  '        <TD>9</TD>'+
  '        <TD><FONT SIZE="1">Environmental</FONT></TD>'+
  '        <TD><FONT SIZE="1">[ENV,EPR]</FONT></TD>'+
  '        <TD><FONT SIZE="1"></FONT></TD>'+
  '     </TR>'+
  '     <TR ALIGN="LEFT">'+
  '        <TD>10</TD>'+
  '        <TD><FONT SIZE="1">Exempt</FONT></TD>'+
  '        <TD><FONT SIZE="1">[EX,EXE,EXT,TE]</FONT></TD>'+
  '        <TD><FONT SIZE="1"></FONT></TD>'+
  '     </TR>'+
  '     <TR ALIGN="LEFT">'+
  '        <TD>11</TD>'+
  '        <TD><FONT SIZE="1">Government</FONT></TD>'+
  '        <TD><FONT SIZE="1">[FGV,G,GC,GG,GM, HREP,LGV,OFF,SGV]</FONT></TD>'+
  '        <TD><FONT SIZE="1">[UH] for state = MS - Mississippi only</FONT></TD>'+
  '     </TR>'+
  '     <TR ALIGN="LEFT">'+
  '        <TD>12</TD>'+
  '        <TD><FONT SIZE="1">Military/Reserve</FONT></TD>'+
  '        <TD><FONT SIZE="1">[AF,AFRV,MIL,MR, RFRV,UVP,UVR]</FONT></TD>'+
  '        <TD><FONT SIZE="1"></FONT></TD>'+
  '     </TR>'+
  '     <TR ALIGN="LEFT">'+
  '        <TD>13</TD>'+
  '        <TD><FONT SIZE="1">Motorhome/RV</FONT></TD>'+
  '        <TD><FONT SIZE="1">[HV,REC,RV]</FONT></TD>'+
  '        <TD><FONT SIZE="1">[MH] for state = OH - Ohio only<BR>Description contains "MOTORHOME"</FONT></TD>'+
  '     </TR>'+
  '     <TR ALIGN="LEFT">'+
  '        <TD>14</TD>'+
  '        <TD><FONT SIZE="1">Motorcycle</FONT></TD>'+
  '        <TD><FONT SIZE="1">[CMR,MOT,MC,MCR, MCP,MV,NCR]</FONT></TD>'+
  '       <TD><FONT SIZE="1"></FONT></TD>'+
  '     </TR>'+
  '     <TR ALIGN="LEFT">'+
  '        <TD>15</TD>'+
  '        <TD><FONT SIZE="1">Private</FONT></TD>'+
  '        <TD><FONT SIZE="1">[PRI,PRV]</FONT></TD>'+
  '       <TD><FONT SIZE="1"></FONT></TD>'+
  '     </TR>'+
  '     <TR ALIGN="LEFT">'+
  '        <TD>16</TD>'+
  '        <TD><FONT SIZE="1">Taxi</FONT></TD>'+
  '        <TD><FONT SIZE="1">[TAX,TAXI]</FONT></TD>'+
  '        <TD><FONT SIZE="1"></FONT></TD>'+
  '     </TR>'+
  '     <TR ALIGN="LEFT">'+
  '        <TD>17</TD>'+
  '        <TD><FONT SIZE="1">Temporary</FONT></TD>'+
  '        <TD><FONT SIZE="1">[TEM,TEP,TM]</FONT></TD>'+
  '        <TD><FONT SIZE="1"></FONT></TD>'+
  '     </TR>'+
  '     <TR ALIGN="LEFT">'+
  '        <TD>18</TD>'+
  '        <TD><FONT SIZE="1">Trailer</FONT></TD>'+
  '       <TD><FONT SIZE="1">[TRL]</FONT></TD>'+
  '       <TD><FONT SIZE="1">Description contains "TRAILER"</FONT></TD>'+
  '     </TR>'+
  '     <TR ALIGN="LEFT">'+
  '        <TD>19</TD>'+
  '        <TD><FONT SIZE="1">Vanity</FONT></TD>'+
  '        <TD><FONT SIZE="1">[MV,VAN,VR]</FONT></TD>'+
  '       <TD><FONT SIZE="1"></FONT></TD>'+
  '    </TR>'+
  ' </TABLE><BR>'+
  '</DIV>';

  ENDMACRO;