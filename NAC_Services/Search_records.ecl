import AutoStandardI, iesp, NAC_Services;

EXPORT Search_records(iesp.nac_search.t_NACSearch in_rec,
										  NAC_Services.IParam.options in_param):= FUNCTION
	
	//1. Project to standard layout
	in_rec_standard := NAC_Services.Functions.getStandardInputLayout(in_rec, in_param);
		
	//2. Get records
	res_rec 				:= NAC_Services.Records(dataset(in_rec_standard), in_param);
	
	//3. Project to final output
	//Contact
	iesp.nac_search.t_NACContact xformContact(NAC_Services.Layouts.nac_raw_rec L) := transform
		self.Name 					:= L.state_contact_name;
		self.Phone 					:= L.state_contact_phone;
		self.PhoneExtension := L.state_contact_phone_extension;
		self.Email 					:= L.state_contact_email;
	end;
	//Client
	iesp.nac_search.t_NACClient xformClient(NAC_Services.Layouts.nac_raw_rec L) := transform
		self.ClientId 					:= L.client_identifier;
		self.LastName 					:= L.client_last_name;
		self.FirstName 					:= L.client_first_name;
		self.MiddleName 				:= L.client_middle_name;
		self.Gender 						:= L.client_gender;
		self.Race 							:= L.client_race;
		self.Ethnicity 					:= L.client_ethnicity;
		self.SSN 								:= L.client_ssn;
		self.SSNType						:= L.client_ssn_type_indicator;
		self.DOB 								:= L.client_dob;
		self.DOBType 						:= L.client_dob_type_indicator;
		self.EligibleIndicator 	:= L.client_eligible_status_indicator;
		self.EligibleStatusDate := L.client_eligible_status_date;
		self.PhoneNumber 				:= L.client_phone;
		self.Email 							:= L.client_email;
	end;
	//Case
	iesp.nac_search.t_NACCase xformCase(NAC_Services.Layouts.nac_raw_rec L) := transform
		self.CaseId 												:= L.case_identifier;
		self.LastName 											:= L.case_last_name;
		self.FirstName 											:= L.case_first_name;
		self.MiddleName 										:= L.case_middle_name;
		self.State 													:= L.case_state_abbreviation;
		self.BenefitMonth 									:= L.case_benefit_month;
		self.BenefitType 										:= L.case_benefit_type;
		self.Phone1													:= L.case_phone_1;
		self.Phone2 												:= L.case_phone_2;
		self.Email													:= L.case_email;
		self.PhysicalAddress.StreetAddress1 := L.case_physical_address_street_1;
		self.PhysicalAddress.StreetAddress2 := L.case_physical_address_street_2;
		self.PhysicalAddress.City 					:= L.case_physical_address_city;
		self.PhysicalAddress.State 					:= L.case_physical_address_state;
		self.PhysicalAddress.Zip 						:= L.case_physical_address_zip;
		self.MailingAddress.StreetAddress1 	:= L.case_mailing_address_street_1;
		self.MailingAddress.StreetAddress2 	:= L.case_mailing_address_street_2;
		self.MailingAddress.City 						:= L.case_mailing_address_city;
		self.MailingAddress.State 					:= L.case_mailing_address_state;
		self.MailingAddress.Zip 						:= L.case_mailing_address_zip;
		self.CountyParishCode 							:= L.case_county_parish_code;
		self.CountyParishName 							:= L.case_county_parish_name;
	end;
	//Record
	iesp.nac_search.t_NACRecord xformRecord(NAC_Services.Layouts.nac_raw_rec L) := transform
		self.Case 		:= project(L, xformCase(left));
		self.Client 	:= project(L, xformClient(left));
		self.Contact	:= project(L, xformContact(left));
	end;
	//To output layout
	iesp.nac_search.t_NACSearchResultRecord xformFinal(NAC_Services.Layouts.nac_raw_rec L) := transform
		self.NACRecord 					:= project(L, xformRecord(left));
		self.MatchCode 					:= L.matchcode;
		self.LexIdScore 				:= (string)L.lexid_score;
		self.TwelveMonthHistory	:= L.twelve_month_history;
		self.SequenceNumber 		:= L.sequence_number;
		self._Penalty						:= (string)L.penalt; //hidden[ecldev]
		self.UniqueId						:= (string)L.did; //hidden[ecldev]
	end;
	
	recs_final 			:= project(res_rec(err_search not in NAC_Services.Constants.ERROR_CODES_SET), xformFinal(left));
	
	//4. Include errors 203, 301 and 10 in Header without failing Roxie
	iesp.nac_search.t_NACSearchResponse xformOut() := transform
		header_row 	 := iesp.ECL2ESP.GetHeaderRow();
		error_code 	 := res_rec[1].err_search; //if the search errored out,there will only be one record in the result set
		error_desc 	 := res_rec[1].err_desc;
		self._Header := project(header_row, transform(iesp.share.t_ResponseHeader,
																								  self.Exceptions := dataset([{'', error_code, '', if(error_code <> 0, error_desc, '')}], iesp.share.t_WsException);
																									self := left));
		self.RecordCount 					:= count(recs_final);
		self.DrupalTransactionId 	:= in_rec.DrupalTransactionId; 
		self.Records 							:= recs_final;
	end;
	
	res_final := dataset([xformOut()]);

	RETURN res_final;
END;
