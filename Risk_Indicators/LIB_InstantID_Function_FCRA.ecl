/*--LIBRARY--*/

import iesp, gateway, risk_indicators, doxie;

export LIB_InstantID_Function_FCRA(DATASET(risk_indicators.layout_input) indata,
			dataset(Gateway.Layouts.Config) gateways,
			risk_indicators.LIBIN args,
			dataset(iesp.share.t_StringArrayItem) watchlists_requested,
			dataset(risk_indicators.layouts.Layout_DOB_Match_Options) DOBMatchOptions) :=

MODULE

isFCRA := TRUE; 	// hardcode this so it only deploys fcra data


// unpacking args
dppa := args.dppa;
glb := args.glb;
isUtility := args.isUtility;
suppressNearDups := args.SuppressNearDups;
require2Ele := args.require2Ele;
from_IT1O := args.from_IT1O;
BSversion := args.BSversion;
runBestAddrCheck := args.runBestAddrCheck;
runChronoPhoneLookup := args.runChronoPhoneLookup;
runAreaCodeSplitSearch := args.runAreaCodeSplitSearch;
allowCellphones := args.allowCellphones;
ExactMatchLevel := args.ExactMatchLevel;
DataRestriction := args.DataRestrictionMask;
CustomDataFilter := args.CustomDataFilter;
EverOccupant_PastMonths := args.EverOccupant_PastMonths;
EverOccupant_StartDate  := args.EverOccupant_StartDate;
append_best := args.append_best;
BSOptions := args.BSOptions;
LastSeenThreshold := args.LastSeenThreshold;
companyID := args.companyID;
DataPermission := args.DataPermissionMask;
IntendedPurpose := args.IntendedPurpose;

mod_access := PROJECT(args, Doxie.IDataAccess, OPT);

// step 1.  Get the DID and prep the layout_output dataset
with_DID := risk_indicators.iid_getDID_prepOutput(indata, dppa, glb, isFCRA, BSversion, DataRestriction, append_best, gateways, BSOptions);

with_PersonContext := if(isFCRA, Risk_Indicators.checkPersonContext(with_did, gateways, BSversion, intendedPurpose), with_did);

with_overrides := PROJECT(with_PersonContext, Risk_Indicators.Transforms.add_flags(LEFT));

mod_iid := PROJECT (args, risk_indicators.ICommonInstantId);
commonstart := risk_indicators.iid_common_function(with_overrides, mod_iid, mod_access, isFCRA, DOBMatchOptions);

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
