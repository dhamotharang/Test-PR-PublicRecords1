/*--LIBRARY--*/

import fcra, gateway;

EXPORT LIB_Boca_Shell_Function_FCRA (
	DATASET (Layout_input) pre_iid,
	DATASET (Gateway.Layouts.Config) gateways,
	BS_LIBIN args
	) := MODULE
	
	dppa := args.bs_dppa;
	glb := args.bs_glb;
	isUtility := args.bs_isUtility;
	isLN := args.bs_isLN;
	includeRelativeInfo := false;// args.bs_includeRelativeInfo;
	includeDLInfo := args.bs_includeDLInfo;
	includeVehInfo := args.bs_includeVehInfo;
	includeDerogInfo := args.bs_includeDerogInfo;
	IN_BSversion := args.bs_BSversion;
	doScore := args.bs_doScore;
	nugen := args.bs_nugen;
	filter_out_fares := args.bs_filter_out_fares;
	DataRestriction := args.bs_DataRestriction;
	DataPermission := args.bs_DataPermission;
	BSOptions := args.bs_BSOptions;
	in_isPrescreen := args.bs_isprescreen;
	ADL_Based_Shell := args.bs_ADL_Based_Shell;
	IN_AppendBest := args.bs_AppendBest;
	require2Ele := args.bs_require2Ele;
	in_ofac_only := args.bs_ofac_only;
	in_suppressneardups := args.bs_suppressneardups;
	in_from_biid := args.bs_from_biid;
	in_excludewatchlists := args.bs_excludewatchlists;
	in_from_it1o := args.bs_from_it1o;
	in_ofac_version := args.bs_ofac_version;
	in_include_ofac := args.bs_include_ofac;
	in_include_additional_watchlists := args.bs_include_additional_watchlists;
	in_global_watchlist_threshold := args.bs_global_watchlist_threshold;
	IN_doScore := args.bs_doScore;
	IN_isDirectToConsumerPurpose := args.IN_isDirectToConsumer;
	IncludeLnJ := args.bs_IncludeLnJ;
 in_ReportingPeriod := args.bs_ReportingPeriod;


	// when running FCRA shell version 4 or higher in prescreen mode for attributes, set append best=2 so we append an SSN to input if it's missing
	append_best := if(IN_BSversion>3 and in_isPrescreen and ADL_Based_Shell=false, 2, IN_AppendBest);
	
	
	//need to put this here so that library corrections can have access to the flag file id
	// noticed that if we append the ssn, it doesnt get appended until later and there will be no corrections for ssn here....... 

// add extra params to boca_shell_fcra_neutral_soapcall
  ids_wide := group(sort(
    FCRA.Boca_Shell_FCRA_Neutral_DID_Soapcall (pre_iid, gateways, dppa, glb, 
									isUtility, isLN, includeRelativeInfo, require2Ele,
									IN_OFAC_Only, IN_SuppressNearDups, IN_From_BIID, IN_ExcludeWatchLists, IN_From_IT1O,
									IN_OFAC_Version, IN_Include_OFAC, IN_Include_additional_watchlists, IN_Global_watchlist_threshold,
									IN_BSversion, nugen, ADL_Based_Shell, DataRestriction, append_best, BSOptions, DataPermission
									)
	, seq), seq);


  p := dedup(group(sort(project(ids_wide(~isrelat), transform (Layout_Boca_Shell, self := LEFT)), seq), seq), seq);

  layout_output into_iid(p le) := transform
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
  per_prop := getAllBocaShellData (iid, group(sort(project(ids_wide, transform(layout_bocashell_neutral, self.age := 0, self := left, self := [])),seq),seq), p,
                                   TRUE, isLN, dppa, dppa_ok,
                                   includeRelativeInfo, /*includeDLInfo*/ FALSE, includeVehInfo, includeDerogInfo,
							IN_BSversion, IN_IsPreScreen, IN_doScore,
							true,  // filter out fares always true in FCRA
							DataRestriction,
							BSOptions, glb, gateways, DataPermission, 
							IN_isDirectToConsumerPurpose, IncludeLnJ, in_ReportingPeriod);

	export results := per_prop;
END;