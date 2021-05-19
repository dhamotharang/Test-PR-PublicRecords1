IMPORT FLAccidents_Ecrash, eCrash_Maintenance;

EXPORT fn_InputFiles_Deletion_Common (DATASET(FLAccidents_Ecrash.Layout_Infiles.incident_new) dds_incident, STRING logicalfilename) := FUNCTION 

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
	d_persn := DISTRIBUTE(persn, HASH32(incident_id));
	d_vehicl := DISTRIBUTE(vehicl, HASH32(incident_id));
	d_citation := DISTRIBUTE(citation, HASH32(incident_id));
	d_property := DISTRIBUTE(Property_damage, HASH32(incident_id));
	d_commercial := DISTRIBUTE(commercl, HASH32(vehicle_id));
	d_document := DISTRIBUTE(document, HASH32(incident_id));
	
	//Person file deletion
  persn_after_deletion := JOIN(d_persn, dds_incident,
															 TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL), 
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
																				 
	//Vehicles to join with commercial
	jvehicl := JOIN(d_vehicl, dds_incident,
									TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
									TRANSFORM(LEFT), LOCAL);
	//Unique Vehicle_id
	d_unq_vehicle := DEDUP(SORT(DISTRIBUTE(jvehicl(TRIM(vehicle_id, LEFT, RIGHT) <> ''), HASH32(vehicle_id)), vehicle_id, LOCAL), vehicle_id, LOCAL);		
										
	//Vehicle file deletion
	vehicl_after_deletion := JOIN(d_vehicl, dds_incident,
															  TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
																TRANSFORM(LEFT), LEFT ONLY, LOCAL);
	out_vehicl := OUTPUT(vehicl_after_deletion,,eCrash_Maintenance.Files.Vehicle_Raw_LF(logicalfilename),OVERWRITE,__COMPRESSED__,
		                   CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"'),MAXLENGTH(60000)));
				 
	vehicl_deletion := SEQUENTIAL(
														    out_vehicl, 
														    FileServices.StartSuperFileTransaction(),
														    FileServices.ClearSuperFile(eCrash_Maintenance.Files.Vehicle_Raw_SF, FALSE),
														    FileServices.AddSuperFile(eCrash_Maintenance.Files.Vehicle_Raw_SF,
														                              eCrash_Maintenance.Files.Vehicle_Raw_LF(logicalfilename)),
														    FileServices.FinishSuperFileTransaction()
													      );	
																
	//Citation file deletion
	citation_after_deletion := JOIN(d_citation, dds_incident,
																	TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
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
																				 
	//Property damage file deletion
	property_after_deletion := JOIN(d_property, dds_incident,
																	TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
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
																				 
  //Commercial file deletion
	commercial_after_deletion := JOIN(d_commercial, d_unq_vehicle,
																	  TRIM(LEFT.vehicle_id, ALL) = TRIM(RIGHT.vehicle_id,ALL),
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
																					 
	//Document file deletion
	document_after_deletion := JOIN(d_document, dds_incident,
																	TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
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
																	
	//Incident file deletion
	incident_after_deletion := JOIN(d_incident, dds_incident,
																	TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
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

																	
	seq_deletion := SEQUENTIAL(persn_deletion, vehicl_deletion, citation_deletion, 
	                           IF(isDeletePropertyDamage, property_deletion, OUTPUT('No data to be deleted from Property_Damage Input file')),
														 IF(isDeleteCommercial, commercial_deletion, OUTPUT('No data to be deleted from Commercial Input file')),
														 IF(isDeleteDocument, document_deletion, OUTPUT('No data to be deleted from Document Input file')),
														 incident_deletion);
	
	RETURN seq_deletion;																					
END;
