IMPORT doxie, ut, iesp, Suppress, header, AutoStandardI, DeathV2_Services;

export split_Residents (DATASET(doxie.layout_best) ds_all_records_tmp, 
	                      DATASET(AddressReport_Services.layouts.in_address) m_AddrInfo,
												AddressReport_Services.input._addressreport param) := MODULE
	
	SHARED MatchOnAddressCriteria(DATASET(AddressReport_Services.layouts.residents_final_out) ds_first_cut, 
																DATASET(AddressReport_Services.layouts.in_address) m_AddrInfo, 
																BOOLEAN valid_addr_city_state, BOOLEAN valid_addr_zip) :=
	FUNCTION
					
		ds_large_area_matches := 
								MAP( valid_addr_zip        => ds_first_cut( zip  =  m_AddrInfo[1].zip ),
										 valid_addr_city_state => ds_first_cut(ut.NNEQ(city_name, m_AddrInfo[1].p_city_name) AND
																													 ut.NNEQ(st,        m_AddrInfo[1].st))
										);
		
		ds_address_matches := ds_large_area_matches( ut.NNEQ(prim_name,  m_AddrInfo[1].prim_name) AND
																								 ut.NNEQ(prim_range, m_AddrInfo[1].prim_range) AND
																								 ut.NNEQ(predir,     m_AddrInfo[1].predir) AND
																								 ut.NNEQ(suffix,     m_AddrInfo[1].suffix) AND
																								 ut.NNEQ(postdir,    m_AddrInfo[1].postdir) AND
																								 ut.NNEQ(sec_range,  m_AddrInfo[1].sec_range) );
		RETURN ds_address_matches;
		
	END;
		
	//********************************************************************************************************		
  export AddressReport_Services.layouts.residents_final_out add_akas (DATASET(doxie.layout_best) resi_input):=function
		suppressDMVInfo_value := AutoStandardI.GlobalModule().suppressDMVInfo;
    main_record := record (AddressReport_Services.layouts.resident_best_layout)
      boolean is_best := true;
      boolean legacy_ssn := false; //for potentially randomized SSNs defines if SSN-DID pair was seen before
    end;
  
    hrecs_raw := join (resi_input, doxie.Key_Header,
											 KEYED(LEFT.did = RIGHT.s_did)
											 and LEFT.prim_name = RIGHT.prim_name
											 and LEFT.st = RIGHT.st
											 and ~Doxie.DataRestriction.isHeaderSourceRestricted(right.src),
											 transform(right),
											 limit(ut.limits.DEFAULT));
									 
		hrecs_filt := Header.FilterDMVInfo(hrecs_raw);
		hrecs0 := if(suppressDMVInfo_value, hrecs_filt, hrecs_raw);
		
    main_record get_header_recs(doxie.Key_Header R) := transform
      self.is_best := false;
      self.name_suffix := if (R.name_suffix ='UNK','',R.name_suffix);
      self.prim_name   := if (R.src in ['DE', 'DS'],'',R.prim_name);
      self.dod:=(string) R.dod;
      self.age := if (R.dob = 0, 0, ut.Age(R.dob));
			self.addr_dt_first_seen := R.dt_first_seen;
			self.addr_dt_last_seen	:= R.dt_last_seen;
      self := R;
    end;
		
		hrecs := project(hrecs0, get_header_recs(left));
		
    // this defines which AKAs we consider to be the same.
    all_names := hrecs + project (resi_input, main_record); 
    resi_srt := sort (all_names, did, lname, fname, mname, name_suffix, -ssn, -dob, ~is_best);
    resi    := dedup (resi_srt,  did, lname, fname, mname, name_suffix, 
                      Left.ssn = Right.ssn or (Right.ssn = ''), Left.dob = Right.dob or (Right.dob = 0));

    // check if SSN was seen before randomization:
    ssn_w_legacy_info := join (resi, doxie.key_legacy_ssn,
                               keyed (Left.ssn = Right.ssn) AND
                               (Left.did = Right.did),
                               transform (main_record, Self.legacy_ssn := Right.ssn != '', Self := Left),
                               LEFT OUTER, KEEP (1), limit (0)); //at most 1 : 1 relation

    // get SSN data, create into esdl-alike layout        
    AddressReport_Services.layouts.resident_layout AddIssuance (main_record L, doxie.Key_SSN_Map R) := transform
      Self.did := L.did;
      Self.Identity.UniqueID := intformat (L.did, 12, 1);
      Self.Identity.Name := iesp.ECL2ESP.SetName (L.fname, L.mname, L.lname, L.name_suffix, L.title);

      // new ssn-issue data have '20990101' for the current date intervals
      r_end := IF (R.end_date='20990101', 0, (unsigned4) R.end_date);
      ssn_issue_early  := Suppress.dateCorrect.sdate_u4(L.ssn, (unsigned4) R.start_date);
      ssn_issue_last  := Suppress.dateCorrect.edate_u4(L.ssn, r_end);
      IssuedStart := iesp.ECL2ESP.toDate (ssn_issue_early);
      IssuedEnd   := iesp.ECL2ESP.toDate (ssn_issue_last);

			m_validation := ut.GetSSNValidation (l.ssn);
			boolean is_valid := m_validation.is_valid;
      boolean is_legacy := m_validation.is_valid AND R.ssn5 = '' AND l.legacy_ssn;
      valid_pre := (is_valid and not is_legacy and ((integer)L.ssn not in doxie.bad_ssn_list)); 
      valid := Suppress.dateCorrect.valid (L.ssn, valid_pre);
      ssn_issue_place  := Suppress.dateCorrect.state (L.ssn, R.state);
      Self.Identity.SSNInfo   := [];
      Self.Identity.SSNInfoEx := iesp.ECL2ESP.SetSSNInfoEx (L.ssn, if (valid, 'YES', 'NO'), ssn_issue_place, 
                                      IssuedStart, IssuedEnd);

      Self.Identity.DOB := iesp.ECL2ESP.toDate (L.dob);
      Self.Identity.Age := L.age;
      Self.Identity.Gender := iesp.ECL2ESP.GetGender (L.title);
      Self.Identity := []; //DOD, AgeAtDeath, DeathCounty, DeathVerificationCode
      Self := L;
    end;

    res_w_issuance := join(ssn_w_legacy_info, doxie.Key_SSN_Map,
                           keyed (left.ssn[1..5] = Right.ssn5) AND
                           keyed (left.ssn[6..9] between Right.start_serial AND Right.end_serial), //between is inclusive
                           AddIssuance(left,right),
                           left outer, KEEP (1), limit (0)); //m:1 relation

    AddressReport_Services.layouts.resident_layout GetDead (res_w_issuance L, doxie.key_death_masterV2_ssa_DID R):=transform
      // we prefer DOB from header, if valid for the purpose 
      DOB := L.Identity.DOB;
      left_dob := (string4) DOB.year + intformat (DOB.month, 2, 1) + intformat (DOB.day, 2, 1);
      d_birth := (unsigned) if (DOB.year != 0 and DOB.month != 0, left_dob, r.dob8);
      d_death := (unsigned) r.dod8;
      Self.Identity.DOD := iesp.ECL2ESP.toDatestring8 (r.dod8);
      Self.Identity.DeathVerificationCode := r.vorp_code; //death_code in header index
      Self.Identity.AgeAtDeath := if (d_death = 0 or L.Identity.age = 0, 0, ut.Age (d_birth, d_death));
      Self.Identity.DeathCounty := R.county_name;
      Self.Identity.DeathState := R.state;
			self.Identity.Deceased := if (r.l_did != 0  , 'Y','N');
      Self.Identity := L.Identity;
      Self.is_best := L.is_best;
      Self := L; //all the other fields which unfortunately has defaults in the layout definition
    END;
		deathparams := DeathV2_Services.IParam.GetDeathRestrictions(AutoStandardI.GlobalModule());
		glb_ok := deathparams.isValidGlb();
		
    res_w_d_pre := JOIN (res_w_issuance, doxie.key_death_masterV2_ssa_DID, 
                         keyed (Left.did = Right.l_did) 
												  and	not DeathV2_Services.Functions.Restricted(right.src, right.glb_flag, glb_ok, deathparams),
                         GetDead (Left, Right),
                         left outer, keep (1), limit (0));


    res_w_d_info_nonmasked := dedup (sort (res_w_d_pre, did, ~is_best, record, if (Identity.DeathVerificationCode<>'',0,1)),
                                    did, record, except Identity.DOD.year, Identity.DOD.month, Identity.DOD.day, Identity.DeathVerificationCode);

    suppress.MAC_Mask (res_w_d_info_nonmasked, res_w_d_info_masked, Identity.SSNInfoEx.ssn, null, true, false,
                       ,,, param.ssn_mask);
    res_w_d_info := if (param.ssn_mask != '', res_w_d_info_masked, res_w_d_info_nonmasked);

    AddressReport_Services.layouts.residents_final_out Set_akas (AddressReport_Services.layouts.resident_layout L,DATASET(AddressReport_Services.layouts.resident_layout) allRows):=transform
      self.akas:=project(choosen(allRows (~is_best),iesp.constants.AR.MaxAKAs), transform (iesp.share.t_identity, Self := LEFT.Identity));
			min_allRows_dt_first_seen := min(set(allRows(addr_dt_first_seen<>0),addr_dt_first_seen));
			self.addr_dt_first_seen := if(L.addr_dt_first_seen < min_allRows_dt_first_seen and L.addr_dt_first_seen <> 0, L.addr_dt_first_seen, min_allRows_dt_first_seen);
      self := L;
			self := [];// phone info and address info is added later on
    END;
    akas_res_grp := group(sort(res_w_d_info, did, ~is_best), did);
    res_w_akas := ROLLUP(akas_res_grp, GROUP, Set_akas(LEFT, ROWS(LEFT)));
		return res_w_akas;
	end;

	shared ds_all_records:=add_akas(ds_all_records_tmp);
			
	// Derived flags:		
	BOOLEAN valid_addr_city_state := 
		IF( m_AddrInfo[1].prim_name != '' AND 
				m_AddrInfo[1].p_city_name != ''  AND 
				m_AddrInfo[1].st != '',
				TRUE,
				FALSE
			 );
					 
	BOOLEAN valid_addr_zip :=
		IF( m_AddrInfo[1].prim_name != '' AND
				m_AddrInfo[1].zip != '',
				TRUE,
				FALSE
			 );					
	
	// Prune off non-current records:
	ds_first_cut := ds_all_records(addr_dt_last_seen > AddressReport_Services.constants.THRESHOLD_DATE_FOR_CURRENT_RESIDENCY);

	// Next, prune those records that do not match the input address:		
	Current_res_tmp := IF(valid_addr_city_state OR valid_addr_zip,
												MatchOnAddressCriteria(ds_first_cut, m_AddrInfo, valid_addr_city_state, valid_addr_zip),
												ds_first_cut);		
	shared Current_res_dedup := dedup(sort(Current_res_tmp,did),did);		
	maxHriPer_value := AddressReport_Services.Constants.MaxCountHRI;
	doxie.mac_AddHRIAddress(Current_res_dedup,CurrentResidents_hri);
	CurrentResidents_w_phone := AddressReport_Services.Functions.getRTPhones(CurrentResidents_hri, param.locationReport);
	EXPORT CurrentResidents	:= if(param.locationReport, CurrentResidents_w_phone, project(Current_res_dedup, transform(AddressReport_Services.Layouts.residents_final_out_w_royalties, self.residents := left)));
	
	ds_all_records format_prior_res(ds_all_records l, Current_res_dedup r):=transform	
		boolean NOT_address_matches := if( (l.prim_name = m_AddrInfo[1].prim_name AND
																		l.prim_range = m_AddrInfo[1].prim_range AND
																		l.predir = m_AddrInfo[1].predir AND
																		l.suffix = m_AddrInfo[1].suffix AND
																		l.postdir = m_AddrInfo[1].postdir AND
																		l.sec_range =  m_AddrInfo[1].sec_range AND
																		l.city_name= m_AddrInfo[1].p_city_name AND
																		l.st= m_AddrInfo[1].st),false,true);
		self.prim_name:=if(NOT_address_matches,l.prim_name,'');
		self.prim_range:=if(NOT_address_matches,l.prim_range,'');
		self.predir:=if(NOT_address_matches,l.predir,'');
		self.suffix:=if(NOT_address_matches,l.suffix,'');
		self.postdir:=if(NOT_address_matches,l.postdir,'');
		self.sec_range:=if(NOT_address_matches,l.sec_range,'');
		self.unit_desig:=if(NOT_address_matches,l.unit_desig,'');
		self.st:=if(NOT_address_matches,l.st,'');
		self.zip:=if(NOT_address_matches,l.zip,'');
		self.zip4:=if(NOT_address_matches,l.zip4,'');
		self:=l;
	end;																									 
	Prior_res_tmp:=join(ds_all_records,Current_res_dedup,LEFT.did=RIGHT.did,format_prior_res(LEFT,RIGHT),LEFT ONLY);
	Prior_res_dedup:=dedup(sort(Prior_res_tmp,did),did);
	
	doxie.layout_AppendGongByAddr_input fixComp(Prior_res_dedup L) := transform 
		self.listing_name := '';
		self.timezone := '';
		self.phone := '';
		self := l;
	end;
	a := project(Prior_res_dedup,fixComp(left));
	cur_phones := doxie.fn_AppendGongByAddr(a(prim_name<>'', prim_range<>'', st<>''),true)(not(publish_code = 'N' or omit_phone = 'Y')); 	
	
	AddressReport_Services.layouts.residents_final_out add_phones(Prior_res_dedup L, cur_phones R):=transform
		self.CurrentPhone := project(r, transform(iesp.addressreport.t_AddrReportRealTimePhone,
																							self.Phone10 			:= left.phone,
																							self.PubNonpub 		:= left.publish_code,
																							// self.ListingPhone10 := '',
																							self.ListingName 	:= left.listing_name,
																							self.TimeZone 		:= left.timezone,
																							// self.ListingTimeZone := '',
																							self := []));
		self:=l;
	end;
	PriorResidents_tmp:=join(Prior_res_dedup,cur_phones,
	                           LEFT.did=RIGHT.did,
													 add_phones(LEFT,RIGHT),
													 LEFT outer,keep(1),ALL);
	
	PriorResidents_tmp final_dedup(PriorResidents_tmp l,Current_res_dedup r):=transform
		self:=l;
	end;
	EXPORT PriorResidents := join(PriorResidents_tmp,Current_res_dedup,left.did=right.did,final_dedup(LEFT,RIGHT),left only);
END;