/////////////////////////////////////////////////////////////////////////////////////
/*
LNBO000147<transaction>
	<command_name>firm</command_name>
	<parameters>
		<LINE1>LexisNexis</LINE1>
		<LINE2>John S tombs</LINE2>
	</parameters>
</transaction>
returned
LNBO000477<result>
	<PRENAME>MR</PRENAME><FIRST_NAME>JOHN</FIRST_NAME><MIDDLE_NAME>S</MIDDLE_NAME><LAST_NAME>TOMBS</LAST_NAME>
	<SUFFIX_NAME></SUFFIX_NAME><HONORARY_POSTNAME></HONORARY_POSTNAME><TITLE></TITLE><SCORE>34</SCORE>
	<PRENAME2></PRENAME2><FIRST_NAME2></FIRST_NAME2><MIDDLE_NAME2></MIDDLE_NAME2><LAST_NAME2></LAST_NAME2>
	<SUFFIX_NAME2></SUFFIX_NAME2><HONORARY_POSTNAME2></HONORARY_POSTNAME2><TITLE2></TITLE2><SCORE2></SCORE2>
	<FIRM1>LEXISNEXIS</FIRM1><FIRM2></FIRM2>
</result>
*/



EXPORT BOCleanFirmName (const string line1,const string line2,
							const string server = BO_Server, 
							unsigned2 port = BO_Port)	:= FUNCTION

//	CorrectPort := 11200; 
//	CorrectServer := 'postalclean18';
string send_payload := '<transaction><command_name>firm</command_name><parameters>' +
	if(line1 = ''	,'', '<LINE1>' + line1 + '</LINE1>')+
	if(line2 = ''	,'', '<LINE2>' + line2 + '</LINE2>')+
	'</parameters></transaction>';

  clean := AddrCleanLib.CleanLNBO (send_payload, server, port);  
  return clean; 
END;


