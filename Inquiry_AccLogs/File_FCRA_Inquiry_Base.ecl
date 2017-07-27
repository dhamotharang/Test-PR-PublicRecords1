Base_Files := distribute((inquiry_acclogs.File_FCRA_Riskwise_Logs_Common + 
																	Inquiry_AccLogs.File_FCRA_BankoBatch_Logs_Common +
																	Inquiry_AccLogs.File_FCRA_Batch_Logs_Common + 
																	Inquiry_AccLogs.File_FCRA_ProdR3_Logs_Common + 
																	Inquiry_AccLogs.File_FCRA_Banko_Logs_Common),
																hash(search_info.transaction_id, search_info.login_history_id, search_info.datetime[1..8], person_q.linkid, person_q.fname, 
																 person_q.lname, bus_q.cname, bususer_q.fname, bususer_q.lname, person_q.address, bus_q.address, bususer_q.address));
																 
upCaseField := project(base_files, transform(recordof(base_files), 
											self.search_info.function_description := stringlib.stringtouppercase(left.search_info.function_description), 
											self := left));

export File_FCRA_Inquiry_Base := dedup(sort(upCaseField, record, local), record, local);