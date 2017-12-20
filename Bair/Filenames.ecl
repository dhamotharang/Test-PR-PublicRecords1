import versioncontrol,tools;

export Filenames(string version = '', boolean pUseProd = false, boolean pUseDelta = false ) := module
	
	shared suffixBaseVersion
		:= if(pUseDelta, '::delta::@version@', '::@version@');
	shared suffixBaseBuilt
		:= if(pUseDelta, '::delta', '');
	shared thor_cluster
		:= _Dataset(pUseProd).thor_cluster_files;
	shared dsName
		:= _Dataset().name;
		
	export event_helper_ucr_group_classifications_lBaseTemplate_built
			:= thor_cluster + 'base::' + dsName + '::event::helper::ucr_group_classifications::built';
	export event_helper_ucr_group_classifications_lBaseTemplate
			:= thor_cluster + 'base::' + dsName+ '::event::helper::ucr_group_classifications::@version@';
	export event_helper_ucr_group_classifications_lKeyTemplate	  							
			:= thor_cluster + 'base::' + dsName + '_keybuild' + '::event::helper::ucr_group_classifications::@version@';		
	export event_helper_ucr_group_classifications_lInputTemplate 							
			:= thor_cluster + 'in::'   + dsName + '::event::helper::ucr_group_classifications' ;
	export event_helper_ucr_group_classifications_lInputHistTemplate 					
			:= thor_cluster + 'in::'   + dsName + '::event::helper::ucr_group_classifications::history';
	export event_helper_ucr_group_classifications_Base		  										
			:= tools.mod_FilenamesBuild(event_helper_ucr_group_classifications_lBaseTemplate, version);
	
	export event_address_lookup_lBaseTemplate_built
			:= thor_cluster + 'base::' + dsName + '::event::import::address_lookup::built';
	export event_address_lookup_lBaseTemplate
			:= thor_cluster + 'base::' + dsName+ '::event::import::address_lookup::@version@';
	export event_address_lookup_lKeyTemplate	  							
			:= thor_cluster + 'base::' + dsName + '_keybuild' + '::event::import::address_lookup::@version@';		
	export event_address_lookup_lInputTemplate 							
			:= thor_cluster + 'in::'   + dsName + '::event::import::address_lookup' ;
	export event_address_lookup_lInputHistTemplate 					
			:= thor_cluster + 'in::'   + dsName + '::event::import::address_lookup::history';
	export event_address_lookup_Base		  										
			:= tools.mod_FilenamesBuild(event_address_lookup_lBaseTemplate, version);
			
	export intersection_coordinates_lBaseTemplate_built
			:= thor_cluster + 'base::' + dsName + '::dbo::intersectioncoordinates::built';
	export intersection_coordinates_lBaseTemplate
			:= thor_cluster + 'base::' + dsName+ '::dbo::intersectioncoordinates::@version@';
	export intersection_coordinates_lKeyTemplate	  							
			:= thor_cluster + 'base::' + dsName + '_keybuild' + '::dbo::intersectioncoordinatess::@version@';		
	export intersection_coordinates_lInputTemplate 							
			:= thor_cluster + 'in::'   + dsName + '::dbo::intersectioncoordinates' ;
	export intersection_coordinates_lInputHistTemplate 					
			:= thor_cluster + 'in::'   + dsName + '::dbo::intersectioncoordinates::history';
	export intersection_coordinates_Base		  										
			:= tools.mod_FilenamesBuild(intersection_coordinates_lBaseTemplate, version);	
	
	export agency_deletes_lBaseTemplate_built
			:= thor_cluster + 'base::' + dsName + '::agency_removed::dbo::agency_deletes::built';
	export agency_deletes_lBaseTemplate
			:= thor_cluster + 'base::' + dsName+ '::agency_removed::dbo::agency_deletes::@version@';
	export agency_deletes_lKeyTemplate	  							
			:= thor_cluster + 'base::' + dsName + '_keybuild' + '::agency_removed::dbo::agency_deletes::@version@';		
	export agency_deletes_lInputTemplate 							
			:= thor_cluster + 'in::'   + dsName + '::agency_removed::dbo::agency_deletes' ;
	export agency_deletes_lInputHistTemplate 					
			:= thor_cluster + 'in::'   + dsName + '::agency_removed::dbo::agency_deletes::history';
	export agency_deletes_Base		  										
			:= tools.mod_FilenamesBuild(agency_deletes_lBaseTemplate, version);	
	
	export cfs_dbo_cfs_2_lBaseTemplate_built
			:= thor_cluster + 'base::' + dsName + '::cfs::dbo::cfs_2::built';
	export cfs_dbo_cfs_2_lBaseTemplate
			:= thor_cluster + 'base::' + dsName+ '::cfs::dbo::cfs_2::@version@';
	export cfs_dbo_cfs_2_lKeyTemplate	  							
			:= thor_cluster + 'base::' + dsName + '_keybuild' + '::cfs::dbo::cfs_2::@version@';		
	export cfs_dbo_cfs_2_lInputTemplate 							
			:= thor_cluster + 'in::'   + dsName + '::cfs::dbo::cfs_2' ;
	export cfs_dbo_cfs_2_lInputHistTemplate 					
			:= thor_cluster + 'in::'   + dsName + '::cfs::dbo::cfs_2::history';
	export cfs_dbo_cfs_2_Base		  										
			:= tools.mod_FilenamesBuild(cfs_dbo_cfs_2_lBaseTemplate, version);
	
	export cfs_dbo_cfs_officers_2_lBaseTemplate_built	
			:= thor_cluster + 'base::' + dsName + '::cfs::dbo::cfs_officers_2::built';
	export cfs_dbo_cfs_officers_2_lBaseTemplate				
			:= thor_cluster + 'base::' + dsName+ '::cfs::dbo::cfs_officers_2::@version@';
	export cfs_dbo_cfs_officers_2_lKeyTemplate	  		
			:= thor_cluster + 'base::' + dsName + '_keybuild' + '::event::dbo::cfs_officers_2::@version@';		
	export cfs_dbo_cfs_officers_2_lInputTemplate 			
			:= thor_cluster + 'in::'   + dsName + '::cfs::dbo::cfs_officers_2' ;
	export cfs_dbo_cfs_officers_2_lInputHistTemplate 	
			:= thor_cluster + 'in::'   + dsName + '::cfs::dbo::cfs_officers_2::history';
	export cfs_dbo_cfs_officers_2_Base		  					
			:= tools.mod_FilenamesBuild(cfs_dbo_cfs_officers_2_lBaseTemplate, version);

	export cfs_dbo_agencycfstypelookup_lBaseTemplate_built		
			:= thor_cluster + 'base::' + dsName + '::cfs::dbo::agencycfstypelookup::built';
	export cfs_dbo_agencycfstypelookup_lBaseTemplate					
			:= thor_cluster + 'base::' + dsName+ '::cfs::dbo::agencycfstypelookup::@version@';
	export cfs_dbo_agencycfstypelookup_lKeyTemplate	  				
			:= thor_cluster + 'base::' + dsName + '_keybuild' + '::cfs::dbo::agencycfstypelookup::@version@';		
	export cfs_dbo_agencycfstypelookup_lInputTemplate 				
			:= thor_cluster + 'in::'   + dsName + '::cfs::dbo::agencycfstypelookup' ;
	export cfs_dbo_agencycfstypelookup_lInputHistTemplate 		
			:= thor_cluster + 'in::'   + dsName + '::cfs::dbo::agencycfstypelookup::history';
	export cfs_dbo_AgencyCfsTypeLookup_Base		  							
			:= tools.mod_FilenamesBuild(cfs_dbo_agencycfstypelookup_lBaseTemplate, version);
			
	export event_dbo_mo_lBaseTemplate_built							
			:= thor_cluster + 'base::' + dsName + '::event::dbo::mo::built';
	export event_dbo_mo_lBaseTemplate										
			:= thor_cluster + 'base::' + dsName+ '::event::dbo::mo::@version@';
	export event_dbo_mo_lKeyTemplate	  								
			:= thor_cluster + 'base::' + dsName + '_keybuild' + '::event::dbo::mo::@version@';		
	export event_dbo_mo_lInputTemplate 									
			:= thor_cluster + 'in::'   + dsName + '::event::dbo::mo' ;
	export event_dbo_mo_lInputHistTemplate 							
			:= thor_cluster + 'in::'   + dsName + '::event::dbo::mo::history';
	export event_dbo_mo_Base		  											
			:= tools.mod_FilenamesBuild(event_dbo_mo_lBaseTemplate, version);
	
	export event_dbo_vehicle_lBaseTemplate_built				
			:= thor_cluster + 'base::' + dsName + '::event::dbo::vehicle::built';
	export event_dbo_vehicle_lBaseTemplate							
			:= thor_cluster + 'base::' + dsName+ '::event::dbo::vehicle::@version@';
	export event_dbo_vehicle_lKeyTemplate	  						
			:= thor_cluster + 'base::' + dsName + '_keybuild' + '::event::dbo::vehicle::@version@';		
	export event_dbo_vehicle_lInputTemplate 						
			:= thor_cluster + 'in::'   + dsName + '::event::dbo::vehicle' ;
	export event_dbo_vehicle_lInputHistTemplate 				
			:= thor_cluster + 'in::'   + dsName + '::event::dbo::vehicle::history';
	export event_dbo_vehicle_Base		  									
			:= tools.mod_FilenamesBuild(event_dbo_vehicle_lBaseTemplate, version);
	
	export event_dbo_persons_lBaseTemplate_built				
			:= thor_cluster + 'base::' + dsName + '::event::dbo::persons::built';
	export event_dbo_persons_lBaseTemplate							
			:= thor_cluster + 'base::' + dsName+ '::event::dbo::persons::@version@';
	export event_dbo_persons_lKeyTemplate	  						
			:= thor_cluster + 'base::' + dsName + '_keybuild' + '::event::dbo::persons::@version@';		
	export event_dbo_persons_lInputTemplate 						
			:= thor_cluster + 'in::'   + dsName + '::event::dbo::persons' ;
	export event_dbo_persons_lInputHistTemplate 				
			:= thor_cluster + 'in::'   + dsName + '::event::dbo::persons::history';
	export event_dbo_persons_Base		  									
			:= tools.mod_FilenamesBuild(event_dbo_persons_lBaseTemplate, version);
	
	export event_import_group_access_lBaseTemplate_built				
			:= thor_cluster + 'base::' + dsName + '::event::import::group_access::built';
	export event_import_group_access_lBaseTemplate							
			:= thor_cluster + 'base::' + dsName+ '::event::import::group_access::@version@';
	export event_import_group_access_lKeyTemplate	  						
			:= thor_cluster + 'base::' + dsName + '_keybuild' + '::event::import::group_access::@version@';
	export event_import_group_access_lInputTemplate 			
			:= thor_cluster + 'in::'   + dsName + '::event::import::group_access' ;
	export event_import_group_access_lInputHistTemplate 	
			:= thor_cluster + 'in::'   + dsName + '::event::import::group_access::history';
	export event_import_group_access_Base		  									
			:= tools.mod_FilenamesBuild(event_import_group_access_lBaseTemplate, version);	
	
	export event_dbo_AgencyCrimeTypeLookup_lBaseTemplate_built		
			:= thor_cluster + 'base::' + dsName + '::event::dbo::agencycrimetypelookup::built';
	export event_dbo_AgencyCrimeTypeLookup_lBaseTemplate					
			:= thor_cluster + 'base::' + dsName+ '::event::dbo::agencycrimetypelookup::@version@';
	export event_dbo_AgencyCrimeTypeLookup_lKeyTemplate	  				
			:= thor_cluster + 'base::' + dsName + '_keybuild' + '::event::dbo::agencycrimetypelookup::@version@';		
	export event_dbo_AgencyCrimeTypeLookup_lInputTemplate 				
			:= thor_cluster + 'in::'   + dsName + '::event::dbo::agencycrimetypelookup' ;
	export event_dbo_AgencyCrimeTypeLookup_lInputHistTemplate 		
			:= thor_cluster + 'in::'   + dsName + '::event::dbo::agencycrimetypelookup::history';
	export event_dbo_AgencyCrimeTypeLookup_Base		  							
			:= tools.mod_FilenamesBuild(event_dbo_AgencyCrimeTypeLookup_lBaseTemplate, version);	
	
	export event_dbo_data_provider_lBaseTemplate_built	
			:= thor_cluster + 'base::' + dsName + '::event::dbo::data_provider::built';
	export event_dbo_data_provider_lBaseTemplate				
			:= thor_cluster + 'base::' + dsName+ '::event::dbo::data_provider::@version@';
	export event_dbo_data_provider_lKeyTemplate	  			
			:= thor_cluster + 'base::' + dsName + '_keybuild' + '::event::dbo::data_provider::@version@';		
	export event_dbo_data_provider_lInputTemplate 			
			:= thor_cluster + 'in::' + dsName + '::event::dbo::data_provider' ;
	export event_dbo_data_provider_lInputHistTemplate 	
			:= thor_cluster + 'in::' + dsName + '::event::dbo::data_provider::history';
	export event_dbo_data_provider_Base		  						
			:= tools.mod_FilenamesBuild(event_dbo_data_provider_lBaseTemplate, version);
	
	export event_dbo_data_provider_location_lBaseTemplate_built	
			:= thor_cluster + 'base::' + dsName + '::event::dbo::data_provider_location::built';
	export event_dbo_data_provider_location_lBaseTemplate				
			:= thor_cluster + 'base::' + dsName+ '::event::dbo::data_provider_location::@version@';
	export event_dbo_data_provider_location_lKeyTemplate	  		
			:= thor_cluster + 'base::' + dsName + '_keybuild' + '::event::dbo::data_provider_location::@version@';
	export event_dbo_data_provider_location_lInputTemplate 			
			:= thor_cluster + 'in::' + dsName + '::event::dbo::data_provider_location' ;
	export event_dbo_data_provider_location_lInputHistTemplate 	
			:= thor_cluster + 'in::' + dsName + '::event::dbo::data_provider_location::history';
	export event_dbo_data_provider_location_Base		  					
			:= tools.mod_FilenamesBuild(event_dbo_data_provider_location_lBaseTemplate, version);

	export event_dbo_data_provider_import_lBaseTemplate_built	
			:= thor_cluster + 'base::' + dsName + '::event::dbo::data_provider_import::built';
	export event_dbo_data_provider_import_lBaseTemplate				
			:= thor_cluster + 'base::' + dsName+ '::event::dbo::data_provider_import::@version@';
	export event_dbo_data_provider_import_lKeyTemplate	  			
			:= thor_cluster + 'base::' + dsName + '_keybuild' + '::event::dbo::data_provider_import::@version@';		
	export event_dbo_data_provider_import_lInputTemplate 			
			:= thor_cluster + 'in::' + dsName + '::event::dbo::data_provider_import' ;
	export event_dbo_data_provider_import_lInputHistTemplate 	
			:= thor_cluster + 'in::' + dsName + '::event::dbo::data_provider_import::history';
	export event_dbo_data_provider_import_Base		  						
			:= tools.mod_FilenamesBuild(event_dbo_data_provider_import_lBaseTemplate, version);
		
	export intel_dbo_entity_lBaseTemplate_built									
			:= thor_cluster + 'base::' + dsName + '::intel::dbo::entity::built';
	export intel_dbo_entity_lBaseTemplate										
			:= thor_cluster + 'base::' + dsName+ '::intel::dbo::entity::@version@';
	export intel_dbo_entity_lKeyTemplate	  							
			:= thor_cluster + 'base::' + dsName + '_keybuild' + '::intel::dbo::entity::@version@';		
	export intel_dbo_entity_lInputTemplate 							
			:= thor_cluster + 'in::'   + dsName + '::intel::dbo::entity' ;
	export intel_dbo_entity_lInputHistTemplate 					
			:= thor_cluster + 'in::'   + dsName + '::intel::dbo::entity::history';
	export intel_dbo_entity_Base		  										
			:= tools.mod_FilenamesBuild(intel_dbo_entity_lBaseTemplate, version);
	
	export intel_dbo_entity_notes_lBaseTemplate_built	
			:= thor_cluster + 'base::' + dsName + '::intel::dbo::entity_notes::built';
	export intel_dbo_entity_notes_lBaseTemplate				
			:= thor_cluster + 'base::' + dsName+ '::intel::dbo::entity_notes::@version@';
	export intel_dbo_entity_notes_lKeyTemplate	  		
			:= thor_cluster + 'base::' + dsName + '_keybuild' + '::intel::dbo::entity_notes::@version@';		
	export intel_dbo_entity_notes_lInputTemplate 			
			:= thor_cluster + 'in::'   + dsName + '::intel::dbo::entity_notes' ;
	export intel_dbo_entity_notes_lInputHistTemplate 	
			:= thor_cluster + 'in::'   + dsName + '::intel::dbo::entity_notes::history';
	export intel_dbo_entity_notes_Base		  					
			:= tools.mod_FilenamesBuild(intel_dbo_entity_notes_lBaseTemplate, version);
	
	export intel_dbo_incident_lBaseTemplate_built							
			:= thor_cluster + 'base::' + dsName + '::intel::dbo::incident::built';
	export intel_dbo_incident_lBaseTemplate										
			:= thor_cluster + 'base::' + dsName+ '::intel::dbo::incident::@version@';
	export intel_dbo_incident_lKeyTemplate	  								
			:= thor_cluster + 'base::' + dsName + '_keybuild' + '::intel::dbo::incident::@version@';		
	export intel_dbo_incident_lInputTemplate 									
			:= thor_cluster + 'in::'   + dsName + '::intel::dbo::incident' ;
	export intel_dbo_incident_lInputHistTemplate 							
			:= thor_cluster + 'in::'   + dsName + '::intel::dbo::incident::history';
	export intel_dbo_incident_Base		  											
			:= tools.mod_FilenamesBuild(intel_dbo_incident_lBaseTemplate, version);
	
	export intel_dbo_incident_notes_lBaseTemplate_built				
			:= thor_cluster + 'base::' + dsName + '::intel::dbo::incident_notes::built';
	export intel_dbo_incident_notes_lBaseTemplate							
			:= thor_cluster + 'base::' + dsName+ '::intel::dbo::incident_notes::@version@';
	export intel_dbo_incident_notes_lKeyTemplate	  						
			:= thor_cluster + 'base::' + dsName + '_keybuild' + '::intel::dbo::incident_notes::@version@';		
	export intel_dbo_incident_notes_lInputTemplate 						
			:= thor_cluster + 'in::'   + dsName + '::intel::dbo::incident_notes' ;
	export intel_dbo_incident_notes_lInputHistTemplate 				
			:= thor_cluster + 'in::'   + dsName + '::intel::dbo::incident_notes::history';
	export intel_dbo_incident_notes_Base		  									
			:= tools.mod_FilenamesBuild(intel_dbo_incident_notes_lBaseTemplate, version);
	
	export intel_dbo_reporting_officer_lBaseTemplate_built				
			:= thor_cluster + 'base::' + dsName + '::intel::dbo::reporting_officer::built';
	export intel_dbo_reporting_officer_lBaseTemplate							
			:= thor_cluster + 'base::' + dsName+ '::intel::dbo::reporting_officer::@version@';
	export intel_dbo_reporting_officer_lKeyTemplate	  						
			:= thor_cluster + 'base::' + dsName + '_keybuild' + '::intel::dbo::reporting_officer::@version@';		
	export intel_dbo_reporting_officer_lInputTemplate 						
			:= thor_cluster + 'in::'   + dsName + '::intel::dbo::reporting_officer' ;
	export intel_dbo_reporting_officer_lInputHistTemplate 				
			:= thor_cluster + 'in::'   + dsName + '::intel::dbo::reporting_officer::history';
	export intel_dbo_reporting_officer_Base		  									
			:= tools.mod_FilenamesBuild(intel_dbo_reporting_officer_lBaseTemplate, version);
	
	export intel_dbo_vehicle_notes_lBaseTemplate_built					
			:= thor_cluster + 'base::' + dsName + '::intel::dbo::vehicle_notes::built';
	export intel_dbo_vehicle_notes_lBaseTemplate								
			:= thor_cluster + 'base::' + dsName+ '::intel::dbo::vehicle_notes::@version@';
	export intel_dbo_vehicle_notes_lKeyTemplate	  						
			:= thor_cluster + 'base::' + dsName + '_keybuild' + '::intel::dbo::vehicle_notes::@version@';		
	export intel_dbo_vehicle_notes_lInputTemplate 							
			:= thor_cluster + 'in::'   + dsName + '::intel::dbo::vehicle_notes' ;
	export intel_dbo_vehicle_notes_lInputHistTemplate 					
			:= thor_cluster + 'in::'   + dsName + '::intel::dbo::vehicle_notes::history';
	export intel_dbo_vehicle_notes_Base		  									
			:= tools.mod_FilenamesBuild(intel_dbo_vehicle_notes_lBaseTemplate, version);
	
	export intel_dbo_entity_photo_lBaseTemplate_built		
			:= thor_cluster + 'base::' + dsName + '::intel::dbo::entity_photo::built';
	export intel_dbo_entity_photo_lBaseTemplate					
			:= thor_cluster + 'base::' + dsName+ '::intel::dbo::entity_photo::@version@';
	export intel_dbo_entity_photo_lKeyTemplate	  				
			:= thor_cluster + 'base::' + dsName + '_keybuild' + '::intel::dbo::entity_photo::@version@';		
	export intel_dbo_entity_photo_lInputTemplate 				
			:= thor_cluster + 'in::'   + dsName + '::intel::dbo::entity_photo' ;
	export intel_dbo_entity_photo_lInputHistTemplate 		
			:= thor_cluster + 'in::'   + dsName + '::intel::dbo::entity_photo::history';
	export intel_dbo_entity_photo_Base		  							
			:= tools.mod_FilenamesBuild(intel_dbo_entity_photo_lBaseTemplate, version);
	
	export offenders_dbo_offender_classification_lBaseTemplate_built	
			:= thor_cluster + 'base::' + dsName + '::offenders::dbo::offender_classification::built';
	export offenders_dbo_offender_classification_lBaseTemplate				
			:= thor_cluster + 'base::' + dsName+ '::offenders::dbo::offender_classification::@version@';
	export offenders_dbo_offender_classification_lKeyTemplate	  		
			:= thor_cluster + 'base::' + dsName + '_keybuild' + '::offenders::dbo::offender_classification::@version@';
	export offenders_dbo_offender_classification_lInputTemplate 			
			:= thor_cluster + 'in::' + dsName + '::offenders::dbo::offender_classification' ;
	export offenders_dbo_offender_classification_lInputHistTemplate 	
			:= thor_cluster + 'in::' + dsName + '::offenders::dbo::offender_classification::history';
	export offenders_dbo_offender_classification_Base		  					
			:= tools.mod_FilenamesBuild(offenders_dbo_offender_classification_lBaseTemplate, version);
	
	export offenders_dbo_offender_lBaseTemplate_built					
			:= thor_cluster + 'base::' + dsName + '::offenders::dbo::offender::built';
	export offenders_dbo_offender_lBaseTemplate								
			:= thor_cluster + 'base::' + dsName+ '::offenders::dbo::offender::@version@';
	export offenders_dbo_offender_lKeyTemplate	  							
			:= thor_cluster + 'base::' + dsName + '_keybuild' + '::offenders::dbo::offender::@version@';		
	export offenders_dbo_offender_lInputTemplate 							
			:= thor_cluster + 'in::'   + dsName + '::offenders::dbo::offender' ;
	export offenders_dbo_offender_lInputHistTemplate 					
			:= thor_cluster + 'in::'   + dsName + '::offenders::dbo::offender::history';
	export offenders_dbo_offender_Base		  										
			:= tools.mod_FilenamesBuild(offenders_dbo_offender_lBaseTemplate, version);

	export offenders_dbo_picture_lBaseTemplate_built					
			:= thor_cluster + 'base::' + dsName + '::offenders::dbo::offender_picture::built';
	export offenders_dbo_picture_lBaseTemplate								
			:= thor_cluster + 'base::' + dsName+ '::offenders::dbo::offender_picture::@version@';
	export offenders_dbo_picture_lKeyTemplate	  							
			:= thor_cluster + 'base::' + dsName + '_keybuild' + '::offenders::dbo::offender_picture::@version@';		
	export offenders_dbo_picture_lInputTemplate 							
			:= thor_cluster + 'in::'   + dsName + '::offenders::dbo::offender_picture' ;
	export offenders_dbo_picture_lInputHistTemplate 					
			:= thor_cluster + 'in::'   + dsName + '::offenders::dbo::offender_picture::history';
	export offenders_dbo_picture_Base		  										
			:= tools.mod_FilenamesBuild(offenders_dbo_picture_lBaseTemplate, version);
	
	export offenders_dbo_classification_lBaseTemplate_built	
			:= thor_cluster + 'base::' + dsName + '::offenders::dbo::classification::built';
	export offenders_dbo_classification_lBaseTemplate				
			:= thor_cluster + 'base::' + dsName+ '::offenders::dbo::classification::@version@';
	export offenders_dbo_classification_lKeyTemplate	  			
			:= thor_cluster + 'base::' + dsName + '_keybuild' + '::offenders::dbo::classification::@version@';		
	export offenders_dbo_classification_lInputTemplate 			
			:= thor_cluster + 'in::' + dsName + '::offenders::dbo::classification' ;
	export offenders_dbo_classification_lInputHistTemplate 	
			:= thor_cluster + 'in::' + dsName + '::offenders::dbo::classification::history';
	export offenders_dbo_classification_Base		  						
			:= tools.mod_FilenamesBuild(offenders_dbo_classification_lBaseTemplate, version);
			
	export crash_dbo_crash_lBaseTemplate_built							
			:= thor_cluster + 'base::' + dsName + '::crash::dbo::crash::built';
	export crash_dbo_crash_lBaseTemplate										
			:= thor_cluster + 'base::' + dsName+ '::crash::dbo::crash::@version@';
	export crash_dbo_crash_lKeyTemplate	  								
			:= thor_cluster + 'base::' + dsName + '_keybuild' + '::crash::dbo::crash::@version@';		
	export crash_dbo_crash_lInputTemplate 									
			:= thor_cluster + 'in::'   + dsName + '::crash::dbo::crash' ;
	export crash_dbo_crash_lInputHistTemplate 							
			:= thor_cluster + 'in::'   + dsName + '::crash::dbo::crash::history';
	export crash_dbo_crash_Base		  											
			:= tools.mod_FilenamesBuild(crash_dbo_crash_lBaseTemplate, version);
	
	export crash_dbo_person_lBaseTemplate_built				
			:= thor_cluster + 'base::' + dsName + '::crash::dbo::person::built';
	export crash_dbo_person_lBaseTemplate							
			:= thor_cluster + 'base::' + dsName+ '::crash::dbo::person::@version@';
	export crash_dbo_person_lKeyTemplate	  						
			:= thor_cluster + 'base::' + dsName + '_keybuild' + '::crash::dbo::person::@version@';		
	export crash_dbo_person_lInputTemplate 						
			:= thor_cluster + 'in::'   + dsName + '::crash::dbo::person' ;
	export crash_dbo_person_lInputHistTemplate 				
			:= thor_cluster + 'in::'   + dsName + '::crash::dbo::person::history';
	export crash_dbo_person_Base		  									
			:= tools.mod_FilenamesBuild(crash_dbo_person_lBaseTemplate, version);
	
	export crash_dbo_vehicle_lBaseTemplate_built				
			:= thor_cluster + 'base::' + dsName + '::crash::dbo::vehicle::built';
	export crash_dbo_vehicle_lBaseTemplate							
			:= thor_cluster + 'base::' + dsName+ '::crash::dbo::vehicle::@version@';
	export crash_dbo_vehicle_lKeyTemplate	  						
			:= thor_cluster + 'base::' + dsName + '_keybuild' + '::crash::dbo::vehicle::@version@';		
	export crash_dbo_vehicle_lInputTemplate 						
			:= thor_cluster + 'in::'   + dsName + '::crash::dbo::vehicle' ;
	export crash_dbo_vehicle_lInputHistTemplate 				
			:= thor_cluster + 'in::'   + dsName + '::crash::dbo::vehicle::history';
	export crash_dbo_vehicle_Base		  									
			:= tools.mod_FilenamesBuild(crash_dbo_vehicle_lBaseTemplate, version);
	
	export lpr_dbo_licenseplateevent_lBaseTemplate_built	
			:= thor_cluster + 'base::' + dsName + '::dbo::licenseplateevent::built' + suffixBaseBuilt;
	export lpr_dbo_licenseplateevent_lBaseTemplate				
			:= thor_cluster + 'base::' + dsName+ '::dbo::licenseplateevent' + suffixBaseVersion;
	export lpr_dbo_licenseplateevent_lKeyTemplate	  			
			:= thor_cluster + 'base::' + dsName + '_keybuild' + '::dbo::licenseplateevent::@version@';		
	export lpr_dbo_licenseplateevent_lInputTemplate 			
			:= thor_cluster + 'in::'   + dsName + '::lpr::dbo::licenseplateevent' ;
	export lpr_dbo_licenseplateevent_lInputHistTemplate 	
			:= thor_cluster + 'in::'   + dsName + '::lpr::dbo::licenseplateevent::history';
	export lpr_dbo_licenseplateevent_Base		  						
			:= tools.mod_FilenamesBuild(lpr_dbo_licenseplateevent_lBaseTemplate, version);
		
	export dbo_cfs_lBaseTemplate_built				
			:= thor_cluster + 'base::' + dsName + '::dbo::cfs::built' + suffixBaseBuilt;
	export dbo_cfs_lBaseTemplate							
			:= thor_cluster + 'base::' + dsName+ '::dbo::cfs' + suffixBaseVersion;
	export dbo_cfs_lKeyTemplate	  						
			:= thor_cluster + 'base::' + dsName + '_keybuild' + '::dbo::cfs::@version@';
	export dbo_cfs_lInputTemplate 			
			:= thor_cluster + 'in::'   + dsName + '::dbo::cfs' ;
	export dbo_cfs_lInputHistTemplate 	
			:= thor_cluster + 'in::'   + dsName + '::dbo::cfs::history';
	export dbo_cfs_Base		  									
			:= tools.mod_FilenamesBuild(dbo_cfs_lBaseTemplate, version);						
	
	export event_dbo_mo_udf_lBaseTemplate_built					
			:= thor_cluster + 'base::' + dsName + '::event::dbo::mo_udf::built' + suffixBaseBuilt;
	export event_dbo_mo_udf_lBaseTemplate								
			:= thor_cluster + 'base::' + dsName+ '::event::dbo::mo_udf' + suffixBaseVersion;
	export event_dbo_mo_udf_lKeyTemplate	  						
			:= thor_cluster + 'base::' + dsName + '_keybuild' + '::event::dbo::mo_udf::@version@';		
	export event_dbo_mo_udf_lInputTemplate 							
			:= thor_cluster + 'in::'   + dsName + '::event::dbo::mo_udf' ;
	export event_dbo_mo_udf_lInputHistTemplate 					
			:= thor_cluster + 'in::'   + dsName + '::event::dbo::mo_udf::history';
	export event_dbo_mo_udf_Base		  									
			:= tools.mod_FilenamesBuild(event_dbo_mo_udf_lBaseTemplate, version);
	
	export event_dbo_persons_udf_lBaseTemplate_built		
			:= thor_cluster + 'base::' + dsName + '::event::dbo::persons_udf::built' + suffixBaseBuilt;
	export event_dbo_persons_udf_lBaseTemplate					
			:= thor_cluster + 'base::' + dsName+ '::event::dbo::persons_udf' + suffixBaseVersion;
	export event_dbo_persons_udf_lKeyTemplate	  				
			:= thor_cluster + 'base::' + dsName + '_keybuild' + '::event::dbo::persons_udf::@version@';		
	export event_dbo_persons_udf_lInputTemplate 				
			:= thor_cluster + 'in::'   + dsName + '::event::dbo::persons_udf' ;
	export event_dbo_persons_udf_lInputHistTemplate 		
			:= thor_cluster + 'in::'   + dsName + '::event::dbo::persons_udf::history';
	export event_dbo_persons_udf_Base		  							
			:= tools.mod_FilenamesBuild(event_dbo_persons_udf_lBaseTemplate, version);
	
	export dbo_event_mo_lBaseTemplate_built				
			:= thor_cluster + 'base::' + dsName + '::dbo::mo::built' + suffixBaseBuilt;
	export dbo_event_mo_lBaseTemplate							
			:= thor_cluster + 'base::' + dsName+ '::dbo::mo' + suffixBaseVersion;
	export dbo_event_mo_lKeyTemplate	  						
			:= thor_cluster + 'base::' + dsName + '_keybuild' + '::dbo::mo::@version@';	
	export dbo_event_mo_lInputTemplate 			
			:= thor_cluster + 'in::'   + dsName + '::dbo::mo' ;
	export dbo_event_mo_lInputHistTemplate 	
			:= thor_cluster + 'in::'   + dsName + '::dbo::mo::history';
	export dbo_event_mo_Base		  									
			:= tools.mod_FilenamesBuild(dbo_event_mo_lBaseTemplate, version);
	
	export dbo_event_persons_lBaseTemplate_built				
			:= thor_cluster + 'base::' + dsName + '::dbo::persons::built' + suffixBaseBuilt;
	export dbo_event_persons_lBaseTemplate							
			:= thor_cluster + 'base::' + dsName+ '::dbo::persons' + suffixBaseVersion;
	export dbo_event_persons_lKeyTemplate	  						
			:= thor_cluster + 'base::' + dsName + '_keybuild' + '::dbo::persons::@version@';
	export dbo_event_persons_lInputTemplate 			
			:= thor_cluster + 'in::'   + dsName + '::dbo::persons' ;
	export dbo_event_persons_lInputHistTemplate 	
			:= thor_cluster + 'in::'   + dsName + '::dbo::persons::history';
	export dbo_event_persons_Base		  									
			:= tools.mod_FilenamesBuild(dbo_event_persons_lBaseTemplate, version);
			
	export dbo_event_vehicle_lBaseTemplate_built				
			:= thor_cluster + 'base::' + dsName + '::dbo::vehicle::built' + suffixBaseBuilt;
	export dbo_event_vehicle_lBaseTemplate							
			:= thor_cluster + 'base::' + dsName+ '::dbo::vehicle' + suffixBaseVersion;
	export dbo_event_vehicle_lKeyTemplate	  						
			:= thor_cluster + 'base::' + dsName + '_keybuild' + '::dbo::vehicle::@version@';
	export dbo_event_vehicle_lInputTemplate 			
			:= thor_cluster + 'in::'   + dsName + '::dbo::vehicle' ;
	export dbo_event_vehicle_lInputHistTemplate 	
			:= thor_cluster + 'in::'   + dsName + '::dbo::vehicle::history';
	export dbo_event_vehicle_Base		  									
			:= tools.mod_FilenamesBuild(dbo_event_vehicle_lBaseTemplate, version);
			
	export event_group_access_lBaseTemplate_built				
			:= thor_cluster + 'base::' + dsName + '::event::group_access::built';
	export event_group_access_lBaseTemplate							
			:= thor_cluster + 'base::' + dsName+ '::event::group_access::@version@';
	export event_group_access_lKeyTemplate	  						
			:= thor_cluster + 'base::' + dsName + '_keybuild' + '::event::group_access::@version@';
	export event_group_access_lInputTemplate 			
			:= thor_cluster + 'in::'   + dsName + '::event::group_access' ;
	export event_group_access_lInputHistTemplate 	
			:= thor_cluster + 'in::'   + dsName + '::event::group_access::history';
	export event_group_access_Base		  									
			:= tools.mod_FilenamesBuild(event_group_access_lBaseTemplate, version);
			
	export dbo_intel_lBaseTemplate_built				
			:= thor_cluster + 'base::' + dsName + '::dbo::intel::built' + suffixBaseBuilt;
	export dbo_intel_lBaseTemplate								
			:= thor_cluster + 'base::' + dsName+ '::dbo::intel' + suffixBaseVersion;
	export dbo_intel_lKeyTemplate	  						
			:= thor_cluster + 'base::' + dsName + '_keybuild' + '::dbo::intel::@version@';
	export dbo_intel_lInputTemplate 			
			:= thor_cluster + 'in::'   + dsName + '::dbo::intel' ;
	export dbo_intel_lInputHistTemplate 	
			:= thor_cluster + 'in::'   + dsName + '::dbo::intel::history';
	export dbo_intel_Base		  										
			:= tools.mod_FilenamesBuild(dbo_intel_lBaseTemplate, version);
			
	export dbo_offenders_lBaseTemplate_built				
			:= thor_cluster + 'base::' + dsName + '::dbo::offenders::built' + suffixBaseBuilt;
	export dbo_offenders_lBaseTemplate							
			:= thor_cluster + 'base::' + dsName+ '::dbo::offenders' + suffixBaseVersion;
	export dbo_offenders_lKeyTemplate	  						
			:= thor_cluster + 'base::' + dsName + '_keybuild' + '::dbo::offenders::@version@';
	export dbo_offenders_lInputTemplate 			
			:= thor_cluster + 'in::'   + dsName + '::dbo::offenders' ;
	export dbo_offenders_lInputHistTemplate 	
			:= thor_cluster + 'in::'   + dsName + '::dbo::offenders::history';
	export dbo_offenders_Base		  									
			:= tools.mod_FilenamesBuild(dbo_offenders_lBaseTemplate, version);
			
	export dbo_offenders_Picture_lBaseTemplate_built				
			:= thor_cluster + 'base::' + dsName + '::dbo::offenders_picture::built' + suffixBaseBuilt;
	export dbo_offenders_Picture_lBaseTemplate							
			:= thor_cluster + 'base::' + dsName+ '::dbo::offenders_picture' + suffixBaseVersion;
	export dbo_offenders_Picture_lKeyTemplate	  						
			:= thor_cluster + 'base::' + dsName + '_keybuild' + '::dbo::offenders_picture::@version@';
	export dbo_offenders_Picture_lInputTemplate 			
			:= thor_cluster + 'in::'   + dsName + '::dbo::offenders_picture' ;
	export dbo_offenders_Picture_lInputHistTemplate 	
			:= thor_cluster + 'in::'   + dsName + '::dbo::offenders_picture::history';
	export dbo_offenders_Picture_Base		  									
			:= tools.mod_FilenamesBuild(dbo_offenders_Picture_lBaseTemplate, version);			
	
	export dbo_offenders_class_lBaseTemplate_built				
			:= thor_cluster + 'base::' + dsName + '::dbo::offenders_classification::built' + suffixBaseBuilt;
	export dbo_offenders_class_lBaseTemplate							
			:= thor_cluster + 'base::' + dsName+ '::dbo::offenders_classification' + suffixBaseVersion;
	export dbo_offenders_class_lKeyTemplate	  						
			:= thor_cluster + 'base::' + dsName + '_keybuild' + '::dbo::offenders_classification::@version@';
	export dbo_offenders_class_lInputTemplate 			
			:= thor_cluster + 'in::'   + dsName + '::dbo::offenders_classification' ;
	export dbo_offenders_class_lInputHistTemplate 	
			:= thor_cluster + 'in::'   + dsName + '::dbo::offenders_classification::history';
	export dbo_offenders_class_Base		  									
			:= tools.mod_FilenamesBuild(dbo_offenders_class_lBaseTemplate, version);
			
	export dbo_crash_lBaseTemplate_built						
			:= thor_cluster + 'base::' + dsName + '::dbo::crash::built' + suffixBaseBuilt;
	export dbo_crash_lBaseTemplate									
			:= thor_cluster + 'base::' + dsName+ '::dbo::crash' + suffixBaseVersion;
	export dbo_crash_lKeyTemplate	  								
			:= thor_cluster + 'base::' + dsName + '_keybuild' + '::dbo::crash::@version@';
	export dbo_crash_lInputTemplate 			
			:= thor_cluster + 'in::'   + dsName + '::dbo::crash' ;
	export dbo_crash_lInputHistTemplate 	
			:= thor_cluster + 'in::'   + dsName + '::dbo::crash::history';
	export dbo_crash_Base		  											
			:= tools.mod_FilenamesBuild(dbo_crash_lBaseTemplate, version);
	
	export gunop_dbo_shot_incident_lBaseTemplate_built	
			:= thor_cluster + 'base::' + dsName + '::dbo::Shotspotter::built' + suffixBaseBuilt;
	export gunop_dbo_shot_incident_lBaseTemplate				
			:= thor_cluster + 'base::' + dsName+ '::dbo::Shotspotter' + suffixBaseVersion;
	export gunop_dbo_shot_incident_lKeyTemplate	  			
			:= thor_cluster + 'base::' + dsName + '_keybuild' + '::dbo::Shotspotter::@version@';		
	export gunop_dbo_shot_incident_lInputTemplate 			
			:= thor_cluster + 'in::'   + dsName + '::gunop::dbo::shot_incident' ;
	export gunop_dbo_shot_incident_lInputHistTemplate 	
			:= thor_cluster + 'in::'   + dsName + '::gunop::dbo::shot_incident::history';
	export gunop_dbo_shot_incident_Base		  						
			:= tools.mod_FilenamesBuild(gunop_dbo_shot_incident_lBaseTemplate, version);

	export geohash_lBaseTemplate_built				
			:= thor_cluster + 'base::' + dsName + '::geohash::built' + suffixBaseBuilt;
	export geohash_lBaseTemplate							
			:= thor_cluster + 'base::' + dsName+ '::geohash' + suffixBaseVersion;
	export geohash_lKeyTemplate	  						
			:= thor_cluster + 'base::' + dsName + '_keybuild' + '::geohash::@version@';
	export geohash_lInputTemplate 			
			:= thor_cluster + 'in::'   + dsName + '::geohash' ;
	export geohash_lInputHistTemplate 	
			:= thor_cluster + 'in::'   + dsName + '::geohash::history';
	export geohash_Base		  									
			:= tools.mod_FilenamesBuild(geohash_lBaseTemplate, version);
			
	export geohash_lpr_lBaseTemplate_built				
			:= thor_cluster + 'base::' + dsName + '::geohash::lpr::built' + suffixBaseBuilt;
	export geohash_lpr_lBaseTemplate							
			:= thor_cluster + 'base::' + dsName+ '::geohash::lpr' + suffixBaseVersion;
	export geohash_lpr_lKeyTemplate	  						
			:= thor_cluster + 'base::' + dsName + '_keybuild' + '::geohash::lpr::@version@';
	export geohash_lpr_lInputTemplate 			
			:= thor_cluster + 'in::'   + dsName + '::geohash::lpr' ;
	export geohash_lpr_lInputHistTemplate 	
			:= thor_cluster + 'in::'   + dsName + '::geohash::lpr::history';
	export geohash_lpr_Base		  									
			:= tools.mod_FilenamesBuild(geohash_lpr_lBaseTemplate, version);		

	export Notes_lBaseTemplate_built				
			:= thor_cluster + 'base::' + dsName + '::Notes::built' + suffixBaseBuilt;
	export Notes_lBaseTemplate							
			:= thor_cluster + 'base::' + dsName+ '::Notes' + suffixBaseVersion;
	export Notes_Base		  									
			:= tools.mod_FilenamesBuild(Notes_lBaseTemplate, version);

	export Images_lBaseTemplate_built				
			:= thor_cluster + 'base::' + dsName + '::Images::built' + suffixBaseBuilt;
	export Images_lBaseTemplate							
			:= thor_cluster + 'base::' + dsName+ '::Images' + suffixBaseVersion;
	export Images_Base		  									
			:= tools.mod_FilenamesBuild(Images_lBaseTemplate, version);
	
	export Classification_lBaseTemplate_built				
			:= thor_cluster + 'base::' + dsName + '::Classification::built';
	export Classification_lBaseTemplate							
			:= thor_cluster + 'base::' + dsName+ '::Classification::@version@';
	export Classification_base		  									
			:= tools.mod_FilenamesBuild(Classification_lBaseTemplate, version);
			
	export Orbit_Agencies_Template 
			:= thor_cluster + 'out::' + dsName + '::orbit_agencies';
	export Orbit_Datasets_Template 
			:= thor_cluster + 'out::' + dsName + '::orbit_datasets';
	
	export Files_Type_Template 
			:= thor_cluster + dsName + '::reference::files_type';	

	export Build_Version_Template 
			:= thor_cluster + dsName + '::reference::build_version';	

end;
