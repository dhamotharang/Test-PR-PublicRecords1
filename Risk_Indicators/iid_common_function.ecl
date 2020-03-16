//Risk_Indicators.iid_common_function

import emailv2_services,gateway,doxie,email_data,risk_indicators;

export iid_common_function(grouped DATASET(risk_indicators.Layout_Output) with_did, unsigned1 dppa, unsigned1 glb, boolean isUtility=false, 
							boolean ln_branded, boolean suppressNearDups=false, 
							boolean isFCRA=false, unsigned1 BSversion=1, 
							boolean runSSNCodes=true, boolean runBestAddrCheck=true,
							string10 ExactMatchLevel=risk_indicators.iid_constants.default_ExactMatchLevel,
							string50 DataRestriction=risk_indicators.iid_constants.default_DataRestriction, 
							string10 CustomDataFilter='',
							dataset(risk_indicators.layouts.Layout_DOB_Match_Options) DOBMatchOptions,
							unsigned2 EverOccupant_PastMonths,
							unsigned4 EverOccupant_StartDate,
							unsigned8 BSOptions, 
							unsigned3 LastSeenThreshold = risk_indicators.iid_constants.oneyear,
							string50 DataPermission=risk_indicators.iid_constants.default_DataPermission,
							unsigned1 LexIdSourceOptout = 1,
							string TransactionID = '',
							string BatchUID = '',
							unsigned6 GlobalCompanyId = 0,
              string5 IndustryClass = ''
							) :=
FUNCTION

mod_access := MODULE(Doxie.IDataAccess)
	EXPORT glb := ^.glb;
	EXPORT dppa := ^.dppa;
	EXPORT unsigned1 lexid_source_optout := LexIdSourceOptout;
	EXPORT string transaction_id := TransactionID; // esp transaction id or batch uid
	EXPORT unsigned6 global_company_id := GlobalCompanyId; // mbs gcid
END;

// check the first record in the batch to determine if this a realtime transaction or an archive test
production_realtime_mode := with_did[1].historydate=risk_indicators.iid_constants.default_history_date
														or with_did[1].historydate = (unsigned)((string)risk_indicators.iid_constants.todaydate)[1..6];
														
with_ADLVelocity := risk_indicators.Boca_Shell_ADL(with_DID, isFCRA, dppa, DataRestriction, mod_access);	// real time BocaShell 2 and 3 stuff

// skip the realtime velocity stuff if history run and bocashell version 50 or higher
adlRec := if(production_realtime_mode and BSversion between 2 and 49, with_ADLVelocity, with_did);	

// returns the full list of raw header records for that did																								
with_header := risk_indicators.iid_getHeader(adlRec, dppa, glb, isFCRA, ln_branded, ExactMatchLevel, DataRestriction, CustomDataFilter, BSversion, DOBMatchOptions, EverOccupant_PastMonths, EverOccupant_StartDate, LastSeenThreshold, BSOptions,LexIdSourceOptout, 
	TransactionID, 
	BatchUID , 
	GlobalCompanyID);

// append address hierarchy seq # to the addresses from the header
with_hierarchy := if(bsversion >= 50, Risk_Indicators.iid_append_address_hierarchy(with_header, isFCRA, bsversion) );

//  call to get miltary flags if shell version 5.0 or higher
header_with_Military_addresses   := if(bsversion >= 50, risk_indicators.iid_GetMilitaryAddr(with_hierarchy), with_header);

with_ssn_addr_velocity := risk_indicators.getVelocityHist(header_with_Military_addresses, isFCRA, dppa, DataRestriction, BSversion, mod_access);//  history BocaShell stuff
with_ADL_counts := if(production_realtime_mode and BSversion between 2 and 49, 
	header_with_Military_addresses, 
	with_ssn_addr_velocity);  // for shell version 50 and higher, use the runtime calculation of ADL velocity counters

all_header := if(BSversion > risk_indicators.iid_constants.basic_shell_version, 
	risk_indicators.getPhoneAddrVelocity(with_ADL_counts, isUtility, dppa, isFCRA, DataRestriction, bsversion, BSOptions, mod_access), header_with_Military_addresses);	
	
with_addr_history := if(bsversion > 3, risk_indicators.Boca_Shell_Address_History(all_header, isFCRA, datarestriction), all_header);

// the HHID summary is a lot of additional searching for each DID in the household.  if we don't need to do that searching, keep it turned off for efficiency.
includeHHIDSummary := bsversion >= 50 and isFCRA=false and (BSOptions & risk_indicators.iid_constants.BSOptions.IncludeHHIDSummary) > 0;

with_hhid_summary := if(includeHHIDSummary, risk_indicators.Boca_Shell_HHID_Summary(with_addr_history, dppa, dataRestriction, bsversion, mod_access), with_addr_history);

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
with_ssn_flags := risk_indicators.iid_getSSNFlags(rolled_header, dppa, glb, isFCRA, runSSNCodes, ExactMatchLevel, DataRestriction, BSversion, BSOptions, DataPermission, mod_access);

with_best_addr := risk_indicators.iid_check_best(with_hhid_summary, with_ssn_flags, ExactMatchLevel, bsversion);

common := if(runBestAddrCheck or bsversion >=50, with_best_addr, with_ssn_flags);

valid_email_inputs := if(~isFCRA,common(did<>0 and trim(email_address)<>''));  // only send the transactions with a populated email address and populated DID
ret_email := Ungroup(project(valid_email_inputs, transform(risk_indicators.Layout_Input, self.did := left.did, 
             self.email_address := left.email_address, self.seq := left.seq, self := [])));
email_in:= Project(ret_email,transform(EmailV2_Services.Layouts.batch_in_rec,
                                      self.email:=trim(StringLib.StringToUpperCase(left.email_address)),
                                      self.email_username:=email_data.Fn_Clean_Email_Username(left.email_address),
                                      self.email_domain:=email_data.Fn_Clean_Email_Domain(left.email_address),
                                      self:=left));

in_email_mod := Module(EmailV2_Services.IParams.EmailParams);
    EXPORT UNSIGNED2  PenaltThreshold      := EmailV2_Services.Constants.Defaults.PenaltThreshold;  
    EXPORT UNSIGNED  MaxResultsPerAcct    := EmailV2_Services.Constants.Defaults.MaxResultsPerAcct;  
    EXPORT BOOLEAN   IncludeHistoricData  := TRUE; 
    EXPORT STRING5   Industry_Class       := IndustryClass;
    EXPORT BOOLEAN   RequireLexidMatch    := FALSE;  
    EXPORT UNSIGNED1  EmailQualityRulesMask := 0;
    EXPORT BOOLEAN   RunDeepDive          := FALSE;  
    EXPORT STRING    SearchType :='EIA';
    EXPORT STRING    RestrictedUseCase := EmailV2_Services.Constants.RestrictedUseCase.Standard; // for the purpose of email filtering by source as needed
    EXPORT STRING    BVAPIkey := '';   
    EXPORT UNSIGNED  MaxEmailsForDeliveryCheck := EmailV2_Services.Constants.Defaults.MaxEmailsToCheckDeliverable;   //max number of result email addresses per account to send to gateway for delivery check
    EXPORT BOOLEAN   CheckEmailDeliverable := FALSE;  // option  for whether to use external gateway call to check if email address deliverable
    EXPORT BOOLEAN   KeepUndeliverableEmail := TRUE;
    EXPORT DATASET (Gateway.Layouts.Config) gateways := DATASET ([], Gateway.Layouts.Config);  // to check delivery status
END;	
	
email_search_results := EmailV2_Services.Functions.getEmaildata(email_in,in_email_mod,EmailV2_Services.Constants.SearchBy.ByEmail);

mylayout_output := record
    unsigned seq;
    unsigned did;
    string email_address;
    string VerifiedEmail;  
end;

with_email_verification := join(ret_email, email_search_results, left.seq=right.seq,
      transform(mylayout_output,
      self.seq := left.seq;
      self.did := left.did; 
      self.email_address:=left.email_address;
      self.VerifiedEmail := if(left.did=right.did, left.email_address, '');  
	     ),left outer);
  
mylayout_output emailroll (mylayout_output l,mylayout_output r):=TRANSFORM
    self:=l;
END;

sorted_email:= group(sort(with_email_verification,seq,-VerifiedEmail),seq);		
rolled_email:= rollup(sorted_email, left.seq=right.seq, emailroll(left,right));
 
 Risk_indicators.layout_output cleanemail(common l, rolled_email r):=transform
  self.VerifiedEmail:=r.VerifiedEmail;
  self:=l;
END;
 
join_rolled_email:=join(common, rolled_email,left.seq=right.seq,cleanemail(left,right),left outer);
output_common:= group(join_rolled_email,seq);
// output(common,named('common'));
// output(ret_email,named('ret_email'));
// output(email_in,named('email_in'));
// output(email_search_results,named('email_search_results'));
// output(with_email_verification,named('with_email_verification'));
// output(output_common,named('output_common'));
// output(IndustryClass, named('industryClass_iidCommonFunction'));
return output_common;

END;