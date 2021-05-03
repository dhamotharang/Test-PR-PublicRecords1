IMPORT ut, Data_Services, FLAccidents_Ecrash; 

EXPORT fn_FL_Fiers_Removal_HP_Desk_Sales := FUNCTION

 lay_fl_fiers_removal_stats := RECORD
	  STRING Desc;
	  UNSIGNED8 fiers_incidents;
		UNSIGNED8 total_incidents;
		UNSIGNED8 total_fl_incidents;
	  UNSIGNED8 total_incidents_after_delete;
		UNSIGNED8 total_persons;
		UNSIGNED8 total_fl_persons;
	  UNSIGNED8 total_persons_after_delete;
		UNSIGNED8 total_vehicles;
		UNSIGNED8 total_fl_vehicles;
	  UNSIGNED8 total_vehicles_after_delete;
		UNSIGNED8 total_citations;
		UNSIGNED8 total_fl_citations;
	  UNSIGNED8 total_citations_after_delete;
		UNSIGNED8 total_commercials;
		UNSIGNED8 total_fl_commercials;
	  UNSIGNED8 total_commercials_after_delete;
		UNSIGNED8 total_propertydamages;
		UNSIGNED8 total_fl_propertydamages;
	  UNSIGNED8 total_propertydamages_after_delete;		
		// UNSIGNED8 total_documents;
		// UNSIGNED8 total_fl_documents;
	  // UNSIGNED8 total_documents_after_delete;
	END;
	
  incident := FLAccidents_Ecrash.Infiles.Incident;
	persn := FLAccidents_Ecrash.Infiles.Persn;
	vehicl := FLAccidents_Ecrash.Infiles.Vehicl;
	citation := FLAccidents_Ecrash.Infiles.Citation;
	Property_damage := FLAccidents_Ecrash.Infiles.Property_Damage;
	commercl := FLAccidents_Ecrash.Infiles.Commercl;
	// document := FLAccidents_Ecrash.Infiles.Document;
	
  //Distribute DS
	d_incident := DISTRIBUTE(incident, HASH32(incident_id)):INDEPENDENT;
	d_persn := DISTRIBUTE(persn, HASH32(incident_id)):INDEPENDENT;
	d_vehicl := DISTRIBUTE(vehicl, HASH32(incident_id)):INDEPENDENT;
	d_citation := DISTRIBUTE(citation, HASH32(incident_id)):INDEPENDENT;
	d_property := DISTRIBUTE(Property_damage, HASH32(incident_id)):INDEPENDENT;
	d_commercial := DISTRIBUTE(commercl, HASH32(vehicle_id)):INDEPENDENT;
	// d_document := DISTRIBUTE(document, HASH32(incident_id)):INDEPENDENT;
	
	//FL HP Desk sales data
	lay := record
        string incident_id;
			 end;
  ds_incident_fl :=	DATASET(Data_Services.foreign_prod+'thor_data400::in::ecrash::incident_raw::flremoval',
									          lay,
									          CSV(HEADING(1),
                            SEPARATOR([',','\t']),
                            TERMINATOR(['\n','\r\n','\n\r'])));
                   
  dds_incident_fl := DEDUP(SORT(DISTRIBUTE(ds_incident_fl(TRIM(incident_id, LEFT, RIGHT) <> ''), HASH32(incident_id)), incident_id, LOCAL), incident_id, LOCAL);
  
	//FL Persons counts	
  fl_persn := JOIN(d_persn, dds_incident_fl,
									 TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
									 TRANSFORM(LEFT), LOCAL);
									 
  //Person file deletion
  persn_after_fl_deletion := JOIN(d_persn, dds_incident_fl,
																  TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL), 
																  TRANSFORM(LEFT), LEFT ONLY, LOCAL):INDEPENDENT;

	out_per := OUTPUT(persn_after_fl_deletion,,Files.Person_Raw_LF('fl_data_removal'),OVERWRITE,__COMPRESSED__,
		                CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"'),MAXLENGTH(60000)));
				 
	person_out :=  SEQUENTIAL(
														out_per, 
														FileServices.StartSuperFileTransaction(),
														FileServices.ClearSuperFile(Files.Person_Raw_SF, FALSE),
														FileServices.AddSuperFile(Files.Person_Raw_SF, 
														                          Files.Person_Raw_LF('fl_data_removal')),
														FileServices.FinishSuperFileTransaction()
													 );
													 
	//FL Vehicles counts
	fl_vehicl := JOIN(d_vehicl, dds_incident_fl,
									  TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
									  TRANSFORM(LEFT), LOCAL):INDEPENDENT;

  //Vehicle file deletion
	vehicl_after_fl_deletion := JOIN(d_vehicl, dds_incident_fl,
																	 TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
																	 TRANSFORM(LEFT), LEFT ONLY, LOCAL):INDEPENDENT;

	veh_out := OUTPUT(vehicl_after_fl_deletion,,Files.Vehicle_Raw_LF('fl_data_removal'),OVERWRITE,__COMPRESSED__,
		                CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"'),MAXLENGTH(60000)));
				 
	vehicle_out := SEQUENTIAL(
														veh_out, 
														FileServices.StartSuperFileTransaction(),
														FileServices.ClearSuperFile(Files.Vehicle_Raw_SF, FALSE),
														FileServices.AddSuperFile(Files.Vehicle_Raw_SF,
														                          Files.Vehicle_Raw_LF('fl_data_removal')),
														FileServices.FinishSuperFileTransaction()
													 );
													 
	//FL Citations counts
	fl_citation := JOIN(d_citation, dds_incident_fl,
									    TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
									    TRANSFORM(LEFT), LOCAL);
										
  //Citation file deletion
	citation_after_fl_deletion := JOIN(d_citation, dds_incident_fl,
																	 TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
																	 TRANSFORM(LEFT), LEFT ONLY, LOCAL):INDEPENDENT;

	cit_out := OUTPUT(citation_after_fl_deletion,,Files.Citation_Raw_LF('fl_data_removal'),OVERWRITE,__COMPRESSED__,
		                CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"'),MAXLENGTH(60000)));
				 
	citation_out := SEQUENTIAL(
														cit_out,
														FileServices.StartSuperFileTransaction(),
														FileServices.ClearSuperFile(Files.Citation_Raw_SF, FALSE),
														FileServices.AddSuperFile(Files.Citation_Raw_SF,
														                          Files.Citation_Raw_LF('fl_data_removal')),
														FileServices.FinishSuperFileTransaction()
													 );
													 
	//FL property counts
	fl_property := JOIN(d_property, dds_incident_fl,
									    TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
									    TRANSFORM(LEFT), LOCAL);
										
  //Property damage file deletion
	property_after_fl_deletion := JOIN(d_property, dds_incident_fl,
																	   TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
																	   TRANSFORM(LEFT), LEFT ONLY, LOCAL):INDEPENDENT;

	pro_out := OUTPUT(property_after_fl_deletion,,Files.PropertyDamage_Raw_LF('fl_data_removal'),OVERWRITE,__COMPRESSED__,
		                CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"'),MAXLENGTH(50000)));
				 
	property_out := SEQUENTIAL(
														pro_out,
														FileServices.StartSuperFileTransaction(),
														FileServices.ClearSuperFile(Files.PropertyDamage_Raw_SF, FALSE),
														FileServices.AddSuperFile(Files.PropertyDamage_Raw_SF,
														                          Files.PropertyDamage_Raw_LF('fl_data_removal')),
														FileServices.FinishSuperFileTransaction()
													 );

	//Unique Vehicle_id
	d_unq_fl_vehicle := DEDUP(SORT(DISTRIBUTE(fl_vehicl(TRIM(vehicle_id, LEFT, RIGHT) <> ''), HASH32(vehicle_id)), vehicle_id, LOCAL), vehicle_id, LOCAL);
  
	//FL commercial counts
	fl_commercial := JOIN(d_commercial, d_unq_fl_vehicle,
									    TRIM(LEFT.vehicle_id, ALL) = TRIM(RIGHT.vehicle_id,ALL),
									    TRANSFORM(LEFT), LOCAL);
										
  //Commercial file deletion
	commercial_after_fl_deletion := JOIN(d_commercial, d_unq_fl_vehicle,
																	   TRIM(LEFT.vehicle_id, ALL) = TRIM(RIGHT.vehicle_id,ALL),
																	   TRANSFORM(LEFT), LEFT ONLY, LOCAL):INDEPENDENT;

	com_out := OUTPUT(commercial_after_fl_deletion,,Files.Commercial_Raw_LF('fl_data_removal'),OVERWRITE,__COMPRESSED__,
		                CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"'),MAXLENGTH(50000)));
				 
	commercial_out := SEQUENTIAL(
	                              com_out,
																FileServices.StartSuperFileTransaction(),
																FileServices.ClearSuperFile(Files.Commercial_Raw_SF, FALSE),
																FileServices.AddSuperFile(Files.Commercial_Raw_SF,
																                          Files.Commercial_Raw_LF('fl_data_removal')),
																FileServices.FinishSuperFileTransaction()
															 );
													 
	//FL document counts
	// fl_document := JOIN(d_document, dds_incident_fl,
									    // TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
									    // TRANSFORM(LEFT), LOCAL);
										
  //Document file deletion
	// document_after_fl_deletion := JOIN(d_document, dds_incident_fl,
																	   // TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
																	   // TRANSFORM(LEFT), LEFT ONLY, LOCAL):INDEPENDENT;

	// doc_out := OUTPUT(document_after_fl_deletion,,Files.Document_Raw_LF('fl_data_removal'),OVERWRITE,__COMPRESSED__,
		                // CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"'),MAXLENGTH(50000)));
				 
	// document_out := SEQUENTIAL(
														// doc_out,
														// FileServices.StartSuperFileTransaction(),
														// FileServices.ClearSuperFile(Files.Document_Raw_LF, FALSE),
														// FileServices.AddSuperFile(Files.Document_Raw_SF,Files.Document_Raw_LF('fl_data_removal')),
														// FileServices.FinishSuperFileTransaction()
													 // );
													 
  //Incident file counts
	fl_incident := JOIN(d_incident, dds_incident_fl,
									    TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
									    TRANSFORM(LEFT), LOCAL);
										
  //Incident file deletion
	incident_after_fl_deletion := JOIN(d_incident, dds_incident_fl,
																	   TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
																	   TRANSFORM(LEFT), LEFT ONLY, LOCAL):INDEPENDENT;
  inc_out := OUTPUT(incident_after_fl_deletion,,Files.Incident_Raw_LF('fl_data_removal'),OVERWRITE,__COMPRESSED__,
		                CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"'),MAXLENGTH(60000)));
											
	incident_out := SEQUENTIAL(
														 inc_out,
														 FileServices.StartSuperFileTransaction(),
														 FileServices.ClearSuperFile(Files.Incident_Raw_SF, FALSE),
														 FileServices.AddSuperFile(Files.Incident_Raw_SF,Files.Incident_Raw_LF('fl_data_removal')),
														 FileServices.FinishSuperFileTransaction()
													  );

	//Calculating stats
  ds_pre_delete := DATASET([{'PRE_DELETE', COUNT(dds_incident_fl), COUNT(d_incident), COUNT(fl_incident), 0, COUNT(d_persn), COUNT(fl_persn), 0, COUNT(d_vehicl), COUNT(fl_vehicl), 0, COUNT(d_citation), COUNT(fl_citation), 0, COUNT(d_commercial), COUNT(fl_commercial), 0, COUNT(d_property), COUNT(fl_property), 0}], lay_fl_fiers_removal_stats);
  ds_post_delete := DATASET([{'POST_DELETE', ds_pre_delete[1].fiers_incidents, ds_pre_delete[1].total_incidents, ds_pre_delete[1].total_fl_incidents, COUNT(incident_after_fl_deletion), ds_pre_delete[1].total_persons, ds_pre_delete[1].total_fl_persons, COUNT(persn_after_fl_deletion), ds_pre_delete[1].total_vehicles, ds_pre_delete[1].total_fl_vehicles, COUNT(vehicl_after_fl_deletion), ds_pre_delete[1].total_citations, ds_pre_delete[1].total_fl_citations, COUNT(citation_after_fl_deletion), ds_pre_delete[1].total_commercials, ds_pre_delete[1].total_fl_commercials, COUNT(commercial_after_fl_deletion), ds_pre_delete[1].total_propertydamages, ds_pre_delete[1].total_fl_propertydamages, COUNT(property_after_fl_deletion)}], lay_fl_fiers_removal_stats);
  ds_fl_removal_stats := ds_pre_delete & ds_post_delete;
	
	delete_fl_data := SEQUENTIAL(
	                             OUTPUT(ds_pre_delete,,NAMED('PRE_DELETE')),
															 person_out,
															 citation_out,
															 property_out,
															 commercial_out,
															 vehicle_out,
															 //document_out,
															 incident_out,
															 OUTPUT(ds_post_delete,,NAMED('POST_DELETE')),
															 OUTPUT(ds_fl_removal_stats,,NAMED('FL_REMOVAL_STATS'))
															);
	 
	RETURN delete_fl_data;
END;											