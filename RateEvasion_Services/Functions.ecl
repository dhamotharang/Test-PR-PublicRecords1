import AutoStandardI,Census_data,codes,doxie,DriversV2,dx_Gong,iesp,Risk_Indicators,Suppress,ut,VehicleV2,Watchdog,NID,MDR,
       dx_header;

export Functions := module

	export params := interface(
			AutoStandardI.InterfaceTranslator.ssn_mask_value.params
			,AutoStandardI.InterfaceTranslator.cleaned_name.params
			,AutoStandardI.InterfaceTranslator.fname_value.params
			,AutoStandardI.InterfaceTranslator.mname_value.params
			,AutoStandardI.InterfaceTranslator.lname_value.params
			,AutoStandardI.InterfaceTranslator.name_suffix_val.params
			,AutoStandardI.InterfaceTranslator.prange_value.params
			,AutoStandardI.InterfaceTranslator.predir_value.params
			,AutoStandardI.InterfaceTranslator.pname_value.params
			,AutoStandardI.InterfaceTranslator.addr_suffix_value.params
			,AutoStandardI.InterfaceTranslator.postdir_value.params
			,AutoStandardI.InterfaceTranslator.sec_range_value.params
			,AutoStandardI.InterfaceTranslator.city_value.params
			,AutoStandardI.InterfaceTranslator.state_value.params
			,AutoStandardI.InterfaceTranslator.zip_value_cleaned.params
			,AutoStandardI.InterfaceTranslator.ssn_value.params
			,AutoStandardI.InterfaceTranslator.dob_val.params
			,AutoStandardI.InterfaceTranslator.phone_value.params
			,AutoStandardI.InterfaceTranslator.dl_mask_value.params
			,AutoStandardI.InterfaceTranslator.application_type_val.params
			,AutoStandardI.PermissionI_Tools.params
		)
	  // Fields passed in from Search_Records via in_mod and used throughout this attribute.
		export boolean   phoneticmatch  := false;
	  export boolean   allownicknames := false;

		export string20  agent_number  := '';
	  export string20  claim_number  := '';
	  export unsigned8 polinc_date   := 0;
	  export string20  policy_number := '';
	  export unsigned8 date_loss     := 0;
	  export string20  exam_adj_code := '';

	  export boolean include_score                      := false;
	  export boolean include_previousaddresses          := false;
		export boolean include_reversephonelookup         := false;
	  export boolean include_driverlicense              := false;
	  export boolean include_motorvehicles              := false;
	  export boolean include_additionaldrivers          := false;
	  export boolean include_potentialadditionaldrivers := false;
		export boolean include_non_regulated_sources      := false;

		export set of string30 input_vins := [];

		// 2 lines below added for scoring info changes (Bug 44338)
		export string20 company_id      := '';
		export string40000 scoring_info := '';
	end;
 shared MAC_CopyComplianceValuesFromLegacy (mod) := MACRO
    EXPORT unsigned1 unrestricted := 0 | IF (mod.AllowGLB, doxie.compliance.ALLOW.GLB, 0)
                                       | IF (mod.AllowDPPA, doxie.compliance.ALLOW.DPPA, 0)
                                       | IF (mod.AllowALL, doxie.compliance.ALLOW.ALL, 0);
    EXPORT unsigned1 glb := mod.GLBPurpose;
    EXPORT unsigned1 dppa := mod.DPPAPurpose;
    EXPORT string DataPermissionMask := mod.DataPermissionMask;
    //EXPORT boolean ln_branded := mod.lnbranded;
    EXPORT string5 industry_class := mod.IndustryClass;
    EXPORT string32 application_type := mod.ApplicationType;
    EXPORT boolean show_minors := mod.IncludeMinors;
    EXPORT unsigned1 mask_dl := mod.dlmask;
  ENDMACRO;

	lname_var := RECORD
		string20	fname;
		STRING20  lname;
		unsigned3 first_seen;
		unsigned3 last_seen;
	END;
	ssn_table_rec := RECORD
		STRING9 ssn;
		unsigned3 official_first_seen;
		unsigned3 official_last_seen;
		unsigned3 header_first_seen;
		unsigned3 header_last_seen;
		boolean isValidFormat;
		boolean isSequenceValid;
		boolean isBankrupt;
		unsigned dt_first_bankrupt;
		boolean isDeceased;
		unsigned dt_first_deceased;
		unsigned decs_dob;
		string5 decs_zip_lastres;
		string5 decs_zip_lastpayment;
		string20 decs_last;
		string20 decs_first;
		STRING2 issue_state;
		INTEGER headerCount;
		INTEGER EqCount;
		INTEGER TuCount;
		INTEGER SrcCount;
		INTEGER DidCount;
		INTEGER DidCount_c6;
		integer addr_ct;
		integer addr_ct_c6;
		INTEGER BestCount;
		INTEGER RecentCount;
		unsigned6 BestDid;
		lname_var lname1;
		lname_var lname2;
		lname_var lname3;
		lname_var lname4;
	END;

  export fnSearchVal(dataset(doxie.layout_presentation) in_recs,
                     params in_mod) := function

    gm :=  AutoStandardI.GlobalModule();
    mod_access_pre := doxie.compliance.GetGlobalDataAccessModuleTranslated (gm);
    mod_access := module(mod_access_pre)
      MAC_CopyComplianceValuesFromLegacy(in_mod);
    end;

    // ----------------------------------------------------------------------------------
    // Common routine used to get the name of a county
    get_county_name(string2 st_in, string3 county_in) :=
		        Census_data.Key_Fips2County(keyed(st_in = state_code AND
                                              county_in = county_fips))[1].county_name;

    // Common routine used to only output a person's title if it is not one of the standard ones.
    check_title (string5 title_in) := map (title_in = 'MR'  or
		                                       title_in = 'MS'  or
																					 title_in = 'MRS' or
																					 title_in = 'MISS'   => ' ',
	                                         title_in);

    // Get the date the search is being run
    integer4 run_yyyymmdd := (integer4) StringLib.GetDateYYYYMMDD();

    // Get the time the search is being run
    string6 time_hhmmss := ut.getTime();
    string2 hh := time_hhmmss[1..2];
	  string2 mm := time_hhmmss[3..4];
    string2 ss := time_hhmmss[5..6];

    // Set passed-in include_* booleans to local attributes to be used later on
		// in various places.
    boolean IncludeScore    := in_mod.include_score;
	  boolean IncludePA       := in_mod.include_previousaddresses;
		boolean IncludeRPL      := in_mod.include_reversephonelookup;
	  boolean IncludeDL       := in_mod.include_driverlicense;
	  boolean IncludeMVR      := in_mod.include_motorvehicles;
	  boolean IncludeAD       := in_mod.include_additionaldrivers;
	  boolean IncludePAD      := in_mod.include_potentialadditionaldrivers;


		// *** Handle passed-in scoring related fields.

		// Check for special MAIF customer# to know which defaults to use (if needed).
		boolean CustomerIsMaif  := if(trim(in_mod.company_id,left,right)=RateEvasion_Services.Constants.MAIF_company_id,
		                                   true,false);

    // Store entire ESP passed-in scoring info into local string attribute and set boolean
		// for use in multiple places below.
    string scoring_info_in := if(in_mod.scoring_info<>'',in_mod.scoring_info,'');
	  boolean ScoringInput   := if(scoring_info_in<>'',true,false);

    // The ESP passed-in <ScoringInfo> contains xml encoded characters, &lt; &gt;, etc.
		// So use XMLDECODE to decode them into "<", ">", etc.
		string decoded_scoring_info := XMLDECODE(scoring_info_in);

    // Store decoded xml string in a dataset for parsing below.
    ds_si_xmlin := dataset ([{decoded_scoring_info}], {string40000 line});

    // Record layout of parsed fields using appropriate xpath tag names.
    layout_scoring_info_in := record
	    string5   version          := XMLTEXT('version');
			integer1  starting_score   := (integer1) XMLTEXT('starting-score');
	    integer1  fn_match         := (integer1) XMLTEXT('element-scores/first-name/match');
			integer1  fn_nomatch       := (integer1) XMLTEXT('element-scores/first-name/no-match');
			integer1  fn_missing       := (integer1) XMLTEXT('element-scores/first-name/output-missing');
	    integer1  ln_match         := (integer1) XMLTEXT('element-scores/last-name/match');
			integer1  ln_nomatch       := (integer1) XMLTEXT('element-scores/last-name/no-match');
			integer1  ln_missing       := (integer1) XMLTEXT('element-scores/last-name/output-missing');
	    integer1  addr_match       := (integer1) XMLTEXT('element-scores/address/match');
			integer1  addr_nomatch     := (integer1) XMLTEXT('element-scores/address/no-match');
			integer1  addr_missing     := (integer1) XMLTEXT('element-scores/address/output-missing');
	    integer1  city_match       := (integer1) XMLTEXT('element-scores/city/match');
			integer1  city_nomatch     := (integer1) XMLTEXT('element-scores/city/no-match');
			integer1  city_missing     := (integer1) XMLTEXT('element-scores/city/output-missing');
	    integer1  st_match         := (integer1) XMLTEXT('element-scores/state/match');
			integer1  st_nomatch       := (integer1) XMLTEXT('element-scores/state/no-match');
			integer1  st_missing       := (integer1) XMLTEXT('element-scores/state/output-missing');
	    integer1  zip_match        := (integer1) XMLTEXT('element-scores/zip/match');
			integer1  zip_nomatch      := (integer1) XMLTEXT('element-scores/zip/no-match');
			integer1  zip_missing      := (integer1) XMLTEXT('element-scores/zip/output-missing');
	    integer1  ssn_match        := (integer1) XMLTEXT('element-scores/ssn/match');
			integer1  ssn_nomatch      := (integer1) XMLTEXT('element-scores/ssn/no-match');
			integer1  ssn_missing      := (integer1) XMLTEXT('element-scores/ssn/output-missing');
	    integer1  dob_match        := (integer1) XMLTEXT('element-scores/dob/match');
			integer1  dob_nomatch      := (integer1) XMLTEXT('element-scores/dob/no-match');
			integer1  dob_missing      := (integer1) XMLTEXT('element-scores/dob/output-missing');
	    integer1  phn_match        := (integer1) XMLTEXT('element-scores/phone/match');
			integer1  phn_nomatch      := (integer1) XMLTEXT('element-scores/phone/no-match');
			integer1  phn_missing      := (integer1) XMLTEXT('element-scores/phone/output-missing');
    end;

    // Parse the input decoded scoring info xml into a record which contains only the
		// scoring value fields being used below.
    rec_si_xmlin := PARSE( ds_si_xmlin, line, layout_scoring_info_in, XML('scoring') );

    // Store parsed record fields into local attributes to use below.
    version_in        := rec_si_xmlin[1].version;
    starting_score_in := rec_si_xmlin[1].starting_score;
    fn_match_in       := rec_si_xmlin[1].fn_match;
    fn_nomatch_in     := rec_si_xmlin[1].fn_nomatch;
    fn_missing_in     := rec_si_xmlin[1].fn_missing;
    ln_match_in       := rec_si_xmlin[1].ln_match;
    ln_nomatch_in     := rec_si_xmlin[1].ln_nomatch;
    ln_missing_in     := rec_si_xmlin[1].ln_missing;
    addr_match_in     := rec_si_xmlin[1].addr_match;
    addr_nomatch_in   := rec_si_xmlin[1].addr_nomatch;
    addr_missing_in   := rec_si_xmlin[1].addr_missing;
    city_match_in     := rec_si_xmlin[1].city_match;
    city_nomatch_in   := rec_si_xmlin[1].city_nomatch;
    city_missing_in   := rec_si_xmlin[1].city_missing;
    st_match_in       := rec_si_xmlin[1].st_match;
    st_nomatch_in     := rec_si_xmlin[1].st_nomatch;
    st_missing_in     := rec_si_xmlin[1].st_missing;
    zip_match_in      := rec_si_xmlin[1].zip_match;
    zip_nomatch_in    := rec_si_xmlin[1].zip_nomatch;
    zip_missing_in    := rec_si_xmlin[1].zip_missing;
    ssn_match_in      := rec_si_xmlin[1].ssn_match;
    ssn_nomatch_in    := rec_si_xmlin[1].ssn_nomatch;
    ssn_missing_in    := rec_si_xmlin[1].ssn_missing;
    dob_match_in      := rec_si_xmlin[1].dob_match;
    dob_nomatch_in    := rec_si_xmlin[1].dob_nomatch;
    dob_missing_in    := rec_si_xmlin[1].dob_missing;
    phn_match_in      := rec_si_xmlin[1].phn_match;
    phn_nomatch_in    := rec_si_xmlin[1].phn_nomatch;
    phn_missing_in    := rec_si_xmlin[1].phn_missing;

    // Set local attributes to be used in the score calculation (in the main transform)
		// either from the passed-in values or from default values (if no scoring info passed in).
    string5  scoring_version := if(ScoringInput,version_in,'');
		integer1 starting_score  := if(ScoringInput,
		                               starting_score_in,
                                   if(CustomerIsMaif,RateEvasion_Services.Constants.MAIF_START_SCORE,
																	                   RateEvasion_Services.Constants.DEF_START_SCORE));
    integer1 fn_match        := if(ScoringInput,
		                               fn_match_in,
                                   if(CustomerIsMaif,RateEvasion_Services.Constants.MAIF_FN_MATCH,
                                                     RateEvasion_Services.Constants.DEF_FN_MATCH));
    integer1 fn_nomatch      := if(ScoringInput,
		                               fn_nomatch_in,
                                   if(CustomerIsMaif,RateEvasion_Services.Constants.MAIF_FN_NOMATCH,
                                                     RateEvasion_Services.Constants.DEF_FN_NOMATCH));
    integer1 fn_missing      := if(ScoringInput,
		                               fn_missing_in,
                                   if(CustomerIsMaif,RateEvasion_Services.Constants.MAIF_FN_MISSING,
                                                     RateEvasion_Services.Constants.DEF_FN_MISSING));
    integer1 ln_match        := if(ScoringInput,
		                               ln_match_in,
                                   if(CustomerIsMaif,RateEvasion_Services.Constants.MAIF_LN_MATCH,
                                                     RateEvasion_Services.Constants.DEF_LN_MATCH));
    integer1 ln_nomatch      := if(ScoringInput,
		                               ln_nomatch_in,
                                   if(CustomerIsMaif,RateEvasion_Services.Constants.MAIF_LN_NOMATCH,
                                                     RateEvasion_Services.Constants.DEF_LN_NOMATCH));
    integer1 ln_missing      := if(ScoringInput,
		                               ln_missing_in,
                                   if(CustomerIsMaif,RateEvasion_Services.Constants.MAIF_LN_MISSING,
                                                     RateEvasion_Services.Constants.DEF_LN_MISSING));
    integer1 addr_match      := if(ScoringInput,
		                               addr_match_in,
                                   if(CustomerIsMaif,RateEvasion_Services.Constants.MAIF_ADDR_MATCH,
                                                     RateEvasion_Services.Constants.DEF_ADDR_MATCH));
    integer1 addr_nomatch    := if(ScoringInput,
		                               addr_nomatch_in,
                                   if(CustomerIsMaif,RateEvasion_Services.Constants.MAIF_ADDR_NOMATCH,
                                                     RateEvasion_Services.Constants.DEF_ADDR_NOMATCH));
    integer1 addr_missing    := if(ScoringInput,
		                               addr_missing_in,
                                   if(CustomerIsMaif,RateEvasion_Services.Constants.MAIF_ADDR_MISSING,
                                                     RateEvasion_Services.Constants.DEF_ADDR_MISSING));
    integer1 city_match      := if(ScoringInput,
		                               city_match_in,
                                   if(CustomerIsMaif,RateEvasion_Services.Constants.MAIF_CITY_MATCH,
                                                     RateEvasion_Services.Constants.DEF_CITY_MATCH));
    integer1 city_nomatch    := if(ScoringInput,
		                               city_nomatch_in,
                                   if(CustomerIsMaif,RateEvasion_Services.Constants.MAIF_CITY_NOMATCH,
                                                     RateEvasion_Services.Constants.DEF_CITY_NOMATCH));
    integer1 city_missing    := if(ScoringInput,
		                               city_missing_in,
                                   if(CustomerIsMaif,RateEvasion_Services.Constants.MAIF_CITY_MISSING,
                                                     RateEvasion_Services.Constants.DEF_CITY_MISSING));
    integer1 st_match        := if(ScoringInput,
		                               st_match_in,
                                   if(CustomerIsMaif,RateEvasion_Services.Constants.MAIF_ST_MATCH,
                                                     RateEvasion_Services.Constants.DEF_ST_MATCH));
    integer1 st_nomatch      := if(ScoringInput,
		                               st_nomatch_in,
                                   if(CustomerIsMaif,RateEvasion_Services.Constants.MAIF_ST_NOMATCH,
                                                     RateEvasion_Services.Constants.DEF_ST_NOMATCH));
    integer1 st_missing      := if(ScoringInput,
		                               st_missing_in,
                                   if(CustomerIsMaif,RateEvasion_Services.Constants.MAIF_ST_MISSING,
                                                     RateEvasion_Services.Constants.DEF_ST_MISSING));
    integer1 zip_match       := if(ScoringInput,
		                               zip_match_in,
                                   if(CustomerIsMaif,RateEvasion_Services.Constants.MAIF_ZIP_MATCH,
                                                     RateEvasion_Services.Constants.DEF_ZIP_MATCH));
    integer1 zip_nomatch     := if(ScoringInput,
		                               zip_nomatch_in,
                                   if(CustomerIsMaif,RateEvasion_Services.Constants.MAIF_ZIP_NOMATCH,
                                                     RateEvasion_Services.Constants.DEF_ZIP_NOMATCH));
    integer1 zip_missing     := if(ScoringInput,
		                               zip_missing_in,
                                   if(CustomerIsMaif,RateEvasion_Services.Constants.MAIF_ZIP_MISSING,
                                                     RateEvasion_Services.Constants.DEF_ZIP_MISSING));
    integer1 ssn_match       := if(ScoringInput,
		                               ssn_match_in,
                                   if(CustomerIsMaif,RateEvasion_Services.Constants.MAIF_SSN_MATCH,
                                                     RateEvasion_Services.Constants.DEF_SSN_MATCH));
    integer1 ssn_nomatch     := if(ScoringInput,
		                               ssn_nomatch_in,
                                   if(CustomerIsMaif,RateEvasion_Services.Constants.MAIF_SSN_NOMATCH,
                                                     RateEvasion_Services.Constants.DEF_SSN_NOMATCH));
    integer1 ssn_missing     := if(ScoringInput,
		                               ssn_missing_in,
                                   if(CustomerIsMaif,RateEvasion_Services.Constants.MAIF_SSN_MISSING,
                                                     RateEvasion_Services.Constants.DEF_SSN_MISSING));
    integer1 dob_match       := if(ScoringInput,
		                               dob_match_in,
                                   if(CustomerIsMaif,RateEvasion_Services.Constants.MAIF_DOB_MATCH,
                                                     RateEvasion_Services.Constants.DEF_DOB_MATCH));
    integer1 dob_nomatch     := if(ScoringInput,
		                               dob_nomatch_in,
                                   if(CustomerIsMaif,RateEvasion_Services.Constants.MAIF_DOB_NOMATCH,
                                                     RateEvasion_Services.Constants.DEF_DOB_NOMATCH));
    integer1 dob_missing     := if(ScoringInput,
		                               dob_missing_in,
                                   if(CustomerIsMaif,RateEvasion_Services.Constants.MAIF_DOB_MISSING,
                                                     RateEvasion_Services.Constants.DEF_DOB_MISSING));
    integer1 phn_match       := if(ScoringInput,
		                               phn_match_in,
                                   if(CustomerIsMaif,RateEvasion_Services.Constants.MAIF_PHN_MATCH,
                                                     RateEvasion_Services.Constants.DEF_PHN_MATCH));
    integer1 phn_nomatch     := if(ScoringInput,
		                               phn_nomatch_in,
                                   if(CustomerIsMaif,RateEvasion_Services.Constants.MAIF_PHN_NOMATCH,
                                                     RateEvasion_Services.Constants.DEF_PHN_NOMATCH));
    integer1 phn_missing     := if(ScoringInput,
		                               phn_missing_in,
                                   if(CustomerIsMaif,RateEvasion_Services.Constants.MAIF_PHN_MISSING,
                                                     RateEvasion_Services.Constants.DEF_PHN_MISSING));

    // ***End of handling the scoring information/values.


    // -------------------------------------------------------------------------------------
		// Pre-processing of data

		// First sort/roll all the input records together to consolidate all info for
		// similar addresses.

    // Sort first in order that the parts will be rolled on.
    in_recs_addr_sorted := sort(in_recs,st,zip,prim_name,prim_range,
		                                    suffix,predir,postdir,sec_range);

		hr_layout := doxie.layout_presentation;

		hr_layout rollAddrs(hr_layout le, hr_layout ri) := transform
		  // Keep the lowest penalty for an address
			self.penalt := if(le.penalt < ri.penalt,le.penalt,ri.penalt);
			// Keep the lowest non-zero date first seen for an address
		  self.dt_first_seen   := MAP(ri.dt_first_seen = 0   => le.dt_first_seen,
            			                le.dt_first_seen = 0   => ri.dt_first_seen,
                                  if(le.dt_first_seen < ri.dt_first_seen,
					                           le.dt_first_seen, ri.dt_first_seen));
			// Keep the highest non-zero date last seen for an address
      self.dt_last_seen := if(le.dt_last_seen > ri.dt_last_seen,
														 le.dt_last_seen,ri.dt_last_seen);
      // For fields below, take left if it is not blank/null, otherwise take right;
			// unless otherwise noted.

			// Since will get phone, ssn, dob, name parts from best, not needed here ???
			self.phone := if (le.phone <>'',le.phone,ri.phone);
			self.ssn   := if (le.ssn <>'',le.ssn,ri.ssn);
			// Keep the highest dob for an address (i.e. 19700624 instead of 1970000
			self.dob   := if(ri.dob = 0 or
			                 (le.dob > 0 and le.dob > ri.dob), // to account for mmdd=0000
											le.dob,ri.dob);
			self.title := if (le.title <>'',le.title,ri.title);
			self.fname := if (le.fname <>'',le.fname,ri.fname);
			// any mname with more than just an initial is preferred
			self.mname := if (le.mname ='',ri.mname,   //if left blank, take right
			                               if(ri.mname='',le.mname, //if right blank, take left
																		                //else if both not blank, take left if length > 1
																		                if(length(trim(StringLib.StringToUpperCase(le.mname),left,right))>1,le.mname,ri.mname)));
			self.lname        := if (le.lname <>'',le.lname,ri.lname);
			self.name_suffix  := if (le.name_suffix <>'',le.name_suffix,ri.name_suffix);
			// address parts
			self.predir       := if (le.predir <> '', le.predir, ri.predir);
			self.prim_range   := if (le.prim_range <> '', le.prim_range, ri.prim_range);
			self.prim_name    := if (le.prim_name <> '', le.prim_name, ri.prim_name);
			self.suffix       := if (le.suffix <> '', le.suffix, ri.suffix);
			self.postdir      := if (le.postdir <> '', le.postdir, ri.postdir);
			self.unit_desig   := if (length(le.unit_desig) > length(ri.unit_desig),
			                        le.unit_desig, ri.unit_desig);
			self.sec_range    := if (le.sec_range <> '', le.sec_range, ri.sec_range);
			self.city_name    := if (le.city_name <> '', le.city_name, ri.city_name);
			self.st           := if (le.st <> '', le.st, ri.st);
			self.zip          := if (le.zip <> '', le.zip, ri.zip);
			self.zip4         := if (le.zip4 <> '', le.zip4, ri.zip4);
			self.county       := if (le.county <> '', le.county, ri.county);
			self.hhid         := if(le.hhid<>0,le.hhid,ri.hhid);
			self.county_name  := if (le.county_name <> '', le.county_name, ri.county_name);
      self.listed_name  := if (le.listed_name <>'',le.listed_name,ri.listed_name);
      self.listed_phone := if (le.listed_phone <>'',le.listed_phone,ri.listed_phone);
			// Keep the highest dod for an address (i.e. 19700624 instead of 1970000
			self.dod          := if(ri.dod = 0 or
			                        (le.dod > 0 and le.dod > ri.dod), // to account for mmdd=0000
														 le.dod,ri.dod);
			// any other field not listed above doesn't matter, so it gets the left value.
	    self := le;
		end;

		in_recs_addr_rolled := rollup(in_recs_addr_sorted, rollAddrs(LEFT,RIGHT),
					                      ut.nneq(LEFT.st, RIGHT.st),
			              		        ut.nneq(LEFT.zip, RIGHT.zip),
					                      // don't use city name due to inconsistent values
																// i.e. North Yarmouth vs N Yarmouth
					                      ut.nneq(LEFT.prim_name, RIGHT.prim_name),
																// do not roll together recs for same address that
																// have no prim_range with ones that do.
																(LEFT.prim_range = RIGHT.prim_range),
					                      ut.nneq(LEFT.suffix, RIGHT.suffix),
					                      ut.nneq(LEFT.predir, RIGHT.predir),
					                      ut.nneq(LEFT.postdir, RIGHT.postdir),
					                      ut.nneq(LEFT.sec_range, RIGHT.sec_range));

		// Save off the did from the first rolled record (which should be the did of the
		// person being returned) to be used in lultiple places below.
    unsigned6 main_did  := in_recs_addr_rolled[1].did;

		// Get the "best" data for the did from both Experian & non-Experian "Watchdog" files.
		// Then determine which file's data to use based upon DataRestrictionMask ECH value.
		doxie.mac_best_records(dataset([{main_did}], doxie.layout_references),
													 did, best_recs, true, ut.glb_ok(gm.GLBPurpose), , doxie.DataRestriction.fixed_DRM);

		best_rec := choosen(best_recs,1);

		// join the in_recs_addr_rolled to the best rec data to find the 1
		// in_recs_addr_rolled record that matches the address info from the
		// best file for that did.
		curr_addr := join(in_recs_addr_rolled,best_rec,
		                  (left.prim_range = right.prim_range AND
										   left.predir     = right.predir AND
										   left.prim_name  = right.prim_name AND
											 left.suffix     = right.suffix AND
										   left.postdir    = right.postdir AND
										   left.prim_name  = right.prim_name AND
											 left.zip        = right.zip
										  ),
										  transform(hr_layout,
											  // pull these 2 fields from left first due to type mismatch
												self.dod  := left.did,
												self.bdid := left.bdid,
												// Get name, addr, ssn, dob, phone & dt_last_seen from right/best rec
												self      := right,
												self.dt_last_seen := right.addr_dt_last_seen,
												// For rest of the fields, use left/in_recs_rolled_sorted data
												self := left),
										  RIGHT OUTER); // if no match keep the best/right record info

 		// Pull off certain fields from the new first (current) record to be used later on.
    string9   main_ssn  := curr_addr[1].ssn;


    // -------------------------------------------------------------------------------------
    // Store input search-by and actual results (current name/address) fields to be
		// checked for certain conditions.
		//
		// Get the "search-by" fields that were input from the appropriate attributes within
		// the common AutoStandardI.InterfaceTranslator module.
		// Save the cleaned unparsed full name from InterfaceTranslator to use for the name suffix.
		// The other name parts are used from the appropriate IT *.val attributes, where they
		// were processed to contain either the individual name parts that were entered or
		// they were parsed out of the unparsed full name if it was entered.
		//
		// Get the "current" fields from the curr_addr record created above.

		search_fullname	:= AutoStandardI.InterfaceTranslator.cleaned_name.val(in_mod);

		// First Name
		search_fname	       := AutoStandardI.InterfaceTranslator.fname_value.val(in_mod);
    string current_fname := trim(curr_addr[1].fname,left,right);

		// Middle Name/Initial
		search_mname	           := AutoStandardI.InterfaceTranslator.mname_value.val(in_mod);
    string1 search_minitial  := search_mname[1..1];
		string  current_mname    := trim(curr_addr[1].mname,left,right);
		string1 current_minitial := current_mname[1..1];

		// Last Name
		search_lname	:= AutoStandardI.InterfaceTranslator.lname_value.val(in_mod);
		string current_lname := trim(curr_addr[1].lname,left,right);

		// Name Suffix
		search_name_suffix := if(search_fullname[66..70]<>'',
		                         search_fullname[66..70],
														 AutoStandardI.InterfaceTranslator.name_suffix_val.val(in_mod));
		string current_name_suffix := trim(curr_addr[1].name_suffix,left,right);

		boolean in_nicknames_on := in_mod.allownicknames;
		boolean in_phonetics_on := in_mod.phoneticmatch;

    // Check for input last_name equal to the results current last_name, accounting for
		// when phonetics were requested and the phonetic equivalent of the last names are equal.
		boolean last_names_same	:= if (in_phonetics_on and
		 		                           metaphonelib.DMetaPhone1(search_lname)[1..6] =
				                           metaphonelib.DMetaPhone1(current_lname)[1..6],
																	 true,
										               if(search_lname = current_lname or ut.fn_match_on_hyphenated_name(search_lname,current_lname),true,false));

    // Check for input first_name equal to the results current first_name, accounting for
		// when nicknames were requested and the preferred first equivalent of the first
		// names are equal.
		boolean first_names_same	:= if (in_nicknames_on and
																     NID.mod_PFirstTools.PFLeqPFR(search_fname,current_fname),
																		 true,
																		 if(search_fname = current_fname,true,false));

		// The address parts are used from the appropriate IT *.val attributes, where they
		// were processed to contain either the individual address fields that were entered or
		// they were parsed out of the full "addr" field if it was entered.

    // Street Number
		search_prim_range	        := AutoStandardI.InterfaceTranslator.prange_value.val(in_mod);
		string current_prim_range := trim(curr_addr[1].prim_range,left,right);

 		// Street Name
		search_prim_name	       := AutoStandardI.InterfaceTranslator.pname_value.val(in_mod);
  	string current_prim_name := trim(curr_addr[1].prim_name,left,right);
		// In case prim_range in the current record address has a ordinal (st, th, etc.),
		// strip it out for comparison later on.
		string current_prim_name_stripped := ut.StripOrdinal(current_prim_name);

 		// Sec Range (apt/unit#)
  	string current_sec_range := trim(curr_addr[1].sec_range,left,right);

		// City
		search_city	        := AutoStandardI.InterfaceTranslator.city_value.val(in_mod);
		string current_city := trim(curr_addr[1].city_name,left,right);

		// State
		search_state	       := AutoStandardI.InterfaceTranslator.state_value.val(in_mod);
		string current_state := trim(curr_addr[1].st,left,right);

    // Zip
		search_zip         := AutoStandardI.InterfaceTranslator.zip_value_cleaned.val(in_mod);
		string current_zip := trim(curr_addr[1].zip,left,right);


    // SSN
		search_ssn := AutoStandardI.InterfaceTranslator.ssn_value.val(in_mod);
		boolean search_ssn_length_ok  := if(length(search_ssn) = 9,true, false);
		boolean search_ssn_is_numeric := if(ut.isNumeric(search_ssn),true, false);
		string  current_ssn := curr_addr[1].ssn;

		// Date of Birth
		search_dob := AutoStandardI.InterfaceTranslator.dob_val.val(in_mod);
		// assign dob to string8 to pick off yyyy, mm & dd parts
		string8 search_dob_string  := (string) search_dob;
		// remove leading/trailing spaces
		string search_dob_stringv  := trim(search_dob_string,left,right);
		boolean search_dob_length_ok := if(length(search_dob_stringv) = 8,true, false);
		// Pick off year.  If length less than 4, then year not even entered.
		string4 search_dob_yyyy    := if(length(search_dob_stringv) >3,
		                                 search_dob_string[1..4],'0000');
		// Pick off month.  If length less than 6, then month not entered.
		string4 search_dob_mm      := if(length(search_dob_stringv) >5,
		                                 search_dob_string[5..6],'00');
		// Pick off day.  If length less than 8, then day not entered.
		string4 search_dob_dd      := if(length(search_dob_stringv) >7,
		                                 search_dob_string[7..8],' ');
    // Put yyyy & mm together into integer3 for checking later against SSN issued date
    integer3 search_dob_yyyymm := ((integer3) search_dob_yyyy) * 100 +
		                               (integer3) search_dob_mm;
		integer4 current_dob       := curr_addr[1].dob;


    // Phone Number
		search_phone := AutoStandardI.InterfaceTranslator.phone_value.val(in_mod);
		boolean  search_phone_length_ok  := if(length(search_phone) = 10,true, false);
		boolean  search_phone_is_numeric := if(ut.isNumeric(search_phone),true, false);
		string3  search_phone3 := if(search_phone_length_ok,search_phone[1..3],'');
		string7  search_phone7 := if(search_phone_length_ok,search_phone[4..10],'');
		string   current_phone := curr_addr[1].phone;


    // Set booleans based upon what was input to assist in checking later on.
		boolean fname_was_input      := if(search_fname <> '',true, false);
		boolean mname_was_input      := if(search_mname <> '',true, false);
		boolean lname_was_input      := if(search_lname <> '',true, false);
		boolean namesuffix_was_input := if(search_name_suffix <> '',true, false);
		boolean prim_range_was_input := if(search_prim_range <> '',true, false);
		boolean prim_name_was_input  := if(search_prim_name <> '',true, false);
		boolean city_was_input       := if(search_city <> '',true, false);
		boolean state_was_input      := if(search_state <> '',true, false);
		boolean zip_was_input        := if(search_zip <> '',true, false);
		boolean ssn_was_input        := if(search_ssn <>'',true, false);
    boolean dob_was_input        := if(search_dob   <> 0,true, false);
    boolean phone_was_input      := if(search_phone <> '',true, false);


    // ----------------------------------------------------------------------------------
		// NOTE: Passed-in in_recs contain multiple record(s) for each did to be returned.
		// Separate the records into current and previous addresses.

    // *** Use LEFT ONLY JOIN to determine which address recs rolled_sorted ARE NOT the
		// current one. (To be used for the Previous Addresses section in the results).
		prev_addrs := join(in_recs_addr_rolled,curr_addr,
		                 (left.prim_range = right.prim_range AND
										  left.predir     = right.predir AND
										  left.prim_name  = right.prim_name AND
											left.suffix     = right.suffix AND
										  left.postdir    = right.postdir AND
										  left.prim_name  = right.prim_name AND
											left.zip        = right.zip
										 ),
										 transform(hr_layout,
												self := left),
										 LEFT ONLY, // only keep ones that don't match the right rec set
										 ALL);

		// Sort previous addresses in order by date last seen (descending).
    prev_addrs_sorted := sort(prev_addrs,-dt_last_seen);


    // ----------------------------------------------------------------------------------
    // Reverse Phone Lookup (RPL) processing.

    // *** Get the current gong history phone info for the input phone# (if there was one)
    // from the thor_data400::key::gong_history_phone_qa file.
    // It will be used for warning checking later and to output RPL info later.
    input_phone_info_rec_raw := dx_Gong.key_history_phone()(
      keyed(search_phone7 = p7 and search_phone3 = p3) and current_flag);

    input_phone_info_rec_optout := Suppress.MAC_SuppressSource(input_phone_info_rec_raw, mod_access);

    input_phone_info_rec := if(IncludeRPL and phone_was_input and search_phone_length_ok,
      input_phone_info_rec_optout);

    // ----------------------------------------------------------------------------------
		// SSN related processing.

    // *** Get basic ssn info (about the first 5 of the ssn) for the INPUT ssn
		// (if there was one) from	the thor_data400::key::ssnissue2::qa::ssn5 file.
		// It will be used for warning checking later.
		input_ssn5_info_rec := if(ssn_was_input,
		                          doxie.Key_SSN_Map(keyed(search_ssn[1..5] = ssn5)),
														 dataset([],recordof(doxie.Key_SSN_Map)));


    // *** Get detailed ssn info for the INPUT ssn (if there was one) from the
		// thor_data400::key::ssn_table_v2_qa file.
		// It will be used for warning checking later.
		input_ssn_info_rec := if(ssn_was_input,
		                         project(Risk_Indicators.Key_SSN_Table_v4_2 (keyed(search_ssn = ssn)), transform(ssn_table_rec,
															self := map(~doxie.DataRestriction.ECH and ~doxie.DataRestriction.EQ and ~doxie.DataRestriction.TCH => left.combo,
																					~doxie.DataRestriction.EQ => left.eq,
																					~doxie.DataRestriction.ECH => left.en,
																					left.tn);
															self := left)),
														 dataset([],recordof(ssn_table_rec)));


		// ***Get all the unique SSNs from all the input header records and put them in
		// a final order with the ssn that matches the one from the "best" file first.
		in_recs_ssns_deduped := sort(dedup(sort(in_recs,ssn),ssn),-(ssn=current_ssn));

		// Filter out any zero or blank SSNs
		in_recs_ssns_filtered := in_recs_ssns_deduped(ssn<>'');

	  // Count the ssns associated with the main_did for outputting a warning code later.
		in_recs_ssns_count := count(in_recs_ssns_filtered);

    // ***Get the ssn info for all the ssns from the ssn_table.
		// They will be used to output "SSNs" info later.
    ssn_info_recs_unmasked := join (in_recs_ssns_filtered,Risk_Indicators.Key_SSN_Table_v4_2,
		                                   keyed(left.ssn = right.ssn),
																		   transform(recordof(Risk_Indicators.Key_SSN_Table_v4_2),
														                     self := right),
													             LIMIT(1,skip));

    // Mask the SSNs according to any SSNMask value entered.
	  string6 ssn_mask_value := AutoStandardI.InterfaceTranslator.ssn_mask_val.val(project(in_mod,
                              AutoStandardI.InterfaceTranslator.ssn_mask_val.params));
		suppress.MAC_Mask(ssn_info_recs_unmasked, ssn_info_recs, ssn, blank, true, false);

		// *** Get all dids for all the SSNs associated with the main_did from the
		// thor_data400::key::header.ssn.did_qa file.
		ssn_did_rl := record
      unsigned6 did;
    end;

		key_header_ssn := dx_Header.key_SSN();
		ssn_did_rl hdr_ssn_did_xform(key_header_ssn le) := transform
      self :=le;
    end;

		dids_for_all_ssns := join(in_recs_ssns_filtered,key_header_ssn,
		                          keyed(left.ssn[1] = right.s1 and
    							                  left.ssn[2] = right.s2 and
    							                  left.ssn[3] = right.s3 and
    							                  left.ssn[4] = right.s4 and
    							                  left.ssn[5] = right.s5 and
    							                  left.ssn[6] = right.s6 and
    							                  left.ssn[7] = right.s7 and
    							                  left.ssn[8] = right.s8 and
    							                  left.ssn[9] = right.s9),
											        transform(ssn_did_rl,
															     self := right),
															LIMIT(RateEvasion_Services.Constants.MAX_RECS_ON_JOIN,skip));

		// Remove the did for the current name being returned.
		dids_for_all_ssns_minus_main := dids_for_all_ssns(did<>main_did);

    // Dedup the dids
		dids_for_all_ssns_deduped := dedup(sort(dids_for_all_ssns_minus_main,did),did);

    // Count the unique dids (except main one) for the ssn to know which
		// warning code to output later.
		dids_for_all_ssns_count := count(dids_for_all_ssns_deduped);

		// Now get the "best" current name, address & phone info for the dids above
		doxie.mac_best_records(dids_for_all_ssns_deduped, did, others_with_same_ssn_best_recs, true, ut.glb_ok(gm.GLBPurpose), , doxie.DataRestriction.fixed_DRM);
		others_with_same_ssn_best_info := project(others_with_same_ssn_best_recs, watchdog.Layout_Best);

    // Sort resulting records in order by lname, fname, mname, etc.
		// They will be used to output "OthersWithSameSSN" info later.
		others_with_same_ssn_recs := sort(others_with_same_ssn_best_info,lname,fname,mname,name_suffix);


    // ------------------------------------------------------------------------------------
		// Get all the people who's "best" address is the same as the main_did's current
		// address.  Then see if those people have DL info or not.  This info is used later
		// if we need to output additional drivers and/or potential additional drivers.

		// *** First use the appropriate current address parts to get all the key header
		// address records for the current address from the
		// thor_data400::key::header_address_qa file.
		key_hdr_addr_recs_all := dx_header.Key_Header_Address()(
		                                      keyed(current_prim_name = prim_name and
		                                            current_zip = zip and
		                                            current_prim_range = prim_range and
		                                            current_sec_range = sec_range));

		// *** Sort by did and then dedup by did since key file above can contain multiple
		// records for each did.
		key_hdr_addr_recs_deduped := dedup(sort(key_hdr_addr_recs_all,did),did);

		key_hdr_addr_recs := suppress.MAC_SuppressSource(key_hdr_addr_recs_deduped,mod_access);
		// *** Next join the dids from the records above to "Watchdog" files to
		// determine which dids currently still reside at that address.
		doxie.mac_best_records(key_hdr_addr_recs, did, curr_addr_best_recs, true, ut.glb_ok(gm.GLBPurpose), , doxie.DataRestriction.fixed_DRM);

		all_curr_addr_best_recs :=
			join(key_hdr_addr_recs, curr_addr_best_recs,
				left.did = right.did and
				left.prim_name  = right.prim_name and
				left.zip        = right.zip and
				left.prim_range = right.prim_range and
				left.sec_range  = right.sec_range,
				transform(watchdog.Layout_Best, self := right),
				LIMIT(1,skip));  // should only be 1 did rec on the best file


    // *** Remove any matched best recs with addr_dt_last_seen greater than 2 years old
		// since watchdog_best appears to contain a record for some dids that for some reason
		// haven't been updated recently (no activity for the person or they are dead, but no dod,
		// or they have a new did assigned, etc.)
		// NOTE: The 2 year limit was just an arbitrary limit that was picked based upon
		// all the records observed for 6 different test cases as of 08/11/2009.
		// It may need adjusted in the future based upon new test cases/bugs.
		curr_addr_best_recs_filtered := all_curr_addr_best_recs(
		                ut.DaysApart(addr_dt_last_seen+'00', ut.GetDate) < ut.DaysInNYears(2));

    // ***Remove the did for the current name being returned.
		curr_addr_best_recs_minus_main := curr_addr_best_recs_filtered(did<>main_did);


		// *** Try to get a driver license record for all the current address dids by
		// joining via did to the DL info did key file, thor_data400::key::dl2::qa::dl_did_public file.

		// *** After the join, sort the records by did, then by lic-issue-date (descending)
		// order to put the most recent record for a did first.
		// Then dedup by did to only keep the most recent record for each did.
		// Then put final results in order by dob.

    dl_info_rl := recordof(DriversV2.Key_DL_DID);

		dl_recs_by_did :=  sort(dedup(sort(join(curr_addr_best_recs_filtered,DriversV2.Key_DL_DID,
		                                     keyed(left.did = right.did) and
																				 (in_mod.include_non_regulated_sources or right.source_code != MDR.sourceTools.src_Certegy),
                 								      	 transform(dl_info_rl,
															              self := right),
															           LIMIT(RateEvasion_Services.Constants.MAX_RECS_ON_JOIN,skip)),
									                  did,-lic_issue_date),
													     did),
												 dob);

		// Apply DPPA permissions
		dl_recs_unmasked := dl_recs_by_did(ut.PermissionTools.dppa.state_ok(orig_state,in_mod.DPPAPurpose,,source_code));

    //apply DL mask, if any
    dl_mask_value := AutoStandardI.InterfaceTranslator.dl_mask_value.val(in_mod);
    suppress.mac_mask (dl_recs_unmasked, dl_recs_all, null, dl_number, false, true);

		// Count all the dids at the current address that have a DL record.
		// This is to be used later in checking for a warning condition.
	  unsigned2 dl_recs_count := count(dl_recs_all);

    // Store off the dl rec for the main did and also store the dl recs for the rest of
		// household (all recs minus the main did rec).
		dl_rec_for_main    := dl_recs_all(did=main_did);
		dl_recs_minus_main := dl_recs_all(did<>main_did);


    // *** Use LEFT ONLY JOIN to determine which current address did(s) DID NOT have a
		// DL record. (To be used for the Potential Additional Drivers section).
		pad_info_unmasked := join(curr_addr_best_recs_minus_main,dl_recs_minus_main,
				                  left.did = right.did,
													transform(watchdog.Layout_Best,
    								       self := left),
                          LEFT ONLY, // only keep ones that don't match the right rec set
													ALL);
    suppress.mac_mask (pad_info_unmasked, pad_info_recs, null, dl_number, false, true);


    // ----------------------------------------------------------------------------------
		// Get all the vehicle related info for the main did; to be used later if need to
		// output vehicle info.

		// *** First get all the vehicle_keys for the main (current name) did from the
		// thor_data400::key::vehiclev2::did_qa file.

		// Use a slimmed down record to only keep needed fields.
		vehicle_key_rl := record
			string30 vehicle_key;
			string15 iteration_key;
	    string15 sequence_key;
    end;

		// Use project with keyed to get all the vehicle_keys for the main did from
		// the vehicle key did file.
		vehicles_for_did_all := project(limit(VehicleV2.Key_Vehicle_DID(keyed(main_did = append_did)),ut.limits.default,skip), // if desired the limit might be increased to 20000 which will cover all dids except 118 recs
										                vehicle_key_rl);

		// Then sort by vehicle_key and iteration_key (descending) and sequence_key (descending)
		// to get the highest (most recent) iteration_key & sequence_key records for a
		// vehicle to sort first.
		// Then dedup by vehicle_key; keeping the 1 rec with the highest
		// (most recent) iteration_key & sequence_key for each vehicle_key.
		vehicles_for_did := dedup(sort(vehicles_for_did_all,
															     Vehicle_Key,-iteration_key,-sequence_key),
															Vehicle_Key);


    // NOTE: Even though the vehicle_keys may at one time have been associated with the
		// did (current and historical), some of those vehicles may no longer be associated
		// with the did, so they are at best potential vehicles.

		// *** Once we got all the potential vehicle keys for a did,
		// do a JOIN to the thor_data400::key::vehiclev2::party_key_ qa file (matching on
		// vehicle_key, to get owner, registrant and lien holder
		// info for every potential vehicle.

		vehicle_party_key_rl := record(vehiclev2.Key_Vehicle_Party_Key)
    end;

		vehicle_party_recs_did_all_no_dppa_pre := join(vehicles_for_did,VehicleV2.Key_Vehicle_party_Key,
																							 keyed(left.vehicle_key=right.vehicle_key) and
																							 (in_mod.include_non_regulated_sources or right.source_code not in [MDR.sourceTools.src_infutor_veh,MDR.sourceTools.src_infutor_motorcycle_veh]),
																							 transform(vehicle_party_key_rl,
																												 self := right),
																							 limit(RateEvasion_Services.Constants.MAX_RECS_ON_JOIN,skip));
   vehicle_party_recs_did_all_no_dppa := suppress.MAC_SuppressSource(vehicle_party_recs_did_all_no_dppa_pre,mod_access,append_did);
		// Apply DPPA permissions
		vehicle_party_recs_for_did_all := vehicle_party_recs_did_all_no_dppa(ut.PermissionTools.dppa.state_ok(state_origin,in_mod.DPPAPurpose,,source_code));

	  // *** Do a join to filter all vehicle_party_recs for a did down to just the ones
		// associated with the latest iteration key & sequence_key for a vehicle_key.
    vehicle_party_recs_for_did_all2 := join(vehicle_party_recs_for_did_all, vehicles_for_did,
	                                          (left.vehicle_key=right.vehicle_key AND
																		         left.iteration_key=right.iteration_key AND
																						 left.sequence_key=right.sequence_key),
																		        transform(vehicle_party_key_rl,
								                                      self := left),
  											                    limit(RateEvasion_Services.Constants.MAX_RECS_ON_JOIN,skip));

		// Filter all of the potential vehicle party recs to only include those vehicle_keys
		// that have at least 1 party record for the main_did (i.e. the vehicle is still
		// somehow associated to that did) AND it's not a history record.
		vehicle_party_recs_for_did_all3 := vehicle_party_recs_for_did_all2(
		                                                    append_did = main_did AND
																												history <> Constants.History AND
																												history <> Constants.Expired);

		// Sort and dedup the resulting party recs to keep only 1 rec for each vehicle key.
		deduped_party_recs := dedup(sort(vehicle_party_recs_for_did_all3,
		                                 Vehicle_Key),
		                            Vehicle_key);

	  // *** Do a join to filter all vehicle_keys for a did down to just the ones
		// still associated with the main did.
    active_vehicles_for_did_all := join(vehicles_for_did_all, deduped_party_recs,
	                                   (left.vehicle_key=right.vehicle_key),
																		 transform(vehicle_key_rl,
								                               self := left),
  											             limit(RateEvasion_Services.Constants.MAX_RECS_ON_JOIN,skip));

    // Sort/dedup to keep just 1 rec for each vehicle key
		active_vehicles_for_did := dedup(sort(active_vehicles_for_did_all,
														              Vehicle_Key,-iteration_key),
													           Vehicle_Key);

    // Count the active vehicle keys for a did to be used later in checking for a
		// warning condition.
	  unsigned2 active_vehicles_count := count(active_vehicles_for_did);


    // Use a join to filter all party recs again to keep all the party recs only for
		// the active vehicles that aren't historical recs.
		vehicle_party_recs_for_did := join(vehicle_party_recs_for_did_all,
		                                   active_vehicles_for_did_all,
	                                      (left.vehicle_key=right.vehicle_key AND
																				 left.iteration_key = right.iteration_key AND
																				 left.sequence_key=right.sequence_key AND
																					left.history <> Constants.History AND
																					left.history <> Constants.Expired),
		     											          limit(RateEvasion_Services.Constants.MAX_RECS_ON_JOIN,skip));


    // *** Rollup party key records fields when vehicle_key, name_type & did are the same.

		// Sort first in vehicle_key, orig-name-type and did order
		vehicle_party_recs_sorted := sort(vehicle_party_recs_for_did,
		                                  vehicle_key,orig_name_type,append_did);

		vehicle_party_key_rl rollPartyRecs(vehicle_party_key_rl le,
		                                   vehicle_party_key_rl ri) := transform
			// Registration data
			// Keep the lowest (earliest) non-zero reg_earliest_effective_date
			self.reg_earliest_effective_date := if(ri.reg_earliest_effective_date = '' or
			                                       (le.reg_earliest_effective_date <>'' and
			                                       le.reg_earliest_effective_date < ri.reg_earliest_effective_date),
															               le.reg_earliest_effective_date,
																						 ri.reg_earliest_effective_date);
      // Keep the highest (latest) non-zero reg_latest_effective_date
      self.reg_latest_effective_date := if(le.reg_latest_effective_date > ri.reg_latest_effective_date,
													               	 le.reg_latest_effective_date,
																					 ri.reg_latest_effective_date);
			// Keep the highest (latest) non-zero reg_latest_expiration_date
      self.reg_latest_expiration_date := if(le.reg_latest_expiration_date > ri.reg_latest_expiration_date,
													               	 le.reg_latest_expiration_date,
																					 ri.reg_latest_expiration_date);
			// Plate data
			self.reg_license_plate := if (le.reg_license_plate <>'',
                                    le.reg_license_plate,
			                              ri.reg_license_plate),
			self.reg_license_state := if (le.reg_license_state <>'',
			                              le.reg_license_state,
			                              ri.reg_license_state),
	    self.reg_previous_license_plate := if (le.reg_previous_license_plate <>'',
			                                       le.reg_previous_license_plate,
			                                       ri.reg_previous_license_plate),
	    self.reg_previous_license_state := if (le.reg_previous_license_state <>'',
			                                       le.reg_previous_license_state,
			                                       ri.reg_previous_license_state),
			// Title data
			self.ttl_number := if(le.ttl_number<>'',
			                      le.ttl_number,
														ri.ttl_number),
		  // Keep the lowest (earliest) non-zero ttl_earliest_issue_date
			self.ttl_earliest_issue_date := if(ri.ttl_earliest_issue_date = '' or
			                                   (le.ttl_earliest_issue_date <>'' and
			                                    le.ttl_earliest_issue_date < ri.ttl_earliest_issue_date),
															           le.ttl_earliest_issue_date,
																				 ri.ttl_earliest_issue_date);

	 		// any other field not listed above doesn't matter, so it gets the left value.
	    self := le;
		end;

		vehicle_party_recs_rolled := rollup(vehicle_party_recs_sorted, rollpartyRecs(LEFT,RIGHT),
			              		                ut.nneq(LEFT.vehicle_key, RIGHT.vehicle_key),
					                              ut.nneq(LEFT.orig_name_type, RIGHT.orig_name_type),
					                              ut.nneq((string) LEFT.append_did, (string) RIGHT.append_did));


    // ----------------------------------------------------------------------------------
    // Get vehicle information for any input VIN(s)

		// *** First get all the vehicle_keys for the input VIN(s) from the
		// thor_data400::key::vehiclev2::vin_qa file.

		// Use the slimmed down vehicle_key_rl record (from above) to only keep needed fields.
		vehicle_key_rl vin_vehicle_key_xform(VehicleV2.Key_Vehicle_VIN le) := transform
		  // set sequence_key to null since this field doesn't exist on the key vehicle vin_qa file
		  self.sequence_key := '',
			self := le
    end;

		// Use project with keyed to get all the vehicle_keys for the input vins from
		// the vehicle key vin file.
		vin_vehicle_key_recs_all := project(VehicleV2.Key_Vehicle_VIN(keyed(vin in in_mod.input_vins)),
											                         vin_vehicle_key_xform(left));

		// *** Once we got the vehicle key for a vin, do a JOIN to the
		// thor_data400::key::vehiclev2::party_key_ qa file (matching on vehicle_key)
		// to get owner, registrant and lienholder info.
		// Note we get vehicle data from 2 sources (AE & DI), so current party records may
		// exist for both sources.  These will be rolled together later.

		// For the transform, use the vehicle_party_key_rl that was already defined above.
		vin_vehicle_party_recs_no_dppa_pre := join(vin_vehicle_key_recs_all,VehicleV2.Key_Vehicle_party_Key,
																					 keyed(left.vehicle_key=right.vehicle_key AND
																									left.iteration_key=right.iteration_key) and
																					 (in_mod.include_non_regulated_sources or right.source_code not in [MDR.sourceTools.src_infutor_veh,MDR.sourceTools.src_infutor_motorcycle_veh]),
																					 transform(vehicle_party_key_rl,
																										 self := right),
																					 limit(RateEvasion_Services.Constants.MAX_RECS_ON_JOIN,skip));
   vin_vehicle_party_recs_no_dppa := suppress.MAC_SuppressSource(vin_vehicle_party_recs_no_dppa_pre,mod_access,append_did);
		// Apply DPPA permissions
		vin_vehicle_party_recs_dppa := vin_vehicle_party_recs_no_dppa(ut.PermissionTools.dppa.state_ok(state_origin,in_mod.DPPAPurpose,,source_code));


		// only use party key records that are not "H"istorical and not "E"xpired),
		vin_vehicle_party_recs := vin_vehicle_party_recs_dppa(history <> Constants.History AND
																													history <> Constants.Expired);

    // *** Rollup vin party key records fields when vehicle_key, name_type (owner,
		// registrant, etc.) & did are the same.

		// Sort first in vehicle_key, orig-name-type and did order
		vin_vehicle_party_recs_sorted := sort(vin_vehicle_party_recs,
		                                      vehicle_key,orig_name_type,append_did);

		// This rollup uses the rollpartyRecs transform from above
		vin_vehicle_party_recs_rolled := rollup(vin_vehicle_party_recs_sorted, rollpartyRecs(LEFT,RIGHT),
			              		                ut.nneq(LEFT.vehicle_key, RIGHT.vehicle_key),
					                              ut.nneq(LEFT.orig_name_type, RIGHT.orig_name_type),
					                              ut.nneq((string) LEFT.append_did, (string) RIGHT.append_did));

		// Had to use "vin_vehicle_party_recs_dppa" instead of "vin_vehicle_key_recs_all" so as to apply DPPA permissions
		// Sort by vehicle_key and iteration_key (descending) and sequence_key (descending)
		// to get the highest (most recent) iteration_key & sequence_key record for a
		// vehicle to sort first.
		// Then dedup by vehicle_key; keeping the 1 rec with the highest (most recent)
		// iteration_key & sequence_key for each vehicle_key.
		vin_vehicle_key_recs := dedup(sort(project(vin_vehicle_party_recs_dppa,vehicle_key_rl),
															         Vehicle_Key,-iteration_key,-sequence_key),
															    Vehicle_Key);

    // *** Now combine the vehicle recs for the current name with any vehicle recs
		// associated with any input vins.
		combined_vehicle_recs := active_vehicles_for_did + vin_vehicle_key_recs;

		// Sort, then dedup on vehicle_key in case any vin(s) that was input
		// was also found looking up vins for the main did.
    deduped_vehicle_recs := dedup(sort(combined_vehicle_recs,
		                                   vehicle_key),
															    vehicle_key);

    // Combine the vehicle party recs for the current name with any vehicle party recs
		// associated with any input vins.
  	combined_vehicle_party_recs := vehicle_party_recs_rolled + vin_vehicle_party_recs_rolled;

		// Sort in order by vin, orig_name_type, then name parts.
		// Then dedup on same fields in case same vin was input as was found looking up vins
		// for the main did.
    deduped_vehicle_party_recs := dedup(sort(combined_vehicle_party_recs,
		                                         vehicle_key,
																						 orig_name_type,
																			       append_clean_name.lname,
																			       append_clean_name.fname,
																			       append_clean_name.name_suffix,
																			       append_clean_cname),  // in case of company name
																	      vehicle_key,
																				orig_name_type,
																	      append_clean_name.lname,
																	      append_clean_name.fname,
																	      append_clean_name.name_suffix,
																	      append_clean_cname); // in case of company name


    // ----------------------------------------------------------------------------------
    // Check various conditions (i.e. search_by versus returned fields)
		// to create a recordset of warning codes.

    // Assign certain fields/conditions from the ssn info recordsets (created earlier)
		// to local attributes for easier referencing below.
		boolean input_ssn5_found      := if(ssn_was_input and input_ssn5_info_rec[1].ssn5 <> '',
		                                    true, false);
		integer4 input_ssn5_startdt   := if(input_ssn5_found,
		                                    (integer4) input_ssn5_info_rec[1].start_date, // yyyymmdd
		                                    0);

		boolean input_ssn_found           := if(ssn_was_input and input_ssn_info_rec[1].ssn <> '',
		                                        true, false);
		boolean input_ssn_isvalidformat   := if(ssn_was_input and input_ssn_info_rec[1].isvalidformat,
		                                        true, false);
		boolean input_ssn_issequencevalid := if(ssn_was_input and input_ssn_info_rec[1].issequencevalid,
		                                        true, false);
		boolean input_ssn_isdeceased      := if(ssn_was_input and input_ssn_info_rec[1].isdeceased,
		                                        true, false);
		integer3 input_ssn_first_seen     := if(ssn_was_input and input_ssn_found,
		                                        input_ssn_info_rec[1].official_first_seen, // yyyymm
		                                        0);
    integer3 input_ssn_last_seen      := if(ssn_was_input and input_ssn_found,
		                                        input_ssn_info_rec[1].official_last_seen, // yyyymm
		                                        0);

		// if ssn rec is for a deceased person use the deceased name parts instead of lname1.
    string input_ssn_lname            := if(ssn_was_input and input_ssn_found,
		                                        if(input_ssn_isdeceased,
																						   trim(input_ssn_info_rec[1].decs_last,left,right),
		                                           trim(input_ssn_info_rec[1].lname1.lname,left,right)),
		                                        '');
    string input_ssn_fname            := if(ssn_was_input and input_ssn_found,
		                                        if(input_ssn_isdeceased,
																						   trim(input_ssn_info_rec[1].decs_first,left,right),
																						   trim(input_ssn_info_rec[1].lname1.fname,left,right)),
		                                        '');

    // Check for input last_name equal to the ssn info last_name, accounting for when
		// phonetics were requested and the phonetic equivalent of the last names are equal.
		boolean ssn_last_names_same	:= if (in_phonetics_on and
		 		                               metaphonelib.DMetaPhone1(search_lname)[1..6] =
				                               metaphonelib.DMetaPhone1(input_ssn_lname)[1..6],
																	     true,
										                   if(search_lname = input_ssn_lname or ut.fn_match_on_hyphenated_name(search_lname,input_ssn_lname),true,false));

    // Check for input first_name equal to the ssn info first_name, accounting for when
		// nicknames were requested and the nickname equivalent of the first names are equal.
		boolean ssn_first_names_same	:= if (in_nicknames_on and
																         NID.mod_PFirstTools.PFLeqPFR(search_fname,input_ssn_fname),
																		     true,
																		     if(search_fname = input_ssn_fname,true,false));


    // *** Check for SSN related warnings

    // Check for input ssn being for a deceased person
		string4 wcode_0002 :=  if(ssn_was_input and input_ssn_found and input_ssn_isdeceased,
		                          '0002','');

    // Check for input ssn issued prior to input date-of-birth
		string4 wcode_0003 :=  if(ssn_was_input and input_ssn_found and
		                          search_dob<> 0 and input_ssn_last_seen <= search_dob_yyyymm,
															'0003','');

    // Check for input name & ssn verified, but at a different address
	  string4 wcode_0004 := if(lname_was_input and search_lname = current_lname and
		                         fname_was_input and search_fname = current_fname and
                             ssn_was_input   and search_ssn = current_ssn and
														 (search_prim_range <> current_prim_range or
														  search_prim_name <> current_prim_name_stripped),
															'0004','');

    // Check for input ssn invalid or not yet issued (not yet issued means the first 5
		// are not on ssnissue2 key file).
		string4 wcode_0006 := if(ssn_was_input and
		                         search_ssn_length_ok and search_ssn_is_numeric and
		                         (not input_ssn_found or
		                          not input_ssn_isvalidformat or not input_ssn_issequencevalid or
														  not input_ssn5_found),
														 '0006','');

    // Check for input phone potentially invalid (which means valid length and numeric,
		// but it does not match the one from the header file for the person being searched).
		//string4 wcode_0008 := '';
		string4 wcode_0008 := if(phone_was_input and
		                         search_phone_length_ok and search_phone_is_numeric and
														 search_phone <> current_phone,
														 '0008','');


		// Check for input SSN possibly being miskeyed (has data, but contains non-numeric data).
    string4 wcode_0029 :=  if(ssn_was_input and
															search_ssn_length_ok and
		                          not search_ssn_is_numeric,
															'0029','');

    // Check for input phone may have been miskeyed (has data, but contains non-numeric data).
		string4 wcode_0031 := if(phone_was_input and
		                         search_phone_length_ok and
														 not search_phone_is_numeric,
														 '0031','');

		// Check for input SSN associated with different first & last name accounting for
		// nicknames and phonetics.
    string4 wcode_0038 :=  if(ssn_was_input and
		 		                      input_ssn_found and
		                          not ssn_last_names_same and
															not ssn_first_names_same,
		                          '0038','');

		// Check input first name not = results first name
		string4 wcode_0048 := if(not first_names_same,'0048','');

		// Check for input SSN associated with different last name, same first name accounting
		// for phonetics and nicknames.
		string4 wcode_0066 :=  if(ssn_was_input and
															not ssn_last_names_same and
															ssn_first_names_same,
		                          '0066','');

	  // Check input name may have been miskeyed (or missing some parts)
    string4 wcode_0076 := if((lname_was_input and not fname_was_input) or // last without first
		                         (fname_was_input and not lname_was_input) or // first without last
														 (not fname_was_input and not lname_was_input and mname_was_input), // middle without first and last
		                         '0076','');

	  // Check input name (first and last) missing
    string4 wcode_0077 := if(not fname_was_input and not lname_was_input,'0077','');

	  // Check input address missing (street # or name missing or city and state or zip missing)
    string4 wcode_0078 := if(not prim_name_was_input or
                             (not city_was_input and not state_was_input and not zip_was_input),
														 '0078','');

    // Check input name and address return a different phone# than input
		string4 wcode_0082 := if (fname_was_input and lname_was_input and prim_name_was_input and
															phone_was_input and
		                          search_phone_length_ok and search_phone_is_numeric and
															search_phone <> current_phone,
		                          '0082','');

		// Check input DOB may have been miskeyed.
    string4 wcode_0083 := if(dob_was_input and
		                         search_dob_length_ok and
		                         ((search_dob_yyyy < '1880' or  search_dob_yyyy > '2100') or
														  (search_dob_mm < '01' or search_dob_mm > '12') or
															(search_dob_dd < '01' or search_dob_dd > '31')),
		                         '0083','');

		// Check input SSN issued within last 3 years
		// (i.e. ssn5 issued start date > run (current) date minus 3 years)
		integer4 run_date_minus3 := ((integer4) run_yyyymmdd) - 30000;
		string4 wcode_0089 := if(ssn_was_input and
		                         input_ssn5_startdt > run_date_minus3,
														 '0089','');

		// Check input SSN issued after age 5 (post-1990).
		// (i.e. ssn5 issued start date > current dob plus 5 years for dobs after 1990)
		// Use current name dob instead of input dob in case it was not entered or
		// it was entered incorrectly.
    integer4 dob_plus5 := current_dob + 50000;
    string4 wcode_0090 := if(ssn_was_input and
		                         current_dob > 19891231 and
		                         input_ssn5_startdt > dob_plus5,
														 '0090','');

    // Check input_ssn and ssn/did count
		string4 wcode_0120 := if(ssn_was_input and dids_for_all_ssns_count > 1,'0120','');

		// *** Check for various input fields versus results fields
		// Name + Address match only
		string4 wcode_2374 := if(last_names_same and
	                           first_names_same and
														 search_prim_range = current_prim_range and
														 search_prim_name  = current_prim_name_stripped and
														 search_ssn <> current_ssn and
														 search_dob <> current_dob,
			                       '2374','');

		// Name + DOB match only
		string4 wcode_2375 := if(last_names_same and
	                           first_names_same and
 														 search_dob = current_dob and
														 search_prim_range <> current_prim_range and
														 search_prim_name  <> current_prim_name_stripped and
														 search_ssn <> current_ssn,
	                           '2375','');

		// Name + SSN match only
		string4 wcode_2376 := if(last_names_same and
	                           first_names_same and
                             search_ssn = current_ssn and
														 search_prim_range <> current_prim_range and
														 search_prim_name  <> current_prim_name_stripped and
														 search_dob <> current_dob,
			                       '2376','');

    // *** Check for DL record name different than input name.
	  string lname_from_dl_rec := trim(dl_rec_for_main[1].lname,left,right);
		string fname_from_dl_rec := trim(dl_rec_for_main[1].fname,left,right);

    // Check for input last_name equal to the dl info last_name, accounting for when
		// phonetics were requested and the phonetic equivalent of the last names are equal.
		boolean dl_last_names_same	:= if (in_phonetics_on and
		 		                               metaphonelib.DMetaPhone1(search_lname)[1..6] =
				                               metaphonelib.DMetaPhone1(lname_from_dl_rec)[1..6],
																	     true,
										                   if(search_lname = lname_from_dl_rec or ut.fn_match_on_hyphenated_name(search_lname,lname_from_dl_rec),true,false));

    // Check for input first_name equal to the dl info first_name, accounting for when
		// nicknames were requested and the nickname equivalent of the first names are equal.
		boolean dl_first_names_same	:= if (in_nicknames_on and
																       NID.mod_PFirstTools.PFLeqPFR(search_fname, fname_from_dl_rec),
																		   true,
																		   if(search_fname = fname_from_dl_rec,true,false));

		string4 wcode_2377 := if(IncludeDL and
		                         fname_from_dl_rec<>'' and
		                         lname_from_dl_rec <> '' and
		                         (not dl_last_names_same or not dl_first_names_same),'2377','');

    // Check if main_did is associated with more than 1 ssn
		string4 wcode_2378 := if(in_recs_ssns_count > 1,'2378','');

	  // Check input last name not = results last name
		string4 wcode_2390 := if(not last_names_same,'2390','');

	  // Check input name not = reverse phone lookup name
		string4 wcode_2391 := if(IncludeRPL and phone_was_input and
		                          search_phone_length_ok and search_phone_is_numeric and
															input_phone_info_rec[1].phone10 <>'' and
		                         (search_fname[1..1] <> input_phone_info_rec[1].name_first[1..1] or
														  search_lname <> trim(input_phone_info_rec[1].name_last,left,right)),
		                          '2391','');

    // check # of drivers in the household versus the # of vehicles
		string4 wcode_2392 := if(IncludeMVR and dl_recs_count <> active_vehicles_count,
			                       '2392','');


    // Record layout of warnings_code recordset
		warning_codes_rl := record
	    string4 code;
    end;

		// *** Combine individual warning code attributes into a recordset.
		warning_codes1 := dataset([{wcode_0002}, {wcode_0003}, {wcode_0004}, {wcode_0006},
															 {wcode_0008},
		                           {wcode_0029}, {wcode_0031}, {wcode_0038},
															 {wcode_0048}, {wcode_0066},
															 {wcode_0076}, {wcode_0077}, {wcode_0078},
															 {wcode_0082}, {wcode_0083},
															 {wcode_0089}, {wcode_0090},
															 {wcode_0120},
															 {wcode_2374}, {wcode_2375}, {wcode_2376}, {wcode_2377},
															 {wcode_2378}, {wcode_2390}, {wcode_2391}, {wcode_2392}
			                        ], warning_codes_rl);

	  // Filter out all null codes
		warning_codes := warning_codes1(code<>'');



    // **************** SUBORDINATE FILE TRANSFORMS ****************

 		//******** Gong file (telephone data) transform
		iesp.rateevasion.t_RateEvasionReversePhone gong_file_xform(input_phone_info_rec_raw l) := transform

		  // convert state abbrev & county fips code to county name to be used in the address below.
		  gong_county_name := get_county_name(l.st, l.county_code[3..5]);

			self.ListingName := l.listed_name,
			self.Address     := iesp.ECL2ESP.setAddressFields(l.prim_name, l.prim_range,
			                                                  l.predir, l.postdir, l.suffix,
																												l.unit_desig, l.sec_range,
																												l.p_city_name, l.v_city_name, '',
																	                      l.st, l.z5, l.z4, gong_county_name, ''),
      self.Address.DateFirstSeen := iesp.ECL2ESP.toDate ((unsigned4) l.dt_first_seen),
		  self.Address.DateLastSeen  := iesp.ECL2ESP.toDate ((unsigned4) l.dt_last_seen),
      self.Address.Sources       := [],
			self.PhoneType             := l.listing_type_res
    end;


		//******** Driver License file transform
		iesp.rateevasion.t_RateEvasionDriverLicense
		                                     dl_file_xform(DriversV2.Key_DL_DID l) := transform

 			self.Name        := iesp.ECL2ESP.setNameFields(l.fname, l.mname, l.lname, '',
			                                               l.name_suffix, check_title(l.title)),
			self.DOB         := iesp.ECL2ESP.toDate (l.dob),
			self.Address     := iesp.ECL2ESP.setAddressFields(l.prim_name, l.prim_range,
			                                                  l.predir, l.postdir, l.suffix,
																												l.unit_desig, l.sec_range,
																												l.p_city_name, l.v_city_name, '',
																	                      l.st, l.zip5, l.zip4, l.county_name, ''),
      self.Address.DateFirstSeen := iesp.ECL2ESP.toDate ((unsigned4) 0),
		  self.Address.DateLastSeen  := iesp.ECL2ESP.toDate ((unsigned4) 0),
      self.Address.Sources := [],
			self.Number       := l.dl_number,
			self._Type        := l.license_type,
			self.IssuedDate   := iesp.ECL2ESP.toDate ((unsigned4) l.lic_issue_date),
			self.DLClass      := l.license_class,
			self.IssuedState  := l.orig_state,
			self.Message      := '',
			self.Restrictions := [],

    end;


		//******** SSN info file transform
		iesp.rateevasion.t_RateEvasionSSNInfo
		                        ssn_info_xform(Risk_Indicators.Key_SSN_Table_v4_2 l) := transform
			_l := map(~doxie.DataRestriction.ECH and ~doxie.DataRestriction.EQ and ~doxie.DataRestriction.TCH => l.combo,
								~doxie.DataRestriction.EQ => l.eq,
								~doxie.DataRestriction.ECH => l.en,
								l.tn);
			bureau_deceased_records_permitted := ~doxie.DataRestriction.BureauDeceasedRecords;
			_isDeceased := if(bureau_deceased_records_permitted, _l.isDeceased, l.eq.isDeceased);

      self.SSN             := l.ssn,

			// Check 2 booleans set from is* flag(s) on the key ssn_table_v2 file.
			// As of 06/22/09, Kevin Logemann is still trying to get an "official" ruling
			// from various people as to exactly how "Valid" should be determined.
			self.Valid           := if(l.isvalidformat and l.issequencevalid,
			                           'YES','NO');

			// Convert issue state abbreviation to state name.
			self.IssuedLocation  := ut.St2Name(l.issue_state);
      // Since 2 date fields below are only yyyymm, multiple by 100 to shift left 2 places
			// then add the appropriate number for the dd part.
	    self.IssuedStartDate := iesp.ECL2ESP.toDate ((unsigned4) l.official_first_seen*100 + 1);
      self.IssuedEndDate   := iesp.ECL2ESP.toDate ((unsigned4) l.official_last_seen*100 + 31);
			self.Name            := if(_l.lname1.lname<>'',
			                           iesp.ECL2ESP.setNameFields(_l.lname1.fname, '',_l.lname1.lname,'', '', ''),
																 iesp.ECL2ESP.setNameFields('', '', '', '', '', '')),
	    self.Date            := iesp.ECL2ESP.toDate ((unsigned4) 0),
	    self.State           := l.issue_state,
			// For DeceasedState field, convert deceased zip last residence to 2 char state abbrev.
	    self.DeceasedState   := if(_isDeceased,ziplib.ZipToState2(_l.decs_zip_lastres),''),
	    self.DeceasedName    := if(_isDeceased,
			                           iesp.ECL2ESP.setNameFields(_l.decs_first, '', _l.decs_last, '', '', ''),
														     iesp.ECL2ESP.setNameFields('', '', '', '', '', '')),
	    self.DeceasedDate    := if(_isDeceased,iesp.ECL2ESP.toDate ((unsigned4) _l.dt_first_deceased),
			                                        iesp.ECL2ESP.toDate ((unsigned4) 0))
    end;


 		//******** Others With Same SSN info file transform
		iesp.rateevasion.t_RateEvasionOtherWithSameSSN
		                                   ssn_info2_xform(Watchdog.Layout_Best l) := transform

			self.Name    := iesp.ECL2ESP.setNameFields(l.fname, l.mname, l.lname, '',
			                                           l.name_suffix, check_title(l.title)),
			self.Address := iesp.ECL2ESP.setAddressFields(l.prim_name, l.prim_range,
			                                              l.predir, l.postdir, l.suffix,
																										l.unit_desig, l.sec_range,
																										'', l.city_name, '',
																	                  l.st, l.zip, l.zip4, '', ''),

      self.Address.DateFirstSeen := iesp.ECL2ESP.toDate ((unsigned4) 0),
      // Since date field below is only yyyymm, multiple by 100 to shift left which
			// will add 2 zeroes for the "dd" part of the date.
		  self.Address.DateLastSeen  := iesp.ECL2ESP.toDate ((unsigned4) l.addr_dt_last_seen*100),
      self.Address.Sources := [],
      self.Phone10         := l.phone
		end;


    //******** Previous Address transform
		iesp.rateevasion.t_RateEvasionAddress prev_addr_xform(
			                                    doxie.layout_presentation l) := transform

			self := iesp.ECL2ESP.setAddressFields(l.prim_name, l.prim_range,
			                                      l.predir, l.postdir, l.suffix,
																						l.unit_desig, l.sec_range,
																						'', l.city_name, '',
										                        l.st, l.zip, l.zip4, l.county_name, ''),

			// Since 2 date fields below are only yyyymm, multiple by 100 to shift left which
			// will add 2 zeroes for the "dd" part of the date.
      self.DateFirstSeen := iesp.ECL2ESP.toDate ((unsigned4) l.dt_first_seen*100),
		  self.DateLastSeen  := iesp.ECL2ESP.toDate ((unsigned4) l.dt_last_seen*100),
      self.Sources       := []
    end;


		//******** Vehicle Main key file transform
		iesp.rateevasion.t_RateEvasionVehicleSpecification
                       vehicle_mainkey_xform(VehicleV2.Key_Vehicle_Main_Key l) := transform

	    self.VIN        := l.orig_vin,
	    self.VINStatus  := '',
	    self.Make       := l.vina_make_desc,
	    self.Model      := l.vina_model_desc,
	    self.Year       := (integer2) l.orig_year,
	    self.Series     := l.vina_series_desc,
	    self.BodyStyle  := l.vina_body_style_desc,
	    self.Engine     := l.vina_engine_size,
	    self.VehicleUse := l.orig_vehicle_use_desc,
    end;

		//******** Vehicle Party key file transforms
		iesp.rateevasion.t_RateEvasionVehiclePerson
                   vehicle_partykey_person_xform(vehicle_party_key_rl l) := transform

			self.Name.Full   := l.orig_name,
			self.Name.First  := l.append_clean_name.fname,
			self.Name.Middle := l.append_clean_name.mname,
			self.Name.Last   := l.append_clean_name.lname,
			self.Name.Suffix := l.append_clean_name.name_suffix,
			self.Name.Prefix := check_title(l.append_clean_name.title),

      self.NameType := l.orig_party_type,
			self.Address := iesp.ECL2ESP.setAddressFields(l.append_clean_address.prim_name,
			                                              l.append_clean_address.prim_range,
			                                              l.append_clean_address.predir,
																										l.append_clean_address.postdir,
																										l.append_clean_address.addr_suffix,
																										l.append_clean_address.unit_desig,
																										l.append_clean_address.sec_range,
																										'',
																										l.append_clean_address.v_city_name, '',
																	                  l.append_clean_address.st,
																										l.append_clean_address.zip5,
																										l.append_clean_address.zip4,
																										// Due to some missing/invlaid fips data,
																										// check the fips fields first.
																										if(l.append_clean_address.fips_state  <>'' and
																										   l.append_clean_address.fips_county <> '',
																											 // convert state abbrev & fips county code to county name
																										   get_county_name(l.append_clean_address.st,
																										                   l.append_clean_address.fips_county),
																											 ''),
																										''),
      self.Address.DateFirstSeen := iesp.ECL2ESP.toDate ((unsigned4) 0),
		  self.Address.DateLastSeen  := iesp.ECL2ESP.toDate ((unsigned4) 0),
      self.Address.Sources := []
		end;

		iesp.share.t_Date vehicle_partykey_date1_xform(vehicle_party_key_rl l) := transform
	    self   := iesp.ECL2ESP.toDate ((unsigned4) l.reg_earliest_effective_date)
    end;

		iesp.share.t_Date vehicle_partykey_date2_xform(vehicle_party_key_rl l) := transform
	    self   := iesp.ECL2ESP.toDate ((unsigned4) l.reg_latest_effective_date)
    end;

		iesp.share.t_Date vehicle_partykey_date3_xform(vehicle_party_key_rl l) := transform
	    self   := iesp.ECL2ESP.toDate ((unsigned4) l.reg_latest_expiration_date)
    end;

		iesp.rateevasion.t_RateEvasionVehiclePlate
                   vehicle_partykey_plate_xform(vehicle_party_key_rl l) := transform
			self.Number         := l.reg_license_plate,
	    self.State          := if(l.reg_license_state='',l.state_origin,l.reg_license_state),
	    self.PreviousNumber := if(l.reg_previous_license_plate <> l.reg_license_plate,
			                          l.reg_previous_license_plate,''),
	    self.PreviousState  := if(l.reg_previous_license_state <> l.reg_license_state,
			                          l.reg_previous_license_state,''),
    end;

		iesp.rateevasion.t_RateEvasionAddress
                   vehicle_partykey_lha_xform(vehicle_party_key_rl l) := transform

			self := iesp.ECL2ESP.setAddressFields(l.append_clean_address.prim_name,
			                                      l.append_clean_address.prim_range,
			                                      l.append_clean_address.predir,
																						l.append_clean_address.postdir,
																						l.append_clean_address.addr_suffix,
																						l.append_clean_address.unit_desig,
																						l.append_clean_address.sec_range,
																						'',
																						l.append_clean_address.v_city_name, '',
																	          l.append_clean_address.st,
																						l.append_clean_address.zip5,
																						l.append_clean_address.zip4,
																						// Due to some missing/invlaid fips data,
																						// check the fips fields first.
																						if(l.append_clean_address.fips_state  <>'' and
																						   l.append_clean_address.fips_county <> '',
																							 // convert state abbrev & fips county code to county name
																						   get_county_name(l.append_clean_address.st,
																						                   l.append_clean_address.fips_county),
																							 ''),
																						''),
      self.DateFirstSeen := iesp.ECL2ESP.toDate ((unsigned4) 0),
		  self.DateLastSeen  := iesp.ECL2ESP.toDate ((unsigned4) 0),
      self.Sources := []
		end;

		iesp.rateevasion.t_RateEvasionVehicleTitle
                   vehicle_partykey_title_xform(vehicle_party_key_rl l) := transform
			self.Number := l.ttl_number,
	    self.Date   := iesp.ECL2ESP.toDate ((unsigned4) l.ttl_earliest_issue_date),
	    self.Status := l.ttl_status_desc,
    end;


		//******** Vehicle information record transform
		iesp.rateevasion.t_RateEvasionVehicle vehicle_info_xform(vehicle_key_rl l) := transform

		  // Data for the Specification sub-record comes from the
			// thor_data400::key::vehiclev2::main_key_qa file.
			self.Specification := project(VehicleV2.Key_Vehicle_Main_Key(
			                                            keyed(l.vehicle_key = vehicle_key and
																									      l.iteration_key = iteration_key)),
																		vehicle_mainkey_xform(left))[1],

		  // Data for all the other sub-records/fields below comes from the
			// thor_data400::key::vehiclev2::party_key_qa file.
			// Which associated records were gotten above, sorted, rolled, and then combined &
			// re-sorted and stored in the interim deduped_vehicle_party_recs recordset.
			// Where: orig_name_type=1=owner, 4=registrant and 7=lienholder.

			self.Owner1 := project(deduped_vehicle_party_recs(
			                       l.vehicle_key  = vehicle_key AND
														 orig_name_type = Constants.OWNER),
														 vehicle_partykey_person_xform(left))[1],

			self.Owner2 := project(deduped_vehicle_party_recs(
		                         l.vehicle_key  = vehicle_key AND
														 orig_name_type = Constants.OWNER),
						                 vehicle_partykey_person_xform(left))[2],

			self.Registrant1 := project(deduped_vehicle_party_recs(
			                            l.vehicle_key  = vehicle_key AND
																	orig_name_type = Constants.REGISTRANT),
																	vehicle_partykey_person_xform(left))[1],
			self.Registrant2 := project(deduped_vehicle_party_recs(
			                            l.vehicle_key  = vehicle_key AND
																	orig_name_type = Constants.REGISTRANT),
																	vehicle_partykey_person_xform(left))[2],

			// Get following 3 dates and plate info from the first Registrant record
			self.OriginalRegistrationDate := project(deduped_vehicle_party_recs(
			                                         l.vehicle_key  = vehicle_key AND
																							 orig_name_type = Constants.REGISTRANT),
																		           vehicle_partykey_date1_xform(left))[1],

			self.RegistrationDate         := project(deduped_vehicle_party_recs(
			                                         l.vehicle_key  = vehicle_key AND
																							 orig_name_type = Constants.REGISTRANT),
																		           vehicle_partykey_date2_xform(left))[1],


			self.ExpirationDate           := project(deduped_vehicle_party_recs(
			                                         l.vehicle_key  = vehicle_key AND
																							 orig_name_type = Constants.REGISTRANT),
																		           vehicle_partykey_date3_xform(left))[1],

			self.Plate                    := project(deduped_vehicle_party_recs(
			                                         l.vehicle_key  = vehicle_key AND
																							 orig_name_type = Constants.REGISTRANT),
																		           vehicle_partykey_plate_xform(left))[1],

      self.LienHolderName    := deduped_vehicle_party_recs(
                                         l.vehicle_key  = vehicle_key AND
											                   orig_name_type = Constants.LIENHOLDER)[1].orig_name;

			self.LienHolderAddress := project(deduped_vehicle_party_recs(
		                                              l.vehicle_key = vehicle_key AND
																				          orig_name_type= Constants.LIENHOLDER),
																		              vehicle_partykey_lha_xform(left))[1],

      // Get title info from first record for the vehicle regardless of name_type.
			// Some vehicles may only have owner without registrant recs and other
			// vehicles have registrant recs without owner recs (OH recs for example).
			self.Title             := project(deduped_vehicle_party_recs(l.vehicle_key = vehicle_key),
																        vehicle_partykey_title_xform(left))[1],

	    self.BrandedTitle := [] // Not to be output as of 05/26/09 email from Levi Baker
    end;


		//******** Warnings information transform
		iesp.rateevasion.t_RateEvasionWarning wcode_xform(warning_codes_rl l) := transform
			self.Code        := l.code,
      self.Description := codes.KeyCodes('VARIOUS_HRI_FILES','HRI_CODE','',l.code),
    end;


		//******** Additional Driver information transform
		iesp.rateevasion.t_RateEvasionDriver addl_drivers_xform(dl_info_rl l) := transform
    	self.Name                := iesp.ECL2ESP.setNameFields(l.fname, l.mname, l.lname, '',
			                                                       l.name_suffix, check_title(l.title)),

			self.DOB                 := iesp.ECL2ESP.toDate (l.dob),
			self.Age                 := if(l.dob=0,0,ut.Age(l.dob)),
			self.DriverLicenseNumber := l.dl_number,
			self.IssuingState        := l.orig_state,
		  // Since 2 date fields below are only yyyymm, multiple by 100 to shift left which
			// will add 2 zeroes for the "dd" part of the date.
		  self.DateFirstSeen       := iesp.ECL2ESP.toDate ((unsigned4) l.dt_first_seen*100),
      self.DateLastSeen        := iesp.ECL2ESP.toDate ((unsigned4) l.dt_last_seen*100),
    end;


		//******** Potential Additional Driver information transform
		iesp.rateevasion.t_RateEvasionDriver pad_xform(watchdog.Layout_Best l) := transform
			self.Name                := iesp.ECL2ESP.setNameFields(l.fname, l.mname, l.lname, '',
			                                                       l.name_suffix, check_title(l.title)),

			self.DOB                 := iesp.ECL2ESP.toDate (l.dob),
			self.Age                 := if(l.dob=0,0,ut.Age(l.dob)),
			self.DriverLicenseNumber := '',
			self.IssuingState        := '',
			self.DateFirstSeen       := iesp.ECL2ESP.toDate ((unsigned4) 0),
		  // Since date field below is only yyyymm, multiple by 100 to shift left which
			// will add 2 zeroes for the "dd" part of the date.
      self.DateLastSeen        := iesp.ECL2ESP.toDate ((unsigned4) l.addr_dt_last_seen*100),
    end;



	  // **************** MAIN TRANSFORM ****************
    //******** Header file transform
		iesp.rateevasion.t_RateEvasionSearchResponse main_xform(
											                           doxie.layout_presentation l) := transform

			 self._penalty  := l.penalt,
	     self.AlsoFound := false,
		   self._Header   := iesp.ECL2ESP.GetHeaderRow(),

       // The 3 fields below depend upon if IncludeScore was checked.
			 // Calculate scores based upon passed-in score values or defaults if no
			 // scoring info passed-in, whether the results matched the input and whether
			 // values were input at all.
			 // *_match, *_nomatch and *_missing values were set above.
			 integer2 temp_score := if(IncludeScore,
			                           // Start with a starting score
																 (starting_score +
																 // Check input vs returned results or if input was missing.
																 // Negate values for no match or missing conditions.
																 // Check if fname was input and it matches.
 														     if(fname_was_input,
																    if(first_names_same,fn_match,-fn_nomatch),
																    -fn_missing) +
														     // Check if lname was input and it matches
														     if(lname_was_input,
														        if(last_names_same,ln_match,-ln_nomatch),
																    -ln_missing) +
														     // Check if street address was input and it matches
														     if (prim_range_was_input or prim_name_was_input,
														         if(search_prim_name  = current_prim_name_stripped and
																        search_prim_range = current_prim_range,addr_match,-addr_nomatch),
																     -addr_missing) +
														     // Check if City was input and it matches
														     if(city_was_input,
													         if(search_city = current_city,city_match,-city_nomatch),
																    -city_missing) +
														     // Check if State was input and it matches
														     if(state_was_input,
													         if(search_state = current_state,st_match,-st_nomatch),
																    -st_missing) +
														     // Check if zip was input and it matches
														     if (zip_was_input,
														         if(search_zip = current_zip,zip_match,-zip_nomatch),
																     -zip_missing) +
														     // Check if SSN was input and it matches
														     if(ssn_was_input,
														        if(search_ssn = current_ssn,ssn_match,-ssn_nomatch),
																    -ssn_missing) +
														     // Check if DOB was input and it matches
														     if(dob_was_input,
														        if(search_dob = current_dob,dob_match,-dob_nomatch),
																    -dob_missing) +
														     // Check if phone was input and it matches
														     if(phone_was_input,
														        if(search_phone = current_phone,phn_match,-phn_nomatch),
																    -phn_missing)
																 ),
																 // Otherwise if IncludeScore not requested, return a zero.
																 0);

			 //  If score ends up to be negative for some reason, set it to zero.
			 self.Score     := if(IncludeScore,if(temp_score<0,0,temp_score),
			                      0),

       self.ScoringTableVersion := if(IncludeScore,scoring_version,''),

	     // *** For all "*Validated" fields below; set to YES/NO/space based on presence of
			 // input search field and returned data matching what was input.

			 self.SSNValidated := if(ssn_was_input,
			                         if(search_ssn = current_ssn,'YES','NO'),
			 												 ' '),

       // Current Name info is always returned.
       self.CurrentName  := iesp.ECL2ESP.setNameFields(l.fname, l.mname, l.lname, '',
			                                                 l.name_suffix, check_title(l.title)),

			 // Check input name parts values versus file/output values.
	     self.CurrentName.FirstNameValidated  := if(fname_was_input,
			                                            if(search_fname = current_fname,'YES','NO'),
			 	 																				  ' '),
			 // Also check for mname just an initial.
	     self.CurrentName.MiddleNameValidated := if(mname_was_input,
			                                            if(search_mname    = current_mname or
																									   search_minitial = current_minitial,'YES','NO'),
																									' '),
			 self.CurrentName.LastNameValidated   := if(lname_was_input,
			                                            if(search_lname = current_lname or ut.fn_match_on_hyphenated_name(search_lname,current_lname),'YES','NO'),
																								  ' '),
	     self.CurrentName.SuffixValidated     := if(namesuffix_was_input,
			                                            if(search_name_suffix = current_name_suffix,'YES','NO'),
			                                       			' '),

       // Current Address info is always returned.
			 self.CurrentAddress := iesp.ECL2ESP.setAddressFields(l.prim_name, l.prim_range,
			                                                      l.predir, l.postdir, l.suffix,
																														l.unit_desig, l.sec_range,
																														'',	l.city_name, '', l.st,
																														l.zip, l.zip4, l.county_name, ''),

			// Since 2 date fields below are only yyyymm, multiple by 100 to shift left which
			// will add 2 zeroes for the "dd" part of the date.
      self.CurrentAddress.DateFirstSeen := iesp.ECL2ESP.toDate ((unsigned4) l.dt_first_seen*100),
		  self.CurrentAddress.DateLastSeen  := iesp.ECL2ESP.toDate ((unsigned4) l.dt_last_seen*100),

      self.CurrentAddress.Sources       := [],

			// Check input address parts values versus file/output values.
	    self.CurrentAddress.StreetNumberValidated := if(prim_range_was_input,
			                                                if(search_prim_range = current_prim_range,'YES','NO'),
																											' '),
	    self.CurrentAddress.StreetNameValidated   := if(prim_name_was_input,
			                                                if(search_prim_name = current_prim_name_stripped,'YES','NO'),
																											' '),
	    self.CurrentAddress.CityValidated         := if(city_was_input,
			                                                if(search_city = current_city,'YES','NO'),
																											' '),
	    self.CurrentAddress.StateValidated        := if(state_was_input,
			                                                if(search_state = current_state,'YES','NO'),
																											' '),
	    self.CurrentAddress.ZipValidated          := if(zip_was_input,
			                                                if(search_zip = current_zip,'YES','NO'),
																											' '),

      // Home phone info is always returned.
			self.HomePhone.Phone10     := l.phone,
	    self.HomePhone.IsValidated := if(phone_was_input,
			                                 if(search_phone = current_phone,'YES','NO'),
																			 ' '),

      // DOB & Age info is always returned.
			self.DOB             := iesp.ECL2ESP.toDate (l.dob),
			self.DOB.IsValidated := if(dob_was_input,
			                           if(search_dob = current_dob,'YES','NO'),
														     ' '),
			self.Age := if(current_dob <>0,ut.Age(current_dob),0),


			// ***Check appropriate input "Include*" switch to determine whether to output data
			// in the records/datasets below.

      // Only return ReversePhoneLookup data if IncludeReversePhoneLookup checkbox was
			// selected and a valid length phone# was input.
			self.ReversePhoneLookup := if(IncludeRPL and phone_was_input and search_phone_length_ok,
																	  project(input_phone_info_rec, gong_file_xform(left))[1]),

      // Only return Driver License data if IncludeDriverLicense checkbox was selected.
			self.DriverLicense := if(IncludeDL,
						                       project(dl_rec_for_main, dl_file_xform(LEFT))[1]),


      // DateReturned & TimeReturned info is always returned.
			self.DateReturned  := iesp.ECL2ESP.toDate (run_yyyymmdd),
      self.TimeReturned  := hh + ':' + mm + ':' + ss + '.00',

      // SSN & OthersWithSameSSN info is always returned.
			self.SSNs              := choosen(project(ssn_info_recs, ssn_info_xform(left)),
			                                  iesp.Constants.RATEEVA_MAX_COUNT_SSNS),

			self.OthersWithSameSSN := choosen(project(others_with_same_ssn_recs, ssn_info2_xform(left)),
 			                                  iesp.Constants.RATEEVA_MAX_COUNT_OTHER_SSNS),

			// Only return Previous Addresses data if IncludePreviousAddresses checkbox was selected.
			// Use separate dataset of previous addresses created from in_recs above.
			self.PreviousAddresses := if(IncludePA,
			                             choosen(project(prev_addrs_sorted, prev_addr_xform(LEFT)),
																         	 iesp.Constants.RATEEVA_MAX_COUNT_PREV_ADDRS)),

			// Only return Motor Vehicles data if IncludeMotorVehicle checkbox was selected.
      // For Vehicles, use the records from the deduped_vehicle_recs dataset created above.
			self.Vehicles          := if(IncludeMVR,
			                             choosen(project(deduped_vehicle_recs, vehicle_info_xform(LEFT)),
																	 	       iesp.Constants.RATEEVA_MAX_COUNT_VEHICLES)),

			// Output warnings if any non-null ones were created.
			self.Warnings := if(count(warning_codes) > 0,
			                    choosen(project(warning_codes, wcode_xform(left)),
														      iesp.Constants.RATEEVA_MAX_COUNT_WARNINGS)),

      // Only return Additional Drivers data if IncludeAdditionalDrivers checkbox was selected.
			// For Additional Drivers, use the records from a dataset created above.
			self.AdditionalDrivers := if(IncludeAD,
						                       choosen(project(dl_recs_minus_main, addl_drivers_xform(LEFT)),
																	 	       iesp.Constants.RATEEVA_MAX_COUNT_ADDL_DRIVERS)),

			// Only return Potential Additional Drivers data if IncludePotentialAdditionalDrivers
			// checkbox was selected.
			// For Potential Additional Drivers, use the records from a dataset created above.
			self.PotentialAdditionalDrivers := if(IncludePAD,
						                                choosen(project(pad_info_recs,pad_xform(LEFT)),
																						        iesp.Constants.RATEEVA_MAX_COUNT_PADDL_DRIVERS)),

		  // Echo any Insurance Info fields that were input.
			self.InsuranceInfo.AgentNumber          := if(in_mod.agent_number <> '',
			                                              in_mod.agent_number, ' '),
			self.InsuranceInfo.ClaimNumber          := if(in_mod.claim_number <> '',
			                                              in_mod.claim_number, ' '),
			self.InsuranceInfo.PolicyInceptionDate  := if(in_mod.polinc_date <> 0,
			                                              iesp.ECL2ESP.toDate ((unsigned4) in_mod.polinc_date),
																										iesp.ECL2ESP.toDate ((unsigned4) 0)),
			self.InsuranceInfo.PolicyNumber         := if(in_mod.policy_number <> '',
			                                              in_mod.policy_number,' '),
			self.InsuranceInfo.DateOfLoss           := if(in_mod.date_loss <> 0,
			                                              iesp.ECL2ESP.toDate ((unsigned4) in_mod.date_loss),
																										iesp.ECL2ESP.toDate ((unsigned4) 0)),
			self.InsuranceInfo.ExaminerAdjusterCode := if(in_mod.exam_adj_code <> '',
			                                              in_mod.exam_adj_code, ' '),

		end;


    // Use a project to format the data from the current name/address record
		// into the search response record structure(s) defined in iesp.rateevasion.
	  recs_fmtd := project(curr_addr, main_xform(LEFT));


		//Uncomment lines below as needed to assist in debugging
		//output(in_mod.unparsedfullname,named('func_in_mod_up_fullname'));
		//output(in_mod.firstname,named('func_in_mod_firstname'));
		//output(in_mod.middlename,named('func_in_mod_middlename'));
		//output(in_mod.namesuffix,named('func_in_mod_namesuffix'));
		//output(in_mod.lastname,named('func_in_mod_lastname'));
		//output(in_mod.addr,named('func_in_mod_addr'));
		//output(in_mod.prim_name,named('func_in_mod_prim_name'));
		//output(in_mod.prim_range,named('func_in_mod_prim_range'));
		//output(in_mod.city,named('func_in_mod_city'));
		//output(in_mod.state,named('func_in_mod_state'));
		//output(in_mod.zip,named('func_in_mod_zip'));
		//output(in_mod.ssn,named('func_in_mod_ssn'));
		//output(in_mod.dob,named('func_in_mod_dob'));
		//output(in_mod.phone,named('func_in_mod_phone'));
		//output(in_mod.input_vins,named('func_in_mod_input_vins'));
		//output(in_mod.company_id,named('func_in_mod_company_id'));
		//output(CustomerIsMaif,named('func_CustomerIsMaif'));
		//output(in_mod.scoring_info,named('func_in_mod_scoring_info'));
		//output(scoring_info_in,named('func_scoring_info_in'));
		//output(decoded_scoring_info,named('func_decoded_scoring_info'));
		//output(version_in,named('func_version_in'));
		//output(starting_score_in,named('func_starting_score_in'));
		//output(fn_match_in,named('func_fn_match_in'));

	  //output(in_recs,named('func_in_recs'));
		//output(in_recs_addr_sorted, named('func_recs_addr_sorted'));
		//output(in_recs_addr_rolled, named('func_recs_addr_rolled'));
		//output(best_rec,named('func_best_rec'));
		//output(curr_addr,named('func_curr_addr'));
		//output(search_fullname,named('func_search_fullname'));
		//output(search_fname,named('func_search_fname'));
		//output(search_mname,named('func_search_mname'));
		//output(search_lname,named('func_search_lname'));
		//output(search_name_suffix,named('func_search_name_suffix'));
		//output(fname_was_input,named('func_fname_was_input'));
		//output(lname_was_input,named('func_lname_was_input'));
		//output(search_fulladdr.prim_name,named('func_search_fulladdr_pn'));
		//output(search_fulladdr.prim_range,named('func_search_fulladdr_pr'));
    //output(search_prim_range,named('func_search_prim_range'));
		//output(search_prim_name,named('func_search_prim_name'));
		//output(search_city,named('func_search_city'));
		//output(search_state,named('func_search_state'));
		//output(search_zip,named('func_search_zip'));
		//output(search_ssn,named('func_search_ssn'));
		//output(search_dob,named('func_search_dob'));
		//output(search_phone,named('func_search_phone'));
		//output(phone_was_input,named('func_phone_was_input'));
		//output(current_fname,named('func_current_fname'));
		//output(current_lname,named('func_current_lname'));
		//output(current_prim_range,named('func_current_prim_range'));
		//output(current_prim_name,named('func_current_prim_name'));
		//output(current_prim_name_stripped,named('func_current_prim_name_stripped'));
		//output(current_sec_range,named('func_current_sec_range'));
		//output(current_city,named('func_current_city'));
		//output(current_state,named('func_current_state'));
		//output(current_zip,named('func_current_zip'));
		//output(current_ssn,named('func_current_ssn'));
		//output(current_dob,named('func_current_dob'));
		//output(current_phone,named('func_current_phone'));
    //output(first_names_same,named('func_first_names_same'));
		//output(last_names_same,named('func_last_names_same'));
		//output(prim_name_was_input,named('func_prim_name_was_input'));
    //output(main_did,named('func_main_did'));
		//output(main_hhid,named('func_main_hhid'));
		//output(main_ssn,named('func_main_ssn'));
		//output(in_recs_count,named('func_in_recs_count'));
		//output(in_recs_2plus,named('func_in_recs_2plus'));
		//output(prev_addrs,named('func_prev_addrs'));
		//output(prev_addrs_sorted,named('func_prev_addrs_sorted'));
		//output(in_recs_ssns_deduped,named('func_in_recs_ssn_deduped'));
		//output(in_recs_ssns_filtered,named('func_in_recs_ssn_filtered'));
		//output(in_recs_ssns_count,named('func_in_recs_ssns_count'));
		//output(ssn_info_recs,named('func_ssn_info_recs'));
		//output(dids_for_all_ssns,named('func_dids_for_all_ssns'));
		//output(dids_for_all_ssns_minus_main,named('func_dids_for_all_ssns_minus_main'));
		//output(dids_for_all_ssns_count,named('func_dids_for_all_ssns_count'));
		//output(others_with_same_ssn_best_info,named('func_others_with_same_ssn_best_info'));
		//output(others_with_same_ssn_recs,named('func_others_with_same_ssn_recs'));
		//output(key_hdr_addr_recs,named('func_key_hdr_addr_recs'));
		//output(key_hdr_addr_recs_deduped,named('func_key_hdr_addr_recs_deduped'));
		//output(all_curr_addr_best_recs,named('func_all_curr_addr_best_recs'));
		//output(curr_addr_best_recs_filtered,named('func_curr_addr_best_recs_filtered'));
		//output(curr_addr_best_recs_minus_main,named('func_curr_addr_best_recs_minus_main'));
		//output(dl_recs_all,named('func_dl_recs_all'));
		//output(dl_recs_count,named('func_dl_recs_count'));
		//output(dl_rec_for_main,named('func_dl_rec_for_main'));
		//output(dl_recs_minus_main,named('func_dl_recs_minus_main'));
		//output(lname_from_dl_rec,named('func_lname_from_dl_rec'));
		//output(fname_from_dl_rec,named('func_fname_from_dl_rec'));
		//output(dl_last_names_same,named('func_dl_last_names_same'));
		//output(dl_first_names_same,named('func_dl_first_names_same'));
		//output(pad_info_recs,named('func_pad_info_recs'));
		//output(vehicles_for_did_all,named('func_vehicles_for_did_all'));
    //output(vehicles_for_did,named('func_vehicles_for_did'));
		//output(vehicle_party_recs_for_did_all,named('func_vehicle_party_recs_for_did_all'));
		//output(vehicle_party_recs_for_did_all2,named('func_vehicle_party_recs_for_did_all2'));
		//output(vehicle_party_recs_for_did_all3,named('func_vehicle_party_recs_for_did_all3'));
		//output(vehicle_party_recs_for_did,named('func_vehicle_party_recs_for_did'));
		//output(deduped_party_recs,named('func_deduped_party_recs'));
		//output(active_vehicles_for_did_all,named('func_active_vehicles_for_did_all'));
		//output(active_vehicles_for_did,named('func_active_vehicles_for_did'));
		//output(active_vehicles_count,named('func_active_vehicles_count'));
		//output(vehicle_party_recs_sorted,named('func_vehicle_party_recs_sorted'));
		//output(vehicle_party_recs_rolled,named('func_vehicle_party_recs_rolled'));
		//output(vin_vehicle_key_recs,named('func_vin_vehicle_key_recs'));
	  //output(vin_vehicle_party_recs,named('func_vin_vehicle_party_recs'));
		//output(vin_vehicle_party_recs_sorted,named('func_vin_vehicle_party_recs_sorted'));
	  //output(vin_vehicle_party_recs_rolled,named('func_vin_vehicle_party_recs_rolled'));
		//output(combined_vehicle_recs,named('func_combined_vehicle_recs'));
		//output(combined_vehicle_party_recs,named('func_combined_vehicle_party_recs'));
    //output(deduped_vehicle_recs,named('func_deduped_vehicle_recs'));
    //output(deduped_vehicle_party_recs,named('func_deduped_vehicle_party_recs'));
	  //output(warning_codes,named('func_warning_codes'));
		//output(recs_fmtd,named('func_recs_fmtd'));

		return(recs_fmtd);

  end;

end;
