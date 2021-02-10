EXPORT MAC_identifier2_service_GovIdAttributes() := MACRO

  help_text:='<DIV STYLE="height:250px;overflow:auto;">'+
  ' <TABLE BORDER="3" BORDERCOLOR="#c0c0c0" CELLPADDING="2" CELLSPACING="1" WIDTH="1000">'+
  '      <CAPTION><B>Details of GovID change are in JIRA ticket <a href="https://jira.rsi.lexisnexis.com/browse/RR-20547" target="_blank" >RR-20547</</B></CAPTION>'+
  '      <CAPTION><B>How to enter values for GovId input attributes</B></CAPTION>'+
  '    <TH WIDTH="10%"> <FONT SIZE="1"><U>Field name</U></FONT></TH>'+
  '    <TH WIDTH="10%"><FONT SIZE="1"><U>Description</U></FONT></TH>'+
  '    <TH WIDTH="20%">Example</TH>'+
  '    <TH WIDTH="60%">Mappings</TH>'+
  '    <TR ALIGN="LEFT"><TD>govidinattributes</TD>'+
  '      <TD><FONT SIZE="1">One number per row for the GovId attribute to be enabled.<BR>Use the mapping on the right as a reference.</FONT></TD>'+
  '      <TD><FONT SIZE="1">Using the Mapping to the right, to enable Gov Id attributes SSNFullNameMatch & SSNDeathMatchVerification, one would enter: '+
  '        <div style="white-space:pre;">1</div><div style="white-space:pre;">2</div></FONT></TD>'+
  '<TD><FONT SIZE="1">SSNFullNameMatch => 1, SSNDeathMatchVerification => 2, SSNExists => 3, MultiplyIdentitySSN => 4, SSNLastNameMatch => 5, SSNYOBDateAlert => 6, SSN4FullNameMatch => 7, SSNRandomized => 8, SSNHistory => 9, SSN5FullNameMatch => 10, Addr1Zip_StateMatch => 11, Addr1LastNameMatch => 12, IdentityOccupancyVerified => 13, AddrDeliverable => 14, AddrNotBusiness => 15, AddrNotHighRisk => 16, AddrNotMaildrop => 17, PropertyAndDeed  => 18, IdentityOwnershipVerified => 19, NameStreetAddressMatch => 20, NameCityStateMatch => 21, NameZipMatch => 22, Age_Verification => 23, YOBSSNMatch => 24, DOBSSNMatch => 25, DOBFullVerified => 26, DOBMonthYearVerified => 27, DOBYearVerified => 28, DOBMonthDayVerified => 29, PhoneLastNameMatch => 30, PhoneNotMobile => 31, PhoneNotDisconnected => 32, PhoneVerified => 33, PhoneFullNameMatch => 34, DriverLicenseMatch => 35, DriversLicenseVerification => 36, PassportValidation => 37, OFAC => 38, AdditionalWatchlists => 39, LexIDDeathMatch => 40, SSNLowIssuance => 41, SSNSSAValid => 42 </FONT></TD>'+
  '    </TR>'+
  ' </TABLE><BR>'+
  '</DIV>';
	
	#WEBSERVICE(HELP(help_text));  
  ENDMACRO;