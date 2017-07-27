Blank_IDs(infile, outfile) := macro 

	outfile := project(infile,
											transform({inquiry_acclogs.layout.common, string source}, 
													fixTime := Inquiry_AccLogs.fncleanfunctions.tTimeAdded(left.search_info.datetime);
											self.search_info.datetime		:= fixTime;
											self.search_info.function_description	:= Inquiry_AccLogs.fncleanfunctions.fnCleanUp(left.search_info.function_description);
											self.mbs.company_id 				:= '';
											self.mbs.global_company_id 	:= '';
											self := left));
endmacro;


base_files :=	distribute((fnAddSource(inquiry_acclogs.File_FCRA_Riskwise_Logs_Common, 'RISKWISE') + 
													fnAddSource(Inquiry_AccLogs.File_FCRA_BankoBatch_Logs_Common, 'BANKO BATCH') +
													fnAddSource(Inquiry_AccLogs.File_FCRA_Batch_Logs_Common, 'BATCH') + 
													fnAddSource(Inquiry_AccLogs.File_FCRA_ProdR3_Logs_Common, 'PROD R3') + 
													fnAddSource(Inquiry_AccLogs.File_FCRA_Banko_Logs_Common, 'BANKO')),
												hash(source, search_info.transaction_id,search_info.login_history_id,search_info.datetime,search_info.sequence_number,search_info.function_description));
																 
Blank_IDs(base_files, Prod_Weekly_Files)

Correct_Function_Descriptions := 
						join(Prod_Weekly_Files, dedup(File_Function_Description_Rollups,rollup_string,all),
									regexreplace('[^A-Z0-9]', left.search_info.function_description, '') = right.rollup_string,
									transform({recordof(Prod_Weekly_Files)},
										self.search_info.function_description := if(right.rollup_string <> '', right.selected_version, left.search_info.function_description);
										self := left), lookup, left outer);


remove_dupes := dedup(sort(Correct_Function_Descriptions, 
														source, search_info.transaction_id,search_info.login_history_id,search_info.datetime,search_info.sequence_number,search_info.function_description, local), 
														source, search_info.transaction_id,search_info.login_history_id,search_info.datetime,search_info.sequence_number,search_info.function_description, local) 
														: persist('~persist::fcra::acclogs_common_sourced');

export File_FCRA_Inquiry_BaseSourced :=  remove_dupes;
