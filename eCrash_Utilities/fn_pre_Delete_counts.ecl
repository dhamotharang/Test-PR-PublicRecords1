IMPORT FLAccidents_Ecrash;

EXPORT fn_pre_Delete_counts(DATASET(FLAccidents_Ecrash.Layout_Infiles.incident_new) dds_incident) := FUNCTION

	incident := FLAccidents_Ecrash.Infiles.Incident;
	persn := FLAccidents_Ecrash.Infiles.Persn;
	vehicl := FLAccidents_Ecrash.Infiles.Vehicl;
	citation := FLAccidents_Ecrash.Infiles.Citation;
	Property_damage := FLAccidents_Ecrash.Infiles.Property_Damage;
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
	
	//Person file deletion counts
  persn_deletion := JOIN(d_persn, dds_incident,
												 TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL), 
												 TRANSFORM(LEFT), LOCAL);
												 
	//Vehicle file deletion counts
	vehicl_deletion := JOIN(d_vehicl, dds_incident,
															  TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
																TRANSFORM(LEFT), LOCAL);
																
	//Unique Vehicle_id
	d_unq_vehicle := DEDUP(SORT(DISTRIBUTE(vehicl_deletion(TRIM(vehicle_id, LEFT, RIGHT) <> ''), HASH32(vehicle_id)), vehicle_id, LOCAL), vehicle_id, LOCAL);		
		
	//Citation file deletion counts
	citation_deletion := JOIN(d_citation, dds_incident,
																	TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
																	TRANSFORM(LEFT), LOCAL);
																				 
  //Commercial file deletion counts
	commercial_deletion := JOIN(d_commercial, d_unq_vehicle,
																	  TRIM(LEFT.vehicle_id, ALL) = TRIM(RIGHT.vehicle_id,ALL),
																	  TRANSFORM(LEFT), LOCAL);
																					 
	//Document file deletion counts
	document_deletion := JOIN(d_document, dds_incident,
													  TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
													  TRANSFORM(LEFT), LOCAL);
														
	//Property Damage file deletion counts
	property_deletion := JOIN(d_property, dds_incident,
													  TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
														TRANSFORM(LEFT), LOCAL);
																	
	//Incident file deletion counts
	incident_deletion := JOIN(d_incident, dds_incident,
													  TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id,ALL),
														TRANSFORM(LEFT), LOCAL);

	ds_pre_delete := DATASET([{'PRE_DELETE', COUNT(d_incident), COUNT(incident_deletion), COUNT(d_persn), COUNT(persn_deletion), COUNT(d_vehicl), COUNT(vehicl_deletion), COUNT(d_citation), COUNT(citation_deletion), COUNT(d_commercial), COUNT(commercial_deletion), COUNT(d_property), COUNT(property_deletion), COUNT(d_document), COUNT(document_deletion)}], Layouts.lay_pre_delete_stats);
	pre_delete_stats := OUTPUT(ds_pre_delete,,NAMED('PRE_DELETE_COUNTS'), OVERWRITE);
	
	RETURN pre_delete_stats;																					
END;

	