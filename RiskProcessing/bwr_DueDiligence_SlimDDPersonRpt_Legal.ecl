#workunit('name','DueDiligence - Slim DD Person Report - Legal');

IMPORT Data_Services, DueDiligence, iesp, RiskWise, STD;


/* *****************************************************
 *                   Options Section                   *
 *******************************************************/
inputFile := Data_Services.foreign_prod + 'jpyon::in::ln_8691_ln_consumer_ind.csv';
outputFile := '~tgertken::out::duedil_out_' + thorlib.wuid();  //  change output file name to person running script


//MINIMUM INPUT:
//  There is no minimum PII requirements for this product.  All records will process


BOOLEAN runInRealTime := FALSE;    //When TRUE will run request in real time mode, if FALSE will run with archive date from file


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
 *                      Main Script                    *
 *******************************************************/
layout:= record  
	STRING Account;
  STRING FirstName;
  STRING MiddleName;
  STRING LastName;
  STRING inStreetAddress;
  STRING inCity;
  STRING2 inState;
  STRING inZip;
  STRING HomePhone;
  STRING SSN;
  STRING DateOfBirth;
  STRING WorkPhone;
  STRING Income;  
  STRING DLNumber;
  STRING DLState;                                                                                                                                                                                                              
  STRING Balance; 
  STRING ChargeOffd;  
  STRING FormerName;
  STRING Email;  
  STRING EmployerName;
  STRING HistoryDate;   //Expecting YYYYMMDD or YYYYMM or 999999
  STRING LexID;
end;


input := IF(record_limit = 0, 
            DATASET(inputFile, Layout, CSV(QUOTE('"'))),
            CHOOSEN(DATASET(inputFile, Layout, CSV(QUOTE('"'))), record_limit));
		
										
//append seq to the input to track order
inDataRaw := PROJECT(input, TRANSFORM({UNSIGNED seq, RECORDOF(LEFT)}, SELF.seq := COUNTER; SELF := LEFT;));


NullToBlankAndTrim(STRING fieldToCheck) := FUNCTION
  trimField := TRIM(fieldToCheck);
  
  nullToBlank := IF(STD.Str.ToUpperCase(trimField) = 'NULL', '', trimField);
  
  RETURN nullToBlank;
END;


inputRecords := PROJECT(inDataRaw, TRANSFORM(RECORDOF(LEFT),
                                                SELF.Account := NullToBlankAndTrim(LEFT.Account);
                                                SELF.FirstName := NullToBlankAndTrim(LEFT.FirstName);
                                                SELF.MiddleName := NullToBlankAndTrim(LEFT.MiddleName);
                                                SELF.LastName := NullToBlankAndTrim(LEFT.LastName);
                                                SELF.SSN := NullToBlankAndTrim(LEFT.SSN);
                                                SELF.inStreetAddress := NullToBlankAndTrim(LEFT.inStreetAddress);
                                                SELF.inCity := NullToBlankAndTrim(LEFT.inCity);
                                                SELF.inState := NullToBlankAndTrim(LEFT.inState);
                                                SELF.inZip := NullToBlankAndTrim(LEFT.inZip);
                                                SELF.DateOfBirth := NullToBlankAndTrim(LEFT.DateOfBirth);
                                                SELF.HomePhone := NullToBlankAndTrim(LEFT.HomePhone);
                                                SELF.LexID := NullToBlankAndTrim(LEFT.LexID);
                                                SELF.HistoryDate := NullToBlankAndTrim(LEFT.HistoryDate);
                                                
                                                SELF := LEFT;));


reqInput := PROJECT(inputRecords, TRANSFORM({DATASET(iesp.duediligencepersonreport.t_DueDiligencePersonReportRequest) DueDiligencePersonReportRequest},
                                              sb := DATASET([TRANSFORM(iesp.duediligencepersonreport.t_DDRPersonReportBy,		
	
                                                            address := DATASET([TRANSFORM(iesp.share.t_Address,
                                                            
                                                                                          strippedZip := STD.Str.Filter(LEFT.inZip, DueDiligence.Constants.NUMERIC_VALUES);
                                                                                          
                                                                                          SELF.StreetAddress1 := LEFT.inStreetAddress;
                                                                                          SELF.City := LEFT.inCity;
                                                                                          SELF.State := LEFT.inState;
                                                                                          SELF.Zip5 := strippedZip[..5];
                                                                                          SELF.Zip4 := strippedZip[6..];
                                                                                          SELF := [];)])[1];
                                                            
                                                                                                              
                                                                                  
                                                            SELF.Person := DATASET([TRANSFORM(iesp.duediligenceshared.t_DDRAttributesPerson,
                                                                                                      SELF.LexID := LEFT.LexID;
                                                                                                      SELF.Phone := LEFT.HomePhone;
                                                                                                      SELF.SSN := LEFT.SSN;
                                                                                                      SELF.DOB := DATASET([TRANSFORM(iesp.share.t_Date,
                                                                                                                                        SELF.Year := (INTEGER)LEFT.DateOfBirth[1..4];
                                                                                                                                        SELF.Month := (INTEGER)LEFT.DateOfBirth[5..6];
                                                                                                                                        SELF.Day := (INTEGER)LEFT.DateOfBirth[7..8];)])[1];
                                                                                                      SELF.Name := DATASET([TRANSFORM(iesp.share.t_Name,
                                                                                                                                        SELF.First := LEFT.FirstName;
                                                                                                                                        SELF.Middle := LEFT.middleName;
                                                                                                                                        SELF.Last := LEFT.LastName;
                                                                                                                                        SELF := [];)])[1];
                                                                                                      SELF.Address := address;
                                                                                                      SELF := [];)])[1];

                                                                                                    
                                                            SELF := [];)]);
                                              
                                              o := DATASET([TRANSFORM(iesp.duediligenceshared.t_DDRAttributesOptions,
                                                                        SELF.DDAttributesVersionRequest := DueDiligence.Constants.IND_REQ_ATTRIBUTE_V3; 
                                                                        
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
                                                                      
                                              req := DATASET([TRANSFORM(iesp.duediligencepersonreport.t_DueDiligencePersonReportRequest,
                                                                          SELF.ReportBy := sb[1];
                                                                          SELF.Options := o[1];
                                                                          SELF.User := u[1];
                                                                          SELF := [];)]);
                                                                          
                                                                          
                                                                          
                                              SELF.DueDiligencePersonReportRequest := req[1];));
  
  
  
reqInput_dist := DISTRIBUTE(reqInput, RANDOM());



xlayout := RECORD
	UNSIGNED8 time_ms{XPATH('_call_latency_ms')} := 0;  // picks up timing
	iesp.duediligencepersonreport.t_DueDiligencePersonReportResponse;
	STRING errorCode;
END;

xlayout myFail(reqInput_dist le) := TRANSFORM
	SELF.errorCode := FAILCODE + FAILMESSAGE;
	SELF := le;
	SELF := [];
END;

DDResults := SOAPCALL(reqInput_dist, 
											roxieIP,
											'DueDiligence.DueDiligence_PersonRptService', 
											{reqInput_dist}, 
											DATASET(xlayout),
											RETRY(5), TIMEOUT(500),
											XPATH('*/Results/Result/Dataset[@name=\'Results\']/Row'),   //case sensitive
											PARALLEL(threads), 
											ONFAIL(myFail(LEFT)));
	


standardLayout := RECORD
  STRING Account;
  STRING FirstName;
  STRING MiddleName;
  STRING LastName;
  STRING inStreetAddress;
  STRING inCity;
  STRING2 inState;
  STRING inZip;
  STRING HomePhone;
  STRING SSN;
  STRING DateOfBirth;
  STRING WorkPhone;
  STRING Income;  
  STRING DLNumber;
  STRING DLState;                                                                                                                                                                                                              
  STRING Balance; 
  STRING ChargeOffd;  
  STRING FormerName;
  STRING Email;  
  STRING EmployerName;
  STRING HistoryDate;   //Expecting YYYYMMDD or YYYYMM or 999999
  STRING LexID;
end;


InputWithReqLayout := RECORD
   UNSIGNED seq;
   xlayout;
   standardLayout input;
end;
	

droppedInput := JOIN(inputRecords, DDResults,
                      LEFT.Lexid = TRIM(RIGHT.result.inputEcho.person.lexid) AND
                      LEFT.HomePhone = TRIM(RIGHT.result.inputEcho.person.phone) AND
                      TRIM(LEFT.inStreetAddress[..60]) = TRIM(RIGHT.result.inputEcho.person.address.streetAddress1) AND
                      TRIM(LEFT.inCity[..25]) = TRIM(RIGHT.result.inputEcho.person.address.city) AND
                      LEFT.inState = TRIM(RIGHT.result.inputEcho.person.address.state) AND
                      STD.Str.Filter(LEFT.inzip, DueDiligence.Constants.NUMERIC_VALUES) = TRIM(RIGHT.result.inputEcho.person.address.zip5 + RIGHT.result.inputEcho.person.address.zip4) AND
                      LEFT.SSN = TRIM(RIGHT.result.inputEcho.person.ssn) AND
                      LEFT.FirstName[..20] = TRIM(RIGHT.result.inputEcho.person.name.first) AND
                      LEFT.MiddleName[..20] = TRIM(RIGHT.result.inputEcho.person.name.middle) AND
                      LEFT.LastName[..20] = TRIM(RIGHT.result.inputEcho.person.name.last),
                      TRANSFORM({RECORDOF(LEFT) -seq}, SELF := LEFT;), 
                      LEFT ONLY); //These are in the format as input to be reprocessed		


base := JOIN(inputRecords, DDResults(errorCode = ''),
              LEFT.Lexid = TRIM(RIGHT.result.inputEcho.person.lexid) AND
              LEFT.HomePhone = TRIM(RIGHT.result.inputEcho.person.phone) AND
              TRIM(LEFT.inStreetAddress[..60]) = TRIM(RIGHT.result.inputEcho.person.address.streetAddress1) AND
              TRIM(LEFT.inCity[..25]) = TRIM(RIGHT.result.inputEcho.person.address.city) AND
              LEFT.inState = TRIM(RIGHT.result.inputEcho.person.address.state) AND
              STD.Str.Filter(LEFT.inzip, DueDiligence.Constants.NUMERIC_VALUES) = TRIM(RIGHT.result.inputEcho.person.address.zip5 + RIGHT.result.inputEcho.person.address.zip4) AND
              LEFT.SSN = TRIM(RIGHT.result.inputEcho.person.ssn) AND
              LEFT.FirstName[..20] = TRIM(RIGHT.result.inputEcho.person.name.first) AND
              LEFT.MiddleName[..20] = TRIM(RIGHT.result.inputEcho.person.name.middle) AND
              LEFT.LastName[..20] = TRIM(RIGHT.result.inputEcho.person.name.last),
              TRANSFORM(InputWithReqLayout,
                        SELF.input := LEFT;
                        SELF.seq := LEFT.seq;
                        SELF := RIGHT;
                        SELF := [];));
                        


PersonIdentifiers := RECORD
  UNSIGNED seq;
  standardLayout;
  STRING errorCode;
  STRING calcdLexID;
END;                        
                        
SlimPersonReportLayout := RECORD
  PersonIdentifiers;
  DueDiligence.v3Layouts.DDOutput.PerAttributes -PerLexID;
  DATASET(iesp.share.t_NameValuePair) Attributes;
	DATASET(iesp.share.t_NameValuePair) AttributeHitFlags;
  DATASET(iesp.duediligenceshared.t_DDRLegalStateCriminal) Criminals;
END;        

FinalCrimLayout := RECORD
  PersonIdentifiers;
  iesp.duediligenceshared.t_DDRLegalStateCriminal - sources -OffenseDDFirstReported -OffenseDDLastReportedActivity -OffenseDDMostRecentCourtDispDate;
  UNSIGNED4 OffenseDDMostRecentCourtDispDate;
  UNSIGNED4 OffenseDDFirstReported;
  UNSIGNED4 OffenseDDLastReportedActivity;
  UNSIGNED4 courtDispDate;
END;

FinalLayout := RECORD
  PersonIdentifiers;
  DueDiligence.v3Layouts.DDOutput.PerAttributes -PerLexID;
  iesp.duediligenceshared.t_DDRLegalStateCriminal - sources -OffenseDDFirstReported -OffenseDDLastReportedActivity -OffenseDDMostRecentCourtDispDate;
  UNSIGNED4 OffenseDDMostRecentCourtDispDate;
  UNSIGNED4 OffenseDDFirstReported;
  UNSIGNED4 OffenseDDLastReportedActivity;
  UNSIGNED4 courtDispDate;
END; 

               



slimReportRaw := PROJECT(base, TRANSFORM(SlimPersonReportLayout, 
                                          SELF.calcdLexID := LEFT.result.uniqueID;
                                          SELF.PerLexIDMatch := (STRING)LEFT.result.personLexIDMatch;
                                          SELF.attributes := LEFT.result.AttributeGroup.Attributes;
                                          SELF.attributeHitFlags := LEFT.result.AttributeGroup.AttributeLevelHits;
                                          SELF.criminals := LEFT.result.personReport.PersonAttributeDetails.Legal.possibleLegalEvents.Criminals;
                                          SELF.seq := LEFT.seq;
                                          SELF.errorCode := LEFT.errorCode;
                                          SELF := LEFT.input;
                                          SELF := [];));
                                      
slimAttrs := PROJECT(slimReportRaw, TRANSFORM(SlimPersonReportLayout, 
                                                
                                                attributes := LEFT.attributes;
                                                attributeHits := LEFT.attributeHitFlags;

                                                SELF.PerAssetOwnProperty := attributes(TRIM(name) = 'PerAssetOwnProperty')[1].value;
                                                SELF.PerAssetOwnAircraft := attributes(TRIM(name) = 'PerAssetOwnAircraft')[1].value;
                                                SELF.PerAssetOwnWatercraft := attributes(TRIM(name) = 'PerAssetOwnWatercraft')[1].value;
                                                SELF.PerAssetOwnVehicle := attributes(TRIM(name) = 'PerAssetOwnVehicle')[1].value;
                                                SELF.PerAccessToFundsIncome := attributes(TRIM(name) = 'PerAccessToFundsIncome')[1].value;
                                                SELF.PerAccessToFundsProperty := attributes(TRIM(name) = 'PerAccessToFundsProperty')[1].value;
                                                SELF.PerGeographic := attributes(TRIM(name) = 'PerGeographic')[1].value;
                                                SELF.PerMobility := attributes(TRIM(name) = 'PerMobility')[1].value;
                                                SELF.PerStateLegalEvent := attributes(TRIM(name) = 'PerStateLegalEvent')[1].value;
                                                SELF.PerFederalLegalEvent := attributes(TRIM(name) = 'PerFederalLegalEvent')[1].value;
                                                SELF.PerFederalLegalMatchLevel := attributes(TRIM(name) = 'PerFederalLegalMatchLevel')[1].value;
                                                SELF.PerCivilLegalEvent := attributes(TRIM(name) = 'PerCivilLegalEvent')[1].value;
                                                SELF.PerCivilLegalEventFilingAmt := attributes(TRIM(name) = 'PerCivilLegalEventFilingAmt')[1].value;
                                                SELF.PerOffenseType := attributes(TRIM(name) = 'PerOffenseType')[1].value;
                                                SELF.PerAgeRange := attributes(TRIM(name) = 'PerAgeRange')[1].value;
                                                SELF.PerIdentityRisk := attributes(TRIM(name) = 'PerIdentityRisk')[1].value;
                                                SELF.PerUSResidency := attributes(TRIM(name) = 'PerUSResidency')[1].value;
                                                SELF.PerMatchLevel := attributes(TRIM(name) = 'PerMatchLevel')[1].value;
                                                SELF.PerAssociates := attributes(TRIM(name) = 'PerAssociates')[1].value;
                                                SELF.PerProfLicense := attributes(TRIM(name) = 'PerProfLicense')[1].value;
                                                SELF.PerBusAssociations := attributes(TRIM(name) = 'PerBusAssociations')[1].value;
                                                SELF.PerEmploymentIndustry := attributes(TRIM(name) = 'PerEmploymentIndustry')[1].value;

                                                SELF.PerAssetOwnProperty_Flag := attributeHits(TRIM(name) = 'PerAssetOwnProperty_Flag')[1].value;
                                                SELF.PerAssetOwnAircraft_Flag := attributeHits(TRIM(name) = 'PerAssetOwnAircraft_Flag')[1].value;
                                                SELF.PerAssetOwnWatercraft_Flag := attributeHits(TRIM(name) = 'PerAssetOwnWatercraft_Flag')[1].value;
                                                SELF.PerAssetOwnVehicle_Flag := attributeHits(TRIM(name) = 'PerAssetOwnVehicle_Flag')[1].value;
                                                SELF.PerAccessToFundsIncome_Flag := attributeHits(TRIM(name) = 'PerAccessToFundsIncome_Flag')[1].value;
                                                SELF.PerAccessToFundsProperty_Flag := attributeHits(TRIM(name) = 'PerAccessToFundsProperty_Flag')[1].value;
                                                SELF.PerGeographic_Flag := attributeHits(TRIM(name) = 'PerGeographic_Flag')[1].value;
                                                SELF.PerMobility_Flag := attributeHits(TRIM(name) = 'PerMobility_Flag')[1].value;
                                                SELF.PerStateLegalEvent_Flag := attributeHits(TRIM(name) = 'PerStateLegalEvent_Flag')[1].value;
                                                SELF.PerFederalLegalEvent_Flag := attributeHits(TRIM(name) = 'PerFederalLegalEvent_Flag')[1].value;
                                                SELF.PerFederalLegalMatchLevel_Flag := attributeHits(TRIM(name) = 'PerFederalLegalMatchLevel_Flag')[1].value;
                                                SELF.PerCivilLegalEvent_Flag := attributeHits(TRIM(name) = 'PerCivilLegalEvent_Flag')[1].value;
                                                SELF.PerCivilLegalEventFilingAmt_Flag := attributeHits(TRIM(name) = 'PerCivilLegalEventFilingAmt_Flag')[1].value;
                                                SELF.PerOffenseType_Flag := attributeHits(TRIM(name) = 'PerOffenseType_Flag')[1].value;
                                                SELF.PerAgeRange_Flag := attributeHits(TRIM(name) = 'PerAgeRange_Flag')[1].value;
                                                SELF.PerIdentityRisk_Flag := attributeHits(TRIM(name) = 'PerIdentityRisk_Flag')[1].value;
                                                SELF.PerUSResidency_Flag := attributeHits(TRIM(name) = 'PerUSResidency_Flag')[1].value;
                                                SELF.PerMatchLevel_Flag := attributeHits(TRIM(name) = 'PerMatchLevel_Flag')[1].value;
                                                SELF.PerAssociates_Flag := attributeHits(TRIM(name) = 'PerAssociates_Flag')[1].value;
                                                SELF.PerProfLicense_Flag := attributeHits(TRIM(name) = 'PerProfLicense_Flag')[1].value;
                                                SELF.PerBusAssociations_Flag := attributeHits(TRIM(name) = 'PerBusAssociations_Flag')[1].value;
                                                SELF.PerEmploymentIndustry_Flag := attributeHits(TRIM(name) = 'PerEmploymentIndustry_Flag')[1].value;
                                                
                                                SELF := LEFT;));                                      
                                      

normCrimTopLevel := NORMALIZE(slimAttrs, LEFT.Criminals,
                              TRANSFORM({SlimPersonReportLayout -Attributes -AttributeHitFlags -Criminals, iesp.duediligenceshared.t_DDRLegalStateCriminal crimTop, UNSIGNED4 firstSeenOffense},
                                        SELF.crimTop := RIGHT;
                                        SELF.firstSeenOffense := (UNSIGNED4)iesp.ECL2ESP.DateToString(RIGHT.OffenseDDFirstReported);
                                        SELF := LEFT;));
                                        
normCrimSources := NORMALIZE(normCrimTopLevel, LEFT.crimTop.Sources,
                              TRANSFORM({SlimPersonReportLayout -Attributes -AttributeHitFlags -Criminals, iesp.duediligenceshared.t_DDRLegalStateCriminal -sources crimTop, iesp.duediligenceshared.t_DDRLegalSourceInfo -PartyNames crimSources, UNSIGNED4 firstSeenOffense, UNSIGNED4 courtDispDate},
                                          SELF.crimSources := RIGHT;
                                          SELF.courtDispDate := (UNSIGNED4)iesp.ECL2ESP.DateToString(RIGHT.OffenseCourtDispDate);
                                          SELF := LEFT;));    
                                          
sortCourtDispDate := SORT(normCrimSources(courtDispDate <> 0), Account, calcdLexID, crimTop.source, crimTop.caseNumber, -firstSeenOffense, crimTop.OffenseDDLegalEventTypeMapped, courtDispDate);                                      
dedupCourtDispDate := DEDUP(sortCourtDispDate, Account, calcdLexID, crimTop.source, crimTop.caseNumber, firstSeenOffense, crimTop.OffenseDDLegalEventTypeMapped);

addDispDate := JOIN(normCrimTopLevel, dedupCourtDispDate,
                    LEFT.Account = RIGHT.Account AND
                    LEFT.calcdLexID = RIGHT.calcdLexID AND
                    LEFT.crimTop.source = RIGHT.crimTop.source AND
                    LEFT.crimTop.caseNumber = RIGHT.crimTop.caseNumber AND
                    LEFT.firstSeenOffense = RIGHT.firstSeenOffense AND
                    LEFT.crimTop.offenseDDLegalEventTypeMapped = RIGHT.crimTop.offenseDDLegalEventTypeMapped,
                    TRANSFORM(FinalCrimLayout,
                              SELF.courtDispDate := RIGHT.courtDispDate;
                              SELF.OffenseDDFirstReported := (UNSIGNED4)iesp.ECL2ESP.DateToString(LEFT.crimTop.OffenseDDFirstReported);
                              SELF.OffenseDDLastReportedActivity := (UNSIGNED4)iesp.ECL2ESP.DateToString(LEFT.crimTop.OffenseDDLastReportedActivity);
                              SELF.OffenseDDMostRecentCourtDispDate := (UNSIGNED4)iesp.ECL2ESP.DateToString(LEFT.crimTop.OffenseDDMostRecentCourtDispDate);
                              SELF := LEFT.crimTop;
                              SELF := LEFT;),
                    LEFT OUTER);

addNonCriminal := JOIN(slimAttrs, addDispDate,
                       LEFT.Account = RIGHT.Account AND
                       LEFT.calcdLexID = RIGHT.calcdLexID,
                       TRANSFORM(FinalLayout,
                                 SELF := LEFT;
                                 SELF := RIGHT;),
                       LEFT OUTER);																																						

resortData := SORT(addNonCriminal, seq);

final := PROJECT(resortData, TRANSFORM({FinalLayout -seq -errorCode, STRING errorMessage}, SELF.errorMessage := LEFT.errorCode; SELF := LEFT;));







OUTPUT(COUNT(input), NAMED('inDataRaw_count'));
OUTPUT(CHOOSEN(input, eyeball), NAMED('inDataRaw'));
OUTPUT(CHOOSEN(inputRecords, eyeball), NAMED('cleanNullInput'));

OUTPUT(COUNT(reqInput), NAMED('reqInput_count'));
OUTPUT(CHOOSEN(reqInput, eyeball), NAMED('reqInput'));


OUTPUT(COUNT(DDResults), NAMED('DDResultsCount'));
OUTPUT(CHOOSEN(DDResults, eyeball), NAMED('DDResults'));

OUTPUT(COUNT(DDResults(errorCode <> '')), NAMED('requestWithErrors_count'));
OUTPUT(CHOOSEN(DDResults(errorCode <> ''), eyeball), NAMED('requestWithErrors'));

OUTPUT(COUNT(droppedInput), NAMED('droppedInput_count'));
OUTPUT(CHOOSEN(droppedInput, eyeball), NAMED('droppedInput'));

OUTPUT(COUNT(final), NAMED('final_count'));
OUTPUT(CHOOSEN(final, eyeball), NAMED('final'));



OUTPUT(final,, outputFile, CSV(HEADING(single), QUOTE('"')));		
OUTPUT(DDResults(errorCode <> ''),, outputFile + '_err', CSV(HEADING(single), QUOTE('"')));	
OUTPUT(droppedInput,, outputFile + '_reprocess', CSV(QUOTE('"')));   
