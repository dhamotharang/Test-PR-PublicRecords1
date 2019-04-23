import BO_Address, lib_addrClean;
export BOCleanAddressNavteq (const string line1,const string line2,
							const string server = BO_Address.BO_Server, 
							unsigned2 port = BO_Address.BO_Port)	:= FUNCTION

//	CorrectPort := 11200; 
//	CorrectServer := 'postalclean18';
string send_payload := '<transaction><command_name>cleanaddress182Navteq</command_name><parameters>' +
	if(line1 = ''	,'', '<ADDRESS1>' + line1 + '</ADDRESS1>')+
	if(line2 = ''	,'', '<ADDRESS2>' + line2 + '</ADDRESS2>')+
	'</parameters></transaction>';

  //clean := AddrCleanLib.CleanLNBO (send_payload, server, port);  
	clean := AddrCleanLib.CleanLNBO (send_payload, server, port);  
  return clean; 
END;