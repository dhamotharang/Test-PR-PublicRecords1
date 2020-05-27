IMPORT Data_Services, STD, FLAccidents_Ecrash;

EXPORT  fn_TN_Data_Removal(STRING Pdate = (STRING) STD.Date.CurrentDate(TRUE)) := FUNCTION

  lay_tn_data_removal_stats := RECORD
	  STRING Desc;
	  UNSIGNED8 total_incidents;
	  UNSIGNED8 total_unq_incidents;
	  UNSIGNED8 total_tn_incidents;
	  UNSIGNED8 total_unq_tn_incidents;
	  UNSIGNED8 total_incidents_after_delete;
	  UNSIGNED8 total_tn_incidents_after_delete;
		UNSIGNED8 total_persons;
	  UNSIGNED8 total_tn_persons;
	  UNSIGNED8 total_persons_after_delete;
	  UNSIGNED8 total_tn_persons_after_delete;
		UNSIGNED8 total_vehicles;
	  UNSIGNED8 total_tn_vehicles;
	  UNSIGNED8 total_vehicles_after_delete;
	  UNSIGNED8 total_tn_vehicles_after_delete;
	END;
		
  incident   := DATASET(Data_Services.foreign_prod+'thor_data400::in::ecrash::incidnt_raw_new'
												,FLAccidents_Ecrash.Layout_Infiles.incident_new
												,CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"'),MAXLENGTH(60000)))(incident_id != 'Incident_ID');
												
	persn :=  DATASET(Data_Services.foreign_prod+'thor_data400::in::ecrash::persn_raw'
										,FLAccidents_Ecrash.Layout_Infiles.persn_new
										,CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"'),ESCAPE('\r'),MAXLENGTH(3000000)))(Person_ID != 'Person_ID');
										
	vehicl :=  DATASET(Data_Services.foreign_prod+'thor_data400::in::ecrash::vehicl_raw'
													,FLAccidents_Ecrash.Layout_Infiles.vehicl_new
													,CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"'),MAXLENGTH(50000)))(Vehicle_ID != 'Vehicle_ID');
													
	//Distribute DS
	d_incident := DISTRIBUTE(incident, HASH32(incident_id)):INDEPENDENT;
	d_persn := DISTRIBUTE(persn, HASH32(incident_id)):INDEPENDENT;
	d_vehicl := DISTRIBUTE(vehicl, HASH32(incident_id)):INDEPENDENT;
	
	//Unique Incidents
	unq_incident := DEDUP(SORT(d_incident(incident_id <> ''), incident_id, -(sent_to_hpcc_datetime), LOCAL), incident_id, LOCAL):INDEPENDENT;
	
	/*[3:08 PM] Nagula, Sai (RIS-ATL)
    delete * from  incident
where loss_state_abbr = 'TN'
and work_type_id = 0
and source_id in ('TM','TF')
and agency_id   = 1513202
 and creation_date between '2017-10-23 00:00:00' and '2019-03-12 00:00:00';
​[3:08 PM] Nagula, Sai (RIS-ATL)
    delete * from  incident
where loss_state_abbr = 'TN'
and work_type_id = 0
and source_id in ('TM','TF')
and agency_id  <> 1513202
 and creation_date between '2016-08-11 00:00:00' and '2019-03-12 00:00:00';*/

	//TN Incidents									
	memphis_incident := d_incident(std.str.touppercase(TRIM(loss_state_abbr, ALL)) = 'TN' AND (creation_date BETWEEN '2017-10-23' AND '2019-03-11') AND 
	                               work_type_id = '0' AND std.str.touppercase(TRIM(source_id, ALL)) IN ['TM','TF'] AND agency_id = '1513202');
														
	not_memphis_incident := d_incident(std.str.touppercase(TRIM(loss_state_abbr, ALL)) = 'TN' AND (creation_date BETWEEN '2016-08-11' AND '2019-03-11') AND 
	                                   work_type_id = '0' AND std.str.touppercase(TRIM(source_id, ALL)) IN ['TM','TF'] AND agency_id <> '1513202');
	
	tn_incident := (memphis_incident + not_memphis_incident) :PERSIST('~THOR::BASE::PERSIST::ECRASH::TN_DATA_REMOVAL::INCIDENTS', EXPIRE(30), SINGLE);
	
	//Unique TN incidents
	unq_tn_incident := DEDUP(SORT(tn_incident(incident_id <> ''), incident_id, -(sent_to_hpcc_datetime), LOCAL), incident_id, LOCAL):PERSIST('~THOR::BASE::PERSIST::ECRASH::TN_DATA_REMOVAL::UNIQUE_INCIDENTS', EXPIRE(30), SINGLE);
	
	//TN Persons counts	
  tn_persn := JOIN(d_persn, unq_tn_incident,
									 TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
									 TRANSFORM(LEFT), LOCAL);
									 
  //Person file deletion
  persn_after_tn_deletion := JOIN(d_persn, unq_tn_incident,
																  TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL), 
																  TRANSFORM(LEFT), LEFT ONLY, LOCAL):INDEPENDENT;

	OUTPUT(persn_after_tn_deletion,,'~thor_data400::in::ecrash::tn_data_removal_person_'+WORKUNIT,OVERWRITE,__COMPRESSED__,
		     CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"'),MAXLENGTH(60000)));
				 
	person_out :=  SEQUENTIAL(
														FileServices.StartSuperFileTransaction(),
														FileServices.ClearSuperFile('~thor_data400::in::ecrash::persn_raw', FALSE),
														FileServices.AddSuperFile('~thor_data400::in::ecrash::persn_raw','~thor_data400::in::ecrash::tn_data_removal_person_'+workunit),
														FileServices.FinishSuperFileTransaction()
													 );

	//TN Vehicles counts
	tn_vehicl := JOIN(d_vehicl, unq_tn_incident,
									  TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
									  TRANSFORM(LEFT), LOCAL);
										
  //Vehicle file deletion
	vehicl_after_tn_deletion := JOIN(d_vehicl, unq_tn_incident,
																	 TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
																	 TRANSFORM(LEFT), LEFT ONLY, LOCAL):INDEPENDENT;

	OUTPUT(vehicl_after_tn_deletion,,'~thor_data400::in::ecrash::tn_data_removal_vehicle_'+WORKUNIT,OVERWRITE,__COMPRESSED__,
		     CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"'),MAXLENGTH(60000)));
				 
	vehicle_out := SEQUENTIAL(
														FileServices.StartSuperFileTransaction(),
														FileServices.ClearSuperFile('~thor_data400::in::ecrash::vehicl_raw', FALSE),
														FileServices.AddSuperFile('~thor_data400::in::ecrash::vehicl_raw','~thor_data400::in::ecrash::tn_data_removal_vehicle_'+workunit),
														FileServices.FinishSuperFileTransaction()
													 );

  //Incident file deletion
  incident_after_tn_deletion := d_incident(~((std.str.touppercase(TRIM(loss_state_abbr, ALL)) = 'TN' AND 
	                                            (creation_date BETWEEN '2017-10-23' AND '2019-03-11') AND 
																						  work_type_id = '0' AND 
																						  std.str.touppercase(TRIM(source_id, ALL)) IN ['TM','TF'] AND 
																						  agency_id = '1513202')
																             OR 
																					   (std.str.touppercase(TRIM(loss_state_abbr, ALL)) = 'TN' AND 
																						  (creation_date BETWEEN '2016-08-11' AND '2019-03-11') AND 
	                                             work_type_id = '0' AND 
																							 std.str.touppercase(TRIM(source_id, ALL)) IN ['TM','TF'] AND 
																							 agency_id <> '1513202'))):INDEPENDENT;

  OUTPUT(incident_after_tn_deletion,,'~thor_data400::in::ecrash::tn_data_removal_incident_'+WORKUNIT,OVERWRITE,__COMPRESSED__,
		     CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"'),MAXLENGTH(60000)));
	
											
	incident_out := SEQUENTIAL(
														 FileServices.StartSuperFileTransaction(),
														 FileServices.ClearSuperFile('~thor_data400::in::ecrash::incidnt_raw_new', FALSE),
														 FileServices.AddSuperFile('~thor_data400::in::ecrash::incidnt_raw_new','~thor_data400::in::ecrash::tn_data_removal_incident_'+workunit),
														 FileServices.FinishSuperFileTransaction()
													  );

	//Calculating stats
  ds_pre_delete := DATASET([{'PRE_DELETE', COUNT(incident), COUNT(unq_incident), COUNT(tn_incident), COUNT(unq_tn_incident), 0, 0, COUNT(persn), COUNT(tn_persn), 0, 0, COUNT(vehicl), COUNT(tn_vehicl), 0, 0}], lay_tn_data_removal_stats);
	ds_post_delete := DATASET([{'POST_DELETE', ds_pre_delete[1].total_incidents, ds_pre_delete[1].total_unq_incidents, ds_pre_delete[1].total_tn_incidents, ds_pre_delete[1].total_unq_tn_incidents, COUNT(incident_after_tn_deletion), COUNT(tn_incident), ds_pre_delete[1].total_persons, ds_pre_delete[1].total_tn_persons, COUNT(persn_after_tn_deletion), COUNT(tn_persn), ds_pre_delete[1].total_vehicles, ds_pre_delete[1].total_tn_vehicles, COUNT(vehicl_after_tn_deletion), COUNT(tn_vehicl)}], lay_tn_data_removal_stats);
  ds_tn_removal_stats := ds_pre_delete & ds_post_delete;
	
	delete_tn_data := SEQUENTIAL(
	                             OUTPUT(ds_pre_delete,,NAMED('PRE_DELETE')),
															 person_out,
															 vehicle_out,
															 incident_out,
															 OUTPUT(ds_post_delete,,NAMED('POST_DELETE')),
															 OUTPUT(ds_tn_removal_stats,,NAMED('TN_REMOVAL_STATS'))
															);
	 
	RETURN delete_tn_data;
END;
