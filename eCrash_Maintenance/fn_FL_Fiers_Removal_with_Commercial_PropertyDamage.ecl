IMPORT ut, Data_Services, FLAccidents_Ecrash; 

EXPORT fn_FL_Fiers_Removal_with_Commercial_PropertyDamage := FUNCTION

 lay_fl_fiers_removal_stats := RECORD
	  STRING Desc;
	  UNSIGNED8 fiers_incidents;
		UNSIGNED8 total_fl_incidents;
	  UNSIGNED8 total_fiers_fl_incidents;
	  UNSIGNED8 total_incidents_after_delete;
		UNSIGNED8 fiers_persons;
		UNSIGNED8 total_fl_persons;
	  UNSIGNED8 total_fiers_fl_persons;
	  UNSIGNED8 total_persons_after_delete;
		UNSIGNED8 fiers_vehicles;
		UNSIGNED8 total_fl_vehicles;
	  UNSIGNED8 total_fiers_fl_vehicles;
	  UNSIGNED8 total_vehicles_after_delete;
		UNSIGNED8 fiers_citations;
		UNSIGNED8 total_fl_citations;
	  UNSIGNED8 total_fiers_fl_citations;
	  UNSIGNED8 total_citations_after_delete;
		UNSIGNED8 fiers_commercials;
		UNSIGNED8 total_fl_commercials;
	  UNSIGNED8 total_fiers_fl_commercials;
	  UNSIGNED8 total_commercials_after_delete;
		UNSIGNED8 fiers_propertydamages;
		UNSIGNED8 total_fl_propertydamages;
	  UNSIGNED8 total_fiers_fl_propertydamages;
	  UNSIGNED8 total_propertydamages_after_delete;
	END;

   //Incident
  ds_incident_fiers := DATASET('~thor_data400::in::ecrash::incident_raw::flremoval'
															 ,FLAccidents_Ecrash.Layout_Infiles.incident_new
															 ,CSV(TERMINATOR('\n'), SEPARATOR('|\t|'), QUOTE('"'), MAXLENGTH(60000)))(Incident_ID != 'Incident_ID');                    

  ds_incident := DATASET(Data_Services.foreign_prod+'thor_data400::in::ecrash::incidnt_raw_new'
												 ,FLAccidents_Ecrash.Layout_Infiles.incident_new
												 ,CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"'), MAXLENGTH(60000)))(Incident_ID != 'Incident_ID');                  

	d_incident_fiers := DEDUP(SORT(DISTRIBUTE(ds_incident_fiers, HASH32(incident_id)), 
	                               incident_id, LOCAL), 
													  incident_id, LOCAL):INDEPENDENT;
	d_incident := DISTRIBUTE(ds_incident, HASH32(incident_id)):INDEPENDENT;
	
  fl_fiers_incident := JOIN(d_incident, d_incident_fiers,
														TRIM(LEFT.incident_id, LEFT, RIGHT) = TRIM(RIGHT.incident_id, LEFT, RIGHT),
														TRANSFORM(LEFT), LOCAL);
									 
  //Incident fiers fl data deletion
  fl_fiers_incident_deletion := JOIN(d_incident, d_incident_fiers,
																		 TRIM(LEFT.incident_id, LEFT, RIGHT) = TRIM(RIGHT.incident_id, LEFT, RIGHT),
																		 TRANSFORM(LEFT), LEFT ONLY, LOCAL):INDEPENDENT;
					
	out_inc := OUTPUT(fl_fiers_incident_deletion,,'~thor_data400::in::ecrash::fl_fiers_data_removal_incident_'+WORKUNIT,overwrite, __compressed__,
					          CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"'), MAXLENGTH(60000)));

	inc_all :=  SEQUENTIAL(
												 out_inc, 
												 FileServices.StartSuperFileTransaction(),
												 FileServices.ClearSuperFile('~thor_data400::in::ecrash::incidnt_raw_new', FALSE),
												 FileServices.AddSuperFile('~thor_data400::in::ecrash::incidnt_raw_new','~thor_data400::in::ecrash::fl_fiers_data_removal_incident_'+WORKUNIT),
												 FileServices.FinishSuperFileTransaction()
												);

  //Person
  ds_person_fiers :=	DATASET('~thor_data400::in::ecrash::person_raw::flremoval'
												     ,FLAccidents_Ecrash.Layout_Infiles.persn_new
													   ,CSV(TERMINATOR('\n'), SEPARATOR('|\t|'), QUOTE('"'), MAXLENGTH(3000000)))(Person_ID != 'Person_ID');
                    
  ds_person := DATASET(Data_Services.foreign_prod+'thor_data400::in::ecrash::persn_raw'
											,FLAccidents_Ecrash.Layout_Infiles.persn_new
											,CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"'), ESCAPE('\r'), MAXLENGTH(3000000)))(Person_ID != 'Person_ID');
                    
	d_person_fiers := DEDUP(SORT(DISTRIBUTE(ds_person_fiers, HASH32(person_id, incident_id)), 
	                             person_id, incident_id, LOCAL), 
													person_id, incident_id, LOCAL):INDEPENDENT;
	d_person := DISTRIBUTE(ds_person, HASH32(person_id, incident_id)):INDEPENDENT;
	
  fl_fiers_person := JOIN(d_person, d_person_fiers,
												  TRIM(LEFT.person_id, LEFT, RIGHT) = TRIM(RIGHT.person_id, LEFT, RIGHT) AND
													TRIM(LEFT.incident_id, LEFT, RIGHT) = TRIM(RIGHT.incident_id, LEFT, RIGHT),
													TRANSFORM(LEFT), LOCAL);
									 
  //Person fiers fl data deletion
  fl_fiers_person_deletion := JOIN(d_person, d_person_fiers,
																	 TRIM(LEFT.person_id, LEFT, RIGHT) = TRIM(RIGHT.person_id, LEFT, RIGHT) AND
																	 TRIM(LEFT.incident_id, LEFT, RIGHT) = TRIM(RIGHT.incident_id, LEFT, RIGHT),
																	 TRANSFORM(LEFT), LEFT ONLY, LOCAL):INDEPENDENT;
																		 
	out_per := OUTPUT(fl_fiers_person_deletion,,'~thor_data400::in::ecrash::fl_fiers_data_removal_person_'+WORKUNIT,OVERWRITE, __COMPRESSED__,
					          CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"'), MAXLENGTH(3000000)));

	per_all :=  SEQUENTIAL(
												 out_per,
												 FileServices.StartSuperFileTransaction(),
												 FileServices.ClearSuperFile('~thor_data400::in::ecrash::persn_raw', FALSE),
												 FileServices.AddSuperFile('~thor_data400::in::ecrash::persn_raw','~thor_data400::in::ecrash::fl_fiers_data_removal_person_'+WORKUNIT),
												 FileServices.FinishSuperFileTransaction()
												);
	
	//Vehicle
  ds_vehicle_fiers := DATASET('~thor_data400::in::ecrash::vehicle_raw::flremoval'
													    ,FLAccidents_Ecrash.Layout_Infiles.vehicl_new
													    ,CSV(TERMINATOR('\n'), SEPARATOR('|\t|'), QUOTE('"'), MAXLENGTH(50000)))(Vehicle_ID != 'Vehicle_ID');

  ds_vehicle := DATASET(Data_Services.foreign_prod+'thor_data400::in::ecrash::vehicl_raw'
											  ,FLAccidents_Ecrash.Layout_Infiles.vehicl_new
												,CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"'), MAXLENGTH(50000)))(Vehicle_ID != 'Vehicle_ID');
   
	d_vehicle_fiers := DEDUP(SORT(DISTRIBUTE(ds_vehicle_fiers, HASH32(vehicle_id, incident_id)), 
	                              vehicle_id, incident_id, LOCAL), 
														vehicle_id, incident_id, LOCAL):INDEPENDENT;
	d_vehicle := DISTRIBUTE(ds_vehicle, HASH32(vehicle_id, incident_id)):INDEPENDENT;
	
  fl_fiers_vehicle := JOIN(d_vehicle, d_vehicle_fiers,
													 TRIM(LEFT.vehicle_id, LEFT, RIGHT) = TRIM(RIGHT.vehicle_id, LEFT, RIGHT) AND
													 TRIM(LEFT.incident_id, LEFT, RIGHT) = TRIM(RIGHT.incident_id, LEFT, RIGHT),
													 TRANSFORM(LEFT), LOCAL);
									 
  //Vehicle fiers fl data deletion
  fl_fiers_vehicle_deletion := JOIN(d_vehicle, d_vehicle_fiers,
													          TRIM(LEFT.vehicle_id, LEFT, RIGHT) = TRIM(RIGHT.vehicle_id, LEFT, RIGHT) AND
													          TRIM(LEFT.incident_id, LEFT, RIGHT) = TRIM(RIGHT.incident_id, LEFT, RIGHT),
													          TRANSFORM(LEFT), LEFT ONLY, LOCAL):INDEPENDENT;
					
	 out_veh := OUTPUT(fl_fiers_vehicle_deletion,,'~thor_data400::in::ecrash::fl_fiers_data_removal_vehicle_'+WORKUNIT, OVERWRITE, __COMPRESSED__,
					           CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"'), MAXLENGTH(50000)));

	 veh_all :=  SEQUENTIAL(
													 out_veh,
													 FileServices.StartSuperFileTransaction(),
													 FileServices.ClearSuperFile('~thor_data400::in::ecrash::vehicl_raw', FALSE),
													 FileServices.AddSuperFile('~thor_data400::in::ecrash::vehicl_raw','~thor_data400::in::ecrash::fl_fiers_data_removal_vehicle_'+WORKUNIT),
													 FileServices.FinishSuperFileTransaction()
												  );
		
	//Citation
  ds_citation_fiers := DATASET('~thor_data400::in::ecrash::citation_raw::flremoval'
													    ,FLAccidents_Ecrash.Layout_Infiles.citation
													    ,CSV(TERMINATOR('\n'), SEPARATOR('|\t|'), QUOTE('"')))(Citation_ID != 'Citation_ID'); 												
																
  ds_citation := DATASET(Data_Services.foreign_prod+'thor_data400::in::ecrash::citatn_raw'
							          ,FLAccidents_Ecrash.Layout_Infiles.citation
							          ,CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"')))(Citation_ID != 'Citation_ID'); 										
																
	d_citation_fiers := DEDUP(SORT(DISTRIBUTE(ds_citation_fiers, HASH32(citation_id, incident_id)), 
	                               citation_id, incident_id, LOCAL), 
														citation_id, incident_id, LOCAL):INDEPENDENT;
	d_citation := DISTRIBUTE(ds_citation, HASH32(citation_id, incident_id)):INDEPENDENT;
	
  fl_fiers_citation := JOIN(d_citation, d_citation_fiers,
													  TRIM(LEFT.citation_id, LEFT, RIGHT) = TRIM(RIGHT.citation_id, LEFT, RIGHT) AND
													  TRIM(LEFT.incident_id, LEFT, RIGHT) = TRIM(RIGHT.incident_id, LEFT, RIGHT),
													  TRANSFORM(LEFT), LOCAL);
									 
  //Citation fiers fl data deletion
  fl_fiers_citation_deletion := JOIN(d_citation, d_citation_fiers,
													           TRIM(LEFT.citation_id, LEFT, RIGHT) = TRIM(RIGHT.citation_id, LEFT, RIGHT) AND
													           TRIM(LEFT.incident_id, LEFT, RIGHT) = TRIM(RIGHT.incident_id, LEFT, RIGHT),
													           TRANSFORM(LEFT), LEFT ONLY, LOCAL):INDEPENDENT;
					
	 out_cit := OUTPUT(fl_fiers_citation_deletion,,'~thor_data400::in::ecrash::fl_fiers_data_removal_citation_'+WORKUNIT, OVERWRITE, __COMPRESSED__,
					           CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"')));

	cit_all :=  SEQUENTIAL(
												 out_cit,
												 FileServices.StartSuperFileTransaction(),
												 FileServices.ClearSuperFile('~thor_data400::in::ecrash::citatn_raw', FALSE),
												 FileServices.AddSuperFile('~thor_data400::in::ecrash::citatn_raw','~thor_data400::in::ecrash::fl_fiers_data_removal_citation_'+WORKUNIT),
												 FileServices.FinishSuperFileTransaction()
												);
												
	//Commercial
  ds_commercial_fiers := DATASET('~thor_data400::in::ecrash::commercial_raw::flremoval'
													 ,FLAccidents_Ecrash.Layout_Infiles.commercial
													 ,CSV(TERMINATOR('\n'), SEPARATOR('|\t|'), QUOTE('"')))(Commercial_ID != 'Commercial_ID');
								
  ds_commercial := DATASET(Data_Services.foreign_prod+'thor_data400::in::ecrash::commercl_raw'
													,FLAccidents_Ecrash.Layout_Infiles.commercial
													,CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"')))(Commercial_ID != 'Commercial_ID');
													
	d_commercial_fiers := DEDUP(SORT(DISTRIBUTE(ds_commercial_fiers(TRIM(commercial_id, LEFT, RIGHT) <> ''),HASH32(commercial_id, vehicle_id)), 
	                                 commercial_id, vehicle_id, LOCAL), 
															commercial_id, vehicle_id, LOCAL):INDEPENDENT;
	d_commercial := DISTRIBUTE(ds_commercial,HASH32(commercial_id, vehicle_id)):INDEPENDENT;
								
	fl_fiers_commercial := JOIN(d_commercial, d_commercial_fiers,
													    TRIM(LEFT.commercial_id, LEFT, RIGHT) = TRIM(RIGHT.commercial_id, LEFT, RIGHT) AND
													    TRIM(LEFT.vehicle_id, LEFT, RIGHT) = TRIM(RIGHT.vehicle_id, LEFT, RIGHT),
													    TRANSFORM(LEFT), LOCAL);
									 
  //Commercial fiers fl data deletion
  fl_fiers_commercial_deletion := JOIN(d_commercial, d_commercial_fiers,
													           TRIM(LEFT.commercial_id, LEFT, RIGHT) = TRIM(RIGHT.commercial_id, LEFT, RIGHT) AND
													           TRIM(LEFT.vehicle_id, LEFT, RIGHT) = TRIM(RIGHT.vehicle_id, LEFT, RIGHT),
													           TRANSFORM(LEFT), LEFT ONLY, LOCAL):INDEPENDENT;
					
	out_com := OUTPUT(fl_fiers_commercial_deletion,,'~thor_data400::in::ecrash::fl_fiers_data_removal_commercial_'+WORKUNIT, OVERWRITE, __COMPRESSED__,
					           CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"')));

	com_all :=  SEQUENTIAL(
												 out_com,
												 FileServices.StartSuperFileTransaction(),
												 FileServices.ClearSuperFile('~thor_data400::in::ecrash::commercl_raw', FALSE),
												 FileServices.AddSuperFile('~thor_data400::in::ecrash::commercl_raw','~thor_data400::in::ecrash::fl_fiers_data_removal_commercial_'+WORKUNIT),
												 FileServices.FinishSuperFileTransaction()
												);
												
	//Property Damage
  ds_property_fiers := DATASET('~thor_data400::in::ecrash::propertydamage_raw::flremoval'
													 ,FLAccidents_Ecrash.Layout_Infiles.property_damage
													 ,CSV(TERMINATOR('\n'), SEPARATOR('|\t|'), QUOTE('"')))(Property_Damage_ID != 'Property_Damage_ID');
	
	ds_property := DATASET(Data_Services.foreign_prod+'thor_data400::in::ecrash::propertydamage_raw'
													,FLAccidents_Ecrash.Layout_Infiles.property_damage
													,CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"'), MAXLENGTH(50000)))(Property_Damage_ID != 'Property_Damage_ID');
	
	d_property := DISTRIBUTE(ds_property,HASH32(property_damage_id, incident_id)):INDEPENDENT;
	d_property_fiers := DEDUP(SORT(DISTRIBUTE(ds_property_fiers(TRIM(property_damage_id, LEFT, RIGHT) <> ''),HASH32(property_damage_id, incident_id)), 
	                               property_damage_id, incident_id, LOCAL), 
														property_damage_id, incident_id, LOCAL):INDEPENDENT;
  
	fl_fiers_property := JOIN(d_property, d_property_fiers,
													  TRIM(LEFT.property_damage_id, LEFT, RIGHT) = TRIM(RIGHT.property_damage_id, LEFT, RIGHT) AND
													  TRIM(LEFT.incident_id, LEFT, RIGHT) = TRIM(RIGHT.incident_id, LEFT, RIGHT),
													  TRANSFORM(LEFT), LOCAL);
									 
  //Property Damage fiers fl data deletion
  fl_fiers_property_deletion := JOIN(d_property, d_property_fiers,
													           TRIM(LEFT.property_damage_id, LEFT, RIGHT) = TRIM(RIGHT.property_damage_id, LEFT, RIGHT) AND
													           TRIM(LEFT.incident_id, LEFT, RIGHT) = TRIM(RIGHT.incident_id, LEFT, RIGHT),
													           TRANSFORM(LEFT), LEFT ONLY, LOCAL):INDEPENDENT;
					
	out_pro := OUTPUT(fl_fiers_property_deletion,,'~thor_data400::in::ecrash::fl_fiers_data_removal_propertydamage_'+WORKUNIT, OVERWRITE, __COMPRESSED__,
					           CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"'), MAXLENGTH(50000)));

	pro_all :=  SEQUENTIAL(
												 out_pro,
												 FileServices.StartSuperFileTransaction(),
												 FileServices.ClearSuperFile('~thor_data400::in::ecrash::propertydamage_raw', FALSE),
												 FileServices.AddSuperFile('~thor_data400::in::ecrash::propertydamage_raw','~thor_data400::in::ecrash::fl_fiers_data_removal_propertydamage_'+WORKUNIT),
												 FileServices.FinishSuperFileTransaction()
												);
		
	//Calculating stats
  ds_pre_delete := DATASET([{'PRE_DELETE', COUNT(ds_incident_fiers), COUNT(ds_incident), COUNT(fl_fiers_incident), 0, COUNT(ds_person_fiers), COUNT(ds_person), COUNT(fl_fiers_person), 0, COUNT(ds_vehicle_fiers), COUNT(ds_vehicle), COUNT(fl_fiers_vehicle), 0, COUNT(ds_citation_fiers), COUNT(ds_citation), COUNT(fl_fiers_citation), 0, COUNT(ds_commercial_fiers), COUNT(ds_commercial), COUNT(fl_fiers_commercial), 0, COUNT(ds_property_fiers), COUNT(ds_property), COUNT(fl_fiers_property), 0}], lay_fl_fiers_removal_stats);
	ds_post_delete := DATASET([{'POST_DELETE', ds_pre_delete[1].fiers_incidents, ds_pre_delete[1].total_fl_incidents, ds_pre_delete[1].total_fiers_fl_incidents, COUNT(fl_fiers_incident_deletion),ds_pre_delete[1].fiers_persons, ds_pre_delete[1].total_fl_persons, ds_pre_delete[1].total_fiers_fl_persons, COUNT(fl_fiers_person_deletion), ds_pre_delete[1].fiers_vehicles, ds_pre_delete[1].total_fl_vehicles, ds_pre_delete[1].total_fiers_fl_vehicles, COUNT(fl_fiers_vehicle_deletion), ds_pre_delete[1].fiers_citations, ds_pre_delete[1].total_fl_citations, ds_pre_delete[1].total_fiers_fl_citations, COUNT(fl_fiers_citation_deletion), ds_pre_delete[1].fiers_commercials, ds_pre_delete[1].total_fl_commercials, ds_pre_delete[1].total_fiers_fl_commercials, COUNT(fl_fiers_commercial_deletion), ds_pre_delete[1].fiers_propertydamages, ds_pre_delete[1].total_fl_propertydamages, ds_pre_delete[1].total_fiers_fl_propertydamages, COUNT(fl_fiers_property_deletion)}], lay_fl_fiers_removal_stats);
  ds_fl_removal_stats := ds_pre_delete & ds_post_delete;
	
	delete_fl_fiers_data := SEQUENTIAL(
																		 OUTPUT(ds_pre_delete,,NAMED('PRE_DELETE')),
																		 inc_all,
																		 per_all,
																		 veh_all,
																		 cit_all,
																		 com_all,
																		 pro_all,
																		 OUTPUT(ds_post_delete,,NAMED('POST_DELETE')),
																		 OUTPUT(ds_fl_removal_stats,,NAMED('FL_FIERS_REMOVAL_STATS'))
																		);
	 
	RETURN delete_fl_fiers_data;

END;