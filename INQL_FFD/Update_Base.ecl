import ut, inql_ffd, std;

EXPORT Update_Base (boolean isDaily = true, boolean isFCRA = true, string pVersion = '') := module //function

shared InputNonEncrypted	:= Files(isDaily, isFCRA, pVersion).InputBuilding;
	
shared InputEncrypted			:= Files(isDaily, isFCRA, pVersion).InputEncryptedBuilding;    
shared InputDecrypted  		:= INQL_FFD.FN_File_Decryption(InputEncrypted);
	
shared stdInput  					:= INQL_FFD.FN_Join_Decrypted_File(InputNonEncrypted,InputDecrypted);
	
	inql_ffd._Functions.CleanFields(stdInput, cleaned_fields);

	formatted	:=	project(cleaned_fields
												,transform(Inql_ffd.Layouts.Input_Formatted, 

																self.formatted_date_added  						:= Inql_FFD._Functions.Convert_DateTime_Format(left.date_added);
																self.formatted_ssn        						:= Inql_FFD._Functions.Clean_SSN(left.ssn);
																																						
																			clean_name_first  := Inql_FFD._Functions.Clean_ToUpper_Str(left.name_first);
																			clean_name_middle := Inql_FFD._Functions.Clean_ToUpper_Str(left.name_middle);
																			clean_name_last   := Inql_FFD._Functions.Clean_ToUpper_Str(left.name_last);
																			clean_name_full   := clean_name_first + ' ' + clean_name_middle + ' ' + clean_name_last;
																self.formatted_full_name              := stringlib.stringcleanspaces(clean_name_full);
																
																self.formatted_addr_street            := Inql_FFD._Functions.Clean_ToUpper_Str(left.addr_street);
																
																			clean_addr_city          							:= Inql_FFD._Functions.Clean_ToUpper_Str(left.addr_city);
																			clean_addr_state          						:= Inql_FFD._Functions.Clean_ToUpper_Str(left.addr_state);				
																			clean_addr_zip5          							:= Inql_FFD._Functions.Clean_ToUpper_Str(left.addr_zip5);
																			clean_addr_zip4          							:= Inql_FFD._Functions.Clean_ToUpper_Str(left.addr_zip4);
																			clean_addr_lastline										:= clean_addr_city + ' ' +
																																							 clean_addr_state + ' ' +
																																							 clean_addr_zip5 + ' ' +
																																							 clean_addr_zip4;
																self.formatted_addr_lastline         	:= stringlib.stringcleanspaces(clean_addr_lastline);
																
																     clean_dob                        := Std.Date.ConvertDateFormat(left.dob,'%Y-%m-%d','%Y%m%d');
																self.formatted_dob        						:= if(std.date.isvalidDate((unsigned)clean_dob),clean_dob,'');

																self.formatted_phone_nbr           		:= if(ut.CleanPhone(left.phone_nbr) [1] not in ['0','1'],ut.CleanPhone(Left.phone_nbr), '');     
																self.formatted_eu_phone_nbr           := if(ut.CleanPhone(left.eu_phone_nbr) [1] not in ['0','1'],ut.CleanPhone(Left.eu_phone_nbr), '');     
																self                        					:= left;
																self                     							:= [];)
												);

	parsedNames 									:= Inql_FFD._Functions.Parse_STD_Names(formatted);								
	parsedNamesAddresses 					:= Inql_FFD._Functions.Parse_STD_Addresses(parsedNames);
	appended_did_ssn    					:= Inql_FFD._Functions.Append_DID_SSN(parsedNamesAddresses);
	appended_did_ssn_PPC_EXCLUDE 	:= appended_did_ssn(ppc not in _Constants.FCRA_PPC_EXCLUDE);
	
  xlated_ppc         					  := Inql_FFD.FN_Convert_PPC(appended_did_ssn_PPC_EXCLUDE).xlated_ppc;
  
	appended_base       					:=  project(xlated_ppc, transform(INQL_FFD.Layouts.Base,
						self.datetime             := left.formatted_date_added,
						self.dob                  := left.formatted_dob,
						self.phone_nbr            := left.formatted_phone_nbr,
						self.eu_phone_nbr         := left.formatted_eu_phone_nbr,
						self.appended_did         := if(left.appendadl=0,(unsigned)left.lex_id,left.appendadl);
						self.appended_ssn         := left.appendssn,
						self.filedate 						:= (unsigned)Inql_FFD.Fn_Get_Current_Version.fcra_input,
						self.version              := pVersion,
						self 											:= left,
						self 											:= [];
						)); 
  
	shared base_with_group_rid    := INQL_FFD.FN_Append_Group_RID(appended_base).base_group_rid;	
	shared base_no_decrypted      := INQL_FFD.FN_Clean_Decrypted(base_with_group_rid,InputDecrypted)
	                                 :persist('~persist::uspr::inquiryhistory::base_no_decrypted');
																	 
	new_daily_base						    := project(base_no_decrypted,transform(inql_ffd.Layouts.Base,
	                                                     self:=left;));
																											 
  prev_daily_base               := 	if (Inql_FFD._Flags().LastFullKeyVersionApproved , 
	                                      Files(isDaily, isFCRA, pVersion).base.qa(version > INQL_FFD.Fn_Get_Current_Version.fcra_full_keys_dops_prod),
	                                      Files(isDaily, isFCRA, pVersion).base.qa
																				);
	
  daily_base_updated 				    := new_daily_base + prev_daily_base;
 	
  filtered_daily_base        		:= daily_base_updated
																			(
																			((ppc in _Constants.FCRA_PPC) and datetime[1..8] between _Flags(pVersion).dt2yearsago and pVersion) 
							                    or 	((ppc not in _Constants.FCRA_PPC) and datetime[1..8] between _Flags(pVersion).dt1yearago and pVersion)
																			);
																			
 	remediated_base          			:= INQL_FFD.FN_Apply_FCRA_Remediation_Soft_Inquiry(filtered_daily_base).base_remediation;
  
	export daily_base  				  	:= dedup(distribute(remediated_base ,hash(lex_id)),record, all);

  new_daily_base_encrypted      := distribute(project(base_no_decrypted(key_decrypted<>''),
	                                                    transform(inql_ffd.Layouts.Base_Encrypted,self:=left;))
	                                            ,hash(transaction_id));
	prev_daily_base_encrypted     := inql_ffd.Files(true, true, pVersion).Base_Encrypted.qa
	                                      (version > INQL_FFD.Fn_Get_Current_Version.fcra_full_keys_dops_prod);
  export daily_base_encrypted		:= dedup(distribute(new_daily_base_encrypted + prev_daily_base_encrypted),record,all);
	
end;