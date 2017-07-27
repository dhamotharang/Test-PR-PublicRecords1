/*               *********************************************************************************

IMPORTANT NOTE FOR USING THIS ATTRIBUTE....
DOUBLE CHECK THAT THE InstantID_Function AND Boca_Shell_Function HAVE NOT BEEN MODIFIED SINCE THE LAST TIME THIS DEBUG ATTRIBUTE WAS CHECKED IN

**************************************************************************************************/

import iesp,_Control,Gateway;

EXPORT debug_function_options := module


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
													string10 in_ExactMatchLevel=iid_constants.default_ExactMatchLevel,
													string50 in_DataRestriction=iid_constants.default_DataRestriction,
													string10 in_CustomDataFilter='',
													boolean in_runDLverification=false,
													dataset(iesp.share.t_StringArrayItem) watchlists_requested=dataset([], iesp.share.t_StringArrayItem),
													dataset(layouts.Layout_DOB_Match_Options) DOBMatchOptions=dataset([], layouts.layout_dob_match_options),													
													unsigned2 in_EverOccupant_PastMonths = 0,
													unsigned4 in_EverOccupant_StartDate = 99999999,
													unsigned1 in_append_best=0, 
													unsigned8 in_BSOptions = 0,
													unsigned3 in_LastSeenThreshold = iid_constants.oneyear,
													string20 in_CompanyID = '',
													string50 in_DataPermission=iid_constants.default_DataPermission
													) :=
FUNCTION

// force on the InstantID enhancement options for nonfcra shell 50 and higher
in_BSOptions_override := if(in_bsversion >= 50 and in_isFCRA=false, 
(risk_indicators.iid_constants.BSOptions.IncludeInsNAP + 
risk_indicators.iid_constants.BSOptions.IsInstantIDv1 + 
risk_indicators.iid_constants.BSOptions.IncludeInquiries)  +
in_BSOptions,
in_BSOptions);

output(	indata1	, named('indata1')	);
output(	gateways	, named('gateways')	);
output(	in_dppa	, named('in_dppa')	);
output(	in_glb	, named('in_glb')	);
output(	in_isUtility	, named('in_isUtility')	);//5
output(	in_ln_branded	, named('in_ln_branded')	);
output(	in_ofac_only	, named('in_ofac_only')	);
output(	in_suppressNearDups	, named('in_suppressNearDups')	);
output(	in_require2Ele	, named('in_require2Ele')	);
output(	in_from_BIID	, named('in_from_BIID')	);//10  
output(	in_isFCRA	, named('in_isFCRA')	);
output(	in_ExcludeWatchLists	, named('in_ExcludeWatchLists')	);
output(	in_from_IT1O	, named('in_from_IT1O')	);
output(	in_ofac_version	, named('in_ofac_version')	);
output(	in_include_ofac	, named('in_include_ofac')	);//15
output(	in_include_additional_watchlists	, named('in_include_additional_watchlists')	);
output(	in_global_watchlist_threshold	, named('in_global_watchlist_threshold')	);
output(	in_dob_radius	, named('in_dob_radius')	);
output(	in_BSversion	, named('in_BSversion')	);
output(	in_runSSNCodes	, named('in_runSSNCodes')	);//20
output(	in_runBestAddrCheck	, named('in_runBestAddrCheck')	); 
output(	in_runChronoPhoneLookup	, named('in_runChronoPhoneLookup')	);
output(	in_runAreaCodeSplitSearch	, named('in_runAreaCodeSplitSearch')	);
output(	in_allowCellphones	, named('in_allowCellphones')	);
output(	in_ExactMatchLevel	, named('in_ExactMatchLevel')	);//25
output(	in_DataRestriction	, named('in_DataRestriction')	);
output(	in_CustomDataFilter	, named('in_CustomDataFilter')	);
output(	in_runDLverification	, named('in_runDLverification')	);
output(	in_EverOccupant_PastMonths	, named('in_EverOccupant_PastMonths')	);
output(	in_EverOccupant_StartDate	, named('in_EverOccupant_StartDate')	);//30
output(	in_append_best	, named('in_append_best')	);
output(	in_BSOptions	, named('in_BSOptions')	);
output(	in_BSOptions_override	, named('in_BSOptions_override')	);
output(	in_LastSeenThreshold	, named('in_LastSeenThreshold')	);
output(	in_CompanyID	, named('in_CompanyID')	);
output(	in_DataPermission	, named('in_DataPermission')	);

// output(	in_, named('in_')	);

	temp_response := group(project(indata1, transform(risk_indicators.Layout_Output, self := left, self := [])), seq);
	
	return temp_response;
END;  // end of InstantID_Function





EXPORT Boca_Shell_Function (GROUPED DATASET (Layout_output) iid1,
                            DATASET (Gateway.Layouts.Config) gateways,
                            unsigned1 dppa, unsigned1 glb, boolean isUtility=false, boolean isLN=false,

                            // optimization options
                            boolean includeRelativeInfo=true, boolean includeDLInfo=true,
                            boolean includeVehInfo=true, boolean includeDerogInfo=true, unsigned1 BSversion=1,
														boolean doScore=false, boolean nugen = false, boolean filter_out_fares = false,
														string50 DataRestriction=iid_constants.default_DataRestriction,
														unsigned8 BSOptions = 0,
														string50 DataPermission=iid_constants.default_DataPermission) :=  
FUNCTION


output(	iid1	, named('bs_iid1')	);
output(	gateways	, named('bs_gateways')	);
output(	dppa	, named('bs_dppa')	);
output(	glb	, named('bs_glb')	);
output(	isUtility	, named('bs_isUtility')	);
output(	isLN	, named('bs_isLN')	);
output(	includeRelativeInfo	, named('bs_includeRelativeInfo')	);
output(includeDLInfo		, named('bs_includeDLInfo')	);
output(includeVehInfo		, named('bs_includeVehInfo')	);
output(includeDerogInfo		, named('bs_includeDerogInfo')	);
output(BSversion		, named('bs_BSversion')	);
output(doScore		, named('bs_doScore')	);
output(nugen		, named('bs_nugen')	);
output(filter_out_fares		, named('bs_filter_out_fares')	);
output(DataRestriction		, named('bs_DataRestriction')	);
output(BSOptions		, named('bs_BSOptions')	);
output(DataPermission		, named('bs_DataPermission')	);

// output(		, named('bs_')	);


temp_response := group(project(iid1, transform(risk_indicators.Layout_Boca_Shell, self := left, self := [])), seq);

return temp_response;
  
END;  // end of boca_shell_function





end;  // end of module
