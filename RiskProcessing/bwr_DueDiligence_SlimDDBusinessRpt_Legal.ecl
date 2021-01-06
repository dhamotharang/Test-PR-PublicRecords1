IMPORT Data_Services, DueDiligence, iesp, RiskWise, STD;

#workunit('name', 'DueDiligence - Slim DD Business Report - Legal');


/* *****************************************************
 *                   Input Section                     *
 *******************************************************/
inputFile := Data_Services.foreign_prod + 'rbao::in::affirm_10144_bus_rep1_input.csv';
 
outputFileNamePrefix := Data_Services.foreign_prod + 'tgertken::out::bus_duedil_mf_' + thorlib.wuid();
 
 
//MINIMUM INPUT:
//  There is no minimum BII requirements for this product.  All records will process

BOOLEAN runInRealTime := TRUE;    //When TRUE will run request in real time mode, if FALSE will run with archive date from file


//Standard input options
UNSIGNED1 glba := 1;
UNSIGNED1 dppa := 3;

STRING dataPermissionMask := '0000000000000';
STRING dataRestrictionMask := '100000';	// byte 6, if 1, restricts experian, byte 8, if 1, restricts equifax, 
                                        // byte 10 restricts Transunion, 12 restricts ADVO, 13 restricts bureau deceased data

//Location of the ECL query
roxieIP := RiskWise.Shortcuts.prod_batch_analytics_roxie; 


UNSIGNED eyeball := 10;           //Number of records to preview
UNSIGNED record_limit := 0;       //Number of records to read from input file; 0 means ALL
UNSIGNED threads := 30;           //Number of parallel calls to run in the SOAPCALL to the Roxie Query 

 
 
 
 
 /* *****************************************************
 *                   Main Script                        *
 *******************************************************/
 inputLayout:= RECORD 
  STRING30 Account;
  STRING100 CompanyName;
  STRING100 AltCompanyName;
  STRING50 InStreetAddress;
  STRING30 InCity;
  STRING2 InState;
  STRING9 InZip;
  STRING10 Phone;
  STRING9 TaxID;
  STRING16 BusinessIPAddress;
  STRING15 Rep1firstname;
  STRING15 Rep1MiddleName;
  STRING20 Rep1lastname;
  STRING5 Rep1NameSuffix;
  STRING50 Rep1Addr;
  STRING30 Rep1City;
  STRING2 Rep1State;
  STRING9 Rep1Zip;
  STRING9 Rep1SSN;
  STRING8 Rep1DOB;
  STRING3 Rep1Age;
  STRING20 Rep1DLNumber;
  STRING2 Rep1DLState;
  STRING10 Rep1HomePhone;
  STRING50 Rep1EmailAddress;
  STRING20 Rep1FormerLastName;
  STRING HistoryDate;
  STRING LexID; //AKA seleID in this case
END;


input := IF(record_limit = 0, 
             DATASET(inputFile, inputLayout, CSV(QUOTE('"'))),
             CHOOSEN(DATASET(inputFile, inputLayout, CSV(QUOTE('"'))), record_limit));
             
            
//since we are only searching by lexID, lets get the unique lexIDs
uniqueInput := DEDUP(input, ALL);
										
reqInput := PROJECT(uniqueInput, TRANSFORM({DATASET(iesp.duediligencebusinessreport.t_DueDiligenceBusinessReportRequest) DueDiligenceBusinessReportRequest},
                                              rb := DATASET([TRANSFORM(iesp.duediligencebusinessreport.t_DDRBusinessReportBy,		
	
                                                            address := DATASET([TRANSFORM(iesp.share.t_Address,
                                                            
                                                                                          strippedZip := STD.Str.Filter(LEFT.inZip, DueDiligence.Constants.NUMERIC_VALUES);
                                                                                          
                                                                                          SELF.StreetAddress1 := LEFT.inStreetAddress;
                                                                                          SELF.City := LEFT.inCity;
                                                                                          SELF.State := LEFT.inState;
                                                                                          SELF.Zip5 := strippedZip[..5];
                                                                                          SELF.Zip4 := strippedZip[6..];
                                                                                          SELF := [];)])[1];
                                                            
                                                            SELF.Business := DATASET([TRANSFORM(iesp.duediligenceshared.t_DDRAttributesBusiness,
                                                                                                 SELF.CompanyName := LEFT.companyName;
                                                                                                 SELF.FEIN := LEFT.taxID;
                                                                                                 SELF.LexID := LEFT.lexID;
                                                                                                 SELF.Phone := LEFT.phone;
                                                                                                 SELF.Address := address;
                                                                                                 
                                                                                                 SELF := [];)])[1];                                                  
                                                                                  
                                                            

                                                                                                    
                                                            SELF := [];)]);
                                              
                                              o := DATASET([TRANSFORM(iesp.duediligenceshared.t_DDRAttributesOptions,
                                                                      dateToUse := IF(runInRealTime, '99999999', LEFT.HistoryDate);
                                                                      
                                                                      SELF.HistoryDate := DATASET([TRANSFORM(iesp.share.t_Date,
                                                                                                              SELF.Year := (INTEGER)dateToUse[1..4];
                                                                                                              SELF.Month := (INTEGER)dateToUse[5..6];
                                                                                                              SELF.Day := (INTEGER)dateToUse[7..8];)])[1];
                                                                      SELF := [];)]);
                                                                        
                                              u := DATASET([TRANSFORM(iesp.share.t_User, 
                                                                      SELF.AccountNumber := LEFT.Account; 
                                                                      SELF.DataRestrictionMask := dataRestrictionMask;
                                                                      SELF.DataPermissionMask := dataPermissionMask;
                                                                      SELF.GLBPurpose := (STRING)glba;
                                                                      SELF.DLPurpose := (STRING)dppa;
                                                                      SELF := [])]);
                                                                      
                                              req := DATASET([TRANSFORM(iesp.duediligencebusinessreport.t_DueDiligenceBusinessReportRequest,
                                                                        SELF.ReportBy := rb[1];
                                                                        SELF.Options := o[1];
                                                                        SELF.User := u[1];
                                                                        SELF := [];)]);
                                                                          
                                                                          
                                                                          
                                              SELF.DueDiligenceBusinessReportRequest := req[1];));
  
  
  
reqInput_dist := DISTRIBUTE(reqInput, RANDOM());



xlayout := RECORD
	UNSIGNED8 time_ms{XPATH('_call_latency_ms')} := 0;  // picks up timing
	iesp.duediligencebusinessreport.t_DueDiligenceBusinessReportResponse;
	STRING errorCode;
END;

xlayout myFail(reqInput_dist le) := TRANSFORM
	SELF.errorCode := FAILCODE + FAILMESSAGE;
	SELF := le;
	SELF := [];
END;

DDResults := SOAPCALL(reqInput_dist, 
											roxieIP,
											'DueDiligence.DueDiligence_BusinessRptService', 
											{reqInput_dist}, 
											DATASET(xlayout),
											RETRY(5), TIMEOUT(500),
											XPATH('*/Results/Result/Dataset[@name=\'Results\']/Row'),   //case sensitive
											PARALLEL(threads), 
											ONFAIL(myFail(LEFT)));
 
 
 
 
/* *****************************************************
*               Transform Results Section              *
*******************************************************/
InputWithReqLayout := RECORD
  inputLayout input;
  xlayout;
END;

                        
SlimReportLayout := RECORD
  inputLayout input;
  DueDiligence.v3Layouts.DDOutput.BusAttributes;
  DATASET(iesp.share.t_NameValuePair) Attributes;
	DATASET(iesp.share.t_NameValuePair) AttributeHitFlags;
  DATASET(iesp.duediligencebusinessreport.t_DDRBusinessExecutiveCriminalEvents) Criminals;
  DATASET(iesp.duediligencebusinessreport.t_DDRBusinessExecutives) beoDetails;
  UNSIGNED BEOsWithCrimiRecords;
END;

BEOCrim := RECORD
  SlimReportLayout -[Attributes, AttributeHitFlags, Criminals, beoDetails];
  STRING lexID;
  STRING firstName;
  STRING middleName;
  STRING lastName;
  STRING suffix;
  UNSIGNED sle;
  DATASET(iesp.duediligenceshared.t_DDRLegalStateCriminal) criminalDetails;
END; 

TopCrim := RECORD
  BEOCrim -[criminalDetails];
  iesp.duediligenceshared.t_DDRLegalStateCriminal -[sources];
END;


FinalBus := RECORD
  inputLayout input;
  DueDiligence.v3Layouts.DDOutput.BusAttributes;
  UNSIGNED BEOsWithCrimiRecords;
END;

FinalBEO := RECORD
  STRING busAccount;
  STRING busLexID;
  STRING personlexID;
  STRING firstName;
  STRING middleName;
  STRING lastName;
  STRING suffix;
  UNSIGNED sle;
  iesp.duediligenceshared.t_DDRLegalStateCriminal -[sources, OffenseDDFirstReported, OffenseDDLastReportedActivity, OffenseDDMostRecentCourtDispDate];
  UNSIGNED OffenseDDFirstReported;
	UNSIGNED OffenseDDLastReportedActivity;
	UNSIGNED OffenseDDMostRecentCourtDispDate;	
END;

droppedInput := JOIN(input, DDResults,
                      TRIM(LEFT.Lexid) = TRIM(RIGHT.result.inputEcho.business.lexid) AND
                      TRIM(LEFT.Phone) = TRIM(RIGHT.result.inputEcho.business.phone) AND
                      TRIM(LEFT.InStreetAddress[..50]) = TRIM(RIGHT.result.inputEcho.business.address.streetAddress1) AND
                      TRIM(LEFT.InCity[..25]) = TRIM(RIGHT.result.inputEcho.business.address.city) AND
                      TRIM(LEFT.InState) = TRIM(RIGHT.result.inputEcho.business.address.state) AND
                      TRIM(STD.Str.Filter(LEFT.InZip, DueDiligence.Constants.NUMERIC_VALUES)) = TRIM(RIGHT.result.inputEcho.business.address.zip5 + RIGHT.result.inputEcho.business.address.zip4) AND
                      TRIM(LEFT.taxID) = TRIM(RIGHT.result.inputEcho.business.fein) AND
                      TRIM(LEFT.CompanyName) = TRIM(RIGHT.result.inputEcho.business.companyName),
                      TRANSFORM({RECORDOF(LEFT)}, SELF := LEFT;), 
                      LEFT ONLY); //These are in the format as input to be reprocessed	


base := JOIN(input, DDResults(errorCode = ''),
              TRIM(LEFT.Lexid) = TRIM(RIGHT.result.inputEcho.business.lexid) AND
              TRIM(LEFT.Phone) = TRIM(RIGHT.result.inputEcho.business.phone) AND
              TRIM(LEFT.InStreetAddress[..50]) = TRIM(RIGHT.result.inputEcho.business.address.streetAddress1) AND
              TRIM(LEFT.InCity[..25]) = TRIM(RIGHT.result.inputEcho.business.address.city) AND
              TRIM(LEFT.InState) = TRIM(RIGHT.result.inputEcho.business.address.state) AND
              TRIM(STD.Str.Filter(LEFT.InZip, DueDiligence.Constants.NUMERIC_VALUES)) = TRIM(RIGHT.result.inputEcho.business.address.zip5 + RIGHT.result.inputEcho.business.address.zip4) AND
              TRIM(LEFT.taxID) = TRIM(RIGHT.result.inputEcho.business.fein) AND
              TRIM(LEFT.CompanyName) = TRIM(RIGHT.result.inputEcho.business.companyName),
              TRANSFORM(InputWithReqLayout,
                        SELF.input := LEFT;
                        SELF := RIGHT;
                        SELF := [];),
              LEFT OUTER);



 
 
slimReportRaw := PROJECT(base, TRANSFORM(SlimReportLayout, 
                                          SELF.busLexID := (STRING)LEFT.result.businessID;
                                          SELF.busLexIDMatch := (STRING)LEFT.result.businessLexIDMatch;
                                          SELF.attributes := LEFT.result.AttributeGroup.Attributes;
                                          SELF.attributeHitFlags := LEFT.result.AttributeGroup.AttributeLevelHits;
                                          SELF.criminals := LEFT.result.businessReport.BusinessAttributeDetails.Legal.possibleLegalEvents;
                                          SELF.BEOsWithCrimiRecords := COUNT(LEFT.result.businessReport.BusinessAttributeDetails.Legal.possibleLegalEvents);
                                          SELF.beoDetails := LEFT.result.businessReport.BusinessAttributeDetails.NetworkDetails.BusinessExecutives;
                                          SELF.input := LEFT.input;
                                          SELF := [];));
                                          
                                          
popAttributes := PROJECT(slimReportRaw, TRANSFORM(SlimReportLayout,
                                                  
                                                  attribute := LEFT.attributes;
                                                  attributeHits := LEFT.attributeHitFlags;
                                                  
                                                  SELF.BusAssetOwnProperty := attribute(TRIM(name) = 'BusAssetOwnProperty')[1].value;
                                                  SELF.BusAssetOwnAircraft := attribute(TRIM(name) = 'BusAssetOwnAircraft')[1].value;
                                                  SELF.BusAssetOwnWatercraft := attribute(TRIM(name) = 'BusAssetOwnWatercraft')[1].value;
                                                  SELF.BusAssetOwnVehicle := attribute(TRIM(name) = 'BusAssetOwnVehicle')[1].value;
                                                  SELF.BusAccessToFundSales := attribute(TRIM(name) = 'BusAccessToFundSales')[1].value;
                                                  SELF.BusAccessToFundsProperty := attribute(TRIM(name) = 'BusAccessToFundsProperty')[1].value;
                                                  SELF.BusGeographic := attribute(TRIM(name) = 'BusGeographic')[1].value;
                                                  SELF.BusValidity := attribute(TRIM(name) = 'BusValidity')[1].value;
                                                  SELF.BusStability := attribute(TRIM(name) = 'BusStability')[1].value;
                                                  SELF.BusIndustry := attribute(TRIM(name) = 'BusIndustry')[1].value;
                                                  SELF.BusStructureType := attribute(TRIM(name) = 'BusStructureType')[1].value;
                                                  SELF.BusSOSAgeRange := attribute(TRIM(name) = 'BusSOSAgeRange')[1].value;
                                                  SELF.BusPublicRecordAgeRange := attribute(TRIM(name) = 'BusPublicRecordAgeRange')[1].value;
                                                  SELF.BusShellShelf := attribute(TRIM(name) = 'BusShellShelf')[1].value;
                                                  SELF.BusMatchLevel := attribute(TRIM(name) = 'BusMatchLevel')[1].value;
                                                  SELF.BusStateLegalEvent := attribute(TRIM(name) = 'BusStateLegalEvent')[1].value;
                                                  SELF.BusFederalLegalEvent := attribute(TRIM(name) = 'BusFederalLegalEvent')[1].value;
                                                  SELF.BusFederalLegalMatchLevel := attribute(TRIM(name) = 'BusFederalLegalMatchLevel')[1].value;
                                                  SELF.BusCivilLegalEvent := attribute(TRIM(name) = 'BusCivilLegalEvent')[1].value;
                                                  SELF.BusCivilLegalEventFilingAmt := attribute(TRIM(name) = 'BusCivilLegalEventFilingAmt')[1].value;
                                                  SELF.BusOffenseType := attribute(TRIM(name) = 'BusOffenseType')[1].value;
                                                  SELF.BusBEOProfLicense := attribute(TRIM(name) = 'BusBEOProfLicense')[1].value;
                                                  SELF.BusBEOUSResidency := attribute(TRIM(name) = 'BusBEOUSResidency')[1].value;
                                                  SELF.BusBEOAccessToFundsProperty := attribute(TRIM(name) = 'BusBEOAccessToFundsProperty')[1].value;
                                                  SELF.BusLinkedBusinesses := attribute(TRIM(name) = 'BusLinkedBusinesses')[1].value;

                                                  SELF.BusAssetOwnProperty_Flag := attributeHits(TRIM(name) = 'BusAssetOwnProperty_Flag')[1].value;
                                                  SELF.BusAssetOwnAircraft_Flag := attributeHits(TRIM(name) = 'BusAssetOwnAircraft_Flag')[1].value;
                                                  SELF.BusAssetOwnWatercraft_Flag := attributeHits(TRIM(name) = 'BusAssetOwnWatercraft_Flag')[1].value;
                                                  SELF.BusAssetOwnVehicle_Flag := attributeHits(TRIM(name) = 'BusAssetOwnVehicle_Flag')[1].value;
                                                  SELF.BusAccessToFundsSales_Flag := attributeHits(TRIM(name) = 'BusAccessToFundsSales_Flag')[1].value;
                                                  SELF.BusAccessToFundsProperty_Flag := attributeHits(TRIM(name) = 'BusAccessToFundsProperty_Flag')[1].value;
                                                  SELF.BusGeographic_Flag := attributeHits(TRIM(name) = 'BusGeographic_Flag')[1].value;
                                                  SELF.BusValidity_Flag := attributeHits(TRIM(name) = 'BusValidity_Flag')[1].value;
                                                  SELF.BusStability_Flag := attributeHits(TRIM(name) = 'BusStability_Flag')[1].value;
                                                  SELF.BusIndustry_Flag := attributeHits(TRIM(name) = 'BusIndustry_Flag')[1].value;
                                                  SELF.BusStructureType_Flag := attributeHits(TRIM(name) = 'BusStructureType_Flag')[1].value;
                                                  SELF.BusSOSAgeRange_Flag := attributeHits(TRIM(name) = 'BusSOSAgeRange_Flag')[1].value;
                                                  SELF.BusPublicRecordAgeRange_Flag := attributeHits(TRIM(name) = 'BusPublicRecordAgeRange_Flag')[1].value;
                                                  SELF.BusShellShelf_Flag := attributeHits(TRIM(name) = 'BusShellShelf_Flag')[1].value;
                                                  SELF.BusMatchLevel_Flag := attributeHits(TRIM(name) = 'BusMatchLevel_Flag')[1].value;
                                                  SELF.BusStateLegalEvent_Flag := attributeHits(TRIM(name) = 'BusStateLegalEvent_Flag')[1].value;
                                                  SELF.BusFederalLegalEvent_Flag := attributeHits(TRIM(name) = 'BusFederalLegalEvent_Flag')[1].value;
                                                  SELF.BusFederalLegalMatchLevel_Flag := attributeHits(TRIM(name) = 'BusFederalLegalMatchLevel_Flag')[1].value;
                                                  SELF.BusCivilLegalEvent_Flag := attributeHits(TRIM(name) = 'BusCivilLegalEvent_Flag')[1].value;
                                                  SELF.BusCivilLegalEventFilingAmt_Flag := attributeHits(TRIM(name) = 'BusCivilLegalEventFilingAmt_Flag')[1].value;
                                                  SELF.BusOffenseType_Flag := attributeHits(TRIM(name) = 'BusOffenseType_Flag')[1].value;
                                                  SELF.BusBEOProfLicense_Flag := attributeHits(TRIM(name) = 'BusBEOProfLicense_Flag')[1].value;
                                                  SELF.BusBEOUSResidency_Flag := attributeHits(TRIM(name) = 'BusBEOUSResidency_Flag')[1].value;
                                                  SELF.BusBEOAccessToFundsProperty_Flag := attributeHits(TRIM(name) = 'BusBEOAccessToFundsProperty_Flag')[1].value;
                                                  SELF.BusLinkedBusinesses_Flag := attributeHits(TRIM(name) = 'BusLinkedBusinesses_Flag')[1].value;
                                                  
                                                  SELF := LEFT;));
                                                  

getBEOCrim := NORMALIZE(popAttributes, LEFT.criminals,
                        TRANSFORM(BEOCrim,
                                  SELF.lexID := RIGHT.executiveOfficer.lexID;
                                  SELF.firstName := RIGHT.executiveOfficer.name.first;
                                  SELF.middleName := RIGHT.executiveOfficer.name.middle;
                                  SELF.lastName := RIGHT.executiveOfficer.name.last;
                                  SELF.suffix := RIGHT.executiveOfficer.name.suffix;
                                  SELF.criminalDetails := RIGHT.criminals;
                                  SELF.sle := LEFT.beoDetails(lexID = RIGHT.executiveOfficer.lexID)[1].CriminalStateLegalEvents;
                                  SELF := LEFT;));
                                  
getTopCrim := NORMALIZE(getBEOCrim, LEFT.criminalDetails,
                        TRANSFORM(TopCrim,
                                  SELF := RIGHT;
                                  SELF := LEFT;));


topLevelBusReport := DEDUP(SORT(getTopCrim, input.Account, busLexID), input.Account, busLexID);

finalTopLevel := PROJECT(topLevelBusReport, TRANSFORM(FinalBus, SELF := LEFT;));
noBEOTopLevel := PROJECT(popAttributes(BEOsWithCrimiRecords = 0), TRANSFORM(FinalBus, SELF := LEFT;));
allTopLevel := finalTopLevel + noBEOTopLevel;

beoLevelBusReport := PROJECT(getTopCrim, TRANSFORM(FinalBEO,
                                                    SELF.busAccount := LEFT.input.Account;
                                                    SELF.busLexID := LEFT.busLexID;
                                                    SELF.personlexID := LEFT.lexID;
                                                    SELF.OffenseDDFirstReported := (UNSIGNED)iesp.ECL2ESP.DateToString(LEFT.OffenseDDFirstReported);
                                                    SELF.OffenseDDLastReportedActivity := (UNSIGNED)iesp.ECL2ESP.DateToString(LEFT.OffenseDDLastReportedActivity);
                                                    SELF.OffenseDDMostRecentCourtDispDate := (UNSIGNED)iesp.ECL2ESP.DateToString(LEFT.OffenseDDMostRecentCourtDispDate);
                                                    SELF := LEFT;
                                                    SELF := [];));
 



 
/* *****************************************************
*                   Output Section                     *
*******************************************************/

OUTPUT(CHOOSEN(input, eyeball), NAMED('input'));
OUTPUT(CHOOSEN(uniqueInput, eyeball), NAMED('uniqueInput'));
OUTPUT(CHOOSEN(reqInput, eyeball), NAMED('reqInput'));
OUTPUT(CHOOSEN(DDResults, eyeball), NAMED('DDResults'));
OUTPUT(CHOOSEN(base, eyeball), NAMED('base'));

OUTPUT(CHOOSEN(finalTopLevel, eyeball), NAMED('finalTopLevel'));
OUTPUT(CHOOSEN(noBEOTopLevel, eyeball), NAMED('noBEOTopLevel'));
OUTPUT(CHOOSEN(allTopLevel, eyeball), NAMED('allTopLevel'));
OUTPUT(CHOOSEN(beoLevelBusReport, eyeball), NAMED('beoLevelBusReport'));

OUTPUT(allTopLevel,, outputFileNamePrefix + '_bus_data.csv', CSV(HEADING(single), QUOTE('"')));
OUTPUT(beoLevelBusReport,, outputFileNamePrefix + '_beo_legal_data.csv', CSV(HEADING(single), QUOTE('"')));
OUTPUT(droppedInput,, outputFileNamePrefix + '_data_to_reprocess.csv', CSV(QUOTE('"')));
