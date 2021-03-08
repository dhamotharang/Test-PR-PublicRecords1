IMPORT Data_Services, STD, FLAccidents_Ecrash;

EXPORT  FL_Data_Removal_Missing_Ori(STRING Pdate = (STRING) STD.Date.CurrentDate(TRUE)) := FUNCTION

	temp_lay := RECORD
		STRING agency_ori;	
		STRING report_number;	
	END;
	
	ds_incident := FLAccidents_Ecrash.Infiles.Incident;
	ds_persn := FLAccidents_Ecrash.Infiles.Persn;
	ds_vehicl := FLAccidents_Ecrash.Infiles.vehicl;
	ds_citation := FLAccidents_Ecrash.Infiles.citation;
	
	ds_incident_filtered := ds_incident(source_id IN ['TM', 'TF'] AND (UNSIGNED) incident_id < 336470749);

	//Distribute DS
	d_incident := DISTRIBUTE(ds_incident, HASH32(incident_id));
	dds_incident_filtered := DISTRIBUTE(ds_incident_filtered, HASH32(state_report_number, ori_number));
	d_persn := DISTRIBUTE(ds_persn, HASH32(incident_id));
	d_vehicl := DISTRIBUTE(ds_vehicl, HASH32(incident_id));
	d_citation := DISTRIBUTE(ds_citation, HASH32(incident_id));

	//FL Incidents									
  fl_incident := DATASET(Data_Services.foreign_prod + 'thor::in::ecrash::incident_reportnumber_agencyorid', temp_lay,
	                       CSV(HEADING(1), SEPARATOR([',','\t']), TERMINATOR(['\n','\r\n','\n\r'])));
	//Unique FL incidents
	dfl_incident := DEDUP(SORT(DISTRIBUTE(fl_incident, HASH32(report_number, agency_ori)), report_number, agency_ori, LOCAL), report_number, agency_ori, LOCAL);
  
	//FL Incident 
  jfl_Incident := JOIN(dds_incident_filtered, dfl_incident,
									 TRIM(LEFT.state_report_number, ALL) = TRIM(RIGHT.report_number,ALL) AND
									 TRIM(LEFT.ori_number, ALL) = TRIM(RIGHT.agency_ori,ALL),
									 TRANSFORM(LEFT), LOCAL);
	 unq_fl_incident := DEDUP(SORT(DISTRIBUTE(jfl_Incident, HASH32(incident_id)), incident_id, LOCAL), incident_id, LOCAL);						 
   
	  //Incident file deletion
  Incident_after_fl_deletion := JOIN(d_incident, unq_fl_incident,
																  TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL), 
																  TRANSFORM(LEFT), LEFT ONLY, LOCAL);

  output_incident := OUTPUT(incident_after_fl_deletion,,Files.Incident_Raw_LF('data_removal'),OVERWRITE,__COMPRESSED__,
		                        CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"'),MAXLENGTH(60000)));
	
											
	incident_out := SEQUENTIAL(
														 output_incident,
														 FileServices.StartSuperFileTransaction(),
														 FileServices.ClearSuperFile(Files.Incident_Raw_SF, FALSE),
														 FileServices.AddSuperFile(Files.Incident_Raw_SF,
														                           Files.Incident_Raw_LF('data_removal')),
														 FileServices.FinishSuperFileTransaction()
													  );

									 
  //Person file deletion
  persn_after_fl_deletion := JOIN(d_persn, unq_fl_incident,
																  TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL), 
																  TRANSFORM(LEFT), LEFT ONLY, LOCAL);

	output_person := OUTPUT(persn_after_fl_deletion,,Files.Person_Raw_LF('data_removal'),OVERWRITE,__COMPRESSED__,
		                      CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"'),MAXLENGTH(60000)));
				 
	person_out :=  SEQUENTIAL(
														output_person, 
														FileServices.StartSuperFileTransaction(),
														FileServices.ClearSuperFile(Files.Person_Raw_SF, FALSE),
														FileServices.AddSuperFile(Files.Person_Raw_SF, 
														                          Files.Person_Raw_LF('data_removal')),
														FileServices.FinishSuperFileTransaction()
													 );
										
  //Vehicle file deletion
	vehicl_after_fl_deletion := JOIN(d_vehicl, unq_fl_incident,
																	 TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
																	 TRANSFORM(LEFT), LEFT ONLY, LOCAL);

	output_vehicle := OUTPUT(vehicl_after_fl_deletion,,Files.Vehicle_Raw_LF('data_removal'),OVERWRITE,__COMPRESSED__,
		                       CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"'),MAXLENGTH(60000)));
				 
	vehicle_out := SEQUENTIAL(
														output_vehicle, 
														FileServices.StartSuperFileTransaction(),
														FileServices.ClearSuperFile(Files.Vehicle_Raw_SF, FALSE),
														FileServices.AddSuperFile(Files.Vehicle_Raw_SF,
														                          Files.Vehicle_Raw_LF('data_removal')),
														FileServices.FinishSuperFileTransaction()
													 );

  //Citation file deletion
	citation_after_fl_deletion := JOIN(d_citation, unq_fl_incident,
																	 TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
																	 TRANSFORM(LEFT), LEFT ONLY, LOCAL);

	output_citation := OUTPUT(citation_after_fl_deletion,,Files.Citation_Raw_LF('data_removal'),OVERWRITE,__COMPRESSED__,
		                        CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"'),MAXLENGTH(60000)));
				 
	citation_out := SEQUENTIAL(
														output_citation,
														FileServices.StartSuperFileTransaction(),
														FileServices.ClearSuperFile(Files.Citation_Raw_SF, FALSE),
														FileServices.AddSuperFile(Files.Citation_Raw_SF,
														                          Files.Citation_Raw_LF('data_removal')),
														FileServices.FinishSuperFileTransaction()
													 );
	
	delete_fl_data := SEQUENTIAL(
	                             person_out,
															 vehicle_out,
															 citation_out,
															 incident_out
															);
	 
	RETURN delete_fl_data;
END;
