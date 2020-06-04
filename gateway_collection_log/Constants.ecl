IMPORT  ut,_control;
EXPORT  Constants	:= INLINE MODULE

  EXPORT  useProd := FALSE;
	
	//	Server IP to Spray from
  EXPORT  serverIP  := IF(_control.thisenvironment.name='Dataland',
													_Control.IPAddress.bctlpedata12,
													_Control.IPAddress.bctlpedata10);
	
	//	Directory to Spray from
	EXPORT  Directory :=  IF(	_control.thisenvironment.name='Dataland','/data/temp/crim/','/data/temp/crim/');
	

	//	Build Types
	EXPORT  buildType :=  ENUM(
                              UNSIGNED1,
                              Daily,      // DAILY build only processes and links the records from today
                              Linking,    // LINKING Build processes today's records and then links all records
                              FullBuild	  // FULLBUILD processes and links all records (Used when we get a new
                                          // address or name cleaner or we missed processing some daily records
                              );

END;
