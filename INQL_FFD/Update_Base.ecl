﻿import ut, inql_ffd, std;

EXPORT Update_Base (boolean isDaily = true, boolean isFCRA = true, string pVersion = '') := function

	stdInput	:=	Files(isDaily, isFCRA, pVersion).InputBuilding;

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
																self.ppc                    					:= Inql_ffd._Functions.Convert_PPC(left.ppc);
																self                        					:= left;
																self                     							:= [];)
												);

	parsedNames 					:= Inql_FFD._Functions.Parse_STD_Names(formatted);								
	parsedNamesAddresses 	:= Inql_FFD._Functions.Parse_STD_Addresses(parsedNames);
	appended_did_ssn    	:= Inql_FFD._Functions.Append_DID_SSN(parsedNamesAddresses);

	appended_base       	:=  project(appended_did_ssn, transform(INQL_FFD.Layouts.Base,

						self.datetime             := left.formatted_date_added,
						self.dob                  := left.formatted_dob,
						self.phone_nbr            := left.formatted_phone_nbr,
						self.eu_phone_nbr         := left.formatted_eu_phone_nbr,
						self.appended_did         := left.appendadl,
						self.appended_ssn         := left.appendssn,
						self.filedate 						:= (unsigned)Inql_FFD.Fn_Get_Current_Version.fcra_input,
						self.version              := pVersion,
						self 											:= left,
						self 											:= [];
						)); 
  
  prev_daily_base               := 	if (Inql_FFD._Flags().LastFullKeyVersionApproved , 
	                                      Files(isDaily, isFCRA, pVersion).base.qa(version > INQL_FFD.Fn_Get_Current_Version.fcra_full_keys_dops_prod),
	                                      Files(isDaily, isFCRA, pVersion).base.qa
																				);
	
  daily_base_updated  				  := appended_base + prev_daily_base;
 	
  filtered_daily_base        		:= daily_base_updated
																			(
																			((ppc in _Constants.FCRA_PPC) and datetime[1..8] between _Flags(pVersion).dt2yearsago and pVersion) 
							                    or 	((ppc not in _Constants.FCRA_PPC) and datetime[1..8] between _Flags(pVersion).dt1yearago and pVersion)
																			);
																			
  excluded_filtered_daily_base 	:= 	filtered_daily_base (ppc not in _Constants.FCRA_PPC_EXCLUDE);
	
	remediated_base          			:= INQL_FFD.FN_Apply_FCRA_Remediation_Soft_Inquiry(excluded_filtered_daily_base).base_remediation;
  
	daily_base  				  				:= dedup(distribute(remediated_base,hash(lex_id)),record, all);

  return daily_base;
	
end;