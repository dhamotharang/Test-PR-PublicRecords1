import iesp, ut, AutoStandardI, AutoHeaderI, doxie, suppress, codes, AutokeyI, NID, BankruptcyV3, FCRA, STD,
       PhonesFeedback_Services, PhonesFeedback, AddressFeedback_Services, FraudDefenseNetwork_Services;

export Functions := MODULE
	
	export string gender(string fname, string title) :=  function
		//Changed to key off of Title as data has loaded these and think they are a beter indicator
		//Keeping the old method as a fall back in the event that a title does not exists so we are at least no worst off.
		//Old method is generating too many wrong guesses removing it altogether.
		String getGenderbyTitle := iesp.ECL2ESP.GetGender(title);
		// String getGenderbyLib := CASE(datalib.gender(fname),
																					// 'M' => 'Male',
																					// 'F' => 'Female',
																					// '');
		return getGenderbyTitle;
  end;
		
	export iesp.share.t_SourceDocInfo xformRids(doxie.Layout_Rollup.RidRec L) := transform
		self.SourceDocId	:= 'R' + trim(L.rid) + '$';
		self._Type				:= L.src;
		self._Count				:= L.doccnt;
	end;
	
  export xformSearchRecs(dataset(Layouts.headerRecordExt) in_recs, boolean returnAlsoFound, 
												 boolean phoneSearch, boolean incSourceDocCounts=false, 
												 boolean IncludeAlternatePhonesCount = false, 
												 boolean IncludePhonesPlus = false,
												 boolean IncludePhonesFeedback = false,
												 unsigned SourceDocFilter = 0) := FUNCTION

		tmp_layout := RECORD(Layouts.headerRecordExt)
			string10 subjectSSNIndicator := '';
		end;
									
		recs_ext := project(in_recs, tmp_layout);
		
		iesp.bpssearch.t_BpsSearchPhone xformPhones1(Layouts.PhonesRecWithFeedback l) := TRANSFORM
			 self.Phone10 := l.phone10;
			 self.ListingName := l.listed_name;
			 self.isActive := l.listed;
			 self.timeZone := l.timezone;
			 self.UniqueId := intformat (L.did, 12, 1);
			 self.TypeCell := l.listing_type_cell; 
			 self.TypeResidence := l.listing_type_res; 
			 self.MatchType := l.match_type; 
			 self.GongScore := l.gong_score; 
			 self.NewType := l.new_type; 
			 self.Carrier := l.carrier; 
			 self.CarrierCity := l.carrier_city;
			 self.CarrierState := l.carrier_state; 
			 self.PhoneFirstSeen := iesp.ECL2ESP.toDateYM(l.phone_first_seen);
			 self.PhoneLastSeen := iesp.ECL2ESP.toDateYM(l.phone_last_seen); 
			 self.PhoneFeedback.FeedbackCount := l.feedback[1].feedback_count;
			 self.PhoneFeedback.LastFeedbackResult := l.feedback[1].Last_Feedback_Result;
			 self.PhoneFeedback.LastFeedbackResultProvided := (string8)l.feedback[1].Last_Feedback_Result_Provided;
       self.FDNPhoneInd   := l.fdn_phone_ind; //FDN project addition
			 self := l;
       self := [];
		END;
		
		iesp.bpssearch.t_BpsSearchPhoneInfo xformPhoneInfo2(tmp_layout l) := transform			
		  // for backward compatibility for API customers, need to ensure that phone10 contains the gong phone
		  // if present, and only contains the header phone if gong phone is not present
			// this is a similar fix that was made in the Accurint web (preferring gong phone over header phone)
      self.Phone10 					:= if(l.listed_phone <> '', l.listed_phone, l.phone), 
			self.PubNonpub 				:= l.publish_code,
			self.ListingPhone10 	:= l.listed_phone, 
			self.ListingName 			:= if(l.publish_code<>'N',l.listed_name,''),
			self.TimeZone 				:= l.timezone, 
			self.ListingTimeZone 	:= l.listed_timezone,
			self.ListName.Full 		:= if((l.listing_type_bus='' or l.listing_type_res<>'') and l.publish_code<>'N', l.listed_name, ''),
			self.ListName.First 	:= if((l.listing_type_bus='' or l.listing_type_res<>'') and l.publish_code<>'N', l.listed_name_first, ''),
			self.ListName.Middle 	:= if((l.listing_type_bus='' or l.listing_type_res<>'') and l.publish_code<>'N', l.listed_name_middle, ''), 
			self.ListName.Last 		:= if((l.listing_type_bus='' or l.listing_type_res<>'') and l.publish_code<>'N', l.listed_name_last, ''),
			self.ListName.Suffix 	:= if((l.listing_type_bus='' or l.listing_type_res<>'') and l.publish_code<>'N', l.listed_name_suffix, ''), 
			self.ListName.Prefix 	:= if((l.listing_type_bus='' or l.listing_type_res<>'') and l.publish_code<>'N', l.listed_name_prefix, ''),						
			self.ListCompany 			:= if(l.listing_type_bus<>'' and l.publish_code<>'N', l.listed_name, ''),
			// repeating the name elements here for backward compatibility for API customers
      self.Name.Full 				:= if((l.listing_type_bus='' or l.listing_type_res<>'') and l.publish_code<>'N', l.listed_name, ''),
			self.Name.First 			:= if((l.listing_type_bus='' or l.listing_type_res<>'') and l.publish_code<>'N', l.listed_name_first, ''),
			self.Name.Middle 			:= if((l.listing_type_bus='' or l.listing_type_res<>'') and l.publish_code<>'N', l.listed_name_middle, ''), 
			self.Name.Last 				:= if((l.listing_type_bus='' or l.listing_type_res<>'') and l.publish_code<>'N', l.listed_name_last, ''),
			self.Name.Suffix 			:= if((l.listing_type_bus='' or l.listing_type_res<>'') and l.publish_code<>'N', l.listed_name_suffix, ''), 
			self.Name.Prefix 			:= if((l.listing_type_bus='' or l.listing_type_res<>'') and l.publish_code<>'N', l.listed_name_prefix, ''),	
			self.PhoneFirstSeen 	:= iesp.ECL2ESP.toDateYM(l.phone_first_seen),
			self.PhoneLastSeen 		:= iesp.ECL2ESP.toDateYM(l.phone_last_seen),
			self.PhoneFeedback.FeedbackCount := l.phone_feedback[1].feedback_count;
			self.PhoneFeedback.LastFeedbackResult := l.phone_feedback[1].Last_Feedback_Result;
			self.PhoneFeedback.LastFeedbackResultProvided := (string8)l.phone_feedback[1].Last_Feedback_Result_Provided;
      self.FDNPhoneInd        := if(l.listed_phone <> '', l.fdn_listed_phone_ind, l.fdn_phone_ind),
			self.FDNListingPhoneInd := l.fdn_listed_phone_ind;
      self := [];
		end;
		
		
		
    // **************** MAIN SEARCH TRANSFORM ****************
		iesp.bpssearch.t_BpsSearchRecord xform(tmp_layout l) := transform
		
		   //clean_phone_name := addrcleanlib.CleanPerson73(l.listed_name);
		
			 self._Penalty := l.penalt;
			 self.Verified := l.tnt in ['B', 'V'];
 			 self.UniqueId := l.did;
       self._Type := IF(phoneSearch, 'phone', 'subject');
       self.DateFirstSeen := iesp.ECL2ESP.toDateYM(l.first_seen);
			 self.DateLastSeen := iesp.ECL2ESP.toDateYM(l.last_seen);
			 self.Age := ut.Age(l.dob);
			 self.AgeAtDeath := IF(l.dod<>0 and l.dob<>0, (l.dod-l.dob) div 10000, 0);
			 self.DeathVerificationCode := l.death_code;
			 self.DOB := iesp.ECL2ESP.toDate(l.dob);
			 self.DOD := iesp.ECL2ESP.toDate(l.dod);
			 self.Deceased := l.deceased;
       self.Name := iesp.ECL2ESP.setNameFields(l.fname, l.mname, l.lname, '', l.name_suffix, l.title);
																									 
			 self.AddressEx := iesp.ECL2ESP.setAddressFields(l.prim_name, l.prim_range, l.predir, 
			                                               l.postdir, l.suffix, l.unit_desig, 
																										 l.sec_range, '', l.city_name, '',
																		                 l.st, l.zip, l.zip4, l.county_name, '');
			 self.AddressEx.HighRiskIndicators := project(l.hri_address,transform(iesp.share.t_RiskIndicator,self.RiskCode := left.hri,
																																						self.Description := left.desc)); 																										 
			 self.AddressFeedback.FeedbackCount := l.address_feedback[1].feedback_count,
			 self.AddressFeedback.LastFeedbackResult := l.address_feedback[1].last_feedback_result,
			 self.AddressFeedback.LastFeedbackResultProvided := (string8) l.address_feedback[1].last_feedback_result_provided,			 			 
			 self.AddressVerification := '';  // may not be used
			 self.Gender := gender(l.fname, l.title);
			 self.PhoneInfo2 := if (~(IncludeAlternatePhonesCount or IncludePhonesPlus),	Row(xformPhoneInfo2(l)));
	     //start of adding phonesPlus
			 //create dataset to use for request for alternatePhonesCount or phonesPlus
			 //only 1 unique phone number, keep match_types other than 3 first, then keep listed over non-listed.
			 //this dataset will get resorted prior to loading into self.phones just below.
       setofphones := dedup(sort(l.phones,phone10,if(match_type=personSearch_Services.Constants.type_phones_plus,1,0),-listed),phone10); 			 
			 //*****************************************************************************
			 // setofphones not used yet...will be used to remove phoneplus from counts if found in non-phonesplus source.
			 
	     altPhoneCount := if (IncludeAlternatePhonesCount, count(setofphones(match_type = personSearch_Services.Constants.type_phones_plus)), 0);
			 //filter out phonesPlus rows if they just wanted counts
			 _phones2Use := if (IncludeAlternatePhonesCount, l.phones(match_type <> personSearch_Services.Constants.type_phones_plus), setofphones);
			 // self.Phones := project(l.phones, xformPhones(LEFT));
			 phones2use := project(sort(_phones2use, -listed, if(match_type = personSearch_Services.Constants.type_phones_plus, 1, 0), match_type),
														 transform(Layouts.PhonesRecWithFeedback, self := left, self.feedback := []));			 
			 PhonesFeedback_Services.Mac_Append_Feedback(phones2use
																									,did
																									,phone10
																									,phones2useFB
																									,feedback
																									);
			 phones2useWithFB := if(IncludePhonesFeedback,phones2useFB,phones2use);			 
			 self.Phones := project(phones2useWithFB, xformPhones1(LEFT));
		  //end of adding phonesPlus		 
	
	     begDate := iesp.ECL2ESP.toDate(l.ssn_issue_early_fulldate);
			 endDate := iesp.ECL2ESP.toDate(l.ssn_issue_last_fulldate);
			 self.SSNInfo := Row({l.ssn,l.ssn_valid_issue, 
														l.ssn_issue_state,
														{begDate.Year, begDate.Month, begDate.Day},{endDate.Year, endDate.Month, endDate.Day}},
														iesp.share.t_SSNInfo);
			 self.SubjectSSNIndicator := l.subjectSSNIndicator;
			 fileDate := iesp.ECL2ESP.toDateString8(l.date_filed);
			 dischargeDate := iesp.ECL2ESP.toDateString8(l.disposed_date);
			 self.Bankruptcy := Row({l.court_name,l.court_code,l.case_number,l.filing_type_ex,l.record_type,
															{fileDate.Year, fileDate.Month, fileDate.Day}, 
															{dischargeDate.Year, dischargeDate.Month, dischargeDate.Day}
															}, 
															iesp.bankruptcy.t_BankruptcyInfo);

			 self.AlsoFound := if (returnAlsoFound,
														Row({l.comp_prop_count <> 0,   // property
																 l.veh_cnt <> 0, 				   // vehicle
																 l.prof_count <> 0,			   // prof license
																 l.corp_affil_count <> 0,  // business affiliations	
																 l.phonesplus_count <> 0,  // phones plus
																 l.email_count <> 0,   		 // email 
																 altPhoneCount,            // altPhoneCount 
																 l.accident_count <> 0},   // accident 
																 iesp.bpssearch.t_BpsSearchAlsoFound),
														Row({false,false,false,false,false,false,altPhoneCount,false},iesp.bpssearch.t_BpsSearchAlsoFound));	
			 
			 good_rids 								:= doxie.rid_cnt.rid_filter(L.rids(trim(rid)<>''), SourceDocFilter);
			 self.SourceDocIds				:= if(incSourceDocCounts, project(good_rids, xformRids(left)), dataset([],iesp.share.t_SourceDocInfo));
			 self.SourceCounts.Ids		:= if(incSourceDocCounts, doxie.rid_cnt.rid_cnt(good_rids), 0);
			 self.SourceCounts.Types	:= if(incSourceDocCounts, doxie.rid_cnt.src_cnt(good_rids), 0);
			 self.SourceCounts.Docs		:= if(incSourceDocCounts, doxie.rid_cnt.src_doc_cnt(good_rids), 0);
			 self.HasCriminalConviction := l.HasCriminalConviction;
			 self.IsSexualOffender := l.IsSexualOffender;
       self.FDNUniqueIdInd       := l.fdn_did_ind;  //FDN project addition
       self.FDNAddressInd        := l.fdn_addr_ind; //FDN project addition
       self.FDNSsnInd            := l.fdn_ssn_ind;  //FDN project addition
			 self.FDNWafContribData    := l.fdn_waf_contrib_data; //FDN project addition
			 self.FDNResultsFound      := l.fdn_results_found;    //FDN project addition
			 self.FDNIndicatorsReturned := l.fdn_inds_returned;    // Added for FDN bug 196447
			 self.IsCurrent := l.tnt in iesp.Constants.TNT_CURRENT_SET;
			 self := [];
	  END;
		
		// fill in subjectSSNIndicator from codesV3
		recs_ext lookup_code(recs_ext l, recordof(Codes.Key_Codes_V3) r) := transform
			// CodesV3 has these in all uppercase but the ESP WSDL expects them as all lowercase
			self.subjectSSNIndicator := STD.Str.ToLowerCase(r.long_desc);
			self := l;
		end;
		
		recs_cnv := join(recs_ext,Codes.Key_Codes_V3, 
										 keyed(right.file_name = (string35)'HEADER_MASTER_V5') and 
										 keyed(right.field_name = (string50)'VALID_SSN') and
										 left.valid_ssn = right.code,
										 lookup_code(left,right),left outer, limit(ut.limits.DEFAULT,skip));		

	   	

	  recs_fmtd := project(recs_cnv, xform(LEFT)); 
	
		return recs_fmtd;
	end;
	
  export xformRollupRecs(dataset(Layouts.rollupRecord) in_recs, 
												 boolean includeAlsoFound, 
												 boolean incSourceDocCounts=false, 
												 boolean IncludeAlternatePhonesCount = false, 
												 boolean IncludePhonesFeedback = false, 
												 unsigned SourceDocFilter = 0) := FUNCTION
	
		iesp.share.t_NameWithGender xformNames(Layouts.NameRec l) := TRANSFORM
			self := Row({'',l.fname, l.mname, l.lname, l.name_suffix, l.title, gender(l.fname, l.title)}, 
										iesp.share.t_NameWithGender);
		END;

		iesp.rollupbpssearch.t_RollupBpsSearchSSN xformSSNs(Layouts.SSNRec l) := TRANSFORM
       // Revised the coding below during the FDN project changes to use "self.*** := l.*;" 
			 // instead of "Row", for consistency with most other transforms in this function.
	     self.SSN             := l.ssn;
	     self.Valid           := l.ssn_valid_issue;
	     self.IssuedLocation  := l.ssn_issue_state;
	     self.IssuedStartDate := iesp.ECL2ESP.toDate(l.ssn_issue_early_fulldate);
	     self.IssuedEndDate   := iesp.ECL2ESP.toDate(l.ssn_issue_last_fulldate);
			 self.FDNSsnInd			  := l.fdn_ssn_ind  //FDN project addition
		END;
		
		iesp.rollupbpssearch.t_RollupBpsSearchDL xformDLs(Layouts.DlRec l) := TRANSFORM
			self.DriverLicense := l.dl_num;
			self.OriginState := l.dl_st;
			self.EarliestIssueDate := iesp.ECL2ESP.toDate(l.earliest_lic_issue_date);
			self.LatestExpirationDate := iesp.ECL2ESP.toDate(l.latest_expiration_date);
		END;
	
		iesp.rollupbpssearch.t_RollupBpsSearchDate xformDates(Layouts.DatesRec l) := TRANSFORM
			 self.Age := ut.Age(l.dob);
			 self.AgeAtDeath := IF(l.dod<>0 and l.dob<>0, (l.dod-l.dob) div 10000, 0);
			 self.DeathVerificationCode := l.death_code;
			 self.DOB := iesp.ECL2ESP.toDate(l.dob);
			 self.DOD := iesp.ECL2ESP.toDate(l.dod);		
			 self.deceased := l.deceased;
		END;

		iesp.rollupbpssearch.t_RollupBpsSearchPhone xformPhones(Layouts.PhonesRecWithFeedback l) := TRANSFORM
			 self.Phone10 := l.phone10;
			 self.ListingName := l.listed_name;
			 self.isActive := l.listed;
			 self.timeZone := l.timezone;
			 self.UniqueId := intformat (L.did, 12, 1);
			 self.TypeCell := l.listing_type_cell; 
			 self.TypeResidence := l.listing_type_res; 
			 self.MatchType := l.match_type; 
			 self.GongScore := l.gong_score; 
			 self.NewType := l.new_type; 
			 self.Carrier := l.carrier; 
			 self.CarrierCity := l.carrier_city;
			 self.CarrierState := l.carrier_state; 
			 self.PhoneFirstSeen := iesp.ECL2ESP.toDateYM(l.phone_first_seen);
			 self.PhoneLastSeen := iesp.ECL2ESP.toDateYM(l.phone_last_seen); 
			 self.PhoneFeedback.FeedbackCount := l.feedback[1].feedback_count;
			 self.PhoneFeedback.LastFeedbackResult := l.feedback[1].Last_Feedback_Result;
			 self.PhoneFeedback.LastFeedbackResultProvided := (string8)l.feedback[1].Last_Feedback_Result_Provided;
       self.FDNPhoneInd   := l.fdn_phone_ind; // FDN project addition
			 self := l;
       self := [];
		END;
		
		
		 // **************** MAIN ROLLUP TRANSFORM ****************
		iesp.rollupbpssearch.t_RollupBpsSearchRecord xform(Layouts.rollupRecord l) := transform
			 self._Penalty := l.penalt;
			 self.Verified := l.tnt in ['B', 'V'];
 			 self.UniqueId := l.did;
       self.DateFirstSeen := iesp.ECL2ESP.toDateYM(l.first_seen);
			 self.DateLastSeen := iesp.ECL2ESP.toDateYM(l.last_seen);
			 self.Names := project(l.Names, xformNames(LEFT));
			 self.SSNs := project(l.SSNs, xformSSNs(LEFT));
			 self.DLs := project(l.DLs, xformDLs(LEFT));
			 self.Dates := project(l.Dates, xformDates(LEFT));
			 self.Address := iesp.ECL2ESP.setAddressFields(l.prim_name, l.prim_range, l.predir, 
			                                               l.postdir, l.suffix, l.unit_desig, 
																										 l.sec_range, '', l.city_name, '',
																		                 l.st, l.zip, l.zip4, l.county_name, '');
			 self.Address.HighRiskIndicators := project(l.hri_address,transform(iesp.share.t_RiskIndicator,self.RiskCode := left.hri,
																																					self.Description := left.desc)); 					
			 self.AddressFeedback.FeedbackCount := l.address_feedback[1].feedback_count,
			 self.AddressFeedback.LastFeedbackResult := l.address_feedback[1].last_feedback_result,
			 self.AddressFeedback.LastFeedbackResultProvided := (string8) l.address_feedback[1].last_feedback_result_provided,			 
       altPhoneCount := if (IncludeAlternatePhonesCount, count(l.phones(match_type = personSearch_Services.Constants.type_phones_plus)), 0);
			 //filter out phonesPlus rows if they just wanted counts
			 _phones2Use := if (IncludeAlternatePhonesCount, l.phones(match_type <> personSearch_Services.Constants.type_phones_plus), l.phones);
			 phones2use := project(sort(_phones2use, -listed, if(match_type = personSearch_Services.Constants.type_phones_plus, 1, 0), match_type),
														 transform(Layouts.PhonesRecWithFeedback, self := left, self.feedback := []));			 
			 PhonesFeedback_Services.Mac_Append_Feedback(phones2use
																									,did
																									,phone10
																									,phones2useFB
																									,feedback
																									);
			 phones2useWithFB := if(IncludePhonesFeedback,phones2useFB,phones2use);			 
			 self.Phones := project(phones2useWithFB, xformPhones(LEFT));			 			 
			 
			 // create row to use in special case where phonesPlus count needs to get returned even if includeAlsoFound = false.
			 altPhoneOnlyRow := if (IncludeAlternatePhonesCount,
													 Row({0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
													 0,0,altPhoneCount,0}, iesp.bpssearch.t_BpsRecordCounts));
			 self.Counts := IF(includeAlsoFound,
											     Row({l.veh_cnt,l.dl_cnt,l.head_cnt,l.crim_cnt,l.sex_cnt,l.ccw_cnt,l.rel_count,l.fire_count,
													 l.faa_count,l.prof_count,l.vess_count,l.bus_count,l.paw_count,l.bc_count,l.prop_count,
													 l.prop_asses_count,l.prop_deeds_count,l.bk_count,l.corp_affil_count,l.comp_prop_count,
													 l.phonesplus_count,l.email_count,altPhoneCount,l.accident_count}, iesp.bpssearch.t_BpsRecordCounts),
                           altPhoneOnlyRow);
			 fileDate := iesp.ECL2ESP.toDateString8(l.date_filed);
			 dischargeDate := iesp.ECL2ESP.toDateString8(l.disposed_date);
			 self.Bankruptcy := Row({l.court_name,l.court_code,l.case_number,l.filing_type_ex,l.record_type,
															{fileDate.Year, fileDate.Month, fileDate.Day}, 
															{dischargeDate.Year, dischargeDate.Month, dischargeDate.Day}
															}, 
															iesp.bankruptcy.t_BankruptcyInfo);
			 
			 good_rids 								:= doxie.rid_cnt.rid_filter(L.rids(trim(rid)<>''), SourceDocFilter);
			 self.SourceDocIds				:= if(incSourceDocCounts, project(good_rids, xformRids(left)), dataset([],iesp.share.t_SourceDocInfo));
			 self.SourceCounts.Ids		:= if(incSourceDocCounts, doxie.rid_cnt.rid_cnt(good_rids), 0);
			 self.SourceCounts.Types	:= if(incSourceDocCounts, doxie.rid_cnt.src_cnt(good_rids), 0);
			 self.SourceCounts.Docs		:= if(incSourceDocCounts, doxie.rid_cnt.src_doc_cnt(good_rids), 0);
       self.FDNUniqueIdInd      := l.fdn_did_ind;          // Added for the FDN project
       self.FDNAddressInd       := l.fdn_addr_ind;         // Added for the FDN project
			 self.FDNWafContribData   := l.fdn_waf_contrib_data; // Added for the FDN project
			 self.FDNResultsFound      := l.fdn_results_found;   // Added for the FDN project
			 self.FDNIndicatorsReturned := l.fdn_inds_returned;    // Added for FDN bug 196447
			 self := [];
	  END;
		
	  recs_fmtd := project(in_recs, xform(LEFT)); 
	
		return recs_fmtd;
	end;
	
	export add_ssn_issue(dataset(Layouts.HFS_wide) inrecs) := FUNCTION

		ext_rec := record (Layouts.HFS_wide)
			boolean legacy_ssn := false; // for potentially randomized SSNs defines if SSN-DID pair was seen before
		end;

		// check if SSN was seen before randomization:
		ssn_w_legacy_info := join (inrecs, doxie.key_legacy_ssn,
															keyed (Left.ssn = Right.ssn) AND
															((unsigned6) Left.did = Right.did),
															transform (ext_rec, Self.legacy_ssn := Right.ssn != '', Self := Left),
															LEFT OUTER, KEEP (1), limit (0)); //at most 1 : 1 relation

		layouts.headerRecord getSSNInfo(ext_rec l,doxie.Key_SSN_Map R) := transform
			dcNeeded := Suppress.dateCorrect.do(l.ssn).needed;
   
			// new ssn-issue data have '20990101' for the current date intervals
			r_end := IF (R.end_date='20990101', 0, (unsigned4) R.end_date);

			m_validation := ut.GetSSNValidation (l.ssn);
			boolean is_valid := m_validation.is_valid;
			boolean is_legacy := m_validation.is_valid AND R.ssn5 = '' AND l.legacy_ssn;

			self.ssn_issue_early_fulldate	:= Suppress.dateCorrect.sdate_u4(l.ssn, (unsigned4) R.start_date);
			self.ssn_issue_last_fulldate	:= Suppress.dateCorrect.edate_u4(l.ssn, r_end);
			self.ssn_issue_state					:= Suppress.dateCorrect.state(l.ssn, R.state);
			self.ssn_valid_issue := MAP(l.ssn = '' => '',
																	is_valid and ((integer)l.ssn in doxie.bad_ssn_list) => 'maybe',
																	~is_valid or is_legacy => 'no',
																	'yes');
			self := l;
		end;
   
		result := join (ssn_w_legacy_info, doxie.Key_SSN_Map,
                   keyed (left.ssn[1..5] = Right.ssn5) AND
                   keyed (left.ssn[6..9] between Right.start_serial AND Right.end_serial),
                   getSSNInfo (Left, Right),
                   LEFT OUTER, KEEP (1), limit (0)); //1 : 1 relation
		return result;
	end; 

	export householdRecs(dataset(doxie.Layout_presentation) inrecs) := FUNCTION
	
		dids := project(inrecs, TRANSFORM(doxie.layout_references, SELF.did := (unsigned6) LEFT.did));
		// get all of the household members' DIDs 
		hh_dids := project(doxie.Get_Household_DIDs(dids), TRANSFORM(doxie.layout_references_hh, 
																																 SELF.includedbyHHID := true, SELF := LEFT));
		// get the corresponding header records
		pre_recs := doxie.header_records_byDID(hh_dids, false, false,,false,true,true,false,true);
		// ensure that the household records intersect with lname and address of the subjects' records
		same_addr_recs := join(inrecs, pre_recs, left.lname = right.lname and
																						 ut.NNEQ(left.prim_name,right.prim_name) and
																						 ut.NNEQ(left.prim_range, right.prim_range) and
																						 left.st = right.st, 
																						 TRANSFORM(doxie.Layout_presentation, SELF := RIGHT));
		dedup_addr_recs := dedup(sort(same_addr_recs,record),record);
		
		return dedup_addr_recs;
	end; 

	export ssn_either_name := MODULE
		export params := interface(
			AutoStandardI.InterfaceTranslator.ssn_value.params,
			AutoStandardI.InterfaceTranslator.fname_value.params,
			AutoStandardI.InterfaceTranslator.lname_value.params);
	  end;

		export val(params in_mod) := FUNCTION
			temp_ssn_value := AutoStandardI.InterfaceTranslator.ssn_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.ssn_value.params));
			temp_fname_value := AutoStandardI.InterfaceTranslator.fname_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.fname_value.params));
			temp_lname_value := AutoStandardI.InterfaceTranslator.lname_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.lname_value.params));
		
			return temp_ssn_value <> '' and (temp_lname_value <> '' or temp_fname_value <> '');
		end;
	end;

	export allDidRecs := MODULE
		export params := interface(
			AutoStandardI.InterfaceTranslator.ssn_value.params,
			AutoStandardI.InterfaceTranslator.fname_value.params,
			AutoStandardI.InterfaceTranslator.lname_value.params,
			AutoStandardI.InterfaceTranslator.phone_value.params,
			AutoStandardI.InterfaceTranslator.any_addr_error_value.params,
			AutoStandardI.InterfaceTranslator.did_value.params,
			AutoStandardI.InterfaceTranslator.all_dids.params);
	  end;
		
		export val(params in_mod) := FUNCTION
			temp_fname_value := AutoStandardI.InterfaceTranslator.fname_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.fname_value.params));
			temp_lname_value := AutoStandardI.InterfaceTranslator.lname_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.lname_value.params));
			temp_phone_value := AutoStandardI.InterfaceTranslator.phone_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.phone_value.params));
			temp_any_addr_error_value := AutoStandardI.InterfaceTranslator.any_addr_error_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.any_addr_error_value.params));
			temp_did_value := AutoStandardI.InterfaceTranslator.did_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.did_value.params));
			temp_all_did_records_value := AutoStandardI.InterfaceTranslator.all_dids.val(project(in_mod,AutoStandardI.InterfaceTranslator.all_dids.params));
			temp_ssn_either_name_value := ssn_either_name.val(project(in_mod, ssn_either_name.params));

			address_cleaned := ~temp_any_addr_error_value;
			lname_fname_addr := temp_lname_value <> '' and temp_fname_value <> '' and address_cleaned;
			lname_fname_phone := temp_lname_value <> '' and temp_fname_value <> '' and temp_phone_value <> '';
			did := temp_did_value <> '';

			// need to apply special filtering based on presence of input criteria
			allDIDRecords := lname_fname_addr or lname_fname_phone or did or temp_ssn_either_name_value or temp_all_did_records_value;
			return allDidRecords;
		end;
	end;
	
	export ssnOnly := MODULE
		export params := interface(
			AutoStandardI.InterfaceTranslator.ssn_value.params,
			AutoStandardI.InterfaceTranslator.fname_value.params,
			AutoStandardI.InterfaceTranslator.lname_value.params,
			AutoStandardI.InterfaceTranslator.phone_value.params,
			AutoStandardI.InterfaceTranslator.dob_val.params);
	  end;
		
		export val(params in_mod) := FUNCTION
			temp_ssn_value := AutoStandardI.InterfaceTranslator.ssn_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.ssn_value.params));
			temp_fname_value := AutoStandardI.InterfaceTranslator.fname_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.fname_value.params));
			temp_lname_value := AutoStandardI.InterfaceTranslator.lname_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.lname_value.params));
			temp_phone_value := AutoStandardI.InterfaceTranslator.phone_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.phone_value.params));
			temp_dob_val := AutoStandardI.InterfaceTranslator.dob_val.val(project(in_mod,AutoStandardI.InterfaceTranslator.dob_val.params));

			ssn_only := temp_ssn_value <> '' and temp_fname_value = '' and temp_lname_value = '' and temp_phone_value = '' 
									and temp_dob_val = 0;
			return ssn_only;
		end;
	end;

	export ageOrDOB := MODULE
		export params := interface(
			AutoStandardI.InterfaceTranslator.agelow_val.params,
			AutoStandardI.InterfaceTranslator.agehigh_val.params,
			AutoStandardI.InterfaceTranslator.dob_val.params);
	  end;
		
		export val(params in_mod) := FUNCTION
			temp_agelow_val := AutoStandardI.InterfaceTranslator.agelow_val.val(project(in_mod,AutoStandardI.InterfaceTranslator.agelow_val.params));
			temp_agehigh_val := AutoStandardI.InterfaceTranslator.agehigh_val.val(project(in_mod,AutoStandardI.InterfaceTranslator.agehigh_val.params));
			temp_dob_val := AutoStandardI.InterfaceTranslator.dob_val.val(project(in_mod,AutoStandardI.InterfaceTranslator.dob_val.params));

			age_or_dob := temp_agelow_val <> 0 or temp_agehigh_val <> 0 or temp_dob_val <> 0;
			return age_or_dob;
		end;
	end;
	
	export phoneSearch := MODULE
		export params := interface(
			AutoStandardI.InterfaceTranslator.ssn_value.params,
			AutoStandardI.InterfaceTranslator.lname_value.params,
			AutoStandardI.InterfaceTranslator.phone_value.params);
	  end;
		
		export val(params in_mod) := FUNCTION
			temp_ssn_value := AutoStandardI.InterfaceTranslator.ssn_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.ssn_value.params));
			temp_lname_value := AutoStandardI.InterfaceTranslator.lname_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.lname_value.params));
			temp_phone_value := AutoStandardI.InterfaceTranslator.phone_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.phone_value.params));
			phone_search  := temp_phone_value <> '' and temp_lname_value = '' and temp_ssn_value = '';
			return phone_search;
		end;
	end;

	// compare the trailing n digits of the phone against the input phone (where n is the length of the input phone)
	export phoneMatch(string phone, string in_phone) := FUNCTION
		len_in := length(trim(in_phone));
		len_phone := length(trim(phone));
		len_diff := if (len_phone - len_in > 0, len_phone - len_in, 0);
		return phone[len_diff+1..] = in_phone;
	END;
	
	export filterRecs := MODULE
		export params := interface(
			AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full,
			AutoStandardI.InterfaceTranslator.score_threshold_value.params,
			AutoStandardI.InterfaceTranslator.addr_suffix_value.params,
			AutoStandardI.InterfaceTranslator.StrictMatch_value.params,
			AutoStandardI.InterfaceTranslator.all_dids.params)
			export allowPartialSSNMatch := false;
			export allowEditDist := false;
		end;

		export do(dataset(doxie.Layout_presentation) inrecs,
							params in_mod) := FUNCTION

			ssnOnly := ssnOnly.val(project(in_mod, ssnOnly.params));
			allDIDRecs := allDidRecs.val(project(in_mod, allDidRecs.params));
      allDIDRecsNoFilter := AutoStandardI.InterfaceTranslator.all_dids.val(project(in_mod,AutoStandardI.InterfaceTranslator.all_dids.params));
			fname_trailing := AutoStandardI.InterfaceTranslator.fname_trailing_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.fname_trailing_value.params));
			lname_trailing := AutoStandardI.InterfaceTranslator.lname_trailing_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.lname_trailing_value.params));
			nicknames_val := AutoStandardI.InterfaceTranslator.nicknames.val(project(in_mod,AutoStandardI.InterfaceTranslator.nicknames.params));
			phonetics_val := AutoStandardI.InterfaceTranslator.phonetics.val(project(in_mod,AutoStandardI.InterfaceTranslator.phonetics.params));
			lname_val := AutoStandardI.InterfaceTranslator.lname_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.lname_value.params));
			lname_set_val := AutoStandardI.InterfaceTranslator.lname_set_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.lname_set_value.params));
			cleaned_lname_val := AutoStandardI.InterfaceTranslator.cleaned_input_lname.val(project(in_mod,AutoStandardI.InterfaceTranslator.cleaned_input_lname.params));
			fname_val := AutoStandardI.InterfaceTranslator.fname_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.fname_value.params));
			fname_set_val := AutoStandardI.InterfaceTranslator.fname_set_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.fname_set_value.params));
			mname_val := AutoStandardI.InterfaceTranslator.mname_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.mname_value.params));
			addr_wild := AutoStandardI.InterfaceTranslator.addr_wild.val(project(in_mod,AutoStandardI.InterfaceTranslator.addr_wild.params));
			addr_range := AutoStandardI.InterfaceTranslator.addr_range.val(project(in_mod,AutoStandardI.InterfaceTranslator.addr_range.params));
			prange_val := AutoStandardI.InterfaceTranslator.prange_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.prange_value.params));
			prange_beg_val := AutoStandardI.InterfaceTranslator.prange_beg_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.prange_beg_value.params));
			prange_end_val := AutoStandardI.InterfaceTranslator.prange_end_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.prange_end_value.params));
			prange_wild_val := AutoStandardI.InterfaceTranslator.prange_wild_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.prange_wild_value.params));
			pname_val := AutoStandardI.InterfaceTranslator.pname_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.pname_value.params));
			addr_suffix_val := AutoStandardI.InterfaceTranslator.addr_suffix_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.addr_suffix_value.params));
			secrange_val := AutoStandardI.InterfaceTranslator.sec_range_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.sec_range_value.params));
			city_val := AutoStandardI.InterfaceTranslator.city_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.city_value.params));
			state_val := AutoStandardI.InterfaceTranslator.state_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.state_value.params));
			zipradius_val := AutoStandardI.InterfaceTranslator.zipradius_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.zipradius_value.params));
			zip_val := AutoStandardI.InterfaceTranslator.zip_val.val(project(in_mod,AutoStandardI.InterfaceTranslator.zip_val.params));
			zip_value := AutoStandardI.InterfaceTranslator.zip_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.zip_value.params));
			phone_val := AutoStandardI.InterfaceTranslator.phone_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.phone_value.params));
			dob_val := AutoStandardI.InterfaceTranslator.dob_val.val(project(in_mod,AutoStandardI.InterfaceTranslator.dob_val.params));
			agelow_val := AutoStandardI.InterfaceTranslator.agelow_val.val(project(in_mod,AutoStandardI.InterfaceTranslator.agelow_val.params));
			agehigh_val := AutoStandardI.InterfaceTranslator.agehigh_val.val(project(in_mod,AutoStandardI.InterfaceTranslator.agehigh_val.params));
			score_threshold_value := AutoStandardI.InterfaceTranslator.score_threshold_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.score_threshold_value.params));
			StrictMatch_value := AutoStandardI.InterfaceTranslator.StrictMatch_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.StrictMatch_value.params));
			ssn_value := AutoStandardI.InterfaceTranslator.ssn_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.ssn_value.params));
			useSSNFallback := AutoStandardI.InterfaceTranslator.ssnfallback_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.ssnfallback_value.params));

			// some of the daily fetches pick up additional DIDs that don't match the input well enough
			// and need to be filtered based on the best penalty for the group
			grp_recs := group(sort(inrecs, did), did);
			best_pen := topn(grp_recs, 1, penalt);
			good_dids := project(best_pen(penalt < score_threshold_value), doxie.layout_references);
			good_recs := join(inrecs, good_dids, left.did = right.did);

			unsigned8 todays_date := (unsigned8)STD.Date.Today();
			unsigned8 temp_dob_range_low := if(agehigh_val = 0, 19000101,
													 ((todays_date div 10000 - agehigh_val - 1) * 10000) + ((todays_date % 10000) + 1));
			unsigned8 temp_dob_range_high := if(agelow_val = 0, todays_date,
													 ((todays_date div 10000 - agelow_val) * 10000) + (todays_date % 10000));
      
			// replacing the use of editDistance when comparing SSNs (as it produced to low of a value when 
			// shifts occurred).   
			// this is merely a crude character by character comparison, counting the differences
			ssnDistance(string9 s1, string9 s2) := IF(s1[1] <> s2[1],1,0) +
																						 IF(s1[2] <> s2[2],1,0) +
																						 IF(s1[3] <> s2[3],1,0) +
																						 IF(s1[4] <> s2[4],1,0) +
																						 IF(s1[5] <> s2[5],1,0) +
																						 IF(s1[6] <> s2[6],1,0) +
																						 IF(s1[7] <> s2[7],1,0) +
																						 IF(s1[8] <> s2[8],1,0) +
																						 IF(s1[9] <> s2[9],1,0);
			
			ssn_equiv(string ssn1, string ssn2, boolean hasExactMatch) :=  (unsigned)ssn2<>0 and
			                     ((ssn1 = ssn2)
			                      OR
														// bug #55205
														// only allow loose SSN match if lname was input;
														// this eliminates the issue where the only reason a match was
														// returned on an SSN-only search was due to probation data
	                         ((not hasExactMatch and useSSNFallback and lname_val <> '' and
														// default behavior is to only allow an difference of 2 chars between the input SSN 
														// and the candidate record's SSN unless allowPartialSSNMatch is enabled
													 (in_mod.allowPartialSSNMatch or ssnDistance(ssn1,ssn2) <= 2)
													 and
													 ((unsigned)ssn1 % 10000 = (unsigned)ssn2 % 10000 
													 OR 
													 (unsigned)ssn1 div 10000 = (unsigned)ssn2 div 10000
													 )) 
			                     OR
													 ((unsigned)ssn1 % 10000 = (unsigned)ssn2 % 10000 AND 
													 (((unsigned)ssn1 div 10000) = 0 OR ((unsigned)ssn2 div 10000) = 0))
													 OR
													 // need to handle a first5 SSN input value
													 (length(trim(ssn1)) = 5 AND (unsigned)ssn1 = (unsigned)ssn2 div 10000)
													 ));
		
			recs_filt := good_recs(penalt < score_threshold_value);
			
			dobMatch(unsigned4 dv, unsigned4 db) := FUNCTION
				in_year := dv div 10000;
				in_month := (dv div 100) % 100;
				
				year := db div 10000;
				month := (db div 100) % 100;
	
				match := ut.NNEQ_Int((string)in_year, (string) year) and ut.NNEQ_Int((string)in_month, (string) month);
				return match;
			end;
				
			recs_filt3 := recs_filt(dob_val = 0 or dobMatch(dob_val, dob));
			
			// only do a age range filter if either age_range is non-zero and DOB not present,
			// since DOB is the primary lookup criteria and age range is only used in its absence
			recs_filt4 := recs_filt3((agelow_val = 0 and agehigh_val = 0) or dob_val <> 0 or 
																dob between temp_dob_range_low and temp_dob_range_high);

			PhoneticMatch(string20 l, string20 r) :=
				metaphonelib.DMetaPhone1(l)[1..6] = metaphonelib.DMetaPhone1(r)[1..6];

			recs_filt5 := recs_filt4(lname_val = '' or 
			                        (phonetics_val	and PhoneticMatch(lname,lname_val)) or
															(lname_trailing and 
																(lname[1..length(trim(lname_val))] = lname_val or 
																 lname[1..length(trim(cleaned_lname_val))] = cleaned_lname_val)) or
															 lname in lname_set_val);

			PrefFirstMatch(string20 l, string20 r) :=
				NID.mod_PFirstTools.SUBPFLeqPFR(l,r) or NID.mod_PFirstTools.SUBPFLeqR(l,r);

			recs_filt6 := recs_filt5(fname_val = '' 
			                         or 
															 (nicknames_val and (PrefFirstMatch(fname,fname_val)))
															 or 
															(fname_trailing and fname[1..length(trim(fname_val))] = fname_val) or
															 fname in fname_set_val);

			recs_filt7 := recs_filt6(mname_val = '' or mname[1..length(trim(mname_val))] = mname_val);
			
			// only want partial ssn fallback matching when there is not an exact match in the set
			ssn_match := exists(recs_filt7(ssn=ssn_value));
			
			recs_filt7a := recs_filt7(ssn_value = '' or ssn_equiv(ssn_value, ssn, ssn_match));

			recs_filt8 := recs_filt7a(
			                         (
                                (addr_wild and STD.Str.WildMatch(prim_range, prange_wild_val, true))															
															 OR
															 (addr_range and ((integer)prim_range between (integer)prange_beg_val and (integer)prange_end_val))
															 OR 
															 (prange_val = '' or prim_range = prange_val)
															 ) and 
															 (pname_val = '' or doxie.StripOrdinal(prim_name) = pname_val) and
															 (ut.NNEQ(suffix, addr_suffix_val)) and
															 (ut.NNEQ(sec_range,secrange_val))); 

			// clone of guts of ut.ZipsWithinCity in an effort to get this to compile in prod/qa
			// using the dataset directly, rather than transforming it to a set, only to force it back to
			// a dataset
			zipsWithinCity(string2 st, string25 city) := FUNCTION
				tst := trim(st);
				tcity := trim(city);
				azip := ziplib.CityToZip5(tst,tcity);

				set_acircle := ziplib.ZipsWithinRadius(azip, 50);

				ds_acircle := dataset(set_acircle,{integer4 zip});

				acity := ds_acircle(STD.Str.Find(ziplib.ZipToCities((string5)zip),tcity, 1)>0);
				return acity;
			END;
			
			tmp_rec := RECORD
				integer4 zip;
			END;
			
			tmp_rec checkCityName(tmp_rec l, string25 city) := TRANSFORM
				self.zip := if(STD.Str.Find(ziplib.ZipToCities((string5)l.zip),trim(city), 1)>0, l.zip, skip);
			END;
			
			equiv_cities(string25 city1, string2 st1, string25 city2) := FUNCTION
					city1_zips := ZipsWithinCity(st1, city1);
					any_city_matches := project(city1_zips, checkCityName(LEFT, city2));
					return exists(any_city_matches);
			end;
			
			recs_filt9 := recs_filt8(city_val = '' or state_val = '' or city_name = '' or city_val = city_name or 
															 zipradius_val <> 0 or equiv_cities(city_val, state_val, city_name)); 
						
			 // do a zip match if zip was in the input criteria; do a zipset match if zip radius present
			recs_filt10 := recs_filt9(ut.NNEQ(zip_val, zip) or (zipradius_val <> 0 and (integer4) zip in zip_value)); 

			recs_filt11 := recs_filt10(phone_val = '' or phoneMatch(phone,phone_val) or phoneMatch(listed_phone,phone_val));
			
			// handle SSN + Name search pattern separately (bug 50096)
			// regardless of other criteria, if recs match name and SSN, then let them pass unfiltered otherwise
			
			// bug 58585 -- allow candidate lnames to match any of the component lnames of a hyphenated input lname
			// e.g., Smith-Wesson as input will match Smith or Wesson 
			hyph_names := Std.Str.SplitWords(lname_val, '-');
			has_hyph := STD.Str.Find(lname_val, '-', 1) > 0;
			
			lname_set_use := IF(has_hyph, lname_set_val + hyph_names, lname_set_val);
			
			ssn_name_recs_filt1 := inrecs(lname_val = '' or
																	 (phonetics_val	and PhoneticMatch(lname,lname_val)) or
																	 (lname_trailing and 
																	 (lname[1..length(trim(lname_val))] = lname_val or 
																		lname[1..length(trim(cleaned_lname_val))] = cleaned_lname_val)) or
																		lname in lname_set_use or
																		(in_mod.allowEditDist and 
																			((STD.Str.EditDistance(lname, lname_val) <= 2) or
																			 (STD.Str.Find(trim(lname), trim(lname_val),1) > 0) or
																			 (STD.Str.Find(trim(lname_val), trim(lname),1) > 0))) or
																	 // allow for name flips (even if only one name is present in the input)
																	 // but only when the full ssn is an exact match
																	 ((length(trim(ssn_value)) = 9 and ssn = ssn_value) and
																		((nicknames_val and (PrefFirstMatch(fname,lname_val))) or
																		fname in lname_set_use)));

			ssn_name_recs_filt2 := ssn_name_recs_filt1(fname_val = '' or
																									(nicknames_val and PrefFirstMatch(fname,fname_val))
																									or 
																									(fname_trailing and fname[1..length(trim(fname_val))] = fname_val) or
																									 fname in fname_set_val or
																									 // only allow editDistance match if it wasn't an initial
																									 (in_mod.allowEditDist and length(trim(fname_val)) > 1 and
																										STD.Str.EditDistance(fname, fname_val) <= 1) or
																									 // allow for name flips (even if only one name is present in the input)
																									 // but only when the full ssn is an exact match
																									 ((length(trim(ssn_value)) = 9 and ssn = ssn_value) and
																										((phonetics_val	and PhoneticMatch(lname,fname_val)) or
																										lname in fname_set_val)));

			ssn_match2 := exists(ssn_name_recs_filt2(ssn=ssn_value));

			// bug 55800 -- candidates should match on name and SSN or otherwise be excluded, but
			// records returned only need to match on SSN

			// these are the candidates that match the required SSN + lname + fname (where present)
			ssn_name_recs_filt3 := ssn_name_recs_filt2(ssn_equiv(ssn_value, ssn, ssn_match2));

			// need to use these candidates to get all matching records from the inrecs by DID,
			// then return all of those records that match on SSN
			ssn_name_cands_dids := dedup(sort(project(ssn_name_recs_filt3, doxie.layout_references), did),did);
			ssn_name_cands := join(ssn_name_cands_dids, inrecs, left.did = right.did, transform(right));
			ssn_name_recs := ssn_name_cands(ssn_equiv(ssn_value, ssn, ssn_match2));
	
	
			ssn_either_name_val := ssn_either_name.val(project(in_mod, ssn_either_name.params));
			ssn_lname_fname := ssn_value <> '' and lname_val <> '' and fname_val <> '';
			
			// allow StrictMatch to override the AllDIDRecords functionality
			
			// account for the SSN + Lname + Fname as a special subset of the AllDids functionality 
			//   return all records that match SSN if both Lname and Fname are input (allowing for name flips);
			//   if only Lname or Fname are present, return only the matching records (allowing for name flips)
			outrecs := if (allDIDRecs, 
			               IF(allDIDRecsNoFilter, good_recs,
										    IF(ssn_lname_fname, ssn_name_recs, 
												   IF(ssn_either_name_val, ssn_name_recs_filt3, 
													    IF(StrictMatch_value, recs_filt, good_recs)))), recs_filt11);
			return outrecs;	 
		end;
	end;
	// nameScore function is used for apply a score to a record based on a matrix of rules
	// contained in the excel spreadsheet = certegyEntity2ReturnRules08192011.xlsx
	
	// tfbyDL = total found by DL all records found
	// tfbySSN = total found by SSN all records found
	// fbyDL = found by DL this particular record
	// fbySSN = found by SSN this particular record
	// NM = Name Match this particular record
	export integer  nameScore(integer did_count, integer tfbyDL, integer tfbySSN, integer fbyDL, integer fbySSN, boolean NM) := FUNCTION
   return_val := map(
	  did_count = 1 AND tfbyDL = 1 and tfbySSN = 1 and fbyDL = 1 and fbySSN = 1 and  NM => 1,
    did_count = 1 AND tfbyDL = 1 and tfbySSN = 1 and fbyDL = 1 and fbySSN = 1 and ~NM => 2,                                  		                             
                      tfbyDL > 1 and tfbySSN > 1 and fbyDL = 1 and fbySSN = 1 and  NM => 3,                                  		                             
                      tfbyDL > 1 and tfbySSN > 1 and fbyDL = 1 and fbySSN = 1 and ~NM => 4,                                  		                             
    did_count = 1 AND tfbyDL = 0 and tfbySSN = 1 and fbyDL = 0 and fbySSN = 1 and  NM => 5,                                  		                             
    did_count = 1 AND tfbyDL = 0 and tfbySSN = 1 and fbyDL = 0 and fbySSN = 1 and ~NM => 6,  
    did_count = 1 AND tfbyDL = 1 and tfbySSN = 0 and fbyDL = 1 and fbySSN = 0 and  NM => 7,                                  		                             
    did_count = 1 AND tfbyDL = 1 and tfbySSN = 0 and fbyDL = 1 and fbySSN = 0 and ~NM => 8,                                  		                             
                      tfbyDL = 1 and tfbySSN = 1 and fbyDL = 1 and fbySSN = 1 and NM  => 9,                                  		                             
                      tfbyDL = 1 and tfbySSN = 1 and fbyDL = 0 and fbySSN = 1 and NM  => 10,                                  		                             
                      tfbyDL = 1 and tfbySSN = 1 and fbyDL = 1 and fbySSN = 0 and NM  => 11,                                  		                             
                      tfbyDL = 1 and tfbySSN = 1 and fbyDL = 0 and fbySSN = 1 and ~NM => 12, 
                      tfbyDL > 1 and tfbySSN = 0 and fbyDL = 1 and fbySSN = 0 and  NM => 17,                                  		                             
                      tfbyDL > 1 and tfbySSN = 0 and fbyDL = 1 and fbySSN = 0 and ~NM => 18,   
                      tfbyDL > 1 and tfbySSN = 1 and fbyDL = 1 and fbySSN = 1 and NM  => 19,      																																			                                                                		                             
                      tfbyDL > 1 and tfbySSN = 1 and fbyDL = 0 and fbySSN = 1 and NM  => 20,      																																			                                                                		                             
                      tfbyDL > 1 and tfbySSN = 1 and fbyDL = 1 and fbySSN = 0 and NM  => 21,      																																			 	 	 
                      tfbyDL > 1 and tfbySSN = 1 and fbyDL = 0 and fbySSN = 1 and ~NM => 22,      																																			                                                                		                             
               	      tfbyDL > 1 and tfbySSN > 1 and fbyDL = 1 and fbySSN = 1 and NM  => 23, 
 	                    tfbyDL > 1 and tfbySSN > 1 and fbyDL = 0 and fbySSN = 1 and NM  => 24,                               
 	                    tfbyDL > 1 and tfbySSN > 1 and fbyDL = 1 and fbySSN = 0 and NM  => 25,
                      tfbyDL > 1 and tfbySSN > 1 and fbyDL = 0 and fbySSN = 1 and ~NM => 26,																																			
                      tfbyDL = 0 and tfbySSN > 1 and fbyDL = 0 and fbySSN = 1 and NM  => 27,																																			
	                    tfbyDL = 0 and tfbySSN > 1 and fbyDL = 0 and fbySSN = 1 and ~NM => 28,																																			
                      tfbyDL = 1 and tfbySSN > 1 and fbyDL = 1 and fbySSN = 1 and NM  => 29,	
	                    tfbyDL = 1 and tfbySSN > 1 and fbyDL = 0 and fbySSN = 1 and NM  => 30,		
 	                    tfbyDL = 1 and tfbySSN > 1 and fbyDL = 1 and   NM  => 31,	
 	                    tfbyDL = 1 and tfbySSN > 1 and fbySSN = 1 and ~NM  => 32,	
	  99); 
   RETURN return_val;
	end;

  
  // *** A function to check for the did, address, ssn & phone(s) data (passed in from search_records) 
	//     within the FDN data and then populate 1-6 FDN indicator fields when applicable.
  EXPORT func_FdnCheckSearchRecs (dataset(PersonSearch_Services.Layouts.headerRecordExt) ds_in,
		                              unsigned6 in_gc_id,
																  unsigned2 in_ind_type,
																  unsigned6 in_product_code,
																  boolean FDNContDataPermitted, //comes from DPM bit11
																  boolean FDNInqDataPermitted   //comes from DRM bit25
												         ) := FUNCTION

    // local functions
    func_set_indicator(unsigned3 file_type) := function
	    return FraudDefenseNetwork_Services.Functions.set_indicator(file_type, FDNContDataPermitted, FDNInqDataPermitted); 
    end;

    func_set_waf(unsigned file_type, boolean alreadyWAF =false) := function
    	 return FraudDefenseNetwork_Services.Functions.set_waf(file_type,FDNContDataPermitted,alreadyWAF);
    end;

    // Add sequence # on each input record for use later on.
    PersonSearch_Services.Layouts.rec_headerRecordExt_seq tf_AddSeq(
		  PersonSearch_Services.Layouts.headerRecordExt l, integer c) := transform 
		    self.seq := c;
			  self     := l;
	  end;

		ds_in_seq := project(ds_in, tf_AddSeq(left, counter));

    // First "Normalize" the sequenced input, 5 times to split out the 5 pieces of data 
		// (to be checked for in the FDN data) onto separate records since that is what the new
		// FraudDefenseNetwork_Services function is expecting.
		// Check the counter: when 1 assign did, when 2 assign address fields, 
		//                    when 3 assign ssn, when 4 assign phone, when 5 assign listed_phone
		// Also transforming the data onto the layout needed to be passed into the new FraudDefenseNetwork_Services 
		// function and converting the did field into the type expected by the function.
    FraudDefenseNetwork_Services.Layouts.batch_search_rec  tf_NormAndSlim(
		 PersonSearch_Services.Layouts.rec_headerRecordExt_seq L, integer C) := transform
		   self.did         := choose(C,(unsigned6)L.did,0,0,0);
			 self.prim_range  := choose(C,'',L.prim_range,'','');
			 self.predir      := choose(C,'',L.predir,'','');
			 self.prim_name   := choose(C,'',L.prim_name,'','');
			 self.addr_suffix := choose(C,'',L.suffix,'','');
			 self.postdir     := choose(C,'',L.postdir,'','');
			 self.unit_desig  := choose(C,'',L.unit_desig,'','');
			 self.sec_range   := choose(C,'',L.sec_range,'','');
			 self.v_city_name := choose(C,'',L.city_name,'','');
			 self.st          := choose(C,'',L.st,'','');
			 self.zip5        := choose(C,'',L.zip,'','');
			 self.zip4        := choose(C,'',L.zip4,'','');
			 self.ssn         := choose(C,'','',L.ssn,'');
			 self.phone10     := choose(C,'','','',L.phone, L.listed_phone);
			 self.seq := L.seq;
			 self := [];  // Added for FDN Expanded layout
		end;

		ds_in_seq_norm5slim := normalize(ds_in_seq,5,tf_NormAndSlim(left,counter));

		// Next normalize "n" times (where n = count of number of recs in the "phones" child dataset),
		// to split out the "phones" child dataset records into separate records. 
		// Storing all fields from the "phones" child dataset (for use when denormed later). 
		PersonSearch_Services.Layouts.rec_layout_phones_seq tf_NormPhones(
      PersonSearch_Services.Layouts.rec_headerRecordExt_seq L, integer C) := transform
			  self.seq          := L.seq, 
			  self.phonerec_seq := C, // will be used to put phones back into original order 
        self              := L.phones[C]; // to assign all "phones" child dataset fields
		end;

		ds_in_seq_phones_children := normalize(ds_in_seq,count(left.phones),
		                                       tf_NormPhones(left,counter));

    // Sort/dedup the normed phones children recs to only keep unique phone10 values.
		// Then project onto the layout needed to be passed into the new FraudDefenseNetwork_Services function.
		ds_in_seq_pc_dedup := project(dedup(sort(ds_in_seq_phones_children(phone10!=''),phone10),phone10),
		                              transform(FraudDefenseNetwork_Services.Layouts.batch_search_rec,
															      self.phone10 := left.phone10, // only keep "phones" phones10
																    self         := [] // null all other unused fields
	   														  ));

    // Combine the ds normed for the 5 data pieces to be checked and  
		// the ds of deduped recs normed from the phones child dataset.
		ds_in_seq_normed_combined := ds_in_seq_norm5slim + ds_in_seq_pc_dedup;

    // Filter out records with no data fields to be checked.  Then sort/dedup the records being 
		// passed into the new FraudDefenseNetwork_Services function to remove duplicates.
    ds_in_seq_nc_dedup := dedup(sort(ds_in_seq_normed_combined
		                                   //filter to only include recs with at least 1 piece of data
																	     (did !=0 or ssn !='' or phone10 !='' or 
																		    prim_name !='' or v_city_name !='' or st !='' or zip5 !=''), 
                                     record,except seq),
																record,except seq);

		// Then call new FraudDefenseNetwork_Services function to actually check if any of the 
		// input fields exist in the FDN data.
		ds_in_fdn_chkd := FraudDefenseNetwork_Services.func_CheckForFdnData(ds_in_seq_nc_dedup,
		                                                    in_gc_id,in_ind_type,in_product_code);  


    // Now set any applicable FDN indicators based upon the FraudDefenseNetwork_Services.func_CheckForFdnData results.

    // Transform to rollup the records in the dataset out of multiple joins below, preferring
		// records with fdn inds set "on" over those without.  This had to be added because of using
		// left outer joins below and the right (ds_in_fdn_chkd) ds could have 1 or more records per
		// join element (did, addr, etc.) with different file_type values.  
		// Whereas the original ds_in_seq dataset only has 1 record per sequence #. 
		PersonSearch_Services.Layouts.rec_headerRecordExt_seq tf_rollup_fdn(
		  PersonSearch_Services.Layouts.rec_headerRecordExt_seq l,
			PersonSearch_Services.Layouts.rec_headerRecordExt_seq r) :=transform
			  // keep left fdn ind if set on, otherwise keep right
 	      self.fdn_did_ind          := if(l.fdn_did_ind != 0, l.fdn_did_ind,r.fdn_did_ind);
			  self.fdn_addr_ind         := if(l.fdn_addr_ind != 0, l.fdn_addr_ind,r.fdn_addr_ind);
 	      self.fdn_ssn_ind          := if(l.fdn_ssn_ind != 0, l.fdn_ssn_ind,r.fdn_ssn_ind);
 	      self.fdn_phone_ind        := if(l.fdn_phone_ind != 0, l.fdn_phone_ind,r.fdn_phone_ind);
 	      self.fdn_listed_phone_ind := if(l.fdn_listed_phone_ind != 0, l.fdn_listed_phone_ind,r.fdn_listed_phone_ind);
			  self.fdn_waf_contrib_data := if(l.fdn_waf_contrib_data,l.fdn_waf_contrib_data,r.fdn_waf_contrib_data);
				self := l;
		end;
		
    // First join the ds of sequenced input to the ds above out of the FDN function to set the
		// FDN did indicator and the FDN WAF Contrib data indicator.
    PersonSearch_Services.Layouts.rec_headerRecordExt_seq tf_did_info(
      PersonSearch_Services.Layouts.rec_headerRecordExt_seq l, 
			FraudDefenseNetwork_Services.Layouts.batch_response_rec r) := transform  
	      self.fdn_did_ind := func_set_indicator(r.classification_Permissible_use_access.file_type),
			  self.fdn_waf_contrib_data := func_set_waf(r.classification_Permissible_use_access.file_type),
        self := l
    end;

	  ds_in_seq_with_dInd := join(ds_in_seq, ds_in_fdn_chkd,
														      (unsigned6) left.did = right.did and right.did != 0,
																tf_did_info(left,right),
													      LEFT OUTER); //to keep all input recs whether they had fdn data or not

    // Sort/rollup to only keep 1 rec per seq#
    ds_in_seq_with_dInd_ru := rollup(sort(ds_in_seq_with_dInd, seq), 
		                                   left.seq = right.seq,
                                     tf_rollup_fdn(left,right));
													 
    // Second, join the ds out of first join to the ds above out of the FDN function to next 
		// set the FDN addr indicator and the FDN WAF Contrib data indicator.
    PersonSearch_Services.Layouts.rec_headerRecordExt_seq tf_addr_info(
      PersonSearch_Services.Layouts.rec_headerRecordExt_seq l, 
	    FraudDefenseNetwork_Services.Layouts.batch_response_rec  r) := transform  
			   self.fdn_addr_ind  := func_set_indicator(r.classification_Permissible_use_access.file_type),
			   self.fdn_waf_contrib_data := func_set_waf(r.classification_Permissible_use_access.file_type,
																	                 l.fdn_waf_contrib_data),
		     self := l
    end;
		
	  ds_in_seq_with_daInds := join(ds_in_seq_with_dInd_ru,  ds_in_fdn_chkd,
														        left.prim_range = right.prim_range  and
			                              left.predir     = right.predir      and
			                              left.prim_name  = right.prim_name   and
			                              left.suffix     = right.addr_suffix and
			                              left.postdir    = right.postdir     and
														        left.city_name  = right.v_city_name and	
														        left.st         = right.st          and	
														        left.zip        = right.zip5
																		and 
																	  (right.prim_name != '' or right.v_city_name != '' or
																	   right.st !=''         or right.zip5 !=''),
																	tf_addr_info(left,right),
													        LEFT OUTER); //to keep all input recs whether they had fdn data or not

    // Sort/rollup to only keep 1 rec per seq#
    ds_in_seq_with_daInds_ru := rollup(sort(ds_in_seq_with_daInds, seq), 
		                                     left.seq = right.seq,
                                       tf_rollup_fdn(left,right));
													 
    // Third, join the ds out of second join to the ds above out of the FDN function to next 
		// set the FDN ssn indicator and the FDN WAF indicator.
    PersonSearch_Services.Layouts.rec_headerRecordExt_seq tf_ssn_info(
      PersonSearch_Services.Layouts.rec_headerRecordExt_seq l, 
	    FraudDefenseNetwork_Services.Layouts.batch_response_rec r) := transform  
        self.fdn_ssn_ind := func_set_indicator(r.classification_Permissible_use_access.file_type),
			  self.fdn_waf_contrib_data := func_set_waf(r.classification_Permissible_use_access.file_type,
																	                l.fdn_waf_contrib_data),
        self := l
    end;

	  ds_in_seq_with_dasInds := join(ds_in_seq_with_daInds_ru, ds_in_fdn_chkd,
											               left.ssn = right.ssn and right.ssn != '',
																	 tf_ssn_info(left,right),
													         LEFT OUTER); //to keep all input recs whether they had fdn data or not

    // Sort/rollup to only keep 1 rec per seq#
    ds_in_seq_with_dasInds_ru := rollup(sort(ds_in_seq_with_dasInds, seq), 
		                                     left.seq = right.seq,
                                        tf_rollup_fdn(left,right));
													 
    // Fourth, join the ds out of third join to the ds above out of the FDN function to next 
		// set the FDN phone indicator and the FDN WAF indicator.
    PersonSearch_Services.Layouts.rec_headerRecordExt_seq tf_phone_info(
      PersonSearch_Services.Layouts.rec_headerRecordExt_seq l, 
	    FraudDefenseNetwork_Services.Layouts.batch_response_rec   r) := transform
        self.fdn_phone_ind := func_set_indicator(r.classification_Permissible_use_access.file_type),
			  self.fdn_waf_contrib_data := func_set_waf(r.classification_Permissible_use_access.file_type,
				  													              l.fdn_waf_contrib_data),
        self := l
    end;

	  ds_in_seq_with_daspInds := join(ds_in_seq_with_dasInds_ru, ds_in_fdn_chkd,
																	    left.phone = right.phone10 and right.phone10 !='',
																	  tf_phone_info(left,right),
													          LEFT OUTER); //to keep all input recs whether they had fdn data or not

    // Sort/rollup to only keep 1 rec per seq#
    ds_in_seq_with_daspInds_ru := rollup(sort(ds_in_seq_with_daspInds, seq), 
		                                       left.seq = right.seq,
                                         tf_rollup_fdn(left,right));
																		 
    // Fifth, join the ds out of fourth join to the ds above out of the FDN function to next 
		// set the FDN listed_phone indicator and the FDN WAF indicator.
    PersonSearch_Services.Layouts.rec_headerRecordExt_seq tf_listed_phone_info(
      PersonSearch_Services.Layouts.rec_headerRecordExt_seq l, 
			FraudDefenseNetwork_Services.Layouts.batch_response_rec   r) := transform  
        self.fdn_listed_phone_ind := func_set_indicator(r.classification_Permissible_use_access.file_type),
			  self.fdn_waf_contrib_data := func_set_waf(r.classification_Permissible_use_access.file_type,
																	                l.fdn_waf_contrib_data),
        self := l
    end;
		
    ds_in_seq_with_dasplInds := join(ds_in_seq_with_daspInds_ru, ds_in_fdn_chkd,
														          left.listed_phone = right.phone10 and right.phone10 != '',
																	   tf_listed_phone_info(left,right),
													           LEFT OUTER); //to keep all input recs whether they had fdn data or not

    // Sort/rollup to only keep 1 rec per seq#
    ds_in_seq_with_dasplInds_ru := rollup(sort(ds_in_seq_with_dasplInds, seq), 
		                                        left.seq = right.seq,
                                          tf_rollup_fdn(left,right));
																		 
   // Sixth, join the ds of "phones" children to the ds above out of the FDN function to next 
		// set the FDN phone indicator on the phones child dataset layout
    PersonSearch_Services.Layouts.rec_layout_phones_seq tf_phone_child_info(
      PersonSearch_Services.Layouts.rec_layout_phones_seq l, 
	    FraudDefenseNetwork_Services.Layouts.batch_response_rec   r) := transform  
        self.fdn_phone_ind := func_set_indicator(r.classification_Permissible_use_access.file_type),
			  self.fdn_waf_contrib_data := func_set_waf(r.classification_Permissible_use_access.file_type,
																	                l.fdn_waf_contrib_data),
        self := l
    end;

	  ds_in_seq_pc_with_fdnind := join(ds_in_seq_phones_children, ds_in_fdn_chkd,
																       left.phone10 = right.phone10 and right.phone10 !='', 
																		 tf_phone_child_info(left,right),
													           LEFT OUTER); //to keep all input recs whether they had fdn data or not

    // Transform to rollup the records in the dataset out of the join above, preferring
		// records with fdn inds set "on" over those without.  This had to be added because of using
		// left outer join above and the right (ds_in_fdn_chkd) ds could have 1 or more records per
		// join element (phone) with different file_type values.  
		// Whereas the original ds_in_seq_phones_chlidren dataset only has 1 record per sequence #. 
		PersonSearch_Services.Layouts.rec_layout_phones_seq tf_rollup_fdnpc(
		  PersonSearch_Services.Layouts.rec_layout_phones_seq l,
			PersonSearch_Services.Layouts.rec_layout_phones_seq r) :=transform
			  // keep left fdn ind if set on, otherwise keep right
 	      self.fdn_phone_ind        := if(l.fdn_phone_ind != 0, l.fdn_phone_ind,r.fdn_phone_ind);
			  self.fdn_waf_contrib_data := if(l.fdn_waf_contrib_data,l.fdn_waf_contrib_data,r.fdn_waf_contrib_data);
				self := l;
		end;

    // Sort/rollup to only keep 1 rec per seq#/phonerec_seq
    ds_in_seq_pc_with_fdnind_ru := rollup(sort(ds_in_seq_pc_with_fdnind, seq, phonerec_seq), 
		                                        left.seq          = right.seq and
																					  left.phonerec_seq = right.phonerec_seq,
                                          tf_rollup_fdnpc(left,right));

    // Now denormalize using the sequenced input ds and the interim ds with the phones fdn phone
		// indicator set to re-create the original "phones" child dataset records and setting the   
		// fdn phone indicator for the phone10 field on the "phones" child dataset.
		PersonSearch_Services.Layouts.rec_headerRecordExt_seq   tf_denorm_phones(
		  PersonSearch_Services.Layouts.rec_headerRecordExt_seq l,
		  dataset(PersonSearch_Services.Layouts.rec_layout_phones_seq) r) := transform
		    self.phones := project(r(phone10 !=''),doxie.Layout_phones); // to re-assign all "phones" fields & new fdn_phone_ind
        self.fdn_waf_contrib_data := l.fdn_waf_contrib_data or //if fdn waf already on/true, leave it on
				                             // or if any phones child dataset rec had the fdn waf set on 
        														 exists(r(fdn_waf_contrib_data = true)),
        self.fdn_results_found    := l.fdn_results_found or //if fdn results found already on/true, leave it on
				                             // or if any phones child dataset rec had the fdn ind or waf set on 
        														 exists(r(fdn_phone_ind != 0 or fdn_waf_contrib_data = true)),
        self.fdn_inds_returned    := l.fdn_inds_returned or //if fdn inds returned already on/true, leave it on
				                             // or if any phones child dataset rec had the fdn ind set on 
        														 exists(r(fdn_phone_ind != 0)),
			  self := l;
		end;

		ds_in_seq_denorm_phones := denormalize(ds_in_seq_with_dasplInds_ru, ds_in_seq_pc_with_fdnind_ru,
		                                         left.seq = right.seq,
																		       group,
																		       tf_denorm_phones(left,rows(right)));

		// Final project to strip off seq and to set fdn_results_found (for web use only) and 
		// set fdn_indicators_found (for ESP billing use only).
    boolean AnyFdnIndOrWafWasSet := exists(ds_in_seq_denorm_phones(fdn_did_ind          != 0 or
		                                                               fdn_addr_ind         != 0 or
		                                                               fdn_ssn_ind          != 0 or
	                                                                 fdn_phone_ind        != 0 or
																															     fdn_listed_phone_ind != 0 or
                                                                   fdn_waf_contrib_data      or
																																	 fdn_results_found)); 

    boolean AnyFdnIndWasSet := exists(ds_in_seq_denorm_phones(fdn_did_ind          != 0 or
		                                                          fdn_addr_ind         != 0 or
		                                                          fdn_ssn_ind          != 0 or
	                                                            fdn_phone_ind        != 0 or
																															fdn_listed_phone_ind != 0 or
																															fdn_inds_returned));

		ds_in_with_fdninds := project(ds_in_seq_denorm_phones,
		                              transform(PersonSearch_Services.Layouts.headerRecordExt,
																	  self.fdn_results_found := AnyFdnIndOrWafWasSet,
																	  self.fdn_inds_returned := AnyFdnIndWasSet,
																	  self                   := left));


    // For debugging, uncomment as needed
     //output(ds_in,                 named('ds_in'));
	   //output(in_gc_id,              named('in_gc_id'));
	   //output(in_ind_type,           named('in_ind_type'));
	   //output(in_product_code,       named('in_product_code'));
	   //output(FDNContDataPermitted,  named('FDNContDataPermitted'));
	   //output(FDNInqDataPermitted,   named('FDNInqDataPermitted'));

     //output(ds_in_seq,                 named('ds_in_seq'));
     //output(ds_in_seq_norm5slim,       named('ds_in_seq_norm5slim'));
     //output(ds_in_seq_phones_children, named('ds_in_seq_phones_children'));
		 //output(ds_in_seq_pc_dedup,        named('ds_in_seq_pc_dedup'));
     //output(ds_in_seq_normed_combined, named('ds_in_seq_normed_combined'));
     //output(ds_in_seq_nc_dedup,        named('ds_in_seq_nc_dedup'));
		 //output(ds_in_fdn_chkd,             named('ds_in_fdn_chkd'));
     //output(ds_in_seq_with_dInd,        named('ds_in_seq_with_dInd'));
     //output(ds_in_seq_with_dInd_ru,     named('ds_in_seq_with_dInd_ru'));
		 //output(ds_in_seq_with_daInds,      named('ds_in_seq_with_daInds'));
     //output(ds_in_seq_with_daInds_ru,   named('ds_in_seq_with_daInds_ru'));
     //output(ds_in_seq_with_dasInds,     named('ds_in_seq_with_dasInds'));
     //output(ds_in_seq_with_dasInds_ru,  named('ds_in_seq_with_dasInds_ru'));
     //output(ds_in_seq_with_daspInds,    named('ds_in_seq_with_daspInds'));
     //output(ds_in_seq_with_daspInds_ru, named('ds_in_seq_with_daspInds_ru'));
     //output(ds_in_seq_with_dasplInds,   named('ds_in_seq_with_dasplInds'));
     //output(ds_in_seq_with_dasplInds_ru, named('ds_in_seq_with_dasplInds_ru'));
     //output(ds_in_seq_pc_with_fdnind, named('ds_in_seq_pc_with_fdnind'));
     //output(ds_in_seq_pc_with_fdnInd_ru, named('ds_in_seq_pc_with_fdnind_ru'));
     //output(ds_in_seq_denorm_phones,  named('ds_in_seq_denorm_phones'));
     //output(AnyFdnIndWasSet,          named('AnyFdnIndWasSet'));
     //output(ds_in_with_fdnInds,       named('ds_in_with_fdnInds'));
		
		RETURN ds_in_with_fdninds;
	END; // end of func_FdnCheckSearchRecs


  // *** A function to check for the did, address, ssn(s) & phone(s) data (passed in from 
	// Rollup_Records) within the FDN data and then populate 1-6 FDN indicator fields when applicable.
  EXPORT func_FdnCheckRollupRecs (dataset(PersonSearch_Services.Layouts.rollupRecord) ds_in,
		                              unsigned6 in_gc_id,
																  unsigned2 in_ind_type,
																  unsigned6 in_product_code,
																  boolean FDNContDataPermitted,
																  boolean FDNInqDataPermitted
												         ) := FUNCTION

    // local functions
    func_set_indicator(unsigned3 file_type) := function
	    return FraudDefenseNetwork_Services.Functions.set_indicator(file_type, FDNContDataPermitted, FDNInqDataPermitted); 
    end;

    func_set_waf(unsigned file_type, boolean alreadyWAF =false) := function
    	 return FraudDefenseNetwork_Services.Functions.set_waf(file_type,FDNContDataPermitted,alreadyWAF);
    end;
		
    // Add sequence # on each input record for use later on.
    PersonSearch_Services.Layouts.rec_rollupRecord_seq tf_AddSeq(
		  PersonSearch_Services.Layouts.rollupRecord l, integer c) := transform 
		    self.seq := c;
			  self     := l;
	  end;

		ds_in_seq := project(ds_in, tf_AddSeq(left, counter));

	  // First "Normalize" the sequenced input 2 times to split out the "rollup" parent record 
		// did & address pieces of data (to be checked in the FDN data) onto separate records since
		// that is what the new FraudDefenseNetwork_Services function is expecting.
		// Check the counter: when 1 assign did,  when 2 assign address fields
		// Also transforming the data onto the layout needed to be passed into the new FraudDefenseNetwork_Services 
		// function and converting the did field into the type expected by the function.
    FraudDefenseNetwork_Services.Layouts.batch_search_rec tf_NormAndSlim(
		  PersonSearch_Services.Layouts.rec_rollupRecord_seq L, integer C) := transform
		   self.did         := choose(C,(unsigned6)L.did,0);
			 self.prim_range  := choose(C,'',L.prim_range);
			 self.predir      := choose(C,'',L.predir);
			 self.prim_name   := choose(C,'',L.prim_name);
			 self.addr_suffix := choose(C,'',L.suffix);
			 self.postdir     := choose(C,'',L.postdir); 
			 self.unit_desig  := choose(C,'',L.unit_desig);
			 self.sec_range   := choose(C,'',L.sec_range);
			 self.v_city_name := choose(C,'',L.city_name);
			 self.st          := choose(C,'',L.st);
			 self.zip5        := choose(C,'',L.zip);
			 self.zip4        := choose(C,'',L.zip4);
			 self.ssn         := ''; // null here, will norm "ssns" child ds below to fill in
			 self.phone10     := ''; // null here, will norm "phones" child ds below to fill in
			 self.seq         := L.seq; // to store seq on every record
			 self := [];  // Added for FDN Expanded layout
		end;

		ds_in_seq_norm2slim := normalize(ds_in_seq,2,tf_NormAndSlim(left,counter));

		// Second, normalize "n" times (where n = count of number of recs in the "ssns" child dataset),
		// to split out the "ssns" child dataset records into separate records. 
		// Storing all fields from the "ssns" child dataset (for use when denormed later).
		PersonSearch_Services.Layouts.rec_SsnRec_seq tf_NormSsns(
      PersonSearch_Services.Layouts.rec_rollupRecord_seq L, integer C) := transform
			  self.seq        := L.seq, 
				self.ssnrec_seq := C,  // will be used to put ssns back into original order
        self            := L.ssns[C]; // to assign all "ssns" child dataset fields
		end;

   ds_in_seq_ssns_children := normalize(ds_in_seq,count(left.ssns),tf_NormSSNs(left,counter));	
		
   // Sort/dedup the normed "ssns" children recs to only keep unique ssn values.
	 // Then project onto the layout needed to be passed into the new FraudDefenseNetwork_Services function.
	 ds_in_seq_sc_dedup := project(dedup(sort(ds_in_seq_ssns_children(ssn != ''),ssn),ssn),
		                             transform(FraudDefenseNetwork_Services.Layouts.batch_search_rec,
															      self.ssn := left.ssn, // only keep "ssns" ssn field
																    self     := [] // null all other unused fields
	   														 ));
																	
   // Third, normalize "n" times (where n = count of number of recs in the "phones" child dataset),
	 // to split out the "phones" child dataset records into separate records. 
	 // Storing all fields from the "phones" child dataset (for use when denormed later). 
		PersonSearch_Services.Layouts.rec_layout_phones_seq tf_NormPhones(
      PersonSearch_Services.Layouts.rec_rollupRecord_seq L, integer C) := transform
			  self.seq          := L.seq, 
			  self.phonerec_seq := C, // will be used to put phones back into original order 
        self              := L.phones[C]; // to assign all "phones" child dataset fields
		end;

		ds_in_seq_phones_children := normalize(ds_in_seq,count(left.phones),
		                                       tf_NormPhones(left,counter));

    // Sort/dedup the normed "phones" children recs to only keep unique phone10 values.
		// Then project onto the layout needed to be passed into the new FraudDefenseNetwork_Services function.
		ds_in_seq_pc_dedup := project(dedup(sort(ds_in_seq_phones_children(phone10 !=''),phone10),phone10),
		                              transform(FraudDefenseNetwork_Services.Layouts.batch_search_rec,
															      self.phone10 := left.phone10, // only keep "phones" phones10
																    self         := [] // null all other unused fields
	   														  ));

    // Combine the ds normed for the parent rec 2 data pieces to be checked and  
		// the ds of deduped recs normed from the "ssns" child dataset and  
		// the ds of deduped recs normed from the "phones" child dataset.
		ds_in_seq_normed_combined := ds_in_seq_norm2slim + ds_in_seq_sc_dedup + ds_in_seq_pc_dedup;

    // Sort/dedup the records being passed into the new FDN function to remove duplicates.
    ds_in_seq_nc_dedup := dedup(sort(ds_in_seq_normed_combined 
		                                   // filter to only include recs with at least 1 piece of data
																	     (did !=0 or ssn !='' or phone10 !='' or 
																			  prim_name !='' or v_city_name !='' or st !='' or zip5 !=''),
                                     record,except seq),
																record,except seq);

		// Then call the new FraudDefenseNetwork_Services function to actually check if any of the 4 passed in 
		// fields exist within the FDN data.
    ds_in_fdn_chkd := FraudDefenseNetwork_Services.func_CheckForFdnData(ds_in_seq_nc_dedup,
		                                                    in_gc_id,in_ind_type,in_product_code);  


    // Now set any applicable FDN indicators based upon the FraudDefenseNetwork_Services.func_CheckForFdnData results.
		//
    // Transform to rollup the records in the dataset out of multiple joins below, preferring
		// records with fdn inds set "on" over those without.  This had to be added because of using
		// left outer joins below and the right (ds_in_fdn_chkd) ds could have 1 or more records per
		// join element (did, addr, etc.) with different file_type values.  
		// Whereas the original ds_in_seq dataset only has 1 record per sequence #. 
		PersonSearch_Services.Layouts.rec_rollupRecord_seq tf_rollup_fdn(
		  PersonSearch_Services.Layouts.rec_rollupRecord_seq l,
			PersonSearch_Services.Layouts.rec_rollupRecord_seq r) :=transform
			  // keep left fdn ind if set on, otherwise keep right
 	      self.fdn_did_ind          := if(l.fdn_did_ind != 0, l.fdn_did_ind,r.fdn_did_ind);
			  self.fdn_addr_ind         := if(l.fdn_addr_ind != 0, l.fdn_addr_ind,r.fdn_addr_ind);
			  self.fdn_waf_contrib_data := if(l.fdn_waf_contrib_data,l.fdn_waf_contrib_data,r.fdn_waf_contrib_data);
				self := l;
		end;
		
    // First join the ds of sequenced input to the ds above out of the FDN function to set the
		// FDN did indicator and the FDN WAF Contrib data indicator.
	  PersonSearch_Services.Layouts.rec_rollupRecord_seq tf_did_info(
      PersonSearch_Services.Layouts.rec_rollupRecord_seq l, 
	    FraudDefenseNetwork_Services.Layouts.batch_response_rec r) := transform  
	      self.fdn_did_ind := func_set_indicator(r.classification_Permissible_use_access.file_type),
			  self.fdn_waf_contrib_data := func_set_waf(r.classification_Permissible_use_access.file_type),
        self := l
    end;

	  ds_in_seq_with_dInd := join(ds_in_seq, ds_in_fdn_chkd,
														      (unsigned6) left.did = right.did and right.did !=0,
																tf_did_info(left,right),
													      LEFT OUTER); //to keep all input(left ds) recs whether they had fdn data or not

    // Sort/rollup to only keep 1 rec per seq#
    ds_in_seq_with_dInd_ru := rollup(sort(ds_in_seq_with_dInd, seq), 
		                                   left.seq = right.seq,
                                     tf_rollup_fdn(left,right));
													 
    // Second, join the ds out of first join to the ds above out of the FDN function to next 
		// set the FDN addr indicator and the FDN WAF indicator.
     PersonSearch_Services.Layouts.rec_rollupRecord_seq tf_addr_info(
       PersonSearch_Services.Layouts.rec_rollupRecord_seq l, 
	     FraudDefenseNetwork_Services.Layouts.batch_response_rec  r) := transform  
			   self.fdn_addr_ind  := func_set_indicator(r.classification_Permissible_use_access.file_type),
			   self.fdn_waf_contrib_data := func_set_waf(r.classification_Permissible_use_access.file_type,
																	                 l.fdn_waf_contrib_data),
		     self := l
    end;

	  ds_in_seq_with_daInds := join(ds_in_seq_with_dInd_ru, ds_in_fdn_chkd,
														        left.prim_range = right.prim_range  and
			                              left.predir     = right.predir      and
			                              left.prim_name  = right.prim_name   and
			                              left.suffix     = right.addr_suffix and
			                              left.postdir    = right.postdir     and
														        left.city_name  = right.v_city_name and	
														        left.st         = right.st          and	
														        left.zip        = right.zip5
																		and 
																		(right.prim_name != '' or right.v_city_name != '' or
																		 right.st !=''         or right.zip5 !=''),
																	tf_addr_info(left,right),
													        LEFT OUTER); //to keep all input recs whether they had fdn data or not

    // Sort/rollup to only keep 1 rec per seq#
    ds_in_seq_with_daInds_ru := rollup(sort(ds_in_seq_with_daInds, seq), 
		                                     left.seq = right.seq,
                                       tf_rollup_fdn(left,right));

    // Third, join the ds of "ssns" children to the ds above out of the FDN function to next 
		// set the FDN ssn indicator and the FDN WAF indicator) on the "ssns" child dataset layout
    PersonSearch_Services.Layouts.rec_ssnRec_seq tf_ssn_info(
      PersonSearch_Services.Layouts.rec_ssnRec_seq l, 
	    FraudDefenseNetwork_Services.Layouts.batch_response_rec r) := transform  
        self.fdn_ssn_ind := func_set_indicator(r.classification_Permissible_use_access.file_type),
			  self.fdn_waf_contrib_data := func_set_waf(r.classification_Permissible_use_access.file_type,
																	                l.fdn_waf_contrib_data),
        self := l
    end;

	  ds_in_seq_sc_with_fdnind := join(ds_in_seq_ssns_children, ds_in_fdn_chkd,
											                 left.ssn = right.ssn and right.ssn != '',
																	 tf_ssn_info(left,right),
													         LEFT OUTER); //to keep all input recs whether they had fdn data or not

    // Transform to rollup the records in the dataset out of the join above, preferring
		// records with fdn inds set "on" over those without.  This had to be added because of using
		// left outer join above and the right (ds_in_fdn_chkd) ds could have 1 or more records per
		// join element (phone) with different file_type values.  
		// Whereas the original ds_in_seq_phones_chlidren dataset only has 1 record per sequence #. 
		PersonSearch_Services.Layouts.rec_ssnRec_seq tf_rollup_fdnsc(
		  PersonSearch_Services.Layouts.rec_ssnRec_seq l,
			PersonSearch_Services.Layouts.rec_ssnRec_seq r) :=transform
			  // keep left fdn ind if set on, otherwise keep right
 	      self.fdn_ssn_ind          := if(l.fdn_ssn_ind != 0, l.fdn_ssn_ind,r.fdn_ssn_ind);
			  self.fdn_waf_contrib_data := if(l.fdn_waf_contrib_data,l.fdn_waf_contrib_data,r.fdn_waf_contrib_data);
				self := l;
		end;

    // Sort/rollup to only keep 1 rec per seq#
    ds_in_seq_sc_with_fdnind_ru := rollup(sort(ds_in_seq_sc_with_fdnind, seq, ssnrec_seq), 
		                                        left.seq        = right.seq and
		                                        left.ssnrec_seq = right.ssnrec_seq,
                                          tf_rollup_fdnsc(left,right));

    // Fourth, join the ds of "phones" children to the ds above out of the FDN function to next 
		// set the FDN phone indicator and the FDN WAF indicator) on the "phones" child dataset layout.
    PersonSearch_Services.Layouts.rec_layout_phones_seq tf_phone_info(
      PersonSearch_Services.Layouts.rec_layout_phones_seq l, 
	    FraudDefenseNetwork_Services.Layouts.batch_response_rec   r) := transform  
        self.fdn_phone_ind := func_set_indicator(r.classification_Permissible_use_access.file_type),
			  self.fdn_waf_contrib_data := func_set_waf(r.classification_Permissible_use_access.file_type,
				  													              l.fdn_waf_contrib_data),
        self := l
    end;

	  ds_in_seq_pc_with_fdnind := join(ds_in_seq_phones_children, ds_in_fdn_chkd,
																       left.phone10 = right.phone10 and right.phone10 !='',
																		 tf_phone_info(left,right),
													           LEFT OUTER); //to keep all input recs whether they had fdn data or not
 
    // Transform to rollup the records in the dataset out of the join above, preferring
		// records with fdn inds set "on" over those without.  This had to be added because of using
		// left outer join above and the right (ds_in_fdn_chkd) ds could have 1 or more records per
		// join element (phone) with different file_type values.  
		// Whereas the original ds_in_seq_phones_chlidren dataset only has 1 record per sequence #. 
		PersonSearch_Services.Layouts.rec_layout_phones_seq tf_rollup_fdnpc(
		  PersonSearch_Services.Layouts.rec_layout_phones_seq l,
			PersonSearch_Services.Layouts.rec_layout_phones_seq r) :=transform
			  // keep left fdn ind if set on, otherwise keep right
 	      self.fdn_phone_ind          := if(l.fdn_phone_ind != 0, l.fdn_phone_ind,r.fdn_phone_ind);
			  self.fdn_waf_contrib_data := if(l.fdn_waf_contrib_data,l.fdn_waf_contrib_data,r.fdn_waf_contrib_data);
				self := l;
		end;

    // Sort/rollup to only keep 1 rec per seq#
    ds_in_seq_pc_with_fdnind_ru := rollup(sort(ds_in_seq_pc_with_fdnind, seq, phonerec_seq), 
		                                        left.seq          = right.seq and
																					  left.phonerec_seq = right.phonerec_seq,
                                          tf_rollup_fdnpc(left,right));

    // First denormalize using the sequenced input ds with 2 fdn inds set and the interim ds with
		// the "ssns" fdn ssn indicator set to re-create the original "ssns" child dataset records 
		// with the fdn ssn ind for all the records on the "ssns" child dataset.
		PersonSearch_Services.Layouts.rec_rollupRecord_seq    tf_denorm_ssns(
		  PersonSearch_Services.Layouts.rec_rollupRecord_seq l,
		  dataset(PersonSearch_Services.Layouts.rec_SsnRec_seq) r) := transform
		    self.ssns := project(r(ssn !=''), //so empty ssn recs don't get output
											       PersonSearch_Services.Layouts.SsnRec); // to re-assign all "ssns" fields & new fdn ssn ind
       self.fdn_waf_contrib_data := l.fdn_waf_contrib_data or //if fdn waf already on/true, leave it on
				                            // or if any ssns child dataset rec had the fdn waf set on 
        														exists(r(fdn_waf_contrib_data = true)),
       self.fdn_results_found := l.fdn_results_found or //if fdn results found already on/true, leave it on
																 // or if any ssns child dataset rec had the fdn ind or waf set on 
        												 exists(r(fdn_ssn_ind != 0 or fdn_waf_contrib_data = true)),
       self.fdn_inds_returned := l.fdn_inds_returned or //if fdn inds returned already on/true, leave it on
				                         // or if any ssns child dataset rec had the fdn ind set on 
        												 exists(r(fdn_ssn_ind != 0)),
			  self := l;
		end;

		ds_in_seq_denorm_ssns   := denormalize(ds_in_seq_with_daInds_ru, ds_in_seq_sc_with_fdnind_ru,
		                                          left.seq = right.seq,
																		       group,
																		       tf_denorm_ssns(left,rows(right)));

    // Next denormalize using the ds with fdn inds & denormed ssns and the interim ds with
		// the "phones" fdn phone indicator set to re-create the original "phones" child dataset 
		// records with the fdn phone ind for all the records on the "phones" child dataset.
		PersonSearch_Services.Layouts.rec_rollupRecord_seq    tf_denorm_phones(
		  PersonSearch_Services.Layouts.rec_rollupRecord_seq l,
		  dataset(PersonSearch_Services.Layouts.rec_layout_phones_seq) r) := transform
		    self.phones := project(r(phone10 !=''), //so empty phones recs don't get output 
											         PersonSearch_Services.Layouts.PhonesRec); // to re-assign all "phones" fields & new fdn ssn ind
        self.fdn_waf_contrib_data := l.fdn_waf_contrib_data or //if fdn waf already on/true, leave it on
				                             // or if any ssns child dataset rec had the fdn waf set on 
        														 exists(r(fdn_waf_contrib_data = true)),
        self.fdn_results_found    := l.fdn_results_found or //if fdn results found already on/true, leave it on
				                             // or if any phones child dataset rec had the fdn ind or waf set on 
        														 exists(r(fdn_phone_ind != 0 or fdn_waf_contrib_data = true)),
        self.fdn_inds_returned    := l.fdn_inds_returned or //if fdn inds returned already on/true, leave it on
				                             // or if any phones child dataset rec had the fdn ind set on 
        														 exists(r(fdn_phone_ind != 0)),
			  self := l;
		end;

		ds_in_seq_denorm_phones := denormalize(ds_in_seq_denorm_ssns, ds_in_seq_pc_with_fdnind_ru,
		                                          left.seq = right.seq,
																		       group,
																		       tf_denorm_phones(left,rows(right)));

		// Final project to strip off seq and to set fdn_results_found (for web use only) and 
		// set fdn_indicators_found (for ESP billing use only).
    boolean AnyFdnIndorWafWasSet := exists(ds_in_seq_denorm_phones(fdn_did_ind  != 0    or
		                                                               fdn_addr_ind != 0    or
                                                                   fdn_waf_contrib_data or
																													         fdn_results_found)); 

    boolean AnyFdnIndWasSet := exists(ds_in_seq_denorm_phones(fdn_did_ind  != 0 or
                                                              fdn_addr_ind != 0 or
																														  fdn_inds_returned));

		ds_in_with_fdninds := project(ds_in_seq_denorm_phones,
		                              transform(PersonSearch_Services.Layouts.rollupRecord,
																	  self.fdn_results_found := AnyFdnIndOrWafWasSet,
																	  self.fdn_inds_returned := AnyFdnIndWasSet,
																	  self                   := left));

    // For debugging, uncomment as needed
     //output(ds_in,                 named('ds_in'));
	   //output(in_gc_id,              named('in_gc_id'));
	   //output(in_ind_type,           named('in_ind_type'));
	   //output(in_product_code,       named('in_product_code'));
	   //output(FDNContDataPermitted,  named('FDNContDataPermitted'));
	   //output(FDNInqDataPermitted,   named('FDNInqDataPermitted'));

     //output(ds_in_seq,                 named('ds_in_seq'));
     //output(ds_in_seq_norm2slim,       named('ds_in_seq_norm2slim'));
     //output(ds_in_seq_ssns_children,   named('ds_in_seq_ssns_children'));
     //output(ds_in_seq_phones_children, named('ds_in_seq_phones_children'));
		 //output(ds_in_seq_sc_dedup,        named('ds_in_seq_sc_dedup'));
		 //output(ds_in_seq_pc_dedup,        named('ds_in_seq_pc_dedup'));
     //output(ds_in_seq_normed_combined, named('ds_in_seq_normed_combined'));
     //output(ds_in_seq_nc_dedup,        named('ds_in_seq_nc_dedup'));
		 //output(ds_in_fdn_chkd,            named('ds_in_fdn_chkd'));
     //output(ds_in_seq_with_dInd,       named('ds_in_seq_with_dInd'));
     //output(ds_in_seq_with_dInd_ru,    named('ds_in_seq_with_dInd_ru'));
     //output(ds_in_seq_with_daInds,     named('ds_in_seq_with_daInds'));
     //output(ds_in_seq_with_daInds_ru,  named('ds_in_seq_with_daInds_ru'));
		 //output(ds_in_seq_sc_with_fdnind,  named('ds_in_seq_sc_with_fdnind'));
     //output(ds_in_seq_sc_with_fdnInd_ru, named('ds_in_seq_sc_with_fdnind_ru'));
     //output(ds_in_seq_pc_with_fdnind,  named('ds_in_seq_pc_with_fdnind'));
     //output(ds_in_seq_pc_with_fdnInd_ru, named('ds_in_seq_pc_with_fdnind_ru'));
     //output(ds_in_seq_denorm_ssns,     named('ds_in_seq_denorm_ssns'));
     //output(ds_in_seq_denorm_phones,   named('ds_in_seq_denorm_phones'));
     //output(AnyFdnIndWasSet,           named('AnyFdnIndWasSet'));
     //output(ds_in_with_fdnInds,        named('ds_in_with_fdnInds'));
		
		RETURN ds_in_with_fdninds;
	END; // end of func_FdnCheckRollupRecs

  // Function to check if bankruptcy exists for Pick list records
  // We will have to use non-fcra key as pick list runs on neutral roxie
  // After running pick list, customer will run FCRA bankruptcy search
  // Hence, need to make sure that the bankruptcy record doesn't exceed the 7 year time limit
  EXPORT GetBankruptcyFlag(DATASET(iesp.person_picklist.t_PersonPickListRecord) dIn) :=
  FUNCTION
    rPickListBankruptcy :=
    RECORD(iesp.person_picklist.t_PersonPickListRecord)
      BankruptcyV3.key_bankruptcyV3_did().tmsid;
      boolean _HasBankruptcy := FALSE;
    END;
	
    dBankruptcyIds := JOIN(dIn, BankruptcyV3.key_bankruptcyV3_did(),
                            KEYED((unsigned)LEFT.UniqueId = RIGHT.did),
                            TRANSFORM(rPickListBankruptcy,
                                      SELF.tmsid := RIGHT.tmsid,
                                      SELF       := LEFT),
                            LEFT OUTER,
                            LIMIT(0), KEEP(1));

    dBankruptcyMain := JOIN(dBankruptcyIds, BankruptcyV3.key_bankruptcyV3_main_full(),
                            KEYED(LEFT.tmsid = RIGHT.tmsid) AND fcra.bankrupt_is_ok((string)STD.Date.Today(), right.date_filed),
                            TRANSFORM(rPickListBankruptcy,
                                      SELF._HasBankruptcy := RIGHT.tmsid != '',
                                      SELF.tmsid          := RIGHT.tmsid,
                                      SELF                := LEFT),
                            LEFT OUTER,
                            LIMIT(0), KEEP(1));
    
    RETURN dBankruptcyMain;
  END;

end;
