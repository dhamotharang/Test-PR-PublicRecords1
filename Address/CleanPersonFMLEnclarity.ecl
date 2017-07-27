
import BO_Address,Address;

EXPORT CleanPersonFMLEnclarity (const string name, 
                         const string server = '', 
											   unsigned2 port = 0)	:= FUNCTION

	
	cleanserver := if (server = '',BO_Address.BO_EnclarityServer,server);
	cleanport := if (port = 0,BO_Address.BO_EnclarityPort,port);
  
	clean := BO_Address.CleanPersonFMLEnclarity (name,cleanserver,cleanport);  
  
  return clean; 
END;