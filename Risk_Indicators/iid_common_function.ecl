//Risk_Indicators.iid_common_function

import didville,doxie,FCRA,header,header_quick,header_SlimSort,watchdog,ut,DID_Add,address,
       gong,drivers,mdr,riskwise,suppress;

export iid_common_function(grouped DATASET(risk_indicators.Layout_Output) with_did, unsigned1 dppa, unsigned1 glb, boolean isUtility=false, 
							boolean ln_branded, boolean suppressNearDups=false, 
							boolean isFCRA=false, unsigned1 BSversion=1, 
							boolean runSSNCodes=true, boolean runBestAddrCheck=true,
							string10 ExactMatchLevel=iid_constants.default_ExactMatchLevel,
							string50 DataRestriction=iid_constants.default_DataRestriction, 
							string10 CustomDataFilter='',
							dataset(layouts.Layout_DOB_Match_Options) DOBMatchOptions,
							unsigned2 EverOccupant_PastMonths,
							unsigned4 EverOccupant_StartDate,
							unsigned8 BSOptions, 
							unsigned3 LastSeenThreshold = iid_constants.oneyear,
							string50 DataPermission=iid_constants.default_DataPermission
							) :=
FUNCTION

// check the first record in the batch to determine if this a realtime transaction or an archive test
production_realtime_mode := with_did[1].historydate=risk_indicators.iid_constants.default_history_date
														or with_did[1].historydate = (unsigned)((string)risk_indicators.iid_constants.todaydate)[1..6];
														
with_ADLVelocity := risk_indicators.Boca_Shell_ADL(with_DID, isFCRA, dppa, DataRestriction);	// real time BocaShell 2 and 3 stuff

// skip the realtime velocity stuff if history run and bocashell version 50 or higher
adlRec := if(production_realtime_mode and BSversion between 2 and 49, with_ADLVelocity, with_did);	

// returns the full list of raw header records for that did																								
with_header := risk_indicators.iid_getHeader(adlRec, dppa, glb, isFCRA, ln_branded, ExactMatchLevel, DataRestriction, CustomDataFilter, BSversion, DOBMatchOptions, EverOccupant_PastMonths, EverOccupant_StartDate, LastSeenThreshold, BSOptions);

// append address hierarchy seq # to the addresses from the header
with_hierarchy := if(bsversion >= 50, Risk_Indicators.iid_append_address_hierarchy(with_header, isFCRA, bsversion) );

//  call to get miltary flags if shell version 5.0 or higher
header_with_Military_addresses   := if(bsversion >= 50, risk_indicators.iid_GetMilitaryAddr(with_hierarchy), with_header);

with_ssn_addr_velocity := risk_indicators.getVelocityHist(header_with_Military_addresses, isFCRA, dppa, DataRestriction, BSversion);//  history BocaShell stuff
with_ADL_counts := if(production_realtime_mode and BSversion between 2 and 49, 
	header_with_Military_addresses, 
	with_ssn_addr_velocity);  // for shell version 50 and higher, use the runtime calculation of ADL velocity counters

all_header := if(BSversion > risk_indicators.iid_constants.basic_shell_version, 
	risk_indicators.getPhoneAddrVelocity(with_ADL_counts, isUtility, dppa, isFCRA, DataRestriction, bsversion, BSOptions), header_with_Military_addresses);	
	
with_addr_history := if(bsversion > 3, risk_indicators.Boca_Shell_Address_History(all_header, isFCRA, datarestriction), all_header);

// the HHID summary is a lot of additional searching for each DID in the household.  if we don't need to do that searching, keep it turned off for efficiency.
includeHHIDSummary := bsversion >= 50 and isFCRA=false and (BSOptions & risk_indicators.iid_constants.BSOptions.IncludeHHIDSummary) > 0;

with_hhid_summary := if(includeHHIDSummary, risk_indicators.Boca_Shell_HHID_Summary(with_addr_history, dppa, dataRestriction, bsversion), with_addr_history);

just_layout_output := PROJECT (with_hhid_summary,
		TRANSFORM(risk_indicators.layout_output, 
		SELF.rawaid_orig := LEFT.h.rawaid, SELF := LEFT));		

experian_batch_feed := false;  // this is always false in this function when calling roll_header
rolled_header_normal := risk_indicators.iid_roll_header(just_layout_output, suppressNearDups, BSversion, experian_batch_feed, isfcra, BSOptions);

//For BS 5.3, additional fields need to be passed to 'iid_getFraudVelocity' in order to filter by source
ApplicationType 		 := '';
with_fraud_velocity := risk_indicators.iid_getFraudVelocity(all_header, rolled_header_normal,	ApplicationType, dppa,
																									ln_branded, isFCRA, BSversion, DataRestriction,	CustomDataFilter, BSOptions, glb);
	

// for fraud shell, hang on to datasets of PII information that was found on file at the time of application
isFraudpoint :=  not isFCRA and (BSOptions & iid_constants.BSOptions.IncludeFraudVelocity) > 0;
isInstantIDv1 := not isFCRA and (BSOptions & iid_constants.BSOptions.IsInstantIDv1) > 0;	// for CIID, get the nlr data
rolled_header := if(isFraudpoint or (bsversion>=41 and ~isFCRA) or isInstantIDv1, with_fraud_velocity, rolled_header_normal);

// iid_getSSNFlags was located prior to rolled_header. When entering a 4 byte ssn, flags were being set before the ssn was fixed.
with_ssn_flags := risk_indicators.iid_getSSNFlags(rolled_header, dppa, glb, isFCRA, runSSNCodes, ExactMatchLevel, DataRestriction, BSversion, BSOptions, DataPermission );

with_best_addr := risk_indicators.iid_check_best(with_hhid_summary, with_ssn_flags, ExactMatchLevel, bsversion);

common := if(runBestAddrCheck or bsversion >=50, with_best_addr, with_ssn_flags);

RETURN common;

END;