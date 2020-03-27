IMPORT	Address, DriversV2, EmailService, iesp, doxie, ut, 
	Risk_Indicators, Header, suppress, models, Gateway, Royalty, STD;

ifr := iesp.identityfraudreport;

EXPORT Functions := MODULE
  shared NLR := Header.constants.no_longer_reported; // TODO: redirect to data

  //bitwise summator
  export unsigned8 IndicatorsSum (dataset (layouts.bureau_indicator) indicators) := function
    res := rollup (indicators, true, 
                   transform (layouts.bureau_indicator, Self.not_in_bureau := Left.not_in_bureau | Right.not_in_bureau));
    return res[1].not_in_bureau;
  end;
  
  // (4.1.25)
  export string GetIdentityDescription (string10 ind) := CASE(ind,
																															'CORE'       => 'Established Identity',
																															'CORENOVSSN' => 'Possibly Established Identity',
																															'H_MERGE'    => 'Inactive Identity',
																															'C_MERGE'    => 'Possible Emerging Identity', 
																															'DEAD'       => 'Deceased Identity',
																															'INACTIVE'   => 'Inactive Identity',
																															'NO_SSN'     => 'No SSN on Record for Identity',
																															'NOISE'      => 'Inactive Identity',
																															'SUSPECT'    => 'Suspicious Identity',
																															// 'AMBIG'   => 'Ambiguous Identity',
																															'');

  shared string FormatCode (unsigned2 cd) := if (cd < 1000, 'F' + intformat (cd, 3, 1), (string) cd);

  export ifr.t_ColoredRiskIndicator GetRiskIndicator (unsigned8 cd, string descript = '') := function // TODO: check if unsigned4
    // static table mapping RI to rank, description, etc.
    ri_row := IdentityFraud_Services.RIMapTable (code = cd)[1];
    // prefer provided description over the standard one:
    _text := if (descript != '', descript, ri_row.description);
    return dataset([{FormatCode (ri_row.code), _text, ri_row.rank, 
                      Constants.GetColorDescription (ri_row.color_code),ri_row.provider}], ifr.t_ColoredRiskIndicator);
  end;

  // reverse
  export integer GetIntegerCode (string cd) := (integer) (cd[2..]);

  // transform from to this service ESDL
  export ifr.t_ColoredRiskIndicator TransformRiskIndicators (Risk_Indicators.Layout_Desc L) := function
    standard_code := if(ut.fnTrim2Upper(L.desc) = 'FRAUD_IND',(integer)L.hri,Constants.GetComplianceCode (L.hri));
    ifr.t_ColoredRiskIndicator mTransform := TRANSFORM, skip (standard_code = 0)
      ri_row := IdentityFraud_Services.RIMapTable (code = standard_code)[1];
      Self.Color := Constants.GetColorDescription (ri_row.color_code);
      Self.RiskCode := FormatCode (ri_row.code); //note: change of code from "standard" to IdentityFraud
      Self.Rank := ri_row.rank;
      Self.Description := ri_row.description;
      Self.Providers := '';
    end;
    return mTransform;
  end;


  // Fetch driver's license
  // Depending on whether I fetch it by DIDs or "best" DL, can produce one or more records. 
  // Current implementation assumes fetching by DL, which can be changed easily
  dl_out_rec := iesp.identityfraudreport.t_IFRDriverLicense;
  export dataset (dl_out_rec) GetBestDLInfo (string24 dl_num, unsigned6 in_did, doxie.IDataAccess param) := function
    // did-method: I could simply call DriversV2_Services.DLReportService_records,
    //             but there's certain overhead in this call (not a huge one, though, but anyway).
    // fetched_dls := JOIN (dids, DriversV2.Key_DL_DID,
    //                      keyed (Left.did = Right.did),
    //                      keep (Constants.MAX_DL_RECORDS), limit (0));

    // best-dl method:
    fetched_dls := LIMIT (DriversV2.Key_DL_Number (keyed (s_dl = dl_num), did = in_did), Constants.MAX_DL_RECORDS, KEYED, SKIP);

    // TODO: should we consider "privacy_flag" (haven't seen any application of it anywhere at all)
		Suppress.MAC_Suppress(fetched_dls,pull_dids,param.application_type,Suppress.Constants.LinkTypes.DID,did);
		Suppress.MAC_Suppress(pull_dids,pull_ssns,param.application_type,Suppress.Constants.LinkTypes.SSN,ssn);
    Doxie.MAC_PruneOldSSNs (pull_ssns, pruned_ssns, ssn, did);
  
    dl_glb  := pruned_ssns (doxie.compliance.minor_ok (ut.Age (dob), param.show_minors)); // pull minors
    dl_cleaned := dl_glb (param.isValidDPPAState (orig_state, , source_code)); //pull by DPPA

    // Pick dates from "best license", prefering: government over Certegy, current over historical
    src := dl_cleaned.source_code;
    hist := dl_cleaned.history;
    is_current := ((src = 'AD') and (hist = '')) or // Government; history_name = 'CURRENT'
                  ((src = 'AX') and (hist = '')) or // old Experian 
                  ((src = 'CY') and (hist = 'U'));  // all Certegy records seem to have 'U', actually.
    src_sort := map (src = 'AD' =>0, src = 'AX' =>1, 2);

    // [license, src, current] should be unique (if fetched by dl_number, then grouping is formality)
    dls_srt := sort (dl_cleaned, dl_number, src_sort, ~is_current, 
                     if (dt_last_seen > 0, -dt_last_seen, -dt_vendor_last_reported));
    dls_grp := group (dls_srt, dl_number);

    dl_out_rec SetDriverlicenseData (recordof (dls_grp) L, dataset (recordof (dls_grp)) R) := transform
      boolean IsGvmt := L.source_code = 'AD';
      Self.IsGovernmentSource := IsGvmt;
      Self.Number := L.dl_number;
      Self.IssueState := L.orig_state;

      // for the first_seen choose the earliest for "this" license.
      unsigned4 earliest_orig   := choosen (R (orig_issue_date > 0), 1)[1].orig_issue_date; // should be same in all records
      unsigned4 earliest_issue  := min (R (lic_issue_date > 0), lic_issue_date);
      unsigned4 issue_date := if (earliest_orig > 0, earliest_orig, earliest_issue);

      Self.IssueDate := iesp.ECL2ESP.toDate (issue_date);
      Self.ExpirationDate  := iesp.ECL2ESP.toDate (L.expiration_date);

      unsigned3 earliest_first  := min (R (dt_first_seen >0 ), dt_first_seen);
      // "vendor's first" is a case of non-gvmt, generally
      unsigned3 earliest_first_vendor := min (R (dt_vendor_first_reported >0), dt_vendor_first_reported);
      unsigned4 date_earliest := if (earliest_first > 0, earliest_first, earliest_first_vendor) *100;

      // "date last" is easier, since records are already assumed to be sorted in a preferred order.
      unsigned4 date_latest := if (L.dt_last_seen > 0, L.dt_last_seen, L.dt_vendor_last_reported) * 100;

      Self.DateFirstSeen := iesp.ECL2ESP.toDate (date_earliest);
      Self.DateLastSeen  := iesp.ECL2ESP.toDate (date_latest);


      // for DLs Sources may contain up to 1 non-gvmnt and up to 2 government counts
      _src := dedup (R, source_code, all);
      ds_src := dataset ([
        {'Drivers License', count (_src (source_code = 'AD' or source_code = 'AX'))},
        {'Other Reporting Source', count (_src (source_code = 'CY'))}
      ], ifr.t_IFRLinkIdSources);
      Self.Sources := ds_src (ds_src.Count > 0);

      // both government and old Experian are treated as "government source"
      Self.SourceCount := count (ds_src);
      Self.RiskIndicators := [];
    end;
    //this will leave 1 record per distinctive dl number
    dls2 := rollup (dls_grp, group, SetDriverlicenseData (left, rows (left))); //TODO: why "dls" won't compile?
                   
    return dls2;
  end;

  export ifr.t_IFRLinkIdSources GetSources (dataset (IdentityFraud_Services.layouts.slim_header) header_rec) := function
    _src := dedup (group (sort (header_rec, _type, src), _type), src);
    src_categories:=rollup (_src, group, transform (ifr.t_IFRLinkIdSources, Self._Type := Left._Type, Self.Count := count (rows (left))));
    // when sorting sources bring Credit Bureaus records on top, then alphabetically
    src_srt := sort (src_categories, _Type[1..25] != 'CONSUMER REPORTING AGENCY', _Type);
    return src_srt;
  end;


//TODO: this is simply a proof of concept. If it will bring efficiency issues, I can use common normalize+join
  // The purpose of it is to limit the number of indicators per each imposter to stimulate
  // a customer run report for each imposter in turn.

  shared risk_extended_rec := record (ifr.t_ColoredRiskIndicator)
    unsigned1 ri_type;
    string indicative {maxlength (16)} := ''; // whatever additional values we need for linking.
  end;
  
  export dataset (ifr.t_IFRAssociatedIdentity) LimitImpostersIndicators (dataset (ifr.t_IFRAssociatedIdentity) imposters, unsigned1 max_num) := function
    // General approach: for each DID 1) detach all RIs; 2) choose MAX most important ones; 3) attach back to place
    risk_extended_rec norm (ifr.t_ColoredRiskIndicator L, unsigned1 tp) := transform
      Self.ri_type := tp;
      Self := L;
    end;
    risk_extended_rec normWithID (ifr.t_ColoredRiskIndicator L,  unsigned1 tp, string id) := transform
      Self.ri_type := tp;
      Self.indicative := id;
      Self := L;
    end;

    ifr.t_IFRAssociatedIdentity ImposeLimit (ifr.t_IFRAssociatedIdentity L) := transform
      a_did_norm  := project (L.LinkIdInfo.RiskIndicators,  norm (Left, Constants.ITYPES.T_DID));
      //a_ssn_norm  := normalize (L.SharedSSN, Left.RiskIndicators,     norm (Left, Constants.ITYPES.T_SSN));
      a_ssn_norm := normalize (L.SharedSSNs, Left.RiskIndicators, normWithID (Right, Constants.ITYPES.T_SSN, Left.SSNData.SSN));

      a_name_norm := project (L.NameInfo.RiskIndicators,    norm (Left, Constants.ITYPES.T_NAME));
      a_dob_norm  := project (L.DOBInfo.RiskIndicators,     norm (Left, Constants.ITYPES.T_DOB));
      a_addr_norm := project (L.AddressInfo.RiskIndicators, norm (Left, Constants.ITYPES.T_ADDRESS));
      a_phone_norm := normalize (L.PhoneInfo, Left.RiskIndicators, normWithID (Right, Constants.ITYPES.T_PHONE, Left.Phone10));

      // pickup selected number of most important ones
      all_indicators := a_did_norm + a_ssn_norm + a_name_norm + a_dob_norm + a_addr_norm + a_phone_norm;
      ind_chosen := choosen (sort (all_indicators, all_indicators.Rank, Description), max_num);

      Self.LinkIdInfo.RiskIndicators  := ind_chosen (ri_type = Constants.ITYPES.T_DID);
      Self.SharedSSNs := project (L.SharedSSNs, 
                                  transform (ifr.t_IFRSSN,
                                            Self.RiskIndicators := ind_chosen (ri_type = Constants.ITYPES.T_SSN, trim (indicative) = Left.SSNData.SSN),
                                            Self := Left));
//      Self.SSNInfo.RiskIndicators     := ind_chosen (ri_type = Constants.ITYPES.T_SSN);
      Self.NameInfo.RiskIndicators    := ind_chosen (ri_type = Constants.ITYPES.T_NAME);
      Self.DOBInfo.RiskIndicators     := ind_chosen (ri_type = Constants.ITYPES.T_DOB);
      Self.AddressInfo.RiskIndicators := ind_chosen (ri_type = Constants.ITYPES.T_ADDRESS);
      Self.PhoneInfo := project (L.PhoneInfo, 
                                 transform (ifr.t_IFRPhone,
                                            Self.RiskIndicators := ind_chosen (ri_type = Constants.ITYPES.T_PHONE, indicative = Left.Phone10),
                                            Self := Left));
      Self := L;
    end;
    res := project (imposters, ImposeLimit (Left));
    return res;
  end;

  // checks if indicator is "address/po is vacant" by code
  set of integer vacant_set := [Constants.RiskCodes.Address.ADVO_VACANT, Constants.RiskCodes.Address.ADVO_VACANT_PO];
  export boolean IsVacant (string cd) := GetIntegerCode (cd) in vacant_set;


  // ========================================================================
  // deprecated: Compile SUMMARY section
  // ========================================================================
  // For SUMMARY section we need to exclude all specific "no longer reported by ...", 
  // and replace it with neutral "Identity HAS <data> no longer reported"
  shared out_rec := iesp.identityfraudreport.t_IdentityFraudReportResponse;

  export dataset (out_rec) AppendSummary (dataset(out_rec) individual, integer max_top_hri) := function
    out_rec CompileSummary (out_rec L) := transform 
      NLR := Constants.RiskCodes.NLR;
      // DIDs
      did_inds := L.PrimaryIdentity.LinkIdInfo.RiskIndicators;
      did_nlr := did_inds ((integer) RiskCode in [NLR.DID_EQ, NLR.DID_EN]);
      did_summary_ri := did_inds ((integer) RiskCode not in [NLR.DID_EQ, NLR.DID_EN]) +
                        if (exists (did_nlr), GetRiskIndicator (NLR.DID));

      // SSNs
      ssn_inds := L.PrimaryIdentity.SSNInfo.RiskIndicators;
      ssn_nlr := ssn_inds ((integer) RiskCode in [NLR.SSN_EQ, NLR.SSN_EN]);
      ssn_summary_ri := ssn_inds ((integer) RiskCode not in [NLR.SSN_EQ, NLR.SSN_EN]) +
                        if (exists (ssn_nlr), GetRiskIndicator (NLR.SSN));

      // Names
      name_inds := L.PrimaryIdentity.NameInfo.RiskIndicators;
      name_nlr := name_inds ((integer) RiskCode in [NLR.NAME_EQ, NLR.NAME_EN]);
      name_summary_ri := name_inds ((integer) RiskCode not in [NLR.NAME_EQ, NLR.NAME_EN]) +
                         if (exists (name_nlr), GetRiskIndicator (NLR.NAME));

      // DOBs
      dob_inds := L.PrimaryIdentity.DOBInfo.RiskIndicators;
      dob_nlr := dob_inds ((integer) RiskCode in [NLR.DOB_EQ, NLR.DOB_EN]);
      dob_summary_ri := dob_inds ((integer) RiskCode not in [NLR.DOB_EQ, NLR.DOB_EN]) +
                        if (exists (dob_nlr), GetRiskIndicator (NLR.DOB));

      // Address
      address_inds := L.PrimaryIdentity.AddressInfo.RiskIndicators;
      address_nlr := address_inds ((integer) RiskCode in [NLR.ADDRESS_EQ, NLR.ADDRESS_EN]);
      // In addition, all USPIS address indicators will be replaced with one entry (same Rank)
      uspis_ri := address_inds (Providers = Constants.Providers.USPIS);
      address_summary_ri := address_inds (
         (integer) RiskCode not in [NLR.ADDRESS_EQ, NLR.ADDRESS_EN],
         providers != Constants.Providers.USPIS) +
                      if (exists (address_nlr), GetRiskIndicator (NLR.ADDRESS)) +
                      if (exists (uspis_ri), GetRiskIndicator (Constants.RiskCodes.Address.USPIS));

      // Phones:
      phones_inds := L.PrimaryIdentity.PhoneInfo.RiskIndicators;

      // combine all together
      indicators_subject_all := did_summary_ri + ssn_summary_ri + name_summary_ri + dob_summary_ri + address_summary_ri + phones_inds;

      // sort and dedup by rank (importance)
      indicators_subj_grp := group (sort (indicators_subject_all (Color != 'Blue'), indicators_subject_all.Rank), indicators_subject_all.Rank);
      subj_summary_ri := dedup (indicators_subj_grp, indicators_subj_grp.Rank);

      Self.ReportSummary.RiskIndicators := CHOOSEN (subj_summary_ri, max_top_hri);
      Self := L;
    end;
    return project (individual, CompileSummary (Left));
  end;
  // ----------------------------------------------------------------------------------


  // ========================================================================
  // Set up additional constraints on dates first/last
  // ========================================================================
  // Date first/last cannot be lower/later than correcponding dates for LinkID
  // this is probably a temporarily fix, untill dates issues are resolved
  shared linkid_rec := iesp.identityfraudreport.t_IFRLinkId;
  shared ssn_rec := iesp.identityfraudreport.t_IFRSSN;
  shared name_rec := iesp.identityfraudreport.t_IFRName;
  shared address_rec := iesp.identityfraudreport.t_IFRAddress;
  shared dob_rec := iesp.identityfraudreport.t_IFRDOB;

  shared iesp.share.t_Date patchDateFirst (iesp.share.t_Date src_date, integer low_bound, integer high_bound) := 
    map ( iesp.ECL2ESP.DateToInteger (src_date) > high_bound => iesp.ECL2ESP.toDate (high_bound),
					iesp.ECL2ESP.DateToInteger (src_date) < low_bound => iesp.ECL2ESP.toDate(low_bound),
					src_date);

  shared iesp.share.t_Date patchDateLast (iesp.share.t_Date src_date, integer low_bound, integer high_bound) := 
    if (iesp.ECL2ESP.DateToInteger (src_date) between low_bound and high_bound, src_date, iesp.ECL2ESP.toDate (high_bound));

  shared blank_date := iesp.ECL2ESP.toDate (0);

	// Bug 77282 - boolean value set to false so as to not blank the dt_last_seen if the dt_first_seen is blank and vice versa
	shared apply_blank := false;
	
  // transforms for individual data types
  shared ssn_rec PatchDatesSSN (ssn_rec L, integer low_bound, integer high_bound) := transform
    boolean is_valid := L.SSNData.SSN != '';
    // if either of the dates is blank, don't patch and set both dates to blank.
    boolean do_blank := (iesp.ECL2ESP.DateToInteger (L.DateFirstSeen) = 0) or (iesp.ECL2ESP.DateToInteger (L.DateLastSeen) = 0);

    Self.DateFirstSeen := if (is_valid, if (apply_blank and do_blank, blank_date, patchDateFirst (L.DateFirstSeen, low_bound, high_bound)));
    Self.DateLastSeen  := if (is_valid, if (apply_blank and do_blank, blank_date, patchDateLast  (L.DateLastSeen, low_bound, high_bound)));
    Self := L;
  end;
	
  shared name_rec PatchDatesName (name_rec L, integer low_bound, integer high_bound) := transform
    boolean is_valid := (L.Name.First != '') or (L.Name.Last != '');
    // if either of the dates is blank, don't patch and set both to blank.
    boolean do_blank := (iesp.ECL2ESP.DateToInteger (L.DateFirstSeen) = 0) or (iesp.ECL2ESP.DateToInteger (L.DateLastSeen) = 0);

    Self.DateFirstSeen := if (is_valid, if (apply_blank and do_blank, blank_date, patchDateFirst (L.DateFirstSeen, low_bound, high_bound)));
    Self.DateLastSeen  := if (is_valid, if (apply_blank and do_blank, blank_date, patchDateLast  (L.DateLastSeen, low_bound, high_bound)));
    Self := L;
  end;
	
  shared address_rec PatchDatesAddress (address_rec L, integer low_bound, integer high_bound) := transform
    boolean is_valid := ((L.Address.City != '') and (L.Address.State != '')) or (L.Address.Zip5 != '');
    // if either of the dates is blank, don't patch and set both to blank.
    boolean do_blank := (iesp.ECL2ESP.DateToInteger (L.DateFirstSeen) = 0) or (iesp.ECL2ESP.DateToInteger (L.DateLastSeen) = 0);

    Self.DateFirstSeen := if (is_valid, if (apply_blank and do_blank, blank_date, patchDateFirst (L.DateFirstSeen, low_bound, high_bound)));
    Self.DateLastSeen  := if (is_valid, if (apply_blank and do_blank, blank_date, patchDateLast  (L.DateLastSeen, low_bound, high_bound)));
    Self := L;
  end;
	
  shared dob_rec PatchDatesDOB (dob_rec L, integer low_bound, integer high_bound) := transform
    boolean is_valid := iesp.ECL2ESP.DateToInteger (L.DOB) > 0;
    // if either of the dates is blank, don't patch and set both to blank.
    boolean do_blank := (iesp.ECL2ESP.DateToInteger (L.DateFirstSeen) = 0) or (iesp.ECL2ESP.DateToInteger (L.DateLastSeen) = 0);

    Self.DateFirstSeen := if (is_valid, if (apply_blank and do_blank, blank_date, patchDateFirst (L.DateFirstSeen, low_bound, high_bound)));
    Self.DateLastSeen  := if (is_valid, if (apply_blank and do_blank, blank_date, patchDateLast  (L.DateLastSeen, low_bound, high_bound)));
    Self := L;
  end;

  // primary identity (subject)
  prim_rec := iesp.identityfraudreport.t_IFRPrimaryIdentity;
  shared prim_rec PatchIdentityDates (prim_rec L) := transform
    integer low_bound := iesp.ECL2ESP.DateToInteger (L.LinkIdInfo.DateFirstSeen);
    integer high_bound := iesp.ECL2ESP.DateToInteger (L.LinkIdInfo.DateLastSeen);

    Self.SSNInfo     := row (PatchDatesSSN (L.SSNInfo, low_bound, high_bound));
    Self.NameInfo    := row (PatchDatesName (L.NameInfo, low_bound, high_bound));
    Self.AddressInfo := row (PatchDatesAddress (L.AddressInfo, low_bound, high_bound));
    Self.DOBInfo     := row (PatchDatesDOB (L.DOBInfo, low_bound, high_bound));
    Self := L;
  end;

  // subject's associated data
  assoc_rec := iesp.identityfraudreport.t_IFRAssociatedData;
  shared assoc_rec PatchAssociatedDates (assoc_rec L, linkid_rec Subj) := transform
    integer low_bound := iesp.ECL2ESP.DateToInteger (Subj.DateFirstSeen);
    integer high_bound := iesp.ECL2ESP.DateToInteger (Subj.DateLastSeen);

    Self.SSNs      := project (L.SSNs,      PatchDatesSSN (Left, low_bound, high_bound));
    Self.Names     := project (L.Names,     PatchDatesName (Left, low_bound, high_bound));
    Self.Addresses := project (L.Addresses, PatchDatesAddress (Left, low_bound, high_bound));
    Self.DOBs      := project (L.DOBs,      PatchDatesDOB (Left, low_bound, high_bound));
    Self := L;
  end;

  // imposters
  imposter_rec := iesp.identityfraudreport.t_IFRAssociatedIdentity;
  imposter_rec PatchImposterDates (imposter_rec L) := transform
    integer low_bound := iesp.ECL2ESP.DateToInteger (L.LinkIdInfo.DateFirstSeen);
    integer high_bound := iesp.ECL2ESP.DateToInteger (L.LinkIdInfo.DateLastSeen);

    Self.SharedSSNs  := project (L.SharedSSNs, PatchDatesSSN (Left, low_bound, high_bound));
    Self.NameInfo    := row (PatchDatesName    (L.NameInfo, low_bound, high_bound));
    Self.AddressInfo := row (PatchDatesAddress (L.AddressInfo, low_bound, high_bound));
    Self.DOBInfo     := row (PatchDatesDOB     (L.DOBInfo, low_bound, high_bound));
    Self := L;
  end;

  // patch dates; main:
  export out_rec PatchDates (dataset(out_rec) individual) := function
    out_rec patch (out_rec L) := transform 
      Self.PrimaryIdentity := row (PatchIdentityDates (L.PrimaryIdentity));
      Self.AssociatedData  := row (PatchAssociatedDates (L.AssociatedData, L.PrimaryIdentity.LinkIdInfo));
      Self.AssociatedIdentities := project (L.AssociatedIdentities, PatchImposterDates (Left));
      Self := L;
    end;
    return project (individual, patch (Left));
  end;
  // ----------------------------------------------------------------------------------



  // ========================================================================
  // Mask SSN, DL, DOB 
  // ========================================================================
  // Masking is postponed until the very end of the query, since values-to-be-masked are used for linking and comparison 
  // (some legacy code reads masking directions from #stored, so I had to #constant (no any mask)

  // I have to wrap it into a function call, otherwise it can't be used inside the transform ("import" statement in the macro)
  shared ifr.t_IFRSSN MaskSSNs (dataset(ifr.t_IFRSSN) _ssns,
                         string ssn_mask) := function
    suppress.MAC_Mask (_ssns, outf, SSNData.SSN, blank, true, false, maskVal := ssn_mask);
    return outf;
  end;

  shared ifr.t_IFRDOB MaskDOBs (ifr.t_IFRDOB L, unsigned1 dob_mask) := transform
    Self.DOB := iesp.ECL2ESP.ApplyDateMask (L.DOB, dob_mask);
    Self.DOB2 := iesp.ECL2ESP.ApplyDateStringMask (L.DOB2, dob_mask);
    Self := L;
  end;
  
  shared ifr.t_IFRAssociatedIdentity MaskAssociatedIdentities (
               ifr.t_IFRAssociatedIdentity L, IParam._identityfraudreport param,
               boolean do_mask_ssn, boolean do_mask_dob) := transform

    Self.SharedSSNs := if (do_mask_ssn, MaskSSNs (L.SharedSSNs, param.ssn_mask), L.SharedSSNs);
    Self.DOBInfo    := if (do_mask_dob, project (L.DOBInfo, MaskDOBs (Left, param.dob_mask)), L.DOBInfo);
    Self := L;
  end;

  export out_rec MaskReport (dataset(out_rec) individual,
                             IParam._identityfraudreport param) := function

    boolean do_mask_ssn := (param.ssn_mask != '') and (param.ssn_mask != 'NONE');
    boolean do_mask_dob := param.dob_mask != suppress.Constants.DateMask.NONE;

    out_rec mask (out_rec L) := transform
      // DL and DOB masking for primary identity (SSN is done later)
      dl_num := L.PrimaryIdentity.DriverLicense.Number;
      Self.PrimaryIdentity.DriverLicense.Number := if (param.dl_mask = 1, suppress.dl_mask (dl_num), dl_num);
      Self.PrimaryIdentity.DOBInfo.DOB  := if (do_mask_dob, iesp.ECL2ESP.ApplyDateMask (L.PrimaryIdentity.DOBInfo.DOB, param.dob_mask), L.PrimaryIdentity.DOBInfo.DOB);
      Self.PrimaryIdentity.DOBInfo.DOB2 := if (do_mask_dob, iesp.ECL2ESP.ApplyDateStringMask (L.PrimaryIdentity.DOBInfo.DOB2, param.dob_mask), L.PrimaryIdentity.DOBInfo.DOB2);

      // alternative SSN and DOB data for primary identity
      Self.AssociatedData.SSNs := if (do_mask_ssn, MaskSSNs (L.AssociatedData.SSNs, param.ssn_mask), L.AssociatedData.SSNs);
      Self.AssociatedData.DOBs := if (do_mask_dob, project (L.AssociatedData.DOBs, MaskDOBs (Left, param.dob_mask)), L.AssociatedData.DOBs);

      // imposters have both SSNs and DOBs
      Self.AssociatedIdentities := project (L.AssociatedIdentities, MaskAssociatedIdentities (Left, param, do_mask_ssn, do_mask_dob));
      self := L;
    end;
    masked_child := project (individual, mask (Left));

    // now mask SSN for the main subject
    suppress.MAC_Mask (masked_child, outf, PrimaryIdentity.SSNInfo.SSNData.SSN, blank, true, false, maskVal := param.ssn_mask);
    return outf;
  end;    
  // ----------------------------------------------------------------------------------



  // returns unique DIDs fetched by driver's license. Input state is used as "not different" condition
  // TODO: does 'orig_state' matter at all?
  export dataset (doxie.layout_references) GetDidsByDL (string24 dl_num, string2 state_in) := function
    fetched_dls := LIMIT (DriversV2.Key_DL_Number (keyed (s_dl = dl_num)), Constants.MAX_DL_RECORDS, KEYED, SKIP);
    ds_filtered := fetched_dls (did != 0, ut.NNEQ (orig_state, state_in) or ut.NNEQ (state, state_in));
    return project (dedup (ds_filtered, did, all), doxie.layout_references);
  end;

  // utility function: prints out all codes, formatted.
  export dataset (ifr.t_ColoredRiskIndicator) GetFormattedCodes () := function
    ifr.t_ColoredRiskIndicator FormatCodes (layouts.ri_map L) := TRANSFORM
      Self.Color := Constants.GetColorDescription (L.color_code);
      Self.RiskCode := FormatCode (L.code); //note: change of code from "standard" to IdentityFraud
      Self.Rank := L.rank;
      Self.Description := L.description;
      Self.Providers := L.provider;
    end;
    return project (IdentityFraud_Services.RIMapTable, FormatCodes (Left));
  end;
	
	// Function to get the fraud level indices
	export	dataset(IdentityFraud_Services.layouts.id_fraud_attributes)	GetIdentityFraudRiskIndices(	dataset(doxie.layout_references)										dids,
																																																		dataset(doxie.layout_best)													dSubjectBestRecs,
																																																		IdentityFraud_Services.IParam._identityfraudreport	iParam,
																																																		boolean																							isFCRA,
																																																		string50 																						DataPermission
																																																	)	:=
	function
		// Primary identity DID
		primaryDID	:=	dids[1].did;
		
		// Format to layout that would enable to call the InstantID function
		risk_indicators.Layout_Input	tFormat2IIDIn(dSubjectBestRecs	pInput,integer	cnt)	:=
		transform
			self.seq							:=	cnt;
			self.score						:=	if(pInput.did	!=	0,100,0);
			self.in_StreetAddress	:=	Address.Addr1FromComponents(	pInput.prim_range,pInput.predir,pInput.prim_name,
																															pInput.suffix,pInput.postdir,pInput.unit_desig,pInput.sec_range
																														);
			self.in_city					:=	pInput.city_name;
			self.in_state					:=	pInput.st;
			self.in_zipcode				:=	pInput.zip;
			self.ssn							:=	if((integer)pInput.ssn	=	0,'',pInput.ssn);	// blank out social if it is all 0's
	
			self.suffix						:=	pInput.name_suffix;
			self.addr_suffix			:=	pInput.suffix;
			self.p_city_name			:=	pInput.city_name;
			self.z5								:=	pInput.zip;
			self.phone10					:=	pInput.phone;
			self.dob							:=	(string)pInput.dob;
			self.age							:=	if(pInput.age	=	0	and	pInput.dob	!=	0,(STRING3)ut.Age(pInput.dob),(string3)pInput.age);
			self.historydate			:=	999999;
			self									:=	pInput;
			self									:=	[];
		end;
		
		dFormat2IIDIn	:=	project(dSubjectBestRecs,tFormat2IIDIn(left,counter));
		
		// InstantID & Boca shell constants - obtained from "Models.FraudAdvisor_Service"
		dGateways												:=	Gateway.Constants.void_gateway;
		boolean		isLn									:=	false;	// not needed anymore
		boolean		isUtility							:=	false;
		boolean		doRelatives						:=	true;
		boolean		doDL									:=	false;
		boolean		doVehicle							:=	false;
		boolean		doDerogs							:=	true;
		boolean		doScore								:=	false;
		boolean		nugen									:=	true;
		boolean		ofac_only							:=	true;
		boolean		suppressNearDups			:=	false;
		boolean		require2Ele						:=	false;
		boolean		from_biid							:=	false;
		boolean		excludewatchlists			:=	false;
		boolean		from_IT1O							:=	false;
		unsigned1	OFACVersion						:=	1;			// default
		boolean		IncludeOfac						:=	false;
		boolean		addtl_watchlists			:=	false;
		real			gwThreshold						:=	0.84;		// default
		integer2	dobradius							:=	-1;			// since no DOB mask is supplied
		boolean		IncludeDLverification	:=	true;

		// Options for FraudPointAttrV2 indices
		unsigned	bsVersion							:=	51;			// to get the fraud point indices
		unsigned8	bsOptions							:=	risk_indicators.iid_constants.BSOptions.IncludeDoNotMail +
																				risk_indicators.iid_constants.BSOptions.IncludeFraudVelocity;
		
		// InstantID function
		dIID	:=	risk_indicators.InstantID_Function(	dFormat2IIDIn,
																									dGateways,
																									iParam.dppa,iParam.glb,
																									isUtility,isLn, 
																									ofac_only,
																									suppressNearDups,require2Ele,from_biid,
																									isFCRA,
																									excludewatchlists, 
																									from_IT1O,
																									OFACVersion,IncludeOfac,addtl_watchlists,gwThreshold,
																									dobradius,
																									BSversion,
																									in_runDLverification	:=	IncludeDLverification,
																									in_DataRestriction		:=	iParam.DataRestrictionMask,
																									in_BSOptions					:=	BSOptions,
																									in_DataPermission			:= 	DataPermission
																								);
		
		// BocaShell function
		dBocaShell	:=	Risk_Indicators.Boca_Shell_Function(	dIID,
																													dGateways,
																													iParam.dppa,iParam.glb,
																													isUtility,isLn,  
																													doRelatives,doDL,doVehicle,doDerogs,
																													bsVersion,
																													doScore,nugen,
																													DataRestriction	:=	iParam.DataRestrictionMask,
																													BSOptions				:=	bsOptions,
																													DataPermission	:= 	DataPermission
																												);
		
		dBocaShellUngrpd	:=	ungroup(dBocaShell);
		
		// Slim the layout to contain only the fraud attributes listed in the change request
		IdentityFraud_Services.layouts.fraud_attributes	tFraudAttributes(dBocaShellUngrpd	pInput)	:=
		transform
			dFraudAttr	:=	models.Attributes_Master(pInput,isFCRA);
			self.ssn													:=	pInput.shell_input.ssn;
			self.title												:=	pInput.shell_input.title;
			self.fname												:=	pInput.shell_input.fname;
			self.mname												:=	pInput.shell_input.mname;
			self.lname												:=	pInput.shell_input.lname;
			self.name_suffix									:=	pInput.shell_input.suffix;
			self.prim_range										:=	pInput.shell_input.prim_range;
			self.predir												:=	pInput.shell_input.predir;
			self.prim_name										:=	pInput.shell_input.prim_name;
			self.addr_suffix									:=	pInput.shell_input.addr_suffix;
			self.postdir											:=	pInput.shell_input.postdir;
			self.unit_desig										:=	pInput.shell_input.unit_desig;
			self.sec_range										:=	pInput.shell_input.sec_range;
			self.v_city_name									:=	pInput.shell_input.p_city_name;
			self.st														:=	pInput.shell_input.st;
			self.zip5													:=	pInput.shell_input.z5;
			self.zip4													:=	pInput.shell_input.zip4;
			self.addr_rec_type								:=	pInput.shell_input.addr_type;
			self.fips_county									:=	pInput.shell_input.county[1..3];
			self.geo_lat											:=	pInput.shell_input.lat;
			self.geo_long											:=	pInput.shell_input.long;
			self.geo_blk											:=	pInput.shell_input.geo_blk;
			self.IdentityRecentUpdate					:=	dFraudAttr.RecentUpdate;
			self.VariationAddrStability				:=	dFraudAttr.AddrStability;
			self.VariationPhoneCount					:=	dFraudAttr.SubjectPhoneCount;
			self.VariationSearchSSNCount			:=	dFraudAttr.PRSearchIdentitySSNs;
			self.VariationSearchAddrCount			:=	dFraudAttr.PRSearchIdentityAddrs;
			self.VariationSearchPhoneCount		:=	dFraudAttr.PRSearchIdentityPhones;
			self.SearchCountYear							:=	dFraudAttr.PRSearchCountYear;
			self.SearchCountMonth							:=	dFraudAttr.PRSearchCountMonth;
			self.SearchCountWeek							:=	dFraudAttr.PRSearchCountWeek;
			self.SearchCountDay								:=	dFraudAttr.PRSearchCountDay;
			self.DivAddrSuspIdentityCountNew	:=	dFraudAttr.DivAddrSuspIdentityCountNew;
			self.SearchSSNSearchCountYear			:=	dFraudAttr.PRSearchSSNSearchCountYear;
			self.SearchSSNSearchCountMonth		:=	dFraudAttr.PRSearchSSNSearchCountMonth;
			self.SearchSSNSearchCountWeek			:=	dFraudAttr.PRSearchSSNSearchCountWeek;
			self.SearchSSNSearchCountDay			:=	dFraudAttr.PRSearchSSNSearchCountDay;
			self.IdentityRiskLevel						:=	dFraudAttr.IdentityRiskLevel;
			self.SourceRiskLevel							:=	dFraudAttr.SourceRiskLevel;
			self.VelocityRiskLevel						:=	dFraudAttr.PRSearchVelocityRiskLevel;
			self															:=	pInput;
			self															:=	[];
		end;
		
		dFraudAttributes	:=	project(dBocaShellUngrpd,tFraudAttributes(left));
		
		// Convert to boolean values so as to populated the risk indicator messages using these values.
		// Did not calculate the boolean values in the previous project as it can be used for debugging purposes
		IdentityFraud_Services.layouts.id_fraud_attributes	tIdFraud(dFraudAttributes	pInput)	:=
		transform
			self.IdentityRecentUpdate					:=	pInput.IdentityRecentUpdate	!=	''	and	(integer)pInput.IdentityRecentUpdate	=	0;
			self.VariationAddrStability				:=	(integer)pInput.VariationAddrStability	in	[1,2];
			self.VariationPhoneCount					:=	(integer)pInput.VariationPhoneCount	>=	3;
			self.VariationSearchSSNCount			:=	(pInput.did	=	primaryDID)	and	((integer)pInput.VariationSearchSSNCount	>=	3);
			self.VariationSearchAddrCount			:=	(pInput.did	=	primaryDID)	and	((integer)pInput.VariationSearchAddrCount	>=	3);
			self.VariationSearchPhoneCount		:=	(pInput.did	=	primaryDID)	and	((integer)pInput.VariationSearchPhoneCount	>=	3);
			self.SearchCountYear							:=	(pInput.did	=	primaryDID)	and	((integer)pInput.SearchCountYear	>=	7);
			self.SearchCountMonth							:=	(pInput.did	=	primaryDID)	and	((integer)pInput.SearchCountMonth	>=	5);
			self.SearchCountWeek							:=	(pInput.did	=	primaryDID)	and	((integer)pInput.SearchCountWeek	>=	3);
			self.SearchCountDay								:=	(pInput.did	=	primaryDID)	and	((integer)pInput.SearchCountDay	>=	2);
			self.DivAddrSuspIdentityCountNew	:=	(integer)pInput.DivAddrSuspIdentityCountNew	>=	3;
			self.SearchSSNSearchCountYear			:=	(integer)pInput.SearchSSNSearchCountYear	>=	7;
			self.SearchSSNSearchCountMonth		:=	(integer)pInput.SearchSSNSearchCountMonth	>=	5;
			self.SearchSSNSearchCountWeek			:=	(integer)pInput.SearchSSNSearchCountWeek	>=	3;
			self.SearchSSNSearchCountDay			:=	(integer)pInput.SearchSSNSearchCountDay	>=	2;
			self.TotalSearchCountYear					:=	pInput.SearchCountYear;
			self.TotalSearchCountMonth				:=	pInput.SearchCountMonth;
			self.TotalSearchCountWeek					:=	pInput.SearchCountWeek;
			self.TotalSearchCountDay					:=	pInput.SearchCountDay;
			self															:=	pInput;
		end;
		
		dIdFraudAttributes	:=	project(dFraudAttributes,tIdFraud(left));
		
		// Debugging
		// output(dIID,named('dIID'));
		// output(dBocaShell,named('dBocaShell'));
		// output(dFraudAttributes,named('dFraudAttributes'));
		// output(dIdFraudAttributes,named('dIdFraudAttributes'));
		
		return	dIdFraudAttributes;
	end;
	
	// Function to get the emails for the identity
	export	dataset(IdentityFraud_Services.Layouts.email_did_rec)	GetEmails(	dataset(EmailService.Assorted_Layouts.layout_report_rollup)	dEmails,
																																						IdentityFraud_Services.IParam._identityfraudreport					param, 
																																						boolean isFCRA = false
																																					)	:=
	function
		IdentityFraud_Services.Layouts.email_rec	tNormEmail(dEmails	pInput,integer	cnt)	:=
		transform
			self.did							:=	pInput.did;
			self.src							:=	pInput.src;
			self._type						:=	Constants.EmailDataFamily;
			self.royalty					:=	false;
			self.EmailAddress			:=	pInput.emails[cnt].orig_email;
			self.datefirstseen		:=	iesp.ECL2ESP.toDateYM((integer)pInput.emails[cnt].date_first_seen[1..6]);
			self.datelastseen			:=	iesp.ECL2ESP.toDateYM((integer)pInput.emails[cnt].date_last_seen[1..6]);
			self.date_first_seen	:=	pInput.emails[cnt].date_first_seen[1..6];
			self.date_last_seen		:=	pInput.emails[cnt].date_last_seen[1..6];
			self									:=	[];
		end;
		
		dEmailNorm	:=	normalize(dEmails,count(left.emails),tNormEmail(left,counter));
		
		// Populate the royalty flag
		IdentityFraud_Services.Layouts.email_rec	tEmailRoyaltyFlag(dEmailNorm	pInput)	:=
		transform
			self.royalty	:=	pInput.src in Royalty.Constants.EMAIL_ROYALTY_SET(isFCRA);
			self					:=	pInput;
		end;
		
		dEmailRoyaltyFlag	:=	project(dEmailNorm,tEmailRoyaltyFlag(left));
		
		// Remove the royalty based records if we have the same email from a flat based vendor
		dEmailRoyaltyRecs		:=	dEmailRoyaltyFlag(royalty);
		dEmailNoRoyaltyRecs	:=	dEmailRoyaltyFlag(~royalty);
		
		dEmailRoyaltyOnly	:=	join(	dEmailRoyaltyRecs,
																dEmailNoRoyaltyRecs,
																left.did					=	right.did	and
																left.EmailAddress	=	right.EmailAddress,
																transform(IdentityFraud_Services.Layouts.email_rec,self	:=	left),
																left only
															);
		
		dEmailAll	:=	dEmailNoRoyaltyRecs	+	dEmailRoyaltyOnly;
		
		// Sort and rollup by email
		dEmailGroup	:=	group(sort(dEmailAll,did,EmailAddress),did,EmailAddress);
		
		IdentityFraud_Services.Layouts.email_rec	tEmailRollup(IdentityFraud_Services.Layouts.email_rec	le,dataset(IdentityFraud_Services.Layouts.email_rec)	ri)	:=
		transform
			// Dedup by source accross the family categories (_type)
			dEmailSrcDedup	:=	dedup(group(sort(ri,_type,src),_type),src);
			
			ifr.t_IFRLinkIdSources	tSourceRollup(IdentityFraud_Services.Layouts.email_rec	le,dataset(IdentityFraud_Services.Layouts.email_rec)	ri)	:=
			transform
				self._type	:=	le._type;
				self.count	:=	count(ri);
			end;
			
			self.datefirstseen	:=	iesp.ECL2ESP.toDateYM((integer)min(ri((integer)date_first_seen	>	0),date_first_seen));
			self.datelastseen		:=	iesp.ECL2ESP.toDateYM((integer)max(ri(date_last_seen	<=	(string)STD.Date.Today()),date_last_seen));
			self.sourcecount		:=	if(param.count_by_source,count(dedup(ri,src,all)),count(dedup(ri,_type,all)));
			self.sources				:=	rollup(dEmailSrcDedup,group,tSourceRollup(left,rows(left)));
			self								:=	le;
		end;
		
		dEmailRollup	:=	rollup(dEmailGroup,group,tEmailRollup(left,rows(left)));
		
		return	topn(	project(dEmailRollup,IdentityFraud_Services.Layouts.email_did_rec),
									iesp.Constants.IFR.MaxEmails,did,royalty,-datelastseen,EmailAddress
								);
	end;
	
END;
