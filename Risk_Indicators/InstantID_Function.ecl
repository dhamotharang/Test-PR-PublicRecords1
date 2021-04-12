﻿import iesp, _Control, Gateway, Risk_Indicators, doxie;

USE_LIBRARY := not _Control.LibraryUse.ForceOff_Risk_Indicators__LIB_InstantID_Function;



export InstantID_Function(DATASET(risk_indicators.layout_input) indata1, dataset(Gateway.Layouts.Config) gateways,
                          unsigned1 in_dppa, unsigned1 in_glb,
                          boolean in_isUtility=false, boolean in_ln_branded,
                          boolean in_ofac_only=true,
                          BOOLEAN in_suppressNearDups=false, boolean in_require2Ele=false,
                          boolean in_from_BIID = false, boolean in_isFCRA = false, boolean in_ExcludeWatchLists = false, boolean in_from_IT1O=false,
                          unsigned1 in_ofac_version =1,boolean in_include_ofac = FALSE, boolean in_include_additional_watchlists =false,
                          real in_global_watchlist_threshold =.84,integer2 in_dob_radius = -1, unsigned1 in_BSversion=1,
                          boolean in_runSSNCodes=true, boolean in_runBestAddrCheck=true, boolean in_runChronoPhoneLookup=true,	boolean in_runAreaCodeSplitSearch=true,
                          boolean in_allowCellphones=false,
                          string10 in_ExactMatchLevel=risk_indicators.iid_constants.default_ExactMatchLevel,
                          string50 in_DataRestriction=risk_indicators.iid_constants.default_DataRestriction,
                          string10 in_CustomDataFilter='',
                          boolean in_runDLverification=false,
                          dataset(iesp.share.t_StringArrayItem) watchlists_requested=dataset([], iesp.share.t_StringArrayItem),
                          dataset(risk_indicators.layouts.Layout_DOB_Match_Options) DOBMatchOptions=dataset([], risk_indicators.layouts.layout_dob_match_options),
                          unsigned2 in_EverOccupant_PastMonths = 0,
                          unsigned4 in_EverOccupant_StartDate = 99999999,
                          unsigned1 in_append_best=0,
                          unsigned8 in_BSOptions = 0,
                          unsigned3 in_LastSeenThreshold = risk_indicators.iid_constants.oneyear,
                          string20 in_CompanyID = '',
                          string50 in_DataPermission=risk_indicators.iid_constants.default_DataPermission,
                          boolean in_IncludeNAPData = false,
                          string100 in_IntendedPurpose = '',
                          unsigned1 LexIdSourceOptout = 1,
                          string TransactionID = '',
                          string BatchUID = '',
                          unsigned6 GlobalCompanyId = 0,
                          string5 in_industryClass = ''
													) :=
FUNCTION

// if they are not on already, force on the InstantID enhancement options for nonfcra shell 50 and higher
in_BSOptions_override := if(in_bsversion >= 50 and in_isFCRA=false,
(if(Risk_Indicators.iid_constants.CheckBSOptionFlag(Risk_Indicators.iid_constants.BSOptions.IncludeInsNAP, in_BSOptions), 0, risk_indicators.iid_constants.BSOptions.IncludeInsNAP) +
 if(Risk_Indicators.iid_constants.CheckBSOptionFlag(Risk_Indicators.iid_constants.BSOptions.IsInstantIDv1, in_BSOptions), 0, risk_indicators.iid_constants.BSOptions.IsInstantIDv1) +
 if(Risk_Indicators.iid_constants.CheckBSOptionFlag(Risk_Indicators.iid_constants.BSOptions.IncludeInquiries, in_BSOptions), 0,
		if(in_DataRestriction[risk_indicators.iid_constants.posInquiriesRestriction]<>risk_indicators.iid_constants.sTrue , risk_indicators.iid_constants.BSOptions.IncludeInquiries, 0)
		))  +
 in_BSOptions,
 in_BSOptions);

// for batch queries, dedup the input to reduce searching
indata := dedup(sort(indata1,
	historydate, fname, mname, lname, suffix, ssn, dob, phone10, wphone10, in_streetAddress, in_city, in_state, in_zipcode, dl_number, dl_state, email_address, did, seq),
	historydate, fname, mname, lname, suffix, ssn, dob, phone10, wphone10, in_streetAddress, in_city, in_state, in_zipcode, dl_number, dl_state, email_address, did);

seq_map := join( indata1, indata,
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
	transform( {unsigned input_seq, unsigned deduped_seq}, self.input_seq := left.seq, self.deduped_seq := right.seq ), keep(1)/*, ALL*/);


	// Pack arguments
	args := module(risk_indicators.LIBIN)
			export unsigned1 dppa := in_dppa;
			export unsigned1 glb := in_glb;
			export boolean isUtility := in_isUtility;
			export boolean ln_branded := in_ln_branded;
			export boolean ofac_only:= in_ofac_only;
			export boolean suppressNearDups:= in_suppressNearDups;
			export boolean require2Ele:= in_require2Ele;
			export boolean from_BIID := in_from_BIID;
			export boolean ExcludeWatchLists := in_ExcludeWatchLists;
			export boolean from_IT1O:= in_from_IT1O;
			export unsigned1 ofac_version := in_ofac_version;
			export boolean include_ofac := in_include_OFAC;
			export boolean include_additional_watchlists := in_include_additional_watchlists;
			export real global_watchlist_threshold := in_global_watchlist_threshold;
			export integer2 dob_radius := in_dob_radius;
			export unsigned1 BSversion:= in_bsversion;
			export boolean runSSNCodes:= in_runSSNCodes;
			export boolean runBestAddrCheck:= in_runBestAddrCheck;
			export boolean runChronoPhoneLookup:= in_runChronoPhoneLookup;
			export boolean runAreaCodeSplitSearch:= in_runAreaCodeSplitSearch;
			export boolean allowCellphones := in_allowCellphones;
			export string10 ExactMatchLevel := in_ExactMatchLevel;
			export string DataRestrictionMask := in_DataRestriction;
			export string10 CustomDataFilter := in_CustomDataFilter;
			export boolean runDLverification := in_runDLverification;
			export unsigned2 EverOccupant_PastMonths := in_EverOccupant_PastMonths;
			export unsigned4 EverOccupant_StartDate := in_EverOccupant_StartDate;
			export unsigned1 append_best := in_append_best;
			export unsigned8 BSOptions := in_BSOptions_override;
			export unsigned3 LastSeenThreshold := in_LastSeenThreshold;
			export string20 CompanyID := in_CompanyID;
			export string DataPermissionMask := in_DataPermission;
			export boolean IncludeNAPData := in_IncludeNAPData;
			export string100 IntendedPurpose := in_IntendedPurpose;
			export unsigned1 lexid_source_optout := LexIdSourceOptout;
			export string transaction_id := IF (TransactionID != '', TransactionID, BatchUID);
			export unsigned6 global_company_id := GlobalCompanyId;
      export string5 industry_class := in_industryClass;
      export string ssn_mask := '';
		END;

#if(USE_LIBRARY)
	// Call Library
	iid_results := if(in_isFCRA,	library('Risk_Indicators.LIB_InstantID_Function_FCRA', Risk_Indicators.IInstantID_Function(indata, gateways, args, watchlists_requested, DOBMatchOptions)).results,
												library('Risk_Indicators.LIB_InstantID_Function', Risk_Indicators.IInstantID_Function(indata, gateways, args, watchlists_requested, DOBMatchOptions)).results);
#else

  mod_access := PROJECT(args, doxie.IDataAccess, OPT);
  mod_iid := PROJECT (args, risk_indicators.ICommonInstantId);


	base := Risk_Indicators.iid_base_function(indata, gateways, mod_iid, mod_access, in_isFCRA, watchlists_requested, DOBMatchOptions);

	iid_results := base;

#end

	// join the results back to the original input so that every record on input has a response populated
	full_response := join( seq_map, iid_results, left.deduped_seq=right.seq, transform( risk_indicators.layout_output, self.seq := left.input_seq, self := right ), keep(1) );

  valid_full_response := IF(in_isFCRA, full_response, full_response(IF(watchlist_table = 'ERR', ERROR('Bridger Gateway Error'), true)));


// output(	indata1	, named('indata1')	);
// output(	gateways	, named('gateways')	);
// output(	in_dppa	, named('in_dppa')	);
// output(	in_glb	, named('in_glb')	);
// output(	in_isUtility	, named('in_isUtility')	);//5
// output(	in_ln_branded	, named('in_ln_branded')	);
// output(	in_ofac_only	, named('in_ofac_only')	);
// output(	in_suppressNearDups	, named('in_suppressNearDups')	);
// output(	in_require2Ele	, named('in_require2Ele')	);
// output(	in_from_BIID	, named('in_from_BIID')	);//10
// output(	in_isFCRA	, named('in_isFCRA')	);
// output(	in_ExcludeWatchLists	, named('in_ExcludeWatchLists')	);
// output(	in_from_IT1O	, named('in_from_IT1O')	);
// output(	in_ofac_version	, named('in_ofac_version')	);
// output(	in_include_ofac	, named('in_include_ofac')	);//15
// output(	in_include_additional_watchlists	, named('in_include_additional_watchlists')	);
// output(	in_global_watchlist_threshold	, named('in_global_watchlist_threshold')	);
// output(	in_dob_radius	, named('in_dob_radius')	);
// output(	in_BSversion	, named('in_BSversion')	);
// output(	in_runSSNCodes	, named('in_runSSNCodes')	);//20
// output(	in_runBestAddrCheck	, named('in_runBestAddrCheck')	);
// output(	in_runChronoPhoneLookup	, named('in_runChronoPhoneLookup')	);
// output(	in_runAreaCodeSplitSearch	, named('in_runAreaCodeSplitSearch')	);
// output(	in_allowCellphones	, named('in_allowCellphones')	);
// output(	in_ExactMatchLevel	, named('in_ExactMatchLevel')	);//25
// output(	in_DataRestriction	, named('in_DataRestriction')	);
// output(	in_CustomDataFilter	, named('in_CustomDataFilter')	);
// output(	in_runDLverification	, named('in_runDLverification')	);
// output(	in_EverOccupant_PastMonths	, named('in_EverOccupant_PastMonths')	);
// output(	in_EverOccupant_StartDate	, named('in_EverOccupant_StartDate')	);//30
// output(	in_append_best	, named('in_append_best')	);
// output(	in_BSOptions	, named('in_BSOptions')	);
// output(	in_BSOptions_override	, named('in_BSOptions_override')	);
// output(	in_LastSeenThreshold	, named('in_LastSeenThreshold')	);
// output(	in_CompanyID	, named('in_CompanyID')	);
// output(	in_DataPermission	, named('in_DataPermission')	);//35
// output(in_industryClass, named('industryClass_iidFunction'));

	return group(valid_full_response, seq);
END;
