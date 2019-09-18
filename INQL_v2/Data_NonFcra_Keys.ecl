IMPORT Inql_V2, Doxie, ut, data_services, inquiry_acclogs;

EXPORT Data_NonFcra_Keys (boolean isUpdate = true) := Module

 shared Blank_IDs(infile, outfile) := macro 

	outfile := project(infile,
        transform(INQL_v2.layouts.Common_ThorAdditions_non_fcra, 
         fixTime := INQL_v2.fncleanfunctions.tTimeAdded(left.search_info.datetime);
         self.search_info.datetime             := fixTime;
         self.search_info.function_description := INQL_v2.fncleanfunctions.fnCleanUp(left.search_info.function_description);
         self.mbs.company_id                   := '';
         self.mbs.global_company_id            := '';
         self.bus_intel.sub_market             := if (left.bus_intel.sub_market='CARD','CARDS',left.bus_intel.sub_market);
         self := left));
 endmacro;

 base_update := INQL_v2.Files(false, true).INQL_base.built; //Daily NonFcra Base File

 base_update_filtered_mbs :=	base_update (
																						~INQL_v2.fnTranslations.is_SubMarketFilter(allow_flags.allowflags) and
																						~INQL_v2.fnTranslations.is_IndustryFilter(allow_flags.allowflags) and
																						~INQL_v2.fnTranslations.is_VerticalFilter(allow_flags.allowflags) and
																						~INQL_v2.fnTranslations.is_Disable_Observation(allow_flags.allowflags) and
																						~INQL_v2.fnTranslations.is_Internal(allow_flags.allowflags) and
																						~INQL_v2.fnTranslations.is_AdditionalHealthcare(allow_flags.allowflags) and
																						 country = 'UNITED STATES'
																					 );

 Blank_IDs(base_update_filtered_mbs, base_update_blanked);
 
 base_update_distributed :=  distribute(base_update_blanked, hash(source
																																, search_info.product_code
																																, search_info.transaction_id
																																, search_info.login_history_id
																																, search_info.datetime
																																, search_info.sequence_number
																																, search_info.function_description
																																  )
																				);

 base_update_func_applied := 	join( base_update_distributed, dedup(File_Function_Description_Rollups,rollup_string,all),
																		regexreplace('[^A-Z0-9]', left.search_info.function_description, '') = right.rollup_string
																	,	transform({recordof(base_update_distributed)}
																						,	self.search_info.function_description := if(right.rollup_string <> ''
																																												, right.selected_version
																																												, left.search_info.function_description);
																							self := left)
																	, lookup, left outer,local);
									
 base_update_cleaned  := INQL_v2.fn_cleanup_spec_char(dedup(sort(base_update_func_applied, 
																																	source
																																, search_info.product_code
																																, search_info.transaction_id
																																, search_info.login_history_id
																																, search_info.datetime
																																, search_info.sequence_number
																																, search_info.function_description, local)
																													, source
																													, search_info.product_code
																													, search_info.transaction_id
																													, search_info.login_history_id
																													, search_info.datetime
																													, search_info.sequence_number
																													, search_info.function_description, local));
																													
shared base_update_filtered  := base_update_cleaned (bus_intel.industry <> '' 
																								and StringLib.StringToUpperCase(trim(search_info.function_description)) not in 
																																			['MODELS.ITA_BATCH_SERVICE', 'RISKWISE IP SEARCH (NA99)'] 
																								and	stringlib.stringfind(search_info.function_description, 'INTERNATIONAL', 1) = 0 
																								and stringlib.stringfind(search_info.function_description, 'INTL', 1) = 0);
 
 shared base_update_icommon         	:= project(base_update_filtered, INQL_v2.Layouts.Common_indexes); 
  
 shared base_history  								:= INQL_v2.Files(false, false).INQL_Base_History_Appended.built;  
 shared base_history_icommon 		  		:= project(base_history, INQL_v2.Layouts.Common_indexes); 
 
 shared base     											:= if(isUpdate, base_update_filtered, base_history); 
 export base_icommon     							:= if(isUpdate, base_update_icommon, base_history_icommon); 
 
 thor_history_keys_version       			:= INQL_v2._Versions.thor_nonfcra_keys;
 roxie_history_keys_version      			:= INQL_v2._Versions.dops_nonfcra_keys_CertQA; 
 Legacy_Base_History_Appended         := dataset('~thor_data400::out::inquiry_tracking::weekly_historical',inquiry_acclogs.Layout.Common_ThorAdditions_non_FCRA,thor);
 Legacy_Base_History_Appended_Father  := dataset('~thor_data400::out::inquiry_tracking::weekly_historical_father',inquiry_acclogs.Layout.Common_ThorAdditions_non_FCRA,thor);
 roxie_base_history           	  		:= if(thor_history_keys_version = roxie_history_keys_version
																					  ,Legacy_Base_History_Appended//INQL_v2.Files(false, false).INQL_Base_History_Appended.built			
																					  ,Legacy_Base_History_Appended_Father//INQL_v2.Files(false, false).INQL_Base_History_Appended.father
																						);
 base_update_legacy                   := project(base_update_filtered, inquiry_acclogs.layout.Common_ThorAdditions_non_fcra);		
 export base_full											:= roxie_base_history + base_update_legacy;//base_update_filtered; 
               
 
 iDID_filtered	:= base (person_q.Appended_ADL > 0);
 export iDID := INQL_v2.FN_Append_SBA_DID(iDID_filtered);
 
 export iSSN := base_icommon ((unsigned)person_q.ssn > 0);
 
 export iAddress := project(base_icommon 
														,transform(layouts.common_indexes_address,
																				self.zip := map((unsigned)left.person_q.zip > 0 => left.person_q.zip, left.person_q.zip5),
																				self := left))
										        (((unsigned)person_q.zip > 0 or (unsigned)person_q.zip5 > 0) and trim(person_q.prim_name)<>'');

 email_filtered := base_icommon (trim(person_q.email_address) <> '' and (unsigned)person_q.appended_adl <> 0);
 export iEMAIL  := project(email_filtered, transform(Inql_v2.Layouts.i_nonfcra_email, 
																								self.person_q.email_address := stringlib.stringtouppercase(left.person_q.email_address), 
																								self := left));
 
 export iPHONE  := base_icommon ((unsigned)person_q.personal_phone > 0); 
  
 export iFEIN 	 := base (bus_q.appended_ein <>'');
 
 name_filtered := base_icommon (trim(person_q.lname) <> '' and  trim(person_q.fname) <> '' and
																		 StringLib.StringToUpperCase(trim(Search_Info.Function_Description)) 
																		                              in Inql_V2.shell_constants.set_suspiciousfraud_function_names); 
 export iNAME := project(name_filtered, transform(Inql_v2.Layouts.i_nonfcra_slim, self := left));

ipaddr_filtered := base_icommon(trim(person_q.IPaddr) <> '' and
																		 StringLib.StringToUpperCase(trim(Search_Info.Function_Description)) 
																		                              in Inql_V2.shell_constants.set_suspiciousfraud_function_names); 
export iIPADDR := project(ipaddr_filtered, transform(Inql_v2.Layouts.i_nonfcra_slim, 
																						self.person_q.IPADDR := trim(left.person_q.IPaddr,left,right)
																					, self := left));

transaction_id_filtered := base_icommon (search_info.transaction_id != '' and 
                                          StringLib.StringToUpperCase(trim(search_info.function_description)) 
																					                            in Inql_V2.shell_constants.chargeback_functions);
export iTransaction_id := DEDUP(Project(transaction_id_filtered, 
																	Transform(INQL_v2.Layouts.i_nonfcra_transaction_id,
																						self.transaction_id					:= left.search_info.transaction_id,		
																						self.appended_adl						:= left.person_q.appended_adl,		
																						self.datetime								:= left.search_info.datetime,		
																						self.industry								:= left.bus_intel.industry,		
																						self.vertical								:= left.bus_intel.vertical,		
																						self.sub_market							:= left.bus_intel.sub_market,		
																						self.function_description		:= left.search_info.function_description,		
																						self.product_code						:= left.search_info.product_code,		
																						self.use										:= left.bus_intel.use,		
																						self.Sequence_Number				:= left.search_info.Sequence_Number))
																,ALL);		
															

mbs_filtered := INQL_V2.File_MBS.File(~(INQL_V2.fnTranslations.is_Disable_Observation(allowflags) or 
                                        INQL_V2.fnTranslations.is_opt_out(allowflags) or
																				INQL_V2.fnTranslations.is_Exclude_Inquiry_Access(allowflags)));
mbs_filtered_mapped := project(mbs_filtered, transform({INQL_V2.Layout_MBS_Industry_vertical}
																								,self.sub_market := if (left.sub_market='CARD','CARDS',left.sub_market)
																								,self := left
																								, self := []));
mbs_filtered_mapped_dist := distribute(mbs_filtered_mapped, hash(company_id,gc_id));
export iIndustry_use_vertical := dedup(sort(mbs_filtered_mapped_dist, gc_id, company_id, product_id, local), 
																				gc_id, company_id, product_id, local);
																					
export iIndustry_use_vertical_login := INQL_v2.File_Inquiry_industry_use_vertical_login.MBS_slim;

func_desc := INQL_v2.File_Lookups.transaction_desc;
func_desc_dedup := dedup(func_desc(function_name <> ''), all);
export ilookup_func_desc := project(func_desc_dedup, transform(INQL_v2.layouts.i_lookup_func_desc, 
																					self.description := stringlib.stringtouppercase(left.description), 
																					self := left));

export iBillgroups_DID := INQL_V2.File_Inquiry_Billgroups_DID().File;


base_Bip := INQL_v2.FN_Append_Bip(base);											
export iLinkids := INQL_v2.FN_Append_SBA(base_Bip);

//export iDID_Risk   := INQL_v2.fn_Build_Risk_Base(base_full);

end;