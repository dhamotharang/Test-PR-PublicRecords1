IMPORT NAC_Services,NAC_V2_Services,STD,Address,AutoKeyI,NID,iesp;
EXPORT SearchFunctions := MODULE
  // This function is placed in this attribute because investigative searches are only conducted from the search service and not batch
	SHARED isInvestigativeInputMet(STRING1 program_code,STRING6 in_month,STRING2 in_state,STRING6 inv_start_month,
	                               STRING6 inv_end_month,STRING20 case_id,STRING20 client_id,BOOLEAN hasNoPII) := FUNCTION
		hasNoDates  := TRIM(in_month)='' AND (TRIM(inv_start_month)='' OR TRIM(inv_end_month)='');
		in_date     := (STD.Date.Date_t)(in_month        + '01');
		inv_d_start := (STD.Date.Date_t)(inv_start_month + '01');
		inv_d_end   := (STD.Date.Date_t)(inv_end_month   + '01');
		hasInValidDates	:= ~STD.DATE.IsValidDate(in_date) AND (~STD.DATE.IsValidDate(inv_d_start) 
		                    OR ~STD.DATE.IsValidDate(inv_d_end) OR inv_d_start>inv_d_end);

		hasCaseId := case_id<>'';
		hasNoPIIorCaseID := hasNoPII AND ~hasCaseId;
		hasClientIdWithoutCase := client_id<>'' AND ~hasCaseId;

	  hasNoProgramCode := program_code = '';
		hasInValidProgramCode := program_code NOT IN NAC_V2_Services.Constants.SNAP_DSNAP_SET;
		// FOR investigative mode, the state is NOT auto populated by mbs
		hasNoStateWhenRequired := hasCaseId AND in_state = '';

		RETURN MAP(hasNoDates OR hasNoProgramCode OR hasNoPIIorCaseID
		           OR hasNoStateWhenRequired                  => AutoKeyI.errorcodes._codes.INSUFFICIENT_INPUT
							,hasInValidDates OR hasInValidProgramCode
							 OR hasClientIdWithoutCase                  => AutoKeyI.errorcodes._codes.INVALID_INPUT
							,0);
	END;

	EXPORT processSearch(iesp.nac_search.t_NACSearch in_rec,BOOLEAN InvestigativePurpose) := FUNCTION

		NAC_V2_Services.Layouts.process_layout xformInput(iesp.nac_search.t_NACSearch L) := TRANSFORM
			SELF.acctno 						:= 1; // Search only has one record
			Identity 								:= L.Identity;
			InvestigativeFields 		:= L.InvestigativeFields;
			useFullName							:= Identity.FullName <> '';
			useCleanName						:= useFullName OR (Identity.FirstName <> '' AND Identity.LastName <> '');
			nameToClean_parsed			:= Address.NameFromComponents(Identity.FirstName,
																													  Identity.MiddleName,
																													  Identity.LastName,
																													  Identity.Suffix);
			cleanName_unparsed			:= Address.CleanNameFields(Address.CleanPerson73(Identity.FullName)).CleanNameRecord;
			cleanName_parsed				:= Address.CleanNameFields(Address.CleanPersonFML73(nameToClean_parsed)).CleanNameRecord;
			cleanName								:= if(useFullName, cleanName_unparsed, cleanName_parsed);
			nameLast      					:= IF(useCleanName, cleanName.lname, Identity.LastName);
			SELF.name_last 					:= nameLast;
			nameFirst       				:= IF(useCleanName, cleanName.fname, Identity.FirstName);
			SELF.name_first 				:= nameFirst;
			SELF.name_middle 				:= if(useCleanName, cleanName.mname, Identity.MiddleName);
			SELF.name_suffix				:= if(useCleanName, cleanName.name_suffix, Identity.Suffix);
			SELF.name_first_pref		:= NID.PreferredFirst(nameFirst);
			SELF.name_first_pref_new:= NID.PreferredFirstNew(nameFirst);
			SELF.orig_name_last			:= Identity.LastName;
			SELF.orig_name_first		:= Identity.FirstName;
			address1_addr1					:= Identity.Address1.StreetAddress1 + ' ' + Identity.Address1.StreetAddress2;
			address1_addr2 					:= Address.Addr2FromComponents(Identity.Address1.City, Identity.Address1.State, Identity.Address1.Zip);
			address1_clean_addr 		:= address.GetCleanAddress(address1_addr1,address1_addr2,address.Components.country.US);
			address1_ca							:= address1_clean_addr.results;
			SELF.addr1_prim_range		:= address1_ca.prim_range;
			SELF.addr1_prim_name 		:= address1_ca.prim_name;
			SELF.addr1_suffix				:= address1_ca.suffix;
			SELF.addr1_predir 			:= address1_ca.predir;
			SELF.addr1_postdir 			:= address1_ca.postdir;
			SELF.addr1_sec_range		:= address1_ca.sec_range;
			SELF.addr1_city					:= address1_ca.p_city;
			SELF.addr1_state				:= address1_ca.state;
			SELF.addr1_zip					:= address1_ca.zip;
			address2_addr1					:= Identity.Address2.StreetAddress1 + ' ' + Identity.Address2.StreetAddress2;
			address2_addr2 					:= Address.Addr2FromComponents(Identity.Address2.City, Identity.Address2.State, Identity.Address2.Zip);
			address2_clean_addr 		:= address.GetCleanAddress(address2_addr1,address2_addr2,address.Components.country.US);
			address2_ca							:= address2_clean_addr.results;
			SELF.addr2_prim_range		:= address2_ca.prim_range;
			SELF.addr2_prim_name 		:= address2_ca.prim_name;
			SELF.addr2_suffix				:= address2_ca.suffix;
			SELF.addr2_predir 			:= address2_ca.predir;
			SELF.addr2_postdir 			:= address2_ca.postdir;
			SELF.addr2_sec_range		:= address2_ca.sec_range;
			SELF.addr2_city					:= address2_ca.p_city;
			SELF.addr2_state				:= address2_ca.state;
			SELF.addr2_zip					:= address2_ca.zip;
			// For filling match codes correctly if city/state OR zip wasn't actually in the input
			SELF.hasCityStateInput	:= (Identity.Address1.City <> '' AND Identity.Address1.State <> '')
			                            OR (Identity.Address2.City <> '' AND Identity.Address2.State <> '');
			SELF.hasZipInput				:= Identity.Address1.Zip <> '' OR Identity.Address2.Zip <> '';
			SELF.ssn 								:= Identity.SSN;
			SELF.dob 								:= Identity.DOB;
			programCode             := STD.STR.ToUpperCase(Identity.BenefitType);
			SELF.in_program_code 		:= programCode;
			caseID                  := STD.STR.ToUpperCase(Identity.CaseId);
			SELF.case_identifier 		:= caseID;
			clientID                := STD.STR.ToUpperCase(Identity.ClientId);
			// Purposely set the client='' since we don't support client searches in nac1 match searches
			SELF.client_identifier 	:= IF(InvestigativePurpose,clientID,'');
			benState                := STD.STR.ToUpperCase(InvestigativeFields.BenefitState);
			SELF.benefit_state 			:= benState;
			benMonth                := TRIM(Identity.BenefitMonth,LEFT)[..6];
			SELF.benefit_month 			:= benMonth;
			benMonth_start          := TRIM(InvestigativeFields.BenefitMonthStart,LEFT)[..6];
			SELF.benefit_month_start:= IF(InvestigativePurpose,benMonth_start,'');
			benMonth_end            := TRIM(InvestigativeFields.BenefitMonthEnd,LEFT)[..6];
			SELF.benefit_month_end	:= IF(InvestigativePurpose,benMonth_end,'');
			SELF.eligibility_status	:= STD.STR.ToUpperCase(InvestigativeFields.EligibilityStatus);
			SELF.IncludeInterstateAllPrograms	:= TRUE;
			
			inHasNoPII	:= ~NAC_V2_Services.Functions().inputHasPII(nameLast, nameFirst, Identity.SSN,
																	Identity.Address1.StreetAddress1, Identity.Address1.City, 
																	Identity.Address1.State, Identity.Address1.Zip,
																	Identity.Address2.StreetAddress1, Identity.Address2.City,
																	Identity.Address2.State, Identity.Address2.Zip);
			SELF.error_code	:= IF(InvestigativePurpose,
														isInvestigativeInputMet(programCode,benMonth,benState,benMonth_start,
														                        benMonth_end,caseID,clientID,inHasNoPII),
			                      NAC_Services.Functions.isMatchInputMet(programCode,Identity.BenefitMonth,benState,inHasNoPII));
		END;
		// Turn the record into a DS so that it can be processed by the upcoming functions
		ds_out := DATASET(PROJECT(in_rec, xformInput(LEFT)));
		// Debug
		#IF(NAC_Services.Constants.Debug)
			OUTPUT(ds_out(error_code=0),NAMED('valid_inputs'));
			OUTPUT(ds_out(error_code>0),NAMED('invalid_inputs'));
		#END
		RETURN ds_out;
	END;

	EXPORT finalSearchTRANSFORM(DATASET(NAC_Services.Layouts.nac_raw_rec) res_rec, STRING drupalID) := FUNCTION
		// Contact
		iesp.nac_search.t_NACContact xformContact(NAC_Services.Layouts.nac_raw_rec L) := TRANSFORM
			SELF.Name 					:= L.state_contact_name;
			SELF.Phone 					:= L.state_contact_phone;
			SELF.PhoneExtension := L.state_contact_phone_extension;
			SELF.Email 					:= L.state_contact_email;
		END;
		// Client
		iesp.nac_search.t_NACClient xformClient(NAC_Services.Layouts.nac_raw_rec L) := TRANSFORM
			SELF.ClientId 					:= L.client_identifier;
			SELF.LastName 					:= L.client_last_name;
			SELF.FirstName 					:= L.client_first_name;
			SELF.MiddleName 				:= L.client_middle_name;
			SELF.Gender 						:= L.client_gender;
			SELF.Race 							:= L.client_race;
			SELF.Ethnicity 					:= L.client_ethnicity;
			SELF.SSN 								:= L.client_ssn;
			SELF.SSNType						:= L.client_ssn_type_indicator;
			SELF.DOB 								:= L.client_dob;
			SELF.DOBType 						:= L.client_dob_type_indicator;
			SELF.EligibleIndicatOR 	:= L.client_eligible_status_indicator;
			SELF.EligibleStatusDate := L.client_eligible_status_date;
			SELF.PhoneNumber 				:= L.client_phone;
			SELF.Email 							:= L.client_email;
		END;
		// Case
		iesp.nac_search.t_NACCase xformCase(NAC_Services.Layouts.nac_raw_rec L) := TRANSFORM
			SELF.CaseId 												:= L.case_identifier;
			SELF.LastName 											:= L.case_last_name;
			SELF.FirstName 											:= L.case_first_name;
			SELF.MiddleName 										:= L.case_middle_name;
			SELF.State 													:= L.case_state_abbreviation;
			SELF.BenefitMonth 									:= L.case_benefit_month;
			SELF.BenefitType 										:= L.case_benefit_type;
			SELF.Phone1													:= L.case_phone_1;
			SELF.Phone2 												:= L.case_phone_2;
			SELF.Email													:= L.case_email;
			SELF.PhysicalAddress.StreetAddress1 := L.case_physical_address_street_1;
			SELF.PhysicalAddress.StreetAddress2 := L.case_physical_address_street_2;
			SELF.PhysicalAddress.City 					:= L.case_physical_address_city;
			SELF.PhysicalAddress.State 					:= L.case_physical_address_state;
			SELF.PhysicalAddress.Zip 						:= L.case_physical_address_zip;
			SELF.MailingAddress.StreetAddress1 	:= L.case_mailing_address_street_1;
			SELF.MailingAddress.StreetAddress2 	:= L.case_mailing_address_street_2;
			SELF.MailingAddress.City 						:= L.case_mailing_address_city;
			SELF.MailingAddress.State 					:= L.case_mailing_address_state;
			SELF.MailingAddress.Zip 						:= L.case_mailing_address_zip;
			SELF.CountyParishCode 							:= L.case_county_parish_code;
			SELF.CountyParishName 							:= L.case_county_parish_name;
		END;
		// Record
		iesp.nac_search.t_NACRecord xformRecord(NAC_Services.Layouts.nac_raw_rec L) := TRANSFORM
			SELF.Case 		:= PROJECT(L, xformCase(LEFT));
			SELF.Client 	:= PROJECT(L, xformClient(LEFT));
			SELF.Contact	:= PROJECT(L, xformContact(LEFT));
		END;
		// To output layout
		iesp.nac_search.t_NACSearchResultRecord xformFinal(NAC_Services.Layouts.nac_raw_rec L) := TRANSFORM
			SELF.NACRecord 					:= PROJECT(L, xformRecord(LEFT));
			SELF.MatchCode 					:= L.matchcode;
			SELF.LexIdScore 				:= (STRING)L.lexid_score;
			SELF.TwelveMonthHistory	:= L.twelve_month_history;
			SELF.SequenceNumber 		:= IF(L.sequence_number=0,'',(STRING)L.sequence_number);
			SELF._Penalty						:= (STRING)L.penalt; //hidden[ecldev]
			SELF.UniqueId						:= (STRING)L.did;    //hidden[ecldev]
		END;

		recs_final := PROJECT(res_rec(err_search NOT IN NAC_V2_Services.Constants.ERROR_CODES_SET), xformFinal(LEFT));

		iesp.nac_search.t_NACSearchResponse xformOut() := TRANSFORM
			header_row 	 := iesp.ECL2ESP.GetHeaderRow();
			// If the search failed,there will only be one record in the result set
			error_code 	 := res_rec[1].err_search;
			error_desc 	 := res_rec[1].err_desc;
			SELF._Header := PROJECT(header_row, 
													TRANSFORM(iesp.share.t_ResponseHeader,
														SELF.Exceptions := 
																	DATASET([{'', error_code, '', IF(error_code <> 0, error_desc, '')}], iesp.share.t_WsException);
														SELF := LEFT));
			SELF.RecordCount 					:= COUNT(recs_final);
			SELF.DrupalTransactionId 	:= drupalID; 
			SELF.Records 							:= recs_final;
		END;

		final_recs := DATASET([xformOut()]);
		RETURN final_recs;
	END;
END;
