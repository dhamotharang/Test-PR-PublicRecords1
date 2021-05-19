IMPORT DueDiligence, Gateway, iesp, RiskWise, STD;


/* *****************************************************
 *                   Options Section                   *
 *******************************************************/
//Choose input data options
inputSelection := 2; //1 = BII only, 2 = lexID only, 3 = both BII and lexID 

//Choose file to run
fileSelection := 4;

inputInfoLayout := RECORD
  STRING fileName;
  BOOLEAN includesIdentifyingInfo; //BII
  BOOLEAN includesLexID;  //SeleID
END;

inputData := CASE(fileSelection,
                    1 => DATASET([{'~tgertken::in::business_bii_only_232k.csv', TRUE, FALSE}], inputInfoLayout),
                    2 => DATASET([{'~tgertken::in::business_bii_lexid_231949.csv', TRUE, TRUE}], inputInfoLayout),
                    3 => DATASET([{'~tgertken::out::sl_uniqueids_test.csv', FALSE, TRUE}], inputInfoLayout),
                    4 => DATASET([{'~tgertken::out::w20210428-162111_duediligence_businessrptservice_v16_biiandlexid_not_processed.csv', FALSE, TRUE}], inputInfoLayout),
                    DATASET([], inputInfoLayout))[1];
                    
//Select the product(s) to run
productsRequested := 'AttributesOnly'; // VALUES:[AttributesOnly, Modules]
potentialAttributeModules := DATASET([], {STRING attrs}); //VALUES: [ECONOMIC, LEGAL, NETWORK, OPERATING] -- only legal fully modular


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
roxieSelection := 2;  //1 = Dev154, 2 = Dev156, 3 = cert, 4 = prod, 5 = Dev155

//Choose version of query
serviceVersionRequested := '.16';  


//Choose output selections
eyeball := 100;
recordLimit := 10;    //number of records to read from input file; 0 means ALL
outputFileName := '~tgertken::out::' + STD.System.Job.wuid() + '_';
returnOutputFiles := FALSE;                   
                    

//include outputs of additional information for various sections of the report                   
includeLegal := FALSE;
includeEconomic := FALSE;
includeOperating := FALSE;
includeNetworking := FALSE;


threads := 2;

/* *****************************************************
 *                   Validate Section                  *
 *******************************************************/
invalidRequest := MAP(STD.Str.ToUpperCase(TRIM(productsRequested)) = 'MODULES' AND NOT EXISTS(potentialAttributeModules) => 'Need to select module(s) when selecting Module product',
                      inputSelection = 1 AND inputData.includesIdentifyingInfo = FALSE => 'Input file does not contain BII',
                      inputSelection = 2 AND inputData.includesLexID = FALSE => 'Input file does not contain a lexID',
                      inputSelection = 3 AND inputData.includesIdentifyingInfo = FALSE AND inputData.includesLexID = FALSE => 'Input file does not contain BII and lexID',
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

includePII := inputSelection IN [1, 3];
includeLexID := inputSelection IN [2, 3];

roxieIP := CASE(roxieSelection,
                1 => RiskWise.Shortcuts.dev154,
                2 => RiskWise.Shortcuts.dev156,
                3 => RiskWise.Shortcuts.staging_neutral_roxieIP,
                4 => RiskWise.Shortcuts.prod_batch_analytics_roxie,
                5 => RiskWise.Shortcuts.dev155,
                RiskWise.Shortcuts.dev156);
 
serviceName:= 'DueDiligence.DueDiligence_BusinessRptService' + serviceVersionRequested; 


mapInputTypeText := MAP(inputSelection = 1 => 'BIIOnly',
                        inputSelection = 2 => 'LexIDOnly',
                        inputSelection = 3 => 'BIIAndLexID',
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
                      5 => 'DEV 155',
                      ''); 
 
outputFile := TRIM(outputFileName + 'DueDiligence_BusinessRptService_v' + serviceVersionRequested[2..] + '_' + TRIM(mapInputTypeText) + '_');

addVersionText := IF(serviceVersionRequested <> DueDiligence.Constants.EMPTY, 'v' + serviceVersionRequested[2..], DueDiligence.Constants.EMPTY);
#WORKUNIT('name', TRIM(mapRoxieText + ' - ' + recordLimit + ' records - DueDiligenceBusinessRptService ' + addVersionText) + ' - ' + mapModeText + ' - ' + mapInputTypeText);

reqAttribute := DueDiligence.Constants.BUS_REQ_ATTRIBUTE_V3;





Layout:= RECORD
  INTEGER seq; 
  #IF(fileSelection = 3)
      STRING ultid;
      STRING orgid;
      STRING lexID;
  #END
  STRING accountNumber;
  #IF(fileSelection <> 3)
    STRING lexID;
  #END
  STRING inputCompanyName;
  STRING inputAltCompanyName;
  STRING50 addr;
  STRING30 city;
  STRING2 state;
  STRING zip;
  STRING10 phone1;    //business phone
  STRING9 taxID;      //fein
  STRING historydate;
END;


rawInput := IF(recordLimit = 0, 
               DATASET(inputData.fileName, Layout, CSV(HEADING(single), QUOTE('"'))),
               CHOOSEN(DATASET(inputData.fileName, Layout, CSV(HEADING(single), QUOTE('"'))), recordLimit));


//filter data so we don't have duplicates based on run
lexIDOnlyFilter := DEDUP(SORT(rawInput((UNSIGNED)lexID > 0), (UNSIGNED)lexID), (UNSIGNED)lexID);
identOnlyFilter := DEDUP(SORT(rawInput, inputCompanyName, inputAltCompanyName, -taxID, addr, city, state, zip, -phone1), inputCompanyName, inputAltCompanyName, taxID, addr, city, state, zip);
lexIDAndIdentFilter := DEDUP(rawInput, ALL);

inputRecords := CASE(inputSelection,
                      1 => identOnlyFilter,
                      2 => lexIDOnlyFilter,
                      lexIDAndIdentFilter);




DD_inLayout := record
	DATASET(iesp.duediligencebusinessreport.t_DueDiligenceBusinessReportRequest) DueDiligenceBusinessReportRequest;
	BOOLEAN debugMode := debugOn;
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
                                            rb := DATASET([TRANSFORM(iesp.duediligencebusinessreport.t_DDRBusinessReportBy,		
	
	
                                                          taxIDZeroPad := appendZeroAtBeginning(LEFT.TaxID, 9);
                              
                                                          address := DATASET([TRANSFORM(iesp.share.t_Address,
                                                                                        SELF.StreetAddress1 := LEFT.Addr;
                                                                                        SELF.City := LEFT.City;
                                                                                        SELF.State := LEFT.State;
                                                                                        SELF.Zip5 := appendZeroAtBeginning(LEFT.Zip[1..5], 5);
                                                                                        SELF.Zip4 := appendZeroAtBeginning(LEFT.Zip[6..9], 4);
                                                                                        SELF := [];)])[1];
                                                                                        
                                                         
                                                          SELF.Business := DATASET([TRANSFORM(iesp.duediligenceshared.t_DDRAttributesBusiness,
                                                                                                 SELF.CompanyName := IF(includePII, LEFT.inputCompanyName, '');
                                                                                                 SELF.FEIN := IF(includePII, taxIDZeroPad, '');
                                                                                                 SELF.LexID := IF(includeLexID, LEFT.LexID, '');
                                                                                                 SELF.Phone := IF(includePII, LEFT.phone1, '');
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
                                                                      
                                                                      month := (UNSIGNED)LEFT.historyDate[1..(firstDateSlash - 1)];
                                                                      day := (UNSIGNED)LEFT.historyDate[(firstDateSlash + 1)..(secondDateSlash - 1)];
                                                                      
                                                                      tempInputDateMonth := INTFORMAT(month, 2, 1);
                                                                      tempInputDateDay := INTFORMAT(day, 2, 1);
                                                                      tempInputDateYear := LEFT.historyDate[(secondDateSlash + 1)..];
                                                                      
                                                                      tempInputFileDate := DATASET([TRANSFORM(iesp.share.t_Date,
                                                                                                              SELF.Year := (INTEGER)tempInputDateYear;
                                                                                                              SELF.Month := (INTEGER)tempInputDateMonth;
                                                                                                              SELF.Day := (INTEGER)tempInputDateDay;)])[1];
                                                                      
                                                                      SELF.HistoryDate := IF(mapModeDate = '', tempInputFileDate, tempDate);
                                                                      SELF := [];)]);
                                                                      
                                            u := DATASET([TRANSFORM(iesp.share.t_User, 
                                                                      SELF.AccountNumber := LEFT.AccountNumber; 
                                                                      SELF.DataRestrictionMask := dataRestrictionMask;
                                                                      SELF.DataPermissionMask := '';
                                                                      SELF.GLBPurpose := (STRING)glba;
                                                                      SELF.DLPurpose := (STRING)dppa;
                                                                      SELF := [])]);
                                                                    
                                            req := DATASET([TRANSFORM(iesp.duediligencebusinessreport.t_DueDiligenceBusinessReportRequest,
                                                                        SELF.ReportBy := rb[1];
                                                                        SELF.Options := o[1];
                                                                        SELF.User := u[1];
                                                                        SELF := [];)]);
                                                                        
                                                                        
                                                                        
                                            SELF.DueDiligenceBusinessReportRequest := req[1];));


ddInputDist := DISTRIBUTE(ddInput, RANDOM());                 
                    
                    





/* *****************************************************
 *                Processing Section                   *
 *******************************************************/ 

soapResponselayout := RECORD
	UNSIGNED8 time_ms {xpath('_call_latency_ms')};  // picks up timing
  STRING errorCode;
  iesp.duediligencebusinessreport.t_DueDiligenceBusinessReportResponse results {XPATH('Results/Result/Dataset[@name=\'Results\']/Row')};
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
	
noErrors := DDResults(errorCode = '');

SlimBusinessReportLayout := RECORD
  UNSIGNED8 time_ms;
  UNSIGNED seq;
  STRING ultID;
  STRING orgID;
  STRING seleID;
  STRING accountNumber;
  BOOLEAN lexIDChanged;
  iesp.duediligencebusinessreport.t_DDRBusinessReportBy InputEcho;
  iesp.duediligencebusinessreport.t_DDRBusinessInformation BusinessInfo;
  DueDiligence.v3Layouts.DDOutput.BusAttributes;
  DATASET(iesp.share.t_NameValuePair) Attributes;
  DATASET(iesp.share.t_NameValuePair) AttributeHitFlags;
  iesp.duediligencebusinessreport.t_DDRBusinessLegalAttributeDetails legal;
  iesp.duediligencebusinessreport.t_DDRBusinessEconomicAttributeDetails economic;
  iesp.duediligencebusinessreport.t_DDRBusinessOperatingAttributeDetails operating;
  iesp.duediligencebusinessreport.t_DDRBusinessNetworkDetails network;
END;   

    
slimReportRaw := PROJECT(noErrors, TRANSFORM(SlimBusinessReportLayout, 
                                              SELF.time_ms := LEFT.time_ms;
                                              SELF.busLexID := LEFT.results.result.BusinessId;
                                              SELF.lexIDChanged := LEFT.results.result.lexIDChanged;
                                              SELF.busLexIDMatch := (STRING)LEFT.results.result.businessLexIDMatch;
                                              SELF.attributes := LEFT.results.result.AttributeGroup.Attributes;
                                              SELF.attributeHitFlags := LEFT.results.result.AttributeGroup.AttributeLevelHits;
                                              SELF.inputEcho := LEFT.results.result.InputEcho;
                                              SELF.businessInfo := LEFT.results.result.BusinessReport.BusinessInformation;
                                              SELF.legal := LEFT.results.result.businessReport.BusinessAttributeDetails.Legal;
                                              SELF.economic := LEFT.results.result.businessReport.BusinessAttributeDetails.Economic;
                                              SELF.operating := LEFT.results.result.businessReport.BusinessAttributeDetails.Operating;
                                              SELF.network := LEFT.results.result.businessReport.BusinessAttributeDetails.NetworkDetails;
                                              SELF := [];));


 
biiExpand := //'TRIM(LEFT.Phone1) = TRIM(RIGHT.inputEcho.business.phone) AND ' +
              'TRIM(LEFT.Addr[..50]) = TRIM(RIGHT.inputEcho.business.address.streetAddress1) AND ' +
              'TRIM(LEFT.City[..25]) = TRIM(RIGHT.inputEcho.business.address.city) AND ' +
              'TRIM(LEFT.State) = TRIM(RIGHT.inputEcho.business.address.state) AND ' +
              'TRIM(formatZip5(LEFT.zip[..5])) = TRIM(RIGHT.inputEcho.business.address.zip5 + RIGHT.inputEcho.business.address.zip4) AND ' +
              'TRIM(formatTaxID(LEFT.taxID)) = TRIM(RIGHT.inputEcho.business.fein) AND ' +
              'TRIM(LEFT.inputCompanyName) = TRIM(RIGHT.inputEcho.business.companyName)';

lexIDExpand := 'TRIM(LEFT.lexID) = TRIM(RIGHT.inputEcho.business.lexID)';

joinCondition := CASE(inputSelection,
                        1 => biiExpand,
                        2 => lexIDExpand,
                        3 => biiExpand + ' AND ' + lexIDExpand,
                        '');
				  


base := JOIN(inputRecords, slimReportRaw,
              #EXPAND(joinCondition),
              TRANSFORM(SlimBusinessReportLayout,
                        SELF.seq := LEFT.seq;
                        SELF.accountNumber := LEFT.accountNumber;
                        #IF(fileSelection = 3)
                          SELF.ultID := LEFT.ultID;
                          SELF.orgID := LEFT.orgID;
                          SELF.seleID := LEFT.lexID;
                        #END
                        SELF := RIGHT;));


notFound := JOIN(inputRecords, base,
                  #EXPAND(joinCondition),
                  TRANSFORM(layout,
                            SELF := LEFT;),
                  LEFT ONLY);
                  

processedTimings := PROJECT(base, TRANSFORM({UNSIGNED8 timeMS, UNSIGNED inputSeq, STRING inputAcct, STRING inputLexID},
                                            SELF.timeMS := LEFT.time_ms;
                                            SELF.inputSeq := LEFT.seq;
                                            SELF.inputAcct := LEFT.accountNumber;
                                            SELF.inputLexID := LEFT.seleID;));




////////////////ATTRIBUTES////////////////                           
flatAttrs := PROJECT(base, TRANSFORM(SlimBusinessReportLayout, 
                                                
                                      attributes := LEFT.attributes;
                                      attributeHits := LEFT.attributeHitFlags;

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
                                      SELF.BusCivilLegalEventFilingAmt_Flag := attributes(TRIM(name) = 'BusCivilLegalEventFilingAmt_Flag')[1].value;
                                      SELF.BusOffenseType_Flag := attributeHits(TRIM(name) = 'BusOffenseType_Flag')[1].value; 
                                      SELF.BusBEOProfLicense_Flag := attributeHits(TRIM(name) = 'BusBEOProfLicense_Flag')[1].value; 
                                      SELF.BusBEOUSResidency_Flag := attributeHits(TRIM(name) = 'BusBEOUSResidency_Flag')[1].value; 
                                      SELF.BusBEOAccessToFundsProperty_Flag := attributeHits(TRIM(name) = 'BusBEOAccessToFundsProperty_Flag')[1].value; 
                                      SELF.BusLinkedBusinesses_Flag := attributeHits(TRIM(name) = 'BusLinkedBusinesses_Flag')[1].value;
                                      
                                      SELF := LEFT;));                         
                        
                    
attributesOnly := PROJECT(flatAttrs, TRANSFORM({UNSIGNED seq, STRING ultID, STRING orgID, STRING seleID, BOOLEAN lexIDChanged, DueDiligence.v3Layouts.DDOutput.BusAttributes},  
                                                SELF := LEFT;));                     
                    
                    
////////////////ECONOMIC//////////////// 
#IF(includeEconomic)
  properties := NORMALIZE(base, LEFT.economic.property.properties,
                          TRANSFORM({UNSIGNED seq, STRING ultID, STRING orgID, STRING seleID, STRING lexID, UNSIGNED currPropCnt, UNSIGNED taxedAssessedValue, iesp.duediligencebusinessreport.t_DDRBusinessProperty prop},
                                    SELF.seq := LEFT.seq;
                                    SELF.ultID := LEFT.ultID;
                                    SELF.orgID := LEFT.orgID;
                                    SELF.seleID := LEFT.seleID;
                                    SELF.lexID := LEFT.busLexID;
                                    SELF.currPropCnt := LEFT.economic.property.PropertyCurrentCount;
                                    SELF.taxedAssessedValue := LEFT.economic.property.TaxAssessedValue;
                                    SELF.prop := RIGHT;));


  vehicles := NORMALIZE(base, LEFT.economic.MotorVehicle.MotorVehicles,
                        TRANSFORM({UNSIGNED seq, STRING ultID, STRING orgID, STRING seleID, STRING lexID, UNSIGNED vehCnt, iesp.duediligenceshared.t_DDRMotorVehicle vehicle},
                                  SELF.seq := LEFT.seq;
                                  SELF.ultID := LEFT.ultID;
                                  SELF.orgID := LEFT.orgID;
                                  SELF.seleID := LEFT.seleID;
                                  SELF.lexID := LEFT.busLexID;
                                  SELF.vehCnt := LEFT.economic.motorVehicle.MotorVehicleCount;
                                  SELF.vehicle := RIGHT;));
                                  
                                  
  aircraft := NORMALIZE(base, LEFT.economic.Aircraft.Aircrafts,
                        TRANSFORM({UNSIGNED seq, UNSIGNED airCnt, iesp.duediligenceshared.t_DDRAircraft air},
                                  SELF.seq := LEFT.seq;
                                  SELF.airCnt := LEFT.economic.aircraft.AircraftCount;
                                  SELF.air := RIGHT;));
                                                                  
                                  
  h2oCraft := NORMALIZE(base, LEFT.economic.Watercraft.Watercrafts,
                        TRANSFORM({UNSIGNED seq, UNSIGNED waterCnt, iesp.duediligenceshared.t_DDRWatercraft water},
                                  SELF.seq := LEFT.seq;
                                  SELF.waterCnt := LEFT.economic.Watercraft.WatercraftCount;
                                  SELF.water := RIGHT;));



  OUTPUT(CHOOSEN(properties, eyeball), NAMED('properties'));
  OUTPUT(CHOOSEN(vehicles, eyeball), NAMED('vehicles'));
  OUTPUT(CHOOSEN(aircraft, eyeball), NAMED('aircraft'));
  OUTPUT(CHOOSEN(h2oCraft, eyeball), NAMED('h2oCraft'));

#END


////////////////OPERATING//////////////// 
#IF(includeOperating)
  busLocations := NORMALIZE(base, LEFT.operating.BusinessLocations.OperatingLocations,
                            TRANSFORM({UNSIGNED seq, UNSIGNED locCnt, iesp.duediligencebusinessreport.t_DDRBusinessAddressRisk locations},
                                      SELF.seq := LEFT.seq;
                                      SELF.locCnt := LEFT.operating.businesslocations.OperatingLocationCount;
                                      SELF.locations := RIGHT;));


  busSlimInfo := PROJECT(base, TRANSFORM({UNSIGNED seq, iesp.duediligencebusinessreport.t_DDRBusinessOperatingInformation AND NOT [ReportingSources, SOSFilingStatuses, SICNAICs, BusinessNameVariations, SSNAssociatedWithFEIN, SSNAssociatedWith] info},
                                      SELF.seq := LEFT.seq;
                                      SELF.info := LEFT.operating.BusinessInformation;));


  reportingSources := NORMALIZE(base, LEFT.operating.businessInformation.ReportingSources,
                                TRANSFORM({UNSIGNED seq, UNSIGNED sourceCnt, iesp.duediligencebusinessreport.t_DDRReportingSources rptSource},
                                          SELF.seq := LEFT.seq;
                                          SELF.sourceCnt := LEFT.operating.businessInformation.NumberOfSourcesReporting;
                                          SELF.rptSource := RIGHT;));


  reportFilings := NORMALIZE(base, LEFT.operating.businessInformation.SOSFilingStatuses,
                                TRANSFORM({UNSIGNED seq, UNSIGNED activeFilingCnt, UNSIGNED otherFilingCnt, UNSIGNED totalFilings, iesp.duediligencebusinessreport.t_DDRSOSFiling AND NOT [SOSActions] filings},
                                          SELF.seq := LEFT.seq;
                                          SELF.activeFilingCnt := LEFT.operating.businessInformation.SOSActiveCount;
                                          SELF.otherFilingCnt := LEFT.operating.businessInformation.SOSOtherCount;
                                          SELF.totalFilings := COUNT(LEFT.operating.businessInformation.SOSFilingStatuses);
                                          SELF.filings := RIGHT;));


  naicSICs := NORMALIZE(base, LEFT.operating.businessInformation.SICNAICs,
                                TRANSFORM({UNSIGNED seq, STRING bestSIC, STRING bestNAICS, UNSIGNED codeCount, iesp.duediligencebusinessreport.t_DDRSICNAIC codes},
                                          SELF.seq := LEFT.seq;
                                          SELF.bestSIC := LEFT.businessInfo.SicCode;
                                          SELF.bestNAICS := LEFT.businessInfo.NaicsCode;
                                          SELF.codeCount := COUNT(LEFT.operating.businessInformation.SICNAICs);
                                          SELF.codes := RIGHT;));


  nameVariation := NORMALIZE(base, LEFT.operating.businessInformation.BusinessNameVariations,
                                TRANSFORM({UNSIGNED seq, UNSIGNED nameCnt, iesp.duediligencebusinessreport.t_DDRComponentsOfBusiness names},
                                          SELF.seq := LEFT.seq;
                                          SELF.nameCnt := COUNT(LEFT.operating.businessInformation.BusinessNameVariations);
                                          SELF.names := RIGHT;));


  ssnAssocFEIN := NORMALIZE(base, LEFT.operating.businessInformation.SSNAssociatedWithFEIN,
                                TRANSFORM({UNSIGNED seq, UNSIGNED assocCnt, iesp.duediligenceshared.t_DDRPersonNameWithLexID assocFEIN},
                                          SELF.seq := LEFT.seq;
                                          SELF.assocCnt := COUNT(LEFT.operating.businessInformation.SSNAssociatedWithFEIN);
                                          SELF.assocFEIN := RIGHT;));


  shellShelf := PROJECT(base, TRANSFORM({UNSIGNED seq, iesp.duediligencebusinessreport.t_DDRBusinessShellShelfCharacteristics AND NOT [RegisteredAgents] busShellShelf},
                                        SELF.seq := LEFT.seq;
                                        SELF.busShellShelf := LEFT.operating.ShellShelfCharacteristics;));


  registeredAgents := NORMALIZE(base, LEFT.operating.ShellShelfCharacteristics.RegisteredAgents,
                                TRANSFORM({UNSIGNED seq, UNSIGNED nameCnt, iesp.share.t_Name name},
                                          SELF.seq := LEFT.seq;
                                          SELF.nameCnt := COUNT(LEFT.operating.ShellShelfCharacteristics.RegisteredAgents);
                                          SELF.name := RIGHT;));


  OUTPUT(CHOOSEN(busLocations, eyeball), NAMED('busLocations'));
  OUTPUT(CHOOSEN(busSlimInfo, eyeball), NAMED('busSlimInfo'));
  OUTPUT(CHOOSEN(reportingSources, eyeball), NAMED('reportingSources'));
  OUTPUT(CHOOSEN(reportFilings, eyeball), NAMED('reportFilings'));
  OUTPUT(CHOOSEN(naicSICs, eyeball), NAMED('naicSICs'));
  OUTPUT(CHOOSEN(nameVariation, eyeball), NAMED('nameVariation'));
  OUTPUT(CHOOSEN(ssnAssocFEIN, eyeball), NAMED('ssnAssocFEIN'));
  OUTPUT(CHOOSEN(shellShelf, eyeball), NAMED('shellShelf'));
  OUTPUT(CHOOSEN(registeredAgents, eyeball), NAMED('registeredAgents'));
  
#END



////////////////NETWORKING//////////////// 
#IF(includeNetworking)
  tempExecIDs := NORMALIZE(base, SORT(LEFT.network.BusinessExecutives, lexID, name.last, name.first, name.middle, dob.year, dob.month, dob.day),
                           TRANSFORM({UNSIGNED seq, UNSIGNED execID, RECORDOF(RIGHT)},
                                      SELF.seq := LEFT.seq;
                                      SELF.execID := COUNTER;
                                      SELF := RIGHT;));

  slimExec := PROJECT(tempExecIDs, TRANSFORM({UNSIGNED seq, UNSIGNED execID, iesp.duediligencebusinessreport.t_DDRBusinessExecutives AND NOT [Titles, ProfessionalLicenses, AssociatedWithOtherIndividuals, AssociatedWithOtherBusinesses] exec},
                                              SELF.seq := LEFT.seq;
                                              SELF.execID := LEFT.execID;
                                              SELF.exec := LEFT;));


  execTitles := NORMALIZE(tempExecIDs, LEFT.titles,
                          TRANSFORM({UNSIGNED seq, UNSIGNED execID, iesp.share.t_Name name, UNSIGNED titleCnt, iesp.duediligenceshared.t_DDRPositionTitles title},
                                    SELF.seq := LEFT.seq;
                                    SELF.execID := LEFT.execID;
                                    SELF.name := LEFT.name;
                                    SELF.titleCnt := COUNT(LEFT.titles);
                                    SELF.title := RIGHT;));


  profLic := NORMALIZE(tempExecIDs, LEFT.ProfessionalLicenses,
                          TRANSFORM({UNSIGNED seq, UNSIGNED execID, iesp.share.t_Name name, UNSIGNED licCnt, iesp.duediligenceshared.t_DDRProfessionalLicenses lic},
                                    SELF.seq := LEFT.seq;
                                    SELF.execID := LEFT.execID;
                                    SELF.name := LEFT.name;
                                    SELF.licCnt := COUNT(LEFT.ProfessionalLicenses);
                                    SELF.lic := RIGHT;));


  execAssocOtherInd := NORMALIZE(tempExecIDs, LEFT.AssociatedWithOtherIndividuals,
                                TRANSFORM({UNSIGNED seq, UNSIGNED execID, iesp.share.t_Name name, UNSIGNED indCnt, iesp.duediligenceshared.t_DDRPersonNameWithLexID per},
                                          SELF.seq := LEFT.seq;
                                          SELF.execID := LEFT.execID;
                                          SELF.name := LEFT.name;
                                          SELF.indCnt := COUNT(LEFT.AssociatedWithOtherIndividuals);
                                          SELF.per := RIGHT;));


  execAssocOtherBus := NORMALIZE(tempExecIDs, LEFT.AssociatedWithOtherBusinesses,
                                TRANSFORM({UNSIGNED seq, UNSIGNED execID, iesp.share.t_Name name, UNSIGNED busCnt, iesp.duediligencebusinessreport.t_DDRBusinessNameWithLexID bus},
                                          SELF.seq := LEFT.seq;
                                          SELF.execID := LEFT.execID;
                                          SELF.name := LEFT.name;
                                          SELF.busCnt := COUNT(LEFT.AssociatedWithOtherBusinesses);
                                          SELF.bus := RIGHT;));



  
  OUTPUT(CHOOSEN(tempExecIDs, eyeball), NAMED('tempExecIDs'));
  OUTPUT(CHOOSEN(slimExec, eyeball), NAMED('slimExec'));
  OUTPUT(CHOOSEN(execTitles, eyeball), NAMED('execTitles'));
  OUTPUT(CHOOSEN(profLic, eyeball), NAMED('profLic'));
  OUTPUT(CHOOSEN(execAssocOtherInd, eyeball), NAMED('execAssocOtherInd'));
  OUTPUT(CHOOSEN(execAssocOtherBus, eyeball), NAMED('execAssocOtherBus'));
  
#END





////////////////LEGAL////////////////
#IF(includeLegal)                         
  civil := NORMALIZE(base, LEFT.legal.PossibleLiensJudgmentsEvictions,
                     TRANSFORM({UNSIGNED seq, iesp.duediligenceshared.t_DDRLiensJudgmentsEvictions -debtors -creditors, UNSIGNED debtorCount, UNSIGNED creditorCount},
                                SELF.seq := LEFT.seq;
                                SELF.debtorCount := COUNT(RIGHT.debtors);
                                SELF.creditorCount := COUNT(RIGHT.creditors);
                                SELF := RIGHT;));
                          
                         
  topLevelCrim := NORMALIZE(base, LEFT.legal.PossibleLegalEvents,
                             TRANSFORM({UNSIGNED seq, UNSIGNED crimCount, UNSIGNED sourceCnt, iesp.duediligencebusinessreport.t_DDRBusinessExecutiveCriminalEvents},
                                        SELF.seq := LEFT.seq;
                                        SELF.crimCount := COUNT(RIGHT.criminals);
                                        SELF.sourceCnt := 0;
                                        SELF := RIGHT;));
   
   
  sourceDetails := RECORD
     STRING det_offensecharge;
     STRING7 det_offenseconviction;
     STRING det_offensechargelevelreported;
     STRING det_source;
     STRING det_courtdisposition1;
     STRING det_courtdisposition2;
     iesp.share.t_date det_offensereporteddate;
     iesp.share.t_date det_offensearrestdate;
     iesp.share.t_date det_offensecourtdispdate;
     iesp.share.t_date det_offenseappealdate;
     iesp.share.t_date det_offensesentencedate;
     iesp.share.t_date det_offensesentencestartdate;
     iesp.share.t_date det_docconvictionoverridedate;
     iesp.share.t_date det_docscheduledreleasedate;
     iesp.share.t_date det_docactualreleasedate;
     STRING det_docinmatestatus;
     STRING det_docparolestatus;
     STRING det_offensemaxterm;
     iesp.share.t_date det_docparoleactualreleasedate;
     iesp.share.t_date det_docparolepresumptivereleasedate;
     iesp.share.t_date det_docparolescheduledreleasedate;
     STRING det_doccurrentlocationsecurity;
     STRING det_docparolecurrentstatus;
     STRING det_doccurrentknowninmatestatus;
     BOOLEAN det_currentincarcerationflag;
     BOOLEAN det_currentparoleflag;
     BOOLEAN det_currentprobationflag;
  END; 
   
  crimDetailLayout := RECORD
    STRING50 State;
    STRING25 Source;
    STRING CaseNumber;
    STRING OffenseStatute;
    iesp.share.t_Date OffenseDDFirstReported;
    iesp.share.t_Date OffenseDDLastReportedActivity;
    iesp.share.t_Date OffenseDDMostRecentCourtDispDate;
    INTEGER2 OffenseID;
    INTEGER2 OffensePriorityOrder;
    INTEGER1 OffenseLevel;
    STRING OffenseDDLegalEventTypeMapped;
    STRING OffenseCharge;
    STRING OffenseDDChargeLevelCalculated;
    STRING OffenseChargeLevelReported;
    STRING7 OffenseConviction;
    STRING35 OffenseIncarcerationProbationParole;
    STRING7 OffenseTrafficRelated;
    STRING30 County;
    STRING40 CountyCourt;
    STRING40 City;
    STRING50 Agency;
    STRING30 Race;
    STRING7 Sex;
    STRING15 HairColor;
    STRING15 EyeColor;
    STRING3 Height;
    STRING3 Weight;
    DATASET(iesp.duediligenceshared.t_DDRLegalSourceInfo) Sources;
    sourceDetails;
  END;                                      

  finalCrimLayout := RECORD     
    UNSIGNED seq;
    UNSIGNED crimCount;
    UNSIGNED sourceCnt;
    iesp.duediligenceshared.t_DDRLegalEventIndividual executiveofficer;
    // iesp.duediligencebusinessreport.t_DDRBusinessExecutiveCriminalEvents -criminals;
    iesp.duediligenceshared.t_DDRLegalStateCriminal -sources;
    iesp.duediligenceshared.t_DDRLegalSourceInfo -partyNames det;     
  END;     
                                        
  detailCrim := NORMALIZE(topLevelCrim, LEFT.criminals,
                          TRANSFORM({RECORDOF(LEFT)-criminals, crimDetailLayout},
                                    SELF.seq := LEFT.seq;
                                    SELF.sourceCnt := COUNT(RIGHT.sources);
                                    SELF := RIGHT;
                                    SELF := LEFT;
                                    SELF := [];));
                                    
  sourceDetailsCrim := NORMALIZE(detailCrim, LEFT.sources,
                                 TRANSFORM({RECORDOF(LEFT)-sources},
                                            SELF.seq := LEFT.seq;
                                            SELF.det_offensecharge := RIGHT.offensecharge;
                                            SELF.det_offenseconviction := RIGHT.offenseconviction;
                                            SELF.det_offensechargelevelreported := RIGHT.offensechargelevelreported;
                                            SELF.det_source := RIGHT.source;
                                            SELF.det_courtdisposition1 := RIGHT.courtdisposition1;
                                            SELF.det_courtdisposition2 := RIGHT.courtdisposition2;
                                            SELF.det_offensereporteddate := RIGHT.offensereporteddate;
                                            SELF.det_offensearrestdate := RIGHT.offensearrestdate;
                                            SELF.det_offensecourtdispdate := RIGHT.offensecourtdispdate;
                                            SELF.det_offenseappealdate := RIGHT.offenseappealdate;
                                            SELF.det_offensesentencedate := RIGHT.offensesentencedate;
                                            SELF.det_offensesentencestartdate := RIGHT.offensesentencestartdate;
                                            SELF.det_docconvictionoverridedate := RIGHT.docconvictionoverridedate;
                                            SELF.det_docscheduledreleasedate := RIGHT.docscheduledreleasedate;
                                            SELF.det_docactualreleasedate := RIGHT.docactualreleasedate;
                                            SELF.det_docinmatestatus := RIGHT.docinmatestatus;
                                            SELF.det_docparolestatus := RIGHT.docparolestatus;
                                            SELF.det_offensemaxterm := RIGHT.offensemaxterm;
                                            SELF.det_docparoleactualreleasedate := RIGHT.docparoleactualreleasedate;
                                            SELF.det_docparolepresumptivereleasedate := RIGHT.docparolepresumptivereleasedate;
                                            SELF.det_docparolescheduledreleasedate := RIGHT.docparolescheduledreleasedate;
                                            SELF.det_doccurrentlocationsecurity := RIGHT.doccurrentlocationsecurity;
                                            SELF.det_docparolecurrentstatus := RIGHT.docparolecurrentstatus;
                                            SELF.det_doccurrentknowninmatestatus := RIGHT.doccurrentknowninmatestatus;
                                            SELF.det_currentincarcerationflag := RIGHT.currentincarcerationflag;
                                            SELF.det_currentparoleflag := RIGHT.currentparoleflag;
                                            SELF.det_currentprobationflag := RIGHT.currentprobationflag;
                                            SELF := LEFT;));
                        


  
  OUTPUT(CHOOSEN(civil, eyeball), NAMED('civil'));
  OUTPUT(CHOOSEN(topLevelCrim, eyeball), NAMED('topLevelCrim'));
  OUTPUT(CHOOSEN(detailCrim, eyeball), NAMED('detailCrim'));
  OUTPUT(CHOOSEN(sourceDetailsCrim, eyeball), NAMED('sourceDetailsCrim'));

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
  UNSIGNED rowsInFinalOutputFile := COUNT(attributesOnly);
  UNSIGNED lexIDChanged := COUNT(attributesOnly(lexIDChanged));
  UNSIGNED noBusDataFound := COUNT(attributesOnly(busMatchLevel = '-1'));
  UNSIGNED busDataFound := COUNT(attributesOnly(busMatchLevel <> '-1'));
  UNSIGNED ddResultsWithNoAttributes := COUNT(base(NOT EXISTS(attributes)));
  
  UNSIGNED averageTiming := AVE(processedTimings, timeMS);
  UNSIGNED fastestRequest := MIN(processedTimings, timeMS);
  UNSIGNED slowestRequest := MAX(processedTimings, timeMS);
END;

                        
                        
summary := TABLE(DATASET([{1}], {UNSIGNED dumb}), tbleLayout);



busEconomicSummary := RECORD
  UNSIGNED currentPropCount := COUNT(base.economic.property.properties);
  UNSIGNED taxAssessedValue := base.economic.property.TaxAssessedValue;
  UNSIGNED currentVehCount := COUNT(base.economic.MotorVehicle.MotorVehicles);
  UNSIGNED largestVehBasePrice := MAX(base.economic.MotorVehicle.MotorVehicles, basePrice);
  UNSIGNED currentAircraftCount := COUNT(base.economic.aircraft.aircrafts);
  UNSIGNED currentWatercraftCount := COUNT(base.economic.Watercraft.Watercrafts);
  UNSIGNED maxWatercraftLengthFt := MAX(base.economic.Watercraft.Watercrafts, lengthFeet);
END;

SICNAICSummaryInfo := RECORD
  UNSIGNED numberOfSICNAICCodes := COUNT(base.operating.businessInformation.SICNAICs);
  STRING bestSIC := base.businessInfo.SicCode;
  STRING bestNAIC := base.businessInfo.NaicsCode;
  BOOLEAN containsCIBRetail := EXISTS(base.operating.businessInformation.SICNAICs(CashIntensiveRetail));
  BOOLEAN containsCIBnonRetail := EXISTS(base.operating.businessInformation.SICNAICs(CashIntensiveNonRetail));
  BOOLEAN containsMSB := EXISTS(base.operating.businessInformation.SICNAICs(MoneyServiceBusiness));
  BOOLEAN containsNonFinBankInst := EXISTS(base.operating.businessInformation.SICNAICs(NonBankFinancialInstitution));
  BOOLEAN containsCasinoGambling := EXISTS(base.operating.businessInformation.SICNAICs(CasinoOrGamblingRelated));
  BOOLEAN containsLegalAccountingTelemarkFlightTravel := EXISTS(base.operating.businessInformation.SICNAICs(LegalAccountantTelemarketerFlightOrTravel));
  BOOLEAN containsAuto := EXISTS(base.operating.businessInformation.SICNAICs(Automotive));
END;

busOperatingSummary := RECORD
  UNSIGNED operatingLocationCount := COUNT(base.operating.BusinessLocations.OperatingLocations);
  SICNAICSummaryInfo;
  UNSIGNED numberReportingSources := COUNT(base.operating.businessInformation.ReportingSources);
  BOOLEAN reportingSourceNameAndTypeEmpty := EXISTS(base.operating.businessInformation.ReportingSources) AND EXISTS(base.operating.businessInformation.ReportingSources(SourceName = '' AND SourceType = ''));
  UNSIGNED numberSOSFilings := COUNT(base.operating.businessInformation.SOSFilingStatuses);
  UNSIGNED numberSOSFilingsActive := COUNT(base.operating.businessInformation.SOSFilingStatuses(STD.Str.ToUpperCase(SOSFilingStatus) = 'ACTIVE'));
  UNSIGNED numberBusinessNameVariations := COUNT(base.operating.businessInformation.BusinessNameVariations);
  UNSIGNED numberOfRegisteredAgents_ShellShelf := COUNT(base.operating.ShellShelfCharacteristics.RegisteredAgents);
END;

busExecSummary := RECORD
  UNSIGNED numberOfExecs := COUNT(base.network.BusinessExecutives);
  BOOLEAN anyExecDeceased := EXISTS(base.network.BusinessExecutives(Deceased));
  BOOLEAN more2IndivAssocWSSN := EXISTS(base.network.BusinessExecutives(MoreThanTwoIndvsAssociatedWithSSN));
  UNSIGNED numberOfExecsWTitles := COUNT(base.network.BusinessExecutives(EXISTS(Titles)));
  BOOLEAN execAssocWOtherCompany := EXISTS(base.network.BusinessExecutives(AssociatedWithOtherCompanies));
  UNSIGNED numberOfExecsWProfLicense := COUNT(base.network.BusinessExecutives(EXISTS(ProfessionalLicenses)));
END;

busNetworkingSummary := RECORD
  busExecSummary;
  UNSIGNED numberOfRegisteredAgents_Networking := COUNT(base.network.RegisteredAgents);
  UNSIGNED numberOfLinkedBusinesses := COUNT(base.network.LinkedBusinesses);
END;

busLegalSummary := RECORD
  UNSIGNED numberOfCivilEvents := COUNT(base.legal.PossibleLiensJudgmentsEvictions);
  UNSIGNED largestFilingAmount := MAX(base.legal.PossibleLiensJudgmentsEvictions, FilingAmount);
  UNSIGNED numberOfLegalEvents := COUNT(base.legal.PossibleLegalEvents);
END;

busDetailSummaryAll := RECORD
  UNSIGNED seq := base.seq;
  UNSIGNED processingTime := base.time_ms;
  UNSIGNED calcdLexID := (UNSIGNED)base.busLexID;
  STRING3 lexIDMatch := base.busLexIDMatch;
  BOOLEAN lexIDChanged := base.lexIDChanged;
  busEconomicSummary economic; 
  busOperatingSummary operating;
  busNetworkingSummary networking;
  busLegalSummary legal;
END;


busDetailSummary := TABLE(base((UNSIGNED)busLexID > 0), busDetailSummaryAll);

                                     
                                      
    
    

OUTPUT(inputData, NAMED('inputData'));      
OUTPUT(CHOOSEN(rawInput, eyeball), NAMED('rawInput'));      
OUTPUT(CHOOSEN(inputRecords, eyeball), NAMED('inputRecords')); 
OUTPUT(CHOOSEN(ddInput, eyeball), NAMED('ddInput')); 
OUTPUT(CHOOSEN(ddResults, eyeball), NAMED('ddResults')); 
OUTPUT(CHOOSEN(noErrors, eyeball), NAMED('noErrors')); 
OUTPUT(CHOOSEN(slimReportRaw, eyeball), NAMED('slimReportRaw')); 
OUTPUT(CHOOSEN(base, eyeball), NAMED('base')); 
OUTPUT(CHOOSEN(notFound, eyeball), NAMED('notFound')); 
OUTPUT(CHOOSEN(processedTimings, eyeball), NAMED('processedTimings')); 
OUTPUT(CHOOSEN(attributesOnly, eyeball), NAMED('attributesOnly'));     
OUTPUT(CHOOSEN(summary, eyeball), NAMED('DDResultsSummary')); 
OUTPUT(CHOOSEN(busDetailSummary, eyeball), NAMED('busDetailEconomicSummary')); 




            
                    
IF(returnOutputFiles, OUTPUT(attributesOnly,, outputFile + 'Attrs.csv', CSV(HEADING(single), QUOTE('"'))));	
IF(returnOutputFiles, OUTPUT(processedTimings,, outputFile + 'SlimTimings.csv', CSV(HEADING(single), QUOTE('"'))));
IF(returnOutputFiles, OUTPUT(notFound,, outputFile + 'Not_Processed.csv', CSV(HEADING(single), QUOTE('"'))));
IF(returnOutputFiles, OUTPUT(summary,, outputFile + 'Results_Summary.csv', CSV(HEADING(single), QUOTE('"'))));
IF(returnOutputFiles, OUTPUT(busDetailSummary,, outputFile + 'Business_Details_Summary.csv', CSV(HEADING(single), QUOTE('"'))));
