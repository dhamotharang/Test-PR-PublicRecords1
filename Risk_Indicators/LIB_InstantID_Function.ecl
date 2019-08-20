import doxie, ut, DID_Add, address, UtilFile, riskwise, iesp, patriot, gateway;

export LIB_InstantID_Function(DATASET(risk_indicators.layout_input) indata, 
			dataset(Gateway.Layouts.Config) gateways, 
			LIBIN args, 
			dataset(iesp.share.t_StringArrayItem) watchlists_requested,
			dataset(layouts.Layout_DOB_Match_Options) DOBMatchOptions) := 

MODULE

// unpacking args
dppa := args.dppa;
glb := args.glb;  
isUtility := args.isUtility;
ln_branded := args.ln_branded;
// history_date := args.history_date;
ofac_only := args.ofac_only;
suppressNearDups := args.SuppressNearDups;
require2Ele := args.require2Ele;
from_BIID := args.from_BIID;
isFCRA := FALSE; 		// hardcode so that only non-fcra deploys
ExcludeWatchlists := args.ExcludeWatchlists;
from_IT1O := args.from_IT1O;
ofac_version := args.ofac_version;
include_ofac := args.include_ofac;
include_additional_watchlists := args.include_additional_watchlists;
global_watchlist_threshold := args.global_watchlist_threshold;
dob_radius := args.dob_radius;
BSversion := args.BSversion;
runSSNCodes := args.runSSNCodes;
runBestAddrCheck := args.runBestAddrCheck;
runChronoPhoneLookup := args.runChronoPhoneLookup;
runAreaCodeSplitSearch := args.runAreaCodeSplitSearch;
allowCellphones := args.allowCellphones;
ExactMatchLevel := args.ExactMatchLevel;
DataRestriction := args.DataRestriction;
CustomDataFilter := args.CustomDataFilter;
runDLverification := args.runDLverification;
EverOccupant_PastMonths := args.EverOccupant_PastMonths;
EverOccupant_StartDate  := args.EverOccupant_StartDate;
append_best := args.append_best;
BSOptions := args.BSOptions;
LastSeenThreshold := args.LastSeenThreshold;
companyID := args.companyID;
DataPermission := args.DataPermission;
IncludeNAPData := args.IncludeNAPData;

// step 1.  Get the DID and prep the layout_output dataset
with_DID := risk_indicators.iid_getDID_prepOutput(indata, dppa, glb, isFCRA, BSversion, DataRestriction, 
				append_best, gateways, BSOptions);

commonstart := risk_indicators.iid_common_function(with_did, dppa, glb, isUtility, ln_branded,
															suppressNearDups, isFCRA, bsversion,
															runSSNCodes, runBestAddrCheck, ExactMatchLevel, DataRestriction, CustomDataFilter,
															DOBMatchOptions, EverOccupant_PastMonths, EverOccupant_StartDate, BSOptions, LastSeenThreshold, 
															DataPermission);
															
common_transformed := risk_indicators.iid_transform_common(commonstart, BSOptions);

// one of the optimization options in IID v2 is to allow this search to be skipped when not needed.
with_chrono_phones := risk_indicators.iid_getChronologyPhones(common_transformed, from_IT1O, ExactMatchLevel, isFCRA, BSOptions, glb);
eqfsphones := if(runChronoPhoneLookup, with_chrono_phones, common_transformed);

gotWatch := map(isFCRA or // don't search watchlist files for FCRA products anymore
								(ofac_version=1 and ExcludeWatchLists) or 
								(ofac_version>1 and Include_Ofac=FALSE and Include_Additional_Watchlists=FALSE and count(watchlists_requested)=0) => eqfsphones, 
								gateways(servicename='attus')[1].url!='' 	=> getAttus(eqfsphones, gateways, dppa, glb), 
								// ofac_version=4 => call the new Watchlist ESP service
								risk_indicators.getWatchLists2(eqfsphones,ofac_only, from_BIID,ofac_version,include_ofac,
								include_additional_watchlists,global_watchlist_threshold,dob_radius, watchlists_requested, gateways));


with_flags := risk_indicators.iid_getPhoneAddrFlags(with_did, isFCRA, runAreaCodeSplitSearch, BSversion);							
with_addrs := risk_indicators.iid_getAddressInfo(with_flags, glb, isFCRA, require2ele, BSversion, isUtility, 
		ExactMatchLevel, LastSeenThreshold, BSOptions);					

with_nap := risk_indicators.iid_getPhoneInfo(with_addrs, gateways, dppa, glb, isFCRA, require2ele, BSversion, 
allowCellphones, ExactMatchLevel, LastSeenThreshold, BSOptions,
		companyID,EverOccupant_PastMonths, EverOccupant_StartDate, IncludeNAPData);

combined_verification := risk_indicators.iid_combine_verification(gotWatch, with_nap, from_IT1O, 
		ExactMatchLevel, isFCRA, BSOptions, bsversion, DataPermission, DataRestriction);

dlverify := risk_indicators.iid_DL_verification(combined_verification, dppa, isfcra, ExactMatchLevel, BSOptions, DataPermission, bsversion);
with_DL_verification := if(runDLverification, dlverify, combined_verification);

runThreatMetrix := (BSOptions & risk_indicators.iid_constants.BSOptions.runThreatMetrix) > 0;

with_ThreatMetrix := if(runThreatMetrix, 
	risk_indicators.iid_append_threatMetrix(indata, with_dl_verification, gateways, companyID), 
	with_dl_verification);
	
export results := with_ThreatMetrix;

END;
