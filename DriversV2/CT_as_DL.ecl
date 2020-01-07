import Lib_StringLib, Drivers, Std;

export CT_as_DL(dataset(drivers.Layout_CT_Full) pFile_CT_Input)			:= function

	fGetAddressToken(string pAddressIn, unsigned pToken)
			:=choose(pToken,
							 pAddressIn[1..(lib_stringlib.StringLib.stringfind(pAddressIn,'@',1)-1)],
							 pAddressIn[(lib_stringlib.StringLib.stringfind(pAddressIn,'@',1)+1)..(lib_stringlib.StringLib.stringfind(pAddressIn,'@',2)-1)],
							 pAddressIn[(lib_stringlib.StringLib.stringfind(pAddressIn,'@',2)+1)..(lib_stringlib.StringLib.stringfind(pAddressIn,'@',3)-1)],
							 pAddressIn[(lib_stringlib.StringLib.stringfind(pAddressIn,'@',3)+1)..(lib_stringlib.StringLib.stringfind(pAddressIn,'@',4)-1)],
							 pAddressIn[(lib_stringlib.StringLib.stringfind(pAddressIn,'@',4)+1)..(lib_stringlib.StringLib.stringfind(pAddressIn,';',1)-1)],
							 '');
							 
	TrimUpper(STRING s):= FUNCTION
	 RETURN std.str.touppercase(std.str.cleanspaces(s));
  END;

	Layouts_DL_CT_In.Layout_CT_Temp trfNormAddr(pFile_CT_Input l, integer c) := transform
		self.addr_type := choose(c,'M','R');
		self.Street    := choose(c, l.MailAddrStreet, l.ResiAddrStreet);
		self.City      := choose(c, l.MailingCity, l.ResidencyCity);
		self.State     := choose(c, l.MailingState, l.ResidencyState);
		self.Zip       := choose(c, l.MailingZip, l.ResidencyZip);
		self           := l;
	end;

	norm_file := normalize(pFile_CT_Input, 
												 if(TrimUpper(left.MailAddrStreet) <> TrimUpper(left.ResiAddrStreet) and 
														trim(left.ResiAddrStreet + left.ResidencyCity + left.ResidencyState,all) <> '',2,1)
														,trfNormAddr(left,counter)
											   );
												 
	DriversV2.Layout_DL_Extended tCTAsDL(Layouts_DL_CT_In.Layout_CT_Temp  l):=transform	
		
		self.dt_first_seen 								:= (unsigned8)l.append_PROCESS_DATE div 100;
		self.dt_last_seen 								:= (unsigned8)l.append_PROCESS_DATE div 100;
		self.dt_vendor_first_reported			:= (unsigned8)l.append_PROCESS_DATE div 100;
		self.dt_vendor_last_reported 			:= (unsigned8)l.append_PROCESS_DATE div 100;
		self.dateReceived									:= (integer)l.append_PROCESS_DATE;
		self.orig_state 			    			  := 'CT';
		self.source_code	                := 'AD';
		self.name											    := TrimUpper(TrimUpper(l.FirstName)+' '+ TrimUpper(l.MiddleInitial)+' '+ 
																									 TrimUpper(l.LastName)+' '+ TrimUpper(l.Suffix) );
		self.RawFullName							    := TrimUpper(TrimUpper(l.FirstName)+' '+ TrimUpper(l.MiddleInitial)+' '+ 
																									 TrimUpper(l.LastName)+' '+ TrimUpper(l.Suffix) );
		self.addr1										    := l.Street;
		self.city 										    := l.City;
		self.state										    := l.State;
		self.zip 										    	:= l.Zip;
		self.addr_type                    := l.addr_type;		
		self.dob 											    := (unsigned4)(l.Date_Birth);
	  self.sex_flag									    := l.Gender;
		Self.license_class   							:= trim(l.Credential_Class,left,right); 
		self.OrigLicenseClass   					:= trim(l.Credential_Class,left,right);
		self.license_type    							:= trim(l.CredentialType,left,right);
	  self.OrigLicenseType              := trim(l.CredentialType,left,right);		
    self.moxie_license_type           := l.Credential_Class +	if(l.Credential_Class in ['A','B','C'],
																																 l.LicenseStatusCDL,l.StatusNONCDL); //just keeping the old logic 
		self.restrictions 				        := if(l.CredentialType in ['CDL','LIC','LP'] ,l.restrictions,'');
	  self.expiration_date		          := (unsigned4)(l.ExpDate);
		self.orig_expiration_date         := (unsigned4)(l.ExpDate);
		self.lic_issue_date 	            := (unsigned4)l.LastIssueRenewalDate;		
		self.orig_issue_date              := (unsigned4)l.LastIssueRenewalDate;	
		self.lic_endorsement              := if(l.CredentialType in ['CDL','LIC','LP'] ,l.endorsements,'');	
		self.motorcycle_code							:= if(l.Credential_Class = 'M','ALSO','');//just keeping the old logic 
		self.dl_number 							  		:= l.CredentialNumber;
		self.height 											:= l.Height;	
		self.oos_previous_st							:= l.CancelState;
		self.eye_color										:= l.EyeColor;	
		self.title 											  := l.clean_name_prefix;
		self.fname 											  := l.clean_name_first;		                             
		self.mname 											  := l.clean_name_middle;		                             
		self.lname 											  := l.clean_name_last;		                             
		self.name_suffix 									:= l.clean_name_suffix;		                             
		self.cleaning_score 							:= l.clean_name_score;
		self.status             					:= l.StatusNONCDL;
		self.CDL_Status         					:= l.LicenseStatusCDL;
		self.orig_canceldate		          := l.CancelDate;
		self.orig_origcdldate             := l.OriginalDate_CDL;
		self                    					:= l;
		self                          		:= [];		
	end;

	CT_as_DL			:= project(norm_file,tCTasDL(left));
	return(CT_as_DL);
	
end;


