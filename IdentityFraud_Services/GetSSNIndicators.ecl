IMPORT doxie, iesp, Suppress, header, header_quick, risk_indicators;

header_rec := IdentityFraud_Services.layouts.slim_header;

EXPORT layouts.ssn_did_rec GetSSNIndicators (
  dataset (header_rec) header_ext,
	dataset (IdentityFraud_Services.layouts.id_fraud_attributes) fraud_indices,
  IdentityFraud_Services.IParam._identityfraudreport param) := FUNCTION

  // to transform input for use by standard macros assigning HRIs
  ssn_hri_rec := record (header_rec)
    unsigned cnt := 0; // this field is used in address rollup only
    unsigned3 ssn_issue_early := 0;
    unsigned3 ssn_issue_last := 0;
    string2  ssn_issue_place := '';
    dataset (risk_indicators.layout_desc) hri_ssn {maxcount(Constants.MAX_HRI)} := dataset([], risk_indicators.layout_desc);
  end;  

  ssn_hri_rec ToSSNHRI (header_rec L) := transform
     Self := L;
  end;
  // don't want to count SSNs appended from elsewhere
  header_ssns := project (header_ext (ssn != '', valid_ssn != 'M'), ToSSNHRI (Left));
  maxHriPer_value := param.max_hri;
	doxie.mac_AddHRISSN(header_ssns, header_ssns_hri, false);

  // Add SSN fraud indicators
	ssn_hri_rec tSSNFraudInd(header_ssns_hri le,fraud_indices ri) :=
	transform
		ri_ssn_fraud := if(ri.SearchSSNSearchCountYear,row({Constants.RiskCodes.SSN.EXCESSIVE_SEARCHES_YEAR,'FRAUD_IND'},risk_indicators.layout_desc)) +
										if(ri.SearchSSNSearchCountMonth,row({Constants.RiskCodes.SSN.EXCESSIVE_SEARCHES_MONTH,'FRAUD_IND'},risk_indicators.layout_desc)) +
										if(ri.SearchSSNSearchCountWeek,row({Constants.RiskCodes.SSN.EXCESSIVE_SEARCHES_WEEK,'FRAUD_IND'},risk_indicators.layout_desc)) +
										if(ri.SearchSSNSearchCountDay,row({Constants.RiskCodes.SSN.EXCESSIVE_SEARCHES_DAY,'FRAUD_IND'},risk_indicators.layout_desc));
		
		self.hri_ssn := le.hri_ssn + ri_ssn_fraud;
		self         := le;
	end;
	
	a_ssns_fraud := join (header_ssns_hri,
												fraud_indices,
												left.did = right.did and
												left.ssn = right.ssn,
												tSSNFraudInd(left,right),
												left outer,
												limit(0),keep(1));
	
  header_pre_ssn := group (sort (a_ssns_fraud, did, ssn, src), did, ssn);
	
  layouts.ssn_did_rec SetAssociatedSSNs (ssn_hri_rec L, dataset (ssn_hri_rec) R) := transform
    Self.did := L.did;
    Self.SSNData.SSN := L.ssn;
// TODO: verify descriptions (Header.layout_header_v2 doesn't list all possibilities)
    Self.SSNData.Valid := if (L.valid_ssn IN ['G','M'], 'yes', 'no');
    Self.SSNData := []; // state name and dates cannot be used here

    Self.DateFirstSeen := iesp.ecl2esp.toDateYM (min (R (dt_vendor_first_reported > 0), dt_vendor_first_reported));
    Self.DateLastSeen := iesp.ecl2esp.toDateYM (max (R, dt_vendor_last_reported));

    // get source categories' counts:
    Self.Sources := choosen (Functions.GetSources (R), iesp.Constants.IFR.MaxSourcetypes);
    // overal count:
    Self.SourceCount := if (param.count_by_source, count (dedup (R, src, all)), count (dedup (R, _type, all)));

    ISC := Header.constants.no_longer_reported;
    ICRN := IdentityFraud_Services.Constants.RiskCodes.NLR;
    indicators := Functions.IndicatorsSum (project (R, layouts.bureau_indicator));  // cannot use deduped dataset here
    ri_nlr := if (indicators & ISC.ssn_not_in_en = ISC.ssn_not_in_en, Functions.GetRiskIndicator (ICRN.SSN_EN)) +
              if (indicators & ISC.ssn_not_in_eq = ISC.ssn_not_in_eq, Functions.GetRiskIndicator (ICRN.SSN_EQ)) +
              if (indicators & ISC.ssn_not_in_tn = ISC.ssn_not_in_tn, Functions.GetRiskIndicator (ICRN.SSN_TU));

    // take previously calculated RIs and append "no longer reported"
    _indicators := if (exists (L.hri_ssn), project (L.hri_ssn, Functions.TransformRiskIndicators (Left))) + ri_nlr;
		
    Self.RiskIndicators := choosen (_indicators, iesp.Constants.IFR.MaxIndicators);
  end;
  a_ssns_rolled := rollup (header_pre_ssn, group, SetAssociatedSSNs (left, rows (left)));
	
  layouts.ssn_did_rec GetCommonSSNIndicators (layouts.ssn_did_rec L, header_quick.key_ssn_validity R) := transform
		hasCommonRI := R.ssn_flags_bitmap>0 and not Suppress.dateCorrect.do(R.ssn).needed;
    HCS := Header.constants.ssn_indicators;

// TODO: check if ITIN is better to be taken from standard doxie/mac_AddHRISSN indicators;
//       if it is, then standard code '2388' should be added to Constants and handled appropriately.
    common_ri := 
      if (R.ssn_flags_bitmap & HCS.IS_ITIN               = HCS.IS_ITIN,               Functions.GetRiskIndicator (Constants.RiskCodes.SSN.ITIN)) +
      // if (R.ssn_flags_bitmap & HCS.IS_PARTIAL            = HCS.IS_PARTIAL,            Functions.GetRiskIndicator (Constants.RiskCodesSSN.)) +
      if (R.ssn_flags_bitmap & HCS.IS_EAE                = HCS.IS_EAE,                Functions.GetRiskIndicator (Constants.RiskCodes.SSN.ENUMERATION)) +
      // all these are "invalid or not yet issued"
      if ((R.ssn_flags_bitmap & HCS.IS_666                = HCS.IS_666) or
          (R.ssn_flags_bitmap & HCS.IS_ADVERTISING        = HCS.IS_ADVERTISING) or
          (R.ssn_flags_bitmap & HCS.IS_WOOLWORTH          = HCS.IS_WOOLWORTH) or
          (R.ssn_flags_bitmap & HCS.IS_INVALID_AREA       = HCS.IS_INVALID_AREA) or
          (R.ssn_flags_bitmap & HCS.IS_INVALID_GROUP      = HCS.IS_INVALID_GROUP) or
          // (R.ssn_flags_bitmap & HCS.AREA_GROUP_NOT_ISSUED = HCS.AREA_GROUP_NOT_ISSUED) or
          (R.ssn_flags_bitmap & HCS.IS_INVALID_SERIAL     = HCS.IS_INVALID_SERIAL),
          Functions.GetRiskIndicator (Constants.RiskCodes.SSN.INVALID));

    Self.RiskIndicators := choosen(L.RiskIndicators + if(hasCommonRI, common_ri), iesp.Constants.IFR.MaxIndicators);
    Self := L;
  end;

  //get general ssn indicators: those are based just on a number out of any context
  a_ssns := JOIN (a_ssns_rolled, header_quick.key_ssn_validity,
                  keyed (Left.SSNData.ssn = Right.ssn),
                  GetCommonSSNIndicators (Left, Right),
                  LEFT OUTER, KEEP (1), limit (0));  // atmost 1 : 1 

  return a_ssns;
END;

