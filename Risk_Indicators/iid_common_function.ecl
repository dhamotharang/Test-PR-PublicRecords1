import emailv2_services, gateway, doxie, email_data, risk_indicators, RiskWise, STD;

export iid_common_function(grouped DATASET(risk_indicators.Layout_Output) with_did,
							Risk_Indicators.ICommonInstantId mod_iid, doxie.IDataAccess mod_access,
							boolean isFCRA=false,
							dataset(risk_indicators.layouts.Layout_DOB_Match_Options) DOBMatchOptions
							) := FUNCTION

BSOptions := mod_iid.BSOptions;
BSversion := mod_iid.BSversion;
DataRestriction := mod_access.DataRestrictionMask;
dppa := mod_access.dppa;
glb := mod_access.glb;
ln_branded := mod_access.ln_branded;
ExactMatchLevel := mod_iid.ExactMatchLevel;
CustomDataFilter := mod_iid.CustomDataFilter;
EverOccupant_PastMonths := mod_iid.EverOccupant_PastMonths;
EverOccupant_StartDate := mod_iid.EverOccupant_StartDate;
LastSeenThreshold := mod_iid.LastSeenThreshold;
LexIdSourceOptout := mod_access.lexid_source_optout;
TransactionID := mod_access.transaction_id;
BatchUID := '';
GlobalCompanyID := mod_access.global_company_id;

IsFIS  := (BSOptions & risk_indicators.iid_constants.BSOptions.IsFISattributes) > 0;

// check the first record in the batch to determine if this a realtime transaction or an archive test
production_realtime_mode := with_did[1].historydate=risk_indicators.iid_constants.default_history_date
														or with_did[1].historydate = (unsigned)((string)risk_indicators.iid_constants.todaydate)[1..6];

with_ADLVelocity := risk_indicators.Boca_Shell_ADL(with_DID, isFCRA, mod_access);	// real time BocaShell 2 and 3 stuff

// skip the realtime velocity stuff if history run and bocashell version 50 or higher
adlRec_temp := if(production_realtime_mode and BSversion between 2 and 49, with_ADLVelocity, with_did);

FIS_adlRec := join(with_did, with_ADLVelocity,
                  left.seq = right.seq,
                  Transform(risk_indicators.layout_output,
                            self.FIS_addrs_last12 := right.FIS_addrs_last12,
                            self.FIS_addrs_last60 := right.FIS_addrs_last60,
                            self := left),
                            ATMOST(RiskWise.max_atmost), KEEP(1));

adlRec := IF(IsFIS, group(FIS_adlRec, seq), adlRec_temp);

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
	risk_indicators.getPhoneAddrVelocity(with_ADL_counts, mod_iid.isUtility, dppa, isFCRA, DataRestriction, bsversion, BSOptions, mod_access), header_with_Military_addresses);

with_addr_history := if(bsversion > 3, risk_indicators.Boca_Shell_Address_History(all_header, isFCRA, datarestriction), all_header);

// the HHID summary is a lot of additional searching for each DID in the household.  if we don't need to do that searching, keep it turned off for efficiency.
includeHHIDSummary := bsversion >= 50 and isFCRA=false and (BSOptions & risk_indicators.iid_constants.BSOptions.IncludeHHIDSummary) > 0;

with_hhid_summary := if(includeHHIDSummary, risk_indicators.Boca_Shell_HHID_Summary(with_addr_history, dppa, dataRestriction, bsversion, mod_access), with_addr_history);

just_layout_output := PROJECT (with_hhid_summary,
		TRANSFORM(risk_indicators.layout_output,
		SELF.rawaid_orig := LEFT.h.rawaid, SELF := LEFT));

experian_batch_feed := false;  // this is always false in this function when calling roll_header
rolled_header_normal := risk_indicators.iid_roll_header(just_layout_output, mod_iid.suppressNearDups, BSversion, experian_batch_feed, isfcra, BSOptions);

//For BS 5.3, additional fields need to be passed to 'iid_getFraudVelocity' in order to filter by source
ApplicationType 		 := '';
with_fraud_velocity := risk_indicators.iid_getFraudVelocity(all_header, rolled_header_normal,	ApplicationType, dppa,
																									ln_branded, isFCRA, BSversion, DataRestriction,	CustomDataFilter, BSOptions, glb);


// for fraud shell, hang on to datasets of PII information that was found on file at the time of application
isFraudpoint :=  not isFCRA and (BSOptions & iid_constants.BSOptions.IncludeFraudVelocity) > 0;
isInstantIDv1 := not isFCRA and (BSOptions & iid_constants.BSOptions.IsInstantIDv1) > 0;	// for CIID, get the nlr data
rolled_header := if(isFraudpoint or (bsversion>=41 and ~isFCRA) or isInstantIDv1, with_fraud_velocity, rolled_header_normal);

// iid_getSSNFlags was located prior to rolled_header. When entering a 4 byte ssn, flags were being set before the ssn was fixed.
with_ssn_flags := risk_indicators.iid_getSSNFlags(rolled_header, mod_access, isFCRA, mod_iid.runSSNCodes, ExactMatchLevel, BSversion, BSOptions);

with_best_addr := risk_indicators.iid_check_best(with_hhid_summary, with_ssn_flags, ExactMatchLevel, bsversion);

common := if(mod_iid.runBestAddrCheck or bsversion >=50, with_best_addr, with_ssn_flags);

valid_email_inputs := if(~isFCRA,common(did<>0 and trim(email_address)<>''));  // only send the transactions with a populated email address and populated DID
ret_email := Ungroup(project(valid_email_inputs, transform(risk_indicators.Layout_Input, self.did := left.did,
             self.email_address := left.email_address, self.seq := left.seq, self := [])));
email_in:= Project(ret_email,transform(EmailV2_Services.Layouts.batch_in_rec,
                                      self.email:=trim(STD.Str.ToUpperCase(left.email_address)),
                                      self.email_username:=email_data.Fn_Clean_Email_Username(left.email_address),
                                      self.email_domain:=email_data.Fn_Clean_Email_Domain(left.email_address),
                                      self:=left));

in_email_mod := Module(EmailV2_Services.IParams.EmailParams);
    EXPORT UNSIGNED2  PenaltThreshold      := EmailV2_Services.Constants.Defaults.PenaltThreshold;
    EXPORT UNSIGNED  MaxResultsPerAcct    := EmailV2_Services.Constants.Defaults.MaxResultsPerAcct;
    EXPORT BOOLEAN   IncludeHistoricData  := TRUE;
    EXPORT STRING5   Industry_Class       := mod_access.industry_class;
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
// output(with_ADLVelocity, named('with_ADLVelocity_iidCommonFunction'), Overwrite);
// output(adlRec_temp, named('adlRec_temp_iidCommonFunction'), Overwrite);
// output(adlRec, named('adlRec_iidCommonFunction'), Overwrite);
// output(with_header, named('with_header_iidCommonFunction'), Overwrite);
// output(with_hierarchy, named('with_hierarchy_iidCommonFunction'), Overwrite);
// output(header_with_Military_addresses, named('header_with_Military_addresses_iidCommonFunction'), Overwrite);
// output(with_ssn_addr_velocity, named('with_ssn_addr_velocity_iidCommonFunction'), Overwrite);
// output(with_ADL_counts, named('with_ADL_counts_iidCommonFunction'), Overwrite);
// output(with_addr_history, named('with_addr_history_iidCommonFunction'), Overwrite);
// output(common, named('common_iidCommonFunction'), Overwrite);

return output_common;

END;
