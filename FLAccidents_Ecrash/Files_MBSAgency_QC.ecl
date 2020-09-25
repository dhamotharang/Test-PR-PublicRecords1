EXPORT Files_MBSAgency_QC := MODULE
  
  SHARED QC_PREFIX := '::QC';

  // ##############################################################################################
  //                    Agency Spray file with QC Prefix
  // ##############################################################################################
  EXPORT SPRAY_AGENCY_PREFIX := Files_MBSAgency_Prefix.SPRAY_AGENCY_PREFIX + QC_PREFIX;
	
  // ##############################################################################################
  //                      Orbit Agency Prefix with QC Prefix
  // ##############################################################################################
  EXPORT BASE_ORBIT_AGENCY_PREFIX := Files_MBSAgency_Prefix.BASE_ORBIT_AGENCY_PREFIX + QC_PREFIX;

  // ##############################################################################################
  //                    Agency Base file with QC Prefix
  // ##############################################################################################	
  EXPORT BASE_AGENCY_PREFIX := Files_MBSAgency_Prefix.BASE_AGENCY_PREFIX + QC_PREFIX;
	
END;