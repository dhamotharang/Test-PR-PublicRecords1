/*--LIBRARY--*/

import iesp, fcra, gateway, risk_indicators;

export LIB_InstantID_Function_FCRA(DATASET(risk_indicators.layout_input) indata, 
			dataset(Gateway.Layouts.Config) gateways, 
			risk_indicators.LIBIN args, 
			dataset(iesp.share.t_StringArrayItem) watchlists_requested,
			dataset(risk_indicators.layouts.Layout_DOB_Match_Options) DOBMatchOptions) := 

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
isFCRA := TRUE; 	// hardcode this so it only deploys fcra data
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
EverOccupant_PastMonths := args.EverOccupant_PastMonths;
EverOccupant_StartDate  := args.EverOccupant_StartDate;
append_best := args.append_best;
BSOptions := args.BSOptions;
LastSeenThreshold := args.LastSeenThreshold;
companyID := args.companyID;
DataPermission := args.DataPermission;
IntendedPurpose := args.IntendedPurpose;

// step 1.  Get the DID and prep the layout_output dataset
with_DID := risk_indicators.iid_getDID_prepOutput(indata, dppa, glb, isFCRA, BSversion, DataRestriction, append_best, gateways, BSOptions);

with_PersonContext := if(isFCRA, Risk_Indicators.checkPersonContext(with_did, gateways, BSversion, intendedPurpose), with_did);
	  
with_overrides := PROJECT(with_PersonContext, Risk_Indicators.Transforms.add_flags(LEFT));


commonstart := risk_indicators.iid_common_function(with_overrides, dppa, glb, isUtility, ln_branded,
															suppressNearDups, isFCRA, bsversion,
															runSSNCodes, runBestAddrCheck, ExactMatchLevel, DataRestriction, CustomDataFilter,
															DOBMatchOptions, EverOccupant_PastMonths, EverOccupant_StartDate, BSOptions, LastSeenThreshold, DataPermission);
															
common_transformed := risk_indicators.iid_transform_common(commonstart, BSOptions);

// one of the optimization options in IID v2 is to allow this search to be skipped when not needed.
with_chrono_phones := risk_indicators.iid_getChronologyPhones(common_transformed, from_IT1O, ExactMatchLevel, isFCRA, BSOptions, glb);
eqfsphones := if(runChronoPhoneLookup, with_chrono_phones, common_transformed);

with_flags := risk_indicators.iid_getPhoneAddrFlags(with_overrides, isFCRA, runAreaCodeSplitSearch, BSversion);							
with_addrs := risk_indicators.iid_getAddressInfo(with_flags, glb, isFCRA, require2ele, BSversion, isUtility, ExactMatchLevel, LastSeenThreshold, BSOptions);					
with_nap := risk_indicators.iid_getPhoneInfo(with_addrs, gateways, dppa, glb, isFCRA, require2ele, BSversion, allowCellphones, ExactMatchLevel, LastSeenThreshold, BSOptions, companyID,EverOccupant_PastMonths, EverOccupant_StartDate);

combined_verification := risk_indicators.iid_combine_verification(eqfsphones, with_nap, from_IT1O, ExactMatchLevel, isFCRA, BSOptions, bsversion, DataPermission, DataRestriction);


export results := combined_verification;

END;