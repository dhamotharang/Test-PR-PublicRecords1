IMPORT business_header, TopBusiness_BIPV2, Thrive, PRTE2_Thrive, BIPv2;

EXPORT Files := MODULE

 //Base
 EXPORT Thrive_Base := DATASET(PRTE2_Thrive.Constants.base_prefix +'Thrive', PRTE2_Thrive.Layouts.Base, thor);
  
 //Key Build
 EXPORT Thrive_did := PROJECT(Thrive_Base, TRANSFORM(Layouts.key, self := left, self := [])); 

   
 //Input Files
 EXPORT Input_INS := dataset('~prte::in::thrive::ins', PRTE2_Thrive.Layouts.INPUT, CSV(HEADING(3), 
                     SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"'))); 
 
END;