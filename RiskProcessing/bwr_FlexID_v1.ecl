#workunit('name','FlexID Process v1');
// #option ('hthorMemoryLimit', 1000)

import Models, risk_indicators, riskwise, iesp, ut;

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


INFILE := '~tfuerstenberg::in::rent_8885_puerto_rico_in.csv';
OUTFILE := '~tfuerstenberg::out::rent_8885_puerto_rico_flexidv1' + thorlib.wuid();

// f := DATASET(INFILE,prii_layout,csv(quote('"')));
f := choosen(DATASET(INFILE,prii_layout,csv(quote('"'))),10);
output(f);

// verSSN on/off: On for Google only
include_VerSSN := False;

// ---------------------------------------------------------------------------------------
// FraudPoint score selection
//
// **** No Scores
score := dataset([], models.Layout_Score_Chooser);

// **** FP FP3710_0
// score := dataset([{'Models.FraudAdvisor_Service', riskwise.shortcuts.staging_neutral_roxieip,
                    // dataset ([{'Version','FP1109_0'},{'includeriskindices','1'}],models.Layout_Parameters)
                 // }], models.Layout_Score_Chooser);
                 

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
	boolean IIDVersionOverride;
	string _CompanyID;
	unsigned HistoryDateYYYYMM;
	string20 HistoryDateTimeStamp;
  boolean OfacOnly;
  boolean ExcludeWatchLists;
	integer OFACversion;
	boolean IncludeOfac;
	boolean IncludeAdditionalWatchLists;
	real GlobalWatchlistThreshold;
  dataset(iesp.share.t_StringArrayItem) Watchlist {xpath('Watchlist/Row/WatchList/Name')};
  real _espclientinterfaceversion;
end;


include_DigitalInsights := false;  // new setting in CIID enhancements Fall 2019.  Default to false
UseTargusGateway := false;


layout_soap t_f(f le, INTEGER c) := TRANSFORM
	self.originalAccount := le.accountnumber;
	
	// self.gateways := dataset([], risk_indicators.Layout_Gateways_In);

	self.gateways := riskwise.shortcuts.gw_insurancephoneheader + 
									if(include_DigitalInsights, riskwise.shortcuts.gw_threatmetrix) + 
									if(UseTargusGateway, riskwise.shortcuts.gw_targus_sco);
	
//__________________________________________________________________________________________________________________________________________________________________________ 
/* **** Use if Targus and InsurancePhoneHeader are needed  **** */

//__________________________________________________________________________________________________________________________________________________________________________            
	// self.gateways := dataset([{'targus','http://rw_data_prod:Password01@gatewayprodesp.sc.seisint.com:7726/wsGateway/?ver_=1.70'}], risk_indicators.Layout_Gateways_In);

	// for production runs, use the production gateway
	// self.gateways := dataset([{'insurancephoneheader','http://rw_score_dev:Password01@gatewaycertesp.sc.seisint.com:7526/WsPrism/?ver_=1.82'}], risk_indicators.Layout_Gateways_In);
// self.gateways := dataset([{'bridgerwlc', 'http://bridger_batch_cert:Br1dg3rBAtchC3rt@172.16.70.19:7003/WsSearchCore?ver_=1'}], Gateway.Layouts.Config);  // CERT use this one to run OFAC/Watchlist Version 4 searching  
	
//__________________________________________________________________________________________________________________________________________________________________________ 
/* **** Use if Targus and InsurancePhoneHeader are needed  **** */
// self.gateways := dataset([{'targus','http://rw_data_prod:Password01@gatewayprodesp.sc.seisint.com:7726/wsGateway/?ver_=1.70'}
           // ,{'insurancephoneheader','http://rw_score_dev:Password01@gatewaycertesp.sc.seisint.com:7526/WsPrism/?ver_=1.82'}], risk_indicators.Layout_Gateways_In);
//__________________________________________________________________________________________________________________________________________________________________________            
/* **** Use if Targus and Watchlists are needed  **** */

// self.gateways := dataset([{'targus','http://rw_data_prod:Password01@gatewayprodesp.sc.seisint.com:7726/wsGateway/?ver_=1.70'}
           // ,{'bridgerwlc', 'http://bridger_batch_cert:Br1dg3rBAtchC3rt@172.16.70.19:7003/WsSearchCore?ver_=1'}], risk_indicators.Layout_Gateways_In);
//__________________________________________________________________________________________________________________________________________________________________________ 
/* **** Use if Watchlists and InsurancePhoneHeader are needed  **** */

// self.gateways := dataset([{'bridgerwlc', 'http://bridger_batch_cert:Br1dg3rBAtchC3rt@172.16.70.19:7003/WsSearchCore?ver_=1'}
           // ,{'insurancephoneheader','http://rw_score_dev:Password01@gatewaycertesp.sc.seisint.com:7526/WsPrism/?ver_=1.82'}], risk_indicators.Layout_Gateways_In);
//__________________________________________________________________________________________________________________________________________________________________________           
 /* **** Use if Targus, InsurancePhoneHeader, and Watchlists are needed are needed  **** */
 
// self.gateways := dataset([{'targus','http://rw_data_prod:Password01@gatewayprodesp.sc.seisint.com:7726/wsGateway/?ver_=1.70'}
// ,{'insurancephoneheader','http://rw_score_dev:Password01@gatewaycertesp.sc.seisint.com:7526/WsPrism/?ver_=1.82'}
// ,{'bridgerwlc', 'http://bridger_batch_cert:Br1dg3rBAtchC3rt@172.16.70.19:7003/WsSearchCore?ver_=1'}], risk_indicators.Layout_Gateways_In);
//__________________________________________________________________________________________________________________________________________________________________________ 

/*	
ESP WITH WATCHLISTS INSTRUCTIONS AND USAGE

Being introduced in the 10/23/18 release if you are wanting proper watchlist hits you must input the proper ESP version. This will be done by defining which version of the ESP you want 
by putting it in where the ESP version is defined in the script. There are different options to select based on what kind of watchlist hits you want for each version of ESP. Also to 
note is that when wanting version 4 of OFAC the bridgerwlc gateway will need to be used. An example of how to do this will be shown in the script where gateways are defined.  
Defined below are definitions for watchlist terms and what terms work with ESP options. 
---------------------------------------------------------------------------------------------------------------------------

WATCHLIST DEFINITIONS

OFAConly - this makes it so only OFAC hits are returned, this should not be used with IncludeOfac, IncludeAdditionalWatchlists, and Watchlist as it was created for use only in version 1 of OFAC, can be set to either true or false  

ExcludeWatchlists - this will make it so no watchlists are ever returned, this function only works with OFACversion equal to 1, can be set to either true or false

IncludeOFAC - this makes it so only OFAC hits are returned, this function only works with OFACversions >= 2, can be set to either true or false, simliar to only requesting OFAC in the watchlist dataset

IncludeAdditionalWatchlists - this makes it so other watchlist outside of OFAC are returned, this functon only works with OFACversions >= 2, can be set to either true or false, combined with IncludeOFAC it is similar to running ALL in the watchlist dataset

Watchlist - this allows to input a watchlist or watchlist(s) that you specifically want to search. Examples of possible input are ALL - all watchlists, ALLV4 - all watchlists including new bridger ones, OFAC - just OFAC watchlists, BES - just BES watchlist, etc. 
--------------------------------------------------------------------------------------------------------------------------

WATCHLIST TERMS COMPATIBILITY WITH ESP VERSIONS

ESP version < 1.39 which applies to IID/BIID and Patriot - OFACversion, OFAConly, ExcludeWatchlists

ESP version >= 1.039 and < 1.49 which only applies to IID/BIID - OFACversion, IncludeOFAC, IncludeAdditionalWatchlists

ESP version >= 1.49 which applies to IID/BIID and Patriot -  OFACversion, Watchlist
*/

	self.OfacOnly := false;
  self.ExcludeWatchLists := false;
	self.OFACversion := 2;
	self.IncludeOfac := false; // only used if _espclientinterfaceversion is less than 1.49
	self.IncludeAdditionalWatchLists := false; // only used if _espclientinterfaceversion is less than 1.49
	self.GlobalWatchlistThreshold := 0.84;
  self.watchlist := dataset([{''}],iesp.share.t_StringArrayItem); // when wanting no watchlists ran use this
  // self.watchlist := dataset([{'OFAC'}],iesp.share.t_StringArrayItem); // identical to having includeofac = true and includeadditionalwatchlists = false
  // self.watchlist := dataset([{'ALL'}],iesp.share.t_StringArrayItem); // identical to having includeofac = true and includeadditionalwatchlists = true or includeofac = false and 
																																				// includeadditionalwatchlists = true
  // self.watchlist := dataset([{'OFAC'}],iesp.share.t_StringArrayItem) +
									  // dataset([{'BES'}],iesp.share.t_StringArrayItem); // use this if you need more than one watchlist, but not all of them
  self._espclientinterfaceversion := 2.16;
 

	self.FlexIDRequest := project(ut.ds_oneRecord,
					transform(iesp.flexid.t_FlexIDRequest, 
 
								self.user.queryid := le.AccountNumber;
								self.user.AccountNumber := le.AccountNumber;
								self.user.GLBPurpose := (string)riskwise.permittedUse.fraudGLBA; 
								self.user.DLPurpose := (string)riskwise.permittedUse.fraudDPPA; 
								self.user.DataRestrictionMask := '0000000000000000000000000';
								self.user.TestDataEnabled := false;
							 
							//To Turn on OFAC or add any additional watchlists, uncomment out line 164 and comment out line 166. Default is off
             	// self.options.WatchLists := dataset([{'OFAC'}], iesp.share.t_StringArrayItem); 
							 
								self.options.WatchLists := dataset([], iesp.share.t_StringArrayItem); 
								self.options.UseDOBFilter := false; 
								self.options.DOBRadius := 0; 
								self.options.IncludeMSOverride := false; 
								self.options.DisallowTargusEID3220 := true;  // false turns ON targus cellphone searching
								self.options.PoBoxCompliance := false; 
								self.options.RequireExactMatch.LastName := false;
								self.options.RequireExactMatch.FirstName := false; 
								self.options.RequireExactMatch.FirstNameAllowNickname := false; 
								self.options.RequireExactMatch.HomePhone := false; 
								self.options.RequireExactmatch.SSN := false; 
								self.options.RequireExactmatch.Address := false;
								// self.options.RequireExactmatch.DOB := false;
								// self.options.RequireExactmatch.DriverLicense := false;
								self.options.IncludeAllRiskIndicators := true; 
								self.options.IncludeVerifiedElementSummary := true; 
								self.options.IncludeDLVerification := true;
								self.options.DOBMatch.MatchType := '';
								self.options.DOBMatch.MatchYearRadius := 0; 
								
								// new v1 fields
								self.options.CustomCVIModelName := '';
								self.options.LastSeenThreshold := (string)risk_indicators.iid_constants.oneyear;	// 365, this needs to be specified in number of days
								self.options.IncludeMIOverride := false;
								self.options.IncludeSSNVerification := if(include_VerSSN, true, false);  // controlled by flag in line 38
								self.options.CVICalculationOptions.IncludeDOB := true;	// this allows the DOB verification to possibly increase the CVI by 10
								self.options.CVICalculationOptions.IncludeDriverLicense := true;	// this allows the DL verification to possibly increase CVI by 10
								self.options.CVICalculationOptions.DisableCustomerNetworkOption := false;	// if true, disables the inquiry data in the NAP calculation
								self.options.DisallowInsurancePhoneHeaderGateway := false;	// if true, disables the insurance header gateway in the NAP calculation
								self.options.InstantIDVersion := '1';
								// new Emerging Identities fields
								self.options.EnableEmergingId := false;	// if true, does additional DID searching (for AmEx primarily)
								self.options.NameInputOrder := '';	// if customer wants to specify the order of input name
																										//   options are 'fml' or 'lfm' - anything else defaults to standard

																										
								self.options.IncludeEmailVerification := false;
								self.options.DisableNonGovernmentDLData := false;
								self.options.IncludeDigitalIdentity := include_DigitalInsights;  
								
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

								self := []
								));

							
	self.scores := score; // this is where you ask for the scores, it is being set above
	
	self.IIDVersionOverride := false;	// as of now, not used, will be used when version 1 is forced by product
	self._CompanyID := 'NTJ';	// this will get logged on the insurance side when the insurance gateway is called, NickTimJustin, just want it so we can identify your team vs real customer

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
end;
p_f := project(f, t_f(left, counter));
output(p_f, named('CIID_Input'));

dist_dataset := distribute(p_f, random());


roxieIP :='http://roxiebatch.br.seisint.com:9856';  // roxiebatch


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

			
resu := soapcall(dist_dataset, roxieIP,
				'Risk_Indicators.FlexID_Service', {dist_dataset}, 
				DATASET(xlayout),
				RETRY(2), TIMEOUT(500), LITERAL,
				XPATH('Risk_Indicators.FlexID_ServiceResponse/Results/Result/Dataset[@name=\'Results\']/Row'),
				PARALLEL(30), onFail(myFail(LEFT)));		

output(resu, named('resu'));



LayoutFlexIDOut := RECORD
	risk_indicators.LayoutsFlexID.LayoutFlexIDBatchOut;
	STRING errorcode;
END;


LayoutFlexIDOut normit(resu le, p_f ri) := transform
	self.Acctno := ri.originalAccount;
	
	self.NameAddressPhoneSummary := le.Result.NameAddressPhone.Summary;
	self.NameAddressPhoneType := le.Result.NameAddressPhone._Type;
	self.NameAddressPhoneStatus := le.Result.NameAddressPhone.Status;
	
	self.VerifiedElementSummaryFirstName := le.Result.VerifiedElementSummary.FirstName;
	self.VerifiedElementSummaryMiddleName := if(le.Result.VerifiedElementSummary.MiddleName, '1', '0');
	self.VerifiedElementSummaryLastName := le.Result.VerifiedElementSummary.LastName;
	self.VerifiedElementSummaryStreetAddress := le.Result.VerifiedElementSummary.StreetAddress;
	self.VerifiedElementSummaryCity := le.Result.VerifiedElementSummary.City;
	self.VerifiedElementSummaryState := le.Result.VerifiedElementSummary.State;
	self.VerifiedElementSummaryZip := le.Result.VerifiedElementSummary.Zip;
	self.VerifiedElementSummaryHomePhone := le.Result.VerifiedElementSummary.HomePhone;
	self.VerifiedElementSummaryDOB := if(le.Result.VerifiedElementSummary.DOB=true, '1', '0');  //(string)le.Result.VerifiedElementSummary.DOB;
	self.VerifiedElementSummaryDOBMatchLevel := (string)le.Result.VerifiedElementSummary.DOBMatchLevel;//dobmatchlevel
	self.VerifiedElementSummarySSN := le.Result.VerifiedElementSummary.SSN;
	self.VerifiedElementSummaryDL := le.Result.VerifiedElementSummary.DL;
	self.VerifiedElementSummaryEmail := if(le.Result.VerifiedElementSummary.Email, '1', '0');
	
	self.ValidElementSummarySSN := (string)le.Result.ValidElementSummary.SSNValid;
	self.ValidElementSummarySSNDeceased := (string)le.Result.ValidElementSummary.SSNDeceased;
	self.ValidElementSummaryDL := le.Result.ValidElementSummary.DLValid;
	self.ValidElementSummaryPassport := (string)le.Result.ValidElementSummary.PassportValid;
  self.ValidElementSummaryAddressCMRA := (string)le.Result.ValidElementSummary.AddressCMRA;
  self.ValidElementSummaryAddressPOBox := (string)le.Result.ValidElementSummary.AddressPOBox;
	self.ValidElementSummarySSNFoundForLexID := (string)le.Result.ValidElementSummary.SSNFoundForLexID;
  
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
	self.ScoreRiskCode5 := le.Result.Models[1].Scores[1].HighRiskIndicators[5].RiskCode;
	self.ScoreDescription5 := le.Result.Models[1].Scores[1].HighRiskIndicators[5].Description;
	self.ScoreRiskCode6 := le.Result.Models[1].Scores[1].HighRiskIndicators[6].RiskCode;
	self.ScoreDescription6 := le.Result.Models[1].Scores[1].HighRiskIndicators[6].Description;
	
	self.StolenIdentityIndex := le.Result.Models[1].Scores[1].RiskIndices[1].value[1];
	self.SyntheticIdentityIndex := le.Result.Models[1].Scores[1].RiskIndices[2].value[1];
	self.ManipulatedIdentityIndex := le.Result.Models[1].Scores[1].RiskIndices[3].value[1];
	self.VulnerableVictimIndex := le.Result.Models[1].Scores[1].RiskIndices[4].value[1];
	self.FriendlyFraudIndex := le.Result.Models[1].Scores[1].RiskIndices[5].value[1];
	self.SuspiciousActivityIndex := le.Result.Models[1].Scores[1].RiskIndices[6].value[1];
	self.UniqueID := le.Result.UniqueID;
	self.verSSN := le.Result.VerifiedSSN;
	self.cviCustomScore := '';
	self.InstantIDVersion := le.Result.InstantIDVersion;
	self.EmergingID := le.Result.EmergingID;
	self.AddressSecondaryRangeMismatch := le.Result.AddressSecondaryRangeMismatch;
	
  self.BureauDeleted :=le.result.BureauDeleted;
  self.ITINExpired :=le.result.ITINExpired;
  self.IsPhoneCurrent :=le.result.IsPhoneCurrent;
  self.PhoneLineType :=le.result.PhoneLineType;
  self.PhoneLineDescription :=le.result.PhoneLineDescription;	
		
  self.errorcode := le.errorcode;
	self.seq := ri.FlexIDRequest[1].Searchby.Seq;

end;
j_f := JOIN(resu,p_f,LEFT.Result.InputEcho.Seq=RIGHT.FlexIDRequest[1].Searchby.Seq,normit(LEFT,RIGHT));

/*---------------------------------------------------------------*/
/* To remove verssn */
Layout_no_verssn := RECORD
	string10 seq;
	string30 acctno;
	Risk_Indicators.LayoutsFlexId.LayoutNameAddressPhone;
	Risk_Indicators.LayoutsFlexId.LayoutVerifiedElementSummary;
	Risk_Indicators.LayoutsFlexId.LayoutValidElementSummary;
	string2 NameAddressSSNSummary;
	Risk_Indicators.LayoutsFlexId.LayoutCVI;
	Risk_Indicators.LayoutsFlexId.LayoutModel;
	string1 StolenIdentityIndex;
	string1 SyntheticIdentityIndex;
	string1 ManipulatedIdentityIndex;
	string1 VulnerableVictimIndex;
	string1 FriendlyFraudIndex;
	string1 SuspiciousActivityIndex;
	string12 UniqueID;
	string1 ValidElementSummarySSNFoundForLexID;
	string3 cviCustomScore;
	string1 InstantIDVersion;	// output the version that was run
	boolean EmergingID;
	string1 AddressSecondaryRangeMismatch;	// New for EmergingIdentities	
  boolean BureauDeleted;
  boolean ITINExpired;
  boolean IsPhoneCurrent;
  string2 PhoneLineType;
  string2 PhoneLineDescription; 
	string errorcode;
END;

no_verssn_j_f := PROJECT(j_f, layout_no_verssn);
/*-------------------------------------------------------------*/
output(j_f, named('With_verSSN'));
output(no_verssn_j_f, named('Without_verSSN'));
/* if statements control whether verSSN or no-verSSN dataset is written to file */
if(
	(boolean) include_verssn,
	output(j_f,,OUTFILE,CSV(heading(single), quote('"'))),
	output(no_verssn_j_f,,OUTFILE,CSV(heading(single), quote('"')))
	);
if(
  (boolean) include_verssn,
	output(j_f(errorcode<>''),,OUTFILE+'_error',CSV(QUOTE('"'))),
	output(no_verssn_j_f(errorcode<>''),,OUTFILE+'_error',CSV(QUOTE('"')))

	);