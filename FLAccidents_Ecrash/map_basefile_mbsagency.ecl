
  sAgency := Files_MBSAgency.DS_SPRAY_AGENCY;  
	
	mac_CleanFields(sAgency, sCleanAgency);
  dCleanAgency := DEDUP(sCleanAgency, all);
	
  pAgency := PROJECT(dCleanAgency, TRANSFORM(Layout_Infiles_Fixed.agency_contrib_source, 
                            SELF.agency_id := IF(TRIM(Left.agency_id,LEFT,RIGHT) <>'', LEFT.agency_id,ERROR('agency file bad')),
														SELF.agency_name := LEFT.agency_name;
														SELF.source_id := LEFT.source_id;
														SELF.agency_state_abbr := LEFT.agency_state_abbr;
														SELF.agency_ori := LEFT.agency_ori;
														SELF.append_overwrite_flag := LEFT.append_overwrite_flag;
                            SELF:= LEFT;
														SELF := [];));	
	
  dsAgency := DISTRIBUTE(pAgency, HASH32(agency_id));

EXPORT map_basefile_mbsagency := dsAgency;