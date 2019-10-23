 import _Control;
 
 export fn_despray(string filename) := FUNCTION
 
	 subfilename	:= nothor(fileservices.superfilecontents(filename)[1].name);
	  despray := FileServices.Despray('~'+subfilename,
															_Control.IPAddress.bctlpedata12,
														'/data/temp/crim/bk_dashboard/'+ subfilename + '.csv',

															,,,  // Timeout, ESP, MaxConnections
															true
															);
	  
	  RETURN despray;
		
	end;
	
	                     

 







