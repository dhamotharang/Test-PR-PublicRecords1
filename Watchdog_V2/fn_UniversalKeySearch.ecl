IMPORT dx_BestRecords,data_services,doxie,Watchdog;

EXPORT fn_UniversalKeySearch := MODULE

EXPORT basekey := dx_BestRecords.key_watchdog();
EXPORT PermissionsType := dx_BestRecords.Constants.PERM_TYPE;

//Fetch records function
EXPORT FetchRecords($.UniversalKeyInterface Parms) := FUNCTION
       DidPassed := Parms.did <> 0;                                      
       PermissionsPassed := Parms.permissions <> 0;
       DidFilter := basekey.Did = Parms.did;                                
       PermissionsFilter := (basekey.Permissions & Parms.permissions) <> 0 ;
       filter := MAP(DidPassed AND PermissionsPassed  => DidFilter AND PermissionsFilter,     
              DidPassed => DidFilter ,
              PermissionsPassed => PermissionsFilter ,
							FALSE);	
   RETURN PROJECT(Basekey(filter),TRANSFORM(watchdog.Layout_best_flags,SELF :=LEFT));	
END;

END;

			   
                                                         
														
														
														
										
