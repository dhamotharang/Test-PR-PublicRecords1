#workunit('name','File prep for Innovis');
//
//The purpose of this script is to read a file of input PII and append best SSN to any record that does not have a valid SSN populated on input.  This file will then get sent to IDA and then to Innovis
//for appending the Innovis attributes for Analytics to possibly build models off of

import Models, risk_indicators, riskwise, iesp, _control, std, doxie;

//
//*** A few options and settings that you may want to alter 
//
eyeball             := 25;
Threads             := 30;
RecordsToRun        := 25; // Set to 0 to run all, otherwise set to the number of records from the inputFile you wish to run
roxieIP             := riskwise.shortcuts.prod_batch_analytics_roxie;
DataRestrictionMask := '100001000100010000000000';
inputFileName       :=  '~foreign::' + _control.IPAddress.prod_thor_dali + '::' +'jpyon::in::dm_8062_z23_p1_f_s_in.csv';
// inputFileName       := '~jpyon::in::dm_8062_z23_p1_f_s_in.csv';
outputFileName      := '~tfuerstenberg::out::prep_file_for_Innovis';

//
//*** From here on down, none of this code should ever need to be changed/altered
//

//define the input layout
prii_layout := RECORD
	STRING Account;
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
  string IPaddress;
END;

//select the records for processing - either the full file or a selected count of records
input_file := IF(RecordsToRun <= 0, DATASET(inputFileName, prii_layout, CSV(QUOTE('"'))),
																	  CHOOSEN(DATASET(inputFileName, prii_layout, CSV(QUOTE('"'))), RecordsToRun));
output(CHOOSEN(input_file, eyeball), NAMED('input_file'));

//define invalid SSN values
invalid_SSNs  := ['000000000', '111111111', '222222222', '333333333', '444444444', '555555555', '666666666', '777777777', '888888888', '999999999']; 

//filter out records that already have a good SSN - they will skip processing and just get added back to the final output file at the end 
good_SSNs := input_file(LENGTH(TRIM(STD.Str.Filter(ssn, '0123456789'))) = 9 AND STD.Str.Filter(ssn, '0123456789') NOT IN invalid_SSNs);
output(CHOOSEN(good_SSNs, eyeball), NAMED('good_SSNs'));
output(COUNT(good_SSNs), NAMED('count_good_SSNs'));

//identify the records with invalid/no SSN - these are the records that will go through the rest of the process
bad_SSNs  := input_file(LENGTH(TRIM(STD.Str.Filter(ssn, '0123456789'))) <> 9 OR STD.Str.Filter(ssn, '0123456789') IN invalid_SSNs);
output(CHOOSEN(bad_SSNs, eyeball), NAMED('bad_SSNs'));
output(COUNT(bad_SSNs), NAMED('count_bad_SSNs'));

//define layout with unique sequence number added
prii_layout_wSeq := RECORD
	string seq;
	prii_layout;
END;

//add a unique sequence number to each record
prii_layout_wSeq intoInputwSeq(bad_SSNs le, INTEGER c) := TRANSFORM
	SELF.seq  := (string)c;
	SELF      := le;
END;

bad_SSNs_wSeq := PROJECT(bad_SSNs, intoInputwSeq(LEFT,COUNTER));
OUTPUT(CHOOSEN(bad_SSNs_wSeq, eyeball), NAMED('bad_SSNs_wSeq'));

//
//We need a LexID before we can append the best SSN.  To get LexID we are calling the FlexID query.  Here starts the code to make that call.
//

//define the SOAP layout for FlexID
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

//some hard coded options that FlexID requires - set to default
include_VerSSN          := False;
score                   := dataset([], models.Layout_Score_Chooser);
include_DigitalInsights := false;  
UseTargusGateway        := false;

//use a project to transform the input records into the SOAP layout for FlexID. We need only bare bones FlexID to get LexID so set all other options that we don't need to "off".
layout_soap tform_into_soap(bad_SSNs_wSeq le, INTEGER c) := TRANSFORM
	self.originalAccount              := le.account;
	self.gateways                     := dataset([], risk_indicators.Layout_Gateways_In);
	self.OfacOnly                     := false;
  self.ExcludeWatchLists            := true;
	self.OFACversion                  := 2;
	self.IncludeOfac                  := false;
	self.IncludeAdditionalWatchLists  := false; 
	self.GlobalWatchlistThreshold     := 0.84;
  self.watchlist                    := dataset([{''}],iesp.share.t_StringArrayItem); 
  self._espclientinterfaceversion   := 2.16;
	self.FlexIDRequest := DATASET([
			transform(iesp.flexid.t_FlexIDRequest, 
          self.user.queryid                                     := le.Account;
          self.user.AccountNumber                               := le.Account;
          self.user.GLBPurpose                                  := (string)riskwise.permittedUse.fraudGLBA; 
          self.user.DLPurpose                                   := (string)riskwise.permittedUse.fraudDPPA; 
          self.user.DataRestrictionMask                         := DataRestrictionMask;
          self.user.TestDataEnabled                             := false;
          self.options.WatchLists                               := dataset([], iesp.share.t_StringArrayItem); 
          self.options.UseDOBFilter                             := false; 
          self.options.DOBRadius                                := 0; 
          self.options.IncludeMSOverride                        := false; 
          self.options.DisallowTargusEID3220                    := true;  
          self.options.PoBoxCompliance                          := false; 
          self.options.RequireExactMatch.LastName               := false;
          self.options.RequireExactMatch.FirstName              := false; 
          self.options.RequireExactMatch.FirstNameAllowNickname := false; 
          self.options.RequireExactMatch.HomePhone              := false; 
          self.options.RequireExactmatch.SSN                    := false; 
          self.options.RequireExactmatch.Address                := false;
          self.options.RequireExactmatch.DOB                    := false;
          self.options.RequireExactmatch.DriverLicense          := false;
          self.options.IncludeAllRiskIndicators                 := true; 
          self.options.IncludeVerifiedElementSummary            := true; 
          self.options.IncludeDLVerification                    := true;
          self.options.DOBMatch.MatchType                       := '';
          self.options.DOBMatch.MatchYearRadius                 := 0; 
          self.options.CustomCVIModelName                       := '';
          self.options.LastSeenThreshold                        := (string)risk_indicators.iid_constants.oneyear;	
          self.options.IncludeMIOverride                        := false;
          self.options.IncludeSSNVerification                   := if(include_VerSSN, true, false);  
          self.options.CVICalculationOptions.IncludeDOB         := false;	  
          self.options.CVICalculationOptions.IncludeDriverLicense := false;	
          self.options.CVICalculationOptions.DisableCustomerNetworkOption := true;	
          self.options.DisallowInsurancePhoneHeaderGateway      := true;	  
          self.options.InstantIDVersion                         := '1';
          self.options.EnableEmergingId                         := false;	  
          self.options.NameInputOrder                           := '';	   
          self.options.IncludeEmailVerification                 := false;
          self.options.DisableNonGovernmentDLData               := true;
          self.options.IncludeDigitalIdentity                   := include_DigitalInsights;  
          self.searchby.Seq                                     := le.Seq;
          self.searchby.Name.Full                               := ''; 
          self.searchby.Name.First                              := le.FirstName; 
          self.searchby.Name.Middle                             := le.MiddleName; 
          self.searchby.Name.Last                               := le.LastName; 
          self.searchby.Name.Suffix                             := '';
          self.searchby.Name.Prefix                             := ''; 
          self.searchby.Address.StreetNumber                    := ''; 
          self.searchby.Address.StreetPreDirection              := ''; 
          self.searchby.Address.StreetName                      := ''; 
          self.searchby.Address.StreetSuffix                    := ''; 
          self.searchby.Address.StreetPostDirection             := ''; 
          self.searchby.Address.UnitDesignation                 := ''; 
          self.searchby.Address.UnitNumber                      := ''; 
          self.searchby.Address.StreetAddress1                  := le.StreetAddress; 
          self.searchby.Address.StreetAddress2                  := ''; 
          self.searchby.Address.City                            := le.City; 
          self.searchby.Address.State                           := le.State; 
          self.searchby.Address.Zip5                            := le.Zip; 
          self.searchby.Address.Zip4                            := ''; 
          self.searchby.Address.County                          := ''; 
          self.searchby.Address.PostalCode                      := ''; 
          self.searchby.Address.StateCityZip                    := ''; 
          self.searchby.DOB.Year                                := (unsigned)le.DateOfBirth[1..4]; 
          self.searchby.DOB.Month                               := (unsigned)le.DateOfBirth[5..6];
          self.searchby.DOB.Day                                 := (unsigned)le.DateOfBirth[7..8]; 
          self.searchby.Age                                     := 0; 
          self.searchby.SSN                                     := le.SSN; 
          self.searchby.SSNLast4                                := ''; 
          self.searchby.DriverLicenseNumber                     := le.DLNumber; 
          self.searchby.DriverLicenseState                      := le.DLState; 
          self.searchby.IPAddress                               := ''; 
          self.searchby.HomePhone                               := le.HomePhone; 
          self.searchby.WorkPhone                               := le.WorkPhone; 
          self.searchby.Passport.MachineReadableLine1           := '';
          self.searchby.Passport.MachineReadableLine2           := '';
          self.searchby.Gender                                  := '';
          self := [])]
          );
	self.scores               := score; 
	self.IIDVersionOverride   := false;	
	self._CompanyID           := '';	
  self.historydateyyyymm    := 999999;  
	self.historyDateTimeStamp := '';   
end;

soap_input := project(bad_SSNs_wSeq, tform_into_soap(left, counter));
output(CHOOSEN(soap_input, eyeball), NAMED('soap_input'));

//distribute the SOAP request file
dist_dataset := distribute(soap_input, random());

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

//make the call to FlexID			
resu := soapcall(dist_dataset, roxieIP,
				'Risk_Indicators.FlexID_Service', {dist_dataset}, 
				DATASET(xlayout),
				RETRY(2), TIMEOUT(500), LITERAL,
				XPATH('Risk_Indicators.FlexID_ServiceResponse/Results/Result/Dataset[@name=\'Results\']/Row'),
				PARALLEL(Threads), onFail(myFail(LEFT)));		
output(CHOOSEN(resu, eyeball), NAMED('resu'));

//define input layout with LexID appended
prii_layout_wDID := RECORD
	unsigned6 LexID;
	prii_layout_wSeq;
END;

//use a join to append the LexID from FlexID back to the original file
prii_layout_wDID appendDID(bad_SSNs_wSeq le, resu ri) := transform
	self.LexID := (unsigned6)ri.result.UniqueId;
	self := le;
end;

withLexID := JOIN(bad_SSNs_wSeq,resu,
                  LEFT.Seq = RIGHT.Result.InputEcho.Seq, 
                  appendDID(LEFT,RIGHT));
output(CHOOSEN(withLexID, eyeball), NAMED('withLexID'));

//filter out any records that did not get a LexID appended and then sort/dedup them so we only pass unique LexIDs in to the SSN append
dedupedLexIDs  := dedup(sort(withLexID(LexID <> 0), LexID), LexID);
output(CHOOSEN(dedupedLexIDs, eyeball), NAMED('dedupedLexIDs'));
output(count(dedupedLexIDs), named('countDedupedLexIDs'));


//the SSN append accepts a file of LexID only, so do that here
LexIDs_only := project(distribute(dedupedLexIDs, hash64(LexID)),
																	transform(doxie.layout_references, self.did := left.LexID));
output(count(LexIDs_only), named('LexIDs_only'));

//Append Best SSN for the records that didn't have a valid SSN input and that did get a LexID appended 
SSNsAppended := risk_indicators.collection_shell_mod.getBestCleaned(LexIDs_only, 
																																	DataRestrictionMask, 
																																	GLB_Purpose:=1, 
																																	clean_address:=false); // don't need clean address, just the best SSN
output(COUNT(SSNsAppended(ssn <> '')), NAMED('CountSSNsAppended'));
output(CHOOSEN(SSNsAppended, eyeball), NAMED('SSNsAppended'));

//define the final layout - it is the exact layout as the input file but with the best SSN field appended to the end
prii_layout_wBestSSN := RECORD
	prii_layout;
	string BestSSN;
END;

//join the records from the SSN append back to the original input and replace the input SSN with the appended SSN
bestSSNappended := join(distribute(withLexID, hash64(LexID)), 
													distribute(SSNsAppended, hash64(did)),  
													left.LexID=right.did,
												  TRANSFORM(prii_layout_wBestSSN,
																	// self.lexid := left.lexid,
																	SELF.BestSSN := right.ssn,
																	SELF := left), left outer, LOCAL);
output(CHOOSEN(bestSSNappended, eyeball), NAMED('bestSSNappended'));
output(COUNT(bestSSNappended), NAMED('countBestSSNappended'));

//for the records that came in with a good SSN, place that good SSN in the best SSN field of the final output layout
goodRecsBestAdded := project(good_SSNs,
											 transform(prii_layout_wBestSSN, 
                       self.BestSSN := left.SSN;
                       self         := left));
//add the records that had a valid SSN input back in with the records that had an SSN appended to create a complete file to get sent off to IDA/Innovis
finalFile := goodRecsBestAdded + bestSSNappended;
output(COUNT(finalFile), NAMED('countfinalFile'));
output(CHOOSEN(finalFile, eyeball), NAMED('finalFile'));
output(finalFile,, outputFileName + thorlib.wuid(),CSV(QUOTE('"'),heading(single))); 

