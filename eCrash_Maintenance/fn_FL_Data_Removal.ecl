IMPORT Data_Services, STD;

EXPORT  fn_FL_Data_Removal(STRING Pdate = (STRING) STD.Date.CurrentDate(TRUE)) := FUNCTION

  lay_fl_data_removal_stats := RECORD
	  STRING Desc;
	  UNSIGNED8 total_incidents;
	  UNSIGNED8 total_unq_incidents;
	  UNSIGNED8 total_fl_incidents;
	  UNSIGNED8 total_unq_fl_incidents;
	  UNSIGNED8 total_incidents_after_delete;
	  UNSIGNED8 total_fl_incidents_after_delete;
		UNSIGNED8 total_persons;
	  UNSIGNED8 total_fl_persons;
	  UNSIGNED8 total_persons_after_delete;
	  UNSIGNED8 total_fl_persons_after_delete;
		UNSIGNED8 total_vehicles;
	  UNSIGNED8 total_fl_vehicles;
	  UNSIGNED8 total_vehicles_after_delete;
	  UNSIGNED8 total_fl_vehicles_after_delete;
		UNSIGNED8 total_citations;
	  UNSIGNED8 total_fl_citations;
	  UNSIGNED8 total_citations_after_delete;
	  UNSIGNED8 total_fl_citations_after_delete;
	END;
		
  incident := DATASET(Data_Services.foreign_prod+'thor_data400::in::ecrash::incidnt_raw_new'
											,FLAccidents_Ecrash.Layout_Infiles.incident_new
											,CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"'),MAXLENGTH(60000)))(incident_id != 'Incident_ID');
												
	persn :=  DATASET(Data_Services.foreign_prod+'thor_data400::in::ecrash::persn_raw'
										,FLAccidents_Ecrash.Layout_Infiles.persn_new
										,CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"'),ESCAPE('\r'),MAXLENGTH(3000000)))(Person_ID != 'Person_ID');
										
	vehicl :=  DATASET(Data_Services.foreign_prod+'thor_data400::in::ecrash::vehicl_raw'
									   ,FLAccidents_Ecrash.Layout_Infiles.vehicl_new
										 ,CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"'),MAXLENGTH(50000)))(Vehicle_ID != 'Vehicle_ID');
													
	citation := DATASET(Data_Services.foreign_prod+'thor_data400::in::ecrash::citatn_raw'
										  ,FLAccidents_Ecrash.Layout_Infiles.citation
											,csv(terminator('\n'), separator(','),quote('"')))(Citation_ID != 'Citation_ID'); 												
													
	//Distribute DS
	d_incident := DISTRIBUTE(incident, HASH32(incident_id)):INDEPENDENT;
	d_persn := DISTRIBUTE(persn, HASH32(incident_id)):INDEPENDENT;
	d_vehicl := DISTRIBUTE(vehicl, HASH32(incident_id)):INDEPENDENT;
	d_citation := DISTRIBUTE(citation, HASH32(incident_id)):INDEPENDENT;
	
	//Unique Incidents
	unq_incident := DEDUP(SORT(d_incident(incident_id <> ''), incident_id, -(sent_to_hpcc_datetime), LOCAL), incident_id, LOCAL):INDEPENDENT;

	//FL Incidents									
	fl_incident := d_incident(loss_state_abbr = 'FL' AND source_id IN ['TM','TF'] 
	                         AND STD.Str.ToUpperCase(TRIM(vendor_code, ALL)) = 'CRASHLOGIC'):PERSIST('~THOR::BASE::PERSIST::ECRASH::FL_DATA_REMOVAL::INCIDENTS', EXPIRE(30), SINGLE);;
													
	//Unique FL incidents
	unq_fl_incident := DEDUP(SORT(fl_incident(incident_id <> ''), incident_id, -(sent_to_hpcc_datetime), LOCAL), incident_id, LOCAL):PERSIST('~THOR::BASE::PERSIST::ECRASH::FL_DATA_REMOVAL::UNIQUE_INCIDENTS', EXPIRE(30), SINGLE);
	
	//FL Persons counts	
  fl_persn := JOIN(d_persn, unq_fl_incident,
									 TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
									 TRANSFORM(LEFT), LOCAL);
									 
  //Person file deletion
  persn_after_fl_deletion := JOIN(d_persn, unq_fl_incident,
																  TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL), 
																  TRANSFORM(LEFT), LEFT ONLY, LOCAL):INDEPENDENT;

	OUTPUT(persn_after_fl_deletion,,'~thor_data400::in::ecrash::fl_data_removal_person_'+WORKUNIT,OVERWRITE,__COMPRESSED__,
		     CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"'),MAXLENGTH(60000)));
				 
	person_out :=  SEQUENTIAL(
														FileServices.StartSuperFileTransaction(),
														FileServices.ClearSuperFile('~thor_data400::in::ecrash::persn_raw', FALSE),
														FileServices.AddSuperFile('~thor_data400::in::ecrash::persn_raw','~thor_data400::in::ecrash::fl_data_removal_person_'+workunit),
														FileServices.FinishSuperFileTransaction()
													 );

	//FL Vehicles counts
	fl_vehicl := JOIN(d_vehicl, unq_fl_incident,
									  TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
									  TRANSFORM(LEFT), LOCAL);
										
  //Vehicle file deletion
	vehicl_after_fl_deletion := JOIN(d_vehicl, unq_fl_incident,
																	 TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
																	 TRANSFORM(LEFT), LEFT ONLY, LOCAL):INDEPENDENT;

	OUTPUT(vehicl_after_fl_deletion,,'~thor_data400::in::ecrash::fl_data_removal_vehicle_'+WORKUNIT,OVERWRITE,__COMPRESSED__,
		     CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"'),MAXLENGTH(60000)));
				 
	vehicle_out := SEQUENTIAL(
														FileServices.StartSuperFileTransaction(),
														FileServices.ClearSuperFile('~thor_data400::in::ecrash::vehicl_raw', FALSE),
														FileServices.AddSuperFile('~thor_data400::in::ecrash::vehicl_raw','~thor_data400::in::ecrash::fl_data_removal_vehicle_'+workunit),
														FileServices.FinishSuperFileTransaction()
													 );
													 
	//FL Citations counts
	fl_citation := JOIN(d_citation, unq_fl_incident,
									    TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
									    TRANSFORM(LEFT), LOCAL);
										
  //Citation file deletion
	citation_after_fl_deletion := JOIN(d_citation, unq_fl_incident,
																	 TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
																	 TRANSFORM(LEFT), LEFT ONLY, LOCAL):INDEPENDENT;

	OUTPUT(citation_after_fl_deletion,,'~thor_data400::in::ecrash::fl_data_removal_citation_'+WORKUNIT,OVERWRITE,__COMPRESSED__,
		     CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"'),MAXLENGTH(60000)));
				 
	citation_out := SEQUENTIAL(
														FileServices.StartSuperFileTransaction(),
														FileServices.ClearSuperFile('~thor_data400::in::ecrash::citatn_raw', FALSE),
														FileServices.AddSuperFile('~thor_data400::in::ecrash::citatn_raw','~thor_data400::in::ecrash::fl_data_removal_citation_'+workunit),
														FileServices.FinishSuperFileTransaction()
													 );

  //Incident file deletion
  incident_after_fl_deletion := d_incident(~(loss_state_abbr = 'FL' AND source_id IN ['TM','TF'] 
	                                           AND STD.Str.ToUpperCase(TRIM(vendor_code, ALL)) = 'CRASHLOGIC')):INDEPENDENT;

  OUTPUT(incident_after_fl_deletion,,'~thor_data400::in::ecrash::fl_data_removal_incident_'+WORKUNIT,OVERWRITE,__COMPRESSED__,
		     CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"'),MAXLENGTH(60000)));
	
											
	incident_out := SEQUENTIAL(
														 FileServices.StartSuperFileTransaction(),
														 FileServices.ClearSuperFile('~thor_data400::in::ecrash::incidnt_raw_new', FALSE),
														 FileServices.AddSuperFile('~thor_data400::in::ecrash::incidnt_raw_new','~thor_data400::in::ecrash::fl_data_removal_incident_'+workunit),
														 FileServices.FinishSuperFileTransaction()
													  );

	//Calculating stats
  ds_pre_delete := DATASET([{'PRE_DELETE', COUNT(incident), COUNT(unq_incident), COUNT(fl_incident), COUNT(unq_fl_incident), 0, 0, COUNT(persn), COUNT(fl_persn), 0, 0, COUNT(vehicl), COUNT(fl_vehicl), 0, 0, COUNT(citation), COUNT(fl_citation), 0, 0}], lay_fl_data_removal_stats);
	ds_post_delete := DATASET([{'POST_DELETE', ds_pre_delete[1].total_incidents, ds_pre_delete[1].total_unq_incidents, ds_pre_delete[1].total_fl_incidents, ds_pre_delete[1].total_unq_fl_incidents, COUNT(incident_after_fl_deletion), COUNT(fl_incident), ds_pre_delete[1].total_persons, ds_pre_delete[1].total_fl_persons, COUNT(persn_after_fl_deletion), COUNT(fl_persn), ds_pre_delete[1].total_vehicles, ds_pre_delete[1].total_fl_vehicles, COUNT(vehicl_after_fl_deletion), COUNT(fl_vehicl), ds_pre_delete[1].total_citations, ds_pre_delete[1].total_fl_citations, COUNT(citation_after_fl_deletion), COUNT(fl_citation)}], lay_fl_data_removal_stats);
  ds_fl_removal_stats := ds_pre_delete & ds_post_delete;
	
	delete_fl_data := SEQUENTIAL(
	                             OUTPUT(ds_pre_delete,,NAMED('PRE_DELETE')),
															 person_out,
															 vehicle_out,
															 citation_out,
															 incident_out,
															 OUTPUT(ds_post_delete,,NAMED('POST_DELETE')),
															 OUTPUT(ds_fl_removal_stats,,NAMED('FL_REMOVAL_STATS'))
															);
	 
	RETURN delete_fl_data;
END;
