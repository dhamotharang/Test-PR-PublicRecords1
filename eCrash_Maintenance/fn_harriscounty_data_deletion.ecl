IMPORT Data_Services, STD, FLAccidents_Ecrash;

EXPORT  fn_harriscounty_data_deletion():= FUNCTION

//WUID For verification 09/11/2020: W20200911-224828

  lay_hc_data_removal_stats := RECORD
	  STRING Desc;
	  UNSIGNED8 total_incidents;
	  UNSIGNED8 total_unq_incidents;
	  UNSIGNED8 total_hc_incidents;
	  UNSIGNED8 total_unq_hc_incidents;
	  UNSIGNED8 total_incidents_after_delete;
	  UNSIGNED8 total_hc_incidents_after_delete;
		UNSIGNED8 total_persons;
	  UNSIGNED8 total_hc_persons;
	  UNSIGNED8 total_persons_after_delete;
	  UNSIGNED8 total_hc_persons_after_delete;
		UNSIGNED8 total_vehicles;
	  UNSIGNED8 total_hc_vehicles;
	  UNSIGNED8 total_vehicles_after_delete;
	  UNSIGNED8 total_hc_vehicles_after_delete;
		// UNSIGNED8 total_citations;
	  // UNSIGNED8 total_hc_citations;
	  // UNSIGNED8 total_citations_after_delete;
	  // UNSIGNED8 total_hc_citations_after_delete;
		// UNSIGNED8 total_property;
	  // UNSIGNED8 total_hc_property;
	  // UNSIGNED8 total_property_after_delete;
	  // UNSIGNED8 total_hc_property_after_delete;
		// UNSIGNED8 total_document;
	  // UNSIGNED8 total_hc_document;
	  // UNSIGNED8 total_document_after_delete;
	  // UNSIGNED8 total_hc_document_after_delete;
		// UNSIGNED8 total_unq_hc_veh;
		// UNSIGNED8 total_commercial;
	  // UNSIGNED8 total_hc_commercial;
	  // UNSIGNED8 total_commercial_after_delete;
	  // UNSIGNED8 total_hc_commercial_after_delete;
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
													
	// citation := DATASET(Data_Services.foreign_prod+'thor_data400::in::ecrash::citatn_raw'
										  // ,FLAccidents_Ecrash.Layout_Infiles.citation
											// ,csv(terminator('\n'), separator(','),quote('"')))(Citation_ID != 'Citation_ID'); 
																							
	// Property_damage :=  dataset(Data_Services.foreign_prod+'thor_data400::in::ecrash::propertydamage_raw'
													    // ,FLAccidents_Ecrash.Layout_Infiles.property_damage
													    // ,csv(terminator('\n'), separator(','),quote('"'),maxlength(50000)))(Property_Damage_ID != 'Property_Damage_ID'); 
													
	// document := DATASET(Data_Services.foreign_prod+'thor_data400::in::ecrash::document_raw'
								 // ,FLAccidents_Ecrash.Layout_Infiles.Document
								 // ,CSV(HEADING(1),TERMINATOR('\n'), SEPARATOR(','),QUOTE('"')),OPT)(Document_ID != 'Document_ID');
								 
	// commercl := dataset(Data_Services.foreign_prod+'thor_data400::in::ecrash::commercl_raw'
										  // ,FLAccidents_Ecrash.Layout_Infiles.commercial
											// ,csv(terminator('\n'), separator(','),quote('"')))(Commercial_ID != 'Commercial_ID') ;
								 
	//Distribute DS
	d_incident := DISTRIBUTE(incident, HASH32(incident_id)):INDEPENDENT;
	d_persn := DISTRIBUTE(persn, HASH32(incident_id)):INDEPENDENT;
	d_vehicl := DISTRIBUTE(vehicl, HASH32(incident_id)):INDEPENDENT;
	// d_citation := DISTRIBUTE(citation, HASH32(incident_id)):INDEPENDENT;
	// d_property := DISTRIBUTE(Property_damage, HASH32(incident_id)):INDEPENDENT;
	// d_document := DISTRIBUTE(document, HASH32(incident_id)):INDEPENDENT;
	// d_commercial := DISTRIBUTE(commercl, HASH32(vehicle_id)):INDEPENDENT;
	
	//Unique Incidents
	unq_incident := DEDUP(SORT(d_incident(incident_id <> ''), incident_id, -(sent_to_hpcc_datetime), LOCAL), incident_id, LOCAL):INDEPENDENT;

	//HC Incidents									
	hc_incident := d_incident(STD.Str.ToUpperCase(TRIM(vendor_code, ALL)) = 'HARRISCOUNTY' AND agency_id IN ['1516062', '1516072', 
	                                                                                                         '1516082', '1516092', '1516102', '1516112',
																																																					 '1516122', '1516132', '1516202', '6668433']):PERSIST('~THOR::BASE::PERSIST::ECRASH::HC_DATA_REMOVAL::INCIDENTS', EXPIRE(30), SINGLE);;
													
	//Unique HC incidents
	unq_hc_incident := DEDUP(SORT(hc_incident(incident_id <> ''), incident_id, -(sent_to_hpcc_datetime), LOCAL), incident_id, LOCAL):INDEPENDENT;
	
	//HC Persons counts	
  hc_persn := JOIN(d_persn, unq_hc_incident,
									 TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
									 TRANSFORM(LEFT), LOCAL);
									 
  //Person file deletion
  persn_after_hc_deletion := JOIN(d_persn, unq_hc_incident,
																  TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL), 
																  TRANSFORM(LEFT), LEFT ONLY, LOCAL):INDEPENDENT;

	out_per := OUTPUT(persn_after_hc_deletion,,'~thor_data400::in::ecrash::hc_data_removal_person_'+WORKUNIT,OVERWRITE,__COMPRESSED__,
		                CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"'),MAXLENGTH(60000)));
				 
	person_out :=  SEQUENTIAL(
														out_per, 
														FileServices.StartSuperFileTransaction(),
														FileServices.ClearSuperFile('~thor_data400::in::ecrash::persn_raw', FALSE),
														FileServices.AddSuperFile('~thor_data400::in::ecrash::persn_raw','~thor_data400::in::ecrash::hc_data_removal_person_'+workunit),
														FileServices.FinishSuperFileTransaction()
													 );

	//HC Vehicles counts
	hc_vehicl := JOIN(d_vehicl, unq_hc_incident,
									  TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
									  TRANSFORM(LEFT), LOCAL);
										
	//Unique Vehicle_id
	//unq_hc_vehicle := DEDUP(SORT(hc_vehicl(vehicle_id <> ''), vehicle_id, LOCAL), vehicle_id, LOCAL):INDEPENDENT;
	
  //Vehicle file deletion
	vehicl_after_hc_deletion := JOIN(d_vehicl, unq_hc_incident,
																	 TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
																	 TRANSFORM(LEFT), LEFT ONLY, LOCAL):INDEPENDENT;

	veh_out := OUTPUT(vehicl_after_hc_deletion,,'~thor_data400::in::ecrash::hc_data_removal_vehicle_'+WORKUNIT,OVERWRITE,__COMPRESSED__,
		                CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"'),MAXLENGTH(60000)));
				 
	vehicle_out := SEQUENTIAL(
														veh_out, 
														FileServices.StartSuperFileTransaction(),
														FileServices.ClearSuperFile('~thor_data400::in::ecrash::vehicl_raw', FALSE),
														FileServices.AddSuperFile('~thor_data400::in::ecrash::vehicl_raw','~thor_data400::in::ecrash::hc_data_removal_vehicle_'+workunit),
														FileServices.FinishSuperFileTransaction()
													 );
													 
	//HC Citations counts
	// hc_citation := JOIN(d_citation, unq_hc_incident,
									    // TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
									    // TRANSFORM(LEFT), LOCAL);
										
  //Citation file deletion
	// citation_after_hc_deletion := JOIN(d_citation, unq_hc_incident,
																	 // TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
																	 // TRANSFORM(LEFT), LEFT ONLY, LOCAL):INDEPENDENT;

	// cit_out := OUTPUT(citation_after_hc_deletion,,'~thor_data400::in::ecrash::hc_data_removal_citation_'+WORKUNIT,OVERWRITE,__COMPRESSED__,
		                // CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"'),MAXLENGTH(60000)));
				 
	// citation_out := SEQUENTIAL(
														// cit_out,
														// FileServices.StartSuperFileTransaction(),
														// FileServices.ClearSuperFile('~thor_data400::in::ecrash::citatn_raw', FALSE),
														// FileServices.AddSuperFile('~thor_data400::in::ecrash::citatn_raw','~thor_data400::in::ecrash::hc_data_removal_citation_'+workunit),
														// FileServices.FinishSuperFileTransaction()
													 // );
													 
	//HC property counts
	// hc_property := JOIN(d_property, unq_hc_incident,
									    // TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
									    // TRANSFORM(LEFT), LOCAL);
										
  //Property damage file deletion
	// property_after_hc_deletion := JOIN(d_property, unq_hc_incident,
																	   // TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
																	   // TRANSFORM(LEFT), LEFT ONLY, LOCAL):INDEPENDENT;

	// pro_out := OUTPUT(property_after_hc_deletion,,'~thor_data400::in::ecrash::hc_data_removal_property_'+WORKUNIT,OVERWRITE,__COMPRESSED__,
		                // CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"'),MAXLENGTH(50000)));
				 
	// property_out := SEQUENTIAL(
														// pro_out,
														// FileServices.StartSuperFileTransaction(),
														// FileServices.ClearSuperFile('~thor_data400::in::ecrash::propertydamage_raw', FALSE),
														// FileServices.AddSuperFile('~thor_data400::in::ecrash::propertydamage_raw','~thor_data400::in::ecrash::hc_data_removal_property_'+workunit),
														// FileServices.FinishSuperFileTransaction()
													 // );
													 
	//HC document counts
	// hc_document := JOIN(d_document, unq_hc_incident,
									    // TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
									    // TRANSFORM(LEFT), LOCAL);
										
  //Document file deletion
	// document_after_hc_deletion := JOIN(d_document, unq_hc_incident,
																	   // TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
																	   // TRANSFORM(LEFT), LEFT ONLY, LOCAL):INDEPENDENT;

	// doc_out := OUTPUT(document_after_hc_deletion,,'~thor_data400::in::ecrash::hc_data_removal_document_'+WORKUNIT,OVERWRITE,__COMPRESSED__,
		                // CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"'),MAXLENGTH(50000)));
				 
	// document_out := SEQUENTIAL(
														// doc_out,
														// FileServices.StartSuperFileTransaction(),
														// FileServices.ClearSuperFile('~thor_data400::in::ecrash::document_raw', FALSE),
														// FileServices.AddSuperFile('~thor_data400::in::ecrash::document_raw','~thor_data400::in::ecrash::hc_data_removal_document_'+workunit),
														// FileServices.FinishSuperFileTransaction()
													 // );
													 
	//HC commercial counts
	// hc_commercial := JOIN(d_commercial, unq_hc_vehicle,
									    // TRIM(LEFT.vehicle_id, ALL) = TRIM(RIGHT.vehicle_id,ALL),
									    // TRANSFORM(LEFT), LOCAL);
										
  //Commercial file deletion
	// commercial_after_hc_deletion := JOIN(d_commercial, unq_hc_vehicle,
																	   // TRIM(LEFT.vehicle_id, ALL) = TRIM(RIGHT.vehicle_id,ALL),
																	   // TRANSFORM(LEFT), LEFT ONLY, LOCAL):INDEPENDENT;

	// com_out := OUTPUT(commercial_after_hc_deletion,,'~thor_data400::in::ecrash::hc_data_removal_commercial_'+WORKUNIT,OVERWRITE,__COMPRESSED__,
		                // CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"'),MAXLENGTH(50000)));
				 
	// commercial_out := SEQUENTIAL(
	                              // com_out,
																// FileServices.StartSuperFileTransaction(),
																// FileServices.ClearSuperFile('~thor_data400::in::ecrash::commercl_raw', FALSE),
																// FileServices.AddSuperFile('~thor_data400::in::ecrash::commercl_raw','~thor_data400::in::ecrash::hc_data_removal_commercial_'+workunit),
																// FileServices.FinishSuperFileTransaction()
															 // );

  //Incident file deletion
  incident_after_hc_deletion := d_incident(~(STD.Str.ToUpperCase(TRIM(vendor_code, LEFT, RIGHT)) = 'HARRISCOUNTY' AND agency_id IN ['1516062', '1516072', 
	                                                                                                         '1516082', '1516092', '1516102', '1516112',
																																																					 '1516122', '1516132', '1516202', '6668433'])):INDEPENDENT;

  inc_out := OUTPUT(incident_after_hc_deletion,,'~thor_data400::in::ecrash::hc_data_removal_incident_'+WORKUNIT,OVERWRITE,__COMPRESSED__,
		                CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"'),MAXLENGTH(60000)));
	
											
	incident_out := SEQUENTIAL(
														 inc_out,
														 FileServices.StartSuperFileTransaction(),
														 FileServices.ClearSuperFile('~thor_data400::in::ecrash::incidnt_raw_new', FALSE),
														 FileServices.AddSuperFile('~thor_data400::in::ecrash::incidnt_raw_new','~thor_data400::in::ecrash::hc_data_removal_incident_'+workunit),
														 FileServices.FinishSuperFileTransaction()
													  );

	//Calculating stats
  //ds_pre_delete := DATASET([{'PRE_DELETE', COUNT(incident), COUNT(unq_incident), COUNT(hc_incident), COUNT(unq_hc_incident), 0, 0, COUNT(persn), COUNT(hc_persn), 0, 0, COUNT(vehicl), COUNT(hc_vehicl), 0, 0, COUNT(citation), COUNT(hc_citation), 0, 0, COUNT(Property_damage), COUNT(hc_property), 0, 0, COUNT(document), COUNT(hc_document), 0, 0, COUNT(unq_hc_vehicle), COUNT(commercl), COUNT(hc_commercial), 0, 0}], lay_hc_data_removal_stats);
  ds_pre_delete := DATASET([{'PRE_DELETE', COUNT(incident), COUNT(unq_incident), COUNT(hc_incident), COUNT(unq_hc_incident), 0, 0, COUNT(persn), COUNT(hc_persn), 0, 0, COUNT(vehicl), COUNT(hc_vehicl), 0, 0}], lay_hc_data_removal_stats);
	//ds_post_delete := DATASET([{'POST_DELETE', ds_pre_delete[1].total_incidents, ds_pre_delete[1].total_hc_incidents, ds_pre_delete[1].total_unq_hc_incidents, ds_pre_delete[1].total_unq_hc_incidents, COUNT(incident_after_hc_deletion), COUNT(hc_incident), ds_pre_delete[1].total_persons, ds_pre_delete[1].total_hc_persons, COUNT(persn_after_hc_deletion), COUNT(hc_persn), ds_pre_delete[1].total_vehicles, ds_pre_delete[1].total_hc_vehicles, COUNT(vehicl_after_hc_deletion), COUNT(hc_vehicl), ds_pre_delete[1].total_citations, ds_pre_delete[1].total_hc_citations, COUNT(citation_after_hc_deletion), COUNT(hc_citation), ds_pre_delete[1].total_property, ds_pre_delete[1].total_hc_property, COUNT(property_after_hc_deletion), COUNT(hc_property), ds_pre_delete[1].total_document, ds_pre_delete[1].total_hc_document, COUNT(document_after_hc_deletion), COUNT(hc_document), ds_pre_delete[1].total_unq_hc_veh, ds_pre_delete[1].total_commercial, ds_pre_delete[1].total_hc_commercial, COUNT(commercial_after_hc_deletion), COUNT(hc_commercial)}], lay_hc_data_removal_stats);
	ds_post_delete := DATASET([{'POST_DELETE', ds_pre_delete[1].total_incidents, ds_pre_delete[1].total_hc_incidents, ds_pre_delete[1].total_unq_hc_incidents, ds_pre_delete[1].total_unq_hc_incidents, COUNT(incident_after_hc_deletion), COUNT(hc_incident), ds_pre_delete[1].total_persons, ds_pre_delete[1].total_hc_persons, COUNT(persn_after_hc_deletion), COUNT(hc_persn), ds_pre_delete[1].total_vehicles, ds_pre_delete[1].total_hc_vehicles, COUNT(vehicl_after_hc_deletion), COUNT(hc_vehicl)}], lay_hc_data_removal_stats);
  ds_hc_removal_stats := ds_pre_delete & ds_post_delete;
	
	delete_hc_data := SEQUENTIAL(
	                             OUTPUT(ds_pre_delete,,NAMED('PRE_DELETE')),
															 person_out,
															 //citation_out,
															 //property_out,
															 //document_out,
															 //commercial_out,
															 vehicle_out,
															 incident_out,
															 OUTPUT(ds_post_delete,,NAMED('POST_DELETE')),
															 OUTPUT(ds_hc_removal_stats,,NAMED('HC_REMOVAL_STATS'))
															);
	 
	RETURN delete_hc_data;
END;
