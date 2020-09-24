import ut, inql_ffd, std;

//Reappend DID and SSN to the historic base and filter records out of period. 

EXPORT Fn_UpdateWeeklyBase (string pVersion = '') := function

	curr_weekly_base := INQL_FFD.Files(false, true).Base.Built +
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
																		
	filtered_weekly_base_did_ssn   	:= appended_base
																				(
																			((ppc in _Constants.FCRA_PPC) and datetime[1..8] between _Flags(pVersion).dt2yearsago and pVersion) 
							                    or 	((ppc not in _Constants.FCRA_PPC) and datetime[1..8] between _Flags(pVersion).dt1yearago and pVersion)
																			);
	
	excluded_weekly_base            := filtered_weekly_base_did_ssn (ppc not in _Constants.FCRA_PPC_EXCLUDE);
	
	new_weekly_base  				  				:= dedup(sort(excluded_weekly_base,record),record, except version, filedate);

  
  return new_weekly_base;

end;