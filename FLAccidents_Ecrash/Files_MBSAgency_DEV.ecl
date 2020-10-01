EXPORT Files_MBSAgency_DEV := MODULE

  
  SHARED DEV_PREFIX := '::DEV';

  // ##############################################################################################
  //                    Agency Spray file with DEV Prefix
  // ##############################################################################################
  EXPORT SPRAY_AGENCY_PREFIX := Files_MBSAgency_Prefix.SPRAY_AGENCY_PREFIX + DEV_PREFIX;

  // ##############################################################################################
  //                     Orbit Agency Prefix with Dev Prefix
  // ##############################################################################################
  EXPORT BASE_ORBIT_AGENCY_PREFIX := Files_MBSAgency_Prefix.BASE_ORBIT_AGENCY_PREFIX + DEV_PREFIX;

  // ##############################################################################################
  //                    Agency Base file with DEV Prefix
  // ##############################################################################################	
  EXPORT BASE_AGENCY_PREFIX := Files_MBSAgency_Prefix.BASE_AGENCY_PREFIX + DEV_PREFIX;
	
END;