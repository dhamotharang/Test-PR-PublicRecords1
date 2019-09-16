import ut,data_services;

export File_Inquiry_BaseSourced := module

shared Blank_IDs(infile, outfile) := macro 

	outfile := project(infile,
											transform(inquiry_acclogs.layout.Common_ThorAdditions_non_fcra, 
													fixTime := Inquiry_AccLogs.fncleanfunctions.tTimeAdded(left.search_info.datetime);
											self.search_info.datetime				:= fixTime;
											self.search_info.function_description	:= Inquiry_AccLogs.fncleanfunctions.fnCleanUp(left.search_info.function_description);
											self.mbs.company_id 				:= '';
											self.mbs.global_company_id 	:= '';
											self.bus_intel.sub_market := if (left.bus_intel.sub_market='CARD','CARDS',left.bus_intel.sub_market);
											self := left));
endmacro;

USABase := Inquiry_AccLogs.fn_NonFCRABaseUSAfilter();

Updates_Only :=	USABase
								(~inquiry_acclogs.fnTranslations.is_SubMarketFilter(allow_flags.allowflags) and
								 ~inquiry_acclogs.fnTranslations.is_IndustryFilter(allow_flags.allowflags) and
								 ~inquiry_acclogs.fnTranslations.is_VerticalFilter(allow_flags.allowflags) and
								 ~inquiry_acclogs.fnTranslations.is_Disable_Observation(allow_flags.allowflags) and
								 ~inquiry_acclogs.fnTranslations.is_Internal(allow_flags.allowflags) and
								 ~inquiry_acclogs.fnTranslations.is_AdditionalHealthcare(allow_flags.allowflags));

Blank_IDs(Updates_Only, Updates_Only_Blank);

Prod_Weekly_Files :=  distribute(Updates_Only_Blank, 
												hash(source, search_info.product_code,search_info.transaction_id,search_info.login_history_id,search_info.datetime,search_info.sequence_number,search_info.function_description));

Correct_Function_Descriptions := 
						join(Prod_Weekly_Files, dedup(File_Function_Description_Rollups,rollup_string,all),
									regexreplace('[^A-Z0-9]', left.search_info.function_description, '') = right.rollup_string,
									transform({recordof(Prod_Weekly_Files)},
										self.search_info.function_description := if(right.rollup_string <> '', right.selected_version, left.search_info.function_description);
										self := left), lookup, left outer,local);
									
export updates := Inquiry_AccLogs.fn_cleanup_spec_char(dedup(sort(Correct_Function_Descriptions, 
																 source, search_info.product_code, search_info.transaction_id, search_info.login_history_id, search_info.datetime, search_info.sequence_number, search_info.function_description, local), 
																 source, search_info.product_code, search_info.transaction_id, search_info.login_history_id, search_info.datetime, search_info.sequence_number, search_info.function_description, local))
																 ;
 

export history :=  dataset(data_services.foreign_prod+'thor_data400::out::inquiry_tracking::weekly_historical',inquiry_acclogs.Layout.Common_ThorAdditions_non_FCRA,thor);




end;
																