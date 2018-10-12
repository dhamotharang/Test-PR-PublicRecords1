IMPORT IdentityFraud_Services, PersonReports, doxie, iesp, Codes, header, doxie_crs, 
          doxie_raw, ContactCard, ut, person_models, suppress;

ifr := iesp.identityfraudreport;
NLR := IdentityFraud_Services.Constants.RiskCodes.NLR;
HC_NLR := Header.constants.no_longer_reported;

// impose "absolute" maximum on imposters (that's the number I will try to get best records for)
unsigned2 IMPOSTERS_ABS_MAX := 200;

out_rec := iesp.identityfraudreport.t_IdentityFraudReportResponse;

// accepts atmost one DID, actually
EXPORT IdentityFraudReport (
  dataset (doxie.layout_references) input_dids,
  IdentityFraud_Services.IParam._identityfraudreport param,
  boolean IsFCRA = false, string50 DataPermission) := MODULE

  // In case input DID was found through the search, different customers may want a different degree of match,
  // so we will need to evaluate the input using penalty.
  // Note, it makes sense to separate header records for subject and non-subjects anyway,
  // since different permissions are applied to non-subject header.

  // cannot use doxie/header_records_byDID: it fails at a certain limit on number of records, and here I may have
  // dozens of DIDs

  // Inherit missing values from the global module; it is safer in case new fields added to the IDataAccess interface.
  // Can't project from {input} because of different type of ssn_mask (string vs. string6);
  shared mod_access := MODULE (doxie.functions.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule (IsFCRA)))
    EXPORT unsigned1 glb := param.glbpurpose;
    EXPORT unsigned1 dppa := param.dppapurpose;
    EXPORT string DataPermissionMask := DataPermission; 
    EXPORT string DataRestrictionMask := param.DataRestrictionMask;
    EXPORT boolean ln_branded := FALSE;       //hardcoded for mod_header_records call
    EXPORT boolean probation_override := param.probation_override;
    EXPORT string5 industry_class := '';      //hardcoded for mod_header_records call
    EXPORT string32 application_type := param.applicationtype;
    EXPORT boolean no_scrub := FALSE;         //hardcoded for mod_header_records call
    EXPORT unsigned3 date_threshold := 0;            //hardcoded for mod_header_records call
    EXPORT string ssn_mask := param.ssn_mask;
    EXPORT unsigned1 dl_mask := IF (param.mask_dl, 1, 0);
    export unsigned1 dob_mask := param.dob_mask;
  END;


 shared header_obj := doxie.mod_header_records (
                     false, true, false, //DoSearch, include dailies, allow_wildcard
                     true,               // include_gong
                     false,              // suppress_gong_noncurrent
                     [], false, false, true,    // daily_autokey_skipset, AllowGongFallBack, ApplyBpsFilter, GongByDidOnly
                     mod_access
                );

  header_all_subj := header_obj.Results (project (input_dids, doxie.layout_references_hh));

  doxie.layout_presentation CalculatePenalty (doxie.layout_presentation L) := transform
    // calculation are about the same as in doxie/header_records_byDID
    self.penalt := doxie.FN_Tra_Penalty_Addr (L.predir,L.prim_range,L.prim_name,L.suffix,L.postdir,L.sec_range,
                                              L.city_name,L.st,L.zip) +
                   doxie.FN_Tra_Penalty_DID ((string)L.did) +
                   doxie.FN_Tra_Penalty_DOB ((string)L.dob) +
                   doxie.FN_Tra_Penalty_Name (L.fname,L.mname,L.lname) +
                   doxie.FN_Tra_Penalty_SSN (L.ssn) +
                   ut.Min2 (doxie.Fn_Tra_Penalty_Phone (L.phone), doxie.Fn_Tra_Penalty_Phone (L.listed_phone));
    Self := L;
  end;
  headerSubj_w_penalty := project (header_all_subj, CalculatePenalty (Left));
		shared headerSubj := headerSubj_w_penalty(param.skip_penalty_filter or penalt < Constants.MAX_PENALTY_SCORE);

  // and here we make the decision whether to use input DID
	shared subj_did := if (exists (headerSubj), input_dids[1].did, 0);
  shared dids := if (subj_did!=0, input_dids);

	// emails addresses for the primary identity
	email_recs	:=	doxie.email_records(dids(did	=	subj_did),mod_access.ssn_mask,mod_access.application_type,true);
	
	// normalize the child dataset emails so as to restrict the number of emails shown to the customer
	shared email_recs_norm	:=	Functions.GetEmails(email_recs, param, IsFCRA);

	
  // ========================================================================
  // Get Best data for subject and imposters
  // ========================================================================
  // imposters
  doxie.layout_best FormatLegacyBest () := transform 
    Self.did := subj_did;
    Self := [];
  end;
  imposters_all := doxie.fn_ssn_records (dataset ([FormatLegacyBest ()])); //doxie_crs.layout_ssn_records

  // need DIDs for imposters to fetch header records (for counts only) and best records.
  // choose latest "imposters", if more than limit specified
  slim_rec := record (doxie.layout_references)
    imposters_all.last_seen;
  end;
  imposters_all_dids := dedup (sort (project (imposters_all (did != subj_did), slim_rec), did, -last_seen), did);
	
  // Unfortunately, can't choose the correct number of imposters right away,
  // since "best record" exists not for every possible imposter; must use as much DIDs as possibly feasible here
  imposters_dids := if (subj_did != 0, choosen (sort (imposters_all_dids, -last_seen), IMPOSTERS_ABS_MAX));

  best_subj := doxie.best_records (dids,
        IsFCRA, 
        false, //postpone masking until the very end
        false, // do not append time zone
        ,includeDOD:=true, // use non-blank key = false
        modAccess := mod_access
        );
	
  // ... and here I can pickup the desired number of imposters
  best_imposter := choosen (
    doxie.best_records (project (imposters_dids, doxie.layout_references),
        IsFCRA, 
        false, //postpone masking until the very end
        false, // do not append time zone
        ,
        header.constants.checkRNA,
 			 includeDOD:=true,
       modAccess := mod_access),
    param.max_imposters);
	
  // prevent imposters/associated identities to be fetched in case subject wasn't found:
  best_all_pre := if (subj_did != 0, best_subj + best_imposter);
	
	// Join to Header.key_ADL_segmentation to get the identity type with out using the Z utility records
	best_all	:=	join(	best_all_pre,
											Header.key_ADL_segmentation,
											keyed(left.did	=	right.did),
											transform(recordof(best_all_pre),self.adl_ind	:=	right.ind2;self	:=	left),
											left outer,
											limit(0),
											keep(1)
											);
	
  best_subj_lname := best_subj[1].lname;
  best_subj_ssn   := best_subj[1].ssn;

	// Get the fraud point indices for the subject
	dFraudRiskIndices	:=	IdentityFraud_Services.Functions.GetIdentityFraudRiskIndices(dids,best_all_pre,param,isFCRA,DataPermission);

  // ========================================================================
  // get all header records for all "participants" and categorize sources
  // ========================================================================


  // Now imposters: get header records, apply RNA permissions
  header_all_rna := header_obj.Results (project (best_imposter, doxie.layout_references_hh));

  GLB_Purpose := mod_access.glb;
  dppa_Purpose := mod_access.dppa;
  Header.MAC_GLB_DPPA_Clean_RNA(header_all_rna,headerRNA);	


	// Combine subject and imposters, and filter out Z utility records
  header_all := (headerSubj + headerRNA) (src != mdr.sourceTools.src_ZUtilities);
	

  // attach source category -- Assets, Bureau, etc. -- to each record and initialize counts
  data_categories := limit (Codes.Key_Codes_V3 (keyed (file_name = 'DATA_FAMILIES')), 1000, fail ('too many sources'));

  header_rec := IdentityFraud_Services.layouts.slim_header;

  header_rec AssignCategory (recordof (header_all) L, data_categories R) := transform
    // in case if there are some sources not included into codes v3
    local_category := MAP (L.src = 'PH' => 'PHONE',
                           // L.src = 'QH' => 'BUREAU 1', //Equifax, already in codes v3
                           '');
    descript := trim (R.long_desc);
    Self._Type := if (descript != '', descript, local_category);
    Self.Count := 1;
    // For the purpose of this service sources EQ == QH, so I will common them up just once here
    // Later I count data by category + source, and these two should be counted as same.
    Self.src := if (L.src = 'QH', 'EQ', L.src);

    // in case of Gong records use first/last as vendor's first/last
    Self.dt_vendor_first_reported := if (L.src = 'PH', L.dt_first_seen, L.dt_vendor_first_reported);
    Self.dt_vendor_last_reported := if (L.src = 'PH', L.dt_last_seen, L.dt_vendor_last_reported);
    Self := L;
  end;
  header_families := JOIN (header_all, data_categories,
                           Left.src = Right.code,
                           AssignCategory (Left, Right),
                           left outer, LOOKUP);


  // ========================================================================
  // Get "no longer reported" risk indicators
  // ========================================================================
  // for both subject and imposters: I don't know yet which records will be "best" for imposters

  // Fetch "no longer reported" by record_id: it'll be attached only to bureaus' records 
  header_ext := JOIN (header_families, header.key_nlr_payload,
                      keyed (Left.did = Right.did) and
                      keyed (Left.rid = Right.rid),
											transform (header_rec, Self.not_in_bureau := Right.not_in_bureau, Self := Left),
                      LEFT OUTER, KEEP (1), LIMIT (0));
	
  // ========================================================================
  // Get data variations (source counts for each one): different names, etc.
  //   each will have "standard" risk indicators included
  // ========================================================================
  // 1. Each vendor, contributing to the data field -- dob, name, etc. -- is counted no more than once.
  //    Can't dedup by source right away, since I may accidentally remove meaningful data
  //    (for example, 2 records from same source: {ssn, blank_dob}, {blank_ssn, dob}
  // 2. Deduped header -- same source, meaningful data prefered -- is further categorized by "data groups"

  // NB: first/last seen date are relevant to address and names only (using dates for dob, etc. 
  // requires redesigning of the header file), but I need them for sorting -- to bring most recent on top

  //DIDs
  header_dids := group (sort (header_ext, did), did);
	
  layouts.did_did_rec SetAssociatedDIDs (header_rec L, dataset (header_rec) R) := transform
    Self.did := L.did; // duplicate
    Self.UniqueId := intformat (L.did,12, 1);
    Self._Type := [];// will take it from best
    Self.DateFirstSeen := iesp.ecl2esp.toDateYM (min (R (dt_first_seen > 0), dt_first_seen));
    Self.DateLastSeen := iesp.ecl2esp.toDateYM (max (R, dt_last_seen));
    // get source categories' counts:
    Self.Sources := choosen (Functions.GetSources (R), iesp.Constants.IFR.MaxSourcetypes);
    // overal count:
    Self.SourceCount := if (param.count_by_source, count (dedup (R, src, all)), count (dedup (R, _type, all)));

    indicators := Functions.IndicatorsSum (project (R, layouts.bureau_indicator));  // cannot use deduped set here
    ri_nlr := 
      if (indicators & HC_NLR.did_not_in_en = HC_NLR.did_not_in_en, Functions.GetRiskIndicator (NLR.DID_EN)) +
      if (indicators & HC_NLR.did_not_in_eq = HC_NLR.did_not_in_eq, Functions.GetRiskIndicator (NLR.DID_EQ)) +
      if (indicators & HC_NLR.did_not_in_tn = HC_NLR.did_not_in_tn, Functions.GetRiskIndicator (NLR.DID_TU));
			
    // roll them to have combined name:
    // ri_rolled := rollup (ri_nlr, true, transform (ifr.t_ColoredRiskIndicator, 
                                                  // Self.Providers := Left.Providers + if (Right.Providers != '', ' ' + Right.Providers, ''),
                                                  // Self := Left;));
    Self.RiskIndicators := choosen (ri_nlr, iesp.Constants.IFR.MaxIndicators);
		Self := [];
  end;
	
  a_dids_pre := rollup (header_dids, group, SetAssociatedDIDs (left, rows (left)));
	
	// Add fraud indicators for identity
	layouts.did_did_rec tDIDFraudInd(a_dids_pre le,dFraudRiskIndices ri) :=
	transform
		ri_fraud := if(ri.IdentityRecentUpdate,Functions.GetRiskIndicator(Constants.RiskCodes.Identity.NO_UPDATES)) +
								if(ri.VariationAddrStability,Functions.GetRiskIndicator(Constants.RiskCodes.Identity.ADDRESS_CHANGES)) +
								if(ri.VariationPhoneCount,Functions.GetRiskIndicator(Constants.RiskCodes.Identity.MULTIPLE_PHONES)) +
								if(ri.VariationSearchSSNCount,Functions.GetRiskIndicator(Constants.RiskCodes.Identity.EXCESSIVE_SSNS)) +
								if(ri.VariationSearchAddrCount,Functions.GetRiskIndicator(Constants.RiskCodes.Identity.EXCESSIVE_ADDRESSES)) +
								if(ri.VariationSearchPhoneCount,Functions.GetRiskIndicator(Constants.RiskCodes.Identity.EXCESSIVE_PHONES)) +
								if(ri.SearchCountYear,Functions.GetRiskIndicator(Constants.RiskCodes.Identity.EXCESSIVE_SEARCHES_YEAR)) +
								if(ri.SearchCountMonth,Functions.GetRiskIndicator(Constants.RiskCodes.Identity.EXCESSIVE_SEARCHES_MONTH)) +
								if(ri.SearchCountWeek,Functions.GetRiskIndicator(Constants.RiskCodes.Identity.EXCESSIVE_SEARCHES_WEEK)) +
								if(ri.SearchCountDay,Functions.GetRiskIndicator(Constants.RiskCodes.Identity.EXCESSIVE_SEARCHES_DAY));
		
		self.RiskIndicators    := choosen(le.RiskIndicators + ri_fraud,iesp.Constants.IFR.MaxIndicators);
		self.RiskIndices       := dataset( [{Constants.IdentityRiskLevel,ri.IdentityRiskLevel},
																				{Constants.SourceRiskLevel,ri.SourceRiskLevel},
																				{Constants.VelocityRiskLevel,ri.VelocityRiskLevel}
																			 ],
																			 ifr.t_RiskIndices
																			);
		self.TotalSearchCounts := row({ri.TotalSearchCountDay,ri.TotalSearchCountWeek,ri.TotalSearchCountMonth,ri.TotalSearchCountYear},ifr.t_TotalSearchCounts);
		self                   := le;
	end;
	
	a_dids := join(a_dids_pre,
								 dFraudRiskIndices,
								 left.did = right.did,
								 tDIDFraudInd(left,right),
								 left outer,
								 limit(0),keep(1) // 1:1 relation
								);

  // SSNs
  ssns_risk := IdentityFraud_Services.GetSSNIndicators (header_ext, dFraudRiskIndices, param);
  // this is apparently "redundant" join, since it was already done in doxie/mac_AddHRISSN,
  // but state's full name and dates are contracted to the extent I can't use them there.
  layouts.ssn_did_rec GetSSNData (layouts.ssn_did_rec L, doxie.Key_SSN_Map R) := transform
    IssuedStart := iesp.ECL2ESP.toDatestring8 (R.start_date);
    IssuedEnd   := iesp.ECL2ESP.toDatestring8 (R.end_date);
    Self.SSNData := iesp.ECL2ESP.SetSSNInfo (L.SSNData.ssn, L.SSNData.valid, R.state, 
                                             IssuedStart, IssuedEnd);
    Self := L;
  end;
  a_ssns := join (ssns_risk, doxie.Key_SSN_Map,
                  keyed (Left.SSNData.ssn[1..5] = Right.ssn5) AND
                  keyed (Left.SSNData.ssn[6..9] between Right.start_serial AND Right.end_serial),
                  GetSSNData (Left, Right),
                  left outer, keep (1), limit (0)); //1 : 1 relation

  //DOBs
  header_dobs := group (sort (header_ext (dob != 0, valid_dob != 'M'), did, dob), did, dob);
  dob_rec := record (ifr.t_IFRDOB)
    header_rec.did;
  end;
  dob_rec SetAssociatedDOBs (header_rec L, dataset (header_rec) R) := transform
    Self.did := L.did;
    dob := iesp.ECL2ESP.toDate (L.dob);
    Self.DOB := dob;
    iesp.share.t_MaskableDate xform (iesp.share.t_Date L) := transform // copy to the string representation
      Self.Year := (string) L.Year;
      Self.Month := (string) L.Month;
      Self.Day := (string) L.Day;
    end;
    Self.DOB2 := row (xform (dob));
    Self.DateFirstSeen := iesp.ecl2esp.toDateYM (min (R (dt_vendor_first_reported > 0), dt_vendor_first_reported));
    Self.DateLastSeen := iesp.ecl2esp.toDateYM (max (R, dt_vendor_last_reported));

    // get source categories' counts:
    Self.Sources := choosen (Functions.GetSources (R), iesp.Constants.IFR.MaxSourcetypes);
    // overal count:
    Self.SourceCount := if (param.count_by_source, count (dedup (R, src, all)), count (dedup (R, _type, all)));

    indicators := Functions.IndicatorsSum (project (R, layouts.bureau_indicator));
    // exclude No Longer Reported for Equifax #57471
    ri_nlr := if (indicators & HC_NLR.dob_not_in_en = HC_NLR.dob_not_in_en, Functions.GetRiskIndicator (NLR.DOB_EN));
    Self.RiskIndicators := choosen (ri_nlr, iesp.Constants.IFR.MaxIndicators);
  end;
  a_dobs := rollup (header_dobs, group, SetAssociatedDOBs (left, rows (left)));


  //names
  a_names := IdentityFraud_Services.GetNamesIndicators (header_ext, param);


  // addresses
  a_addresses := IdentityFraud_Services.GetAddressIndicators (header_ext, dFraudRiskIndices, param);


  // phones ... are different from other types: they are fetched from Gong, and header contributes to counts;
  a_phones := IdentityFraud_Services.GetPhoneIndicators (best_all, header_ext, param);
  // roll by DID
  phones_grp := group (sort (a_phones, did), did);
  layouts.phones_roll_rec RollPhones (layouts.phone_did_rec L, dataset (layouts.phone_did_rec) R) := transform
    Self.did := L.did;
    Self.PhoneInfo := choosen (project (R, iesp.identityfraudreport.t_IFRPhone), iesp.constants.IFR.MaxBestPhones);
  end;
  a_phones_rolled := ROLLUP (phones_grp, GROUP, RollPhones (Left, ROWS (Left)));


  // ========================================================================
  // ========================================================================
  // Note that so far risk indicators returned for each data segment are not rolled up,
  // since it may appear that I will need unrolled RIs in SUMMARY section.
  // (For instance, each address may have few indicators "no longer reported").

  // some indicators need to be rolled in relation to Providers -- "no longer reported".
  // USPIS and Blue indicators must not be rolled up.
  boolean is_rolluble (integer rk) := (rk != 12) and (rk != 100) and (rk <200);

  MAC_RollIndicators (ds_in, ds_out, rec) := MACRO
    #uniquename (RollIndicators);
    rec %RollIndicators% (recordof (ds_in) L) := transform
      inds := L.RiskIndicators;
      inds_grp := sort (inds, inds.Rank, Providers);
      // this is rather formal: I don't expect different providers here except 2-3 "no longer reported"
      inds_rolled := rollup (inds_grp, (Left.Rank = Right.Rank) and is_rolluble (Left.Rank),
                             transform (ifr.t_ColoredRiskIndicator, 
                                        Self.Providers := Left.Providers + if (Right.Providers != '', ' ' + Right.Providers, ''),
                                        Self := Left;));
      Self.RiskIndicators := inds_rolled;
      Self := L;
    end;
    ds_out := project (ds_in, %RollIndicators% (Left));
  ENDMACRO;


  // ========================================================================
  // Create identity object -- shared functionality for subject and imposters
  // ========================================================================
  // Attach main data and RIs to the best records;
  // NB: At phase 1 we decided to use exact match for all data.
  // Subject's or imposters' specific fields will be added afterwards -- in the final transform
  ifr.t_IFRIdentity FillIdentity (doxie.layout_best L) := transform
    linkid_match := a_dids (did = L.did)[1]; // always one anyway
    Self.LinkIdInfo.UniqueId := intformat (L.did, 12, 1);
    Self.LinkIdInfo._Type := IdentityFraud_Services.Functions.GetIdentityDescription (L.adl_ind);
		
    MAC_RollIndicators (linkid_match, this_did_record, ifr.t_IFRLinkId);
    Self.LinkIdInfo := this_did_record;
		
    // Names
    fl_match := a_names (did = L.did, 
                         Name.Last = L.lname, Name.First = L.fname, Name.Middle = L.mname,
                         Name.Suffix = L.name_suffix);
    MAC_RollIndicators (fl_match, this_name_record, ifr.t_IFRName);
    
    // append "derived" indicator for a best name, if no sources found containing exact match
    _indicators_name := if (this_name_record[1].SourceCount > 0, 
                            this_name_record[1].RiskIndicators,
                            this_name_record[1].RiskIndicators + Functions.GetRiskIndicator (Constants.RiskCodes.Name.DERIVED));
    Self.NameInfo.RiskIndicators := _indicators_name;
    Self.NameInfo.Name := iesp.ECL2ESP.SetName (l.fname, l.mname, l.lname, L.name_suffix, L.title);
    Self.NameInfo := this_name_record[1]; // SourceCount, sources, dates

    // Addresses: I'm using "almost exact" match: have to ease up a little for secondary range as in GetAddressIndicators:
    // (after my rollup DID=1444392142 has sec range = '101BH' vs. '101' in best)
    address_match := a_addresses (did = L.did,
                        Address.Zip5 = L.zip, 
                        Address.StreetName = L.prim_name, 
                        Address.StreetNumber = L.prim_range,
                        ut.Sec_Range_Eq(Address.UnitNumber, L.sec_range)<10,
                        Address.StreetPreDirection = L.predir,
                        Address.StreetSuffix = L.suffix);
    MAC_RollIndicators (address_match, this_address_record, ifr.t_IFRAddress);
    Self.AddressInfo.Address := iesp.ECL2ESP.SetAddress (L.prim_name, L.prim_range, L.predir, L.postdir,
                                                         L.suffix, L.unit_desig, L.sec_range, L.city_name,
                                                         L.st, L.zip, L.zip4, '');
    Self.AddressInfo := this_address_record [1];

    // DOB
    esdl_dob := iesp.ECL2ESP.toDate (L.dob);
    dob_match := a_dobs (did = L.did, DOB = esdl_dob);
    MAC_RollIndicators (dob_match, this_dob_record, ifr.t_IFRDOB);
    Self.DOBInfo.DOB := esdl_dob;
    Self.DOBInfo := this_dob_record[1];

    // Phones
    // keep only phones with listed name contaning "this" last name
    this_phones_info := a_phones_rolled (did = L.did)[1];
//? TODO: can't use Self.PhoneInfo := this_phones_info.PhoneInfo (ut.IsNamePart (ListedName, trim (L.lname), false));
    ifr.t_IFRPhone FilterByName (ifr.t_IFRPhone L, string lname) := function
      boolean IsSameName := ut.IsNamePart (L.ListedName, trim (lname), false);
      ifr.t_IFRPhone mTransform := transform, skip (~IsSameName) 
        Self := L;
      end;
      return mTransform;
    end;
    Self.PhoneInfo := project (this_phones_info.PhoneInfo, FilterByName (Left, L.lname));
    Self.DOD := iesp.ECL2ESP.toDatestring8 (L.dod);
    Self.Gender := iesp.ECL2ESP.GetGender (L.title);
		Self := [];
  end;
  // this is potentially heavy operation (scan is executed every time in transform),
  // so I may want to consider using separate joins instead (by DOB, address, etc.)
  all_identities := project (best_all, FillIdentity (Left)); //can be more than one

  primary_identity := all_identities ((unsigned6) LinkIdInfo.UniqueID = subj_did); // always one
  imposters_identities := all_identities ((unsigned6) LinkIdInfo.UniqueID != subj_did); // non-negative



  // ========================================================================
  //     Split SSNs into subject's and imposters
  // ========================================================================
  // keep only SSNs shared with a subject
  a_ssn_imposters := join (a_ssns (did != subj_did), a_ssns (did = subj_did),
        Left.SSNData.ssn = Right.SSNData.ssn,
        transform (layouts.ssn_did_rec, Self := Left),
        KEEP (1), LIMIT (0)); // atmost 1 : 1

  // if needed, add "imposters exists for this SSN" indicator to a subject's SSNs
  layouts.ssn_did_rec AddImpostersIndicator (layouts.ssn_did_rec L, layouts.ssn_did_rec R) := transform
    _indicators := L.RiskIndicators + if (R.SSNData.ssn != '', 
                                          Functions.GetRiskIndicator (Constants.RiskCodes.SSN.IMPOSTERS));
    Self.RiskIndicators := choosen (_indicators, iesp.Constants.IFR.MaxIndicators);
    Self := L;
  end;
  a_ssn_subject := join (a_ssns (did = subj_did), a_ssn_imposters,
        Left.SSNData.ssn = Right.SSNData.ssn,
        AddImpostersIndicator (Left, Right),
        LEFT OUTER, KEEP (1), LIMIT (0)); // doesn't matter if more than one



  // ========================================================================
  //     Get detailed relatives description (compare to ContactCard)
  // ========================================================================
            probation := false;
            Relative_Depth := 3;
            max_relatives := 0; //means all;
            isCRS := false; //not used
            max_associates := 0;

  rel := Doxie_Raw.relative_raw (dids, mod_access.date_threshold, mod_access.dppa, mod_access.glb, mod_access.ssn_mask, 
                                            mod_access.ln_branded, probation, true, true,
                                            Relative_Depth, max_relatives, isCRS, max_associates);

  rel_det := choosen(rel(isRelative and depth = 1), 100);

  // set preliminary association:
  ifr.t_IFRAssociatedIdentity SetPrimitiveAssociate (ifr.t_IFRIdentity L, doxie_Raw.Layout_RelativeRawOutput R) := transform
    Self.InferredAssociation := if (R.person2 != 0,
                                    if (L.NameInfo.Name.Last = best_subj_lname, 'Possible Relative', 'Possible Associate'),
                                    '');
    MAC_RollIndicators (a_ssn_imposters (did = (unsigned6) L.LinkIDInfo.UniqueId), a_ssns_ready, ifr.t_IFRSSN);
    Self.SharedSSNs := CHOOSEN (sort (a_ssns_ready, if (SSNData.SSN = best_subj_ssn, 0, 1), -SourceCount), iesp.Constants.IFR.MaxSSNs);
    Self := L;
  end;
  imposters_associated_pre := join (imposters_identities, rel,
        (unsigned6) Left.LinkIDInfo.UniqueId = Right.person2,
        SetPrimitiveAssociate (Left, Right),
        LEFT OUTER, KEEP (1), LIMIT (0));

  // set detailed association:
  ifr.t_IFRAssociatedIdentity SetAssociate (ifr.t_IFRAssociatedIdentity L, doxie_Raw.Layout_RelativeRawOutput R) := transform
    Self.InferredAssociation := if (R.titleNo != 0, 'Possible ' + Header.relative_titles.fn_get_str_title(R.titleNo), L.InferredAssociation);
      // each ssn for an imposter is shared with a subject by definition, but pm wants explicit indicator:
    Self.SharedSSNs := project (L.SharedSSNs, transform (ifr.t_IFRSSN, 
                                  Self.RiskIndicators := Left.RiskIndicators + Functions.GetRiskIndicator (Constants.RiskCodes.SSN.IMPOSTERS),
                                  Self := Left;));
    Self := L;
  end;
  imposters_associated := join (imposters_associated_pre, rel_det,
        (unsigned6) Left.LinkIDInfo.UniqueId = Right.person2,
        SetAssociate (Left, Right),
        LEFT OUTER, KEEP (1), LIMIT (0));

  // ========================================================================
  // Get report together
  // ========================================================================

  out_rec Format () := TRANSFORM
    Self._Header := iesp.ECL2ESP.GetHeaderRow ();

		Self.ReportSummary.RiskIndicators	:=	[];	// it is deprecated now; assigned only by explicit request
		
    // AssociatedData (subject's variations of names, addresses, etc.) 
    // Sorted by recency and/or by SourceCounts, if recency is irrelevant or inavaialble
    // Doesn't list data contained in primary
    MAC_RollIndicators (a_ssn_subject, a_ssns_ready, ifr.t_IFRSSN);
    ssn_best_removed := a_ssns_ready (SSNData.SSN != best_subj_ssn);
    Self.AssociatedData.SSNs := CHOOSEN (sort (ssn_best_removed, -SourceCount, SSNData.ssn), iesp.Constants.IFR.MaxSSNs);

    MAC_RollIndicators (a_dobs (did = subj_did), a_dobs_ready, ifr.t_IFRDOB);
    dob_best_removed := a_dobs_ready (DOB != iesp.ECL2ESP.toDate(best_subj[1].dob));
    Self.AssociatedData.DOBs := CHOOSEN (sort (dob_best_removed, -DateLastSeen, -SourceCount, DOB), iesp.Constants.IFR.MaxDOBs);

    MAC_RollIndicators (a_names (did = subj_did), a_names_ready, ifr.t_IFRName);
    names_best_removed := a_names_ready (
                                     (Name.Last != best_subj[1].lname) or
                                     (Name.First != best_subj[1].fname) or
                                     (Name.Middle != best_subj[1].mname) or
                                     (Name.Suffix != best_subj[1].name_suffix));
    Self.AssociatedData.Names := CHOOSEN (sort (names_best_removed, -DateLastSeen, -SourceCount, NAME), iesp.Constants.IFR.MaxNames);

    MAC_RollIndicators (a_addresses (did = subj_did), a_addresses_ready, ifr.t_IFRAddress);

    // using "project" instead of filtering since I have to do something else for addresses: handle most recent, etc.
    ifr.t_IFRAddress CheckAddresses (ifr.t_IFRAddress L) := function
      boolean IsBest := (L.Address.Zip5 = best_subj[1].zip) and 
                        (L.Address.StreetName = best_subj[1].prim_name) and
                        (L.Address.StreetNumber = best_subj[1].prim_range) and
                        ut.Sec_Range_Eq(L.Address.UnitNumber, best_subj[1].sec_range)<10 and
                        (L.Address.StreetPreDirection = best_subj[1].predir) and
                        (L.Address.StreetSuffix = best_subj[1].suffix);
      ifr.t_IFRAddress mTransform := transform, skip (IsBest)
        // remove "vacant" indicator for addresses older than 2 years than the best (~current)
        // date in the best is 6-chars only
        lseen_months := L.DateLastSeen.Year*12 + L.DateLastSeen.Month;
        best_months := (best_subj[1].addr_dt_last_seen div 100) * 12 + best_subj[1].addr_dt_last_seen % 100;
        whole_months := best_months - lseen_months; // can be negative
        ri_clean := L.RiskIndicators (~Functions.IsVacant (RiskCode) or (whole_months < 24));
        // add "more recent address" indicator
        // lseen := L.DateLastSeen.Year*100 + L.DateLastSeen.Month;
        _indicators := ri_clean;// + if (lseen > best_subj[1].addr_dt_last_seen, Functions.GetRiskIndicator (Constants.RiskCodes.Address.MORE_RECENT));
        Self.RiskIndicators := choosen (_indicators, iesp.Constants.IFR.MaxIndicators);

        Self := L;
      end;
      return mTransform;
    end;

    addr_best_removed := project (a_addresses_ready, CheckAddresses (Left));
    Self.AssociatedData.Addresses := CHOOSEN (sort (addr_best_removed, -DateLastSeen, -SourceCount, Address), iesp.Constants.IFR.MaxAddresses);

		Self.AssociatedData.EmailAddresses	:=	project(email_recs_norm,ifr.t_IFREmail);
		
    // Primary Identity section
    a_dls := IdentityFraud_Services.Functions.GetBestDLInfo (best_subj[1].dl_number, subj_did, project (param, PersonReports.input.permissions));

    // Finish postponed calculations for subject: SSNs, certain aggregated indicators;
    // unfortunately I have to convert codes back into integer (!)
    boolean has_nlr_ssn     := exists (a_ssns_ready.RiskIndicators (Functions.GetIntegerCode(RiskCode) IN Constants.No_LONGER_SET));
    boolean has_nlr_name    := exists (a_names_ready.RiskIndicators (Functions.GetIntegerCode(RiskCode) IN Constants.No_LONGER_SET));
    boolean has_nlr_address := exists (a_addresses_ready.RiskIndicators (Functions.GetIntegerCode(RiskCode) IN Constants.No_LONGER_SET));
    boolean has_nlr_dob     := exists (a_dobs_ready.RiskIndicators (Functions.GetIntegerCode(RiskCode) IN Constants.No_LONGER_SET));
		
		// Transform for the link id risk indicators
    ifr.t_IFRLinkId AddIndicators (ifr.t_IFRLinkId L) := transform
      // "best" ssn may be absent for subject
      cnt := count (ssn_best_removed);
      boolean multiple_ssns := (cnt > 1) or ((cnt = 1) and (best_subj_ssn != ''));
			dLinkIdRiskInd := L.RiskIndicators +
												if (multiple_ssns,   Functions.GetRiskIndicator (Constants.RiskCodes.Identity.MULTIPLE_SSNs)) +
												if (has_nlr_ssn,     Functions.GetRiskIndicator (Constants.RiskCodes.NLR.SSN)) +
												if (has_nlr_name,    Functions.GetRiskIndicator (Constants.RiskCodes.NLR.NAME)) +
												if (has_nlr_address, Functions.GetRiskIndicator (Constants.RiskCodes.NLR.ADDRESS)) +
												if (has_nlr_dob,     Functions.GetRiskIndicator (Constants.RiskCodes.NLR.DOB));
			
      Self.RiskIndicators := topn(dLinkIdRiskInd,
																	iesp.Constants.IFR.MaxIndicators,
																	dLinkIdRiskInd.rank);
      Self := L;
    end;
		
    ifr.t_IFRPrimaryIdentity AddAggregateIndicators (ifr.t_IFRIdentity L) := transform
			linkid_match := a_dids (did = (integer)L.LinkIdInfo.UniqueID)[1]; // always one anyway
			
      Self.LinkIdInfo := project (L.LinkIdInfo, AddIndicators (Left));
      Self.SSNInfo := a_ssns_ready (SSNData.SSN = best_subj_ssn)[1];
      Self.DriverLicense := a_dls[1];
			
			// Fraud risk levels and total search counts
			Self.RiskIndices := choosen(if(param.include_identity_risk_level,linkid_match.RiskIndices(RiskIndex	=	Constants.IdentityRiskLevel))	+
																	if(param.include_source_risk_level,linkid_match.RiskIndices(RiskIndex	=	Constants.SourceRiskLevel))	+
																	if(param.include_velocity_risk_level,linkid_match.RiskIndices(RiskIndex	=	Constants.VelocityRiskLevel)),
																	iesp.Constants.IFR.MaxIndices);
			Self.TotalSearchCounts := linkid_match.TotalSearchCounts;
      Self := L;
    end;
    Self.PrimaryIdentity := project (primary_identity, AddAggregateIndicators (Left))[1];

    // Imposters; best identity-like data for those having same SSN as subject's.
    // this will limit number of indicators to return per each imposter (kind of teaser)
    imposters_identities_checked := Functions.LimitImpostersIndicators (imposters_associated, param.indicators_per_imposter);
    Self.AssociatedIdentities := CHOOSEN (imposters_identities_checked, param.max_imposters); // choosen is sort of redundant
    Self.MoreAssociatedIdentities := count (best_imposter) - count (imposters_identities);
  END;

  // output (best_all, named ('best_all'));
	// output (best_subj (did = subj_did), named ('best_subj'));
	// output (dFraudRiskIndices,named('dFraudRiskIndices'));
	// output (email_recs,named('email_recs'));
	// output (email_recs_norm,named('email_recs_norm'));
	// output (header_all, named ('header_all'));
	// output (header_all (did = subj_did), named ('header_all_subj'));
	// output (header_ext,named('header_ext'));
	// output (ssns_risk, named ('ssns_risk'));
	// output (a_ssns (did = subj_did), named ('a_ssns_subj'));
	// output (a_addresses, named ('a_addresses'));
	// output (a_addresses(did = subj_did), named ('a_addresses_subj'));
	// output (primary_identity, named ('primary_identity'));

  report := dataset ([Format ()]); // always one row
  report_patched := Functions.PatchDates (report); // patch dates

  // masking: ssn, dl, dob
  boolean do_mask := (mod_access.ssn_mask != '' and mod_access.ssn_mask != 'NONE') or (mod_access.dl_mask = 1) or
                     (mod_access.dob_mask != suppress.Constants.DateMask.NONE);
  individual := if (do_mask, Functions.MaskReport (report_patched, param), report_patched);
	
  export	results				:=	individual;
	export	email_results	:=	email_recs_norm;
end;