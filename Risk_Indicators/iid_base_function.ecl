﻿import _Control, iesp, fcra, gateway, risk_indicators, Doxie, risk_indicators;
onThor := _Control.Environment.OnThor;

export iid_base_function(DATASET(risk_indicators.layout_input) indata, dataset(Gateway.Layouts.Config) gateways,
													unsigned1 dppa, unsigned1 glb, 
													boolean isUtility=false, boolean ln_branded, 
													boolean ofac_only=true,
													BOOLEAN suppressNearDups=false, boolean require2Ele=false,
													boolean from_BIID = false, boolean isFCRA = false, boolean ExcludeWatchLists = false, boolean from_IT1O=false,
													unsigned1 ofac_version =1,boolean include_ofac = FALSE, boolean include_additional_watchlists =false,
													real global_watchlist_threshold =.84,integer2 dob_radius = -1, 
													unsigned1 BSversion=1,
													boolean runSSNCodes=true, 
													boolean runBestAddrCheck=true,
													boolean runChronoPhoneLookup=true,
													boolean runAreaCodeSplitSearch=true,
													boolean allowCellphones=false,
													string10 ExactMatchLevel=Risk_Indicators.iid_constants.default_ExactMatchLevel,
													string50 DataRestriction=Risk_Indicators.iid_constants.default_DataRestriction,
													string10 CustomDataFilter='',
													boolean runDLverification=false,
													dataset(iesp.share.t_StringArrayItem) watchlists_requested,
													dataset(Risk_Indicators.layouts.Layout_DOB_Match_Options) DOBMatchOptions,
													unsigned2 EverOccupant_PastMonths,
													unsigned4 EverOccupant_StartDate,
													unsigned1 append_best=0,
													unsigned8 BSOptions=0,
													unsigned3 LastSeenThreshold = Risk_Indicators.iid_constants.oneyear,
													string20 companyID='',
													string50 DataPermission=Risk_Indicators.iid_constants.default_DataPermission,
													boolean IncludeNAPData = false,
													string100 IntendedPurpose = '',
													unsigned1 LexIdSourceOptout = 1,
													string TransactionID = '',
													string BatchUID = '',
													unsigned6 GlobalCompanyId = 0,
                          string5 IndustryClass = ''
													) := FUNCTION

mod_access := MODULE(Doxie.IDataAccess)
	EXPORT glb := ^.glb;
	EXPORT dppa := ^.dppa;
	EXPORT unsigned1 lexid_source_optout := LexIdSourceOptout;
	EXPORT string transaction_id := TransactionID; // esp transaction id or batch uid
	EXPORT unsigned6 global_company_id := GlobalCompanyId; // mbs gcid
END;

// step 1.  Get the DID and prep the layout_output dataset
#IF(onThor)
	with_DID := risk_indicators.iid_getDID_prepOutput_THOR(indata, dppa, glb, isFCRA, BSversion, DataRestriction, append_best, gateways, BSOptions);
#ELSE
	with_DID := risk_indicators.iid_getDID_prepOutput(indata, dppa, glb, isFCRA, BSversion, DataRestriction, append_best, gateways, BSOptions, mod_access);
#END

// do corrections here
risk_indicators.layout_output add_flags(risk_indicators.Layout_output le) := TRANSFORM
	// NOTE: this code is called when the IID library is disabled. when it is enabled, LIB_InstantID_Function_FCRA is used
	// instead. therefore, this transform should be the same as that one.

  // by putting personcontext search first, we can check to make sure we don't add any extra flag records that have already been suppressed in personContext ConsumerStatements dataset
	ssn_flags := CHOOSEN (fcra.key_override_flag_ssn (l_ssn=le.ssn, datalib.NameMatch (le.fname, le.mname, le.lname, fname, mname, lname)<3 and record_id not in set(le.consumerstatements, recidforstid)), risk_indicators.iid_constants.MAX_OVERRIDE_LIMIT);
	did_flags := CHOOSEN (fcra.key_override_flag_did (keyed (l_did=(string)le.did) and record_id not in set(le.consumerstatements, recidforstid) ), Risk_Indicators.iid_constants.MAX_OVERRIDE_LIMIT);
	flags := PROJECT (did_flags, fcra.Layout_override_flag) + PROJECT (ssn_flags, fcra.Layout_override_flag);
	flagrecs := CHOOSEN (dedup (flags, ALL), Risk_Indicators.iid_constants.MAX_OVERRIDE_LIMIT);	

// for each datagroup, add back the record_id we already have obtained from personContext search earlier
	SELF.veh_correct_vin                := SET(flagrecs(file_id = FCRA.FILE_ID.VEHICLE),record_id) + le.veh_correct_vin;
	SELF.veh_correct_ffid               := SET(flagrecs(file_id = FCRA.FILE_ID.VEHICLE),flag_file_id);

	SELF.bankrupt_correct_cccn          := SET(flagrecs(file_id = FCRA.FILE_ID.BANKRUPTCY),record_id) + le.bankrupt_correct_cccn ;
	SELF.bankrupt_correct_ffid          := SET(flagrecs(file_id = FCRA.FILE_ID.BANKRUPTCY),flag_file_id);
	SELF.lien_correct_tmsid_rmsid       := SET(flagrecs(file_id = FCRA.FILE_ID.LIEN),record_id) + le.lien_correct_tmsid_rmsid ;
	SELF.lien_correct_ffid              := SET(flagrecs(file_id = FCRA.FILE_ID.LIEN),flag_file_id);
	SELF.crim_correct_ofk               := SET(flagrecs(file_id = FCRA.FILE_ID.OFFENDERS),record_id) + 
																				 fcra.functions.GetSexOffendersIDs(le.did, flagrecs(file_id = FCRA.FILE_ID.SO_MAIN)) + le.crim_correct_ofk ;
	SELF.crim_correct_ffid              := SET(flagrecs(file_id = FCRA.FILE_ID.OFFENDERS),flag_file_id) + 
																				 SET(flagrecs(file_id = FCRA.FILE_ID.SO_MAIN),flag_file_id);

	SELF.prop_correct_lnfare            := SET(flagrecs(file_id = FCRA.FILE_ID.ASSESSMENT),record_id) +
                                         SET(flagrecs(file_id = FCRA.FILE_ID.DEED),record_id) + le.prop_correct_lnfare ;
	SELF.prop_correct_ffid              := SET(flagrecs(file_id = FCRA.FILE_ID.ASSESSMENT),flag_file_id) +
                                         SET(flagrecs(file_id = FCRA.FILE_ID.DEED),flag_file_id) +
                                         SET(flagrecs(file_id = FCRA.FILE_ID.SEARCH),flag_file_id);
	
	SELF.water_correct_ffid             := SET(flagrecs(file_id = FCRA.FILE_ID.WATERCRAFT),flag_file_id) + le.water_correct_RECORD_ID ;
	SELF.water_correct_RECORD_ID        := SET(flagrecs(file_id = FCRA.FILE_ID.WATERCRAFT),record_id);
	SELF.proflic_correct_ffid           := SET(flagrecs(file_id = FCRA.FILE_ID.PROFLIC),flag_file_id) + le.proflic_correct_RECORD_ID ;
	SELF.proflic_correct_RECORD_ID      := SET(flagrecs(file_id = FCRA.FILE_ID.PROFLIC),record_id);
	SELF.student_correct_ffid           := SET(flagrecs(file_id = FCRA.FILE_ID.STUDENT),flag_file_id) + SET(flagrecs(file_id = FCRA.FILE_ID.STUDENT_alloy),flag_file_id);
	SELF.student_correct_RECORD_ID      := SET(flagrecs(file_id = FCRA.FILE_ID.STUDENT),record_id)    + SET(flagrecs(file_id = FCRA.FILE_ID.STUDENT_alloy),record_id) + le.student_correct_RECORD_ID ;
	SELF.air_correct_ffid               := SET(flagrecs(file_id = FCRA.FILE_ID.AIRCRAFT),flag_file_id);
	SELF.air_correct_RECORD_ID          := SET(flagrecs(file_id = FCRA.FILE_ID.AIRCRAFT),record_id) + le.air_correct_RECORD_ID ;
	SELF.avm_correct_ffid               := SET(flagrecs(file_id = FCRA.FILE_ID.AVM),flag_file_id);
	SELF.avm_correct_RECORD_ID          := SET(flagrecs(file_id = FCRA.FILE_ID.AVM),record_id) + le.avm_correct_RECORD_ID ;
	
	SELF.infutor_correct_ffid           := SET(flagrecs(file_id = FCRA.FILE_ID.INFUTOR),flag_file_id);
	SELF.infutor_correct_record_id      := SET(flagrecs(file_id = FCRA.FILE_ID.INFUTOR),record_id) + le.infutor_correct_record_id ;
	SELF.impulse_correct_ffid           := SET(flagrecs(file_id = FCRA.FILE_ID.IMPULSE),flag_file_id);
	SELF.impulse_correct_record_id      := SET(flagrecs(file_id = FCRA.FILE_ID.IMPULSE),record_id) + le.impulse_correct_record_id ;
	SELF.gong_correct_ffid              := SET(flagrecs(file_id = FCRA.FILE_ID.GONG),flag_file_id);
	SELF.gong_correct_record_id         := SET(flagrecs(file_id = FCRA.FILE_ID.GONG),record_id) + le.gong_correct_record_id ;
	
	SELF.advo_correct_ffid              := SET(flagrecs(file_id = FCRA.FILE_ID.advo),flag_file_id);
	SELF.advo_correct_record_id         := SET(flagrecs(file_id = FCRA.FILE_ID.advo),record_id) + le.advo_correct_record_id ;
	SELF.paw_correct_ffid               := SET(flagrecs(file_id = FCRA.FILE_ID.paw),flag_file_id);
	SELF.paw_correct_record_id          := SET(flagrecs(file_id = FCRA.FILE_ID.paw),record_id) + le.paw_correct_record_id ;
	SELF.email_data_correct_ffid        := SET(flagrecs(file_id = FCRA.FILE_ID.email_data),flag_file_id);
	SELF.email_data_correct_record_id   := SET(flagrecs(file_id = FCRA.FILE_ID.email_data),record_id) + le.email_data_correct_record_id ;
	SELF.inquiries_correct_ffid         := SET(flagrecs(file_id = FCRA.FILE_ID.inquiries),flag_file_id);
	SELF.inquiries_correct_record_id    := SET(flagrecs(file_id = FCRA.FILE_ID.inquiries),record_id) + le.inquiries_correct_record_id ;
	
	SELF.ssn_correct_ffid               := SET(flagrecs(file_id = FCRA.FILE_ID.ssn),flag_file_id);
	SELF.ssn_correct_record_id          := SET(flagrecs(file_id = FCRA.FILE_ID.ssn),record_id) + le.ssn_correct_record_id ;
	
	SELF.header_correct_record_id       := SET(flagrecs(file_id = FCRA.FILE_ID.hdr),record_id) + le.header_correct_record_id ;
	
	SELF.ibehavior_correct_ffid					:= SET(flagrecs(file_id in [FCRA.FILE_ID.ibehavior_consumer,FCRA.FILE_ID.ibehavior_purchase]),flag_file_id) ;
	SELF.ibehavior_correct_record_id		:= SET(flagrecs(file_id in [FCRA.FILE_ID.ibehavior_consumer,FCRA.FILE_ID.ibehavior_purchase]),record_id) + le.ibehavior_correct_record_id ;
	
	SELF := le;
END;

// need to check personContext before the overrides, if there are records which are suppressed in PersonContext, need to make sure the flag_file_id for that suppressed record doesn't get added back by an override record
with_PersonContext := if(isFCRA, Risk_Indicators.checkPersonContext(with_did, gateways, BSversion, IntendedPurpose), with_did);


#IF(_Control.Environment.onVault)
	with_overrides := with_PersonContext;  // when on Vault, we don't need to do corrections
#ELSE
	with_overrides := if( isFCRA, PROJECT(with_PersonContext, add_flags(LEFT)), with_PersonContext);
#END


commonstart := risk_indicators.iid_common_function(with_overrides, dppa, glb, isUtility, ln_branded, 
															suppressNearDups, isFCRA, bsversion,
															runSSNCodes, runBestAddrCheck, ExactMatchLevel, DataRestriction, CustomDataFilter,
															DOBMatchOptions, EverOccupant_PastMonths, EverOccupant_StartDate, BSOptions, 
															LastSeenThreshold, DataPermission,
															LexIdSourceOptout := LexIdSourceOptout, 
															TransactionID := TransactionID, 
															BatchUID := BatchUID, 
															GlobalCompanyID := GlobalCompanyID,
                              IndustryClass := IndustryClass);
                              
common_transformed := risk_indicators.iid_transform_common(commonstart, BSOptions);

// one of the optimization options in IID v2 is to allow this search to be skipped when not needed.
with_chrono_phones := risk_indicators.iid_getChronologyPhones(common_transformed, from_IT1O, ExactMatchLevel, isFCRA, BSOptions, glb);
eqfsphones := if(runChronoPhoneLookup, with_chrono_phones, common_transformed);

gotWatch := map(isFCRA or // don't search watchlist files for FCRA products anymore
								(ofac_version=1 and ExcludeWatchLists) or 
								(ofac_version>1 and Include_Ofac=FALSE and Include_Additional_Watchlists=FALSE and count(watchlists_requested)=0) => eqfsphones, 
								gateways(servicename='attus')[1].url!='' 	=> risk_indicators.getAttus(eqfsphones, gateways, dppa, glb), 
								// ofac_version=4 => call the new Watchlist ESP service
								risk_indicators.getWatchLists2(eqfsphones,ofac_only, from_BIID,ofac_version,include_ofac,include_additional_watchlists,global_watchlist_threshold,dob_radius, watchlists_requested, gateways));

with_flags := group(sort(risk_indicators.iid_getPhoneAddrFlags(with_overrides, isFCRA, runAreaCodeSplitSearch, BSversion, mod_access),seq),seq);
with_addrs := risk_indicators.iid_getAddressInfo(with_flags, glb, isFCRA, require2ele, BSversion, isUtility, ExactMatchLevel, LastSeenThreshold, BSOptions);					
with_nap := risk_indicators.iid_getPhoneInfo(with_addrs, gateways, dppa, glb, isFCRA, require2ele, BSversion, allowCellphones, 
		ExactMatchLevel, LastSeenThreshold, BSOptions, companyID, EverOccupant_PastMonths, EverOccupant_StartDate, 
		IncludeNAPData, mod_access);

combined_verification := risk_indicators.iid_combine_verification(gotWatch, with_nap, from_IT1O, ExactMatchLevel, isFCRA, 
		BSOptions, bsversion, DataPermission, DataRestriction, mod_access);

dlverify := risk_indicators.iid_DL_verification(combined_verification, dppa, isfcra, ExactMatchLevel, BSOptions, DataPermission, bsversion, mod_access);
with_DL_verification := if(runDLverification, dlverify, combined_verification);

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