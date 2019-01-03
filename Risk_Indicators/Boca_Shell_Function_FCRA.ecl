import FCRA, Riskwise, _control, Gateway;
onThor := _Control.Environment.OnThor;

USE_BOCA_SHELL_LIBRARY := not _Control.LibraryUse.ForceOff_Risk_Indicators__LIB_Boca_Shell_Function;

export Boca_Shell_Function_FCRA (	DATASET (risk_indicators.Layout_input) pre_iid1, 
																	DATASET (Gateway.Layouts.Config) gateways,
																	unsigned1 dppa,
																	unsigned1 glb,
																	boolean isUtility = false,
																	boolean isLN = false,
																	boolean require2Ele = false,
																	// optimization options
																	boolean includeRelativeInfo = false,
																	boolean includeDLInfo = true,
																	boolean includeVehInfo = true,
																	boolean includeDerogInfo = true,

																	// values now included for completeness of parameter passing
																	BOOLEAN	IN_OFAC_Only = TRUE,
																	BOOLEAN	IN_SuppressNearDups = FALSE,
																	BOOLEAN	IN_From_BIID = FALSE,
																	BOOLEAN	IN_ExcludeWatchLists = FALSE,
																	BOOLEAN	IN_From_IT1O = FALSE,
																	UNSIGNED1	IN_OFAC_Version = 1,
																	BOOLEAN	IN_Include_OFAC = FALSE,
																	BOOLEAN	IN_Include_additional_watchlists = FALSE,
																	REAL		IN_Global_watchlist_threshold = 0.84,
																	UNSIGNED1	IN_BSversion = 1,
																	BOOLEAN	IN_IsPreScreen = false,
																	BOOLEAN IN_doScore = false, boolean nugen = false,
																	boolean ADL_Based_Shell = false,
																	string50 DataRestriction=risk_indicators.iid_constants.default_DataRestriction,
																	unsigned1 IN_AppendBest=0,
																	unsigned8 BSOptions=0,
																	string50 DataPermission=risk_indicators.iid_constants.default_DataPermission,
																	BOOLEAN	IN_isDirectToConsumer = false,
																	BOOLEAN IncludeLnJ = false,
                 integer2 ReportingPeriod = 84,
                 string100 IntendedPurpose = ''
                 ) := FUNCTION

// for batch queries, dedup the input to reduce searching
pre_iid := dedup(sort(pre_iid1, 
	historydate, fname, mname, lname, suffix, ssn, dob, phone10, wphone10, in_streetAddress, in_city, in_state, in_zipcode, dl_number, dl_state, email_address, did, seq),
	historydate, fname, mname, lname, suffix, ssn, dob, phone10, wphone10, in_streetAddress, in_city, in_state, in_zipcode, dl_number, dl_state, email_address, did);

seq_map := join( pre_iid1, pre_iid,
	left.historydate=right.historydate
		and left.fname=right.fname
		and left.mname=right.mname
		and left.lname=right.lname
		and left.suffix=right.suffix
		and left.ssn=right.ssn
		and left.dob=right.dob
		and left.phone10=right.phone10
		and left.wphone10=right.wphone10
		and left.in_streetAddress=right.in_streetAddress
		and left.in_city=right.in_city
		and left.in_state=right.in_state
		and left.in_zipcode=right.in_zipcode
		and left.dl_number=right.dl_number
		and left.dl_state=right.dl_state
		and left.email_address=right.email_address
		and left.did=right.did,
	transform( {unsigned input_seq, unsigned deduped_seq}, self.input_seq := left.seq, self.deduped_seq := right.seq ), keep(1) );
  

#if(USE_BOCA_SHELL_LIBRARY)
	args := MODULE(BS_LIBIN)
			export unsigned1 bs_dppa     := dppa;
			export unsigned1 bs_glb      := glb;
			export boolean bs_isUtility  := isUtility;
			export boolean bs_isLN       := isLN;

			// optimization options
			export boolean bs_includeRelativeInfo := includeRelativeInfo;
			export boolean bs_includeDLInfo       := includeDLInfo;
			export boolean bs_includeVehInfo      := includeVehInfo;
			export boolean bs_includeDerogInfo    := includeDerogInfo;
			export unsigned1 bs_BSversion         := in_BSversion;
			export boolean bs_doScore             := in_doScore;
			export boolean bs_nugen               := nugen;
			export string50 bs_DataRestriction    := DataRestriction;
			export string50 bs_DataPermission    	:= DataPermission;
			export unsigned8 bs_BSOptions         := BSOptions;
			export unsigned1 bs_AppendBest        := in_AppendBest;
			export boolean bs_IsPreScreen         := IN_IsPreScreen;
			export boolean bs_ADL_Based_Shell     := ADL_Based_Shell;

			export boolean bs_require2Ele                   := require2Ele;
			export boolean bs_OFAC_Only                     := IN_OFAC_Only;
			export boolean bs_SuppressNearDups              := IN_SuppressNearDups;
			export boolean bs_From_BIID                     := IN_From_BIID;
			export boolean bs_ExcludeWatchLists             := IN_ExcludeWatchLists;
			export boolean bs_From_IT1O                     := IN_From_IT1O;
			export unsigned1 bs_OFAC_Version                := IN_OFAC_Version;
			export boolean bs_Include_OFAC                  := IN_Include_OFAC;
			export boolean bs_Include_additional_watchlists := IN_Include_additional_watchlists;
			export real bs_Global_watchlist_threshold       := IN_Global_watchlist_threshold;
			export boolean bs_IsDirectToConsumer						:= IN_isDirectToConsumer;
			export boolean bs_IncludeLnJ										:= IncludeLnJ;
      export integer2 bs_ReportingPeriod := ReportingPeriod; 
      export string100 bs_IntendedPurpose := IntendedPurpose;
	END;

	fcra_shell_results := library('Risk_Indicators.LIB_Boca_Shell_Function_FCRA', Risk_Indicators.IBoca_Shell_Function_FCRA(pre_iid, gateways, args)).results;

#else
	// when running FCRA shell version 4 or higher in prescreen mode for attributes, set append best=2 so we append an SSN to input if it's missing
	append_best := if(IN_BSversion>3 and in_isPrescreen and ADL_Based_Shell=false, 2, IN_AppendBest);
	
	
	//need to put this here so that library corrections can have access to the flag file id
	// noticed that if we append the ssn, it doesnt get appended until later and there will be no corrections for ssn here....... 

// add extra params to boca_shell_fcra_neutral_soapcall
	 ids_result := FCRA.Boca_Shell_FCRA_Neutral_DID_Soapcall (pre_iid, gateways, dppa, glb, 
									 isUtility, isLN, includeRelativeInfo, require2Ele,
									 IN_OFAC_Only, IN_SuppressNearDups, IN_From_BIID, IN_ExcludeWatchLists, IN_From_IT1O,
									 IN_OFAC_Version, IN_Include_OFAC, IN_Include_additional_watchlists, IN_Global_watchlist_threshold,
									 IN_BSversion, nugen, ADL_Based_Shell, DataRestriction, append_best, BSOptions, DataPermission, IntendedPurpose
									 );
		ids_wide_roxie := group(sort(ids_result, seq), seq);
		ids_wide_thor := group(sort(distribute(ids_result, hash64(seq)), seq, LOCAL), seq, LOCAL);
    #IF(onThor)
      ids_wide := ids_wide_thor;
    #ELSE
      ids_wide := ids_wide_roxie;
    #END
  
  p := dedup(group(sort(project(ids_wide(~isrelat), transform (Risk_Indicators.Layout_Boca_Shell, self := LEFT)), seq), seq), seq);

  Risk_Indicators.layout_output into_iid(p le) := transform
		self.seq := le.seq;
		self.socllowissue := (string)le.SSN_Verification.Validation.low_issue_date;
		self.soclhighissue := (string)le.SSN_Verification.Validation.high_issue_date;
		self.socsverlevel := le.iid.NAS_summary;
		self := le.iid;
		self := le.shell_input;
		self := le;
		self := [];
  end;
  iid := project(p, into_iid(LEFT));

  dppa_ok := dppa > 0 and dppa < 8;
  //NB: DL is not used in FCRA-dependent scoring
  per_prop := Risk_Indicators.getAllBocaShellData (iid, group(sort(project(ids_wide, transform(Risk_Indicators.layout_bocashell_neutral, self.age := 0, self := left, self := [])),seq),seq), p,
                                   TRUE, isLN, dppa, dppa_ok,
                                   includeRelativeInfo, /*includeDLInfo*/ FALSE, includeVehInfo, includeDerogInfo,
							IN_BSversion, IN_IsPreScreen, IN_doScore,
							true,  // filter out fares always true in FCRA
							DataRestriction,
							BSOptions, glb, gateways, DataPermission, IN_isDirectToConsumer, 
							IncludeLnJ, ReportingPeriod, adl_based_shell

       );


  fcra_shell_results := per_prop;
#end

// join the results back to the original input so that every record on input has a response populated
full_response := join( seq_map, fcra_shell_results, left.deduped_seq=right.seq, transform( Risk_Indicators.Layout_Boca_Shell, self.seq := left.input_seq, self.shell_input.seq := left.input_seq, self := right ), keep(1) );
return group(full_response, seq);
END;