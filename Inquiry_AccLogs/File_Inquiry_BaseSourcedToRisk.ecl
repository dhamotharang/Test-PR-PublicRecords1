import ut,data_services, inql_v2, did_add, dops;

export File_Inquiry_BaseSourcedToRisk := module

shared _Blank_IDs(infile, outfile) := macro 

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

daily_base_batch 		:= dataset(Data_Services.foreign_prod + 'uspr::inql::nonfcra::base::daily::building_keys', INQL_v2.Layouts.Common_ThorAdditions, thor)
											(source in ['BATCH','BATCHR3'] and version > '20190123');
daily_base_nobatch 	:= dataset(Data_Services.foreign_prod + 'uspr::inql::nonfcra::base::daily::building_keys', INQL_v2.Layouts.Common_ThorAdditions, thor)
                      (source not in ['BATCH','BATCHR3'] );										
daily_base  				:= daily_base_batch + daily_base_nobatch;

USABase 						:= daily_base(COUNTRY='UNITED STATES');

Updates_Only :=	USABase
								(~inquiry_acclogs.fnTranslations.is_SubMarketFilter(allow_flags.allowflags) and
								 ~inquiry_acclogs.fnTranslations.is_IndustryFilter(allow_flags.allowflags) and
								 ~inquiry_acclogs.fnTranslations.is_VerticalFilter(allow_flags.allowflags) and
								 ~inquiry_acclogs.fnTranslations.is_Disable_Observation(allow_flags.allowflags) and
								 ~inquiry_acclogs.fnTranslations.is_Internal(allow_flags.allowflags) and
								 ~inquiry_acclogs.fnTranslations.is_AdditionalHealthcare(allow_flags.allowflags));

_Blank_IDs(Updates_Only, Updates_Only_Blank);

Prod_Weekly_Files :=  distribute(Updates_Only_Blank, 
												hash(source, search_info.product_code,search_info.transaction_id,search_info.login_history_id,search_info.datetime,search_info.sequence_number,search_info.function_description));

Correct_Function_Descriptions := 
						join(Prod_Weekly_Files, dedup(File_Function_Description_Rollups,rollup_string,all),
									regexreplace('[^A-Z0-9]', left.search_info.function_description, '') = right.rollup_string,
									transform({recordof(Prod_Weekly_Files)},
										self.search_info.function_description := if(right.rollup_string <> '', right.selected_version, left.search_info.function_description);
										self := left), lookup, left outer,local);

    updates20190123 := Inquiry_AccLogs.fn_cleanup_spec_char(dedup(sort(Correct_Function_Descriptions, 
																 source, search_info.product_code, search_info.transaction_id, search_info.login_history_id, search_info.datetime, search_info.sequence_number, search_info.function_description, local), 
																 source, search_info.product_code, search_info.transaction_id, search_info.login_history_id, search_info.datetime, search_info.sequence_number, search_info.function_description, local))
																 ;

		VP:=dops.Getbuildversion('InquiryTableKeys','B','N','P','prod');//did_add.get_EnvVariable('inquiry_build_version','http://certstagingvip.hpcc.risk.regn.net:9876')[1..8];
		
		father_sf_empty := count(dataset('~thor_data400::out::inquiry_tracking::weekly_historical_father',inquiry_acclogs.Layout.Common_ThorAdditions_non_FCRA,thor, opt)) = 0;

		sc 			:= nothor(fileservices.superfilecontents('~thor_data400::out::inquiry_tracking::weekly_historical')[1].name);
		findex 	:= stringlib.stringfind(sc, '::', 6)+2;
		lindex 	:= stringlib.stringfind(sc, '_', 3)-1;
		Vk			:= sc[findex..lindex];

		sc_father				:= nothor(fileservices.superfilecontents('~thor_data400::out::inquiry_tracking::weekly_historical_father')[1].name);
		findex_father 	:= stringlib.stringfind(sc_father, '::', 6)+2;
		lindex_father 	:= stringlib.stringfind(sc_father, '_', 3)-1;
		vk_father 			:= sc_father[findex_father..lindex_father];

		FileHistoryVersion := if(vk=vp or father_sf_empty , vk, vk_father);
 
    export updates := if(FileHistoryVersion = '20190123a',
																				updates20190123,
																				inquiry_acclogs.File_Inquiry_BaseSourced.updates
																				);																 
end; 																 