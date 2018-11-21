/*--LIBRARY--*/

import doxie, ut, DID_Add, address, UtilFile, riskwise, iesp, patriot, fcra, gateway;

export LIB_InstantID_Function_FCRA(DATASET(risk_indicators.layout_input) indata, 
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


	// do corrections here
	risk_indicators.layout_output add_flags(risk_indicators.Layout_output le) := TRANSFORM
		// NOTE: this code is called when the IID library is in use. when it is disabled, iid_base_function is used
		// instead. therefore, this transform should be the same as that one.

    // TODO: add a dob/name-near/ssn-near lookup
    ssn_flags := CHOOSEN (fcra.key_override_flag_ssn (l_ssn=le.ssn, datalib.NameMatch (le.fname, le.mname, le.lname, fname, mname, lname)<3), iid_constants.MAX_OVERRIDE_LIMIT);
		// TODO: get dids to be unsigned
    did_flags := CHOOSEN (fcra.key_override_flag_did (keyed (l_did=(string)le.did)), iid_constants.MAX_OVERRIDE_LIMIT);
    flags := PROJECT (did_flags, fcra.Layout_override_flag) + PROJECT (ssn_flags, fcra.Layout_override_flag);
		flagrecs := CHOOSEN (dedup (flags, ALL), iid_constants.MAX_OVERRIDE_LIMIT);
		

		SELF.veh_correct_vin                := SET(flagrecs(file_id = FCRA.FILE_ID.VEHICLE),record_id);
		SELF.veh_correct_ffid               := SET(flagrecs(file_id = FCRA.FILE_ID.VEHICLE),flag_file_id);

		SELF.bankrupt_correct_cccn          := SET(flagrecs(file_id = FCRA.FILE_ID.BANKRUPTCY),record_id);
		SELF.bankrupt_correct_ffid          := SET(flagrecs(file_id = FCRA.FILE_ID.BANKRUPTCY),flag_file_id);
		SELF.lien_correct_tmsid_rmsid       := SET(flagrecs(file_id = FCRA.FILE_ID.LIEN),record_id);
		SELF.lien_correct_ffid              := SET(flagrecs(file_id = FCRA.FILE_ID.LIEN),flag_file_id);
		SELF.crim_correct_ofk               := SET(flagrecs(file_id = FCRA.FILE_ID.OFFENDERS),record_id) + 
																					 fcra.functions.GetSexOffendersIDs(le.did, flagrecs(file_id = FCRA.FILE_ID.SO_MAIN));
		SELF.crim_correct_ffid              := SET(flagrecs(file_id = FCRA.FILE_ID.OFFENDERS),flag_file_id) + 
																					 SET(flagrecs(file_id = FCRA.FILE_ID.SO_MAIN),flag_file_id);

		SELF.prop_correct_lnfare            := SET(flagrecs(file_id = FCRA.FILE_ID.ASSESSMENT),record_id) +
                                           SET(flagrecs(file_id = FCRA.FILE_ID.DEED),record_id);
    // ffids may contain duplicates, but: they don't seem to be used anyway
		SELF.prop_correct_ffid              := SET(flagrecs(file_id = FCRA.FILE_ID.ASSESSMENT),flag_file_id) +
                                           SET(flagrecs(file_id = FCRA.FILE_ID.DEED),flag_file_id) +
                                           SET(flagrecs(file_id = FCRA.FILE_ID.SEARCH),flag_file_id);
		
		SELF.water_correct_ffid             := SET(flagrecs(file_id = FCRA.FILE_ID.WATERCRAFT),flag_file_id);
		SELF.water_correct_RECORD_ID        := SET(flagrecs(file_id = FCRA.FILE_ID.WATERCRAFT),record_id);
		SELF.proflic_correct_ffid           := SET(flagrecs(file_id = FCRA.FILE_ID.PROFLIC),flag_file_id);
		SELF.proflic_correct_RECORD_ID      := SET(flagrecs(file_id = FCRA.FILE_ID.PROFLIC),record_id);
		SELF.student_correct_ffid           := SET(flagrecs(file_id = FCRA.FILE_ID.STUDENT),flag_file_id) + SET(flagrecs(file_id = FCRA.FILE_ID.STUDENT_alloy),flag_file_id);
		SELF.student_correct_RECORD_ID      := SET(flagrecs(file_id = FCRA.FILE_ID.STUDENT),record_id)    + SET(flagrecs(file_id = FCRA.FILE_ID.STUDENT_alloy),record_id);
		SELF.air_correct_ffid               := SET(flagrecs(file_id = FCRA.FILE_ID.AIRCRAFT),flag_file_id);
		SELF.air_correct_RECORD_ID          := SET(flagrecs(file_id = FCRA.FILE_ID.AIRCRAFT),record_id);
		SELF.avm_correct_ffid               := SET(flagrecs(file_id = FCRA.FILE_ID.AVM),flag_file_id);
		SELF.avm_correct_RECORD_ID          := SET(flagrecs(file_id = FCRA.FILE_ID.AVM),record_id);
		
		SELF.infutor_correct_ffid           := SET(flagrecs(file_id = FCRA.FILE_ID.INFUTOR),flag_file_id);
		SELF.infutor_correct_record_id      := SET(flagrecs(file_id = FCRA.FILE_ID.INFUTOR),record_id);
		SELF.impulse_correct_ffid           := SET(flagrecs(file_id = FCRA.FILE_ID.IMPULSE),flag_file_id);
		SELF.impulse_correct_record_id      := SET(flagrecs(file_id = FCRA.FILE_ID.IMPULSE),record_id);
		SELF.gong_correct_ffid              := SET(flagrecs(file_id = FCRA.FILE_ID.GONG),flag_file_id);
		SELF.gong_correct_record_id         := SET(flagrecs(file_id = FCRA.FILE_ID.GONG),record_id);
		
		SELF.advo_correct_ffid              := SET(flagrecs(file_id = FCRA.FILE_ID.advo),flag_file_id);
		SELF.advo_correct_record_id         := SET(flagrecs(file_id = FCRA.FILE_ID.advo),record_id);
		SELF.paw_correct_ffid               := SET(flagrecs(file_id = FCRA.FILE_ID.paw),flag_file_id);
		SELF.paw_correct_record_id          := SET(flagrecs(file_id = FCRA.FILE_ID.paw),record_id);
		SELF.email_data_correct_ffid        := SET(flagrecs(file_id = FCRA.FILE_ID.email_data),flag_file_id);
		SELF.email_data_correct_record_id   := SET(flagrecs(file_id = FCRA.FILE_ID.email_data),record_id);
		SELF.inquiries_correct_ffid         := SET(flagrecs(file_id = FCRA.FILE_ID.inquiries),flag_file_id);
		SELF.inquiries_correct_record_id    := SET(flagrecs(file_id = FCRA.FILE_ID.inquiries),record_id);
		
		SELF.ssn_correct_ffid               := SET(flagrecs(file_id = FCRA.FILE_ID.ssn),flag_file_id);
		SELF.ssn_correct_record_id          := SET(flagrecs(file_id = FCRA.FILE_ID.ssn),record_id);
		
		SELF.header_correct_record_id       := SET(flagrecs(file_id = FCRA.FILE_ID.hdr),record_id);
		
		SELF.ibehavior_correct_ffid					:= SET(flagrecs(file_id in [FCRA.FILE_ID.ibehavior_consumer,FCRA.FILE_ID.ibehavior_purchase]),flag_file_id);
		SELF.ibehavior_correct_record_id		:= SET(flagrecs(file_id in [FCRA.FILE_ID.ibehavior_consumer,FCRA.FILE_ID.ibehavior_purchase]),record_id);
		
		SELF := le;
	END;
	with_overrides := PROJECT(with_did, add_flags(LEFT));

with_PersonContext := if(isFCRA, Risk_Indicators.checkPersonContext(with_overrides, gateways, BSversion, intendedPurpose), with_did);
	
commonstart := risk_indicators.iid_common_function(with_PersonContext, dppa, glb, isUtility, ln_branded,
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