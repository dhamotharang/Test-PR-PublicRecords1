#workunit('name','FlexID Process');
// #option ('hthorMemoryLimit', 1000)


import Models, risk_indicators, riskwise, iesp, ut;

unsigned8 no_of_records := 1000;
unsigned1 eyeball := 100;
integer retry := 3;
integer timeout := 10;
integer threads := 1;
// String roxieIP := 'http://10.173.2.86:9876' ; 
// String roxieIP := 'http://10.173.2.22:9876' ; 
String roxieIP := 'http://10.176.68.186:9876' ; 
Gateway := DATASET([], Gateway.Layouts.Config);
String Infile_name :=  '~nkoubsky::in::persons_with_phones_20171018';
String outfile_name :=  '~nkoubsky::prct::flexid_test_21071121';

in_layout := record
		STRING lexID;
		STRING link_dob;
		STRING link_ssn;
		STRING FirstName;
		STRING MiddleName;
		STRING LastName;
		STRING NameSuffix;
		STRING DateOfBirth;
		STRING SSN;
		STRING StreetAddress;
		STRING addr2;
		STRING City;
		STRING State;
		STRING Zip;
		STRING src;
		STRING HomePhone;
		STRING date_first_reported;
		STRING date_last_reported;
		STRING date_first_seen;
		STRING date_last_seen;
		STRING per_order;
end;

ds_raw_input := CHOOSEN(DATASET(infile_name, in_layout, CSV(HEADING(SINGLE))), no_of_records);
output(choosen(ds_raw_input, eyeball), named('raw_input'));

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
	integer historydateyyyymm;
END;

// f := DATASET('~jpyon::in::cap_2337_invalid_f_s_in',prii_layout,csv(quote('"')));
// f := choosen(DATASET('~jpyon::in::cap_2337_invalid_f_s_in',prii_layout,csv(quote('"'))),5);
f := project(ds_raw_input, transform(prii_layout,
																			self.AccountNumber := left.lexID;
																			self := left;
																			self := [];
																			) );
output(f);

// ---------------------------------------------------------------------------------------
// FraudPoint score selection
//
// **** No Scores
// score := dataset([], models.Layout_Score_Chooser);

// **** FP FP3710_0
score := dataset([{'Models.FraudAdvisor_Service', roxieIP,
                    dataset ([{'Version','fp3710_0'}],models.Layout_Parameters)
                 }], models.Layout_Score_Chooser);
                 

// **** FP FP3710_9 (FP with Criminal)
// score := dataset([{'Models.FraudAdvisor_Service', roxieIP,
                    // dataset ([{'Version','fp3710_9'}],models.Layout_Parameters)
                 // }], models.Layout_Score_Chooser);
// ---------------------------------------------------------------------------------------

layout_soap := record
	string originalAccount;
	dataset(iesp.flexid.t_FlexIDRequest) FlexIDRequest;
	dataset(Risk_Indicators.Layout_Gateways_In) gateways;	
	dataset(Models.Layout_Score_Chooser) scores;
	unsigned HistoryDateYYYYMM;
end;


layout_soap t_f(f le, INTEGER c) := TRANSFORM
	self.originalAccount := le.accountnumber;
	
	self.gateways := dataset([], risk_indicators.Layout_Gateways_In);

	self.FlexIDRequest := project(ut.ds_oneRecord,
					transform(iesp.flexid.t_FlexIDRequest, 
 
								self.user.queryid := le.AccountNumber;
								self.user.AccountNumber := le.AccountNumber;
								self.user.GLBPurpose := (string)riskwise.permittedUse.fraudGLBA; 
								self.user.DLPurpose := (string)riskwise.permittedUse.fraudDPPA; 
								self.user.DataRestrictionMask := '000000000000';
								self.user.TestDataEnabled := false;
							 
							//To Turn on OFAC, uncomment out line 62 and comment out line 64. Default is off
             	// self.options.WatchLists := dataset([{'OFAC'}], iesp.share.t_StringArrayItem); 
							 
								self.options.WatchLists := dataset([], iesp.share.t_StringArrayItem); 
								self.options.UseDOBFilter := false; 
								self.options.DOBRadius := 0; 
								self.options.IncludeMSOverride := false; 
								self.options.DisallowTargusEID3220 := true; 
								self.options.PoBoxCompliance := false; 
								self.options.RequireExactMatch.LastName := false;
								self.options.RequireExactMatch.FirstName := false; 
								self.options.RequireExactMatch.FirstNameAllowNickname := false; 
								self.options.RequireExactMatch.HomePhone := false; 
								self.options.RequireExactmatch.SSN := false; 
								self.options.IncludeAllRiskIndicators := true; 
								self.options.IncludeVerifiedElementSummary := true; 
								self.options.IncludeDLVerification := true;
								self.options.DOBMatch.MatchType := '';
								self.options.DOBMatch.MatchYearRadius := 0; 
								
								self.searchby.Seq := (string)C;
								self.searchby.Name.Full := ''; 
								self.searchby.Name.First := le.FirstName; 
								self.searchby.Name.Middle := le.MiddleName; 
								self.searchby.Name.Last := le.LastName; 
								self.searchby.Name.Suffix := '';
								self.searchby.Name.Prefix := ''; 
								self.searchby.Address.StreetNumber := ''; 
								self.searchby.Address.StreetPreDirection := ''; 
								self.searchby.Address.StreetName := ''; 
								self.searchby.Address.StreetSuffix := ''; 
								self.searchby.Address.StreetPostDirection := ''; 
								self.searchby.Address.UnitDesignation := ''; 
								self.searchby.Address.UnitNumber := ''; 
								self.searchby.Address.StreetAddress1 := le.StreetAddress; 
								self.searchby.Address.StreetAddress2 := ''; 
								self.searchby.Address.City := le.City; 
								self.searchby.Address.State := le.State; 
								self.searchby.Address.Zip5 := le.Zip; 
								self.searchby.Address.Zip4 := ''; 
								self.searchby.Address.County := ''; 
								self.searchby.Address.PostalCode := ''; 
								self.searchby.Address.StateCityZip := ''; 
								self.searchby.DOB.Year := (unsigned)le.DateOfBirth[1..4]; 
								self.searchby.DOB.Month := (unsigned)le.DateOfBirth[5..6];
								self.searchby.DOB.Day := (unsigned)le.DateOfBirth[7..8]; 
								self.searchby.Age := 0; 
								self.searchby.SSN := le.SSN; 
								self.searchby.SSNLast4 := ''; 
								self.searchby.DriverLicenseNumber := le.DLNumber; 
								self.searchby.DriverLicenseState := le.DLState; 
								self.searchby.IPAddress := ''; 
								self.searchby.HomePhone := le.HomePhone; 
								self.searchby.WorkPhone := le.WorkPhone; 
								self.searchby.Passport.MachineReadableLine1 := '';
								self.searchby.Passport.MachineReadableLine2 := '';
								self.searchby.Gender := '';

								self := []));
							
  self.scores := score; 
  
	self.historydateyyyymm := 999999;
end;
p_f := project(f, t_f(left, counter));
output(p_f, named('CIID_Input'));

dist_dataset := distribute(p_f, random());

xlayout := RECORD
	iesp.flexid.t_FlexIDResponse;
	STRING errorcode;
END;

xlayout myFail(dist_dataset le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF.result.inputecho.Seq := le.originalAccount;
	SELF := le;
	SELF := [];
END;

output(dist_dataset,,'nkoubsky::out::flexid_xml_request', xml, overwrite);

resu := soapcall(dist_dataset, roxieIP,
				'Risk_Indicators.FlexID_Service', {dist_dataset}, 
				DATASET(xlayout),
				RETRY(2), TIMEOUT(500), LITERAL,
				XPATH('Risk_Indicators.FlexID_ServiceResponse/Results/Result/Dataset[@name=\'Results\']/Row'),
				PARALLEL(30), onFail(myFail(LEFT)));		

output(resu, named('resu'));



LayoutFlexIDOut := RECORD
	risk_indicators.LayoutsFlexID.LayoutFlexIDBatchOut
										- StolenIdentityIndex
										- SyntheticIdentityIndex
										- ManipulatedIdentityIndex
										- VulnerableVictimIndex
										- FriendlyFraudIndex
										- SuspiciousActivityIndex
										- ValidElementSummarySSNFoundForLexID
										- verSSN
										- cviCustomScore
										- ScoreRiskCode5
										- ScoreDescription5
										- ScoreRiskCode6
										- ScoreDescription6;
	STRING errorcode;
END;


LayoutFlexIDOut normit(resu le, p_f ri) := transform
	self.Acctno := ri.originalAccount;
	
	self.NameAddressPhoneSummary := le.Result.NameAddressPhone.Summary;
	self.NameAddressPhoneType := le.Result.NameAddressPhone._Type;
	self.NameAddressPhoneStatus := le.Result.NameAddressPhone.Status;
	
	self.VerifiedElementSummaryFirstName := le.Result.VerifiedElementSummary.FirstName;
	self.VerifiedElementSummaryLastName := le.Result.VerifiedElementSummary.LastName;
	self.VerifiedElementSummaryStreetAddress := le.Result.VerifiedElementSummary.StreetAddress;
	self.VerifiedElementSummaryCity := le.Result.VerifiedElementSummary.City;
	self.VerifiedElementSummaryState := le.Result.VerifiedElementSummary.State;
	self.VerifiedElementSummaryZip := le.Result.VerifiedElementSummary.Zip;
	self.VerifiedElementSummaryHomePhone := le.Result.VerifiedElementSummary.HomePhone;
	self.VerifiedElementSummaryDOB := (string)le.Result.VerifiedElementSummary.DOB;
	self.VerifiedElementSummaryDOBMatchLevel := (string)le.Result.VerifiedElementSummary.DOBMatchLevel;//dobmatchlevel
	self.VerifiedElementSummarySSN := le.Result.VerifiedElementSummary.SSN;
	self.VerifiedElementSummaryDL := le.Result.VerifiedElementSummary.DL;
	
	self.ValidElementSummarySSN := (string)le.Result.ValidElementSummary.SSNValid;
	self.ValidElementSummarySSNDeceased := (string)le.Result.ValidElementSummary.SSNDeceased;
	self.ValidElementSummaryDL := le.Result.ValidElementSummary.DLValid;
	self.ValidElementSummaryPassport := (string)le.Result.ValidElementSummary.PassportValid;
  self.ValidElementSummaryAddressCMRA := (string)le.Result.ValidElementSummary.AddressCMRA;
  self.ValidElementSummaryAddressPOBox := (string)le.Result.ValidElementSummary.AddressPOBox;
  
	self.NameAddressSSNSummary := (string)le.Result.NameAddressSSNSummary;
	
	self.ComprehensiveVerificationIndex := (string)le.Result.ComprehensiveVerificationIndex;
	
	self.CVIRiskCode1 := le.Result.CVIHighRiskIndicators[1].RiskCode;
	self.CVIDescription1 := le.Result.CVIHighRiskIndicators[1].Description;
	self.CVIRiskCode2 := le.Result.CVIHighRiskIndicators[2].RiskCode;
	self.CVIDescription2 := le.Result.CVIHighRiskIndicators[2].Description;
	self.CVIRiskCode3 := le.Result.CVIHighRiskIndicators[3].RiskCode;
	self.CVIDescription3 := le.Result.CVIHighRiskIndicators[3].Description;
	self.CVIRiskCode4 := le.Result.CVIHighRiskIndicators[4].RiskCode;
	self.CVIDescription4 := le.Result.CVIHighRiskIndicators[4].Description;
	self.CVIRiskCode5 := le.Result.CVIHighRiskIndicators[5].RiskCode;
	self.CVIDescription5 := le.Result.CVIHighRiskIndicators[5].Description;
	self.CVIRiskCode6 := le.Result.CVIHighRiskIndicators[6].RiskCode;
	self.CVIDescription6 := le.Result.CVIHighRiskIndicators[6].Description;
	self.CVIRiskCode7 := le.Result.CVIHighRiskIndicators[7].RiskCode;
	self.CVIDescription7 := le.Result.CVIHighRiskIndicators[7].Description;
	self.CVIRiskCode8 := le.Result.CVIHighRiskIndicators[8].RiskCode;
	self.CVIDescription8 := le.Result.CVIHighRiskIndicators[8].Description;
	self.CVIRiskCode9 := le.Result.CVIHighRiskIndicators[9].RiskCode;
	self.CVIDescription9 := le.Result.CVIHighRiskIndicators[9].Description;
	self.CVIRiskCode10 := le.Result.CVIHighRiskIndicators[10].RiskCode;
	self.CVIDescription10 := le.Result.CVIHighRiskIndicators[10].Description;
	self.CVIRiskCode11 := le.Result.CVIHighRiskIndicators[11].RiskCode;
	self.CVIDescription11 := le.Result.CVIHighRiskIndicators[11].Description;
	self.CVIRiskCode12 := le.Result.CVIHighRiskIndicators[12].RiskCode;
	self.CVIDescription12 := le.Result.CVIHighRiskIndicators[12].Description;
	self.CVIRiskCode13 := le.Result.CVIHighRiskIndicators[13].RiskCode;
	self.CVIDescription13 := le.Result.CVIHighRiskIndicators[13].Description;
	self.CVIRiskCode14 := le.Result.CVIHighRiskIndicators[14].RiskCode;
	self.CVIDescription14 := le.Result.CVIHighRiskIndicators[14].Description;
	self.CVIRiskCode15 := le.Result.CVIHighRiskIndicators[15].RiskCode;
	self.CVIDescription15 := le.Result.CVIHighRiskIndicators[15].Description;
	self.CVIRiskCode16 := le.Result.CVIHighRiskIndicators[16].RiskCode;
	self.CVIDescription16 := le.Result.CVIHighRiskIndicators[16].Description;
	self.CVIRiskCode17 := le.Result.CVIHighRiskIndicators[17].RiskCode;
	self.CVIDescription17 := le.Result.CVIHighRiskIndicators[17].Description;
	self.CVIRiskCode18 := le.Result.CVIHighRiskIndicators[18].RiskCode;
	self.CVIDescription18 := le.Result.CVIHighRiskIndicators[18].Description;
	self.CVIRiskCode19 := le.Result.CVIHighRiskIndicators[19].RiskCode;
	self.CVIDescription19 := le.Result.CVIHighRiskIndicators[19].Description;
	self.CVIRiskCode20 := le.Result.CVIHighRiskIndicators[20].RiskCode;
	self.CVIDescription20 := le.Result.CVIHighRiskIndicators[20].Description;
	
	self.Score1 := (string)le.Result.Models[1].Scores[1].Value;
	self.ScoreRiskCode1 := le.Result.Models[1].Scores[1].HighRiskIndicators[1].RiskCode;
	self.ScoreDescription1 := le.Result.Models[1].Scores[1].HighRiskIndicators[1].Description;
	self.ScoreRiskCode2 := le.Result.Models[1].Scores[1].HighRiskIndicators[2].RiskCode;
	self.ScoreDescription2 := le.Result.Models[1].Scores[1].HighRiskIndicators[2].Description;
	self.ScoreRiskCode3 := le.Result.Models[1].Scores[1].HighRiskIndicators[3].RiskCode;
	self.ScoreDescription3 := le.Result.Models[1].Scores[1].HighRiskIndicators[3].Description;
	self.ScoreRiskCode4 := le.Result.Models[1].Scores[1].HighRiskIndicators[4].RiskCode;
	self.ScoreDescription4 := le.Result.Models[1].Scores[1].HighRiskIndicators[4].Description;
	
	self.UniqueID := le.Result.UniqueID;
  self.errorcode := le.errorcode;
	self.seq := ri.FlexIDRequest[1].Searchby.Seq;
	self.InstantIDVersion := le.Result.InstantIDVersion;
  // add in new fields when they are wanted ... (see above layout description for subtracted out fields).
	self := [];
end;
j_f := JOIN(resu,p_f,LEFT.Result.InputEcho.Seq=RIGHT.FlexIDRequest[1].Searchby.Seq,normit(LEFT,RIGHT));

output(j_f);
// output(j_f,,'~tsteil::out::flexid_out',CSV(heading(single), quote('"')), overwrite);
// output(j_f(errorcode<>''),,'~tsteil::out::flexid_error',CSV(QUOTE('"')), overwrite);
output(j_f,,outfile_name, csv(heading(single), quote('"')), overwrite);
output(j_f(errorcode<>''),,outfile_name + '_error', csv(heading(single), quote('"')), overwrite);
