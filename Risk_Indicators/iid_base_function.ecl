import _Control, iesp, gateway, risk_indicators, Doxie;
onThor := _Control.Environment.OnThor;

export iid_base_function(DATASET(risk_indicators.layout_input) indata,
                         dataset(Gateway.Layouts.Config) gateways,
                         Risk_Indicators.ICommonInstantId mod_iid,
                         doxie.IDataAccess mod_access,
                         boolean isFCRA,
													dataset(iesp.share.t_StringArrayItem) watchlists_requested,
													dataset(Risk_Indicators.layouts.Layout_DOB_Match_Options) DOBMatchOptions
													) := FUNCTION

BSOptions := mod_iid.BSOptions;
BSversion := mod_iid.BSversion;
append_best := mod_iid.append_best;
IntendedPurpose := mod_iid.IntendedPurpose;
runChronoPhoneLookup := mod_iid.runChronoPhoneLookup;
ofac_only := mod_iid.ofac_only;
ofac_version := mod_iid.ofac_version;
include_ofac := mod_iid.include_ofac;
Include_Additional_Watchlists := mod_iid.Include_Additional_Watchlists;
DataRestriction := mod_access.DataRestrictionMask;
DataPermission  := mod_access.DataPermissionMask;
dppa := mod_access.dppa;
glb := mod_access.glb;
ExactMatchLevel := mod_iid.ExactMatchLevel;
EverOccupant_PastMonths := mod_iid.EverOccupant_PastMonths;
EverOccupant_StartDate := mod_iid.EverOccupant_StartDate;
LastSeenThreshold := mod_iid.LastSeenThreshold;
runAreaCodeSplitSearch := mod_iid.runAreaCodeSplitSearch;
isUtility := mod_iid.isUtility;
ExcludeWatchLists := mod_iid.ExcludeWatchLists;
from_IT1O := mod_iid.from_IT1O;
from_BIID := mod_iid.from_BIID;
dob_radius := mod_iid.dob_radius;
global_watchlist_threshold := mod_iid.global_watchlist_threshold;
require2ele := mod_iid.require2ele;
companyID := mod_iid.companyID;


// step 1.  Get the DID and prep the layout_output dataset
#IF(onThor)
	with_DID := risk_indicators.iid_getDID_prepOutput_THOR(indata, dppa, glb, isFCRA, BSversion, DataRestriction, append_best, gateways, BSOptions);
#ELSE
	with_DID := risk_indicators.iid_getDID_prepOutput(indata, dppa, glb, isFCRA, BSversion, DataRestriction, append_best, gateways, BSOptions, mod_access);
#END


// need to check personContext before the overrides, if there are records which are suppressed in PersonContext, need to make sure the flag_file_id for that suppressed record doesn't get added back by an override record
with_PersonContext := if(isFCRA, Risk_Indicators.checkPersonContext(with_did, gateways, BSversion, IntendedPurpose), with_did);


#IF(_Control.Environment.onVault)
	with_overrides := with_PersonContext;  // when on Vault, we don't need to do corrections
#ELSE
	with_overrides := if( isFCRA, PROJECT(with_PersonContext, Risk_Indicators.Transforms.add_flags(LEFT)), with_PersonContext);
#END


commonstart := risk_indicators.iid_common_function(with_overrides, mod_iid, mod_access, isFCRA, DOBMatchOptions);

common_transformed := risk_indicators.iid_transform_common(commonstart, BSOptions);

// one of the optimization options in IID v2 is to allow this search to be skipped when not needed.
with_chrono_phones := risk_indicators.iid_getChronologyPhones(common_transformed, from_IT1O, ExactMatchLevel, isFCRA, BSOptions, glb);
eqfsphones := if(runChronoPhoneLookup, with_chrono_phones, common_transformed);

gotWatch := map(isFCRA or // don't search watchlist files for FCRA products anymore
							(ofac_version=1 and ExcludeWatchLists) or
              (ofac_version>1 and Include_Ofac=FALSE and
              Include_Additional_Watchlists=FALSE and count(watchlists_requested)=0) => eqfsphones,
								gateways(servicename='attus')[1].url!='' 	=> risk_indicators.getAttus(eqfsphones, gateways, dppa, glb),
								// ofac_version=4 => call the new Watchlist ESP service
								risk_indicators.getWatchLists2(eqfsphones,ofac_only, from_BIID,ofac_version,include_ofac,include_additional_watchlists,global_watchlist_threshold,dob_radius, watchlists_requested, gateways));

with_flags := group(sort(risk_indicators.iid_getPhoneAddrFlags(with_overrides, isFCRA, runAreaCodeSplitSearch, BSversion, mod_access),seq),seq);
with_addrs := risk_indicators.iid_getAddressInfo(with_flags, glb, isFCRA, require2ele, BSversion, isUtility, ExactMatchLevel, LastSeenThreshold, BSOptions);
with_nap := risk_indicators.iid_getPhoneInfo(with_addrs, gateways, dppa, glb, isFCRA, require2ele, BSversion, mod_iid.allowCellphones,
		ExactMatchLevel, LastSeenThreshold, BSOptions, companyID, EverOccupant_PastMonths, EverOccupant_StartDate,
		mod_iid.IncludeNAPData, mod_access);

combined_verification := risk_indicators.iid_combine_verification(gotWatch, with_nap, from_IT1O, ExactMatchLevel, isFCRA,
		BSOptions, bsversion, DataPermission, DataRestriction, mod_access);

dlverify := risk_indicators.iid_DL_verification(combined_verification, dppa, isfcra, ExactMatchLevel, BSOptions, DataPermission, bsversion, mod_access);
with_DL_verification := if(mod_iid.runDLverification, dlverify, combined_verification);

runThreatMetrix := (BSOptions & risk_indicators.iid_constants.BSOptions.runThreatMetrix) > 0;

with_ThreatMetrix := if(runThreatMetrix,
	risk_indicators.iid_append_threatMetrix(indata, with_dl_verification, gateways, companyID, DataRestriction),
	with_dl_verification);

// output(with_addrs, named('with_addrs'));
// output(with_nap, named('with_nap'));
// output(IndustryClass, named('industryClass_iidBaseFunction'));

// output(with_overrides, named('with_overrides'), extend);

return with_ThreatMetrix;

end;
