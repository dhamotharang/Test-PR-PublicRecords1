IMPORT ut;
IMPORT Data_Services; 

EXPORT fn_fl_fiers_removal_agencyori := FUNCTION

 lay_fl_fiers_removal_stats := RECORD
	  STRING Desc;
	  UNSIGNED8 fiers_incidents;
		UNSIGNED8 total_fl_incidents;
	  UNSIGNED8 total_fiers_fl_incidents;
	  UNSIGNED8 total_incidents_after_delete;
		UNSIGNED8 total_fl_persons;
	  UNSIGNED8 total_fiers_fl_persons;
	  UNSIGNED8 total_persons_after_delete;
		UNSIGNED8 total_fl_vehicles;
	  UNSIGNED8 total_fiers_fl_vehicles;
	  UNSIGNED8 total_vehicles_after_delete;
	END;

 //Incident

	ds_incident_fiers := DATASET(Data_Services.foreign_dataland+'thor_data400::in::ecrash::incident_raw::flremoval'
															 ,FLAccidents_Ecrash.Layout_Infiles.incident_new
															 ,csv(terminator('\n'), separator('|'),quote('"'),maxlength(10000)))(Incident_ID != 'Incident_ID');                    

  ds_incident := DATASET(Data_Services.foreign_prod+'thor_data400::in::ecrash::incidnt_raw_new'
															,FLAccidents_Ecrash.Layout_Infiles.incident_new
															,csv(terminator('\n'), separator(','),quote('"'),maxlength(60000)))(Incident_ID != 'Incident_ID');                  

	d_incident_fiers := DISTRIBUTE(ds_incident_fiers, HASH32(incident_id));
	d_incident := DISTRIBUTE(ds_incident, HASH32(incident_id));
	
  fl_fiers_incident := JOIN(d_incident, d_incident_fiers,
														TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
														TRANSFORM(LEFT), LOCAL);
									 
  //Incident fiers fl data deletion
  fl_fiers_incident_deletion := JOIN(d_incident, d_incident_fiers,
																		 TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
																		 TRANSFORM(LEFT), LEFT ONLY, LOCAL):INDEPENDENT;
					
	 OUTPUT(fl_fiers_incident_deletion,,'~thor_data400::in::ecrash::fl_fiers_data_removal_incident_'+WORKUNIT,overwrite, __compressed__,
					csv(terminator('\n'), separator(','),quote('"'),maxlength(60000)));

	inc_all :=  SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
		FileServices.ClearSuperFile('~thor_data400::in::ecrash::incidnt_raw_new', FALSE),
		FileServices.AddSuperFile('~thor_data400::in::ecrash::incidnt_raw_new','~thor_data400::in::ecrash::fl_fiers_data_removal_incident_'+WORKUNIT),
		FileServices.FinishSuperFileTransaction()
	);
	
	
  //Person
  ds_person := DATASET(Data_Services.foreign_prod+'thor_data400::in::ecrash::persn_raw'
											,FLAccidents_Ecrash.Layout_Infiles.persn_new
											,csv(terminator('\n'), separator(','),quote('"'),escape('\r'),maxlength(3000000)))(Person_ID != 'Person_ID');

	d_person := DISTRIBUTE(ds_person, HASH32(incident_id));
	
  fl_fiers_person := JOIN(d_person, d_incident_fiers,
													TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
													TRANSFORM(LEFT), LOCAL);
									 
  //Person fiers fl data deletion
  fl_fiers_person_deletion := JOIN(d_person, d_incident_fiers,
																	 TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
																	 TRANSFORM(LEFT), LEFT ONLY, LOCAL);
																		 
	 OUTPUT(fl_fiers_person_deletion,,'~thor_data400::in::ecrash::fl_fiers_data_removal_person_'+WORKUNIT,overwrite, __compressed__,
					csv(terminator('\n'), separator(','),quote('"'),maxlength(60000)));

	per_all :=  SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
		FileServices.ClearSuperFile('~thor_data400::in::ecrash::persn_raw', FALSE),
		FileServices.AddSuperFile('~thor_data400::in::ecrash::persn_raw','~thor_data400::in::ecrash::fl_fiers_data_removal_person_'+WORKUNIT),
		FileServices.FinishSuperFileTransaction()
	);
	
	//Vehicle

	ds_vehicle := DATASET(Data_Services.foreign_prod+'thor_data400::in::ecrash::vehicl_raw'
											  ,FLAccidents_Ecrash.Layout_Infiles.vehicl_new
												,csv(terminator('\n'), separator(','),quote('"'),maxlength(50000)))(Vehicle_ID != 'Vehicle_ID');

	d_vehicle := DISTRIBUTE(ds_vehicle, HASH32(incident_id));
	
  fl_fiers_vehicle := JOIN(d_vehicle, d_incident_fiers,
													 TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
													 TRANSFORM(LEFT), LOCAL);
									 
  //Vehicle fiers fl data deletion
  fl_fiers_vehicle_deletion := JOIN(d_vehicle, d_incident_fiers,
													          TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
													          TRANSFORM(LEFT), LEFT ONLY, LOCAL);
					
	 OUTPUT(fl_fiers_vehicle_deletion,,'~thor_data400::in::ecrash::fl_fiers_data_removal_vehicle_'+WORKUNIT,overwrite, __compressed__,
					csv(terminator('\n'), separator(','),quote('"'),maxlength(60000)));

	veh_all :=  SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
		FileServices.ClearSuperFile('~thor_data400::in::ecrash::vehicl_raw', FALSE),
		FileServices.AddSuperFile('~thor_data400::in::ecrash::vehicl_raw','~thor_data400::in::ecrash::fl_fiers_data_removal_vehicle_'+WORKUNIT),
		FileServices.FinishSuperFileTransaction()
	);
		
	//Calculating stats
  ds_pre_delete := DATASET([{'PRE_DELETE', COUNT(ds_incident_fiers), COUNT(ds_incident), COUNT(fl_fiers_incident), 0, COUNT(ds_person), COUNT(fl_fiers_person), 0, COUNT(ds_vehicle), COUNT(fl_fiers_vehicle), 0}], lay_fl_fiers_removal_stats);
	ds_post_delete := DATASET([{'POST_DELETE', ds_pre_delete[1].fiers_incidents, ds_pre_delete[1].total_fl_incidents, ds_pre_delete[1].total_fiers_fl_incidents, COUNT(fl_fiers_incident_deletion), ds_pre_delete[1].total_fl_persons, ds_pre_delete[1].total_fiers_fl_persons, COUNT(fl_fiers_person_deletion), ds_pre_delete[1].total_fl_vehicles, ds_pre_delete[1].total_fiers_fl_vehicles, COUNT(fl_fiers_vehicle_deletion)}], lay_fl_fiers_removal_stats);
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