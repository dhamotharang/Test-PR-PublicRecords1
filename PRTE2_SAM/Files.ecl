IMPORT business_header, Business_Header_SS, TopBusiness_BIPV2, SAM, PRTE2_SAM, PRTE2, UT, PromoteSupers, std, Prte2, Address, AID, AID_Support, SAM, PRTE2_SAM, AccountMonitoring, EPLS, SAM_Services;
EXPORT Files := MODULE

  //Base
  EXPORT Sam_Base := DATASET(PRTE2_Sam.Constants.Base_Prefix +'SAM', PRTE2_Sam.Layouts.Base, THOR);
  EXPORT Sam_key  := PROJECT(Sam_Base, transform(layouts.Bip_linkid, SELF := LEFT, SELF := []));
  
   
  //Input Files
  EXPORT Input_Boca := DATASET('~prte::in::samkeys::Boca', PRTE2_Sam.Layouts.Input_EXT, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));
  EXPORT Input_INS  := DATASET('~prte::in::samkeys::INS', PRTE2_Sam.Layouts.Input_EXT, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));
  
END;