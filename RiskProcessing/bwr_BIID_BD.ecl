#workunit('name','Business IID-BD Process');
#option('hthorMemoryLimit', 1000);

IMPORT models, Risk_Indicators, Business_Risk, iesp; 

/* *****************************************************
 *                   Options Section                   *
 *******************************************************/
inputFile := '~jpyon::in::precash_1202_cons_bus_f_s_in';
outputFile := '~jpyon::out::precash_1202_biid-bd_out';

/* 
 * Number of RECORDs to run from the input file.  
 * Set to 0 to run ALL RECORDs in the input file.
 */
recordsOnInput := 0;

/* 
 * Number of parallel calls to run in the SOAPCALL to the Roxie Query 
 */
threads := 30;

/* 
 * Roxie the ECL Query is located on 
 */
roxieIP :='http://roxiebatch.br.seisint.com:9856';  // RoxieBatch

/* *****************************************************
 *                      Main Script                    *
 *******************************************************/ 
layout:= RECORD
	STRING	AccountNumber	;
	STRING	CompanyName	;
	STRING	AlternateCompanyName	;
	STRING	addr	;
	STRING	city	;
	STRING	state	;
	STRING	zip	;
	STRING	BusinessPhone	;
	STRING	TaxIdNumber	;
	STRING	BusinessIPAddress ;
	STRING	RepresentativeFirstName	;
	STRING	RepresentativeMiddleName ;
	STRING	RepresentativeLastName	;
	STRING	RepresentativeNameSuffix  ;
	STRING	RepresentativeAddr	;
	STRING	RepresentativeCity	;
	STRING	RepresentativeState	;
	STRING	RepresentativeZip	;
	STRING	RepresentativeSSN	;
	STRING	RepresentativeDOB	;
	STRING  RepresentativeAge   ;
	STRING	RepresentativeDLNumber	;
	STRING	RepresentativeDLState	;
	STRING	RepresentativeHomePhone	;
	STRING	RepresentativeEmailAddress	;
	STRING  RepresentativeFormerLastName ;
	INTEGER	HistoryDateYYYYMM;
END;

f := IF(recordsOnInput = 0, 
                DATASET(inputFile, Layout, CSV(QUOTE('"'))),
                CHOOSEN(DATASET(inputFile, Layout, csv(QUOTE('"'))), recordsOnInput));
OUTPUT(f);

Layout_BIID_SoapCall := RECORD
	STRING	AccountNumber;
	STRING	BDID;
	STRING	CompanyName;
	STRING	AlternateCompanyName;
	STRING	Addr;
	STRING	City;
	STRING	State;
	STRING	Zip;
	STRING	BusinessPhone;
	STRING	TaxIdNumber;
	STRING	BusinessIPAddress;
	STRING	RepresentativeFirstName;
	STRING	RepresentativeMiddleName;
	STRING	RepresentativeLastName;
	STRING	RepresentativeNameSuffix;
	STRING	RepresentativeAddr;
	STRING	RepresentativeCity;
	STRING	RepresentativeState;
	STRING	RepresentativeZip;
	STRING	RepresentativeSSN;
	STRING	RepresentativeDOB;
	STRING	RepresentativeAge;
	STRING	RepresentativeDLNumber;
	STRING	RepresentativeDLState;
	STRING	RepresentativeHomePhone;
	STRING	RepresentativeEmailAddress;
	STRING 	RepresentativeFormerLastName;
	INTEGER	HistoryDateYYYYMM;
	UNSIGNED1	DPPAPurpose;
	UNSIGNED1	GLBPurpose;
	DATASET(Models.Layout_Score_Chooser) scores;
	STRING DataRestrictionMask;
	
	BOOLEAN OfacOnly;
  BOOLEAN ExcludeWatchlists;
	INTEGER OFACversion;
	BOOLEAN IncludeOfac;
	BOOLEAN IncludeAdditionalWatchLists;
	REAL GlobalWatchlistThreshold;
  dataset(risk_indicators.Layout_Gateways_In) gateways;
  dataset(iesp.share.t_StringArrayItem) Watchlist {xpath('Watchlist/Row/WatchList/Name')};
  REAL _espclientinterfaceversion;
	BOOLEAN PoBoxCompliance;
	INTEGER DOBradius;
  BOOLEAN usedobfilter;

END;

Layout_BIID_SoapCall into_bus_input(f le) := TRANSFORM
	SELF.dppapurpose := 3;
	SELF.glbpurpose := 1;
	SELF.scores := DATASET([{'Models.BusinessAdvisor_Service', roxieIP,[]}], models.Layout_Score_Chooser);

  SELF.HistoryDateYYYYMM := (Integer) le.historydateyyyymm[1..6];	
	// SELF.HistoryDateyyyymm:=999999;

	SELF.DataRestrictionMask := '0000000000000000000000000';	// byte 6, if 1, restricts experian, byte 8, if 1, restricts equifax, 
																								// byte 10 restricts Transunion, 12 restricts ADVO, 13 restricts bureau deceased data
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
  
	SELF.PoBoxCompliance := FALSE;
	SELF.OfacOnly := FALSE;
  SELF.ExcludeWatchLists := FALSE;
	SELF.OFACversion := 2;
	SELF.IncludeOfac := FALSE; // only used if _espclientinterfaceversion is less than 1.49
	SELF.IncludeAdditionalWatchLists := FALSE; // only used if _espclientinterfaceversion is less than 1.49
	SELF.GlobalWatchlistThreshold := 0.84;
	self.watchlist := dataset([{''}],iesp.share.t_StringArrayItem); // when wanting no watchlists ran use this
  // self.watchlist := dataset([{'OFAC'}],iesp.share.t_StringArrayItem); // identical to having includeofac = true and includeadditionalwatchlists = false
  // self.watchlist := dataset([{'ALL'}],iesp.share.t_StringArrayItem); // identical to having includeofac = true and includeadditionalwatchlists = true or includeofac = false and 
																																				// includeadditionalwatchlists = true
  // self.watchlist := dataset([{'OFAC'}],iesp.share.t_StringArrayItem) +
									  // dataset([{'BES'}],iesp.share.t_StringArrayItem); // use this if you need more than one watchlist, but not all of them
  // NO GATEWAY
  SELF.gateways := []; // use this one for when No OFAC/Watchlist searching is required 
//CERT
  // self.gateways := dataset([{'bridgerwlc', 'http://bridger_batch_cert:Br1dg3rBAtchC3rt@172.16.70.19:7003/WsSearchCore?ver_=1'}], risk_indicators.Layout_Gateways_In);  // CERT use this one to run OFAC/Watchlist Version 4 searching  
  SELF._espclientinterfaceversion := 2.16;
	SELF.usedobfilter := FALSE;
  SELF.DOBradius := 2;

	// possible input options 'FuzzyCCYYMMDD','FuzzyCCYYMM''ExactCCYYMMDD''ExactCCYYMM''RadiusCCYY', if using the radius, then 0-3 is the range
	// SELF.DOBMatchOptions := DATASET([{'RadiusCCYY','3'}], risk_indicators.layouts.Layout_DOB_Match_Options);

	SELF := le;
	SELF := [];
END;

indata := PROJECT(f, into_bus_input(LEFT));
OUTPUT(indata, NAMED('biid_in'));

errx := RECORD
	STRING errorcode := '';
	business_risk.Layout_Final_Denorm - score - BusRiskIndicators - RepRiskIndicators;  // requested to take the score field out of the layout during testprocessing because batch customers don't see it
	DATASET(Models.Layout_Model) models;
END;

errx err_out(indata L) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF.company_name := L.companyname;
	SELF.addr1 := L.addr;
	SELF.p_city_name := L.city;
	SELF.st := L.state;
	SELF.z5 := L.zip;
	SELF.phone10 := L.businessphone;
	SELF := L;
	SELF := [];
END;

results := SOAPCALL(indata, 
                    roxieIP,
                    'Business_Risk.InstantID_Service', 
                    {indata},
                    DATASET(errx), 
                    RETRY(5), TIMEOUT(500), LITERAL,
                    XPATH('Business_Risk.InstantID_ServiceResponse/Results/Result/Dataset[@name=\'Result 1\']/Row'),
                    PARALLEL(threads), 
                    onfail(err_out(LEFT))
                   );


OUTPUT(results, NAMED('biid_results'));
OUTPUT(results(errorcode!=''), NAMED('biid_errors'));

Chase_Rep_Attributes := RECORD
	STRING1 Rep_Lien_Unrel_Lvl := ''; // 0-5
	STRING1 Rep_Prop_Owner := ''; // 0-2
	STRING2 Rep_Prof_License_Category := ''; // (-1)-5
	STRING1 Rep_Accident_Count := ''; // 0-3
	STRING1 Rep_Paydayloan_Flag := ''; // BOOLEAN (0-1)
	STRING2 Rep_Age_Lvl := ''; // 18, 25, 35, 45, 46
	STRING1 Rep_Bankruptcy_Count := ''; // 0-3
	STRING1 Rep_Ssns_Per_Adl := ''; // 0-4
	STRING1 Rep_Past_Arrest := ''; // BOOLEAN (0-1)
	STRING3 Rep_Add1_Lres_Lvl := ''; // 0, 12, 24, 48, 72, 96, 192, 193
	STRING1 Rep_Criminal_Assoc_Lvl := ''; // 0, 1, 3, 4
	STRING1 Rep_Felony_Count := ''; // 0-2
END;

ox := RECORD
	business_risk.layout_final_Batch - score - Chase_Rep_Attributes;
END;

// Score fields  Note: score[1] equals a 0-999 score range
// Score fields  Note: score[2] equals a 010-050 score range
// Score fields  Note: score[3] equals a 10-90 score range *** Use as Default ***

ox final_tf(results L) := TRANSFORM
	SELF.Acctno := L.account;
  
	SELF.fd_score3:=(STRING)(INTEGER)L.Models[1].scores[3].i;
	SELF.fd_Reason1:=L.Models[1].scores[1].reason_codes[1].reason_code;
	SELF.fd_Desc1 := L.Models[1].scores[1].reason_codes[1].Reason_Description;
	SELF.fd_Reason2:=L.Models[1].scores[1].reason_codes[2].reason_code;
	SELF.fd_Desc2  :=L.Models[1].scores[1].reason_codes[2].Reason_Description;
	SELF.fd_Reason3:=L.Models[1].scores[1].reason_codes[3].reason_code;
	SELF.fd_Desc3  :=L.Models[1].scores[1].reason_codes[3].Reason_Description;
	SELF.fd_Reason4:=L.Models[1].scores[1].reason_codes[4].reason_code;
	SELF.fd_Desc4  :=L.Models[1].scores[1].reason_codes[4].Reason_Description;
	SELF:=L;
  SELF:=[];
END;

j_f := PROJECT(results,final_tf(LEFT));
OUTPUT(j_f,NAMED('OUTPUT'));
OUTPUT(j_f,, outputFile, CSV(HEADING(single), QUOTE('"')), OVERWRITE);