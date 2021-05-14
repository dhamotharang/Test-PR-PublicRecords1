IMPORT ut, Data_Services, flaccidents; 

EXPORT fn_AntiochPD_CRU_Removal() := FUNCTION
 
  order_id_list := ['75369995'];
  ds_ordervs := DATASET(data_services.foreign_prod +'thor_data400::in::flcrash::alpharetta::order_version_new'
						           ,flaccidents.Layout_NtlAccidents_Alpharetta.order_vs
						           ,CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"')))(ORDER_ID  != 'ORDER_ID');

 ordervs_delete := ds_ordervs(order_id IN order_id_list AND Sequence_nbr = '2'):INDEPENDENT; 
 ordervs_after_deletion := ds_ordervs(~(order_id IN order_id_list AND Sequence_nbr = '2')):INDEPENDENT; 
 out_ordervs := OUTPUT(ordervs_after_deletion,,'~thor_data400::in::ntl::AntiochPD_removal_ordervs_'+ WORKUNIT, OVERWRITE, __COMPRESSED__,
					               CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"')));
												 
 ordervs_all :=  SEQUENTIAL(
														 OUTPUT(COUNT(ds_ordervs), NAMED('cnt_ordervs_prod')),
														 OUTPUT(ordervs_delete, NAMED('ordervs_delete')),
                             OUTPUT(COUNT(ordervs_delete), NAMED('cnt_ordervs_delete')),
                             OUTPUT(COUNT(ordervs_after_deletion), NAMED('cnt_ordervs_after_delete')),
														 out_ordervs,
														 FileServices.StartSuperFileTransaction(),
														 FileServices.ClearSuperFile('~thor_data400::in::flcrash::alpharetta::order_version_new', FALSE),
														 FileServices.AddSuperFile('~thor_data400::in::flcrash::alpharetta::order_version_new','~thor_data400::in::ntl::AntiochPD_removal_ordervs_'+WORKUNIT),
														 FileServices.FinishSuperFileTransaction()
														);
	
 //Result Input file
 ds_result := DATASET(data_services.foreign_prod + 'thor_data400::in::flcrash::alpharetta::result_new'
										   ,flaccidents.Layout_NtlAccidents_Alpharetta.result
										   ,CSV(TERMINATOR('\n'), SEPARATOR(',')))(RESULT_ID != 'RESULT_ID');                  
  
 result_delete := ds_result(order_id IN order_id_list AND Sequence_nbr = '2'):INDEPENDENT; 
 result_after_deletion := ds_result(~(order_id IN order_id_list AND Sequence_nbr = '2')):INDEPENDENT; 
 out_result := OUTPUT(result_after_deletion,,'~thor_data400::in::ntl::AntiochPD_removal_result_'+ WORKUNIT, OVERWRITE, __COMPRESSED__,
					              CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"')));

 result_all :=  SEQUENTIAL(
													  OUTPUT(COUNT(ds_result), NAMED('cnt_result_prod')),
													  OUTPUT(result_delete, NAMED('result_delete')),
                            OUTPUT(COUNT(result_delete), NAMED('cnt_result_delete')),
                            OUTPUT(COUNT(result_after_deletion), NAMED('cnt_result_after_deletion')),
													  out_result,
													  FileServices.StartSuperFileTransaction(),
													  FileServices.ClearSuperFile('~thor_data400::in::flcrash::alpharetta::result_new', FALSE),
													  FileServices.AddSuperFile('~thor_data400::in::flcrash::alpharetta::result_new','~thor_data400::in::ntl::AntiochPD_removal_result_' + WORKUNIT),
													  FileServices.FinishSuperFileTransaction()
													  );
														
	delete_ntl_data := SEQUENTIAL(ordervs_all,
	                              result_all);
	 
	RETURN delete_ntl_data;

END;

// Found this order_id only in order version and result cru files(W20210209-132813).
// Request: https://jira.rsi.lexisnexis.com/browse/INSRT-2780