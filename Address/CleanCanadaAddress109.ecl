/*

This wrapper allows flexibility to change server configuration settings for CanadaCleanLib plugin

*/
import BO_Address,Address,lib_CanadaClean;

export CleanCanadaAddress109(const string addrline, const string lastline, 
							 const string server = '', 
							 unsigned2 port = 0,
               string1 lang = '') := function  
	
	cleanserver := if (server = '',Address.Constants.CorrectCServer,server);
	cleanport := if (port = 0,Address.Constants.CorrectCPort,port);

	clean := CanadaCleanLib.CanadaAddress109(addrline,lastline,lang,cleanserver,cleanport); 
  // clean := BO_Address.CleanCanadaAddress109(addrline,lastline,Address.Constants.CorrectCServer,Address.Constants.CorrectCPort,lang); 
  
  return clean; 

end; 
