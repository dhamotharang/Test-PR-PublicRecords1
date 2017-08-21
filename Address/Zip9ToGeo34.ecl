/*
This wrapper calls lib_AddrClean.AddrCleanLib.Zip9ToGeo34 with the appropriate port. 
*/

import BO_Address;

export Zip9ToGeo34(const string zip9,const string server = '', 
                         unsigned2 port = 0) := function  

	cleanserver := if (server = '',Address.Constants.CorrectServer,server);
	cleanport := if (port = 0,Address.Constants.CorrectPort,port);
	
  clean := BO_Address.Zip9ToGeo34(zip9, cleanserver,cleanport);  
  return clean; 

end;

  