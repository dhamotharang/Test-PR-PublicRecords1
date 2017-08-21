export _Constants  := module
	//File Types
	export file_types 			:= ['EventMO','EventPersons','EventVehicles','EventDeletes','CFS','CFSOfficers','CFSDeletes','Crash','CrashPersons','CrashVehicles','CrashDeletes','LPR','LPRDeletes','Offenders','OffendersClassification','OffendersPicture','OffendersDeletes'];
	//Filters
	export event_filter 						:= 'left.ORI = right.ORI and left.IR_Number = right.IR_Number,left only';
	export event_udf_filter 				:= 'left.ORI = right.ORI,left only';
	export event_stats_filter				:= 'left.ORI = right.ORI and left.filename = right.filename,left only';
	export delete_filter 						:= 'left.field1 = right.field1 and left.field2 = right.field2 and left.field3 = right.field3,left only';
	export cfs_filter 							:= 'left.ori = right.ori and left.event_number = right.event_number,left only';
	export crash_filter 						:= 'left.ori = right.ori and left.case_number = right.case_number,left only';
	export offenders_filter 				:= 'left.ori = right.ori and left.agency_offender_id = right.agency_offender_id,left only';
	export lpr_filter								:= 'left.ORI = right.ORI and left.EventNumber = right.EventNumber,left only, skew(1)';
	export orbitbuilds_filter				:= 'left.orbitbuild = right.orbitbuild,left only';
	export address_cache_filter			:= 'left.ac_dataProviderID = right.ac_dataProviderID and left.ac_address = right.ac_address,left only';
	//Previous Versions
	export event_mo_built					:= 'in::prepped::event::dbo::mo::built';
	export event_mo_udf_built 		:= 'in::prepped::event::dbo::mo_udf::built';
	export event_persons_built		:= 'in::prepped::event::dbo::persons::built';
	export event_persons_udf_built:= 'in::prepped::event::dbo::persons_udf::built';
	export event_vehicles_built		:= 'in::prepped::event::dbo::vehicles::built';
	export event_stats_built			:= 'in::prepped::statsreport::built';
	export deletes_built					:= 'in::prepped::deletes::built';
	export cfs_built							:= 'in::prepped::cfs::dbo::cfs_2::built';
	export cfs_officers_built			:= 'in::prepped::cfs::dbo::cfs_officers_2::built';
	export crash_built						:= 'in::prepped::crash::dbo::crash::built';
	export crash_person_built			:= 'in::prepped::crash::dbo::person::built';
	export crash_vehicle_built		:= 'in::prepped::crash::dbo::vehicle::built';
	export offender_built					:= 'in::prepped::offenders::dbo::offender::built';
	export offender_class_built		:= 'in::prepped::offenders::dbo::offender_classification::built';
	export offender_pic_built			:= 'in::prepped::offenders::dbo::offender_picture::built';
	export lpr_built							:= 'in::prepped::lpr::dbo::licenseplateevent::built';
	export orbitbuilds_built			:= 'in::prepped::orbitbuilds::built';
	export address_cache_built		:= 'in::prepped::ln_address_cache::built';
	export bair_geocoding_log			:= '~thor_data400::out::bair_geocoding_log';
	
	//Sentinel Flag
	export sentinel_flag_built	:= '~thor_data400::out::bair_sentinel_flag';
	
	//Secuence Control
	export recordid_raids_built := '~thor_data400::out::bair_recordid_raids';
	
	// formats
	export xml_event_mo_format := 'xml(\'EVENT_XML/MO_TABLE/MO\')';
	export xml_event_persons_format := 'xml(\'EVENT_XML/PERSONS_TABLE/PERSONS\')';
	export xml_event_vehicles_format := 'xml(\'EVENT_XML/VEHICLE_TABLE/VEHICLE\')';

	export xml_cfs_format 	 := 'xml(\'CFS_XML/CFS_TABLE/CFS\')';
	export xml_cfs_officers_format 	 := 'xml(\'CFS_XML/OFFICER_TABLE/OFFICERS\')';
	export xml_lpr_format 	 := 'xml(\'LPR_XML/LPR_TABLE/LPR\')';

	export csv_format := 'CSV(separator([\'~|~\']),quote(\'\'),terminator([\'~<EOL>~\']))';
	
	//Geocoding Log
	export max_geocoding_calls := 20000;
	export notify_after_calls  := 10000;
	export us_eastern_time		 := 40000;
	export ONE_DAY						 := 1000000;
	export sleep_time          := 400;
	
	
	//Timing Log
	export max_execution_time  := 1200000;
	
	//minimum recordID_RAIDS 
	export min_recordID_RAIDS := 50000000000;	
end;



