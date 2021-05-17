import ut, inql_ffd, std;

//Reappend DID and SSN to the historic base and filter records out of period. 

EXPORT Fn_UpdateWeeklyBase (string pVersion = '') := Module

	curr_weekly_base             := Inql_ffd.FN_Decrypt_Weekly_Base() +
																	INQL_FFD.Files(true, true).Base.Built;
	
	formatted	:=	project(curr_weekly_base
												,transform(INQL_FFD.Layouts.Input_Formatted,
																				
																	self.formatted_date_added  						:= left.datetime;
																, self.formatted_ssn        						:= left.appended_ssn; 
																, self.appendssn                        := left.appended_ssn; 
																, self.appendadl												:= left.appended_did;
																, self.formatted_dob        						:= left.dob;
																, self.formatted_phone_nbr           		:= left.phone_nbr;     
																, self.formatted_eu_phone_nbr           := left.eu_phone_nbr;
																//, self.ppc                              := INQL_FFD._Functions.Convert_PPC(left.ppc);
																, self.name_score                       := '';
																,	self                        					:= left;
																,	self                     							:= [];)
												);

	appended_did_ssn    := INQL_FFD._Functions.Append_DID_SSN(formatted);

  appended_base       :=  project(appended_did_ssn, transform(INQL_FFD.Layouts.Base,
																		self.appended_did         := if(left.appendadl=0,(unsigned)left.lex_id,left.appendadl);
																		self.appended_ssn         := left.appendssn;
																		self := left;
																		self := [];
																		)); 
																		
	weekly_base_filtered_by_period   	:= appended_base
																				(
																			((ppc in _Constants.FCRA_PPC) and datetime[1..8] between _Flags(pVersion).dt2yearsago and pVersion) 
							                    or 	((ppc not in _Constants.FCRA_PPC) and datetime[1..8] between _Flags(pVersion).dt1yearago and pVersion)
																			);
	
	weekly_base_filtered_by_valid_ppc   := weekly_base_filtered_by_period (ppc not in _Constants.FCRA_PPC_EXCLUDE);
	
	shared weekly_base_with_group_rid   := INQL_FFD.FN_Append_Group_RID(weekly_base_filtered_by_valid_ppc).base_group_rid;
	
	shared curr_weekly_base_encrypted 	:= distribute(INQL_FFD.Files(false, true).Base_Encrypted.Built +
																										INQL_FFD.Files(true, true).Base_Encrypted.Built,
																										hash(transaction_id));
																								
  shared InputDecrypted         			 := project(curr_weekly_base_encrypted,
	                                                transform(inql_ffd.Layouts.Input_Decrypted,
																																			self := left;
																																			self := [];)
																																			);
																																			
  shared weekly_base_cleaned_decrypted := project(INQL_FFD.FN_Clean_Decrypted(weekly_base_with_group_rid, 
	                                                                            InputDecrypted),
																						transform(inql_ffd.Layouts.base, self:= left;));
																						
	export new_weekly_base  				:= dedup(sort(weekly_base_cleaned_decrypted,record),record, except version, filedate);
	
	weekly_base_transactions        := distribute(table(new_weekly_base,{transaction_id,group_rid}),hash(transaction_id));

  update_weekly_base_encrypted  	:= join(curr_weekly_base_encrypted,weekly_base_transactions,
	                                        left.transaction_id = right.transaction_id,
	                                        transform(Inql_ffd.Layouts.base_encrypted,
																					          self.group_rid := right.group_rid,
																					          self:=left;),local);
																										
	export new_weekly_base_encrypted := dedup(sort(update_weekly_base_encrypted,record),
	                                          record, except version, filedate);
	

end;