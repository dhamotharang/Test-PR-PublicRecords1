// TODO: create common defaults to use in AutoStandardI.GlobalModule, here, etc.

// Encapsulates input parameters for each particular component
// (probably will be split and moved to each correspondent service)

// Currently almost all of these are "fake": just synonyms of a superset input

import AutoHeaderI, PAW_Services, AutoStandardI, Accident_Services,
  Hunting_Fishing_Services, ATF_Services,
  Foreclosure_Services, InternetDomain_Services,
  suppress, relationship, FCRA;

EXPORT input := MODULE

  // Most generous structure for reading input parameters. Unfortunately, individual structures must extend
  // this huge structure, because of legacy code (sudden "#store" calls)
  export _didsearch := INTERFACE (AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full)
  end;

  // 2 interfaces to replace AutoStandardI/DataRestrictionI.params; with defaults
  export restrictions := INTERFACE
    export string DataRestrictionMask := '000000000000000000000000';
    export boolean ignoreFares := false;
    export boolean ignoreFidelity:= false;
  end;

  export permissions := INTERFACE (AutoStandardI.PermissionI_Tools.params,AutoStandardI.InterfaceTranslator.application_type_val.params)
    export boolean AllowAll := false;
    export boolean AllowGLB := false;
    export boolean AllowDPPA := false;
    export unsigned1 GLBPurpose := 0;
    export unsigned1 DPPAPurpose := 0;
    export boolean IncludeMinors := false;
  end;

  // Some things common for all (or most of the) reports. Any report can redefine these.
  export _report := INTERFACE (permissions, restrictions, FCRA.iRules)
    // other common parameters
    export string6 ssn_mask := 'NONE';
    export boolean mask_dl := false;
    export unsigned1 dob_mask := suppress.Constants.dateMask.NONE;
    export boolean include_hri := false;
    export boolean legacy_verified := true;
    export string8 record_by_date := ''; // aka DateVal
    export unsigned1 score_threshold := 10; //needed in phones+    : stored('ScoreThreshold');
    export unsigned2 penalty_threshold := 10;
    export boolean ln_branded := false;
    export unsigned1 max_hri := 10; // same as unsigned1 maxHriPer_value := 10 : stored('MaxHriPer')
    export boolean include_BlankDOD := false; // allows to return death records with no DOD
    // export string5  industryclass
    export unsigned3 dateval := 0; // unsigned3 of 'YYYYMM';
		export boolean smart_rollup := false;
    export integer1 non_subject_suppression := suppress.Constants.NonSubjectSuppression.doNothing;
	end;

  // everything required for fetching best records
  export _best := INTERFACE
    export unsigned1 GLBPurpose := 0;
    export unsigned1 DPPAPurpose := 0; // not needed, actually
    export boolean best_include_ssnissuance := false;
    export boolean best_include_dodinfo := false; // for the future needs
    export string6 ssn_mask := ''; // in doxie version "doSuppress" name is used for masking
    export boolean best_append_timezone := false;
    export boolean use_blankkey := true;
  end;

  // there's implicit inheritance of a type:
  // export _name := INTERFACE (AutoStandardI.InterfaceTranslator.fname_val.params,
                             // AutoStandardI.InterfaceTranslator.mname_val.params,
                             // AutoStandardI.InterfaceTranslator.lname_val.params)
  export _name := INTERFACE
    // unfortunately can't use something like
    // export typeof (AutoStandardI.InterfaceTranslator.fname_val.params.firstname) firstname;
    export string30 _fname := '';
    export string30 _mname := '';
    export string30 _lname := '';
  end;

  export _person := INTERFACE (_name)
    // cannot name it "ssn" because of conflicts of types with interfaces in InterfaceTranslator (string11)
    // (IMHO, string11 must have been called something like "ssn_in")
    export string9 _ssn := ''; // needed, if comp report (and alike) are provided with input SSN
    export unsigned8 _dob := 0;
  end;


  /////////////// STAND ALONE (SINGLE SOURCE)  ///////////////
  export accidents := INTERFACE (Accident_Services.IParam.searchRecords)
  end;

  export aircrafts := INTERFACE (_report)
  end;

  export bankruptcy := INTERFACE (_report)
    export string1 bk_party_type := 'D'; //enforces to return records with subject as Debtor only
    export boolean bk_include_dockets := false;
    export boolean bk_suppress_withdrawn := false;
  end;

  // business IID
  export business_iid := INTERFACE (_person)
  end;

  export ccw := INTERFACE (_report)
  end;

  export corpaffil := INTERFACE (_report)
  end;

  export criminal := INTERFACE (_report)
    export boolean AllowGraphicDescription := false;
    export boolean Include_BestAddress := false;
		export boolean IncludeAllCriminalRecords := false;
    export boolean IncludeSexualOffenses := false;
  end;

  export dea := INTERFACE (_report)
  end;

  export dl := INTERFACE
    // defines whether Certegy data will be used in addition to the Government+Experian
    export boolean use_nonDMVSources := false;
  end;

  export emails := INTERFACE (_report)
  end;

  export faacerts := INTERFACE (_report)
  end;
	
	//not used ?
  export firearms := INTERFACE (ATF_Services.IParam.search_params)
  end;

  export foreclosures := INTERFACE (Foreclosure_Services.ReportService_Records.params)
  end;

  export huntingfishing := INTERFACE (Hunting_Fishing_Services.Search_Records.params)
  end;

  export liens := INTERFACE (_report)
    export string1 liens_party_type := '';
    export string50 tmsid_value := ''; // reserved for future needs if any
  end;

  export nod := INTERFACE (Foreclosure_Services.Records.params)
  end;

  export internetdomains := INTERFACE (InternetDomain_Services.SearchService_Records.params)
  end;

  export peopleatwork := INTERFACE (PAW_Services.PAWSearchService_Records.params)
  end;

  // general (vs. productwise) phones options
  export phones := INTERFACE
    export boolean indicate_restricted := false; // will show "UNPUB"
    export boolean include_phonesfeedback := false;
  end;

  export phonesplus := INTERFACE (phones, _report)
  end;

  export proflic := INTERFACE (_didsearch)
  end;

  export property := INTERFACE (_report)
    export boolean use_nonsubjectproperty     := false; // former "include_priorproperties"
    export boolean use_currentlyownedproperty := false; //meaning, current ONLY!
    export boolean probation_override := false;
  
    // if TRUE, brings this-subject-owned properties on top of the results.
    // Probably, will be sparsely used (see #40087)
    export boolean sort_deeds_by_ownership := false;
		export boolean include_aml_property := false;
  end;

  // health care providers
  export providers := INTERFACE
    export boolean include_groupaffiliations    := false;
    export boolean include_hospitalaffiliations := false;
    export boolean include_education            := false;
    export boolean include_businessaddress      := false;
  end;

  export sanctions := INTERFACE (_didsearch)
  end;

  export sexoffenses := INTERFACE (_report)
  end;
	
  export ucc := INTERFACE (_report)
    export boolean includemultiplesecured := false;
    export boolean returnrolleddebtors := false;
    export string1 ucc_party_type := '';
  end;

  export vehicles := INTERFACE (_report)
    export boolean   Use_CurrentlyOwnedVehicles := FALSE;
  end;

  export voters := INTERFACE (_report)
  end;

  export watercrafts := INTERFACE (_report)
		export boolean include_NonRegulated_WatercraftSources:= FALSE;
  end;

  /////////////// INTERFACES REPRESENTING A PERSON ///////////////
  export address := INTERFACE
    export boolean include_censusdata := false;
    export boolean exact_sec_range_match := false; //... for address-phone linking
    export unsigned1 address_recency_days := 60; // time span address is considered to be current for certain occasions
    export boolean include_residents := true;
    export boolean expand_address := true;
    // allows to include phones which were fetched without secondary range and have different from residents last names;
    // this is probably a wrong option, but Finder report currently shows these phones.
    export boolean include_nonresidents_phones := true;
  end;

  export neighbors := INTERFACE
    export unsigned1 neighborhoods := 0;
    export unsigned1 historical_neighborhoods := 0;
    export unsigned1 neighbors_per_address := 3;
    export unsigned1 addresses_per_neighbor := 3;
    export unsigned1 neighbors_per_na := 6;
    export unsigned1 neighbors_recency := 3;
    export unsigned1 neighbors_proximity := 10;
    // new to CRS:
    export boolean nbrs_with_phones := false;        // meaning, ONLY neighbors with phones
    export boolean use_verified_address_nb := false; // enforce returning of verified addresses only
    export boolean use_bestaka_nb := true ;          // defines whether to return multiple or best AKA only
  end;

  export relatives := INTERFACE (Relationship.IParams.relationshipParams) // equally true for "associates"
    export unsigned1 relative_depth := 1;
    export unsigned1 max_relatives := 10;
    export boolean include_relativeaddresses := false; //TODO: verify default; check do we need it here at all
    export unsigned1 max_relatives_addresses  := 3;
    // new to CRS:
    export boolean rels_with_phones := false;        // meaning, ONLY relatives/associates with phones
    export boolean use_verified_address_ra := false; // enforce returning of verified addresses only
    export boolean use_bestaka_ra := true;           // defines whether to return multiple or best AKA only
  end;

  export imposters := INTERFACE
    // An imposter may have several records on file, some of which with same as subject's SSN;
    // This controls whether to return all imposter's records, or only ones with subject's SSN
    // Moxie currently returns all, which may produce kind of "duplicate" output.
    export boolean return_AllImposterRecords := false;
		export unsigned1 max_imposter_akas := 10;
  end;


  // parameters required for "we also found" functionality
  export count_param := module (_report, property, bankruptcy)
  end;


  /////////////// INTERFACES REPRESENTING A PERSON ///////////////
  // Defines all "personal" data: relatives, neighbors, associates, etc. Also defines most frequent defaults
  // (cannot use "person" -- something for Gavin to take a look at)
  export personal := INTERFACE (_report, address, imposters, relatives, neighbors, phones)
    // unfortunate artefact: DL should really be a stand alone data
    export boolean include_driverslicenses := false;
    export string9 _ssn := ''; // needed, if comp report (and alike) are provided with input SSN
    export boolean include_criminalindicators := false;
  end;

  /////////////// MAIN REPORTS' AND INCLUDE INTERFACES ///////////////
  export include := INTERFACE
    export boolean select_individually := false; //TODO: legacy; to be removed

    export boolean include_accidents := false;
    export boolean include_akas := false;
    export boolean include_alsofound := false; //was not defined in "standard" doxie-selection.
    export boolean include_associates := false;
    export boolean include_atf := false; // Firearms and explosives
    export boolean include_bankruptcy := false;
    export boolean include_best := false;
    export boolean include_boaters := false;
    export boolean include_bpsaddress := false; //was not defined in "standard" doxie-selection.
    export boolean include_civilcourts := false;
    export boolean include_controlledsubstances := false; //aka DEA
    export boolean include_corpaffiliations := false;
    export boolean include_crimrecords := false; //aka DOC
    export boolean include_crimhistory := false; // aka matrix history; ESP also has IncludeMatrixRelativesCriminalHistory
    export boolean include_deceased := false;
    export boolean include_domains := false;
    export boolean include_driversataddress  := false;
    export boolean include_driverslicenses := false;
    export boolean include_email := false;
    export boolean include_eq := false; //Equifax?
    export boolean include_faaaircrafts := false;
    export boolean include_faacertificates := false;
    export boolean include_fbn := false; // fictitious business names
    export boolean include_flcrash := false; // aka Accidents
    export boolean include_foreclosures := false;
    export boolean include_huntingfishing := false;
    export boolean include_historicalneighbors := false;
    export boolean include_imposters := false;
		export boolean include_kris := false;
    export boolean include_liensjudgments := false;
    export boolean include_merchantvessels := false; // not used in doxie-CRS
    export boolean include_motorvehicles := false;
    export boolean include_neighbors := false;
    export boolean include_nod := false; // notice of default
    export boolean include_oldphones := false;
    export boolean include_patriot := false; // aka Global Watch List
    export boolean include_peopleatwork := false;
    export boolean include_phonesplus := false;
    export boolean include_phonesummary := false;
    export boolean include_providers := false;
    export boolean include_proflicenses := false;
    export boolean include_properties := false;
    export boolean include_relatives := false;
    export boolean include_rtvehicles := false;
    export boolean include_sanctions := false;
    export boolean include_sexualoffences := false;
//    export boolean include_targus := false;
    export boolean include_students := false;
    export boolean include_uccfilings := false;
    export boolean include_verification := false;
    export boolean include_voters := false;
    export boolean include_watercrafts := false;
    export boolean include_weaponpermits := false; // aka CCW?
    export boolean include_sources := false;
    export boolean include_criminalindicators := false;
		
  end;

  // TODO: Check Mark's suggestion to define all required for the service through "override_includes"
  export _assetreport := INTERFACE (_report, address, bankruptcy, property, vehicles, watercrafts, imposters, relatives, include, dl, ucc)
    export boolean use_bestaka_ra := false;
    export boolean use_NonDMVSources := true;
    export boolean include_relativeaddresses := true; // if include relatives, then addresses must be included

    export boolean include_faaaircrafts := true;
    export boolean include_motorvehicles := true;
    export boolean include_uccfilings := true;
    export boolean include_imposters := true;
    export boolean include_akas := true;
    export boolean include_bpsaddress := true;
    export boolean include_faacertificates := true;
    export boolean include_watercrafts := true;
    export boolean include_properties := true;
    export boolean include_peopleatwork := true;
  end;

  export _finderreport := INTERFACE (personal, include, vehicles, dl)
  end;

  // default options for finder; only those absolutely NOT provided by ESP must be defined here.
  export default_options_finder := module (_finderreport)
    export boolean use_verified_address_ra := true;
    export boolean use_verified_address_nb := true;
    export boolean nbrs_with_phones := true;
    export boolean rels_with_phones := true;

    export boolean include_akas        := true;
    export boolean include_associates  := true;
    export boolean include_bankruptcy  := true;
    export boolean include_bpsaddress  := true;
    export boolean include_corpaffiliations := true;
    export boolean include_imposters   := true;
    export boolean include_neighbors   := true;
    export boolean include_oldphones   := true;
    export boolean include_relatives   := true;
    export boolean include_relativeaddresses := true;
    export boolean use_NonDMVSources       := true;
  end;

  export _prelitreport := INTERFACE (_report, address, include, property, vehicles, imposters, relatives, dl, bankruptcy, watercrafts)
    export boolean use_NonDMVSources       := true;
    export boolean include_relativeaddresses := true; // if include relatives, then addresses must be included

    export boolean include_motorvehicles   := true;
    export boolean include_uccfilings      := true;
    export boolean include_imposters       := true;
    export boolean include_akas            := true;
    export boolean include_bpsaddress      := true;
    export boolean include_censusdata      := false;
    export boolean include_watercrafts     := true;
    export boolean include_properties      := true;
    export boolean include_bankruptcy      := true;
    export boolean include_proflicenses    := true;
    export boolean include_corpaffiliations := true;
    export boolean include_peopleatwork    := true;
    export boolean include_liensjudgments  := true;
    // some data are available in new presentation (default should be minimal version):
    export unsigned1 bankruptcy_version := 1;
    export unsigned1 liensjudgments_version := 1;
  end;

  export _rnareport := INTERFACE (_report, AutoStandardI.InterfaceTranslator.clean_address.params, include, personal)
    export boolean use_verified_address_nb := true;
    export boolean nbrs_with_phones := true;
    export unsigned1 neighbors_per_address := 6;
  end;

  export mardiv := INTERFACE (_didsearch) end;

  // =========================================================================
  // ================= Central Records, Comprehensive Report ================= 
  // =========================================================================

  // TODO: this can probably be used in all other reports
  export _main    := INTERFACE (personal, property, dl)  end;

  // NB: "pseudo": not for real versioning, but rather to suppress corresponding section and/or count
  export versions := INTERFACE
    export unsigned1 bankruptcy_version := 0;
    export unsigned1 crimrecords_version := 0;
    export unsigned1 dea_version := 0;
    export unsigned1 dl_version := 0;
    export unsigned1 en_version := 0; //pseudo. //TODO: what's that???
    export unsigned1 email_version := 0; //pseudo
    export unsigned1 liensjudgments_version := 0;
    export unsigned1 phonesplus_version := 0; // pseudo
    export unsigned1 proflicense_version := 0; // pseudo
    export unsigned1 property_version := 0;
    export unsigned1 statedeath_version := 0; // pseudo
    export unsigned1 targus_version := 0; // pseudo
    export unsigned1 ucc_version := 0;
    export unsigned1 vehicles_version := 0;
    export unsigned1 voters_version := 0;
  end;

  // TODO: do I really need to keep both?
  export _compoptions := INTERFACE (_main, include, versions, providers)
    export boolean LNVersion := false; // TODO: perhaps, outdated: required in call to central records
  end;
  export _compreport := INTERFACE (_compoptions, _person, AutoStandardI.InterfaceTranslator.adl_service_ip.params)
    // define defaults for those just declared
    export string100 seisintadlservice := '';

    export boolean include_bpsaddress        := true;
    export boolean include_merchantvessels := false;
    export unsigned1 max_relatives := 11;
  end;

  export _sources := INTERFACE (personal, include, versions)
  end;


  export _smartlinxreport := INTERFACE (_main, include, providers, _sources,criminal, liens, bankruptcy, watercrafts)
    // define defaults for those just declared
    //export boolean include_bpsaddress      := true;
		export boolean include_BlankDOD := true;
    export unsigned1 max_relatives := 100;
    //export boolean include_residents := true;
    export boolean use_bestaka_ra := false;
    export boolean include_relativeaddresses := true; // if include relatives, then addresses must be included
    export unsigned1 bankruptcy_version := 2;
    export unsigned1 crimrecords_version := 2;
    export unsigned1 dea_version := 2;
    export unsigned1 dl_version := 2;
    export unsigned1 liensjudgments_version := 2;
    export unsigned1 phonesplus_version := 2;
    export unsigned1 proflicense_version := 2;
    export unsigned1 property_version := 2;
    export unsigned1 ucc_version := 2;
    export unsigned1 vehicles_version := 2;
    export unsigned1 voters_version := 2;
    export boolean include_nonresidents_phones := false;
		export boolean smart_rollup := true;
		export unsigned1 neighborhoods := 1;
    export unsigned1 neighbors_per_address := 20;
    export unsigned1 neighbors_per_na := 2;
		export boolean sort_deeds_by_ownership := true; //sets property ownership flag that is needed for determining Current/Prior
  end;

/*
  // default options for comp report; only those absolutely NOT provided by ESP must be defined here.
  //TODO: check appropriate values
  export default_options_crs := module (_compoptions)
    export boolean include_bpsaddress        := true;
    export boolean include_merchantvessels := false;
    export unsigned1 max_relatives := 11;
  end;
*/


  // For the future needs (I'd like to have a set of simple interfaces with well-defined default values)
  // same as AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full, but with defaults
  export search_name := interface 
    export string120 nameasis := '';
    export string120 unparsedfullname := '';
		export string120 asisname := '';
    export string30 firstname := '';
    export string30 middlename := '';
    export string30 lastname := '';

    export string4 namesuffix := '';
    export string50 lname := '';
    export string4 lname4 := '';
    export string3 fname3 := '';
    export string50 lfmname := '';
    export string30 relativefirstname1 := '';
    export string30 relativefirstname2 := '';
    export string30 otherlastname1 := '';

    export boolean phoneticmatch := false;
    export boolean allownicknames := false;
    export boolean CheckNameVariants := false;
    export boolean CleanFMLName := false;
  end;

  export search_address := interface
    export string200 addr := '';
    export string2 st := '';
    export string2 st_orig := '';
    export string2 state := '';
    export string2 otherstate1 := '';
    export string2 otherstate2 := '';
    export string25 city := '';
    export string25 othercity1 := '';
    export string30 county := '';
    export string6 zip := '';
    export string5 z5 := '';
    export string28 prim_name := '';
    export string4 suffix := '';
    export string2 predir := '';
    export string2 postdir := '';
    export string10 prim_range := '';
    export string8 sec_range := '';
    export integer FuzzySecRange := AutoStandardI.Constants.SECRANGE.EXACT;

    export string30 primname := '';
    export string10 primrange := '';
    export string10 secrange := '';
    export unsigned2 zipradius := 0;
    export string50 statecityzip := '';
    export unsigned1 addr_origin_country := 0; //TODO: address.Components.Country.US;
  end;

  export search_company := interface
    export string11 fein := '';
    export string120 cn := '';
    export string120 company := '';
    export string120 companyname := '';
  end;

// TODO: categorize all others as well
export all_others:= interface
  export boolean UseSSNFallBack := false;
  export boolean SearchAroundAddress := false;
  export boolean isFCRAval := false;
  export unsigned2 penalty_threshold := 20;

  export boolean useGlobalScope := true;
  export boolean isPrimRangePriority :=  false; //'P' in set_options;
  export boolean isPRP := false;
  export string350 corpname := '';
  export string50 ucc_key := '';
  export string50 event_key := '';
  export string50 orig_filing_num := '';
  export string50 file_state := '';
  export string50 street_name := '';
  export string50 dl_number := '';
  export string1 partytype := '';
  export boolean includemultiplesecured := false;
  export boolean returnrolleddebtors := false;
  export boolean nodeepdive := false;
  export unsigned1 bankruptcyversion := 0;
  export unsigned1 uccversion := 0;
  export unsigned1 judgmentlienversion := 0;
  export unsigned1 vehicleversion := 0;
  export unsigned1 voterversion := 0;
  export unsigned1 dlversion := 0;
  export unsigned1 deaversion := 0;
  export unsigned1 propertyversion := 0;
  export string11 ssn := '';
  export string14 did := '';
  export string14 rid := '';
  export boolean currentresidentsonly := false;
  export string15 phone := '';
  export string50 driverslicense := '';
  export string30 vin := '';
  export string20 tag := '';
  export boolean ssntypos := false;
  export boolean household := false;
  export boolean includealldidrecords := false;
  export boolean didonly := false;
  export boolean raw := false;
  export unsigned8 dob := 0;
  export unsigned8 dod := 0;
  export unsigned8 maxresults := 2000;
  export unsigned8 maxresultsthistime := 2000;
  export unsigned8 skiprecords := 0;
  export boolean donotfillblanks := false;
  export string100 seisintadlservice := '';
  export boolean isaneighbor := false;
  export set of string256 neighborservice := [];
  //export dataset(doxie.layout_neighbors) neighbordata := dataset([],doxie.layout_neighbors);
  export boolean report := false;
  export unsigned1 setrepaddrbit := 4;
  export boolean setrepaddr := false;
  export string10 lookuptype := '';
  export boolean latestformas := false;
  export boolean simplifiedcontactreturn := false;
  export boolean excludelessors := false;
  export boolean moxievehicles := false;
  export string8 DidTypeMask := '11111111';
  export boolean isCRS := false;
  export unsigned1 scorethreshold := 10;
  export string6 ssnmask := 'NONE';
  export unsigned1 dlmask := 0;
  export string5 industryclass := '';
  export boolean probationoverride := false;
  export boolean lnbranded := false;
  export boolean nonexclusion := false;
  export boolean searchgoodssnonly := false;
  export boolean searchignoresaddressonly := false;
  export string1 race := '';
  export string1 gender := '';
  export string8 recordbydate := '';
  export boolean useonlybestdid := false;
  export boolean isprofilesearch := false;
  export unsigned dialrecordmatch := 0;
  export unsigned dialcontactprecision := 4;
  export unsigned dialbouncedistance := 1;
  export boolean includezerodidrefs := false;
  export boolean getbdidsbyexecutive := true;
  export boolean usehigherlimit := false;
  export string50 tmsid := '';
  export string101 rmsid := '';
  export string50 liencasenumber := '';
  export string25 irsserialnumber := '';
  export string25 casenumber := '';
  export string50 filingnumber := '';
  export string20 filingjurisdiction := '';
  export string20 filingdatebegin := '';
  export string20 filingdateend := '';
  export string20 dunsnumber := '';
  export string16 statedeathid := '';
  export boolean phoneticdistancematch := false;
  export unsigned1 distancethreshold := 3;
  export unsigned datefirstseen := 0;
  export unsigned datelastseen := 0;
  export boolean allowdateseen := false;
  export boolean allowwildcard := if(thorlib.getenv('AllowWildcard','Default')='1',
                                   true, false);
  export boolean reduceddata := false;
  //export boolean isFCRAval := isFCRA;
  export string bdid := '';
  export boolean exactonly := false;
  export boolean bdidonly := false;
  export unsigned2 mileradius := 0;
  export boolean uselevels := false;
  export boolean useSupergroup := false;
  export boolean usesupergrouppropertyaddress := true;
  export boolean disregardlimits := false;
  export boolean isDayBR := false;
  export boolean SelectIndividually := false;
  export boolean AlwaysCompute := false;
  export boolean Include_Bus_DPPA := false;
  export boolean IncludeNameVariations := false;
  export boolean IncludeAddressVariations := false;  
  export boolean IncludeBusinessesAtAddress := false;  
  export boolean IncludeBusinessFilings := false;   
  export boolean IncludeBankruptcies := false;
  export boolean IncludeBankruptciesV2 := false;
  export boolean IncludeProperties := false; 
  export boolean IncludePropertiesV2 := false; 
  export boolean IncludeLiensJudgments := false; 
  export boolean IncludeLiensJudgmentsV2 := false; 
  export boolean IncludeLiens := false;
  export boolean IncludeJudgments := false;
  export boolean IncludeMotorVehicles := false;  
  export boolean IncludeMotorVehiclesV2 := false;
  export boolean IncludeWatercrafts := false;
  export boolean IncludeAircrafts := false;
  export boolean IncludeCorporationFilings := false;        
  export boolean IncludeCorporationFilingsV2 := false;        
  export boolean IncludeBusinessRegistrations := false; 
  export boolean IncludeUCCFilings := false; 
  export boolean IncludeUCCFilingsV2 := false; 
  export boolean IncludeDunBradstreetRecords := false; 
  export boolean IncludeAssociatedBusinesses := false;      
  export boolean IncludeAssociatedPeople := false;
  export boolean IncludeReversePhone := false;
  export boolean IncludeYellowPages := false;
  export boolean IncludeProfessionalLicenses := false;
  export boolean IncludeFeinVariations := false;
  export boolean IncludeCompanyIDnumbers := false;
  export boolean IncludeCompanyIDnumbersV2 := false;
  export boolean IncludeParentChild := false;
  export boolean IncludeHRI := false;
  export boolean IncludePatriotAct := false;
  export boolean IncludeCompanyProfile := false;
  export boolean IncludeCompanyProfileV2 := false;
  export boolean IncludeInternetDomains := false;
  export boolean IncludePhoneVariations := false;
  export boolean IncludeExecutives := false;
  export boolean IncludeDCA := false;
  export boolean IncludeBBB := false;
  export boolean IncludeSales := false;
  export boolean IncludeIndustryInformation := false;
  export boolean IncludeFinder := false;
  export boolean IncludeLiensJudgmentsUCC := false;
  export boolean IncludeLiensJudgmentsUCCV2 := false;
  export boolean IncludeParentCompany := false;
  export boolean IncludeRegisteredAgents := false;
  export boolean IncludeRegisteredAgentsV2 := false;
  export boolean IncludeSuperiorLiens := false;
  export boolean IncludeBusinessAssociates := false;
  export boolean IncludeEBRHeader := false;
  export boolean IncludeEBRSummary := false;
  export boolean IncludeExperianBusinessReports := false;
  export boolean IncludeIRS5500 := false;
  export boolean IncludeIRSNonP := false;
  export boolean IncludeFDIC := false        ;
  export boolean IncludeBBBMember := false   ;
  export boolean IncludeBBBNonMember := false;
  export boolean IncludeCASalesTax := false  ;
  export boolean IncludeIASalesTax := false  ;
  export boolean IncludeMSWorkComp := false  ;
  export boolean IncludeORWorkComp := false  ;
  export string SourceIdName := '';
  export string SourceIdAddr := '';
  export string SourceIdPhone := '';
  export string SourceIdFein := '';
  export unsigned MaxBusinessesAtAddress := 50;
  export unsigned MaxProfessionalLicenses := 50;
  export unsigned MaxAssociatedBusinesses := 100;
  export unsigned MaxAssociatedPeople := 100;
  export unsigned MaxNameVariations := 50;
  export unsigned MaxPhoneVariations := 50;
  export unsigned MaxAddressVariations := 50;
  export unsigned MaxCorporationFilings := 50;
  export unsigned MaxUCCFilings := 50;
  export unsigned MaxLiens := 50;
  export unsigned MaxJudgments := 50;
  export unsigned MaxMotorVehicles := 50; // GCL - 20051026
  export unsigned MaxWatercrafts := 50; // GCL - 20051026
  export unsigned MaxInternetDomains := 50;
  export unsigned MaxBankruptcies := 50;
  export unsigned MaxBankruptciesV2 := 50;
  export unsigned MaxBusinessRegistrations := 50;
  export unsigned MaxProperties := 50;
  export unsigned MaxPropertiesV2 := 50;
  export unsigned MaxReverseLookup := 50;
  export unsigned MaxExecutives := 50;
  export unsigned MaxDCA := 50;
  export unsigned MaxYellowPages := 50;
  export unsigned MaxPatriotAct := 50;
  export unsigned MaxBBB := 50;
  export unsigned MaxSales := 50;
  export unsigned MaxIndustryInformation := 50;
  export unsigned MaxFinder := 50;
  export unsigned MaxLiensJudgmentsUCC := 50;
  export unsigned MaxLiensJudgmentsUCCV2 := 50;
  export unsigned MaxParentCompany := 50;  
  export unsigned MaxRegisteredAgents := 50;
  export unsigned MaxCompanyIDnumbers := 50;
  export unsigned MaxBusinessAssociates := 100;
  export unsigned MaxEBRHeader := 50;
  export unsigned MaxEBRSummary := 50;
  export unsigned MaxExperianBusinessReports := 25;
  export unsigned MaxIRS5500 := 50;
  export unsigned MaxIRSNonP := 50;
  export unsigned MaxFDIC         := 50;
  export unsigned MaxBBBMember    := 50;
  export unsigned MaxBBBNonMember := 50;
  export unsigned MaxCASalesTax   := 50;
  export unsigned MaxIASalesTax   := 50;
  export unsigned MaxMSWorkComp   := 50;
  export unsigned MaxORWorkComp   := 50;
  export unsigned MaxMotorVehicle := 50;
  export boolean KeepOldSsns := false;
  export boolean UsingKeepSSNs := false;
  export boolean ExcludeCheckSufficientInputs := false;
  export boolean AllowLeadingLname := false;
  export string6 PostalCode := '';
  export boolean OnlyExactMatches := false;
  export boolean StrictMatch := false;
  export boolean BPSLeadingNameMatch := false;
end;

  // this is for the use when you don't care about search input, just need some defaults...
  export dummy_search := INTERFACE (permissions, include,
                                    search_name, search_address, search_company,
                                    all_others)
    export unsigned1 agelow := 0;
    export unsigned1 agehigh := 0;
  end;

END;
