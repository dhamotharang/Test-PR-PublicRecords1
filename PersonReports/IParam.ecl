// Encapsulates input parameters for each particular component
// (probably will be split and moved to each correspondent service)

// Currently almost all of these are "fake": just synonyms of a superset input

IMPORT AutoHeaderI, doxie, suppress, relationship, FCRA, AutoStandardI;

EXPORT IParam := MODULE

  //Most generous structure for reading input parameters. Unfortunately, individual structures must extend
  //this huge structure, because of legacy code (sudden "#store" calls)
  EXPORT _didsearch := INTERFACE (AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full)
  END;


  //Some things common for all (or most of the) reports. Any report can redefine these.
  EXPORT _report := INTERFACE (doxie.IDataAccess, FCRA.iRules)
    //other common parameters
    EXPORT boolean include_hri := FALSE;
    EXPORT boolean legacy_verified := TRUE;
    EXPORT unsigned1 score_threshold := 10; //needed in phones+    : stored('ScoreThreshold');
    EXPORT unsigned2 penalty_threshold := 10;
    EXPORT unsigned1 max_hri := 10; // same as unsigned1 maxHriPer_value := 10 : stored('MaxHriPer')
    EXPORT boolean include_BlankDOD := FALSE; // allows to return death records with no DOD
    EXPORT boolean smart_rollup := FALSE;
    EXPORT integer1 non_subject_suppression := suppress.Constants.NonSubjectSuppression.doNothing;
  END;


  /////////////// STAND ALONE (SINGLE SOURCE)  ///////////////

  EXPORT bankruptcy := INTERFACE
    EXPORT string1 bk_party_type := 'D'; //enforces to return records with subject as Debtor only
    EXPORT boolean bk_include_dockets := FALSE;
    EXPORT boolean bk_suppress_withdrawn := FALSE;
  END;

  EXPORT criminal := INTERFACE
    EXPORT boolean AllowGraphicDescription := FALSE;
    EXPORT boolean Include_BestAddress := FALSE;
    EXPORT boolean IncludeAllCriminalRecords := FALSE;
    EXPORT boolean IncludeSexualOffenses := FALSE;
  END;

  EXPORT dl := INTERFACE
    // defines whether Certegy data will be used in addition to the Government+Experian
    EXPORT boolean use_nonDMVSources := FALSE;
  END;

  EXPORT liens := INTERFACE
    EXPORT string1 liens_party_type := '';
    EXPORT string50 tmsid_value := ''; // reserved for future needs if any
  END;

  EXPORT peopleatwork := INTERFACE (_report)
  END;

  EXPORT proflic := INTERFACE (_report)
  END;

  // general (vs. productwise) phones options
  EXPORT phones := INTERFACE
    EXPORT boolean indicate_restricted := FALSE; // will show "UNPUB"
    EXPORT boolean include_phonesfeedback := FALSE;
  END;

  EXPORT property := INTERFACE
    EXPORT boolean ignoreFares := FALSE;
    EXPORT boolean ignoreFidelity := FALSE;
    EXPORT boolean use_nonsubjectproperty     := FALSE; // former "include_priorproperties"
    EXPORT boolean use_currentlyownedproperty := FALSE; //meaning, current ONLY!
  
    // if TRUE, brings this-subject-owned properties on top of the results.
    // Probably, will be sparsely used (see #40087)
    EXPORT boolean sort_deeds_by_ownership := FALSE;
    EXPORT boolean include_aml_property := FALSE;
  END;

  // health care providers
  EXPORT providers := INTERFACE
    EXPORT boolean include_groupaffiliations    := FALSE;
    EXPORT boolean include_hospitalaffiliations := FALSE;
    EXPORT boolean include_education            := FALSE;
    EXPORT boolean include_businessaddress      := FALSE;
  END;

  EXPORT ucc := INTERFACE
    EXPORT boolean includemultiplesecured := FALSE;
    EXPORT boolean returnrolleddebtors := FALSE;
    EXPORT string1 ucc_party_type := '';
  END;

  EXPORT vehicles := INTERFACE
    EXPORT boolean  Use_CurrentlyOwnedVehicles := FALSE;
  END;

  EXPORT watercrafts := INTERFACE
    EXPORT boolean include_NonRegulated_WatercraftSources := FALSE;
  END;

  /////////////// INTERFACES REPRESENTING A PERSON ///////////////
  EXPORT address := INTERFACE
    EXPORT boolean include_censusdata := FALSE;
    EXPORT boolean exact_sec_range_match := FALSE; //... for address-phone linking
    EXPORT unsigned1 address_recency_days := 60; // time span address is considered to be current for certain occasions
    EXPORT boolean include_residents := TRUE;
    EXPORT boolean expand_address := TRUE;
    // allows to include phones which were fetched without secondary range and have different from residents last names;
    // this is probably a wrong option, but Finder report currently shows these phones.
    EXPORT boolean include_nonresidents_phones := TRUE;
  END;

  EXPORT neighbors := INTERFACE
    EXPORT unsigned1 neighborhoods := 0;
    EXPORT unsigned1 historical_neighborhoods := 0;
    EXPORT unsigned1 neighbors_per_address := 3;
    EXPORT unsigned1 addresses_per_neighbor := 3;
    EXPORT unsigned1 neighbors_per_na := 6;
    EXPORT unsigned1 neighbors_recency := 3;
    EXPORT unsigned1 neighbors_proximity := 10;
    // new to CRS:
    EXPORT boolean nbrs_with_phones := FALSE;        // meaning, ONLY neighbors with phones
    EXPORT boolean use_verified_address_nb := FALSE; // enforce returning of verified addresses only
    EXPORT boolean use_bestaka_nb := TRUE ;          // defines whether to return multiple or best AKA only
  END;

  EXPORT relatives := INTERFACE (Relationship.IParams.relationshipParams) // equally TRUE for "associates"
    EXPORT unsigned1 relative_depth := 1;
    EXPORT unsigned1 max_relatives := 10;
    EXPORT boolean include_relativeaddresses := FALSE; //TODO: verify default; check do we need it here at all
    EXPORT unsigned1 max_relatives_addresses  := 3;
    // new to CRS:
    EXPORT boolean rels_with_phones := FALSE;        // meaning, ONLY relatives/associates with phones
    EXPORT boolean use_verified_address_ra := FALSE; // enforce returning of verified addresses only
    EXPORT boolean use_bestaka_ra := TRUE;           // defines whether to return multiple or best AKA only
  END;

  EXPORT imposters := INTERFACE
    // An imposter may have several records on file, some of which with same as subject's SSN;
    // This controls whether to return all imposter's records, or only ones with subject's SSN
    // Moxie currently returns all, which may produce kind of "duplicate" output.
    EXPORT boolean return_AllImposterRecords := FALSE;
    EXPORT unsigned1 max_imposter_akas := 10;
  END;


  /////////////// INTERFACES REPRESENTING A PERSON ///////////////
  // Defines all "personal" data: relatives, neighbors, associates, etc. Also defines most frequent defaults
  // (cannot use "person" -- something for Gavin to take a look at)
  EXPORT personal := INTERFACE (address, imposters, relatives, neighbors, phones)
  // //   unfortunate artefact: DL should really be a stand alone data
    EXPORT boolean include_driverslicenses := FALSE;
    EXPORT string9 _ssn := ''; // needed, if comp report (and alike) are provided with input SSN
    EXPORT boolean include_criminalindicators := FALSE;
  END;

  /////////////// MAIN REPORTS' AND INCLUDE INTERFACES ///////////////
  EXPORT include := INTERFACE
    EXPORT boolean select_individually := FALSE; //TODO: legacy; to be removed

    EXPORT boolean include_accidents := FALSE;
    EXPORT boolean include_akas := FALSE;
    EXPORT boolean include_alsofound := FALSE; //was not defined in "standard" doxie-selection.
    EXPORT boolean include_associates := FALSE;
    EXPORT boolean include_atf := FALSE; // Firearms and explosives
    EXPORT boolean include_bankruptcy := FALSE;
    EXPORT boolean include_best := FALSE;
    EXPORT boolean include_boaters := FALSE;
    EXPORT boolean include_bpsaddress := FALSE; //was not defined in "standard" doxie-selection.
    EXPORT boolean include_civilcourts := FALSE;
    EXPORT boolean include_controlledsubstances := FALSE; //aka DEA
    EXPORT boolean include_corpaffiliations := FALSE;
    EXPORT boolean include_crimrecords := FALSE; //aka DOC
    EXPORT boolean include_crimhistory := FALSE; // aka matrix history; ESP also has IncludeMatrixRelativesCriminalHistory
    EXPORT boolean include_deceased := FALSE;
    EXPORT boolean include_domains := FALSE;
    EXPORT boolean include_driversataddress  := FALSE;
    EXPORT boolean include_driverslicenses := FALSE;
    EXPORT boolean include_email := FALSE;
    EXPORT boolean include_eq := FALSE; //Equifax?
    EXPORT boolean include_faaaircrafts := FALSE;
    EXPORT boolean include_faacertificates := FALSE;
    EXPORT boolean include_fbn := FALSE; // fictitious business names
    EXPORT boolean include_flcrash := FALSE; // aka Accidents
    EXPORT boolean include_foreclosures := FALSE;
    EXPORT boolean include_huntingfishing := FALSE;
    EXPORT boolean include_historicalneighbors := FALSE;
    EXPORT boolean include_imposters := FALSE;
    EXPORT boolean include_kris := FALSE;
    EXPORT boolean include_liensjudgments := FALSE;
    EXPORT boolean include_merchantvessels := FALSE; // not used in doxie-CRS
    EXPORT boolean include_motorvehicles := FALSE;
    EXPORT boolean include_neighbors := FALSE;
    EXPORT boolean include_nod := FALSE; // notice of default
    EXPORT boolean include_oldphones := FALSE;
    EXPORT boolean include_patriot := FALSE; // aka Global Watch List
    EXPORT boolean include_peopleatwork := FALSE;
    EXPORT boolean include_phonesplus := FALSE;
    EXPORT boolean include_phonesummary := FALSE;
    EXPORT boolean include_providers := FALSE;
    EXPORT boolean include_proflicenses := FALSE;
    EXPORT boolean include_properties := FALSE;
    EXPORT boolean include_relatives := FALSE;
    EXPORT boolean include_rtvehicles := FALSE;
    EXPORT boolean include_sanctions := FALSE;
    EXPORT boolean include_sexualoffences := FALSE;
//    EXPORT boolean include_targus := FALSE;
    EXPORT boolean include_students := FALSE;
    EXPORT boolean include_uccfilings := FALSE;
    EXPORT boolean include_verification := FALSE;
    EXPORT boolean include_voters := FALSE;
    EXPORT boolean include_watercrafts := FALSE;
    EXPORT boolean include_weaponpermits := FALSE; // aka CCW?
    EXPORT boolean include_sources := FALSE;
    EXPORT boolean include_criminalindicators := FALSE;
  END;


  // =========================================================================
  // ================= Central Records, Comprehensive Report ================= 
  // =========================================================================

  // NB: "pseudo": not for real versioning, but rather to suppress corresponding section and/or count
  EXPORT versions := INTERFACE
    EXPORT unsigned1 bankruptcy_version := 0;
    EXPORT unsigned1 crimrecords_version := 0;
    EXPORT unsigned1 dea_version := 0;
    EXPORT unsigned1 dl_version := 0;
    EXPORT unsigned1 en_version := 0; //pseudo. //TODO: what's that???
    EXPORT unsigned1 email_version := 0; //pseudo
    EXPORT unsigned1 liensjudgments_version := 0;
    EXPORT unsigned1 phonesplus_version := 0; // pseudo
    EXPORT unsigned1 proflicense_version := 0; // pseudo
    EXPORT unsigned1 property_version := 0;
    EXPORT unsigned1 statedeath_version := 0; // pseudo
    EXPORT unsigned1 targus_version := 0; // pseudo
    EXPORT unsigned1 ucc_version := 0;
    EXPORT unsigned1 vehicles_version := 0;
    EXPORT unsigned1 voters_version := 0;
  END;

  EXPORT _sources := INTERFACE (include, versions)
  END;

  EXPORT _compoptions := INTERFACE (_report, personal, property, dl, include, versions, providers)
  END;

  //IParam._report isn't compatible with input._report, projecting from new to old will not work.
  //To facilitate converting the modules until we make all PersonReports components
  //compatible with IDataAccess, I will define a set of "old_report" interfaces
  //-- same as original interfaces, minus _report part.
  //Thus, "new" report module can be projected to the "old",
  //and _report can be copied manually.
  
  //Same as $.input._assetreport, minus _report part
  EXPORT old_assetreport := INTERFACE (address, bankruptcy, property, vehicles, watercrafts, imposters, relatives, include, dl, ucc)
    EXPORT boolean use_bestaka_ra := false;
    EXPORT boolean use_NonDMVSources := TRUE;
    EXPORT boolean include_relativeaddresses := TRUE; // if include relatives, then addresses must be included

    EXPORT boolean include_faaaircrafts := TRUE;
    EXPORT boolean include_motorvehicles := TRUE;
    EXPORT boolean include_uccfilings := TRUE;
    EXPORT boolean include_imposters := TRUE;
    EXPORT boolean include_akas := TRUE;
    EXPORT boolean include_bpsaddress := TRUE;
    EXPORT boolean include_faacertificates := TRUE;
    EXPORT boolean include_watercrafts := TRUE;
    EXPORT boolean include_properties := TRUE;
    EXPORT boolean include_peopleatwork := TRUE;
  END;

  EXPORT _assetreport := INTERFACE (_report, old_assetreport)
  END;

  //Same as $.input._finderreport, minus _report part
  EXPORT old_finderreport := INTERFACE (personal, include, vehicles, dl)
    EXPORT boolean use_verified_address_ra := TRUE;
    EXPORT boolean use_verified_address_nb := TRUE;
    EXPORT boolean nbrs_with_phones := TRUE;
    EXPORT boolean rels_with_phones := TRUE;

    EXPORT boolean include_akas        := TRUE;
    EXPORT boolean include_associates  := TRUE;
    EXPORT boolean include_bankruptcy  := TRUE;
    EXPORT boolean include_bpsaddress  := TRUE;
    EXPORT boolean include_corpaffiliations := TRUE;
    EXPORT boolean include_imposters   := TRUE;
    EXPORT boolean include_neighbors   := TRUE;
    EXPORT boolean include_oldphones   := TRUE;
    EXPORT boolean include_relatives   := TRUE;
    EXPORT boolean include_relativeaddresses := TRUE;
    EXPORT boolean use_NonDMVSources       := TRUE;

    //these are not used by Finder; will be removed eventually.
    EXPORT boolean ignoreFares := FALSE;
    EXPORT boolean ignoreFidelity := FALSE;
  END;

  EXPORT _finderreport := INTERFACE (_report, old_finderreport)
  END;

  //Same as $.input._prelitreport, minus _report part
  EXPORT old_prelitreport := INTERFACE (address, include, property, vehicles, imposters, relatives, dl, bankruptcy, watercrafts)
    EXPORT boolean use_NonDMVSources       := TRUE;
    EXPORT boolean include_relativeaddresses := TRUE; // if include relatives, then addresses must be included

    EXPORT boolean include_motorvehicles   := TRUE;
    EXPORT boolean include_uccfilings      := TRUE;
    EXPORT boolean include_imposters       := TRUE;
    EXPORT boolean include_akas            := TRUE;
    EXPORT boolean include_bpsaddress      := TRUE;
    EXPORT boolean include_censusdata      := FALSE;
    EXPORT boolean include_watercrafts     := TRUE;
    EXPORT boolean include_properties      := TRUE;
    EXPORT boolean include_bankruptcy      := TRUE;
    EXPORT boolean include_proflicenses    := TRUE;
    EXPORT boolean include_corpaffiliations := TRUE;
    EXPORT boolean include_peopleatwork    := TRUE;
    EXPORT boolean include_liensjudgments  := TRUE;
    // some data are available in new presentation (default should be minimal version):
    EXPORT unsigned1 bankruptcy_version := 1;
    EXPORT unsigned1 liensjudgments_version := 1;
  end;
  
  EXPORT _prelitreport := INTERFACE (_report, old_prelitreport)
  END;

  //Same as $.input._rnareport, minus _report part
  EXPORT old_rnareport := INTERFACE (AutoStandardI.InterfaceTranslator.clean_address.params, include, personal)
    EXPORT boolean use_verified_address_nb := TRUE;
    EXPORT boolean nbrs_with_phones := TRUE;
    EXPORT unsigned1 neighbors_per_address := 6;
    //these are not used by RNA; will be removed eventually.
    EXPORT boolean ignoreFares := FALSE;
    EXPORT boolean ignoreFidelity := FALSE;
  END;
  EXPORT _rnareport := INTERFACE (_report, old_rnareport)
  END;

  //Same as $.input._smartlinxreport, minus _report part
  EXPORT old_smartlinxreport := INTERFACE (_sources, personal, providers, dl, property, criminal, liens, bankruptcy, watercrafts)
    // define defaults for those just declared
    //EXPORT boolean include_bpsaddress      := TRUE;
    EXPORT boolean include_BlankDOD := TRUE;
    EXPORT unsigned1 max_relatives := 100;
    //EXPORT boolean include_residents := TRUE;
    EXPORT boolean use_bestaka_ra := FALSE;
    EXPORT boolean include_relativeaddresses := TRUE; // if include relatives, then addresses must be included
    EXPORT unsigned1 bankruptcy_version := 2;
    EXPORT unsigned1 crimrecords_version := 2;
    EXPORT unsigned1 dea_version := 2;
    EXPORT unsigned1 dl_version := 2;
    EXPORT unsigned1 liensjudgments_version := 2;
    EXPORT unsigned1 phonesplus_version := 2;
    EXPORT unsigned1 proflicense_version := 2;
    EXPORT unsigned1 property_version := 2;
    EXPORT unsigned1 ucc_version := 2;
    EXPORT unsigned1 vehicles_version := 2;
    EXPORT unsigned1 voters_version := 2;
    EXPORT boolean include_nonresidents_phones := FALSE;
    EXPORT boolean smart_rollup := TRUE;
    EXPORT unsigned1 neighborhoods := 1;
    EXPORT unsigned1 neighbors_per_address := 20;
    EXPORT unsigned1 neighbors_per_na := 2;
    EXPORT boolean sort_deeds_by_ownership := TRUE; //sets property ownership flag that is needed for determining Current/Prior
  END;  

  EXPORT _smartlinxreport := INTERFACE (_report, old_smartlinxreport)
    EXPORT boolean include_BlankDOD := TRUE;
    EXPORT boolean smart_rollup := TRUE;
  END;

  EXPORT ConvertToOldSmartLinx (_smartlinxreport mod_smartlinx) := FUNCTION
    mod_res := MODULE (PROJECT (mod_smartlinx, old_smartlinxreport))
      EXPORT INTEGER FCRAPurpose := mod_smartlinx.FCRAPurpose;
      EXPORT integer8 FFDOptionsMask := mod_smartlinx.FFDOptionsMask;
    
      EXPORT unsigned1 GLBPurpose := mod_smartlinx.glb;
      EXPORT unsigned1 DPPAPurpose := mod_smartlinx.dppa;
      EXPORT string DataPermissionMask := mod_smartlinx.DataPermissionMask;
      EXPORT string DataRestrictionMask := mod_smartlinx.DataRestrictionMask;
      EXPORT boolean ln_branded := mod_smartlinx.ln_branded;
      EXPORT string5 industryclass := mod_smartlinx.industry_class;
      EXPORT string32 applicationtype := mod_smartlinx.application_type;
      EXPORT unsigned3 dateval := mod_smartlinx.date_threshold;
      EXPORT boolean IncludeMinors := mod_smartlinx.show_minors;
      EXPORT string6 ssn_mask := mod_smartlinx.ssn_mask;
      EXPORT boolean mask_dl := mod_smartlinx.dl_mask = 1;
      EXPORT unsigned1 dob_mask := mod_smartlinx.dob_mask;

      EXPORT boolean include_hri := mod_smartlinx.include_hri;
      EXPORT boolean legacy_verified := mod_smartlinx.legacy_verified;
      EXPORT unsigned1 score_threshold := mod_smartlinx.score_threshold;
      EXPORT unsigned2 penalty_threshold := mod_smartlinx.penalty_threshold;
      EXPORT unsigned1 max_hri := mod_smartlinx.max_hri;
      EXPORT boolean include_BlankDOD := mod_smartlinx.include_BlankDOD;
      EXPORT boolean smart_rollup := mod_smartlinx.smart_rollup;
      EXPORT integer1 non_subject_suppression := mod_smartlinx.non_subject_suppression;

      //fields that are likely should be removed
      EXPORT boolean AllowAll := FALSE;
      EXPORT boolean AllowGLB := FALSE;
      EXPORT boolean AllowDPPA := FALSE;
      EXPORT boolean ignoreFares := FALSE;
      EXPORT boolean ignoreFidelity := FALSE;
      EXPORT boolean restrictPreGLB := TRUE; //not used

      // defined individually in _property interface
      EXPORT boolean probation_override := mod_smartlinx.probation_override;
    END;

    RETURN mod_res;
  END;  

END;
