export BOCleanCanadaAddress (const string line1,const string line2,
							const string server = BO_Server, 
							unsigned2 port = BO_Port,const string lang)	:= FUNCTION

//	CorrectPort := 11200; 
//	CorrectServer := 'postalclean18';
string send_payload := '<transaction><command_name>canadaclean</command_name><parameters>' +
	if(line1 = ''	,'', '<ADDRESS1>' + line1 + '</ADDRESS1>')+
	if(line2 = ''	,'', '<ADDRESS2>' + line2 + '</ADDRESS2>')+
	if(lang = ''	,'', '<LANGUAGE>' + lang + '</LANGUAGE>')+
	'</parameters></transaction>';

  //clean := AddrCleanLib.CleanLNBO (send_payload, server, port);  
	clean := AddrCleanLib.CleanLNBO (send_payload, server, port);  
  return clean; 
END;