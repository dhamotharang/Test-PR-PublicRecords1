IMPORT doxie, iesp, ut, header, header_quick, patriot;

header_rec := IdentityFraud_Services.layouts.slim_header;

EXPORT layouts.names_did_rec GetNamesIndicators (
  dataset (IdentityFraud_Services.layouts.slim_header) header_ext,
  IdentityFraud_Services.IParam._identityfraudreport param) := FUNCTION

  header_names := group (sort (header_ext, did, lname, fname, mname, name_suffix), did, lname, fname, mname, name_suffix);
  layouts.names_did_rec SetAssociatedNames (header_rec L, dataset (header_rec) R) := transform
    Self.did := L.did;
    Self.Name := iesp.ECL2ESP.SetName (L.fname, L.mname, L.lname, L.name_suffix, L.title);
    // we will temporarily exclude EQ (and transitively QH) when calculating dates
    Self.DateFirstSeen := iesp.ecl2esp.toDateYM (min (R (dt_vendor_first_reported > 0), dt_vendor_first_reported));
    Self.DateLastSeen := iesp.ecl2esp.toDateYM (max (R, dt_vendor_last_reported));
    // get source categories' counts:
    Self.Sources := choosen (Functions.GetSources (R), iesp.Constants.IFR.MaxSourcetypes);
    // overal count:
    Self.SourceCount := if (param.count_by_source, count (dedup (R, src, all)), count (dedup (R, _type, all)));

    // no longer reported indicators
    ISC := Header.constants.no_longer_reported;
    ICRN := IdentityFraud_Services.Constants.RiskCodes.NLR;
    indicators := Functions.IndicatorsSum (project (R, layouts.bureau_indicator));
    ri_nlr := if (indicators & ISC.name_not_in_en = ISC.name_not_in_en, Functions.GetRiskIndicator (ICRN.NAME_EN)) +
              if (indicators & ISC.name_not_in_eq = ISC.name_not_in_eq, Functions.GetRiskIndicator (ICRN.NAME_EQ)) +
              if (indicators & ISC.name_not_in_tn = ISC.name_not_in_tn, Functions.GetRiskIndicator (ICRN.NAME_TU));
    Self.RiskIndicators := choosen (ri_nlr, iesp.Constants.IFR.MaxIndicators);
  end;
  a_names_header := rollup (header_names, group, SetAssociatedNames (left, rows (left)));

/*
  // Get OFAC name indicator
  // TODO: see if patriot@Search_Function call must be used as in doxie@CompPatriotSearch
  // -- this will require more complicated name-mathc afterwards

	header_for_ofac := dedup (sort(header_names, fname,lname,mname), fname,lname,mname); // unique list of names for the subject
	patriot.Layout_batch_in ToBatch (header_rec L) := transform
		self.name_middle := l.mname;
		self.name_first := l.fname;
		self.name_last := l.lname;
		self.acctno := '';
		self.name_unparsed := '';
		self.search_type := 'BOTH'; 
		self.country :='';
		self.dob := ''; //?
		//self := L;
	end;    
  b_ds := project(header_for_ofac, ToBatch (Left));

	gb_ds := group (sorted (b_ds, acctno), acctno);


  a_names_ofac := ungroup (patriot.Search_Base_Function (gb_ds, false, , true, , true, true));
// export Search_Base_Function(GROUPED DATASET(patriot.Layout_batch_in) in_data, 
														// boolean ofaconly_value,
														// real threshold_value = Constants.DEF_THRESHOLD,
														// boolean noFail=false,
														// unsigned1 ofac_version=1,
														// boolean include_ofac=FALSE,
														// boolean include_Additional_watchlists=FALSE,
														// dataset(iesp.share.t_StringArrayItem) watchlists_requested=dataset([], iesp.share.t_StringArrayItem)) :=

  layouts.names_did_rec AppendOFACIndicator (layouts.names_did_rec L, patriot.Layout_Base_Results.parent R) := transform
    Self.RiskIndicators := if (R.pty_key != '', 
                               L.RiskIndicators + Functions.GetRiskIndicator (Constants.RiskCodes.Name.OFAC),
                               L.RiskIndicators);
    Self := L;
  end;

  a_names := join (a_names_header, a_names_ofac,
                   (Left.Name.First = Right.name_first) and
                   (Left.Name.Last = Right.name_last) and
                   (Left.Name.Middle = '' or Left.Name.Middle = Right.name_middle),
                   AppendOFACIndicator (Left, Right),
                   Left outer, limit (0), keep (1)); 
*/
  return a_names_header;
END;

