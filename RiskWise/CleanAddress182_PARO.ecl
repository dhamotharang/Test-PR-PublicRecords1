/*
This is a temporary fix for PARO to rollback to the 2000 census data

*/
import address;

export CleanAddress182_PARO(const string addrline, const string lastline,string server = '',unsigned2 port = 0)
       := function  

  	
  //clean := AddrCleanLib.CleanAddress182(addrline, lastline, CorrectServer, CorrectPort); 
	
	cleanserver := if (server = '',Address.Constants.CorrectServer,server);
	cleanport := if (port = 0,Address.Constants.CorrectPort,port);
	
	// clean := CleanAddress182Navteq(addrline, lastline, cleanserver, cleanport);;
	clean := Address.CleanAddress182Tomtom(addrline, lastline, cleanserver, cleanport);

  return clean; 

end;  // Function