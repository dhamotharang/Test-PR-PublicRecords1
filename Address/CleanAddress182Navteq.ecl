
//import lib_system;
import BO_Address, Address;

export CleanAddress182Navteq (const string addrline, const string lastline, string server = '',unsigned2 port = 0)
       := function  

	cleanserver := if (server = '',Address.Constants.CorrectServer,server);
	cleanport := if (port = 0,Address.Constants.CorrectPort,port);

	clean := BO_Address.CleanAddress182navteq(addrline, lastline, cleanserver, cleanport);
  return clean; 

end;  // Function