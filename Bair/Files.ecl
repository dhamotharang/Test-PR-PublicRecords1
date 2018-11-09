IMPORT tools;

EXPORT Files(string version = '', boolean pUseProd = false, boolean pUseDelta = false, boolean pPrepped = false) := MODULE
 
/* Input File Versions */	
	export event_helper_ucr_group_classifications_input
		:= dataset(bair.Filenames('',pUseProd).event_helper_ucr_group_classifications_lInputTemplate, Bair.Layouts.events_helper_ucr_group_classifications, CSV(separator([',']),quote(''),terminator(['\n'])), opt);
	export event_helper_ucr_group_classifications_history
		:= dataset(bair.Filenames('',pUseProd).event_helper_ucr_group_classifications_lInputHistTemplate, Bair.Layouts.events_helper_ucr_group_classifications, CSV(separator([',']),quote(''),terminator(['\n'])), opt);
	
	export event_address_lookup_input
		:= dataset(bair.Filenames('',pUseProd).event_address_lookup_lInputTemplate, Bair.Layouts.AddressLookup_In, CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);
	export event_address_lookup_history
		:= dataset(bair.Filenames('',pUseProd).event_address_lookup_lInputHistTemplate, Bair.Layouts.AddressLookup_In, CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);

	export intersection_coordinates_input
		:= dataset(bair.Filenames('',pUseProd).intersection_coordinates_lInputTemplate, Bair.Layouts.Intersection_Coordinates_In, CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);
	export intersection_coordinates_history
		:= dataset(bair.Filenames('',pUseProd).intersection_coordinates_lInputHistTemplate, Bair.Layouts.Intersection_Coordinates_In, CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);
		
	export agency_deletes_input
		:= dataset( if(pPrepped,	bair.FileNames_Prepped(pUseProd).agency_del_in, bair.Filenames('',pUseProd).agency_deletes_lInputTemplate)
					,Bair.Layouts.agency_deletes
					,CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);
	export agency_deletes_history
		:= dataset( if(pPrepped,	bair.FileNames_Prepped(pUseProd).agency_del_in_hist, bair.Filenames('',pUseProd).agency_deletes_lInputHistTemplate)
					,Bair.Layouts.agency_deletes
					,CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);
	
	export cfs_dbo_cfs_2_input
		:= dataset( if(pPrepped,	bair.FileNames_Prepped(pUseProd).cfs_2_in, bair.Filenames('',pUseProd).cfs_dbo_cfs_2_lInputTemplate)
					,Bair.Layouts.cfs_dbo_cfs_2_In
					,CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);
	export cfs_dbo_cfs_2_history
		:= dataset( if(pPrepped,	bair.FileNames_Prepped(pUseProd).cfs_2_in_hist, bair.Filenames('',pUseProd).cfs_dbo_cfs_2_lInputHistTemplate)
					,Bair.Layouts.cfs_dbo_cfs_2_In
					,CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);
	
	export cfs_dbo_cfs_officers_2_input
		:= dataset( if(pPrepped,	bair.FileNames_Prepped(pUseProd).cfs_2_off_in, bair.Filenames('',pUseProd).cfs_dbo_cfs_officers_2_lInputTemplate)
					,Bair.Layouts.cfs_dbo_cfs_officers_2_In
					,CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);
	export cfs_dbo_cfs_officers_2_history
		:= dataset( if(pPrepped,	bair.FileNames_Prepped(pUseProd).cfs_2_off_in_hist, bair.Filenames('',pUseProd).cfs_dbo_cfs_officers_2_lInputHistTemplate)
					,Bair.Layouts.cfs_dbo_cfs_officers_2_In
					,CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);

	export cfs_dbo_agencycfstypelookup_input
		:= dataset(bair.Filenames('',pUseProd).cfs_dbo_agencycfstypelookup_lInputTemplate, Bair.Layouts.cfs_dbo_agencycfstypelookup_In, CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);
	export cfs_dbo_agencycfstypelookup_history
		:= dataset(bair.Filenames('',pUseProd).cfs_dbo_agencycfstypelookup_lInputHistTemplate, Bair.Layouts.cfs_dbo_agencycfstypelookup_In, CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);
  
	export event_dbo_mo_input
		:= dataset( if(pPrepped,	bair.FileNames_Prepped(pUseProd).mo_in, bair.Filenames('',pUseProd).event_dbo_mo_lInputTemplate)
					,Bair.Layouts.event_dbo_mo_In
					,CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);
	export event_dbo_mo_history
		:= dataset( if(pPrepped,	bair.FileNames_Prepped(pUseProd).mo_in_hist, bair.Filenames('',pUseProd).event_dbo_mo_lInputHistTemplate)
					,Bair.Layouts.event_dbo_mo_In
					,CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);
	
	export event_dbo_persons_input
		:= dataset( if(pPrepped,	bair.FileNames_Prepped(pUseProd).persons_in, bair.Filenames('',pUseProd).event_dbo_persons_lInputTemplate)
					,Bair.Layouts.event_dbo_persons_In
					,CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);
	export event_dbo_persons_history
		:= dataset( if(pPrepped,	bair.FileNames_Prepped(pUseProd).persons_in_hist, bair.Filenames('',pUseProd).event_dbo_persons_lInputHistTemplate)
					,Bair.Layouts.event_dbo_persons_In
					,CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);
  
	export event_dbo_vehicle_input
		:= dataset( if(pPrepped,	bair.FileNames_Prepped(pUseProd).vehicle_in, bair.Filenames('',pUseProd).event_dbo_vehicle_lInputTemplate)
					,Bair.Layouts.event_dbo_vehicle_In, CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);
	export event_dbo_vehicle_history
		:= dataset( if(pPrepped,	bair.FileNames_Prepped(pUseProd).vehicle_in_hist, bair.Filenames('',pUseProd).event_dbo_vehicle_lInputHistTemplate)
					,Bair.Layouts.event_dbo_vehicle_In, CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);
	
	export event_import_group_access_input
		:= dataset(bair.Filenames('',pUseProd).event_import_group_access_lInputTemplate, Bair.Layouts.event_import_group_access_In, CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);
	export event_import_group_access_history
		:= dataset(bair.Filenames('',pUseProd).event_import_group_access_lInputHistTemplate, Bair.Layouts.event_import_group_access_In, CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);
	
	export event_dbo_mo_udf_input
		:= dataset( if(pPrepped,	bair.FileNames_Prepped(pUseProd).mo_udf_in, bair.Filenames('',pUseProd).event_dbo_mo_udf_lInputTemplate)
					,Bair.Layouts.event_dbo_mo_udf_In
					,CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);
	export event_dbo_mo_udf_history
		:= dataset( if(pPrepped,	bair.FileNames_Prepped(pUseProd).mo_udf_in_hist, bair.Filenames('',pUseProd).event_dbo_mo_udf_lInputHistTemplate)
					,Bair.Layouts.event_dbo_mo_udf_In
					,CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);
	
	export event_dbo_persons_udf_input
		:= dataset( if(pPrepped,	bair.FileNames_Prepped(pUseProd).persons_udf_in, bair.Filenames('',pUseProd).event_dbo_persons_udf_lInputTemplate)
					,Bair.Layouts.event_dbo_persons_udf_In
					,CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);
	export event_dbo_persons_udf_history
		:= dataset( if(pPrepped,	bair.FileNames_Prepped(pUseProd).persons_udf_in_hist, bair.Filenames('',pUseProd).event_dbo_persons_udf_lInputHistTemplate)
					,Bair.Layouts.event_dbo_persons_udf_In
					,CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);
	
	export event_dbo_data_provider_input
		:= dataset(bair.Filenames('',pUseProd).event_dbo_data_provider_lInputTemplate, Bair.Layouts.event_dbo_data_provider_In, CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);
	export event_dbo_data_provider_history
		:= dataset(bair.Filenames('',pUseProd).event_dbo_data_provider_lInputHistTemplate, Bair.Layouts.event_dbo_data_provider_In, CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);
	
	export event_dbo_data_provider_location_input
		:= dataset(bair.Filenames('',pUseProd).event_dbo_data_provider_location_lInputTemplate, Bair.Layouts.event_dbo_data_provider_location_In, CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);
	export event_dbo_data_provider_location_history
		:= dataset(bair.Filenames('',pUseProd).event_dbo_data_provider_location_lInputHistTemplate, Bair.Layouts.event_dbo_data_provider_location_In, CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);

	export event_dbo_data_provider_import_input
		:= dataset(bair.Filenames('',pUseProd).event_dbo_data_provider_import_lInputTemplate, Bair.Layouts.event_dbo_data_provider_import_In, CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);
	export event_dbo_data_provider_import_history
		:= dataset(bair.Filenames('',pUseProd).event_dbo_data_provider_import_lInputHistTemplate, Bair.Layouts.event_dbo_data_provider_import_In, CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);

	export event_dbo_AgencyCrimeTypeLookup_input
		:= dataset(bair.Filenames('',pUseProd).event_dbo_AgencyCrimeTypeLookup_lInputTemplate, Bair.Layouts.event_dbo_AgencyCrimeTypeLookup_In, CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);
	export event_dbo_AgencyCrimeTypeLookup_history
		:= dataset(bair.Filenames('',pUseProd).event_dbo_AgencyCrimeTypeLookup_lInputHistTemplate, Bair.Layouts.event_dbo_AgencyCrimeTypeLookup_In, CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);

	export intel_dbo_entity_input
		:= dataset(bair.Filenames('',pUseProd).intel_dbo_entity_lInputTemplate, Bair.Layouts.intel_dbo_entity_In, CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);
	export intel_dbo_entity_history
		:= dataset(bair.Filenames('',pUseProd).intel_dbo_entity_lInputHistTemplate, Bair.Layouts.intel_dbo_entity_In, CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);
	
	export intel_dbo_entity_notes_input
		:= dataset(bair.Filenames('',pUseProd).intel_dbo_entity_notes_lInputTemplate, Bair.Layouts.intel_dbo_entity_notes_In, CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);
	export intel_dbo_entity_notes_history
		:= dataset(bair.Filenames('',pUseProd).intel_dbo_entity_notes_lInputHistTemplate, Bair.Layouts.intel_dbo_entity_notes_In, CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);

	export intel_dbo_incident_input
		:= dataset(bair.Filenames('',pUseProd).intel_dbo_incident_lInputTemplate, Bair.Layouts.intel_dbo_incident_In, CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);
	export intel_dbo_incident_history
		:= dataset(bair.Filenames('',pUseProd).intel_dbo_incident_lInputHistTemplate, Bair.Layouts.intel_dbo_incident_In, CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);
	
	export intel_dbo_incident_notes_input
		:= dataset(bair.Filenames('',pUseProd).intel_dbo_incident_notes_lInputTemplate, Bair.Layouts.intel_dbo_incident_notes_In, CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);
	export intel_dbo_incident_notes_history
		:= dataset(bair.Filenames('',pUseProd).intel_dbo_incident_notes_lInputHistTemplate, Bair.Layouts.intel_dbo_incident_notes_In, CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);
	
	export intel_dbo_reporting_officer_input
		:= dataset(bair.Filenames('',pUseProd).intel_dbo_reporting_officer_lInputTemplate, Bair.Layouts.intel_dbo_reporting_officer_In, CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);
	export intel_dbo_reporting_officer_history
		:= dataset(bair.Filenames('',pUseProd).intel_dbo_reporting_officer_lInputHistTemplate, Bair.Layouts.intel_dbo_reporting_officer_In, CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);

	export intel_dbo_vehicle_notes_input
		:= dataset(bair.Filenames('',pUseProd).intel_dbo_vehicle_notes_lInputTemplate, Bair.Layouts.intel_dbo_vehicle_notes_In, CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);
	export intel_dbo_vehicle_notes_history
		:= dataset(bair.Filenames('',pUseProd).intel_dbo_vehicle_notes_lInputHistTemplate, Bair.Layouts.intel_dbo_vehicle_notes_In, CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);
	
	export intel_dbo_entity_photo_input
		:= dataset(bair.Filenames('',pUseProd).intel_dbo_entity_photo_lInputTemplate, Bair.Layouts.intel_dbo_entity_photo_In, CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);
	export intel_dbo_entity_photo_history
		:= dataset(bair.Filenames('',pUseProd).intel_dbo_entity_photo_lInputHistTemplate, Bair.Layouts.intel_dbo_entity_photo_In, CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);

	export offenders_dbo_classification_input
		:= dataset(bair.Filenames('',pUseProd).offenders_dbo_classification_lInputTemplate, Bair.Layouts.offenders_dbo_classification_In, CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);
	export offenders_dbo_classification_history
		:= dataset(bair.Filenames('',pUseProd).offenders_dbo_classification_lInputHistTemplate, Bair.Layouts.offenders_dbo_classification_In, CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);
	
	export offenders_dbo_offender_classification_input
		:= dataset( if(pPrepped,	bair.FileNames_Prepped(pUseProd).offender_class_in, bair.Filenames('',pUseProd).offenders_dbo_offender_classification_lInputTemplate)
					,Bair.Layouts.offenders_dbo_offender_classification_In
					,CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);
	export offenders_dbo_offender_classification_history
		:= dataset( if(pPrepped,	bair.FileNames_Prepped(pUseProd).offender_class_in_hist, bair.Filenames('',pUseProd).offenders_dbo_offender_classification_lInputHistTemplate)
					,Bair.Layouts.offenders_dbo_offender_classification_In
					,CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);

	export offenders_dbo_offender_input
		:= dataset( if(pPrepped,	bair.FileNames_Prepped(pUseProd).offender_in, bair.Filenames('',pUseProd).offenders_dbo_offender_lInputTemplate)
					,Bair.Layouts.offenders_dbo_offender_In
					,CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);
	export offenders_dbo_offender_history
		:= dataset( if(pPrepped,	bair.FileNames_Prepped(pUseProd).offender_in_hist, bair.Filenames('',pUseProd).offenders_dbo_offender_lInputHistTemplate)
					,Bair.Layouts.offenders_dbo_offender_In
					,CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt); 
	
	export offenders_dbo_picture_input
		:= dataset( if(pPrepped,	bair.FileNames_Prepped(pUseProd).offender_pic_in, bair.Filenames('',pUseProd).offenders_dbo_picture_lInputTemplate)
					,Bair.Layouts.Offenders_dbo_offender_picture_In
					,CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);
	export offenders_dbo_picture_history
		:= dataset( if(pPrepped,	bair.FileNames_Prepped(pUseProd).offender_pic_in_hist, bair.Filenames('',pUseProd).offenders_dbo_picture_lInputHistTemplate)
					,Bair.Layouts.Offenders_dbo_offender_picture_In
					,CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt); 
		
	export crash_dbo_crash_input
		:= dataset( if(pPrepped,	bair.FileNames_Prepped(pUseProd).crash_in, bair.Filenames('',pUseProd).crash_dbo_crash_lInputTemplate)
					,Bair.Layouts.crash_dbo_crash_In
					,CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);
	export crash_dbo_crash_history
		:= dataset( if(pPrepped,	bair.FileNames_Prepped(pUseProd).crash_in_hist, bair.Filenames('',pUseProd).crash_dbo_crash_lInputHistTemplate)
					,Bair.Layouts.crash_dbo_crash_In
					,CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);

	export crash_dbo_person_input
		:= dataset( if(pPrepped,	bair.FileNames_Prepped(pUseProd).cra_per_in, bair.Filenames('',pUseProd).crash_dbo_person_lInputTemplate)
					,Bair.Layouts.crash_dbo_person_In
					,CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);
	export crash_dbo_person_history
		:= dataset( if(pPrepped,	bair.FileNames_Prepped(pUseProd).cra_per_in_hist, bair.Filenames('',pUseProd).crash_dbo_person_lInputHistTemplate)
					,Bair.Layouts.crash_dbo_person_In
					,CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);
	
	export crash_dbo_vehicle_input
		:= dataset( if(pPrepped,	bair.FileNames_Prepped(pUseProd).cra_veh_in, bair.Filenames('',pUseProd).crash_dbo_vehicle_lInputTemplate)
					,Bair.Layouts.crash_dbo_vehicle_In
					,CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);
	export crash_dbo_vehicle_history
		:= dataset( if(pPrepped,	bair.FileNames_Prepped(pUseProd).cra_veh_in_hist, bair.Filenames('',pUseProd).crash_dbo_vehicle_lInputHistTemplate)
					,Bair.Layouts.crash_dbo_vehicle_In
					,CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);

	export lpr_dbo_licenseplateevent_input
		:= dataset( if(pPrepped,	bair.FileNames_Prepped(pUseProd).lpr_in, bair.Filenames('',pUseProd).lpr_dbo_licenseplateevent_lInputTemplate)
					,Bair.Layouts.lpr_dbo_LicensePlate_In
					,CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);
	export lpr_dbo_licenseplateevent_history
		:= dataset( if(pPrepped,	bair.FileNames_Prepped(pUseProd).lpr_in_hist, bair.Filenames('',pUseProd).lpr_dbo_licenseplateevent_lInputHistTemplate)
					,Bair.Layouts.lpr_dbo_LicensePlate_In
					,CSV(separator(['|']),quote(''),terminator(['~<EOL>~'])), opt);
		
	export gunop_dbo_shot_incident_input
		:= dataset(bair.Filenames('',pUseProd).gunop_dbo_shot_incident_lInputTemplate, Bair.Layouts.gunop_dbo_shot_In, CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);
	export gunop_dbo_shot_incident_history
		:= dataset(bair.Filenames('',pUseProd).gunop_dbo_shot_incident_lInputHistTemplate, Bair.Layouts.gunop_dbo_shot_In, CSV(separator(['~|~']),quote(''),terminator(['~<EOL>~'])), opt);
	
	export orbit_agencies 
		:= dataset(bair.Filenames('',pUseProd).Orbit_Agencies_Template,Bair.Layouts.Orbit_Agencies_Layout,thor);

	export orbit_datasets 
		:= dataset(bair.Filenames('',pUseProd).Orbit_Datasets_Template,Bair.Layouts.Orbit_Datasets_Layout,thor);

	/* Base File Versions */	
	tools.mac_FilesBase(Filenames(version,pUseProd,pUseDelta).cfs_dbo_cfs_2_Base, Bair.layouts.cfs_dbo_cfs_2_Base, cfs_2_Base);	
	tools.mac_FilesBase(Filenames(version,pUseProd,pUseDelta).cfs_dbo_cfs_officers_2_Base, Bair.layouts.cfs_dbo_cfs_officers_2_Base, cfs_officers_2_Base);	
	tools.mac_FilesBase(Filenames(version,pUseProd,pUseDelta).event_dbo_mo_Base, Bair.layouts.event_dbo_mo_Base, event_mo_Base);
	tools.mac_FilesBase(Filenames(version,pUseProd,pUseDelta).event_dbo_persons_Base, Bair.layouts.event_dbo_persons_Base, event_persons_Base);
	tools.mac_FilesBase(Filenames(version,pUseProd,pUseDelta).event_dbo_vehicle_Base, Bair.layouts.event_dbo_vehicle_Base, event_vehicle_Base);
	tools.mac_FilesBase(Filenames(version,pUseProd,pUseDelta).event_import_group_access_Base, Bair.layouts.event_import_group_access_Base, event_group_access_Base);	
	
	tools.mac_FilesBase(Filenames(version,pUseProd,pUseDelta).intel_dbo_entity_Base, bair.layouts.intel_dbo_entity_Base, intel_entity_Base);	
	tools.mac_FilesBase(Filenames(version,pUseProd,pUseDelta).intel_dbo_entity_notes_Base, Bair.layouts.intel_dbo_entity_notes_Base, intel_entity_notes_Base);	
	tools.mac_FilesBase(Filenames(version,pUseProd,pUseDelta).intel_dbo_incident_Base, Bair.layouts.intel_dbo_incident_Base, intel_incident_Base);
	tools.mac_FilesBase(Filenames(version,pUseProd,pUseDelta).intel_dbo_incident_notes_Base, Bair.layouts.intel_dbo_incident_notes_Base, intel_incident_notes_Base);
	tools.mac_FilesBase(Filenames(version,pUseProd,pUseDelta).intel_dbo_reporting_officer_Base, Bair.layouts.intel_dbo_reporting_officer_Base, intel_reporting_officer_Base);
	tools.mac_FilesBase(Filenames(version,pUseProd,pUseDelta).intel_dbo_vehicle_notes_Base, Bair.layouts.intel_dbo_vehicle_notes_Base, intel_vehicle_notes_Base);
	tools.mac_FilesBase(Filenames(version,pUseProd,pUseDelta).crash_dbo_crash_Base, Bair.layouts.crash_dbo_crash_Base, crash_crash_Base);	
	tools.mac_FilesBase(Filenames(version,pUseProd,pUseDelta).crash_dbo_person_Base, Bair.layouts.crash_dbo_person_Base, crash_person_Base);	
	tools.mac_FilesBase(Filenames(version,pUseProd,pUseDelta).crash_dbo_vehicle_Base, Bair.layouts.crash_dbo_vehicle_Base, crash_vehicle_Base);
	tools.mac_FilesBase(Filenames(version,pUseProd,pUseDelta).offenders_dbo_offender_Base, Bair.layouts.offenders_dbo_offender_Base, offenders_offender_Base);	
	tools.mac_FilesBase(Filenames(version,pUseProd,pUseDelta).offenders_dbo_classification_Base, Bair.layouts.offenders_dbo_classification_Base, offenders_classification_Base);	
	tools.mac_FilesBase(Filenames(version,pUseProd,pUseDelta).offenders_dbo_offender_classification_Base, Bair.layouts.offenders_dbo_offender_classification_Base, offenders_offender_classification_Base);
		
	tools.mac_FilesBase(Filenames(version,pUseProd,pUseDelta).event_address_lookup_Base, Bair.layouts.AddressLookup_In, AddressLookup_Base, pOpt	:= 'true');
	tools.mac_FilesBase(Filenames(version,pUseProd,pUseDelta).agency_deletes_Base, Bair.layouts.AgencyDeletes_Base, AgencyDeletes_base, pOpt	:= 'true');
	
	tools.mac_FilesBase(Filenames(version,pUseProd,pUseDelta).dbo_cfs_Base, Bair.layouts.dbo_cfs_Base, cfs_Base, pOpt	:= 'true');
	tools.mac_FilesBase(Filenames(version,pUseProd,true).dbo_cfs_Base, Bair.layouts.dbo_cfs_Base, cfs_delta_Base, pOpt	:= 'true');
	
	tools.mac_FilesBase(Filenames(version,pUseProd,pUseDelta).event_dbo_mo_udf_Base, Bair.layouts.mo_udf_Base, mo_udf_Base, pOpt	:= 'true');
	tools.mac_FilesBase(Filenames(version,pUseProd,true).event_dbo_mo_udf_Base, Bair.layouts.mo_udf_Base, mo_udf_delta_Base, pOpt	:= 'true');
	
	tools.mac_FilesBase(Filenames(version,pUseProd,pUseDelta).event_dbo_persons_udf_Base, bair.layouts.persons_udf_Base, persons_udf_Base, pOpt	:= 'true');
	tools.mac_FilesBase(Filenames(version,pUseProd,true).event_dbo_persons_udf_Base, bair.layouts.persons_udf_Base, persons_udf_delta_Base, pOpt	:= 'true');
	
	tools.mac_FilesBase(Filenames(version,pUseProd,pUseDelta).dbo_event_mo_Base, bair.layouts.dbo_event_mo_final_Base, mo_Base, pOpt	:= 'true');
	tools.mac_FilesBase(Filenames(version,pUseProd,true).dbo_event_mo_Base, bair.layouts.dbo_event_mo_final_Base, mo_delta_Base, pOpt	:= 'true');
	
	tools.mac_FilesBase(Filenames(version,pUseProd,pUseDelta).dbo_event_persons_Base, bair.layouts.dbo_event_persons_final_Base, persons_Base, pOpt	:= 'true');
	tools.mac_FilesBase(Filenames(version,pUseProd,true).dbo_event_persons_Base, bair.layouts.dbo_event_persons_final_Base, persons_delta_Base, pOpt	:= 'true');
	
	tools.mac_FilesBase(Filenames(version,pUseProd,pUseDelta).dbo_event_vehicle_Base, bair.layouts.dbo_event_vehicle_final_Base, vehicle_Base, pOpt	:= 'true');
	tools.mac_FilesBase(Filenames(version,pUseProd,true).dbo_event_vehicle_Base, bair.layouts.dbo_event_vehicle_final_Base, vehicle_delta_Base, pOpt	:= 'true');

	tools.mac_FilesBase(Filenames(version,pUseProd,pUseDelta).Notes_Base, bair.layouts.Notes_Base, Notes_Base,       pOpt	:= 'true');
	tools.mac_FilesBase(Filenames(version,pUseProd,true).Notes_Base,      bair.layouts.Notes_Base, Notes_delta_Base, pOpt	:= 'true');
	tools.mac_FilesBase(Filenames(version,pUseProd,pUseDelta).Notes_Base, bair.layouts.Notes_Base, Notes_Keybuild,pMaxLength:=150037,pUseMaxLength:=true,pOpt	:= 'true');

	tools.mac_FilesBase(Filenames(version,pUseProd,pUseDelta).event_group_access_Base, bair.layouts.event_group_access_Base, group_access_Base, pOpt	:= 'true');
	tools.mac_FilesBase(Filenames(version,pUseProd,pUseDelta).event_dbo_data_provider_Base, bair.layouts.event_dbo_data_provider_Base, DataProvider_Base, pOpt := 'true');
	tools.mac_FilesBase(Filenames(version,pUseProd,pUseDelta).event_dbo_data_provider_import_Base, bair.layouts.event_dbo_data_provider_import_In, DataProviderImp_Base, pOpt := 'true');
	tools.mac_FilesBase(Filenames(version,pUseProd,pUseDelta).event_dbo_data_provider_location_Base, bair.layouts.event_dbo_data_provider_location_In, DataProviderLoc_Base, pOpt := 'true');
	
	tools.mac_FilesBase(Filenames(version,pUseProd,pUseDelta).dbo_intel_Base, layouts.dbo_intel_Base, intel_Base, pOpt	:= 'true');
	
	tools.mac_FilesBase(Filenames(version,pUseProd,pUseDelta).dbo_offenders_Base, bair.layouts.dbo_offenders_Base, offenders_Base, pOpt	:= 'true');
	tools.mac_FilesBase(Filenames(version,pUseProd,pUseDelta).dbo_offenders_Picture_Base, bair.layouts.dbo_offenders_Picture_Base, offenders_picture_Base, pOpt	:= 'true');
	tools.mac_FilesBase(Filenames(version,pUseProd,pUseDelta).dbo_offenders_class_Base, Bair.layouts.Offenders_dbo_classification_In, offenders_class_Base, pOpt	:= 'true');
	
	tools.mac_FilesBase(Filenames(version,pUseProd,pUseDelta).dbo_crash_Base, bair.layouts.dbo_crash_Base, crash_Base, pOpt	:= 'true');
	
	tools.mac_FilesBase(Filenames(version,pUseProd,pUseDelta).lpr_Dbo_licenseplateevent_Base, bair.layouts.lpr_Dbo_licenseplateevent_Base, LPR_Base, pOpt	:= 'true');
	tools.mac_FilesBase(Filenames(version,pUseProd,true).lpr_Dbo_licenseplateevent_Base, bair.layouts.lpr_Dbo_licenseplateevent_Base, LPR_delta_Base, pOpt	:= 'true');

	tools.mac_FilesBase(Filenames(version,pUseProd,pUseDelta).gunop_Dbo_shot_incident_Base, bair.layouts.gunop_Dbo_shot_incident_Base, Shotspotter_Base, pOpt	:= 'true');
	
	tools.mac_FilesBase(Filenames(version,pUseProd,pUseDelta).geohash_Base, bair.layouts.GeoHashLayout, GeoHash_Base);
	tools.mac_FilesBase(Filenames(version,pUseProd,pUseDelta).geohash_lpr_Base, bair.layouts.GeoHashLayout, GeoHash_lpr_Base);
	
	tools.mac_FilesBase(Filenames(version,pUseProd,pUseDelta).event_dbo_AgencyCrimeTypeLookup_Base, bair.layouts.event_dbo_AgencyCrimeTypeLookup_In, AgencyCrimeLookup_Base, pOpt	:= 'true');
	
	tools.mac_FilesBase(Filenames(version,pUseProd,pUseDelta).cfs_dbo_agencycfstypelookup_Base, bair.layouts.cfs_dbo_AgencyCfsTypeLookup_In, AgencyCfsLookup_Base, pOpt	:= 'true');

	tools.mac_FilesBase(Filenames(version,pUseProd,pUseDelta).Classification_base, Bair.layouts.ClassificationLayout, Classification_base, pOpt	:= 'true');

	tools.mac_FilesBase(Filenames(version,pUseProd,pUseDelta).Images_Base, bair.layouts.Images_Base, Images_Base,       pOpt	:= 'true');
	tools.mac_FilesBase(Filenames(version,pUseProd,true).Images_Base,      bair.layouts.Images_Base, Images_delta_Base, pOpt	:= 'true');
	tools.mac_FilesBase(Filenames(version,pUseProd,pUseDelta).Images_Base, bair.layouts.Images_Base, Images_Keybuild,pMaxLength:=150000,pUseMaxLength:=true,pOpt	:= 'true');

	/* Keybuild File */
	
	export Files_Type
		:= dataset(Filenames(version,pUseProd).Files_Type_Template,Bair.Layouts.FilesTypeLayout,thor);

  export Build_Version
		:= dataset(Filenames(version,pUseProd).Build_Version_Template,Bair.Layouts.BuildVersionLayout,thor);


END;