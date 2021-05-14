IMPORT ut, Data_Services, flaccidents; 

EXPORT fn_individual_orderid_removal := FUNCTION

 //OrderVersion input file 
 ds_ordervs := DATASET(data_services.foreign_prod +'thor_data400::in::flcrash::alpharetta::order_version_new'
						           ,flaccidents.Layout_NtlAccidents_Alpharetta.order_vs
						           ,CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"')))(ORDER_ID  != 'ORDER_ID');

 ordervs_delete := ds_ordervs(order_id IN order_list); 
 ordervs_after_deletion := ds_ordervs(order_id NOT IN order_list); 
 out_ordervs := OUTPUT(ordervs_after_deletion,,'~thor_data400::in::ntl::data_removal_ordervs_'+WORKUNIT,OVERWRITE, __COMPRESSED__,
					               CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"')));
												 
 ordervs_all :=  SEQUENTIAL(
														 OUTPUT(COUNT(ds_ordervs), NAMED('cnt_ordervs_prod')),
														 OUTPUT(ordervs_delete, NAMED('ordervs_delete')),
                             OUTPUT(COUNT(ordervs_delete), NAMED('cnt_ordervs_delete')),
                             OUTPUT(COUNT(ordervs_after_deletion), NAMED('cnt_ordervs_after_delete')),
														 out_ordervs,
														 FileServices.StartSuperFileTransaction(),
														 FileServices.ClearSuperFile('~thor_data400::in::flcrash::alpharetta::order_version_new', FALSE),
														 FileServices.AddSuperFile('~thor_data400::in::flcrash::alpharetta::order_version_new','~thor_data400::in::ntl::data_removal_ordervs_'+WORKUNIT),
														 FileServices.FinishSuperFileTransaction()
														);
	
 //Result Input file
 ds_result := DATASET(data_services.foreign_prod + 'thor_data400::in::flcrash::alpharetta::result_new'
										   ,flaccidents.Layout_NtlAccidents_Alpharetta.result
										   ,CSV(TERMINATOR('\n'), SEPARATOR(',')))(RESULT_ID != 'RESULT_ID');                  
  
 result_delete := ds_result(order_id IN order_list); 
 result_after_deletion := ds_result(order_id NOT IN order_list); 
 out_result := OUTPUT(result_after_deletion,,'~thor_data400::in::ntl::data_removal_result_'+WORKUNIT,OVERWRITE, __COMPRESSED__,
					              CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"')));

 result_all :=  SEQUENTIAL(
													  OUTPUT(COUNT(ds_result), NAMED('cnt_result_prod')),
													  OUTPUT(result_delete, NAMED('result_delete')),
                            OUTPUT(COUNT(result_delete), NAMED('cnt_result_delete')),
                            OUTPUT(COUNT(result_after_deletion), NAMED('cnt_result_after_deletion')),
													  out_result,
													  FileServices.StartSuperFileTransaction(),
													  FileServices.ClearSuperFile('~thor_data400::in::flcrash::alpharetta::result_new', FALSE),
													  FileServices.AddSuperFile('~thor_data400::in::flcrash::alpharetta::result_new','~thor_data400::in::ntl::data_removal_result_'+WORKUNIT),
													  FileServices.FinishSuperFileTransaction()
													  );
														

	//Incident input file
  ds_incident := DATASET(data_services.foreign_prod + 'thor_data400::in::flcrash::alpharetta::vehicle_incident_new'
										    ,flaccidents.Layout_NtlAccidents_Alpharetta.incident
										    ,CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"')));
	
  incident_delete := ds_incident(order_id IN order_list); 
  incident_after_deletion := ds_incident(order_id NOT IN order_list); 							 
  out_inc := OUTPUT(incident_after_deletion,,'~thor_data400::in::ntl::data_removal_incident_'+WORKUNIT,OVERWRITE, __COMPRESSED__,
				            CSV(TERMINATOR('\n'), SEPARATOR(',')));

	incident_all :=  SEQUENTIAL(
															OUTPUT(COUNT(ds_incident), NAMED('cnt_incident_prod')),
															OUTPUT(incident_delete, NAMED('incident_delete')),
                              OUTPUT(COUNT(incident_delete), NAMED('cnt_incident_delete')),
                              OUTPUT(COUNT(incident_after_deletion), NAMED('cnt_incident_after_deletion')),
															out_inc,
															FileServices.StartSuperFileTransaction(),
															FileServices.ClearSuperFile('~thor_data400::in::flcrash::alpharetta::vehicle_incident_new', FALSE),
															FileServices.AddSuperFile('~thor_data400::in::flcrash::alpharetta::vehicle_incident_new','~thor_data400::in::ntl::data_removal_incident_'+WORKUNIT),
															FileServices.FinishSuperFileTransaction()
														);

	delete_ntl_data := SEQUENTIAL(
															  incident_all,
															  result_all,
															  ordervs_all
															 );
	 
	RETURN delete_ntl_data;

END;