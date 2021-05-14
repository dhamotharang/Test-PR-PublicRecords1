EXPORT mod_BuildMBSAgency := MODULE
  
	// Data is distributed in map_basefile_agency 
  dBaseAgency := DISTRIBUTED(map_basefile_mbsagency, HASH32(agency_id)); 
  EXPORT BaseAgency := DEDUP(dBaseAgency, ALL); 
  
END;