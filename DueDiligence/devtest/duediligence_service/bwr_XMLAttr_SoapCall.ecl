IMPORT DueDiligence, Gateway, iesp, RiskWise, STD;


/* *****************************************************
 *                   Options Section                   *
 *******************************************************/
//Choose input data options
inputSelection := 1; //1 = PII/BII only, 2 = lexID only, 3 = both PII/BII and lexID 

//Choose file to run
fileSelection := 2;

inputInfoLayout := RECORD
  STRING fileName;
  BOOLEAN isBusiness;
  BOOLEAN includesIdentifyingInfo; //either PII or BII
  BOOLEAN includesLexID;  //either a DID or SeleID
END;

inputData := CASE(fileSelection,
                    1 => DATASET([{'~tgertken::in::business_bii_only_232k.csv', TRUE, TRUE, FALSE}], inputInfoLayout),
                    2 => DATASET([{'~tgertken::in::business_bii_lexid_231949.csv', TRUE, TRUE, TRUE}], inputInfoLayout),
                    3 => DATASET([{'~tgertken::in::individual_pii_only_168k.csv', FALSE, TRUE, FALSE}], inputInfoLayout),
                    4 => DATASET([{'~tgertken::in::individual_pii_lexid_168k.csv', FALSE, TRUE, TRUE}], inputInfoLayout),
                    DATASET([], inputInfoLayout))[1];
                    
//Select the product(s) to run
productsRequested := 'AttributesOnly'; // VALUES:[AttributesOnly, CitizenshipOnly,  AttributesAndCitizenship, Modules]
potentialAttributeModules := DATASET([], {STRING attrs}); //VALUES: [ECONOMIC, GEOGRAPHIC, IDENTITY, LEGAL, NETWORK, OPERATING]


//Select compliance settings
glba := 1;
dppa := 3;
dataPermissionMask := ''; 
dataRestrictionMask := '0000000000000000000000000';	// byte 6, if 1, restricts experian, byte 8, if 1, restricts equifax, 
																								    // byte 10 restricts Transunion, 12 restricts ADVO, 13 restricts bureau deceased data

                   

//Choose date mode 
selectedMode := 1;  //1 = current, 2 = archive, 3 = archive with current date, 4 = archive passed x years, 5 = date on input file
archiveNumYears := 5;  //number of years to go back (1-5) -- only used with selectedMode = 4
                   
//Choose the Roxie to run on
roxieSelection := 2;  //1 = Dev154, 2 = Dev156, 3 = cert, 4 = prod

//Choose version of query
serviceVersionRequested := '.2';  


//Choose output selections
eyeball := 100;
recordLimit := 10;    //number of records to read from input file; 0 means ALL
outputFileName := '~tgertken::out::' + STD.System.Job.wuid() + '_';
returnOutputFiles := TRUE;                   
                    
                    
threads := 2;




/* *****************************************************
 *                   Validate Section                  *
 *******************************************************/
invalidRequest := MAP(inputData.isBusiness AND productsRequested IN ['CitizenshipOnly', 'AttributesAndCitizenship'] => 'Citizenship cannot be requested for a business',
                      STD.Str.ToUpperCase(TRIM(productsRequested)) = 'MODULES' AND NOT EXISTS(potentialAttributeModules) => 'Need to select module(s) when selecting Module product',
                      inputSelection = 1 AND inputData.includesIdentifyingInfo = FALSE => 'Input file does not contain ' + IF(inputData.isBusiness, 'BII', 'PII'),
                      inputSelection = 2 AND inputData.includesLexID = FALSE => 'Input file does not contain a lexID',
                      inputSelection = 3 AND inputData.includesIdentifyingInfo = FALSE AND inputData.includesLexID = FALSE => 'Input file does not contain ' + IF(inputData.isBusiness, 'BII', 'PII') + ' and lexID',
                      recordLimit = 0 AND returnOutputFiles = FALSE => 'Nothing is being output when running the full file',
                      '');
 
IF(invalidRequest <> '', FAIL(invalidRequest));                  
                    
                    
RiskWise.shortcuts.check_thread_count(threads);




/* *****************************************************
 *             Pre-preprocessing Section               *
 *******************************************************/ 
STRING8 archiveDate := '20160601';
STRING8 today := (STRING8)Std.Date.Today();
STRING8 currrentModeDate := '99999999';

citizenshipModelToRun := 'CIT1808_0_0';


debugOn := FALSE;  
includeIntermediateVariables := FALSE;

//Running as business
runAsBusiness := fileSelection IN [1, 2];


custTypeCd := IF(runAsBusiness, 'B', 'I');  //B = business, I = individual

includePII := inputSelection IN [1, 3];
includeLexID := inputSelection IN [2, 3];
includeCitizenship := productsRequested IN ['CitizenshipOnly', 'AttributesAndCitizenship'] AND inputData.isBusiness = FALSE;

roxieIP := CASE(roxieSelection,
                1 => RiskWise.Shortcuts.dev154,
                2 => RiskWise.Shortcuts.dev156,
                3 => RiskWise.Shortcuts.staging_neutral_roxieIP,
                4 => RiskWise.Shortcuts.prod_batch_analytics_roxie,
                RiskWise.Shortcuts.dev156);
 
serviceName:= 'DueDiligence.DueDiligence_Service' + serviceVersionRequested; 


mapInputTypeText := MAP(inputSelection = 1 => IF(runAsBusiness, 'BIIOnly', 'PIIOnly'),
                        inputSelection = 2 => 'LexIDOnly',
                        inputSelection = 3 => IF(runAsBusiness, 'BII', 'PII') + 'AndLexID',
                        'Unknown');

mapModeText := MAP(selectedMode = 1 => 'CurrentMode',
										selectedMode = 2 => 'ArchiveMode',
										selectedMode = 3 => 'ArchiveCurrentDate',
										selectedMode = 4 => 'ArchiveLast' + archiveNumYears + 'Years',
										selectedMode = 5 => 'DateOnInput',
										'Unknown');
										
mapModeDate := MAP(selectedMode = 1 => currrentModeDate,
										selectedMode = 2 => archiveDate,
										selectedMode = 3 => today,
										selectedMode = 4 => (STRING8)STD.Date.AdjustDate(Std.Date.Today(), -archiveNumYears),
										selectedMode = 5 => '',
										'Unknown');
                    
mapRoxieText := CASE(roxieSelection,
                      1 => 'DEV 154',
                      2 => 'DEV 156',
                      ''); 
 
outputFile := TRIM(outputFileName + 'DueDiligence_Service_' +  IF(inputData.isBusiness, 'business_', 'person_') + 'v' + serviceVersionRequested[2..] + '_');

addVersionText := IF(serviceVersionRequested <> DueDiligence.Constants.EMPTY, 'v' + serviceVersionRequested[2..], DueDiligence.Constants.EMPTY);
#WORKUNIT('name', TRIM(mapRoxieText + ' - ' + recordLimit + ' records - DueDiligenceService ' + addVersionText) + ' - ' + custTypeCd + ' - ' + mapModeText + ' - ' + mapInputTypeText);

reqAttribute := IF(custTypeCd = 'I', DueDiligence.Constants.IND_REQ_ATTRIBUTE_V3, DueDiligence.Constants.BUS_REQ_ATTRIBUTE_V3);





Layout:= RECORD
  INTEGER seq;    
  STRING accountNumber;
  STRING lexID;
  STRING companyOrFirstName;
  #IF(runAsBusiness = FALSE)
    STRING middleName;
  #END
  STRING altCompanyOrLastName;
  STRING50 addr;
  STRING30 city;
  STRING2 state;
  STRING zip;
  #IF(runAsBusiness)
    STRING10 phone1;    //business phone
    STRING9 taxID;      //fein
    STRING historydate;	
    STRING middleName;     //NOT USED
    STRING dateOfBirth;    //NOT USED
  #ELSE
    STRING9 taxID;      //ssn
    STRING10 phone1;    //home phone
    STRING dateOfBirth;
    STRING historydate;
  #END
END;


rawInput := IF(recordLimit = 0, 
               DATASET(inputData.fileName, Layout, CSV(HEADING(single), QUOTE('"'))),
               CHOOSEN(DATASET(inputData.fileName, Layout, CSV(HEADING(single), QUOTE('"'))), recordLimit));


//filter data so we don't have duplicates based on run
lexIDOnlyFilter := DEDUP(SORT(rawInput((UNSIGNED)lexID > 0), (UNSIGNED)lexID, seq), (UNSIGNED)lexID);
identOnlyFilter := DEDUP(SORT(rawInput, companyOrFirstName, altCompanyOrLastName, -middleName, -taxID, addr, city, state, zip, -phone1, -dateOfBirth, seq), companyOrFirstName, altCompanyOrLastName, middleName, taxID, addr, city, state, zip);
lexIDAndIdentFilter := DEDUP(rawInput, ALL);

inputRecords := CASE(inputSelection,
                      1 => identOnlyFilter,
                      2 => lexIDOnlyFilter,
                      lexIDAndIdentFilter);




DD_inLayout := record
	DATASET(iesp.duediligenceattributes.t_DueDiligenceAttributesRequest) DueDiligenceAttributesRequest;
	BOOLEAN debugMode := debugOn;
	BOOLEAN intermediateVariables := includeIntermediateVariables;
  UNSIGNED1 LexIdSourceOptout := 0;
END;


appendZeroAtBeginning(STRING field, UNSIGNED lengthOfField) := FUNCTION
  stripField := STD.Str.Filter(field, DueDiligence.Constants.NUMERIC_VALUES);
  zeroPad := INTFORMAT((UNSIGNED)stripField, lengthOfField, 1);
  RETURN IF(LENGTH(TRIM(field)) = 0, '', zeroPad);
END;

formatTaxID(STRING taxID) := FUNCTION
  RETURN appendZeroAtBeginning(taxID, 9);
END;

formatZip5(STRING zip) := FUNCTION
  RETURN appendZeroAtBeginning(zip, 5);
END;




ddInput := PROJECT(inputRecords, TRANSFORM(DD_inLayout,
                                            sb := DATASET([TRANSFORM(iesp.duediligenceattributes.t_DDRAttributesReportBy,		
	
                                                          taxIDZeroPad := appendZeroAtBeginning(LEFT.TaxID, 9);
                              
                                                          address := DATASET([TRANSFORM(iesp.share.t_Address,
                                                                                        SELF.StreetAddress1 := LEFT.Addr;
                                                                                        SELF.City := LEFT.City;
                                                                                        SELF.State := LEFT.State;
                                                                                        SELF.Zip5 := appendZeroAtBeginning(LEFT.Zip[1..5], 5);
                                                                                        SELF.Zip4 := appendZeroAtBeginning(LEFT.Zip[6..9], 4);
                                                                                        SELF := [];)])[1];
                                                                                        
                                                          personDOB := DATASET([TRANSFORM(iesp.share.t_Date,
                                                                                          SELF.Year := (INTEGER)LEFT.DateOfBirth[1..4];
                                                                                          SELF.Month := (INTEGER)LEFT.DateOfBirth[5..6];
                                                                                          SELF.Day := (INTEGER)LEFT.DateOfBirth[7..8];)])[1];
                                                                                          
                                                          personName := DATASET([TRANSFORM(iesp.share.t_Name,
                                                                                            SELF.First := LEFT.CompanyOrFirstName;
                                                                                            SELF.Middle := LEFT.middleName;
                                                                                            SELF.Last := LEFT.AltCompanyOrLastName;
                                                                                            SELF := [];)])[1];                              
                                                          
                                                          
                                                          
                                                          
                                                          
                                                          SELF.Business := IF(inputData.isBusiness, 
                                                                                DATASET([TRANSFORM(iesp.duediligenceshared.t_DDRAttributesBusiness,
                                                                                                    SELF.CompanyName := IF(includePII, LEFT.CompanyOrFirstName, '');
                                                                                                    SELF.AlternateCompanyName := IF(includePII, LEFT.AltCompanyOrLastName, '');
                                                                                                    SELF.Phone := IF(includePII, LEFT.Phone1, '');
                                                                                                    SELF.FEIN := IF(includePII, taxIDZeroPad, '');
                                                                                                    SELF.Address := IF(includePII, address);
                                                                                                    SELF.LexID := IF(includeLexID, LEFT.lexID, '');
                                                                                                    SELF := [];)]),
                                                                                DATASET([], iesp.duediligenceshared.t_DDRAttributesBusiness))[1];
                                                                                
                                                                                
                                                          SELF.Person := IF(inputData.isBusiness,
                                                                                DATASET([], iesp.duediligenceattributes.t_DDRPersonAttributesReportBy),
                                                                                DATASET([TRANSFORM(iesp.duediligenceattributes.t_DDRPersonAttributesReportBy,
                                                                                                    SELF.LexID := IF(includeLexID, LEFT.LexID, '');
                                                                                                    SELF.Phone := IF(includePII, LEFT.Phone1, '');
                                                                                                    SELF.SSN := IF(includePII, taxIDZeroPad, '');
                                                                                                    SELF.DOB := IF(includePII, personDOB);
                                                                                                    SELF.Name := IF(includePII, personName);
                                                                                                    SELF.Address := IF(includePII, address);
                                                                                                    SELF.Citizenship.CitizenshipModelName := IF(includeCitizenship, citizenshipModelToRun, '');
                                                                                                    SELF := [];)]))[1];

                                                          SELF.ProductRequestType := productsRequested;
                                                          SELF.AttributeModules := PROJECT(potentialAttributeModules, TRANSFORM(iesp.duediligenceshared.t_DDRAttributeModule,
                                                                                           SELF.name := LEFT.attrs;));
                                                          
                                                          SELF := [];)]);
                                            
                                            o := DATASET([TRANSFORM(iesp.duediligenceshared.t_DDRAttributesOptions,
                                                                      SELF.DDAttributesVersionRequest := reqAttribute; 
                                                                      
                                                                      tempDate := DATASET([TRANSFORM(iesp.share.t_Date,
                                                                                                      SELF.Year := (INTEGER)mapModeDate[1..4];
                                                                                                      SELF.Month := (INTEGER)mapModeDate[5..6];
                                                                                                      SELF.Day := (INTEGER)mapModeDate[7..8];)])[1];
                                                                                                              
                                                                      
                                                                      
                                                                      firstDateSlash := STD.Str.Find(LEFT.historyDate, '/', 1);
                                                                      secondDateSlash := STD.Str.Find(LEFT.historyDate, '/', 2);
                                                                      
                                                                      month := (UNSIGNED)IF(firstDateSlash > 0, LEFT.historyDate[1..(firstDateSlash - 1)], LEFT.historyDate[5..6]);
                                                                      day := (UNSIGNED)IF(firstDateSlash > 0, LEFT.historyDate[(firstDateSlash + 1)..(secondDateSlash - 1)], LEFT.historyDate[7..8]);
                                                                      year := (UNSIGNED)IF(firstDateSlash > 0, LEFT.historyDate[(secondDateSlash + 1)..], LEFT.historyDate[1..4]);
                                                                      
                                                                      tempInputDateMonth := INTFORMAT(month, 2, 1);
                                                                      tempInputDateDay := INTFORMAT(day, 2, 1);
                                                                      tempInputDateYear := year;
                                                                      
                                                                      tempInputFileDate := DATASET([TRANSFORM(iesp.share.t_Date,
                                                                                                              SELF.Year := (INTEGER)tempInputDateYear;
                                                                                                              SELF.Month := (INTEGER)tempInputDateMonth;
                                                                                                              SELF.Day := (INTEGER)tempInputDateDay;)])[1];
                                                                      
                                                                      SELF.HistoryDate := IF(mapModeDate = '', tempInputFileDate, tempDate);
                                                                      SELF := [];)]);
                                                                      
                                            u := DATASET([TRANSFORM(iesp.share.t_User, 
                                                                      SELF.AccountNumber := LEFT.AccountNumber; 
                                                                      SELF.DataRestrictionMask := dataRestrictionMask;
                                                                      SELF.DataPermissionMask := dataPermissionMask;
                                                                      SELF.GLBPurpose := (STRING)glba;
                                                                      SELF.DLPurpose := (STRING)dppa;
                                                                      SELF := [])]);
                                                                    
                                            req := DATASET([TRANSFORM(iesp.duediligenceattributes.t_DueDiligenceAttributesRequest,
                                                                        SELF.ReportBy := sb[1];
                                                                        SELF.Options := o[1];
                                                                        SELF.User := u[1];
                                                                        SELF := [];)]);
                                                                        
                                                                        
                                                                        
                                            SELF.DueDiligenceAttributesRequest := req[1];));


ddInputDist := DISTRIBUTE(ddInput, RANDOM());                 
                    
                    





/* *****************************************************
 *                Processing Section                   *
 *******************************************************/ 

soapResponselayout := RECORD
	UNSIGNED8 time_ms{xpath('_call_latency_ms')} := 0;  // picks up timing
  STRING errorCode;
  iesp.duediligenceattributes.t_DueDiligenceAttributesResponse response {XPATH('Results/Result/Dataset[@name=\'Results\']/Row')};
END;

soapResponselayout myFail(ddInputDist le) := TRANSFORM
	SELF.errorCode := FAILCODE + FAILMESSAGE;
	SELF := le;
	SELF := [];
END;

ddResults := SOAPCALL(ddInputDist, 
											roxieIP,
											serviceName, 
											{ddInputDist}, 
											DATASET(soapResponselayout),
											RETRY(5), TIMEOUT(500),
											XPATH('*'),   //case sensitive
											PARALLEL(threads), 
											ONFAIL(myFail(LEFT)));                
                    
                    





/* *****************************************************
 *            Data Transformation Section              *
 *******************************************************/ 
	
AllDataLayout := RECORD
  UNSIGNED8 time_ms;
  INTEGER inputSeq;
  STRING inputAccountNum;
  STRING did;
  UNSIGNED didScore;
  STRING seleID;
  UNSIGNED seleIDScore;
  BOOLEAN lexIDChanged;
  iesp.duediligenceattributes.t_DDRPersonAttributesReportBy inputPersonInfo;
  iesp.duediligenceshared.t_DDRAttributesBusiness inputBusinessInfo;
  iesp.duediligenceshared.t_DDRAttributeGroup ddAttributes;
  iesp.duediligenceattributes.t_DDRCitizenshipResults citResults;
END;			
											

//those that didn't error
baseNoErrors := PROJECT(ddResults(errorCode = ''), TRANSFORM(AllDataLayout, 
                                                              SELF.did := LEFT.response.result.UniqueId;
                                                              SELF.didScore := LEFT.response.result.PersonLexIDMatch;
                                                              SELF.seleID := LEFT.response.result.BusinessId;
                                                              SELF.seleIDScore := LEFT.response.result.BusinessLexIDMatch;
                                                              SELF.inputPersonInfo := LEFT.response.result.inputEcho.person;
                                                              SELF.inputBusinessInfo := LEFT.response.result.inputEcho.business;
                                                              SELF.citResults := LEFT.response.result.CitizenshipResults;
                                                              SELF.ddAttributes := LEFT.response.result.AttributeGroup;
                                                              SELF.time_ms := LEFT.time_ms;
                                                              SELF.lexIDChanged := LEFT.response.result.lexIDChanged;
                                                              SELF := [];)); 


  
piiPersonExpand := 'TRIM(LEFT.Phone1) = TRIM(RIGHT.inputPersonInfo.phone) AND ' +
                    'IF((UNSIGNED)TRIM(LEFT.DateOfBirth[..8]) = 0, DueDiligence.Constants.EMPTY, TRIM(LEFT.DateOfBirth[..8])) = TRIM(iesp.ECL2ESP.t_DateToString8(RIGHT.inputPersonInfo.dob)) AND ' +
                    'TRIM(LEFT.Addr[..50]) = TRIM(RIGHT.inputPersonInfo.address.streetAddress1) AND ' +
                    'TRIM(LEFT.City[..25]) = TRIM(RIGHT.inputPersonInfo.address.city) AND ' +
                    'TRIM(LEFT.State) = TRIM(RIGHT.inputPersonInfo.address.state) AND ' +
                    'TRIM(formatZip5(LEFT.zip[..5])) = TRIM(RIGHT.inputPersonInfo.address.zip5 + RIGHT.inputPersonInfo.address.zip4) AND ' +
                    'TRIM(formatTaxID(LEFT.taxID)) = TRIM(RIGHT.inputPersonInfo.ssn) AND ' +
                    'TRIM(LEFT.CompanyOrFirstName[..20]) = TRIM(RIGHT.inputPersonInfo.name.first) AND ' +
                    'TRIM(LEFT.MiddleName[..20]) = TRIM(RIGHT.inputPersonInfo.name.middle) AND ' +
                    'TRIM(LEFT.AltCompanyOrLastName[..20]) = TRIM(RIGHT.inputPersonInfo.name.last)';

lexIDPersonExpand := '(UNSIGNED)LEFT.lexID = (UNSIGNED)RIGHT.inputPersonInfo.lexID';


biiBusinessExpand := //'TRIM(LEFT.Phone1) = TRIM(RIGHT.inputBusinessInfo.phone) AND ' +
                      'TRIM(LEFT.Addr[..50]) = TRIM(RIGHT.inputBusinessInfo.address.streetAddress1) AND ' +
                      'TRIM(LEFT.City[..25]) = TRIM(RIGHT.inputBusinessInfo.address.city) AND ' +
                      'TRIM(LEFT.State) = TRIM(RIGHT.inputBusinessInfo.address.state) AND ' +
                      'TRIM(formatZip5(LEFT.zip[..5])) = TRIM(RIGHT.inputBusinessInfo.address.zip5 + RIGHT.inputBusinessInfo.address.zip4) AND ' +
                      'TRIM(formatTaxID(LEFT.taxID)) = TRIM(RIGHT.inputBusinessInfo.fein) AND ' +
                      'TRIM(LEFT.CompanyOrFirstName) = TRIM(RIGHT.inputBusinessInfo.companyName) AND ' +
                      'TRIM(LEFT.AltCompanyOrLastName) = TRIM(RIGHT.inputBusinessInfo.alternateCompanyName)';




lexIDBusinessExpand := '(UNSIGNED)LEFT.lexID = (UNSIGNED)RIGHT.inputBusinessInfo.lexID';

joinCondition := MAP(runAsBusiness AND inputSelection = 1 => biiBusinessExpand,
                     runAsBusiness AND inputSelection = 2 => lexIDBusinessExpand,
                     runAsBusiness AND inputSelection = 3 => biiBusinessExpand + ' AND ' + lexIDBusinessExpand,
                     inputSelection = 1 => piiPersonExpand,
                     inputSelection = 2 => lexIDPersonExpand,
                     inputSelection = 3 => piiPersonExpand + ' AND ' + lexIDPersonExpand,
                        '');
				  

base := JOIN(inputRecords, baseNoErrors,
              #EXPAND(joinCondition),
              TRANSFORM(AllDataLayout,
                        SELF.inputSeq := LEFT.seq;
                        SELF.inputAccountNum := LEFT.accountNumber;
                        SELF := RIGHT;));


notFound := JOIN(inputRecords, baseNoErrors,
                  #EXPAND(joinCondition),
                  TRANSFORM(layout,
                            SELF := LEFT;),
                  LEFT ONLY);
                  

processedTimings := PROJECT(base, TRANSFORM({UNSIGNED8 timeMS, UNSIGNED inputSeq, STRING inputAcct, STRING lexID},
                                                          SELF.timeMS := LEFT.time_ms;
                                                          SELF.inputSeq := LEFT.inputSeq;
                                                          SELF.inputAcct := LEFT.inputAccountNum;
                                                          SELF.lexID := IF(inputData.isBusiness, LEFT.seleID, LEFT.did);));




SlimAttrsLayout := RECORD
  UNSIGNED seq;
  BOOLEAN lexIDChanged;
  #IF(runAsBusiness)
    DueDiligence.v3Layouts.DDOutput.BusAttributes;
    iesp.duediligenceshared.t_DDRAttributesBusiness busInput;
  #ELSE
    DueDiligence.v3Layouts.DDOutput.PerAttributes;
    #IF(includeCitizenship)
      DueDiligence.Citizenship.Layouts.LayoutScoreAndIndicators;
    #END
    iesp.duediligenceattributes.t_DDRPersonAttributesReportBy perInput;
  #END
END;



slimAttrs := PROJECT(base, TRANSFORM(SlimAttrsLayout, 
                                                
                                      SELF.seq := LEFT.inputSeq;
                                      
                                      #IF(runAsBusiness)
                                        SELF.busLexID := (STRING)LEFT.seleID;
                                        SELF.busLexIDMatch := (STRING)LEFT.seleIDScore;
                                        
                                        attributes := LEFT.ddAttributes.attributes;
                                        attributeHits := LEFT.ddAttributes.attributeLevelHits;

                                        SELF.BusAssetOwnProperty := attributes(TRIM(name) = 'BusAssetOwnProperty')[1].value;
                                        SELF.BusAssetOwnAircraft := attributes(TRIM(name) = 'BusAssetOwnAircraft')[1].value;
                                        SELF.BusAssetOwnWatercraft := attributes(TRIM(name) = 'BusAssetOwnWatercraft')[1].value;
                                        SELF.BusAssetOwnVehicle := attributes(TRIM(name) = 'BusAssetOwnVehicle')[1].value;
                                        SELF.BusAccessToFundSales := attributes(TRIM(name) = 'BusAccessToFundSales')[1].value;
                                        SELF.BusAccessToFundsProperty := attributes(TRIM(name) = 'BusAccessToFundsProperty')[1].value;
                                        SELF.BusGeographic := attributes(TRIM(name) = 'BusGeographic')[1].value;
                                        SELF.BusValidity := attributes(TRIM(name) = 'BusValidity')[1].value;
                                        SELF.BusStability := attributes(TRIM(name) = 'BusStability')[1].value;
                                        SELF.BusIndustry := attributes(TRIM(name) = 'BusIndustry')[1].value;
                                        SELF.BusStructureType := attributes(TRIM(name) = 'BusStructureType')[1].value;
                                        SELF.BusSOSAgeRange := attributes(TRIM(name) = 'BusSOSAgeRange')[1].value;
                                        SELF.BusPublicRecordAgeRange := attributes(TRIM(name) = 'BusPublicRecordAgeRange')[1].value;
                                        SELF.BusShellShelf := attributes(TRIM(name) = 'BusShellShelf')[1].value;
                                        SELF.BusMatchLevel := attributes(TRIM(name) = 'BusMatchLevel')[1].value;
                                        SELF.BusStateLegalEvent := attributes(TRIM(name) = 'BusStateLegalEvent')[1].value;
                                        SELF.BusFederalLegalEvent := attributes(TRIM(name) = 'BusFederalLegalEvent')[1].value;
                                        SELF.BusFederalLegalMatchLevel := attributes(TRIM(name) = 'BusFederalLegalMatchLevel')[1].value;
                                        SELF.BusCivilLegalEvent := attributes(TRIM(name) = 'BusCivilLegalEvent')[1].value;
                                        SELF.BusCivilLegalEventFilingAmt := attributes(TRIM(name) = 'BusCivilLegalEventFilingAmt')[1].value;
                                        SELF.BusOffenseType := attributes(TRIM(name) = 'BusOffenseType')[1].value;
                                        SELF.BusBEOProfLicense := attributes(TRIM(name) = 'BusBEOProfLicense')[1].value;
                                        SELF.BusBEOUSResidency := attributes(TRIM(name) = 'BusBEOUSResidency')[1].value;
                                        SELF.BusBEOAccessToFundsProperty := attributes(TRIM(name) = 'BusBEOAccessToFundsProperty')[1].value;
                                        SELF.BusLinkedBusinesses := attributes(TRIM(name) = 'BusLinkedBusinesses')[1].value;

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
                                        
                                        SELF.busInput := LEFT.inputBusinessInfo;
                                      
                                      #ELSE
                                      
                                        SELF.perLexID := (STRING)LEFT.did;
                                        SELF.perLexIDMatch := (STRING)LEFT.didScore;
                                        
                                        attributes := LEFT.ddAttributes.attributes;
                                        attributeHits := LEFT.ddAttributes.attributeLevelHits;

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
                                        
                                        #IF(includeCitizenship)
                                          SELF.citizenshipScore := LEFT.citResults.CitizenshipScore;
                                          
                                          cit := LEFT.citResults.CitizenshipAttributes;
                                          
                                          SELF.LexID := (INTEGER)cit(TRIM(name) = 'LexID')[1].value;
                                          SELF.LexIDScore := (INTEGER)cit(TRIM(name) = 'LexIDScore')[1].value;
                                          SELF.IdentityAge := (INTEGER)cit(TRIM(name) = 'IdentityAge')[1].value;
                                          SELF.EmergenceAgeHeader := (INTEGER)cit(TRIM(name) = 'EmergenceAgeHeader')[1].value;
                                          SELF.EmergenceAgeBureau := (INTEGER)cit(TRIM(name) = 'EmergenceAgeBureau')[1].value;
                                          SELF.SSNIssuanceAge := (INTEGER)cit(TRIM(name) = 'SSNIssuanceAge')[1].value;
                                          SELF.SSNIssuanceYears := (INTEGER)cit(TRIM(name) = 'SSNIssuanceYears')[1].value;
                                          SELF.RelativeCount := (INTEGER)cit(TRIM(name) = 'RelativeCount')[1].value;
                                          SELF.Ver_voterRecords := (INTEGER)cit(TRIM(name) = 'Ver_voterRecords')[1].value;
                                          SELF.Ver_insuranceRecords := (INTEGER)cit(TRIM(name) = 'Ver_insuranceRecords')[1].value;
                                          SELF.Ver_studentFile := (INTEGER)cit(TRIM(name) = 'Ver_studentFile')[1].value;
                                          SELF.FirstSeenAddr10 := (INTEGER)cit(TRIM(name) = 'FirstSeenAddr10')[1].value;
                                          SELF.ReportedCurAddressYears := (INTEGER)cit(TRIM(name) = 'ReportedCurAddressYears')[1].value;
                                          SELF.AddressFirstReportedAge := (INTEGER)cit(TRIM(name) = 'AddressFirstReportedAge')[1].value;
                                          SELF.TimeSinceLastReportedNonBureau := (INTEGER)cit(TRIM(name) = 'TimeSinceLastReportedNonBureau')[1].value;
                                          SELF.InputSSNRandomlyIssued := (INTEGER)cit(TRIM(name) = 'InputSSNRandomlyIssued')[1].value;
                                          SELF.InputSSNRandomIssuedInvalid := (INTEGER)cit(TRIM(name) = 'InputSSNRandomIssuedInvalid')[1].value;
                                          SELF.InputSSNIssuedToNonUS := (INTEGER)cit(TRIM(name) = 'InputSSNIssuedToNonUS')[1].value;
                                          SELF.InputSSNITIN := (INTEGER)cit(TRIM(name) = 'InputSSNITIN')[1].value;
                                          SELF.InputSSNInvalid := (INTEGER)cit(TRIM(name) = 'InputSSNInvalid')[1].value;
                                          SELF.InputSSNIssuedPriorDOB := (INTEGER)cit(TRIM(name) = 'InputSSNIssuedPriorDOB')[1].value;
                                          SELF.InputSSNAssociatedMultLexIDs := (INTEGER)cit(TRIM(name) = 'InputSSNAssociatedMultLexIDs')[1].value;
                                          SELF.InputSSNReportedDeceased := (INTEGER)cit(TRIM(name) = 'InputSSNReportedDeceased')[1].value;
                                          SELF.InputSSNNotPrimaryLexID := (INTEGER)cit(TRIM(name) = 'InputSSNNotPrimaryLexID')[1].value;
                                          SELF.LexIDBestSSNInvalid := (INTEGER)cit(TRIM(name) = 'LexIDBestSSNInvalid')[1].value;
                                          SELF.LexIDReportedDeceased := (INTEGER)cit(TRIM(name) = 'LexIDReportedDeceased')[1].value;
                                          SELF.LexIDMultipleSSNs := (INTEGER)cit(TRIM(name) = 'LexIDMultipleSSNs')[1].value;
                                          SELF.InputComponentDivRisk := (INTEGER)cit(TRIM(name) = 'InputComponentDivRisk')[1].value;
                                        #END
                                        
                                        SELF.perInput := LEFT.inputPersonInfo;
                                      #END
                                      
                                      SELF := LEFT;));                  
                    
                    





/* *****************************************************
 *                   Analysis Section                  *
 *******************************************************/    
tbleLayout := RECORD
  UNSIGNED numberRawInput := COUNT(rawInput);
  UNSIGNED inputRecords := COUNT(inputRecords);
  UNSIGNED rawDDResults := COUNT(ddResults);
  UNSIGNED ddResultsWithErrors := COUNT(ddResults(errorCode <> ''));
  UNSIGNED ddResultsNoErrors := COUNT(ddResults(errorCode = ''));
  UNSIGNED ddResultsNotProcessed := COUNT(notFound);
  UNSIGNED rowsInFinalOutputFile := COUNT(slimAttrs);
  UNSIGNED lexIDsChanged := COUNT(slimAttrs(lexIDChanged));
  #IF(runAsBusiness)
    UNSIGNED noBusDataFound := COUNT(slimAttrs(busMatchLevel = '-1'));
    UNSIGNED busDataFound := COUNT(slimAttrs(busMatchLevel <> '-1'));
  #ELSE
    UNSIGNED noPerDataFound := COUNT(slimAttrs(perMatchLevel = '-1'));
    UNSIGNED perDataFound := COUNT(slimAttrs(perMatchLevel <> '-1'));
  #END
  UNSIGNED ddResultsWithNoAttributes := COUNT(base(NOT EXISTS(ddAttributes.attributes)));
  UNSIGNED averageTiming := AVE(processedTimings, timeMS);
  UNSIGNED fastestRequest := MIN(processedTimings, timeMS);
  UNSIGNED slowestRequest := MAX(processedTimings, timeMS);
END;

                        
                        
summary := TABLE(DATASET([{1}], {UNSIGNED dumb}), tbleLayout);

                                     
                                      
    
    

OUTPUT(inputData, NAMED('inputData'));      
OUTPUT(CHOOSEN(rawInput, eyeball), NAMED('rawInput'));      
OUTPUT(CHOOSEN(inputRecords, eyeball), NAMED('inputRecords')); 
OUTPUT(CHOOSEN(ddInput, eyeball), NAMED('ddInput')); 
OUTPUT(CHOOSEN(ddResults, eyeball), NAMED('ddResults')); 
OUTPUT(CHOOSEN(base, eyeball), NAMED('base')); 
OUTPUT(CHOOSEN(notFound, eyeball), NAMED('notFound')); 
OUTPUT(CHOOSEN(processedTimings, eyeball), NAMED('processedTimings')); 
OUTPUT(CHOOSEN(slimAttrs, eyeball), NAMED('slimAttrs'));     
OUTPUT(summary, NAMED('DDResultsSummary')); 

                   
                    
IF(returnOutputFiles, OUTPUT(slimAttrs,, outputFile + 'Attrs.csv', CSV(HEADING(single), QUOTE('"'))));	
IF(returnOutputFiles, OUTPUT(processedTimings,, outputFile + 'SlimTimings.csv', CSV(HEADING(single), QUOTE('"'))));
IF(returnOutputFiles, OUTPUT(notFound,, outputFile + 'Not_Processed.csv', CSV(HEADING(single), QUOTE('"'))));
IF(returnOutputFiles, OUTPUT(summary,, outputFile + 'Results_Summary.csv', CSV(HEADING(single), QUOTE('"'))));
