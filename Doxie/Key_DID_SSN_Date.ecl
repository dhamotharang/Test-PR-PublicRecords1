IMPORT dx_header, data_services;

EXPORT Key_DID_SSN_Date(boolean IsFCRA = false) := 
  dx_header.key_DID_SSN_date (IF (isFCRA, data_services.data_env.iFCRA, data_services.data_env.iNonFCRA));
