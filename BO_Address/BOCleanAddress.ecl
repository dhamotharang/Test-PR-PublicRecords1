/////////////////////////////////////////////////////////////////////////////////////
// "<transaction><command_name>FMLName73</command_name><parameters><LINE1>john m windle</LINE1></parameters></transaction>"
//  "<transaction><command_name>cleanaddress182</command_name><parameters><ADDRESS1>12030 nw 34 place</ADDRESS1><ADDRESS2>sunrise fl 33323</ADDRESS2></parameters></transaction>"




EXPORT BOCleanAddress (const string line1,const string line2,
							const string server = BO_Server, 
							unsigned2 port = BO_Port)	:= FUNCTION

//	CorrectPort := 11200; 
//	CorrectServer := 'postalclean18';
string send_payload := '<transaction><command_name>cleanaddress182</command_name><parameters>' +
	if(line1 = ''	,'', '<ADDRESS1>' + line1 + '</ADDRESS1>')+
	if(line2 = ''	,'', '<ADDRESS2>' + line2 + '</ADDRESS2>')+
	'</parameters></transaction>';

  //clean := AddrCleanLib.CleanLNBO (send_payload, server, port);  
	clean := AddrCleanLib.CleanLNBO (send_payload, server, port);  
  return clean; 
END;