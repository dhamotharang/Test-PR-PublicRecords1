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
  
//Existing definitions
  EXPORT deletes := DATASET(Data_Services.foreign_prod+'thor_data::in::ecrash_deletes',Layouts.deletes,CSV(TERMINATOR(['\n','\r\n']), SEPARATOR(','),QUOTE('"'))); 
  EXPORT Base := MODULE
     EXPORT Supplemental := DATASET(Data_Services.Data_location.Prefix('ecrash')+'thor_data400::base::ecrash_supplemental',Layouts.ReportVersion,THOR);
     EXPORT PhotoBase := DATASET(Data_Services.Data_location.Prefix('ecrash')+'thor_data400::base::ecrash_documents',Layouts.PhotoLayout,THOR);
     EXPORT accidents_alpha := DATASET(Data_Services.Data_location.Prefix('ecrash')+'thor_data400::base::accidents_alpha',Layout_eCrash.Accidents_Alpha,THOR);  
     EXPORT accidents_alpha_father := DATASET(Data_Services.Data_location.Prefix('ecrash')+'thor_data400::base::accidents_alpha_father',Layout_eCrash.Accidents_Alpha,THOR);  
     EXPORT AgencyCmbd := DATASET(Data_Services.Data_location.Prefix('ecrash')+'thor_data400::base::agency_cmbnd', Layouts.agency_cmbnd, THOR);
  END;
END ;
