IMPORT FLAccidents_Ecrash, eCrash_Maintenance;

EXPORT fn_Data_Deletion_Input_Files (STRING logicalfilename) := FUNCTION

  isDeletePropertyDamage := FALSE:STORED('DeletePropertyDamageData');
  isDeleteCommercial := FALSE:STORED('DeleteCommercialData');
  isDeleteDocument := FALSE:STORED('DeleteDocumentData');
	
	//Input Files 
	incident := FLAccidents_Ecrash.Infiles.Incident;
	persn := FLAccidents_Ecrash.Infiles.Persn;
	vehicl := FLAccidents_Ecrash.Infiles.Vehicl;
	citation := FLAccidents_Ecrash.Infiles.Citation;
	property_damage := FLAccidents_Ecrash.Infiles.Property_Damage;
	commercl := FLAccidents_Ecrash.Infiles.Commercl;
	document := FLAccidents_Ecrash.Infiles.Document;
		
	//Distribute DS
	d_incident := DISTRIBUTE(incident, HASH32(incident_id));
	d_persn := DISTRIBUTE(persn, HASH32(person_id, incident_id));
	d_vehicl := DISTRIBUTE(vehicl, HASH32(vehicle_id, incident_id));
	d_citation := DISTRIBUTE(citation, HASH32(citation_id, incident_id));
	d_property := DISTRIBUTE(Property_damage, HASH32(property_damage_id, incident_id));
	d_commercial := DISTRIBUTE(commercl, HASH32(commercial_id, vehicle_id));
	d_document := DISTRIBUTE(document, HASH32(incident_id));

  //Incident file deletion
  ds_incident_delete := DATASET('~thor_data400::in::ecrash::incident_raw::deletion'
															 ,FLAccidents_Ecrash.Layout_Infiles.incident_new
															 ,CSV(TERMINATOR('\n'), SEPARATOR('|\t|'), QUOTE('"'), MAXLENGTH(60000)))(Incident_ID != 'Incident_ID');  
	d_incident_delete := DEDUP(SORT(DISTRIBUTE(ds_incident_delete, HASH32(incident_id)), 
	                                incident_id, LOCAL), 
													   incident_id, LOCAL);
														 
	incident_deletion_count := JOIN(d_incident, d_incident_delete,
													  TRIM(LEFT.incident_id, LEFT, RIGHT) = TRIM(RIGHT.incident_id, LEFT, RIGHT),
														TRANSFORM(LEFT), LOCAL);

  incident_after_deletion := JOIN(d_incident, d_incident_delete,
													  TRIM(LEFT.incident_id, LEFT, RIGHT) = TRIM(RIGHT.incident_id, LEFT, RIGHT),
														TRANSFORM(LEFT), LEFT ONLY, LOCAL);
					
	out_incident := OUTPUT(incident_after_deletion,,eCrash_Maintenance.Files.Incident_Raw_LF(logicalfilename),OVERWRITE,__COMPRESSED__,
		                     CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"'),MAXLENGTH(60000)));
											
	incident_deletion := SEQUENTIAL(
														      out_incident,
														      FileServices.StartSuperFileTransaction(),
														      FileServices.ClearSuperFile(eCrash_Maintenance.Files.Incident_Raw_SF, FALSE),
														      FileServices.AddSuperFile(eCrash_Maintenance.Files.Incident_Raw_SF,
																	                          eCrash_Maintenance.Files.Incident_Raw_LF(logicalfilename)),
														      FileServices.FinishSuperFileTransaction()
													        );

  //Person file deletion
  ds_person_delete :=	DATASET('~thor_data400::in::ecrash::person_raw::deletion'
												      ,FLAccidents_Ecrash.Layout_Infiles.persn_new
													    ,CSV(TERMINATOR('\n'), SEPARATOR('|\t|'), QUOTE('"'), MAXLENGTH(3000000)))(Person_ID != 'Person_ID');
	d_person_delete := DEDUP(SORT(DISTRIBUTE(ds_person_delete, HASH32(person_id, incident_id)), 
	                              person_id, incident_id, LOCAL), 
													 person_id, incident_id, LOCAL);
													 
	persn_deletion_count := JOIN(d_persn, d_person_delete,
														  TRIM(LEFT.person_id, LEFT, RIGHT) = TRIM(RIGHT.person_id, LEFT, RIGHT) AND
														  TRIM(LEFT.incident_id, LEFT, RIGHT) = TRIM(RIGHT.incident_id, LEFT, RIGHT),
															TRANSFORM(LEFT), LOCAL);

  persn_after_deletion := JOIN(d_persn, d_person_delete,
														  TRIM(LEFT.person_id, LEFT, RIGHT) = TRIM(RIGHT.person_id, LEFT, RIGHT) AND
														  TRIM(LEFT.incident_id, LEFT, RIGHT) = TRIM(RIGHT.incident_id, LEFT, RIGHT),
															TRANSFORM(LEFT), LEFT ONLY, LOCAL);
																		 
	out_persn := OUTPUT(persn_after_deletion,,eCrash_Maintenance.Files.Person_Raw_LF(logicalfilename),OVERWRITE,__COMPRESSED__,
		                  CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"'),MAXLENGTH(60000)));
				 
	persn_deletion :=  SEQUENTIAL(
														    out_persn, 
														    FileServices.StartSuperFileTransaction(),
														    FileServices.ClearSuperFile(eCrash_Maintenance.Files.Person_Raw_SF, FALSE),
														    FileServices.AddSuperFile(eCrash_Maintenance.Files.Person_Raw_SF, 
														                              eCrash_Maintenance.Files.Person_Raw_LF(logicalfilename)),
														    FileServices.FinishSuperFileTransaction()
													      );
	
	//Vehicle file deletion
  ds_vehicle_delete := DATASET('~thor_data400::in::ecrash::vehicle_raw::deletion'
													    ,FLAccidents_Ecrash.Layout_Infiles.vehicl_new
													    ,CSV(TERMINATOR('\n'), SEPARATOR('|\t|'), QUOTE('"'), MAXLENGTH(50000)))(Vehicle_ID != 'Vehicle_ID');
	d_vehicle_delete := DEDUP(SORT(DISTRIBUTE(ds_vehicle_delete, HASH32(vehicle_id, incident_id)), 
	                              vehicle_id, incident_id, LOCAL), 
														vehicle_id, incident_id, LOCAL);
														
	vehicle_deletion_count := JOIN(d_vehicl, d_vehicle_delete,
													       TRIM(LEFT.vehicle_id, LEFT, RIGHT) = TRIM(RIGHT.vehicle_id, LEFT, RIGHT) AND
													       TRIM(LEFT.incident_id, LEFT, RIGHT) = TRIM(RIGHT.incident_id, LEFT, RIGHT),
													       TRANSFORM(LEFT), LOCAL);

  vehicle_after_deletion := JOIN(d_vehicl, d_vehicle_delete,
													       TRIM(LEFT.vehicle_id, LEFT, RIGHT) = TRIM(RIGHT.vehicle_id, LEFT, RIGHT) AND
													       TRIM(LEFT.incident_id, LEFT, RIGHT) = TRIM(RIGHT.incident_id, LEFT, RIGHT),
													       TRANSFORM(LEFT), LEFT ONLY, LOCAL);
					
	 out_vehicl := OUTPUT(vehicle_after_deletion,,eCrash_Maintenance.Files.Vehicle_Raw_LF(logicalfilename),OVERWRITE,__COMPRESSED__,
		                   CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"'),MAXLENGTH(60000)));
				 
	 vehicl_deletion := SEQUENTIAL(
														     out_vehicl, 
														     FileServices.StartSuperFileTransaction(),
														     FileServices.ClearSuperFile(eCrash_Maintenance.Files.Vehicle_Raw_SF, FALSE),
														     FileServices.AddSuperFile(eCrash_Maintenance.Files.Vehicle_Raw_SF,
														                               eCrash_Maintenance.Files.Vehicle_Raw_LF(logicalfilename)),
														     FileServices.FinishSuperFileTransaction()
													       );	
		
	//Citation
  ds_citation_delete := DATASET('~thor_data400::in::ecrash::citation_raw::deletion'
													    ,FLAccidents_Ecrash.Layout_Infiles.citation
													    ,CSV(TERMINATOR('\n'), SEPARATOR('|\t|'), QUOTE('"')))(Citation_ID != 'Citation_ID'); 														
	d_citation_delete := DEDUP(SORT(DISTRIBUTE(ds_citation_delete, HASH32(citation_id, incident_id)), 
	                                citation_id, incident_id, LOCAL), 
														 citation_id, incident_id, LOCAL);
														 
	citation_deletion_count := JOIN(d_citation, d_citation_delete,
													        TRIM(LEFT.citation_id, LEFT, RIGHT) = TRIM(RIGHT.citation_id, LEFT, RIGHT) AND
													        TRIM(LEFT.incident_id, LEFT, RIGHT) = TRIM(RIGHT.incident_id, LEFT, RIGHT),
													        TRANSFORM(LEFT), LOCAL);
	
  citation_after_deletion := JOIN(d_citation, d_citation_delete,
													        TRIM(LEFT.citation_id, LEFT, RIGHT) = TRIM(RIGHT.citation_id, LEFT, RIGHT) AND
													        TRIM(LEFT.incident_id, LEFT, RIGHT) = TRIM(RIGHT.incident_id, LEFT, RIGHT),
													        TRANSFORM(LEFT), LEFT ONLY, LOCAL);
					
	out_citation := OUTPUT(citation_after_deletion,,eCrash_Maintenance.Files.Citation_Raw_LF(logicalfilename),OVERWRITE,__COMPRESSED__,
		                     CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"'),MAXLENGTH(60000)));
				 
	citation_deletion := SEQUENTIAL(
														      out_citation,
														      FileServices.StartSuperFileTransaction(),
														      FileServices.ClearSuperFile(eCrash_Maintenance.Files.Citation_Raw_SF, FALSE),
														      FileServices.AddSuperFile(eCrash_Maintenance.Files.Citation_Raw_SF,
														                                eCrash_Maintenance.Files.Citation_Raw_LF(logicalfilename)),
														      FileServices.FinishSuperFileTransaction()
													        );
												
	//Commercial file deletion
  ds_commercial_delete := DATASET('~thor_data400::in::ecrash::commercial_raw::deletion'
													        ,FLAccidents_Ecrash.Layout_Infiles.commercial
													        ,CSV(TERMINATOR('\n'), SEPARATOR('|\t|'), QUOTE('"')))(Commercial_ID != 'Commercial_ID');
	d_commercial_delete := DEDUP(SORT(DISTRIBUTE(ds_commercial_delete(TRIM(commercial_id, LEFT, RIGHT) <> ''),HASH32(commercial_id, vehicle_id)), 
	                                 commercial_id, vehicle_id, LOCAL), 
															commercial_id, vehicle_id, LOCAL);
															
	commercial_deletion_count := JOIN(d_commercial, d_commercial_delete,
													          TRIM(LEFT.commercial_id, LEFT, RIGHT) = TRIM(RIGHT.commercial_id, LEFT, RIGHT) AND
													          TRIM(LEFT.vehicle_id, LEFT, RIGHT) = TRIM(RIGHT.vehicle_id, LEFT, RIGHT),
													          TRANSFORM(LEFT), LOCAL);
								
	commercial_after_deletion := JOIN(d_commercial, d_commercial_delete,
													          TRIM(LEFT.commercial_id, LEFT, RIGHT) = TRIM(RIGHT.commercial_id, LEFT, RIGHT) AND
													          TRIM(LEFT.vehicle_id, LEFT, RIGHT) = TRIM(RIGHT.vehicle_id, LEFT, RIGHT),
													          TRANSFORM(LEFT), LEFT ONLY, LOCAL);

	out_commercial := OUTPUT(commercial_after_deletion,,eCrash_Maintenance.Files.Commercial_Raw_LF(logicalfilename),OVERWRITE,__COMPRESSED__,
		                       CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"'),MAXLENGTH(50000)));
				 
	commercial_deletion := SEQUENTIAL(
	                                  out_commercial,
																    FileServices.StartSuperFileTransaction(),
																    FileServices.ClearSuperFile(eCrash_Maintenance.Files.Commercial_Raw_SF, FALSE),
																    FileServices.AddSuperFile(eCrash_Maintenance.Files.Commercial_Raw_SF,
																                              eCrash_Maintenance.Files.Commercial_Raw_LF(logicalfilename)),
																    FileServices.FinishSuperFileTransaction()
															      );
												
	//Property Damage file deletion
  ds_property_delete := DATASET('~thor_data400::in::ecrash::propertydamage_raw::deletion'
													 ,FLAccidents_Ecrash.Layout_Infiles.property_damage
													 ,CSV(TERMINATOR('\n'), SEPARATOR('|\t|'), QUOTE('"')))(Property_Damage_ID != 'Property_Damage_ID');
	d_property_delete := DEDUP(SORT(DISTRIBUTE(ds_property_delete(TRIM(property_damage_id, LEFT, RIGHT) <> ''),HASH32(property_damage_id, incident_id)), 
	                                property_damage_id, incident_id, LOCAL), 
														 property_damage_id, incident_id, LOCAL);
														 
	property_deletion_count := JOIN(d_property, d_property_delete,
													        TRIM(LEFT.property_damage_id, LEFT, RIGHT) = TRIM(RIGHT.property_damage_id, LEFT, RIGHT) AND
													        TRIM(LEFT.incident_id, LEFT, RIGHT) = TRIM(RIGHT.incident_id, LEFT, RIGHT),
													        TRANSFORM(LEFT), LOCAL);
  
	property_after_deletion := JOIN(d_property, d_property_delete,
													        TRIM(LEFT.property_damage_id, LEFT, RIGHT) = TRIM(RIGHT.property_damage_id, LEFT, RIGHT) AND
													        TRIM(LEFT.incident_id, LEFT, RIGHT) = TRIM(RIGHT.incident_id, LEFT, RIGHT),
													        TRANSFORM(LEFT), LEFT ONLY, LOCAL);
					
	out_property := OUTPUT(property_after_deletion,,eCrash_Maintenance.Files.PropertyDamage_Raw_LF(logicalfilename),OVERWRITE,__COMPRESSED__,
		                     CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"'),MAXLENGTH(50000)));
				 
	property_deletion := SEQUENTIAL(
														      out_property,
														      FileServices.StartSuperFileTransaction(),
														      FileServices.ClearSuperFile(eCrash_Maintenance.Files.PropertyDamage_Raw_SF, FALSE),
														      FileServices.AddSuperFile(eCrash_Maintenance.Files.PropertyDamage_Raw_SF,
														                                eCrash_Maintenance.Files.PropertyDamage_Raw_LF(logicalfilename)),
														      FileServices.FinishSuperFileTransaction()
													 );
													 
	//Document file deletion
  ds_document_delete := DATASET('~thor_data400::in::ecrash::document_raw::deletion'
													 ,FLAccidents_Ecrash.Layout_Infiles.document
													 ,CSV(TERMINATOR('\n'), SEPARATOR('|\t|'), QUOTE('"')))(Document_ID != 'Document_ID');
	d_document_delete := DEDUP(SORT(DISTRIBUTE(ds_document_delete(TRIM(document_id, LEFT, RIGHT) <> ''),HASH32(document_id, incident_id)), 
	                                document_id, incident_id, LOCAL), 
														 document_id, incident_id, LOCAL);
														 
	document_deletion_count := JOIN(d_document, d_document_delete,
													        TRIM(LEFT.document_id, LEFT, RIGHT) = TRIM(RIGHT.document_id, LEFT, RIGHT) AND
													        TRIM(LEFT.incident_id, LEFT, RIGHT) = TRIM(RIGHT.incident_id, LEFT, RIGHT),
													        TRANSFORM(LEFT), LOCAL);
  
	document_after_deletion := JOIN(d_document, d_document_delete,
													        TRIM(LEFT.document_id, LEFT, RIGHT) = TRIM(RIGHT.document_id, LEFT, RIGHT) AND
													        TRIM(LEFT.incident_id, LEFT, RIGHT) = TRIM(RIGHT.incident_id, LEFT, RIGHT),
													        TRANSFORM(LEFT), LEFT ONLY, LOCAL);
					
	out_document := OUTPUT(document_after_deletion,,eCrash_Maintenance.Files.Document_Raw_LF(logicalfilename),OVERWRITE,__COMPRESSED__,
		                     CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"'),MAXLENGTH(50000)));
				 
	document_deletion := SEQUENTIAL(
														      out_document,
														      FileServices.StartSuperFileTransaction(),
														      FileServices.ClearSuperFile(eCrash_Maintenance.Files.Document_Raw_SF, FALSE),
														      FileServices.AddSuperFile(eCrash_Maintenance.Files.Document_Raw_SF,
														                                eCrash_Maintenance.Files.Document_Raw_LF(logicalfilename)),
														      FileServices.FinishSuperFileTransaction()
													 );

  ds_pre_delete := DATASET([{'PRE_DELETE', COUNT(d_incident), COUNT(incident_deletion_count), COUNT(d_persn), COUNT(persn_deletion_count), COUNT(d_vehicl), COUNT(vehicle_deletion_count), COUNT(d_citation), COUNT(citation_deletion_count), COUNT(d_commercial), COUNT(commercial_deletion_count), COUNT(d_property), COUNT(property_deletion_count), COUNT(d_document), COUNT(document_deletion_count)}], Layouts.lay_pre_delete_stats);
	pre_delete_stats := OUTPUT(ds_pre_delete,,NAMED('PRE_DELETE_COUNTS'), OVERWRITE);
	
	seq_deletion := SEQUENTIAL(
	                           pre_delete_stats,
	                           persn_deletion, vehicl_deletion, citation_deletion, 
	                           IF(isDeletePropertyDamage, property_deletion, OUTPUT('No data to be deleted from Property_Damage Input file')),
														 IF(isDeleteCommercial, commercial_deletion, OUTPUT('No data to be deleted from Commercial Input file')),
														 IF(isDeleteDocument, document_deletion, OUTPUT('No data to be deleted from Document Input file')),
														 incident_deletion,
														 fn_post_delete_counts());
	 
	RETURN seq_deletion;
END;