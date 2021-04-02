IMPORT Data_Services;

EXPORT Files := MODULE
  EXPORT isEcrash := TRUE:STORED('Ecrash');
  EXPORT isEcrashDev := FALSE:STORED('EcrashDev');
  EXPORT isEcrashQC := FALSE:STORED('EcrashQC');
  
  
  EXPORT TrimString (STRING str) := TRIM(str, LEFT, RIGHT);
  
  EXPORT mac_fn_GetPrefix(iLabel) := FUNCTIONMACRO
    Prefix := TrimString(
                          MAP(isEcrashQC => Files_QC.iLabel,  
                              isEcrashDev => Files_Dev.iLabel, 
                              isEcrash => Files_Prefix.iLabel,
                              Files_Prefix.iLabel) 
                             );
    RETURN Prefix;	 
  ENDMACRO;  
  
// #################################################################################
//                                Spray Ecrash Prefix
// #################################################################################
  EXPORT SPRAY_ECRASH_PREFIX := mac_fn_GetPrefix(SPRAY_ECRASH_PREFIX); 
  
// #################################################################################
//                                Base Ecrash Prefix
// #################################################################################                                                        
  EXPORT BASE_ECRASH_PREFIX := mac_fn_GetPrefix(BASE_ECRASH_PREFIX); 
  
// #################################################################################
//                                Key Ecrash Prefix
// #################################################################################
  EXPORT KEY_ECRASH_PREFIX := Files_Prefix.KEY_ECRASH_PREFIX + Files_Credentials.UserCredentials; 
  
// #################################################################################
//                                Orbit Ecrash Prefix
// ################################################################################# 
  EXPORT ORBIT_ECRASH_PREFIX := mac_fn_GetPrefix(ORBIT_ECRASH_PREFIX);
	
END ;
