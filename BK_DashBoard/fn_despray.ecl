 import _Control;
 
 export fn_despray(string filename, string pHostname, string pTarget) := FUNCTION
 
	 subfilename	:= nothor(fileservices.superfilecontents(filename)[1].name);
	  despray := FileServices.Despray('~'+subfilename,
															pHostname,
														pTarget+ subfilename + '.csv',

															,,,  // Timeout, ESP, MaxConnections
															true
															);
	  
	  RETURN despray;
		
	end;
	
	                     

 







