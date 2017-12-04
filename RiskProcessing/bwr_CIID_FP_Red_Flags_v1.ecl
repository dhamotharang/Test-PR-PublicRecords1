import ut, risk_indicators, models, scoring, riskwise;
#workunit('name','Consumer IID-FP Process');
#option ('hthorMemoryLimit', 1000);
#option ('linkCountedRows', false); 
// *** Targus can only be used in a Realtime mode with current data ***

prii_layout := RECORD
	STRING AccountNumber;
	STRING FirstName;
	STRING MiddleName;
	STRING LastName;
	STRING StreetAddress;
	STRING City;
	STRING State;
	STRING Zip;
	STRING HomePhone;
	STRING SSN;
	STRING DateOfBirth;
	STRING WorkPhone;
	STRING income;  
	string DLNumber;
	string DLState;
	string BALANCE; 
	string CHARGEOFFD;  
	string FormerName;
	string EMAIL;  
	string COMPANY;
	string historydate;
END;

f := DATASET('~jpyon::in::citi_1295_3220_in_in',prii_layout,csv(quote('"')));
// f := choosen(DATASET(ut.foreign_prod+'jpyon::in::citi_1295_3220_in_in',prii_layout,csv(quote('"'))),100);
output(f);

layout_soap := record
	STRING AccountNumber;
	STRING FirstName;
	STRING MiddleName;
	STRING LastName;
	STRING NameSuffix;
	STRING StreetAddress;
	string PrimRange;
	string PreDir;
	string Primname;
	string AddrSuffix;
	string PostDir;
	string UnitDesignation;
	string SecRange;
	STRING City;
	STRING State;
	STRING Zip;
	STRING Country;
	STRING SSN;
	STRING DateOfBirth;
	STRING Age;
	STRING DLNumber;
	STRING DLState;
	STRING Email;
	STRING IPAddress;
	STRING HomePhone;
	STRING WorkPhone;
	STRING EmployerName;
	STRING FormerName;
	INTEGER GLBPurpose;
	INTEGER DPPAPurpose;
	integer HistoryDateYYYYMM;
	string20 HistoryDateTimeStamp;
	dataset(risk_indicators.Layout_Gateways_In) gateways;
	dataset(Models.Layout_Score_Chooser) scores;
	integer RedFlag_version;  			// **** pass in RedFlag_version=1 to turn red flags on
	boolean IncludeTargusE3220;			// set to true to include the E3220 gateway search, otherwise make sure this is set to false, we get billed for this
	string DataRestrictionMask;
	string50 DataPermissionMask;		
	boolean OfacOnly;
	integer OFACversion;
	boolean IncludeOfac;
	boolean IncludeAdditionalWatchLists;
	real GlobalWatchlistThreshold;
	boolean PoBoxCompliance;
	boolean IncludeMSoverride;
	boolean IncludeCLoverride;
	boolean IncludeDLVerification;
	string44 PassportUpperLine;
	string44 PassportLowerLine;
	string6 Gender;
	integer DOBradius;
  boolean usedobfilter;
	
	boolean ExactFirstNameMatch;
	boolean ExactFirstNameMatchAllowNicknames;
	boolean ExactLastNameMatch;
	boolean ExactPhoneMatch;
	boolean ExactSSNMatch;

	boolean IncludeAllRiskIndicators;

	dataset(risk_indicators.layouts.Layout_DOB_Match_Options) DOBMatchOptions;
	
	// new v1 options
	string CustomCVIModelName;	// currently not used
	unsigned3 LastSeenThreshold;	// defaults to 365 but can be changed to say how many days you would like address verification to look back for
	string6 InstantIDVersion;	// this should be set to 1
	boolean IIDVersionOverride;	// this allows a customer to go below the lowest forced version of ciid
	boolean IncludeDOBInCVI;	// allows the dob verification to affect cvi
	boolean IncludeDriverLicenseInCVI;	// allows drivers license verification to affect cvi, used with IncludeDLVerification (needs to be true)
	boolean IncludeMIoverride;	// will set CVI = 10 for MI reason codes
	boolean DisableCustomerNetworkOptionInCVI;	// will disable the inquiry NAP dataset
	boolean DisallowInsurancePhoneHeaderGateway;	// will disable the insurance gateway NAP dataset
	string5 IndustryClass;
	boolean EnableEmergingID;  //for AmEx - do additional searches to assign a DID - set this option in the transform below 
	string  NameInputOrder;    //if customer wants to specify the order of the input full name field - see options below 

end;

l := RECORD
	STRING old_account_number;
	layout_soap;
END;

// parms := dataset ([{'Version','fp3710_0'}],models.Layout_Parameters);

// parameters for v2 model
parms := dataset ([{'Version','fp1109_0'},
										{'includeriskindices', '1'}],models.Layout_Parameters);

l t_f(f le, INTEGER c) := TRANSFORM
	SELF.old_account_number := le.accountnumber;
	SELF.Accountnumber := (STRING)c;	
	SELF.DPPAPurpose := 3;
	SELF.GLBPurpose := 1;
	self.RedFlag_version := 0;  		// **** pass in RedFlag_version=1 to turn red flags on
	//**************************************************************************************** 
	// When hard-coding archive dates, uncomment and modify one of the following sets of code 
	//   below and comment out the existing  code for self.historydateyyyymm and self.historyDateTimeStamp 
	//****************************************************************************************
	//    self.historydateyyyymm := 201109;  
	//    self.historyDateTimeStamp := '20110901 00000100';  

	//    self.historydateyyyymm := 999999;  
	//    self.historyDateTimeStamp := '';  // leave timestamp blank, query will populate it with the current date  
  self.historydateyyyymm := map(
                  regexfind('^\\d{8} \\d{8}$', le.historydate) => (unsigned)le.historydate[..6],
                  regexfind('^\\d{8}$',        le.historydate) => (unsigned)le.historydate[..6],
                                                                  (unsigned)le.historydate
      );
      
  self.historyDateTimeStamp := map(
      le.historydate in ['', '999999']             => '',  // leave timestamp blank, query will populate it with the current date   
                  regexfind('^\\d{8} \\d{8}$', le.historydate) => le.historydate,
                  regexfind('^\\d{8}$',        le.historydate) => le.historydate +   ' 00000100',
                  regexfind('^\\d{6}$',        le.historydate) => le.historydate + '01 00000100',                                                        
                                                                  le.historydate
      );

 	// self.scores := dataset([{'Models.FraudAdvisor_Service','http://roxiebatch.br.seisint.com:9856',parms}], models.Layout_Score_Chooser);
	self.scores := dataset([], models.Layout_Score_Chooser);	// for when no models are requested
	
	// the following 2 lines are included for e3220 searching, please do not use on regular runs *************************************************************************************
	//self.gateways := dataset([{'targus','http://rw_score_dev:Password01@rwgatewaycert.br.seisint.com:8090/wsGateway/?ver_=1.70'}], risk_indicators.Layout_Gateways_In);
	// self.gateways := dataset([{'targus','http://rw_data_prod:Password01@gatewayprodesp.sc.seisint.com:7726/wsGateway/?ver_=1.70'}], risk_indicators.Layout_Gateways_In);
	
	// for production runs, use the production gateway
	// self.gateways := dataset([{'insurancephoneheader','http://rw_score_dev:Password01@gatewaycertesp.sc.seisint.com:7526/WsPrism/?ver_=1.82'}], risk_indicators.Layout_Gateways_In);
	self.gateways := dataset([{'insurancephoneheader','HTTP://api_prod_gw_roxie:g0h3%40t2x@gatewayprodesp.sc.seisint.com:7726/WsGatewayEx/?ver_=1.87'}], risk_indicators.Layout_Gateways_In);
	
	// self.gateways := dataset([], risk_indicators.Layout_Gateways_In);

/* **** Use if Targus and InsurancePhoneHeader is needed  **** */
// self.gateways := dataset([{'targus','http://rw_data_prod:Password01@gatewayprodesp.sc.seisint.com:7726/wsGateway/?ver_=1.70'}
           // ,{'insurancephoneheader','http://rw_score_dev:Password01@gatewaycertesp.sc.seisint.com:7526/WsPrism/?ver_=1.82'}], risk_indicators.Layout_Gateways_In);


	self.IncludeTargusE3220 := FALSE;	// make sure to set this to false for most runs **********************************************************************************************

	self.DataRestrictionMask := '0000000000000000000000000';	// byte 6, if 1, restricts experian, byte 8, if 1, restricts equifax, 
																									// byte 10 restricts Transunion, 12 restricts ADVO, 13 restricts bureau deceased data,
																									// byte 16 restricts customer network (inquiry) data
	self.DataPermissionMask  := '0000000000100';  	// to allow population of FDN Virtual Fraud, Test Fraud and Contributory Fraud, set position 11 to '1'
																									// to allow Insurance DL data, set position 13 to '1'

	self.PoBoxCompliance := false;
	self.IncludeMSoverride := false;
	self.IncludeCLoverride := false;
	self.usedobfilter := false;
  self.DOBradius := 2;

	self.OfacOnly := false;
	self.OFACversion := 2;
	self.IncludeOfac := false;
	self.IncludeAdditionalWatchLists := false;
	self.GlobalWatchlistThreshold := 0.84;
	
	self.IncludeDLVerification := true;
	self.PassportUpperLine := '';
	self.PassportLowerLine := '';
	self.Gender := '';
	
	self.ExactFirstNameMatch := false;
	self.ExactFirstNameMatchAllowNicknames := false;
	self.ExactLastNameMatch := false;
	self.ExactPhoneMatch := false;
	self.ExactSSNMatch := false;

	self.IncludeAllRiskIndicators := true;
	
	// new stuff for v1
	self.LastSeenThreshold := risk_indicators.iid_constants.oneyear;	// 365, this needs to be specified in number of days 
	self.InstantIDVersion := '1';
	self.IIDVersionOverride := false;	// as of now, not used, will be used when version 1 is forced by product
	self.IncludeDOBInCVI := true;	// this allows the DOB verification to possibly increase the CVI by 10
	self.IncludeDriverLicenseInCVI := true;	// this allows the DL verification to possibly increase CVI by 10
	self.IncludeMIoverride := false;
  self.DisableCustomerNetworkOptionInCVI := false;	// if true, disables the inquiry data in the NAP calculation
	self.DisallowInsurancePhoneHeaderGateway := false;	// if true, disables the insurance header gateway in the NAP calculation
	
	// possible input options 'FuzzyCCYYMMDD','FuzzyCCYYMM''ExactCCYYMMDD''ExactCCYYMM''RadiusCCYY', if using the radius, then 0-3 is the range
	// self.DOBMatchOptions := dataset([{'RadiusCCYY','3'}], risk_indicators.layouts.Layout_DOB_Match_Options);
	
	self.IndustryClass := '';	// populate this field with 'UTILI' for when you want the utility data restricted, international accounts for example

	// new fields for Emerging Identities
	self.EnableEmergingID := false;  //set to true to do additional DID searching (primarily for AmEx)
	self.NameInputOrder := '';  // if customer wants to specify the order of input name
															//   options are 'fml' or 'lfm' - anything else defaults to standard
	SELF := le;
	self := [];
end;

p_f := project(f, t_f(left, counter));
output(p_f, named('CIID_Input'));

dist_dataset := PROJECT(p_f,TRANSFORM(layout_soap,SELF := LEFT));


roxieIP := riskwise.shortcuts.prod_batch_neutral;	// roxie batch


xlayout := RECORD
	(risk_indicators.Layout_InstandID_NuGen)
	STRING errorcode;
END;

xlayout myFail(dist_dataset le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF.AcctNo := le.AccountNumber;
	SELF := le;
	SELF := [];
END;

resu := soapcall(dist_dataset, roxieIP,
				'Risk_Indicators.InstantID', {dist_dataset}, 
				DATASET(xlayout), 
				RETRY(2), TIMEOUT(500), LITERAL,
				XPATH('Risk_Indicators.InstantIDResponse/Results/Result/Dataset[@name=\'Results\']/Row'),
				PARALLEL(30), onFail(myFail(LEFT)));

output(resu, named('iid_results'));

ox := RECORD
	Risk_Indicators.Layout_InstantID_NuGen_Denorm;
	string errorcode;
END;


ox normit(resu L, p_f R) := transform
	SELF.Acctno := R.old_account_number;
	self.hri_1 := if (count(l.ri) >= 1, L.ri[1].hri, '');
	self.hri_desc_1 := if (count(l.ri) >= 1, L.ri[1].desc, '');
	self.hri_2 := if (count(l.ri) >= 2, L.ri[2].hri, '');
	self.hri_desc_2 := if (count(l.ri) >= 2, L.ri[2].desc, '');
	self.hri_3 := if (count(l.ri) >= 3, L.ri[3].hri, '');
	self.hri_desc_3 := if (count(l.ri) >= 3, L.ri[3].desc, '');
	self.hri_4 := if (count(l.ri) >= 4, L.ri[4].hri, '');
	self.hri_desc_4 := if (count(l.ri) >= 4, L.ri[4].desc, '');
	self.hri_5 := if (count(l.ri) >= 5, L.ri[5].hri, '');
	self.hri_desc_5 := if (count(l.ri) >= 5, L.ri[5].desc, '');
	self.hri_6 := if (count(l.ri) >= 6, L.ri[6].hri, '');
	self.hri_desc_6 := if (count(l.ri) >= 6, L.ri[6].desc, '');
	self.fua_1 := if (count(l.fua) >= 1, L.fua[1].hri, '');
	self.fua_desc_1 := if (count(l.fua) >= 1, L.fua[1].desc, '');
	self.fua_2 := if (count(l.fua) >= 2, L.fua[2].hri, '');
	self.fua_desc_2 := if (count(l.fua) >= 2, L.fua[2].desc, '');
	self.fua_3 := if (count(l.fua) >= 3, L.fua[3].hri, '');
	self.fua_desc_3 := if (count(l.fua) >= 3, L.fua[3].desc, '');
	self.fua_4 := if (count(l.fua) >= 4, L.fua[4].hri, '');
	self.fua_desc_4 := if (count(l.fua) >= 4, L.fua[4].desc, '');
	self.additional_fname_1 := if (count(L.additional_lname) >= 1, l.additional_lname[1].fname1,'');
	self.additional_lname_1 := if (count(l.additional_lname) >= 1, L.additional_lname[1].lname1, '');
	self.additional_lname_date_last_1 := if (count(l.additional_lname) >= 1, L.additional_lname[1].date_last, '');
	self.additional_fname_2 := if (count(L.additional_lname) >= 2, l.additional_lname[2].fname1,'');
	self.additional_lname_2 := if (count(l.additional_lname) >= 2, L.additional_lname[2].lname1, '');
	self.additional_lname_date_last_2 := if (count(l.additional_lname) >= 2, L.additional_lname[2].date_last, '');
	self.additional_fname_3 := if (count(L.additional_lname) >= 3, l.additional_lname[3].fname1,'');
	self.additional_lname_3 := if (count(l.additional_lname) >= 3, L.additional_lname[3].lname1, '');
	self.additional_lname_date_last_3 := if (count(l.additional_lname) >= 3, L.additional_lname[3].date_last, '');
	self.chron_address_1 := if (count(L.chronology) >= 1, L.chronology[1].address, '');
	self.chron_city_1 := if (count(L.chronology) >= 1, L.chronology[1].city, '');
	self.chron_st_1 := if (count(L.chronology) >= 1, L.chronology[1].st, '');
	self.chron_zip_1 := if (count(L.chronology) >= 1, L.chronology[1].zip, '');
	self.Chron_Zip4_1 := if(count(l.chronology) >= 1, l.chronology[1].zip4, '');									// **** added zip4
	self.Chron_dpbc_1 := if(count(l.chronology) >= 1, l.chronology[1].dpbc, '');									// **** added dpbc
	self.Chron_dt_first_seen_1 := if(count(l.chronology) >= 1, (string6)l.chronology[1].dt_first_seen, '');			// **** added chronology dates
	self.Chron_dt_last_seen_1 := if(count(l.chronology) >= 1, (string6)l.chronology[1].dt_last_seen, '');			// **** added chronology dates
	self.chron_phone_1 := if (count(L.chronology) >= 1, L.chronology[1].phone, '');
	self.chron_address_2 := if (count(L.chronology) >= 2, L.chronology[2].address, '');
	self.chron_city_2 := if (count(L.chronology) >= 2, L.chronology[2].city, '');
	self.chron_st_2 := if (count(L.chronology) >= 2, L.chronology[2].st, '');
	self.chron_zip_2 := if (count(L.chronology) >= 2, L.chronology[2].zip, '');
	self.Chron_Zip4_2 := if(count(l.chronology) >= 2, l.chronology[2].zip4, '');									// **** added zip4
	self.Chron_dpbc_2 := if(count(l.chronology) >= 2, l.chronology[2].dpbc, '');									// **** added dpbc
	self.Chron_dt_first_seen_2 := if(count(l.chronology) >= 2, (string6)l.chronology[2].dt_first_seen, '');			// **** added chronology dates
	self.Chron_dt_last_seen_2 := if(count(l.chronology) >= 2, (string6)l.chronology[2].dt_last_seen, '');			// **** added chronology dates
	self.chron_phone_2 := if (count(L.chronology) >= 2, L.chronology[2].phone, '');
	self.chron_address_3 := if (count(L.chronology) >= 3, L.chronology[3].address, '');
	self.chron_city_3 := if (count(L.chronology) >= 3, L.chronology[3].city, '');
	self.chron_st_3 := if (count(L.chronology) >= 3, L.chronology[3].st, '');
	self.chron_zip_3 := if (count(L.chronology) >= 3, L.chronology[3].zip, '');
	self.Chron_Zip4_3 := if(count(l.chronology) >= 3, l.chronology[3].zip4, '');									// **** added zip4
	self.Chron_dpbc_3 := if(count(l.chronology) >= 3, l.chronology[3].dpbc, '');									// **** added dpbc
	self.Chron_dt_first_seen_3 := if(count(l.chronology) >= 3, (string6)l.chronology[3].dt_first_seen, '');			// **** added chronology dates
	self.Chron_dt_last_seen_3 := if(count(l.chronology) >= 3, (string6)l.chronology[3].dt_last_seen, '');			// **** added chronology dates
	self.chron_phone_3 := if (count(L.chronology) >= 3, L.chronology[3].phone, '');
	self.did := intformat(L.did,12,1);
	self.transaction_id := intformat(L.transaction_id, 12, 1);
	self.nas_summary := (string)L.nas_summary;
	self.nap_summary := (string)L.nap_summary;
	self.CVI := (String)L.cvi;
	self.additional_score1 := (string)L.additional_score1;
	self.additional_score2 := (string)L.additional_score2;
	self.seq := intformat(L.seq,12,1);
	self.age := if (l.age = '***', '', L.age);
	
	// score fields  Note: score[1] equals a 0-999 score range
	// score fields  Note: score[2] equals a 010-050 score range
	// score fields  Note: score[3] equals a 10-90 score range *** Use as Default ***
	self.fd_score1 := l.models.scores[1].i;
	self.fd_score2 := l.models.scores[2].i;	// this should not be populated
	self.fd_score3 := l.models.scores[3].i;	// this should not be populated
	
	self.fd_reason1 := l.models.scores[1].reason_codes[1].reason_code;
	self.fd_desc1 := l.models.scores[1].reason_codes[1].Reason_Description;
	self.fd_reason2 := l.models.scores[1].reason_codes[2].reason_code;
	self.fd_desc2 := l.models.scores[1].reason_codes[2].Reason_Description;
	self.fd_reason3 := l.models.scores[1].reason_codes[3].reason_code;
	self.fd_desc3 := l.models.scores[1].reason_codes[3].Reason_Description;
	self.fd_reason4 := l.models.scores[1].reason_codes[4].reason_code;
	self.fd_desc4 := l.models.scores[1].reason_codes[4].Reason_Description;
	self.fd_reason5 := l.models.scores[1].reason_codes[5].reason_code;
	self.fd_desc5 := l.models.scores[1].reason_codes[5].Reason_Description;
	self.fd_reason6 := l.models.scores[1].reason_codes[6].reason_code;
	self.fd_desc6 := l.models.scores[1].reason_codes[6].Reason_Description;

	risk_indices := l.models.scores[1].risk_indices;

	self.StolenIdentityIndex        := risk_indices(name='StolenIdentityIndex')[1].value;
	self.SyntheticIdentityIndex     := risk_indices(name='SyntheticIdentityIndex')[1].value;
	self.ManipulatedIdentityIndex   := risk_indices(name='ManipulatedIdentityIndex')[1].value;
	self.VulnerableVictimIndex      := risk_indices(name='VulnerableVictimIndex')[1].value;
	self.FriendlyFraudIndex         := risk_indices(name='FriendlyFraudIndex')[1].value;
	self.SuspiciousActivityIndex    := risk_indices(name='SuspiciousActivityIndex')[1].value;
	
	self.ADDRESS_DISCREPANCY := if(count(l.red_flags.ADDRESS_DISCREPANCY_CODES)>0, 'Y', 'N');
	self.ADDRESS_DISCREPANCY_RC1 := l.red_flags.ADDRESS_DISCREPANCY_CODES[1].hri;
	self.ADDRESS_DISCREPANCY_RC2 := l.red_flags.ADDRESS_DISCREPANCY_CODES[2].hri;
	self.ADDRESS_DISCREPANCY_RC3 := l.red_flags.ADDRESS_DISCREPANCY_CODES[3].hri;
	self.ADDRESS_DISCREPANCY_RC4 := l.red_flags.ADDRESS_DISCREPANCY_CODES[4].hri;
	self.SUSPICIOUS_DOCUMENTS := if(count(l.red_flags.SUSPICIOUS_DOCUMENTS_CODES)>0, 'Y', 'N');
	self.SUSPICIOUS_DOCUMENTS_RC1 := l.red_flags.SUSPICIOUS_DOCUMENTS_CODES[1].hri;
	self.SUSPICIOUS_DOCUMENTS_RC2 := l.red_flags.SUSPICIOUS_DOCUMENTS_CODES[2].hri;
	self.SUSPICIOUS_DOCUMENTS_RC3 := l.red_flags.SUSPICIOUS_DOCUMENTS_CODES[3].hri;
	self.SUSPICIOUS_DOCUMENTS_RC4 := l.red_flags.SUSPICIOUS_DOCUMENTS_CODES[4].hri;
	self.SUSPICIOUS_ADDRESS := if(count(l.red_flags.SUSPICIOUS_ADDRESS_CODES)>0, 'Y', 'N');
	self.SUSPICIOUS_ADDRESS_RC1 := l.red_flags.SUSPICIOUS_ADDRESS_CODES[1].hri;
	self.SUSPICIOUS_ADDRESS_RC2 := l.red_flags.SUSPICIOUS_ADDRESS_CODES[2].hri;
	self.SUSPICIOUS_ADDRESS_RC3 := l.red_flags.SUSPICIOUS_ADDRESS_CODES[3].hri;
	self.SUSPICIOUS_ADDRESS_RC4 := l.red_flags.SUSPICIOUS_ADDRESS_CODES[4].hri;
	self.SUSPICIOUS_SSN := if(count(l.red_flags.SUSPICIOUS_SSN_CODES)>0, 'Y', 'N');
	self.SUSPICIOUS_SSN_RC1 := l.red_flags.SUSPICIOUS_SSN_CODES[1].hri;
	self.SUSPICIOUS_SSN_RC2 := l.red_flags.SUSPICIOUS_SSN_CODES[2].hri;
	self.SUSPICIOUS_SSN_RC3 := l.red_flags.SUSPICIOUS_SSN_CODES[3].hri;
	self.SUSPICIOUS_SSN_RC4 := l.red_flags.SUSPICIOUS_SSN_CODES[4].hri;
	self.SUSPICIOUS_DOB := if(count(l.red_flags.SUSPICIOUS_DOB_CODES)>0, 'Y', 'N');
	self.SUSPICIOUS_DOB_RC1 := l.red_flags.SUSPICIOUS_DOB_CODES[1].hri;
	self.SUSPICIOUS_DOB_RC2 := l.red_flags.SUSPICIOUS_DOB_CODES[2].hri;
	self.SUSPICIOUS_DOB_RC3 := l.red_flags.SUSPICIOUS_DOB_CODES[3].hri;
	self.SUSPICIOUS_DOB_RC4 := l.red_flags.SUSPICIOUS_DOB_CODES[4].hri;
	self.HIGH_RISK_ADDRESS := if(count(l.red_flags.HIGH_RISK_ADDRESS_CODES)>0, 'Y', 'N');
	self.HIGH_RISK_ADDRESS_RC1 := l.red_flags.HIGH_RISK_ADDRESS_CODES[1].hri;
	self.HIGH_RISK_ADDRESS_RC2 := l.red_flags.HIGH_RISK_ADDRESS_CODES[2].hri;
	self.HIGH_RISK_ADDRESS_RC3 := l.red_flags.HIGH_RISK_ADDRESS_CODES[3].hri;
	self.HIGH_RISK_ADDRESS_RC4 := l.red_flags.HIGH_RISK_ADDRESS_CODES[4].hri;
	self.SUSPICIOUS_PHONE := if(count(l.red_flags.SUSPICIOUS_PHONE_CODES)>0, 'Y', 'N');
	self.SUSPICIOUS_PHONE_RC1 := l.red_flags.SUSPICIOUS_PHONE_CODES[1].hri;
	self.SUSPICIOUS_PHONE_RC2 := l.red_flags.SUSPICIOUS_PHONE_CODES[2].hri;
	self.SUSPICIOUS_PHONE_RC3 := l.red_flags.SUSPICIOUS_PHONE_CODES[3].hri;
	self.SUSPICIOUS_PHONE_RC4 := l.red_flags.SUSPICIOUS_PHONE_CODES[4].hri;
	self.SSN_MULTIPLE_LAST := if(count(l.red_flags.SSN_MULTIPLE_LAST_CODES)>0, 'Y', 'N');
	self.SSN_MULTIPLE_LAST_RC1 := l.red_flags.SSN_MULTIPLE_LAST_CODES[1].hri;
	self.SSN_MULTIPLE_LAST_RC2 := l.red_flags.SSN_MULTIPLE_LAST_CODES[2].hri;
	self.SSN_MULTIPLE_LAST_RC3 := l.red_flags.SSN_MULTIPLE_LAST_CODES[3].hri;
	self.SSN_MULTIPLE_LAST_RC4 := l.red_flags.SSN_MULTIPLE_LAST_CODES[4].hri;
	self.MISSING_INPUT := if(count(l.red_flags.MISSING_INPUT_CODES)>0, 'Y', 'N');
	self.MISSING_INPUT_RC1 := l.red_flags.MISSING_INPUT_CODES[1].hri;
	self.MISSING_INPUT_RC2 := l.red_flags.MISSING_INPUT_CODES[2].hri;
	self.MISSING_INPUT_RC3 := l.red_flags.MISSING_INPUT_CODES[3].hri;
	self.MISSING_INPUT_RC4 := l.red_flags.MISSING_INPUT_CODES[4].hri;
	self.FRAUD_ALERT := if(count(l.red_flags.FRAUD_ALERT_CODES)>0, 'Y', 'N');
	self.FRAUD_ALERT_RC1 := l.red_flags.FRAUD_ALERT_CODES[1].hri;
	self.FRAUD_ALERT_RC2 := l.red_flags.FRAUD_ALERT_CODES[2].hri;
	self.FRAUD_ALERT_RC3 := l.red_flags.FRAUD_ALERT_CODES[3].hri;
	self.FRAUD_ALERT_RC4 := l.red_flags.FRAUD_ALERT_CODES[4].hri;
	self.CREDIT_FREEZE := if(count(l.red_flags.CREDIT_FREEZE_CODES)>0, 'Y', 'N');
	self.CREDIT_FREEZE_RC1 := l.red_flags.CREDIT_FREEZE_CODES[1].hri;
	self.CREDIT_FREEZE_RC2 := l.red_flags.CREDIT_FREEZE_CODES[2].hri;
	self.CREDIT_FREEZE_RC3 := l.red_flags.CREDIT_FREEZE_CODES[3].hri;
	self.CREDIT_FREEZE_RC4 := l.red_flags.CREDIT_FREEZE_CODES[4].hri;
	self.IDENTITY_THEFT := if(count(l.red_flags.IDENTITY_THEFT_CODES)>0, 'Y', 'N');
	self.IDENTITY_THEFT_RC1 := l.red_flags.IDENTITY_THEFT_CODES[1].hri;
	self.IDENTITY_THEFT_RC2 := l.red_flags.IDENTITY_THEFT_CODES[2].hri;
	self.IDENTITY_THEFT_RC3 := l.red_flags.IDENTITY_THEFT_CODES[3].hri;
	self.IDENTITY_THEFT_RC4 := l.red_flags.IDENTITY_THEFT_CODES[4].hri;	
	
		self.Chron_addr_1_isBest := if(l.chronology[1].isBestMatch, 'Y', 'N');
	self.Chron_addr_2_isBest := if(l.chronology[2].isBestMatch, 'Y', 'N');
	self.Chron_addr_3_isBest := if(l.chronology[3].isBestMatch, 'Y', 'N');
	
	SELF.Watchlist_contry := l.watchlists[1].watchlist_contry;
	
	SELF.Watchlist_Table_2 := l.watchlists[2].watchlist_table;
	SELF.Watchlist_program_2 :=l.watchlists[2].watchlist_program;
	SELF.Watchlist_Record_Number_2 := l.watchlists[2].watchlist_Record_Number;
	SELF.Watchlist_fname_2 := l.watchlists[2].watchlist_fname;
	SELF.Watchlist_lname_2 := l.watchlists[2].watchlist_lname;
	SELF.Watchlist_address_2 := l.watchlists[2].watchlist_address;
	SELF.Watchlist_city_2 := l.watchlists[2].watchlist_city;
	SELF.Watchlist_state_2 := l.watchlists[2].watchlist_state;
	SELF.Watchlist_zip_2 := l.watchlists[2].watchlist_zip;
	SELF.Watchlist_contry_2 := l.watchlists[2].watchlist_contry;
	SELF.Watchlist_Entity_Name_2 := l.watchlists[2].watchlist_Entity_Name;
	
	SELF.Watchlist_Table_3 := l.watchlists[3].watchlist_table;
	SELF.Watchlist_program_3 :=l.watchlists[3].watchlist_program;
	SELF.Watchlist_Record_Number_3 := l.watchlists[3].watchlist_Record_Number;
	SELF.Watchlist_fname_3 := l.watchlists[3].watchlist_fname;
	SELF.Watchlist_lname_3 := l.watchlists[3].watchlist_lname;
	SELF.Watchlist_address_3 := l.watchlists[3].watchlist_address;
	SELF.Watchlist_city_3 := l.watchlists[3].watchlist_city;
	SELF.Watchlist_state_3 := l.watchlists[3].watchlist_state;
	SELF.Watchlist_zip_3 := l.watchlists[3].watchlist_zip;
	SELF.Watchlist_contry_3 := l.watchlists[3].watchlist_contry;
	SELF.Watchlist_Entity_Name_3 := l.watchlists[3].watchlist_Entity_Name;
	
	SELF.Watchlist_Table_4 := l.watchlists[4].watchlist_table;
	SELF.Watchlist_program_4 :=l.watchlists[4].watchlist_program;
	SELF.Watchlist_Record_Number_4 := l.watchlists[4].watchlist_Record_Number;
	SELF.Watchlist_fname_4 := l.watchlists[4].watchlist_fname;
	SELF.Watchlist_lname_4 := l.watchlists[4].watchlist_lname;
	SELF.Watchlist_address_4 := l.watchlists[4].watchlist_address;
	SELF.Watchlist_city_4 := l.watchlists[4].watchlist_city;
	SELF.Watchlist_state_4 := l.watchlists[4].watchlist_state;
	SELF.Watchlist_zip_4 := l.watchlists[4].watchlist_zip;
	SELF.Watchlist_contry_4 := l.watchlists[4].watchlist_contry;
	SELF.Watchlist_Entity_Name_4 := l.watchlists[4].watchlist_Entity_Name;
	
	SELF.Watchlist_Table_5 := l.watchlists[5].watchlist_table;
	SELF.Watchlist_program_5 :=l.watchlists[5].watchlist_program;
	SELF.Watchlist_Record_Number_5 := l.watchlists[5].watchlist_Record_Number;
	SELF.Watchlist_fname_5 := l.watchlists[5].watchlist_fname;
	SELF.Watchlist_lname_5 := l.watchlists[5].watchlist_lname;
	SELF.Watchlist_address_5 := l.watchlists[5].watchlist_address;
	SELF.Watchlist_city_5 := l.watchlists[5].watchlist_city;
	SELF.Watchlist_state_5 := l.watchlists[5].watchlist_state;
	SELF.Watchlist_zip_5 := l.watchlists[5].watchlist_zip;
	SELF.Watchlist_contry_5 := l.watchlists[5].watchlist_contry;
	SELF.Watchlist_Entity_Name_5 := l.watchlists[5].watchlist_Entity_Name;
	
	SELF.Watchlist_Table_6 := l.watchlists[6].watchlist_table;
	SELF.Watchlist_program_6 :=l.watchlists[6].watchlist_program;
	SELF.Watchlist_Record_Number_6 := l.watchlists[6].watchlist_Record_Number;
	SELF.Watchlist_fname_6 := l.watchlists[6].watchlist_fname;
	SELF.Watchlist_lname_6 := l.watchlists[6].watchlist_lname;
	SELF.Watchlist_address_6 := l.watchlists[6].watchlist_address;
	SELF.Watchlist_city_6 := l.watchlists[6].watchlist_city;
	SELF.Watchlist_state_6 := l.watchlists[6].watchlist_state;
	SELF.Watchlist_zip_6 := l.watchlists[6].watchlist_zip;
	SELF.Watchlist_contry_6 := l.watchlists[6].watchlist_contry;
	SELF.Watchlist_Entity_Name_6 := l.watchlists[6].watchlist_Entity_Name;
	
	SELF.Watchlist_Table_7 := l.watchlists[7].watchlist_table;
	SELF.Watchlist_program_7 :=l.watchlists[7].watchlist_program;
	SELF.Watchlist_Record_Number_7 := l.watchlists[7].watchlist_Record_Number;
	SELF.Watchlist_fname_7 := l.watchlists[7].watchlist_fname;
	SELF.Watchlist_lname_7 := l.watchlists[7].watchlist_lname;
	SELF.Watchlist_address_7 := l.watchlists[7].watchlist_address;
	SELF.Watchlist_city_7 := l.watchlists[7].watchlist_city;
	SELF.Watchlist_state_7 := l.watchlists[7].watchlist_state;
	SELF.Watchlist_zip_7 := l.watchlists[7].watchlist_zip;
	SELF.Watchlist_contry_7 := l.watchlists[7].watchlist_contry;
	SELF.Watchlist_Entity_Name_7 := l.watchlists[7].watchlist_Entity_Name;

// instantid enhancements 3/24/2011
	SELF.hri_7 := if (count(l.ri) >= 7, L.ri[7].hri, '');
	SELF.hri_desc_7 := if (count(l.ri) >= 7, L.ri[7].desc, '');
	SELF.hri_8 := if (count(l.ri) >= 8, L.ri[8].hri, '');
	SELF.hri_desc_8 := if (count(l.ri) >= 8, L.ri[8].desc, '');
	SELF.hri_9 := if (count(l.ri) >= 9, L.ri[9].hri, '');
	SELF.hri_desc_9 := if (count(l.ri) >= 9, L.ri[9].desc, '');
	SELF.hri_10 := if (count(l.ri) >= 10, L.ri[10].hri, '');
	SELF.hri_desc_10 := if (count(l.ri) >= 10, L.ri[10].desc, '');
	SELF.hri_11 := if (count(l.ri) >= 11, L.ri[11].hri, '');
	SELF.hri_desc_11 := if (count(l.ri) >= 11, L.ri[11].desc, '');
	SELF.hri_12 := if (count(l.ri) >= 12, L.ri[12].hri, '');
	SELF.hri_desc_12 := if (count(l.ri) >= 12, L.ri[12].desc, '');
	SELF.hri_13 := if (count(l.ri) >= 13, L.ri[13].hri, '');
	SELF.hri_desc_13 := if (count(l.ri) >= 13, L.ri[13].desc, '');
	SELF.hri_14 := if (count(l.ri) >= 14, L.ri[14].hri, '');
	SELF.hri_desc_14 := if (count(l.ri) >= 14, L.ri[14].desc, '');
	SELF.hri_15 := if (count(l.ri) >= 15, L.ri[15].hri, '');
	SELF.hri_desc_15 := if (count(l.ri) >= 15, L.ri[15].desc, '');
	SELF.hri_16 := if (count(l.ri) >= 16, L.ri[16].hri, '');
	SELF.hri_desc_16 := if (count(l.ri) >= 16, L.ri[16].desc, '');
	SELF.hri_17 := if (count(l.ri) >= 17, L.ri[17].hri, '');
	SELF.hri_desc_17 := if (count(l.ri) >= 17, L.ri[17].desc, '');
	SELF.hri_18 := if (count(l.ri) >= 18, L.ri[18].hri, '');
	SELF.hri_desc_18 := if (count(l.ri) >= 18, L.ri[18].desc, '');
	SELF.hri_19 := if (count(l.ri) >= 19, L.ri[19].hri, '');
	SELF.hri_desc_19 := if (count(l.ri) >= 19, L.ri[19].desc, '');
	SELF.hri_20 := if (count(l.ri) >= 20, L.ri[20].hri, '');
	SELF.hri_desc_20 := if (count(l.ri) >= 20, L.ri[20].desc, '');
	// parsed chronology address 1
	SELF.ChronPrimRange1 := if (count(L.chronology) >= 1, L.chronology[1].primrange, '');
	SELF.ChronPreDir1 := if (count(L.chronology) >= 1, L.chronology[1].predir, '');
	SELF.ChronPrimName1 := if (count(L.chronology) >= 1, L.chronology[1].primname, '');
	SELF.ChronAddrSuffix1 := if (count(L.chronology) >= 1, L.chronology[1].addrsuffix, '');
	SELF.ChronPostDir1 := if (count(L.chronology) >= 1, L.chronology[1].postdir, '');
	SELF.ChronUnitDesignation1 := if (count(L.chronology) >= 1, L.chronology[1].unitdesignation, '');
	SELF.ChronSecRange1 := if (count(L.chronology) >= 1, L.chronology[1].secrange, '');
	// parsed chronology address 2
	SELF.ChronPrimRange2 := if (count(L.chronology) >= 2, L.chronology[2].primrange, '');
	SELF.ChronPreDir2 := if (count(L.chronology) >= 2, L.chronology[2].predir, '');
	SELF.ChronPrimName2 := if (count(L.chronology) >= 2, L.chronology[2].primname, '');
	SELF.ChronAddrSuffix2 := if (count(L.chronology) >= 2, L.chronology[2].addrsuffix, '');
	SELF.ChronPostDir2 := if (count(L.chronology) >= 2, L.chronology[2].postdir, '');
	SELF.ChronUnitDesignation2 := if (count(L.chronology) >= 2, L.chronology[2].unitdesignation, '');
	SELF.ChronSecRange2 := if (count(L.chronology) >= 2, L.chronology[2].secrange, '');
	// parsed chronology address 3
	SELF.ChronPrimRange3 := if (count(L.chronology) >= 3, L.chronology[3].primrange, '');
	SELF.ChronPreDir3 := if (count(L.chronology) >= 3, L.chronology[3].predir, '');
	SELF.ChronPrimName3 := if (count(L.chronology) >= 3, L.chronology[3].primname, '');
	SELF.ChronAddrSuffix3 := if (count(L.chronology) >= 3, L.chronology[3].addrsuffix, '');
	SELF.ChronPostDir3 := if (count(L.chronology) >= 3, L.chronology[3].postdir, '');
	SELF.ChronUnitDesignation3 := if (count(L.chronology) >= 3, L.chronology[3].unitdesignation, '');
	SELF.ChronSecRange3 := if (count(L.chronology) >= 3, L.chronology[3].secrange, '');
	// parsed watchlist address 2
	SELF.WatchlistPrimRange2 := l.watchlists[2].Watchlistprimrange;
	SELF.WatchlistPreDir2 := l.watchlists[2].Watchlistpredir;
	SELF.WatchlistPrimName2 := l.watchlists[2].Watchlistprimname;
	SELF.WatchlistAddrSuffix2 := l.watchlists[2].Watchlistaddrsuffix;
	SELF.WatchlistPostDir2 := l.watchlists[2].Watchlistpostdir;
	SELF.WatchlistUnitDesignation2 := l.watchlists[2].Watchlistunitdesignation;
	SELF.WatchlistSecRange2 := l.watchlists[2].Watchlistsecrange;
	// parsed watchlist address 3
	SELF.WatchlistPrimRange3 := l.watchlists[3].Watchlistprimrange;
	SELF.WatchlistPreDir3 := l.watchlists[3].Watchlistpredir;
	SELF.WatchlistPrimName3 := l.watchlists[3].Watchlistprimname;
	SELF.WatchlistAddrSuffix3 := l.watchlists[3].Watchlistaddrsuffix;
	SELF.WatchlistPostDir3 := l.watchlists[3].Watchlistpostdir;
	SELF.WatchlistUnitDesignation3 := l.watchlists[3].Watchlistunitdesignation;
	SELF.WatchlistSecRange3 := l.watchlists[3].Watchlistsecrange;
	// parsed watchlist address 4
	SELF.WatchlistPrimRange4 := l.watchlists[4].Watchlistprimrange;
	SELF.WatchlistPreDir4 := l.watchlists[4].Watchlistpredir;
	SELF.WatchlistPrimName4 := l.watchlists[4].Watchlistprimname;
	SELF.WatchlistAddrSuffix4 := l.watchlists[4].Watchlistaddrsuffix;
	SELF.WatchlistPostDir4 := l.watchlists[4].Watchlistpostdir;
	SELF.WatchlistUnitDesignation4 := l.watchlists[4].Watchlistunitdesignation;
	SELF.WatchlistSecRange4 := l.watchlists[2].Watchlistsecrange;
	// parsed watchlist address 5
	SELF.WatchlistPrimRange5 := l.watchlists[5].Watchlistprimrange;
	SELF.WatchlistPreDir5 := l.watchlists[5].Watchlistpredir;
	SELF.WatchlistPrimName5 := l.watchlists[5].Watchlistprimname;
	SELF.WatchlistAddrSuffix5 := l.watchlists[5].Watchlistaddrsuffix;
	SELF.WatchlistPostDir5 := l.watchlists[5].Watchlistpostdir;
	SELF.WatchlistUnitDesignation5 := l.watchlists[5].Watchlistunitdesignation;
	SELF.WatchlistSecRange5 := l.watchlists[5].Watchlistsecrange;
	// parsed watchlist address 6
	SELF.WatchlistPrimRange6 := l.watchlists[6].Watchlistprimrange;
	SELF.WatchlistPreDir6 := l.watchlists[6].Watchlistpredir;
	SELF.WatchlistPrimName6 := l.watchlists[6].Watchlistprimname;
	SELF.WatchlistAddrSuffix6 := l.watchlists[6].Watchlistaddrsuffix;
	SELF.WatchlistPostDir6 := l.watchlists[6].Watchlistpostdir;
	SELF.WatchlistUnitDesignation6 := l.watchlists[6].Watchlistunitdesignation;
	SELF.WatchlistSecRange6 := l.watchlists[6].Watchlistsecrange;
	// parsed watchlist address 7
	SELF.WatchlistPrimRange7 := l.watchlists[7].Watchlistprimrange;
	SELF.WatchlistPreDir7 := l.watchlists[7].Watchlistpredir;
	SELF.WatchlistPrimName7 := l.watchlists[7].Watchlistprimname;
	SELF.WatchlistAddrSuffix7 := l.watchlists[7].Watchlistaddrsuffix;
	SELF.WatchlistPostDir7 := l.watchlists[7].Watchlistpostdir;
	SELF.WatchlistUnitDesignation7 := l.watchlists[7].Watchlistunitdesignation;
	SELF.WatchlistSecRange7 := l.watchlists[7].Watchlistsecrange;
	
	// extra fields
	SELF.PLACEHOLDER1 := '';
	SELF.PLACEHOLDER1_RC1 := '';
	SELF.PLACEHOLDER1_RC2 := '';
	SELF.PLACEHOLDER1_RC3 := '';
	SELF.PLACEHOLDER1_RC4 := '';
	
	SELF.PLACEHOLDER2 := '';
	SELF.PLACEHOLDER2_RC1 := '';
	SELF.PLACEHOLDER2_RC2 := '';
	SELF.PLACEHOLDER2_RC3 := '';
	SELF.PLACEHOLDER2_RC4 := '';

	SELF.PLACEHOLDER3 := '';
	SELF.PLACEHOLDER3_RC1 := '';
	SELF.PLACEHOLDER3_RC2 := '';
	SELF.PLACEHOLDER3_RC3 := '';
	SELF.PLACEHOLDER3_RC4 := '';

	SELF.PLACEHOLDER4 := '';
	SELF.PLACEHOLDER4_RC1 := '';
	SELF.PLACEHOLDER4_RC2 := '';
	SELF.PLACEHOLDER4_RC3 := '';
	SELF.PLACEHOLDER4_RC4 := '';

	SELF.PLACEHOLDER5 := '';
	SELF.PLACEHOLDER5_RC1 := '';
	SELF.PLACEHOLDER5_RC2 := '';
	SELF.PLACEHOLDER5_RC3 := '';
	SELF.PLACEHOLDER5_RC4 := '';
	
	self := L;

end;

//j_f := JOIN(resu,p_f,LEFT.acctno=RIGHT.accountnumber,normit(LEFT,RIGHT));
j_f := JOIN(DISTRIBUTE(resu, HASH64(acctno)), DISTRIBUTE(p_f, HASH64(accountnumber)),LEFT. acctno =RIGHT.accountnumber, normit(LEFT,RIGHT));




output(j_f);

insufficient_input_results := project(j_f(errorcode[1..3]='301'),  
	transform(ox, 
	self.acctno := left.acctno;
	self.errorcode := left.errorcode;
	self := [])
	);
successful_results := j_f(errorcode[1..3]<>'301');  
output(insufficient_input_results, named('insufficient_input_results'));
output(successful_results, named('successful_results'));

all_results := insufficient_input_results + successful_results;
output(all_results, named('all_results'));

output(all_results,,'~tsteil::out::ciidv1_',CSV(heading(single), quote('"')), overwrite);
output(all_results(errorcode<>''),,'~tsteil::out::error',CSV(QUOTE('"')), overwrite);