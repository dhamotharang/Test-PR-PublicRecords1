IMPORT NAC_V2_Services,STD,Address,AutoKeyI,NID,iesp;
//nacv2 interface
nacv2I:=NAC_V2_Services.IParams.CommonParams;
empty_mod:=module (nacv2I) end;

EXPORT SearchFunctions(nacv2I in_mod = empty_mod) := MODULE
  // This function is placed in this attribute because investigative searches are only conducted from the search service and not batch
	SHARED isInvestigativeInputMet(STRING1 program_code,STRING1 e_date_type,STD.DATE.date_t e_start_date,
	                               STD.DATE.date_t e_end_date,STRING20 case_id,STRING20 client_id,
																 BOOLEAN hasNoDates,BOOLEAN hasNoPII) := FUNCTION

		hasInValidDates	:= ~STD.DATE.IsValidDate(e_start_date) OR ~STD.DATE.IsValidDate(e_end_date) 
		                   OR e_start_date>e_end_date OR e_date_type NOT IN NAC_V2_Services.Constants.ELI_PERIOD_SET;
		hasCaseOrClientId       := case_id<>'' OR client_id<>'';
		hasNoPIIorCaseClientID  := hasNoPII AND ~hasCaseOrClientId;
	  hasNoProgramCode := program_code = '';
		// Config error - This means they can't see any data
		hasInValidMBSProgramInputs := COUNT(in_mod.SET_PAR)=0;
		// We only allow them to do a * (wildcard) search if they are IN investigative GUI mode	
		hasInValidWildCard := program_code = NAC_V2_Services.Constants._ALL AND ~in_mod.IsOnline;
		// Invalid input - IN case they pass IN an invalid program (that we don't support) code from batch OR xml direct
    hasValidProgramCode   := program_code IN NAC_V2_Services.Constants.PROGRAM_SET OR ~hasInValidWildCard;
		hasInValidProgramCode := ~hasValidProgramCode;
		// Config error - If they search on a program fOR which they don't have rights
		hasUnauthorizedProgramCode := hasValidProgramCode AND program_code NOT IN in_mod.SET_PAR
		                              AND program_code <> NAC_V2_Services.Constants._ALL;		
		// Config error - Because its this means the sourceState is empty
		hasNoStateWhenRequired := hasCaseOrClientId AND in_mod.InvestigativeState = '';

		RETURN MAP(hasNoDates OR hasNoProgramCode OR hasNoPIIorCaseClientID  => AutoKeyI.errorcodes._codes.INSUFFICIENT_INPUT
						  ,hasInValidMBSProgramInputs OR
							 hasUnauthorizedProgramCode OR hasNoStateWhenRequired      => AutoKeyI.errorcodes._codes.CONFIG_ERR
							,hasInValidDates OR hasInValidProgramCode                  => AutoKeyI.errorcodes._codes.INVALID_INPUT 
							,0);
	END;

	EXPORT processSearch(iesp.nac2_search.t_NAC2Search in_rec) := FUNCTION

		NAC_V2_Services.Layouts.process_layout xformInput(iesp.nac2_search.t_NAC2Search L) := TRANSFORM 
			SELF.acctno 						:= 1; // Search only has one record
			Identity 								:= L.Identity;
			useFullName							:= Identity.FullName <> '';
			useCleanName						:= useFullName OR (Identity.FirstName <> '' AND Identity.LastName <> '');
			nameToClean_parsed			:= Address.NameFromComponents(Identity.FirstName,
																													  Identity.MiddleName,
																													  Identity.LastName,
																													  Identity.SuffixName);
			cleanName_unparsed			:= Address.CleanNameFields(Address.CleanPerson73(Identity.FullName)).CleanNameRecord;
			cleanName_parsed				:= Address.CleanNameFields(Address.CleanPersonFML73(nameToClean_parsed)).CleanNameRecord;
			cleanName								:= IF(useFullName, cleanName_unparsed, cleanName_parsed);
			nameLast      					:= IF(useCleanName, cleanName.lname, Identity.LastName);
			SELF.name_last 					:= nameLast;
			nameFirst       				:= IF(useCleanName, cleanName.fname, Identity.FirstName);
			SELF.name_first 				:= nameFirst;
			SELF.name_middle 				:= IF(useCleanName, cleanName.mname, Identity.MiddleName);
			SELF.name_suffix				:= IF(useCleanName, cleanName.name_suffix, Identity.SuffixName);
			SELF.name_first_pref		:= NID.PreferredFirst(nameFirst);
			SELF.name_first_pref_new:= NID.PreferredFirstNew(nameFirst);
			SELF.orig_name_last			:= Identity.LastName;
			SELF.orig_name_first		:= Identity.FirstName;
			address1_addr1					:= Identity.Address1.StreetAddress1 + ' ' + 
			                           Identity.Address1.StreetAddress2;
			address1_addr2 					:= Address.Addr2FromComponents(Identity.Address1.City, 
			                                                       Identity.Address1.State, Identity.Address1.Zip);
			address1_clean_addr 		:= address.GetCleanAddress(address1_addr1,address1_addr2,
			                                                   address.Components.country.US);
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
			address2_addr1					:= Identity.Address2.StreetAddress1 + ' ' +
			                           Identity.Address2.StreetAddress2;
			address2_addr2 					:= Address.Addr2FromComponents(Identity.Address2.City, 
			                                                       Identity.Address2.State, Identity.Address2.Zip);
			address2_clean_addr 		:= address.GetCleanAddress(address2_addr1,address2_addr2,
			                                                   address.Components.country.US);
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
			SELF.hasCityStateInput	:=(Identity.Address1.City <> '' AND Identity.Address1.State <> '')
			                           OR (Identity.Address2.City <> '' AND Identity.Address2.State <> '');
			SELF.hasZipInput				:= Identity.Address1.Zip <> '' OR Identity.Address2.Zip <> '';
			SELF.ssn 								:= Identity.SSN;
			SELF.dob 								:= Identity.DOB;
			programCode             := STD.STR.ToUpperCase(Identity.ProgramCode);
			SELF.in_program_code    := programCode;
			eligibilityPeriodType   := STD.STR.ToUpperCase(Identity.EligibilityRangeType);
			SELF.in_eligibility_period_type:= eligibilityPeriodType;
			
			startDate := TRIM(Identity.EligibilityStart,LEFT);
			endDate   := TRIM(Identity.EligibilityEnd,LEFT);
			inHasNoDates:= startDate='' OR endDate='' OR eligibilityPeriodType='';
			
			d_start := (STD.Date.Date_t)IF(eligibilityPeriodType=NAC_V2_Services.Constants.ELI_PERIOD_MONTH,
			                               startDate[..6] + '01',
																		 Identity.EligibilityStart);
			d_end   := IF(eligibilityPeriodType=NAC_V2_Services.Constants.ELI_PERIOD_MONTH,
			              STD.Date.DatesForMonth((STD.Date.Date_t)(endDate[..6] + '01')).enddate,
									 (STD.Date.Date_t)Identity.EligibilityEnd);
			SELF.in_eligibility_start:= d_start;
			SELF.in_eligibility_end  := d_end;
			case_ident   := STD.STR.ToUpperCase(Identity.CaseIdentifier);
			client_ident := STD.STR.ToUpperCase(Identity.ClientIdentifier);
			SELF.case_identifier    := case_ident;
			SELF.client_identifier  := client_ident;
			SELF.IncludeEligibilityHistory 	  := in_mod.IncludeEligibilityHistory;
			SELF.IncludeInterstateAllPrograms := in_mod.IncludeInterstateAllPrograms;
			inHasNoPII	:= ~NAC_V2_Services.Functions().inputHasPII(nameLast, nameFirst, Identity.SSN,
																	Identity.Address1.StreetAddress1, Identity.Address1.City, 
																	Identity.Address1.State, Identity.Address1.Zip,
																	Identity.Address2.StreetAddress1, Identity.Address2.City,
																	Identity.Address2.State, Identity.Address2.Zip);
			SELF.error_code	:= IF(in_mod.InvestigativePurpose,
														isInvestigativeInputMet(programCode,eligibilityPeriodType,d_start,d_end,case_ident,
														                        client_ident,inHasNoDates,inHasNoPII),
			                      NAC_V2_Services.Functions(in_mod).isMatchInputMet(programCode,eligibilityPeriodType,d_start,d_end,
																																							inHasNoDates,inHasNoPII));
		END;
		// Turn the record into a DS so that it can be processed by the upcoming functions
		ds_out := DATASET(PROJECT(in_rec, xformInput(LEFT)));
		// Debug
		#IF(NAC_V2_Services.Constants.Debug)
			OUTPUT(ds_out(error_code=0),NAMED('valid_inputs'));
			OUTPUT(ds_out(error_code>0),NAMED('invalid_inputs'));
		#END
		RETURN ds_out;
	END;
	
	EXPORT populateSearchHistory(DATASET(NAC_V2_Services.Layouts.nac_raw_rec) nac_recs) := FUNCTION
	
		matchParentRecs_duped  := DEDUP(nac_recs,acctno,client_identifier,case_program_state,case_program_code);
		
		merged_history_recs := NAC_V2_Services.Functions().mergeContigHistRecs(nac_recs);	
		
		match_hist_recs := PROJECT(merged_history_recs,
		                       TRANSFORM(NAC_V2_Services.Layouts.histTempRec,
																SELF.caseidentifier   := LEFT.case_identifier,
																SELF.clientidentifier := LEFT.client_identifier,
																SELF.programstate     := LEFT.case_program_state,
																SELF.programcode      := LEFT.case_program_code,
																SELF.statusindicatOR  := LEFT.eligibility_status_indicator,
																SELF.periodstart      := LEFT.eligibility_period_start_raw,
																SELF.periodend        := LEFT.eligibility_period_end_raw,
																SELF.periodcountdays  := (STRING)LEFT.eligible_period_count_days,
																SELF.periodcountmonths:= (STRING)LEFT.eligible_period_count_months,
																SELF.matchcode        := LEFT.matchcode,
																SELF.lexidscore       := (STRING)LEFT.lexid_score,
																SELF := LEFT));
							
		denormed_Match_recs := DENORMALIZE(matchParentRecs_duped,match_hist_recs,
														LEFT.client_identifier  = RIGHT.clientidentifier AND 
														LEFT.case_program_state = RIGHT.programstate AND 
														LEFT.case_program_code  = RIGHT.programcode,
														GROUP,
														TRANSFORM(NAC_V2_Services.Layouts.denormRec,
																			SELF.MatchInnerHistories := ROWS(RIGHT),
																			SELF := LEFT));
																			
		finalMatchRecs := IF(in_mod.IncludeEligibilityHistory,
		                     denormed_Match_recs,
												 PROJECT(matchParentRecs_duped,NAC_V2_Services.Layouts.denormRec));
												 
		finalMatchRecs_sorted := SORT(finalMatchRecs(isHit),-eligibility_period_end_raw,case_program_state,
																	case_program_code,client_identifier);
												 
		nac_cond_recs  := IF(in_mod.investigativePurpose,
		                     PROJECT(nac_recs,NAC_V2_Services.Layouts.denormRec),
												 finalMatchRecs_sorted);
		// Debug
	  #IF(NAC_V2_Services.Constants.Debug)
			OUTPUT(nac_recs,             NAMED('matchParentRecs_sorted'));
			OUTPUT(matchParentRecs_duped,NAMED('matchParentRecs_duped'));
			OUTPUT(match_hist_recs,      NAMED('match_hist_recs'));
			OUTPUT(denormed_Match_recs,  NAMED('denormed_Match_recs'));
			OUTPUT(finalMatchRecs,       NAMED('finalMatchRecs'));
			OUTPUT(finalMatchRecs_sorted,NAMED('finalMatchRecs_sorted'));
			OUTPUT(nac_cond_recs,        NAMED('nac_cond_recs'));
		#END
		RETURN nac_cond_recs;
	END;	

	EXPORT finalSearchTRANSFORM(DATASET(NAC_V2_Services.Layouts.denormRec) nac_recs_complete) := FUNCTION
															
		rec_count := IF(nac_recs_complete[1].err_search=0,count(nac_recs_complete),0);
		DisplayMatchHist(UNSIGNED val) := IF(~in_mod.InvestigativePurpose and
		                                      in_mod.IncludeEligibilityHistory, (STRING)val, '');
		DisplayInvHist  (STRING   val) := IF( in_mod.InvestigativePurpose and
		                                      in_mod.IncludeEligibilityHistory,         val, '');
																					
		iesp.nac2_search.t_NAC2SearchResultRecord tranToNac2record(NAC_V2_Services.Layouts.denormRec L) := TRANSFORM 
		SELF.nac2record.nacgroupid := L.nac_groupid;
		//*BEGIN_RECORD case (t_nac2case) 
			SELF.nac2record.case.lastname       := L.case_last_name;
			SELF.nac2record.case.firstname      := L.case_first_name;
			SELF.nac2record.case.middlename     := L.case_middle_name;
			SELF.nac2record.case.suffixname     := L.case_suffix_name;
			SELF.nac2record.case.caseidentifier := L.case_identifier;
			SELF.nac2record.case.programstate   := L.case_program_state;
			SELF.nac2record.case.programcode    := L.case_program_code;
			SELF.nac2record.case.phone1         := L.case_phone_1;
			SELF.nac2record.case.phone2         := L.case_phone_2;
			SELF.nac2record.case.email          := L.case_email;
			//*BEGIN_RECORD physicaladdress (t_nac2addressout) 
				SELF.nac2record.case.physicaladdress.streetaddress1  := L.case_physical_address_street_1;
				SELF.nac2record.case.physicaladdress.streetaddress2  := L.case_physical_address_street_2;
				SELF.nac2record.case.physicaladdress.city            := L.case_physical_address_city;
				SELF.nac2record.case.physicaladdress.state           := L.case_physical_address_state;
				SELF.nac2record.case.physicaladdress.zip             := L.case_physical_address_zip;
				SELF.nac2record.case.physicaladdress.addresscategory := L.case_physical_address_category;
			//*END___RECORD physicaladdress
			//*BEGIN_RECORD mailingaddress (t_nac2addressout) 
				SELF.nac2record.case.mailingaddress.streetaddress1  := L.case_mailing_address_street_1;
				SELF.nac2record.case.mailingaddress.streetaddress2  := L.case_mailing_address_street_2;
				SELF.nac2record.case.mailingaddress.city            := L.case_mailing_address_city;
				SELF.nac2record.case.mailingaddress.state           := L.case_mailing_address_state;
				SELF.nac2record.case.mailingaddress.zip             := L.case_mailing_address_zip;
				SELF.nac2record.case.mailingaddress.addresscategory := L.case_mailing_address_category;
			//*END___RECORD mailingaddress
			SELF.nac2record.case.countyparishcode := L.case_county_parish_code;
			SELF.nac2record.case.countyparishname := L.case_county_parish_name;
			SELF.nac2record.case.monthlyallotment := L.case_monthly_allotment;
			SELF.nac2record.case.regioncode       := L.case_region_code;
		//*END___RECORD case
		//*BEGIN_RECORD client (t_nac2client) 
			SELF.nac2record.client.lastname   := L.client_last_name;
			SELF.nac2record.client.firstname  := L.client_first_name;
			SELF.nac2record.client.middlename := L.client_middle_name;
			SELF.nac2record.client.suffixname := L.client_suffix_name;
			SELF.nac2record.client.clientidentifier := L.client_identifier;
			SELF.nac2record.client.gender           := L.client_gender;
			SELF.nac2record.client.race             := L.client_race;
			SELF.nac2record.client.ethnicity        := L.client_ethnicity;
			SELF.nac2record.client.phone            := L.client_phone;
			SELF.nac2record.client.email            := L.client_email;
			SELF.nac2record.client.ssn              := L.client_ssn;
			SELF.nac2record.client.ssntypeindicatOR := L.client_ssn_type_indicator;
			SELF.nac2record.client.dob              := L.client_dob;
			SELF.nac2record.client.dobtypeindicatOR := L.client_dob_type_indicator;
			SELF.nac2record.client.monthlyallotment := L.client_monthly_allotment;
			SELF.nac2record.client.hohindicatOR     := L.client_hoh_indicator;
			SELF.nac2record.client.abawdindicatOR   := L.client_abawd_indicator;
			SELF.nac2record.client.relationshipindicatOR  := L.client_relationship_indicator;
			SELF.nac2record.client.certificateidtype      := L.client_certificate_id_type;
			SELF.nac2record.client.historicalbenefitcount := L.client_historical_benefit_count;
			//*BEGIN_RECORD exception (t_nac2exception) 
				SELF.nac2record.client.exception.reasoncode := L.client_exception_reason_code;
				SELF.nac2record.client.exception.comment    := L.client_exception_comment;
			//*END___RECORD exception
		//*END___RECORD client
		//*BEGIN_RECORD statecontact (t_nac2statecontact) 
			SELF.nac2record.statecontact.name  := L.state_contact_name;
			SELF.nac2record.statecontact.phone := L.state_contact_phone;
			SELF.nac2record.statecontact.phoneextension := L.state_contact_phone_extension;
			SELF.nac2record.statecontact.email          := L.state_contact_email;
		//*END___RECORD statecontact
		//*BEGIN_RECORD eligibility (t_nac2eligibility) 
			SELF.nac2record.eligibility.statusindicatOR   := L.eligibility_status_indicator;
			SELF.nac2record.eligibility.statusdate        := L.eligibility_status_date;
			SELF.nac2record.eligibility.periodtype        := L.client_period_type;
			SELF.nac2record.eligibility.periodstart       := L.eligibility_period_start_raw;
			SELF.nac2record.eligibility.periodend         := L.eligibility_period_end_raw;
			SELF.nac2record.eligibility.periodcountdays   := (STRING)L.eligible_period_count_days;
			SELF.nac2record.eligibility.periodcountmonths := (STRING)L.eligible_period_count_months;
		//*END___RECORD eligibility
		//*BEGIN_RECORD investigativehistory (t_nac2investigativehistory) 
			SELF.nac2record.investigativehistory.earlieststart := DisplayInvHist(L.earlieststart);
			SELF.nac2record.investigativehistory.latestend     := DisplayInvHist(L.latestend);
			SELF.nac2record.investigativehistory.totalrecords  := DisplayInvHist((STRING)L.recordcount);
		//*END___RECORD investigativehistory
		//*BEGIN_RECORD matchhistory (t_nac2matchhistory) 
			SELF.nac2record.matchhistory.totaleligibleperiodcountdays   := DisplayMatchHist(L.totaldays);
			SELF.nac2record.matchhistory.totaleligibleperiodcountmonths := DisplayMatchHist(L.totalmonths);
			SELF.nac2record.matchhistory.matchinnerhistories := PROJECT(L.matchinnerhistories,iesp.nac2_search.t_NAC2MatchInnerHistory);
			//*END___RECORD matchhistory
		//*END___RECORD nac2record
			SELF.matchcode      := L.matchcode;
			SELF.lexidscore     := L.lexid_score;
			SELF.sequencenumber := L.sequence_number;
			SELF.lexid          := L.did;    //hidden[ecldev]
			SELF._penalty       := L.penalt; //hidden[ecldev]
		END;

		recs_final := PROJECT(nac_recs_complete,tranToNac2record(LEFT));

		iesp.nac2_search.t_NAC2SearchResponse xformOut() := TRANSFORM
			header_row 	 := iesp.ECL2ESP.GetHeaderRow();
			// If the search failed,there will only be one record in the result set
			error_code 	 := nac_recs_complete[1].err_search;
			error_desc 	 := nac_recs_complete[1].err_desc;
			SELF._Header := project(header_row, 
													TRANSFORM(iesp.share.t_ResponseHeader,
														SELF.Exceptions := 
														      DATASET([{'', error_code, '', IF(error_code <> 0, error_desc, '')}], iesp.share.t_WsException);
											      SELF := left));
			SELF.RecordCount 					:= rec_count;
			SELF.Records 							:= recs_final;
		end;

		final_recs := DATASET([xformOut()]);
		RETURN final_recs;
	END;
	
END;