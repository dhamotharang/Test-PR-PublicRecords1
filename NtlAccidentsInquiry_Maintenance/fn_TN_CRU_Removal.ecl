IMPORT ut, Data_Services, flaccidents; 

EXPORT fn_TN_CRU_Removal := FUNCTION

lay_tn_removal_stats := RECORD
	  STRING Desc;
	  UNSIGNED8 tn_orderids;
		UNSIGNED8 total_ordervs;
	  UNSIGNED8 total_tn_ordervs;
	  UNSIGNED8 total_ordervs_after_delete;
		UNSIGNED8 total_initorder;
	  UNSIGNED8 total_tn_initorder;
		UNSIGNED8 total_result;
	  UNSIGNED8 total_tn_result;
	  UNSIGNED8 total_result_after_delete;
		UNSIGNED8 total_incidents;
	  UNSIGNED8 total_tn_incidents;
	  UNSIGNED8 total_incidents_after_delete;
		UNSIGNED8 total_client;
	  UNSIGNED8 total_tn_client;
	  UNSIGNED8 total_client_after_delete;
		UNSIGNED8 total_vehicles;
	  UNSIGNED8 total_tn_vehicles;
	  UNSIGNED8 total_vehicles_after_delete;
		UNSIGNED8 total_party;
	  UNSIGNED8 total_tn_party;
	  UNSIGNED8 total_party_after_delete;
	END;


 lay_order := RECORD
               STRING order_id; 
						  END;
						 
 dsOrder := DATASET(data_services.foreign_prod + 'thor_data400::in::ecrash::tn_data_deletion', lay_order,  CSV(SEPARATOR([',','\t']), TERMINATOR(['\n','\r\n','\n\r']),QUOTE('"')))(order_id != 'ORDER_ID');
 ddsOrder := DEDUP(dsOrder(TRIM(order_id, LEFT, RIGHT) <> ''), order_id); 
 d_ddsOrder_tn := DISTRIBUTE(ddsOrder, HASH32(order_id)):INDEPENDENT;

 //OrderVersion input file 
 ds_ordervs := DATASET(data_services.foreign_prod +'thor_data400::in::flcrash::alpharetta::order_version_new'
						           ,flaccidents.Layout_NtlAccidents_Alpharetta.order_vs
						           ,CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"')))(ORDER_ID  != 'ORDER_ID');
 d_ordervs := DISTRIBUTE(ds_ordervs, HASH32(order_id)):INDEPENDENT;
	
 tn_ordervs := JOIN(d_ordervs, d_ddsOrder_tn,
								    TRIM(LEFT.order_id, LEFT, RIGHT) = TRIM(RIGHT.order_id , LEFT, RIGHT),
										TRANSFORM(LEFT), LOCAL):INDEPENDENT;
									 
  //Order Version TN data deletion
  tn_ordervs_deletion := JOIN(d_ordervs, d_ddsOrder_tn,
																		TRIM(LEFT.order_id, LEFT, RIGHT) = TRIM(RIGHT.order_id, LEFT, RIGHT),
																		TRANSFORM(LEFT), LEFT ONLY, LOCAL):INDEPENDENT;
					
	 out_ordervs := OUTPUT(tn_ordervs_deletion,,'~thor_data400::in::ntl::tn_data_removal_ordervs_'+WORKUNIT,OVERWRITE, __COMPRESSED__,
					               CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"')));

	ordervs_all :=  SEQUENTIAL(
															out_ordervs,
															FileServices.StartSuperFileTransaction(),
															FileServices.ClearSuperFile('~thor_data400::in::flcrash::alpharetta::order_version_new', FALSE),
															FileServices.AddSuperFile('~thor_data400::in::flcrash::alpharetta::order_version_new','~thor_data400::in::ntl::tn_data_removal_ordervs_'+WORKUNIT),
															FileServices.FinishSuperFileTransaction()
														);
	
	
  //Init order input file currently no records only for verification of counts
  ds_initorder := DATASET(data_services.foreign_prod +'thor_data400::in::flcrash::alpharetta::int_order_new'
										     ,flaccidents.Layout_NtlAccidents_Alpharetta.int_order
										     ,CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"')))(ORDER_ID  != 'ORDER_ID');
	d_initorder := DISTRIBUTE(ds_initorder, HASH32(order_id));
	
	tn_initorder := JOIN(d_initorder, d_ddsOrder_tn,
													  TRIM(LEFT.order_id, LEFT, RIGHT) = TRIM(RIGHT.order_id, LEFT, RIGHT),
													  TRANSFORM(LEFT), LOCAL);
	
	//Result Input file
	ds_result := DATASET(data_services.foreign_prod + 'thor_data400::in::flcrash::alpharetta::result_new'
										   ,flaccidents.Layout_NtlAccidents_Alpharetta.result
										   ,CSV(TERMINATOR('\n'), SEPARATOR(',')))(RESULT_ID != 'RESULT_ID');                  
  d_result := DISTRIBUTE(ds_result, HASH32(order_id)):INDEPENDENT;
	
  tn_result := JOIN(d_result, d_ddsOrder_tn,
													TRIM(LEFT.order_id, LEFT, RIGHT) = TRIM(RIGHT.order_id, LEFT, RIGHT),
													TRANSFORM(LEFT), LOCAL);
									 
  //Result fiers fl data deletion
  tn_result_deletion := JOIN(d_result, d_ddsOrder_tn,
																	 TRIM(LEFT.order_id, LEFT, RIGHT) = TRIM(RIGHT.order_id, LEFT, RIGHT),
																	 TRANSFORM(LEFT), LEFT ONLY, LOCAL):INDEPENDENT;
					
	 out_result := OUTPUT(tn_result_deletion,,'~thor_data400::in::ntl::tn_data_removal_result_'+WORKUNIT,OVERWRITE, __COMPRESSED__,
					              CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"')));

	 result_all :=  SEQUENTIAL(
														 out_result,
														 FileServices.StartSuperFileTransaction(),
														 FileServices.ClearSuperFile('~thor_data400::in::flcrash::alpharetta::result_new', FALSE),
														 FileServices.AddSuperFile('~thor_data400::in::flcrash::alpharetta::result_new','~thor_data400::in::ntl::tn_data_removal_result_'+WORKUNIT),
														 FileServices.FinishSuperFileTransaction()
													  );
	
	//Incident input file
  ds_incident := DATASET(data_services.foreign_prod + 'thor_data400::in::flcrash::alpharetta::vehicle_incident_new'
										    ,flaccidents.Layout_NtlAccidents_Alpharetta.incident
										    ,CSV(TERMINATOR('\n'), SEPARATOR(',')));
	d_incident := DISTRIBUTE(ds_incident, HASH32(order_id)):INDEPENDENT;
	
  tn_incident := JOIN(d_incident, d_ddsOrder_tn,
													  TRIM(LEFT.order_id, LEFT, RIGHT) = TRIM(RIGHT.order_id, LEFT, RIGHT),
													  TRANSFORM(LEFT), LOCAL):INDEPENDENT;
									 
  //Incident TN data deletion
  tn_incident_deletion := JOIN(d_incident, d_ddsOrder_tn,
																	   TRIM(LEFT.order_id, LEFT, RIGHT) = TRIM(RIGHT.order_id, LEFT, RIGHT),
																	   TRANSFORM(LEFT), LEFT ONLY, LOCAL):INDEPENDENT;
									 
  out_inc := OUTPUT(tn_incident_deletion,,'~thor_data400::in::ntl::tn_data_removal_incident_'+WORKUNIT,OVERWRITE, __COMPRESSED__,
				            CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"')));

	incident_all :=  SEQUENTIAL(
															out_inc,
															FileServices.StartSuperFileTransaction(),
															FileServices.ClearSuperFile('~thor_data400::in::flcrash::alpharetta::vehicle_incident_new', FALSE),
															FileServices.AddSuperFile('~thor_data400::in::flcrash::alpharetta::vehicle_incident_new','~thor_data400::in::ntl::tn_data_removal_incident_'+WORKUNIT),
															FileServices.FinishSuperFileTransaction()
														);
		
	//Client input file
  ds_client := DATASET(data_services.foreign_prod + 'thor_data400::in::flcrash::alpharetta::client_new'
										  ,flaccidents.Layout_NtlAccidents_Alpharetta.client
										  ,CSV(TERMINATOR('\n'), SEPARATOR(',')))(ACCT_NBR != 'ACCT_NBR'); 
  d_client := DISTRIBUTE(ds_client,HASH32(acct_nbr,client_id)):INDEPENDENT;
	dd_ordervs := DEDUP(SORT(DISTRIBUTE(tn_ordervs(client_id <> ''),HASH32(acct_nbr,client_id))
	                         ,acct_nbr,client_id,(last_changed[7..10]+last_changed[1..2]+last_changed[4..5]),LOCAL)
								      ,acct_nbr,client_id,right,LOCAL):INDEPENDENT;
	
  tn_client := JOIN(d_client, dd_ordervs,
								          TRIM(LEFT.acct_nbr, LEFT, RIGHT) = TRIM(RIGHT.acct_nbr, LEFT, RIGHT) AND
								          TRIM(LEFT.client_id, LEFT, RIGHT) = TRIM(RIGHT.client_id, LEFT, RIGHT),
													TRANSFORM(LEFT), LOCAL):INDEPENDENT;
									 
  //Client TN data deletion
  tn_client_deletion := JOIN(d_client, dd_ordervs, 
	                                 TRIM(LEFT.acct_nbr, LEFT, RIGHT) = TRIM(RIGHT.acct_nbr, LEFT, RIGHT) AND
																	 TRIM(LEFT.client_id, LEFT, RIGHT) = TRIM(RIGHT.client_id, LEFT, RIGHT),
																	 TRANSFORM(LEFT), LEFT ONLY, LOCAL):INDEPENDENT;
									 	
	 out_client := OUTPUT(tn_client_deletion,,'~thor_data400::in::ntl::tn_data_removal_client_'+WORKUNIT,OVERWRITE, __COMPRESSED__,
					              CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"')));

	 client_all :=  SEQUENTIAL(
														 out_client,
														 FileServices.StartSuperFileTransaction(),
														 FileServices.ClearSuperFile('~thor_data400::in::flcrash::alpharetta::client_new', FALSE),
														 FileServices.AddSuperFile('~thor_data400::in::flcrash::alpharetta::client_new','~thor_data400::in::ntl::tn_data_removal_client_'+WORKUNIT),
														 FileServices.FinishSuperFileTransaction()
													  );
													
	//Vehicles input file
  vehicles_in := DATASET(data_services.foreign_prod +'thor_data400::in::flcrash::alpharetta::vehicle_new'
										    ,flaccidents.Layout_NtlAccidents_Alpharetta.payload
										    ,CSV(TERMINATOR('\n'), SEPARATOR(''), QUOTE('')));
										
	flaccidents.Layout_NtlAccidents_Alpharetta.vehicles parserecs(vehicles_in L) := TRANSFORM
	STRING unparsedRec := rEGEXREPLACE('"',REGEXREPLACE(',"',REGEXREPLACE('","',L.line+'|','|'),'|'),'');							

	SELF.VEHICLE_ID       		:= unparsedRec[1..stringlib.stringfind(unparsedRec,'|',1)-1];						
	SELF.VEHICLE_INCIDENT_ID	:= unparsedRec[stringlib.stringfind(unparsedRec,'|',1)+1..stringlib.stringfind(unparsedRec,'|',2)-1];						
	SELF.VEHICLE_NBR		:= unparsedRec[stringlib.stringfind(unparsedRec,'|',2)+1..stringlib.stringfind(unparsedRec,'|',3)-1];						
	SELF.VEHICLE_STATUS		:= unparsedRec[stringlib.stringfind(unparsedRec,'|',3)+1..stringlib.stringfind(unparsedRec,'|',4)-1];						
	SELF.vehVIN		:= unparsedRec[stringlib.stringfind(unparsedRec,'|',4)+1..stringlib.stringfind(unparsedRec,'|',5)-1];
	SELF.vehYEAR			:= unparsedRec[stringlib.stringfind(unparsedRec,'|',5)+1..stringlib.stringfind(unparsedRec,'|',6)-1];
	SELF.vehMAKE	:= unparsedRec[stringlib.stringfind(unparsedRec,'|',6)+1..stringlib.stringfind(unparsedRec,'|',7)-1];
	SELF.vehMODEL			:= unparsedRec[stringlib.stringfind(unparsedRec,'|',7)+1..stringlib.stringfind(unparsedRec,'|',8)-1];
	SELF.ODOMETER	:= unparsedRec[stringlib.stringfind(unparsedRec,'|',8)+1..stringlib.stringfind(unparsedRec,'|',9)-1];
	SELF.TAG	:= unparsedRec[stringlib.stringfind(unparsedRec,'|',9)+1..stringlib.stringfind(unparsedRec,'|',10)-1];
	SELF.TAG_STATE			:= unparsedRec[stringlib.stringfind(unparsedRec,'|',10)+1..stringlib.stringfind(unparsedRec,'|',11)-1];
	SELF.COLOR		:= unparsedRec[stringlib.stringfind(unparsedRec,'|',11)+1..stringlib.stringfind(unparsedRec,'|',12)-1];
	SELF.IMPACT_LOCATION	:= unparsedRec[stringlib.stringfind(unparsedRec,'|',12)+1..stringlib.stringfind(unparsedRec,'|',13)-1];
	SELF.POLICY_NBR		:= unparsedRec[stringlib.stringfind(unparsedRec,'|',13)+1..stringlib.stringfind(unparsedRec,'|',14)-1];
	SELF.POLICY_EXP_DATE			:= unparsedRec[stringlib.stringfind(unparsedRec,'|',14)+1..stringlib.stringfind(unparsedRec,'|',15)-1];
	SELF.CARRIER_ID		:= unparsedRec[stringlib.stringfind(unparsedRec,'|',15)+1..stringlib.stringfind(unparsedRec,'|',16)-1];
	SELF.OTHER_CARRIER		:= unparsedRec[stringlib.stringfind(unparsedRec,'|',16)+1..stringlib.stringfind(unparsedRec,'|',17)-1];
	SELF.COMMERCIAL_VIN    := unparsedRec[stringlib.stringfind(unparsedRec,'|',17)+1..stringlib.stringfind(unparsedRec,'|',18)-1];					
	SELF.CAR_FIRE	   		:= unparsedRec[stringlib.stringfind(unparsedRec,'|',18)+1..stringlib.stringfind(unparsedRec,'|',19)-1];						
	SELF.AIRBAGS_DEPLOY		:= unparsedRec[stringlib.stringfind(unparsedRec,'|',19)+1..stringlib.stringfind(unparsedRec,'|',20)-1];						
	SELF.CAR_TOWED		:= unparsedRec[stringlib.stringfind(unparsedRec,'|',20)+1..stringlib.stringfind(unparsedRec,'|',21)-1];						
	SELF.CAR_ROLLOVER		:= unparsedRec[stringlib.stringfind(unparsedRec,'|',21)+1..stringlib.stringfind(unparsedRec,'|',22)-1];
	SELF.DECODED_INFO			:= unparsedRec[stringlib.stringfind(unparsedRec,'|',22)+1..stringlib.stringfind(unparsedRec,'|',23)-1];
	SELF.LAST_CHANGED	:= unparsedRec[stringlib.stringfind(unparsedRec,'|',23)+1..stringlib.stringfind(unparsedRec,'|',24)-1];
	SELF.USERID			:= unparsedRec[stringlib.stringfind(unparsedRec,'|',24)+1..stringlib.stringfind(unparsedRec,'|',25)-1];
	SELF.DAMAGE	:= unparsedRec[stringlib.stringfind(unparsedRec,'|',25)+1..stringlib.stringfind(unparsedRec,'|',26)-1];
	SELF.POLK_VALIDATED_VIN	:= unparsedRec[stringlib.stringfind(unparsedRec,'|',26)+1..stringlib.stringfind(unparsedRec,'|',27)-1];
	SELF := L;
 END;
 ds_vehicles := PROJECT(vehicles_in(REGEXFIND('[0-9]',line)), parserecs(LEFT)); 
 d_vehicles := DISTRIBUTE(ds_vehicles, HASH32(vehicle_incident_id)):INDEPENDENT;
 dd_inc := DEDUP(SORT(DISTRIBUTE(tn_incident(vehicle_incident_id <> ''),HASH32(vehicle_incident_id))
	                    ,vehicle_incident_id,(last_changed[7..10]+ last_changed[1..2]+ last_changed[4..5]),LOCAL)
								 ,vehicle_incident_id, right,LOCAL):INDEPENDENT;
	
  tn_vehicles := JOIN(d_vehicles, dd_inc,
								      TRIM(LEFT.vehicle_incident_id, LEFT, RIGHT) = TRIM(RIGHT.vehicle_incident_id, LEFT, RIGHT),
										  TRANSFORM(LEFT), LOCAL):INDEPENDENT;
									 
  //Vehicles TN data deletion
  tn_vehicles_deletion := JOIN(d_vehicles, dd_inc,
	                             TRIM(LEFT.vehicle_incident_id, LEFT, RIGHT) = TRIM(RIGHT.vehicle_incident_id, LEFT, RIGHT),
													     TRANSFORM(LEFT), LEFT ONLY, LOCAL):INDEPENDENT;
									 	
	out_veh := OUTPUT(tn_vehicles_deletion,,'~thor_data400::in::ntl::tn_data_removal_vehicles_'+WORKUNIT,overwrite, __compressed__,
					          csv(terminator('\n'), separator('","'),quote(''),maxlength(60000)));

	vehicles_all :=  SEQUENTIAL(
															out_veh,
															FileServices.StartSuperFileTransaction(),
															FileServices.ClearSuperFile('~thor_data400::in::flcrash::alpharetta::vehicle_new', FALSE),
															FileServices.AddSuperFile('~thor_data400::in::flcrash::alpharetta::vehicle_new','~thor_data400::in::ntl::tn_data_removal_vehicles_'+WORKUNIT),
															FileServices.FinishSuperFileTransaction()
														);
														
	//Party input file
  ds_party := DATASET(data_services.foreign_prod + 'thor_data400::in::flcrash::alpharetta::vehicle_party_new'
										 ,flaccidents.Layout_NtlAccidents_Alpharetta.party
										 ,CSV(TERMINATOR('\n'), SEPARATOR(',')))(PARTY_ID != 'PARTY_ID');
	d_party := DISTRIBUTE(ds_party, HASH32(vehicle_incident_id,vehicle_id)):INDEPENDENT;
	dd_veh_vehid := DEDUP(SORT(DISTRIBUTE(tn_vehicles(TRIM(vehicle_incident_id, LEFT, RIGHT)<> ''),HASH32(vehicle_incident_id,vehicle_id)), 
	                           vehicle_id ,-(last_changed[7..10]+last_changed[1..2]+last_changed[4..5]), LOCAL)
												,vehicle_id, LOCAL):INDEPENDENT;
	
  tn_party := JOIN(d_party, dd_veh_vehid,
								   TRIM(LEFT.vehicle_incident_id, LEFT, RIGHT) = TRIM(RIGHT.vehicle_incident_id, LEFT, RIGHT) AND
								   TRIM(LEFT.vehicle_id, LEFT, RIGHT) = TRIM(RIGHT.vehicle_id, LEFT, RIGHT),
								   TRANSFORM(LEFT), LOCAL):INDEPENDENT;
									 
  //Party TN data deletion
  tn_party_deletion := JOIN(d_party, dd_veh_vehid,
	                          TRIM(LEFT.vehicle_incident_id, LEFT, RIGHT) = TRIM(RIGHT.vehicle_incident_id, LEFT, RIGHT) AND
								            TRIM(LEFT.vehicle_id, LEFT, RIGHT) = TRIM(RIGHT.vehicle_id, LEFT, RIGHT),
								            TRANSFORM(LEFT), LEFT ONLY, LOCAL):INDEPENDENT;
									 	
	 out_party := OUTPUT(tn_party_deletion,,'~thor_data400::in::ntl::tn_data_removal_party_'+WORKUNIT,OVERWRITE, __COMPRESSED__,
					             CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"')));

	 party_all :=  SEQUENTIAL(
														out_party,
														FileServices.StartSuperFileTransaction(),
														FileServices.ClearSuperFile('~thor_data400::in::flcrash::alpharetta::vehicle_party_new', FALSE),
														FileServices.AddSuperFile('~thor_data400::in::flcrash::alpharetta::vehicle_party_new','~thor_data400::in::ntl::tn_data_removal_party_'+WORKUNIT),
														FileServices.FinishSuperFileTransaction()
													);
													
	//Calculating stats
  ds_pre_delete := DATASET([{'PRE_DELETE', COUNT(ddsOrder), COUNT(ds_ordervs), COUNT(tn_ordervs), 0, COUNT(ds_initorder), COUNT(tn_initorder), COUNT(ds_result), COUNT(tn_result), 0, COUNT(ds_incident), COUNT(tn_incident), 0, COUNT(ds_client), COUNT(tn_client), 0, COUNT(ds_vehicles), COUNT(tn_vehicles), 0, COUNT(ds_party), COUNT(tn_party), 0}], lay_tn_removal_stats);
	ds_post_delete := DATASET([{'POST_DELETE', ds_pre_delete[1].tn_orderids, ds_pre_delete[1].total_ordervs, ds_pre_delete[1].total_tn_ordervs, COUNT(tn_ordervs_deletion),ds_pre_delete[1].total_initorder, ds_pre_delete[1].total_tn_initorder, ds_pre_delete[1].total_result, ds_pre_delete[1].total_tn_result, COUNT(tn_result_deletion), ds_pre_delete[1].total_incidents, ds_pre_delete[1].total_tn_incidents, COUNT(tn_incident_deletion), ds_pre_delete[1].total_client, ds_pre_delete[1].total_tn_client, COUNT(tn_client_deletion), ds_pre_delete[1].total_vehicles, ds_pre_delete[1].total_tn_vehicles, COUNT(tn_vehicles_deletion), ds_pre_delete[1].total_party, ds_pre_delete[1].total_tn_party, COUNT(tn_party_deletion)}], lay_tn_removal_stats);
  ds_fl_removal_stats := ds_pre_delete & ds_post_delete;
	
	delete_tn_data := SEQUENTIAL(
															 OUTPUT(ds_pre_delete,,NAMED('PRE_DELETE')),
															 party_all,
															 vehicles_all,
															 client_all,
															 incident_all,
															 result_all,
															 ordervs_all,
															 OUTPUT(ds_post_delete,,NAMED('POST_DELETE')),
															 OUTPUT(ds_fl_removal_stats,,NAMED('tn_REMOVAL_STATS'))
															);
	 
	RETURN delete_tn_data;

END;