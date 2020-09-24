IMPORT Data_Services, STD, FLAccidents_Ecrash;

EXPORT  fn_ecrash_deletion_juvinile_cruorderid():= FUNCTION

  lay_jv_data_removal_stats := RECORD
	  STRING Desc;
	  UNSIGNED8 total_incidents;
	  UNSIGNED8 total_unq_incidents;
	  UNSIGNED8 total_jv_incidents;
	  UNSIGNED8 total_unq_jv_incidents;
	  UNSIGNED8 total_incidents_after_delete;
	  UNSIGNED8 total_jv_incidents_after_delete;
		UNSIGNED8 total_persons;
	  UNSIGNED8 total_jv_persons;
	  UNSIGNED8 total_persons_after_delete;
	  UNSIGNED8 total_jv_persons_after_delete;
		UNSIGNED8 total_vehicles;
	  UNSIGNED8 total_jv_vehicles;
	  UNSIGNED8 total_vehicles_after_delete;
	  UNSIGNED8 total_jv_vehicles_after_delete;
		UNSIGNED8 total_citations;
	  UNSIGNED8 total_jv_citations;
	  UNSIGNED8 total_citations_after_delete;
	  UNSIGNED8 total_jv_citations_after_delete;
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

	//jv Incidents									
	jv_incident := d_incident(cru_order_id IN ['42756444', '66060901', '111035126']);
													
	//Unique jv incidents
	unq_jv_incident := DEDUP(SORT(jv_incident(incident_id <> ''), incident_id, -(sent_to_hpcc_datetime), LOCAL), incident_id, LOCAL);
	
	//jv Persons counts	
  jv_persn := JOIN(d_persn, unq_jv_incident,
									 TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
									 TRANSFORM(LEFT), LOCAL);
									 
  //Person file deletion
  persn_after_jv_deletion := JOIN(d_persn, unq_jv_incident,
																  TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL), 
																  TRANSFORM(LEFT), LEFT ONLY, LOCAL):INDEPENDENT;

	out_per := OUTPUT(persn_after_jv_deletion,,'~thor_data400::in::ecrash::jv_data_removal_person_'+WORKUNIT,OVERWRITE,__COMPRESSED__,
		                CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"'),MAXLENGTH(60000)));
				 
	person_out :=  SEQUENTIAL(
														out_per, 
														FileServices.StartSuperFileTransaction(),
														FileServices.ClearSuperFile('~thor_data400::in::ecrash::persn_raw', FALSE),
														FileServices.AddSuperFile('~thor_data400::in::ecrash::persn_raw','~thor_data400::in::ecrash::jv_data_removal_person_'+workunit),
														FileServices.FinishSuperFileTransaction()
													 );

	//jv Vehicles counts
	jv_vehicl := JOIN(d_vehicl, unq_jv_incident,
									  TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
									  TRANSFORM(LEFT), LOCAL);

  //Vehicle file deletion
	vehicl_after_jv_deletion := JOIN(d_vehicl, unq_jv_incident,
																	 TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
																	 TRANSFORM(LEFT), LEFT ONLY, LOCAL):INDEPENDENT;

	veh_out := OUTPUT(vehicl_after_jv_deletion,,'~thor_data400::in::ecrash::jv_data_removal_vehicle_'+WORKUNIT,OVERWRITE,__COMPRESSED__,
		                CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"'),MAXLENGTH(60000)));
				 
	vehicle_out := SEQUENTIAL(
														veh_out, 
														FileServices.StartSuperFileTransaction(),
														FileServices.ClearSuperFile('~thor_data400::in::ecrash::vehicl_raw', FALSE),
														FileServices.AddSuperFile('~thor_data400::in::ecrash::vehicl_raw','~thor_data400::in::ecrash::jv_data_removal_vehicle_'+workunit),
														FileServices.FinishSuperFileTransaction()
													 );
													 
	//jv Citations counts
	jv_citation := JOIN(d_citation, unq_jv_incident,
									    TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
									    TRANSFORM(LEFT), LOCAL);
										
  //Citation file deletion
	citation_after_jv_deletion := JOIN(d_citation, unq_jv_incident,
																	 TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
																	 TRANSFORM(LEFT), LEFT ONLY, LOCAL):INDEPENDENT;

	cit_out := OUTPUT(citation_after_jv_deletion,,'~thor_data400::in::ecrash::jv_data_removal_citation_'+WORKUNIT,OVERWRITE,__COMPRESSED__,
		                CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"'),MAXLENGTH(60000)));
				 
	citation_out := SEQUENTIAL(
														cit_out,
														FileServices.StartSuperFileTransaction(),
														FileServices.ClearSuperFile('~thor_data400::in::ecrash::citatn_raw', FALSE),
														FileServices.AddSuperFile('~thor_data400::in::ecrash::citatn_raw','~thor_data400::in::ecrash::jv_data_removal_citation_'+workunit),
														FileServices.FinishSuperFileTransaction()
													 );

  //Incident file deletion
  incident_after_jv_deletion := d_incident(~(cru_order_id IN ['42756444', '66060901', '111035126'])):INDEPENDENT;

  inc_out := OUTPUT(incident_after_jv_deletion,,'~thor_data400::in::ecrash::jv_data_removal_incident_'+WORKUNIT,OVERWRITE,__COMPRESSED__,
		                CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"'),MAXLENGTH(60000)));
	
											
	incident_out := SEQUENTIAL(
														 inc_out,
														 FileServices.StartSuperFileTransaction(),
														 FileServices.ClearSuperFile('~thor_data400::in::ecrash::incidnt_raw_new', FALSE),
														 FileServices.AddSuperFile('~thor_data400::in::ecrash::incidnt_raw_new','~thor_data400::in::ecrash::jv_data_removal_incident_'+workunit),
														 FileServices.FinishSuperFileTransaction()
													  );

	//Calculating stats
  ds_pre_delete := DATASET([{'PRE_DELETE', COUNT(incident), COUNT(unq_incident), COUNT(jv_incident), COUNT(unq_jv_incident), 0, 0, COUNT(persn), COUNT(jv_persn), 0, 0, COUNT(vehicl), COUNT(jv_vehicl), 0, 0, COUNT(citation), COUNT(jv_citation), 0, 0}], lay_jv_data_removal_stats);
	ds_post_delete := DATASET([{'POST_DELETE', ds_pre_delete[1].total_incidents, ds_pre_delete[1].total_jv_incidents, ds_pre_delete[1].total_unq_jv_incidents, ds_pre_delete[1].total_unq_jv_incidents, COUNT(incident_after_jv_deletion), COUNT(jv_incident), ds_pre_delete[1].total_persons, ds_pre_delete[1].total_jv_persons, COUNT(persn_after_jv_deletion), COUNT(jv_persn), ds_pre_delete[1].total_vehicles, ds_pre_delete[1].total_jv_vehicles, COUNT(vehicl_after_jv_deletion), COUNT(jv_vehicl), ds_pre_delete[1].total_citations, ds_pre_delete[1].total_jv_citations, COUNT(citation_after_jv_deletion), COUNT(jv_citation)}], lay_jv_data_removal_stats);
  ds_jv_removal_stats := ds_pre_delete & ds_post_delete;
	
	delete_jv_data := SEQUENTIAL(
	                             OUTPUT(ds_pre_delete,,NAMED('PRE_DELETE')),
															 person_out,
															 citation_out,
															 vehicle_out,
															 incident_out,
															 OUTPUT(ds_post_delete,,NAMED('POST_DELETE')),
															 OUTPUT(ds_jv_removal_stats,,NAMED('jv_REMOVAL_STATS'))
															);
	 
	RETURN delete_jv_data;
END;
