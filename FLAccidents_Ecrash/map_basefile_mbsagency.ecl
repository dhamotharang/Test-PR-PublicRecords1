
  sAgency := Files_MBSAgency.DS_SPRAY_AGENCY;  
  mac_CleanFields(sAgency, sCleanAgency);
  dCleanAgency := DEDUP(sCleanAgency(agency_id <> ''), ALL);
	
	Layout_MBSAgency.agency tCleanAgency(dCleanAgency L) := TRANSFORM
	  SELF.agency_id := IF(TRIM(L.agency_id,LEFT,RIGHT) <>'', L.agency_id,ERROR('agency file bad')),
		SELF.agency_name := L.agency_name;
		SELF.source_id := L.source_id;
		SELF.agency_state_abbr := L.agency_state_abbr;
		SELF.agency_ori := L.agency_ori;
		SELF.append_overwrite_flag := L.append_overwrite_flag;
		SourceStartDate := STD.Date.FromStringToDate(L.source_start_date, '%Y-%m-%d');
		SELF.orig_source_start_date := IF(SourceStartDate = 0, L.source_start_date, (STRING) SourceStartDate);
		SELF.source_start_date := IF(SourceStartDate = 0, 
		                             Constants_MBSAgency.default_source_start_date, 
		                             SourceStartDate);
		SourceEndDate := STD.Date.FromStringToDate(L.source_end_date, '%Y-%m-%d');
		SourceTermDate := STD.Date.FromStringToDate(L.source_termination_date[1..10], '%Y-%m-%d');
		SELF.orig_source_end_date := IF(SourceEndDate = 0, L.source_end_date,(STRING) SourceEndDate);
		SELF.source_end_date := SourceEndDate;
		SELF.orig_source_termination_date := IF(SourceTermDate = 0, L.source_termination_date, (STRING) SourceTermDate);
		SELF.source_termination_date := IF(SourceTermDate = 0, 
		                                   Constants_MBSAgency.default_source_termination_date, 
		                                   SourceTermDate);
		SELF:= L;
		SELF := [];
	END;
  pAgency := PROJECT(dCleanAgency, tCleanAgency(LEFT));		
  dsAgency := DISTRIBUTE(pAgency, HASH32(agency_id));

EXPORT map_basefile_mbsagency := dsAgency;
