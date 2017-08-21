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
	export geocodingLog_filter			:= 'left.file = right.file and left.datetime = right.datetime,left only';
	//Previous Versions
	export event_mo_built					:= 'in::prepped::event::dbo::mo::built';
	export event_mo_udf_built 		:= 'in::prepped::event::dbo::mo_udf::built';
	export event_persons_built		:= 'in::prepped::event::dbo::persons::built';
	export event_persons_udf_built:= 'in::prepped::event::dbo::persons_udf::built';
	export event_vehicles_built		:= 'in::prepped::event::dbo::vehicles::built';
	
	export cfs_built							:= 'in::prepped::cfs::dbo::cfs_2::built';
	export cfs_officers_built			:= 'in::prepped::cfs::dbo::cfs_officers_2::built';
	export crash_built						:= 'in::prepped::crash::dbo::crash::built';
	export crash_person_built			:= 'in::prepped::crash::dbo::person::built';
	export crash_vehicle_built		:= 'in::prepped::crash::dbo::vehicle::built';
	export offender_built					:= 'in::prepped::offenders::dbo::offender::built';
	export offender_class_built		:= 'in::prepped::offenders::dbo::offender_classification::built';
	export offender_pic_built			:= 'in::prepped::offenders::dbo::offender_picture::built';
	export lpr_built							:= 'in::prepped::lpr::dbo::licenseplateevent::built';
	
	export stats_built								:= 'in::prepped::statsreport::built';
	export event_stats_built					:= 'in::prepped::event::statsreport::built';
	export cfs_stats_built						:= 'in::prepped::cfs::statsreport::built';
	export crash_stats_built					:= 'in::prepped::crash::statsreport::built';
	export offender_stats_built				:= 'in::prepped::offender::statsreport::built';
	
	export address_cache_built				:= 'in::prepped::ln_address_cache::built';
	export event_address_cache_built	:= 'in::prepped::event::ln_address_cache::built';
	export cfs_address_cache_built		:= 'in::prepped::cfs::ln_address_cache::built';
	export crash_address_cache_built	:= 'in::prepped::crash::ln_address_cache::built';
	export offender_address_cache_built	:= 'in::prepped::offender::ln_address_cache::built';
	
	export deletes_built							:= 'in::prepped::deletes::built';
	export event_deletes_built				:= 'in::prepped::event::deletes::built';
	export cfs_deletes_built					:= 'in::prepped::cfs::deletes::built';
	export crash_deletes_built				:= 'in::prepped::crash::deletes::built';
	export offender_deletes_built			:= 'in::prepped::offender::deletes::built';
	
	export geocodingLog_built					:= 'out::geocoding_log::built';
	
	export event_linkflags						:= 'ori,ir_number';
	export cfs_linkflags							:= 'ori,event_number';
	export cfsOfficers_linkflags			:= 'officer_ori,officer_event_number';
	export crash_linkflags						:= 'dataProviderId,caseNumber';
	export lpr_linkflags							:= 'ori,EventNumber';
	export offender_linkflags					:= 'data_provider_id,agency_offender_id';
	
	
	//Sentinel Flag
	export sentinel_flag_built	:= '~thor_data400::out::bair_sentinel_flag';
	
	//Secuence Control
	export recordid_raids_built := '~thor_data400::out::bair_recordid_raids';
	
	//Geocoding Log
	export max_geocoding_calls := 18000;
	export notify_after_calls  := 17500;
	export us_eastern_time		 := 40000;
	export ONE_DAY						 := 1000000;
	export sleep_time          := 400;
	export Geo_Test_Mode 			 := FALSE;
	
	
	//Timing Log
	export max_execution_time  := 1200000;
	
	//minimum recordID_RAIDS 
	export min_recordID_RAIDS := 50000000000;	
end;



