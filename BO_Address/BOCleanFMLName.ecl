/////////////////////////////////////////////////////////////////////////////////////
// "<transaction><command_name>FMLName73</command_name><parameters><LINE1>john m windle</LINE1></parameters></transaction>"
//  ,"<transaction><command_name>FMLName73</command_name><LINE1>john m windle</LINE1></transaction>",


import BO_Address,lib_AddrClean;


EXPORT BOCleanFMLName (const string line1,
							const string server = BO_Address.BO_Server, 
							unsigned2 port = BO_Address.BO_Port)	:= FUNCTION

//	CorrectPort := 11200; 
//	CorrectServer := 'postalclean18';
string send_payload := '<transaction><command_name>FMLName73</command_name><parameters>' +
	if(line1 = ''	,'', '<LINE1>' + line1 + '</LINE1>')+
	'</parameters></transaction>';

  clean := AddrCleanLib.CleanLNBO (send_payload, server, port);  
  return clean; 
END;


