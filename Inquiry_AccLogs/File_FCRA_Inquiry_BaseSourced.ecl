/*2017-03-30T05:36:16Z (Fernando Incarnacao)
modify vertical filter 
*/
/*2014-05-09T22:37:47Z (Wendy Ma)
additional healthcare account detection
*/
import ut, data_services, inql_v2;
export File_FCRA_Inquiry_BaseSourced :=  module

Blank_IDs(infile, outfile) := macro 

	outfile := project(infile,
											transform(inquiry_acclogs.layout.Common_ThorAdditions_FCRA,
													fixTime := Inquiry_AccLogs.fncleanfunctions.tTimeAdded(left.search_info.datetime);
											self.search_info.datetime		:= fixTime;
											self.search_info.function_description	:= Inquiry_AccLogs.fncleanfunctions.fnCleanUp(left.search_info.function_description);
											self.mbs.company_id 				:= '';
											self.mbs.global_company_id 	:= '';
											self := left));
endmacro;

v2_base_files := dataset(Data_Services.foreign_prod + 'uspr::inql::fcra::base::weekly::building_keys', INQL_v2.Layouts.Common_ThorAdditions, thor);

base_files :=	distribute(v2_base_files
													// (fnAddSource(inquiry_acclogs.File_FCRA_Riskwise_Logs_Common, 'RISKWISE') +
													// fnAddSource(inquiry_acclogs.File_FCRA_Accurint_Logs_Common, 'COLLECTION') + 
												  // fnAddSource(Inquiry_AccLogs.File_FCRA_BankoBatch_Logs_Common, 'BANKO BATCH') +
													// fnAddSource(Inquiry_AccLogs.File_FCRA_Batch_Logs_Common, 'BATCH') + 
													// fnAddSource(Inquiry_AccLogs.File_FCRA_ProdR3_Logs_Common, 'PROD R3') + 
													// fnAddSource(Inquiry_AccLogs.File_FCRA_Banko_Logs_Common, 'BANKO'))
														// (bus_intel.vertical not in inquiry_acclogs.fnCleanFunctions.filtercds and
														// ~regexfind(inquiry_acclogs.fnCleanFunctions.FilterCds_extra,bus_intel.vertical) and  
														 // bus_intel.industry not in inquiry_acclogs.fnCleanFunctions.industry_filtercds and
														(~inquiry_acclogs.fnTranslations.is_SubMarketFilter(allow_flags.allowflags) and
														 ~inquiry_acclogs.fnTranslations.is_IndustryFilter(allow_flags.allowflags) and
														 ~inquiry_acclogs.fnTranslations.is_VerticalFilter(allow_flags.allowflags) and
														 ~inquiry_acclogs.fnTranslations.is_Disable_Observation(allow_flags.allowflags) and
														 ~inquiry_acclogs.fnTranslations.is_Internal(allow_flags.allowflags) and
												     ~inquiry_acclogs.fnTranslations.is_AdditionalHealthcare(allow_flags.allowflags)),
												hash(source, search_info.transaction_id,search_info.login_history_id,search_info.datetime,search_info.sequence_number,search_info.function_description));
																 
Blank_IDs(base_files, Prod_Weekly_Files)

Correct_Function_Descriptions := 
						join(Prod_Weekly_Files, dedup(File_Function_Description_Rollups,rollup_string,all),
									regexreplace('[^A-Z0-9]', left.search_info.function_description, '') = right.rollup_string,
									//transform({recordof(Prod_Weekly_Files)},
									  transform({recordof(inquiry_acclogs.Layout.Common_ThorAdditions_FCRA)},
										self.search_info.function_description := if(right.rollup_string <> '', right.selected_version, left.search_info.function_description);
										self := left), lookup, left outer);

//project into common_thoradditions because fnMapBaseAppends expects that layout
//and it's a shared function between nonFCRA & FCRA
shared remove_dupes := project(dedup(sort(Correct_Function_Descriptions, 
														source, search_info.transaction_id,search_info.login_history_id,search_info.datetime,search_info.sequence_number,search_info.function_description,person_q.ssn, local), 
														source, search_info.transaction_id,search_info.login_history_id,search_info.datetime,search_info.sequence_number,search_info.function_description,person_q.ssn, local) 
														,inquiry_acclogs.layout.common_thoradditions);

string history_logs_version := ut.GetDate:INDEPENDENT;
create_append_file := fnMapBaseAppends(remove_dupes, true, history_logs_version ).buildFile;		

export create_appends := create_append_file;

reappend_ids := fnMapBaseAppends(remove_dupes, true).AppendNewIDs_FCRA;

export build_file := PROJECT(reappend_ids, TRANSFORM(Inquiry_Acclogs.Layout.Common_ThorAdditions_FCRA,
															self.persistent_record_id := HASH64(LEFT.search_info.transaction_id, 
																			LEFT.search_info.sequence_number, 
																			LEFT.search_info.Login_History_ID,
																			LEFT.search_info.DateTime,
																			LEFT.search_info.Transaction_Type,
																			LEFT.search_info.Function_Description);
																			self.bus_intel.sub_market := if (left.bus_intel.sub_market='CARD','CARDS',left.bus_intel.sub_market);
															self := left));
															
export file := dataset('~persist::inquiry::fcra_base', inquiry_acclogs.layout.Common_ThorAdditions_FCRA, thor);

end;