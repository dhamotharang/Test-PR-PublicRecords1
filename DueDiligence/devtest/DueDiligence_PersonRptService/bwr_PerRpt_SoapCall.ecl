IMPORT DueDiligence, iesp, RiskWise, STD;

/* *****************************************************
 *                   Options Section                   *
 *******************************************************/
//Choose input data options
inputSelection := 3; //1 = PII only, 2 = lexID only, 3 = both PII and lexID 

//Choose file to run
fileSelection := 3;

inputInfoLayout := RECORD
  STRING fileName;
  BOOLEAN includesIdentifyingInfo; //PII
  BOOLEAN includesLexID;  //LexID aka DID
END;

inputData := CASE(fileSelection,
                    1 => DATASET([{'~tgertken::in::individual_pii_only_168k.csv', TRUE, FALSE}], inputInfoLayout),
                    2 => DATASET([{'~tgertken::in::individual_pii_lexid_168k.csv', TRUE, TRUE}], inputInfoLayout),
                    3 => DATASET([{'~tgertken::out::dd_dist_output_with_lexid.csv', TRUE, TRUE}], inputInfoLayout),
                    4 => DATASET([{'~tgertken::out::unique_dd_dist_output_with_lexid_20200303.csv', TRUE, TRUE}], inputInfoLayout),
                    5 => DATASET([{'~tgertken::out::dd_dist_output_with_lexID.csv', TRUE, TRUE}], inputInfoLayout),
                    DATASET([], inputInfoLayout))[1];
  
  
//Select the product(s) to run
productsRequested := 'AttributesOnly'; // VALUES:[AttributesOnly, Modules]
potentialAttributeModules := DATASET([], {STRING attrs}); //VALUES: [ECONOMIC, GEOGRAPHIC, IDENTITY, LEGAL, NETWORK]


//Select compliance settings
glba := 1;
dppa := 3;
dataPermissionMask := '0000000000000'; 
dataRestrictionMask := '0000000000000000000000000';	// byte 6, if 1, restricts experian, byte 8, if 1, restricts equifax, 
																								    // byte 10 restricts Transunion, 12 restricts ADVO, 13 restricts bureau deceased data

                   

//Choose date mode 
selectedMode := 1;  //1 = current, 2 = archive, 3 = archive with current date, 4 = archive passed x years, 5 = date on input file
archiveNumYears := 5;  //number of years to go back (1-5) -- only used with selectedMode = 4
                   
//Choose the Roxie to run on
roxieSelection := 2;  //1 = Dev154, 2 = Dev156, 3 = cert, 4 = prod

//Choose version of query
serviceVersionRequested := '.19';  


//Choose output selections
eyeball := 100;
recordLimit := 10;    //number of records to read from input file; 0 means ALL
outputFileName := '~tgertken::out::' + STD.System.Job.wuid() + '_';
returnOutputFiles := TRUE;                   
                    

includeEconomic := FALSE;
includeLegal := FALSE;
includeGeo := FALSE;
includeIdentity := FALSE;
includeNetwork := FALSE;                    


threads := 2;


/* *****************************************************
 *                   Validate Section                  *
 *******************************************************/
invalidRequest := MAP(STD.Str.ToUpperCase(TRIM(productsRequested)) = 'MODULES' AND NOT EXISTS(potentialAttributeModules) => 'Need to select module(s) when selecting Module product',
                      inputSelection = 1 AND inputData.includesIdentifyingInfo = FALSE => 'Input file does not contain PII',
                      inputSelection = 2 AND inputData.includesLexID = FALSE => 'Input file does not contain a lexID',
                      inputSelection = 3 AND inputData.includesIdentifyingInfo = FALSE AND inputData.includesLexID = FALSE => 'Input file does not contain PII and lexID',
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



debugOn := FALSE;  
includeIntermediateVariables := FALSE;


includePII := inputData.includesIdentifyingInfo;
includeLexID := inputData.includesLexID;

roxieIP := CASE(roxieSelection,
                1 => RiskWise.Shortcuts.dev154,
                2 => RiskWise.Shortcuts.dev156,
                3 => RiskWise.Shortcuts.staging_neutral_roxieIP,
                4 => RiskWise.Shortcuts.prod_batch_analytics_roxie,
                RiskWise.Shortcuts.dev156);
 
serviceName:= 'DueDiligence.DueDiligence_PersonRptService' + serviceVersionRequested; 


mapInputTypeText := MAP(inputSelection = 1 => 'PIIOnly',
                        inputSelection = 2 => 'LexIDOnly',
                        inputSelection = 3 => 'PIIAndLexID',
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
 
outputFile := TRIM(outputFileName + 'DueDiligence_PersonRptService_v' + serviceVersionRequested[2..] + '_' + TRIM(mapInputTypeText) + '_');


addVersionText := IF(serviceVersionRequested <> DueDiligence.Constants.EMPTY, 'v' + serviceVersionRequested[2..], DueDiligence.Constants.EMPTY);
#WORKUNIT('name', TRIM(mapRoxieText + ' - ' + recordLimit + ' records - DueDiligencePersonRptService ' + addVersionText) + ' - ' + mapModeText + ' - ' + mapInputTypeText);

reqAttribute := DueDiligence.Constants.IND_REQ_ATTRIBUTE_V3;




Layout:= RECORD
  INTEGER seq;    
  STRING accountNumber;
  #IF(fileSelection IN [3, 4, 5])
    STRING firstname;
    STRING middlename;
    STRING lastname;
    STRING50 addr;
    STRING30 city;
    STRING2 state;
    STRING9 zip;
    STRING9 taxid;
    STRING10 phone1;
    STRING dateofbirth;
    STRING workphone;
    STRING income;
    STRING dlnumber;
    STRING dlstate;
    STRING balance;
    STRING chargeoffd;
    STRING formername;
    STRING email;
    STRING employername;
    STRING historydate;
    STRING lexid;
  #ELSE
    STRING lexID;
    STRING firstName;
    STRING middleName;
    STRING lastName;
    STRING50 addr;
    STRING30 city;
    STRING2 state;
    STRING zip;
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
lexIDOnlyFilter := DEDUP(SORT(rawInput((UNSIGNED)lexID > 0), (UNSIGNED)lexID), (UNSIGNED)lexID);
identOnlyFilter := DEDUP(SORT(rawInput, firstName, lastName, -middleName, -taxID, addr, city, state, zip, -phone1, -dateOfBirth), firstName, lastName, middleName, taxID, addr, city, state, zip);
lexIDAndIdentFilter := DEDUP(rawInput, ALL);

inputRecords := CASE(inputSelection,
                      1 => identOnlyFilter,
                      2 => lexIDOnlyFilter,
                      lexIDAndIdentFilter);




DD_inLayout := record
	DATASET(iesp.duediligencepersonreport.t_DueDiligencePersonReportRequest) DueDiligencePersonReportRequest;
	BOOLEAN debugMode := debugOn;
	BOOLEAN intermediateVariables := includeIntermediateVariables;
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
                                            rb := DATASET([TRANSFORM(iesp.duediligencepersonreport.t_DDRPersonReportBy,		
	
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
                                                                                            SELF.First := LEFT.firstName;
                                                                                            SELF.Middle := LEFT.middleName;
                                                                                            SELF.Last := LEFT.lastName;
                                                                                            SELF := [];)])[1];    
                                                                                
                                                                                
                                                          SELF.Person := DATASET([TRANSFORM(iesp.duediligenceattributes.t_DDRPersonAttributesReportBy,
                                                                                                    SELF.LexID := IF(includeLexID, LEFT.LexID, '');
                                                                                                    SELF.Phone := IF(includePII, LEFT.Phone1, '');
                                                                                                    SELF.SSN := IF(includePII, taxIDZeroPad, '');
                                                                                                    SELF.DOB := IF(includePII, personDOB);
                                                                                                    SELF.Name := IF(includePII, personName);
                                                                                                    SELF.Address := IF(includePII, address);
                                                                                                    SELF := [];)])[1];

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
                                                                    
                                            req := DATASET([TRANSFORM(iesp.duediligencepersonreport.t_DueDiligencePersonReportRequest,
                                                                        SELF.ReportBy := rb[1];
                                                                        SELF.Options := o[1];
                                                                        SELF.User := u[1];
                                                                        SELF := [];)]);
                                                                        
                                                                        
                                                                        
                                            SELF.DueDiligencePersonReportRequest := req[1];));


ddInputDist := DISTRIBUTE(ddInput, RANDOM());                 
                    
                    





/* *****************************************************
 *                Processing Section                   *
 *******************************************************/ 

soapResponselayout := RECORD
	UNSIGNED8 time_ms{xpath('_call_latency_ms')} := 0;  // picks up timing
  STRING errorCode;
  iesp.duediligencepersonreport.t_DueDiligencePersonReportResponse results {XPATH('Results/Result/Dataset[@name=\'Results\']/Row')};
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

noErrors := ddResults(errorCode = '');


SlimPersonReportLayout := RECORD
  UNSIGNED8 time_ms;
  UNSIGNED seq;
  STRING accountNumber;
  UNSIGNED did;
  BOOLEAN lexIDChanged;
  iesp.duediligencepersonreport.t_DDRPersonReportBy InputEcho;
  iesp.share.t_Address BestAddress;
  DueDiligence.v3Layouts.DDOutput.PerAttributes;
  DATASET(iesp.share.t_NameValuePair) Attributes;
	DATASET(iesp.share.t_NameValuePair) AttributeHitFlags;  
  iesp.duediligencepersonreport.t_DDRPersonEconomicAttributeDetails economic;
  iesp.duediligencepersonreport.t_DDRPersonLegalAttributeDetails legal;
	iesp.duediligencepersonreport.t_DDRPersonAssociations personAssociation;
	iesp.duediligencepersonreport.t_DDRPersonProfessionalNetworkDetails professionalNetwork;
	iesp.duediligencepersonreport.t_DDRBusinessAssocations businessAssociation;
	iesp.duediligencepersonreport.t_DDRIdentityAttributeDetails identity;
	iesp.duediligencepersonreport.t_DDRPersonGeographicAttributeDetails geographic;
END;   

    
slimReportRaw := PROJECT(noErrors, TRANSFORM(SlimPersonReportLayout, 
                                              SELF.time_ms := LEFT.time_ms;
                                              SELF.perLexID := LEFT.results.result.uniqueID;
                                              SELF.perLexIDMatch := (STRING)LEFT.results.result.personLexIDMatch;
                                              SELF.lexIDChanged := LEFT.results.result.lexIDChanged;
                                              SELF.attributes := LEFT.results.result.AttributeGroup.Attributes;
                                              SELF.attributeHitFlags := LEFT.results.result.AttributeGroup.AttributeLevelHits;
                                              SELF.legal := LEFT.results.result.personReport.PersonAttributeDetails.Legal;
                                              SELF.economic := LEFT.results.result.personReport.PersonAttributeDetails.Economic;
                                              SELF.identity := LEFT.results.result.personReport.PersonAttributeDetails.Identitiy;
                                              SELF.geographic := LEFT.results.result.personReport.PersonAttributeDetails.Geographic;
                                              SELF.professionalNetwork := LEFT.results.result.personReport.PersonAttributeDetails.ProfessionalNetwork;
                                              SELF.businessAssociation := LEFT.results.result.personReport.PersonAttributeDetails.BusinessAssocation;
                                              SELF.personAssociation := LEFT.results.result.personReport.PersonAttributeDetails.PersonAssociation;
                                              SELF.inputEcho := LEFT.results.result.InputEcho;
                                              SELF.bestAddress := LEFT.results.result.PersonReport.PersonInformation.bestAddress;
                                              SELF := [];));


  
piiPersonExpand := 'TRIM(LEFT.Phone1) = TRIM(RIGHT.inputEcho.person.phone) AND ' +
                    'IF((UNSIGNED)TRIM(LEFT.DateOfBirth[..8]) = 0, DueDiligence.Constants.EMPTY, TRIM(LEFT.DateOfBirth[..8])) = TRIM(iesp.ECL2ESP.t_DateToString8(RIGHT.inputEcho.person.dob)) AND ' +
                    'TRIM(LEFT.Addr[..50]) = TRIM(RIGHT.inputEcho.person.address.streetAddress1) AND ' +
                    'TRIM(LEFT.City[..25]) = TRIM(RIGHT.inputEcho.person.address.city) AND ' +
                    'TRIM(LEFT.State) = TRIM(RIGHT.inputEcho.person.address.state) AND ' +
                    'TRIM(formatZip5(LEFT.zip[..5])) = TRIM(RIGHT.inputEcho.person.address.zip5 + RIGHT.inputEcho.person.address.zip4) AND ' +
                    'TRIM(formatTaxID(LEFT.taxID)) = TRIM(RIGHT.inputEcho.person.ssn) AND ' +
                    'TRIM(LEFT.firstName[..20]) = TRIM(RIGHT.inputEcho.person.name.first) AND ' +
                    'TRIM(LEFT.MiddleName[..20]) = TRIM(RIGHT.inputEcho.person.name.middle) AND ' +
                    'TRIM(LEFT.lastName[..20]) = TRIM(RIGHT.inputEcho.person.name.last)';

lexIDPersonExpand := '(UNSIGNED)LEFT.lexID = (UNSIGNED)RIGHT.inputEcho.person.lexID';


joinCondition := MAP(inputSelection = 1 => piiPersonExpand,
                     inputSelection = 2 => lexIDPersonExpand,
                     inputSelection = 3 => piiPersonExpand + ' AND ' + lexIDPersonExpand,
                        '');
				  

base := JOIN(inputRecords, slimReportRaw,
              #EXPAND(joinCondition),
              TRANSFORM(SlimPersonReportLayout,
                        SELF.seq := LEFT.seq;
                        SELF.accountNumber := LEFT.accountNumber;
                        SELF.did := (UNSIGNED)LEFT.lexID;
                        SELF := RIGHT;));


notFound := JOIN(inputRecords, base,
                  #EXPAND(joinCondition),
                  TRANSFORM(layout,
                            SELF := LEFT;),
                  LEFT ONLY);
                  

processedTimings := PROJECT(base, TRANSFORM({UNSIGNED8 timeMS, UNSIGNED inputSeq, STRING inputAcct, UNSIGNED lexID},
                                            SELF.timeMS := LEFT.time_ms;
                                            SELF.inputSeq := LEFT.seq;
                                            SELF.inputAcct := LEFT.accountNumber;
                                            SELF.lexID := LEFT.did;));


SlimAttrsLayout := RECORD
  UNSIGNED seq;
  BOOLEAN lexIDChanged;
  DueDiligence.v3Layouts.DDOutput.PerAttributes;
  iesp.duediligencepersonreport.t_DDRPersonReportBy AND NOT [AttributeModules] perInput;
END;



slimAttrs := PROJECT(base, TRANSFORM(SlimAttrsLayout, 
                                                
                                      SELF.seq := LEFT.seq;
                                                                            
                                      SELF.perLexID := (STRING)LEFT.did;
                                      
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
                                      
                                      SELF.perInput := LEFT.inputEcho;
                                      
                                      SELF := LEFT;));                  
                    
                    


////////////////ECONOMIC//////////////// 
#IF(includeEconomic)
  h20Craft := NORMALIZE(base, LEFT.economic.watercraft.watercrafts,
                          TRANSFORM({UNSIGNED seq, UNSIGNED lexID, UNSIGNED ownerCnt, UNSIGNED waterCnt, iesp.duediligencepersonreport.t_DDRPersonWatercraft -OwnershipType, iesp.duediligencepersonreport.t_DDRInquiredOrSpouseOwnership -owners addInfo},
                                    SELF.seq := LEFT.seq;
                                    SELF.lexID := (UNSIGNED)LEFT.perLexID;
                                    SELF.waterCnt := COUNT(LEFT.economic.watercraft.watercrafts);
                                    SELF.ownerCnt := COUNT(RIGHT.OwnershipType.owners);
                                    SELF.addInfo := RIGHT.ownershipType;
                                    SELF := RIGHT;));



                   
  OUTPUT(CHOOSEN(h20Craft, eyeball), NAMED('watercraftDetails'));
  
  
  
  
  IF(returnOutputFiles, OUTPUT(h20Craft,, outputFile + 'WatercraftDetails.csv', CSV(HEADING(single), QUOTE('"'))));	
  
#END
                    

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
  
  UNSIGNED lexIDChanged := COUNT(slimAttrs(lexIDChanged)); 
  UNSIGNED noPerDataFound := COUNT(slimAttrs(perMatchLevel = '-1'));
  UNSIGNED perDataFound := COUNT(slimAttrs(perMatchLevel <> '-1'));
  UNSIGNED ddResultsWithNoAttributes := COUNT(base(NOT EXISTS(attributes)));
  
  UNSIGNED averageTiming := AVE(processedTimings, timeMS);
  UNSIGNED fastestRequest := MIN(processedTimings, timeMS);
  UNSIGNED slowestRequest := MAX(processedTimings, timeMS);
END;

                                              
summary := TABLE(DATASET([{1}], {UNSIGNED dumb}), tbleLayout);


perEconomicSummary := RECORD
  UNSIGNED currentPropCount := COUNT(base.economic.property.properties);
  UNSIGNED taxAssessedValue := base.economic.property.TaxAssessedValue;
  BOOLEAN propInquiredOwnOnly := EXISTS(base.economic.property.properties(OwnershipType.SubjectOwned AND OwnershipType.SpouseOwned = FALSE));
  BOOLEAN propSpouseOwnOnly := EXISTS(base.economic.property.properties(OwnershipType.SubjectOwned = FALSE AND OwnershipType.SpouseOwned));
  BOOLEAN propInquiredAndSpouseOwn := EXISTS(base.economic.property.properties(OwnershipType.SubjectOwned AND OwnershipType.SpouseOwned));
  
  UNSIGNED currentVehCount := COUNT(base.economic.Vehicle.MotorVehicles);
  UNSIGNED largestVehBasePrice := MAX(base.economic.Vehicle.MotorVehicles, basePrice);
  BOOLEAN vehInquiredOwnOnly := EXISTS(base.economic.Vehicle.MotorVehicles(OwnershipType.SubjectOwned AND OwnershipType.SpouseOwned = FALSE));
  BOOLEAN vehSpouseOwnOnly := EXISTS(base.economic.Vehicle.MotorVehicles(OwnershipType.SubjectOwned = FALSE AND OwnershipType.SpouseOwned));
  BOOLEAN vehInquiredAndSpouseOwn := EXISTS(base.economic.Vehicle.MotorVehicles(OwnershipType.SubjectOwned AND OwnershipType.SpouseOwned));
  
  UNSIGNED currentAircraftCount := COUNT(base.economic.aircraft.aircrafts);
  BOOLEAN airInquiredOwnOnly := EXISTS(base.economic.aircraft.aircrafts(OwnershipType.SubjectOwned AND OwnershipType.SpouseOwned = FALSE));
  BOOLEAN airSpouseOwnOnly := EXISTS(base.economic.aircraft.aircrafts(OwnershipType.SubjectOwned = FALSE AND OwnershipType.SpouseOwned));
  BOOLEAN airInquiredAndSpouseOwn := EXISTS(base.economic.aircraft.aircrafts(OwnershipType.SubjectOwned AND OwnershipType.SpouseOwned));
  
  UNSIGNED currentWatercraftCount := COUNT(base.economic.Watercraft.Watercrafts);
  UNSIGNED maxWatercraftLengthFt := MAX(base.economic.Watercraft.Watercrafts, lengthFeet);
  BOOLEAN waterInquiredOwnOnly := EXISTS(base.economic.Watercraft.Watercrafts(OwnershipType.SubjectOwned AND OwnershipType.SpouseOwned = FALSE));
  BOOLEAN waterSpouseOwnOnly := EXISTS(base.economic.Watercraft.Watercrafts(OwnershipType.SubjectOwned = FALSE AND OwnershipType.SpouseOwned));
  BOOLEAN waterInquiredAndSpouseOwn := EXISTS(base.economic.Watercraft.Watercrafts(OwnershipType.SubjectOwned AND OwnershipType.SpouseOwned));
  
  UNSIGNED estimatedIncome := base.economic.EstimatedIncome;
END;

perLegalSummary := RECORD
  UNSIGNED numberOfCivilEvents := COUNT(base.legal.PossibleLiensJudgmentsEvictions);
  UNSIGNED largestFilingAmount := MAX(base.legal.PossibleLiensJudgmentsEvictions, FilingAmount);
  UNSIGNED numberOfLegalEvents := COUNT(base.legal.PossibleLegalEvents.criminals);
END;



perAssociationSummary := RECORD
  UNSIGNED numberOfRelatives := COUNT(base.personAssociation.RelationDetails(STD.Str.ToUpperCase(PossibleRelationship) <> 'ASSOCIATE'));
  UNSIGNED numberOfAssociates := COUNT(base.personAssociation.RelationDetails(STD.Str.ToUpperCase(PossibleRelationship) = 'ASSOCIATE'));
  BOOLEAN containsAssociateOrRelativeWTrafficOffense := EXISTS(base.personAssociation.RelationDetails(TrafficRelated));
  BOOLEAN containsAssociateOrRelativeWNonTrafficOffense := EXISTS(base.personAssociation.RelationDetails(AllOtherCriminalRecords));
END;

perProfLicenseSummary := RECORD
  UNSIGNED numberOfProfLicenses := COUNT(base.professionalNetwork.ProfessionalLicenses);
  UNSIGNED numberOfActiveLicenses := COUNT(base.professionalNetwork.ProfessionalLicenses(STD.Str.ToUpperCase(Status) = 'ACTIVE'));
  BOOLEAN containsLawAccounting := EXISTS(base.professionalNetwork.professionalLicenses(LawAccounting));
  BOOLEAN containsFinanceRealEstate := EXISTS(base.professionalNetwork.professionalLicenses(FinanceRealEstate));
  BOOLEAN containsMedicalDoctor := EXISTS(base.professionalNetwork.professionalLicenses(MedicalDoctor));
  BOOLEAN containsMarineHarborPiolotExplosives := EXISTS(base.professionalNetwork.professionalLicenses(PilotMarinePilotHarborPilotExplosives));
END;

perBusinessAssociationsSummary := RECORD
  UNSIGNED numberOfBusAssociations := COUNT(base.businessAssociation.Associations);
  UNSIGNED numberOfBusAssociationsWExecs := COUNT(base.businessAssociation.Associations(EXISTS(ExecutiveOfficers)));
  UNSIGNED numberOfBusAssociationsWRegisteredAgents := COUNT(base.businessAssociation.Associations(EXISTS(RegisteredAgents)));
  UNSIGNED numberOfBusAssociationsWExecsAndRegisteredAgents := COUNT(base.businessAssociation.Associations(EXISTS(ExecutiveOfficers) AND EXISTS(RegisteredAgents)));
END;

perNetworkingSummary := RECORD
  perAssociationSummary;
  perProfLicenseSummary;
  perBusinessAssociationsSummary;
END;

perIdentityInputSSNSummary := RECORD
  UNSIGNED numberOfInputSSN_SSNDeviations := COUNT(base.identity.SSNInformation.InputSSNDetails.SSNDeviations);
  BOOLEAN inputSSN_ssnRandomized := base.identity.SSNInformation.InputSSNDetails.SSNRandomized;
  BOOLEAN inputSSN_enumerationAtEntry := base.identity.SSNInformation.InputSSNDetails.SSNEnumerationAtEntry;
  BOOLEAN inputSSN_isITIN := base.identity.SSNInformation.InputSSNDetails.SSNIsITIN;
  BOOLEAN inputSSN_invalid := base.identity.SSNInformation.InputSSNDetails.SSNInvalid;
  BOOLEAN inputSSN_issuedPriorToDOB := base.identity.SSNInformation.InputSSNDetails.SSNIssuedPriorToDOB;
  BOOLEAN inputSSN_randomlyIssuedInvalid := base.identity.SSNInformation.InputSSNDetails.SSNRandomlyIssuedInvalid;
  BOOLEAN inputSSN_reportedDecease := base.identity.SSNInformation.InputSSNDetails.SSNReportedAsDeceased;
  BOOLEAN inputSSN_noNameWLexID := EXISTS(base.identity.SSNInformation.InputSSNDetails.SSNDeviations(TRIM(name.first) = '' AND TRIM(name.middle) = '' AND TRIM(name.last) = '' AND (UNSIGNED)lexID > 0));
END;

perIdentityBestSSNSummary := RECORD
  UNSIGNED numberOfBestSSN_SSNDeviations := COUNT(base.identity.SSNInformation.BestSSNDetails.SSNDeviations);
  BOOLEAN bestSSN_ssnRandomized := base.identity.SSNInformation.BestSSNDetails.SSNRandomized;
  BOOLEAN bestSSN_enumerationAtEntry := base.identity.SSNInformation.BestSSNDetails.SSNEnumerationAtEntry;
  BOOLEAN bestSSN_isITIN := base.identity.SSNInformation.BestSSNDetails.SSNIsITIN;
  BOOLEAN bestSSN_invalid := base.identity.SSNInformation.BestSSNDetails.SSNInvalid;
  BOOLEAN bestSSN_issuedPriorToDOB := base.identity.SSNInformation.BestSSNDetails.SSNIssuedPriorToDOB;
  BOOLEAN bestSSN_randomlyIssuedInvalid := base.identity.SSNInformation.BestSSNDetails.SSNRandomlyIssuedInvalid;
  BOOLEAN bestSSN_reportedDecease := base.identity.SSNInformation.BestSSNDetails.SSNReportedAsDeceased;
  BOOLEAN bestSSN_noNameWLexID := EXISTS(base.identity.SSNInformation.BestSSNDetails.SSNDeviations(TRIM(name.first) = '' AND TRIM(name.middle) = '' AND TRIM(name.last) = '' AND (UNSIGNED)lexID > 0));   
END;

perIdentityLexIDSummary := RECORD
  STRING identityType := base.identity.LexIDInformation.IdentityType;
  UNSIGNED numberOfAKAsByLexID := COUNT(base.identity.LexIDInformation.IdentityAKAs);
  UNSIGNED numberOfReportedDOBsByLexID := COUNT(base.identity.LexIDInformation.IdentityReportedDOBs);
  UNSIGNED numberOfReportedSSNsByLexID := COUNT(base.identity.LexIDInformation.IdentityReportedSSNs);
  BOOLEAN lexIDReportedDeceased := base.identity.LexIDInformation.LexIDReportedDeceased;
  BOOLEAN lexIDBestSSNInvalid := base.identity.LexIDInformation.LexIDBestSSNInvalid;
  BOOLEAN lexIDMultipleSSNs := base.identity.LexIDInformation.LexIDMultipleSSNs;
END;


perIdentitySummary := RECORD
  UNSIGNED numberOfSourcesReporting := COUNT(base.identity.SourcesReporting(TimesReported > 0));
  INTEGER1 estimatedAge := base.identity.EstimatedAge;
  
  perIdentityInputSSNSummary;
  perIdentityBestSSNSummary;
  perIdentityLexIDSummary;  
END;

perGeoSummary := RECORD
  UNSIGNED numberOfResidences := COUNT(base.geographic.ResidenceDetails);
  UNSIGNED numberOfResidencesWCurrentTenants := COUNT(base.geographic.residencedetails(ResidentTenantRisk.NumberCurrentResidentTenant > 0));
  UNSIGNED numberOfResidencesWRelatives := COUNT(base.geographic.residencedetails(ResidentTenantRisk.NumberRelatives > 0));
  UNSIGNED numberOfResidencesWBusAssociates := COUNT(base.geographic.residencedetails(ResidentTenantRisk.NumberBusinessAssociates > 0));
  UNSIGNED numberOfResidencesWHighRiskProfServProvidersOrFieldsOfStudy := COUNT(base.geographic.residencedetails(ResidentTenantRisk.NumberHighRiskProfServiceProvidersOrFieldOfStudy > 0));
  UNSIGNED numberOfResidencesWPotentialCrimRecordsArrests := COUNT(base.geographic.residencedetails(ResidentTenantRisk.NumberPotentialCriminalRecordsArrests > 0));
  UNSIGNED numberOfResidencesWPotentialSexOffenders := COUNT(base.geographic.residencedetails(ResidentTenantRisk.NumberPotentialSexOffenders > 0));
END;


perDetailSummaryAll := RECORD
  UNSIGNED seq := base.seq;
  UNSIGNED processingTime := base.time_ms;
  UNSIGNED calcdLexID := (UNSIGNED)base.perLexID;
  STRING3 lexIDMatch := base.perLexIDMatch;
  BOOLEAN lexIDChanged := base.lexIDChanged;
  perEconomicSummary economic; 
  perLegalSummary legal;
  perNetworkingSummary networking;
  perIdentitySummary identity;
  perGeoSummary geography;
END;


perDetailSummary := TABLE(base((UNSIGNED)perLexID > 0), perDetailSummaryAll);





OUTPUT(inputData, NAMED('inputData'));      
OUTPUT(CHOOSEN(rawInput, eyeball), NAMED('rawInput'));      
OUTPUT(CHOOSEN(inputRecords, eyeball), NAMED('inputRecords')); 
OUTPUT(CHOOSEN(ddInput, eyeball), NAMED('ddInput')); 
OUTPUT(CHOOSEN(ddResults, eyeball), NAMED('ddResults')); 
OUTPUT(CHOOSEN(base, eyeball), NAMED('base')); 
OUTPUT(CHOOSEN(notFound, eyeball), NAMED('notFound')); 
OUTPUT(CHOOSEN(processedTimings, eyeball), NAMED('processedTimings')); 
OUTPUT(CHOOSEN(slimAttrs, eyeball), NAMED('slimAttrs')); 
OUTPUT(CHOOSEN(summary, eyeball), NAMED('DDResultsSummary')); 
OUTPUT(CHOOSEN(perDetailSummary, eyeball), NAMED('perDetailEconomicSummary')); 

                   
                    
IF(returnOutputFiles, OUTPUT(slimAttrs,, outputFile + 'Attrs.csv', CSV(HEADING(single), QUOTE('"'))));	
IF(returnOutputFiles, OUTPUT(processedTimings,, outputFile + 'SlimTimings.csv', CSV(HEADING(single), QUOTE('"'))));
IF(returnOutputFiles, OUTPUT(notFound,, outputFile + 'Not_Processed.csv', CSV(HEADING(single), QUOTE('"'))));
IF(returnOutputFiles, OUTPUT(summary,, outputFile + 'Results_Summary.csv', CSV(HEADING(single), QUOTE('"'))));
IF(returnOutputFiles, OUTPUT(perDetailSummary,, outputFile + 'Person_Detail_Summary.csv', CSV(HEADING(single), QUOTE('"'))));
