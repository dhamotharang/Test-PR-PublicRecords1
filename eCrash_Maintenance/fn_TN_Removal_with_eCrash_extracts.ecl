IMPORT ut, Data_Services, FLAccidents_Ecrash; 

EXPORT fn_TN_Removal_with_eCrash_extracts := FUNCTION

 lay_tn_removal_stats := RECORD
	  STRING Desc;
	  UNSIGNED8 total_incidents;
		UNSIGNED8 total_tn_extract_incidents;
		UNSIGNED8 total_tn_incidents;
	  UNSIGNED8 total_incidents_after_delete;
	  UNSIGNED8 total_tn_incidents_after_delete;
		UNSIGNED8 total_persons;
		UNSIGNED8 total_tn_extract_persons;
		UNSIGNED8 total_tn_persons;
	  UNSIGNED8 total_persons_after_delete;
	  UNSIGNED8 total_tn_persons_after_delete;
		UNSIGNED8 total_vehicles;
		UNSIGNED8 total_tn_extract_vehicles;
		UNSIGNED8 total_tn_vehicles;
	  UNSIGNED8 total_vehicles_after_delete;
	  UNSIGNED8 total_tn_vehicles_after_delete;
	END;
	
  //Incident
	lay_tn_incident := RECORD
                      STRING incident_id;
			               END;
  ds_incident_TN := DATASET(Data_Services.foreign_prod+'thor_data400::in::ecrash::incident_20201103'
									           ,lay_tn_incident
									           ,CSV(SEPARATOR([','])
                             ,TERMINATOR(['\n','\r\n','\n\r'])))(Incident_ID != 'Incident_ID');
  d_incident_TN := DEDUP(SORT(DISTRIBUTE(ds_incident_TN, HASH32(incident_id)), 
	                               incident_id, LOCAL), 
													  incident_id, LOCAL):INDEPENDENT;
														 
  ds_incident := FLAccidents_Ecrash.Infiles.incident;
	d_incident := DISTRIBUTE(ds_incident, HASH32(incident_id)):INDEPENDENT;
	
  tn_incident := JOIN(d_incident, d_incident_TN,
														TRIM(LEFT.incident_id, LEFT, RIGHT) = TRIM(RIGHT.incident_id, LEFT, RIGHT),
														TRANSFORM(LEFT), LOCAL);
									 
  //Incident fiers TN data deletion
  tn_incident_deletion := JOIN(d_incident, d_incident_TN,
																		 TRIM(LEFT.incident_id, LEFT, RIGHT) = TRIM(RIGHT.incident_id, LEFT, RIGHT),
																		 TRANSFORM(LEFT), LEFT ONLY, LOCAL):INDEPENDENT;
					
	out_inc := OUTPUT(tn_incident_deletion,,'~thor_data400::in::ecrash::tn_data_removal_incident_'+WORKUNIT,overwrite, __compressed__,
					          CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"'), MAXLENGTH(60000)));

	inc_all :=  SEQUENTIAL(
												 out_inc, 
												 FileServices.StartSuperFileTransaction(),
												 FileServices.ClearSuperFile('~thor_data400::in::ecrash::incidnt_raw_new', FALSE),
												 FileServices.AddSuperFile('~thor_data400::in::ecrash::incidnt_raw_new','~thor_data400::in::ecrash::tn_data_removal_incident_'+WORKUNIT),
												 FileServices.FinishSuperFileTransaction()
												);

  //Person
	lay_tn_person := RECORD
                      STRING person_id;
			               END;
  ds_person_TN :=	DATASET(Data_Services.foreign_prod+'thor_data400::in::ecrash::person_20201103'
							           ,lay_tn_person
							           ,CSV(SEPARATOR([',']),
                     TERMINATOR(['\n','\r\n','\n\r'])))(Person_ID != 'Person_ID');	
	d_person_TN := DEDUP(SORT(DISTRIBUTE(ds_person_TN, HASH32(person_id)), 
	                             person_id, LOCAL), 
													person_id, LOCAL):INDEPENDENT;
										 
  ds_person := FLAccidents_Ecrash.Infiles.Persn;
  d_person := DISTRIBUTE(ds_person, HASH32(person_id)):INDEPENDENT;
	
  tn_person := JOIN(d_person, d_person_TN,
												  TRIM(LEFT.person_id, LEFT, RIGHT) = TRIM(RIGHT.person_id, LEFT, RIGHT),
													TRANSFORM(LEFT), LOCAL);
									 
  //Person fiers fl data deletion
  tn_person_deletion := JOIN(d_person, d_person_TN,
																	 TRIM(LEFT.person_id, LEFT, RIGHT) = TRIM(RIGHT.person_id, LEFT, RIGHT),
																	 TRANSFORM(LEFT), LEFT ONLY, LOCAL):INDEPENDENT;
																		 
	out_per := OUTPUT(tn_person_deletion,,'~thor_data400::in::ecrash::tn_data_removal_person_'+WORKUNIT,OVERWRITE, __COMPRESSED__,
					          CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"'), MAXLENGTH(3000000)));

	per_all :=  SEQUENTIAL(
												 out_per,
												 FileServices.StartSuperFileTransaction(),
												 FileServices.ClearSuperFile('~thor_data400::in::ecrash::persn_raw', FALSE),
												 FileServices.AddSuperFile('~thor_data400::in::ecrash::persn_raw','~thor_data400::in::ecrash::tn_data_removal_person_'+WORKUNIT),
												 FileServices.FinishSuperFileTransaction()
												);
	
	//Vehicle
	lay_tn_vehicle := RECORD
        STRING col;
        STRING vehicle_id;
			END;
  ds_vehicle_TN := DATASET(Data_Services.foreign_prod+'thor_data400::in::ecrash::vehicle_20201103'
							            ,lay_tn_vehicle
							            ,CSV(SEPARATOR([','])
                          ,TERMINATOR(['\n','\r\n','\n\r'])))(Vehicle_ID != 'Vehicle_ID');
  d_vehicle_TN := DEDUP(SORT(DISTRIBUTE(ds_vehicle_TN, HASH32(vehicle_id)), 
	                              vehicle_id, LOCAL), 
														vehicle_id, LOCAL):INDEPENDENT;

  ds_vehicle := FLAccidents_Ecrash.Infiles.Vehicl;
	d_vehicle := DISTRIBUTE(ds_vehicle, HASH32(vehicle_id)):INDEPENDENT;
	
  tn_vehicle := JOIN(d_vehicle, d_vehicle_TN,
										 TRIM(LEFT.vehicle_id, LEFT, RIGHT) = TRIM(RIGHT.vehicle_id, LEFT, RIGHT),
										 TRANSFORM(LEFT), LOCAL);
									 
  //Vehicle fiers fl data deletion
  tn_vehicle_deletion := JOIN(d_vehicle, d_vehicle_TN,
													    TRIM(LEFT.vehicle_id, LEFT, RIGHT) = TRIM(RIGHT.vehicle_id, LEFT, RIGHT),
													    TRANSFORM(LEFT), LEFT ONLY, LOCAL):INDEPENDENT;
					
	 out_veh := OUTPUT(tn_vehicle_deletion,,'~thor_data400::in::ecrash::tn_data_removal_vehicle_'+WORKUNIT, OVERWRITE, __COMPRESSED__,
					           CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"'), MAXLENGTH(50000)));

	 veh_all :=  SEQUENTIAL(
													 out_veh,
													 FileServices.StartSuperFileTransaction(),
													 FileServices.ClearSuperFile('~thor_data400::in::ecrash::vehicl_raw', FALSE),
													 FileServices.AddSuperFile('~thor_data400::in::ecrash::vehicl_raw','~thor_data400::in::ecrash::tn_data_removal_vehicle_'+WORKUNIT),
													 FileServices.FinishSuperFileTransaction()
												  );
		
	//Calculating stats
  ds_pre_delete := DATASET([{'PRE_DELETE', COUNT(d_incident), COUNT(d_incident_TN), COUNT(tn_incident), 0, 0, COUNT(d_person), COUNT(d_person_TN), COUNT(tn_person), 0, 0, COUNT(d_vehicle), COUNT(d_vehicle_TN), COUNT(tn_vehicle), 0, 0}], lay_tn_removal_stats);
  ds_post_delete := DATASET([{'POST_DELETE', ds_pre_delete[1].total_incidents, ds_pre_delete[1].total_tn_extract_incidents, ds_pre_delete[1].total_tn_incidents, COUNT(tn_incident_deletion), COUNT(tn_incident), ds_pre_delete[1].total_persons, ds_pre_delete[1].total_tn_extract_persons, ds_pre_delete[1].total_tn_persons, COUNT(tn_person_deletion), COUNT(tn_person), ds_pre_delete[1].total_vehicles, ds_pre_delete[1].total_tn_extract_vehicles, ds_pre_delete[1].total_tn_vehicles, COUNT(tn_vehicle_deletion), COUNT(tn_vehicle)}], lay_tn_removal_stats);
  ds_fl_removal_stats := ds_pre_delete & ds_post_delete;
	
	delete_fl_fiers_data := SEQUENTIAL(
																		 OUTPUT(ds_pre_delete,,NAMED('PRE_DELETE')),
																		 inc_all,
																		 per_all,
																		 veh_all,
																		 OUTPUT(ds_post_delete,,NAMED('POST_DELETE')),
																		 OUTPUT(ds_fl_removal_stats,,NAMED('FL_FIERS_REMOVAL_STATS'))
																		);
	 
	RETURN delete_fl_fiers_data;

END;