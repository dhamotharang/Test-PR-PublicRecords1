

import BO_Address,lib_AddrClean;


EXPORT BOCleanFMLNameEnclarity (const string line1,
							const string server, 
							unsigned2 port)	:= FUNCTION


string send_payload := '<transaction><command_name>cleanFMLEnclarity</command_name><parameters>' +
	if(line1 = ''	,'', '<LINE1>' + line1 + '</LINE1>')+
	'</parameters></transaction>';

  clean := AddrCleanLib.CleanLNBO (send_payload, server, port);  
  return clean; 
END;


