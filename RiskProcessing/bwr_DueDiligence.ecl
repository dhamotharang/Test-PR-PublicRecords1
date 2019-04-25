#workunit('name','Due Diligence Batch');

IMPORT Data_Services, DueDiligence, RiskWise, STD;

/* *****************************************************
 *                   Options Section                   *
 *******************************************************/
inputFile := Data_Services.foreign_prod + 'jpyon::in::rbs_1179_bus_bus_con_f_s_in';
outputFile := '~tgertken::out::duedil_out_' + thorlib.wuid();  //  change output file name to person running script


//MINIMUM INPUT:
//  There is no minimum PII requirements for this product.  All records will process

STRING ddVersionRequested := '3';  //Currently only version 3 is supported

BOOLEAN runInRealTime := FALSE;   //When TRUE will run request in real time mode, if FALSE will run with archive date from file

//Standard input options
UNSIGNED1 inGLBA := 1;
UNSIGNED1 inDPPA := 3;

STRING inDataPermission := '0000000000000';
STRING inDataRestriction := '0000010001001100000000000';	// byte 6, if 1, restricts experian, byte 8, if 1, restricts equifax, 
                                                          // byte 10 restricts Transunion, 12 restricts ADVO, 13 restricts bureau deceased data

//Location of the ECL query
roxieIP := RiskWise.Shortcuts.prod_batch_analytics_roxie; 


UNSIGNED eyeball := 10;        //Number of records to preview
UNSIGNED record_limit := 0;    //Number of records to read from input file; 0 means ALL
UNSIGNED threads := 30;          //Number of parallel calls to run in the SOAPCALL to the Roxie Query 




/* *****************************************************
 *                      Main Script                    *
 *******************************************************/
layout:= RECORD
    STRING Account;
    STRING CompanyName;
    STRING AlternateCompanyName;
    STRING BusAddr;
    STRING BusCity;
    STRING BusState;
    STRING BusZip;
    STRING BusinessPhone;
    STRING TaxID;
    STRING FirstName;
    STRING MiddleName;
    STRING LastName;
    STRING NameSuffix;
    STRING StreetAddress;
    STRING City;
    STRING State;
    STRING Zip;
    STRING SSN;
    STRING DateOfBirth;
    STRING Age;
    STRING DLNumber;
    STRING DLState;
    STRING HomePhone;
    STRING EmailAddress;
    STRING HistoryDate;           //Expecting YYYYMMDD or YYYYMM or 999999
    STRING CustTypeCode;          //Needs to be either 'I' for Individual  or  'B' for BUSINESS
    STRING LexID;
END;




input := IF(record_limit = 0, 
            DATASET(inputFile, Layout, CSV(QUOTE('"'))),
            CHOOSEN(DATASET(inputFile, Layout, CSV(QUOTE('"'))), record_limit));
		
										
//append seq to the input to track order
inputRecords := PROJECT(input, TRANSFORM({UNSIGNED seq, RECORDOF(LEFT)}, SELF.seq := COUNTER; SELF := LEFT;));






DD_input := record
	DATASET(DueDiligence.Layouts.BatchInLayout) batch_in;
  STRING attributesVersion := ddVersionRequested;
  UNSIGNED1 glba := inGLBA;
	UNSIGNED1 dppa := inDPPA;
	STRING dataRestriction := inDataRestriction;
  STRING dataPermission := inDataPermission;
END;


reqInput := PROJECT(inputRecords, TRANSFORM(DD_input,
                                              SELF.batch_in := DATASET([TRANSFORM(DueDiligence.Layouts.BatchInLayout,
                                                                        SELF.seq := LEFT.seq;
                                                                        SELF.acctNo := LEFT.Account;
                                                                        SELF.lexID := LEFT.LexID;
                                                                        
                                                                        BOOLEAN isIndiv := STD.Str.ToUpperCase(TRIM(LEFT.CustTypeCode)) = 'I';
                                                                        
                                                                        SELF.custType := IF(isIndiv, DueDiligence.Constants.INDIVIDUAL, DueDiligence.Constants.BUSINESS);
                                                                        
                                                                        SELF.companyName := IF(isIndiv = FALSE, LEFT.CompanyName, '');
                                                                        SELF.altCompanyName := IF(isIndiv = FALSE, LEFT.AlternateCompanyName, '');
                                                                        SELF.taxID := IF(isIndiv = FALSE, LEFT.taxID, '');
                                                                        
                                                                        
                                                                        SELF.firstName := IF(isIndiv, LEFT.FirstName, '');
                                                                        SELF.middleName := IF(isIndiv, LEFT.MiddleName, '');
                                                                        SELF.lastName := IF(isIndiv, LEFT.LastName, '');
                                                                        
                                                                        SELF.ssn := IF(isIndiv, LEFT.SSN, '');
                                                                        SELF.dob := IF(isIndiv, LEFT.DateOfBirth, '');
                                                                        
                                                                        SELF.streetAddress1 := IF(isIndiv, LEFT.StreetAddress, LEFT.BusAddr);
                                                                        SELF.city := IF(isIndiv, LEFT.City, LEFT.BusCity);
                                                                        SELF.state := IF(isIndiv, LEFT.State, LEFT.BusState);
                                                                        SELF.zip5 := IF(isIndiv, LEFT.Zip, LEFT.BusZip)[..5];
                                                                        SELF.zip4 := IF(isIndiv, LEFT.Zip, LEFT.BusZip)[6..];

                                                                        SELF.phone := IF(isIndiv, LEFT.HomePhone, LEFT.BusinessPhone);
                                                                        
                                                                        SELF.HistoryDateYYYYMMDD := IF(runInRealTime, 99999999, (UNSIGNED4)LEFT.HistoryDate);
                                   
                                                                        SELF := [];)]);));
                                                                        
                                                                        
dd_input_dist := DISTRIBUTE(reqInput, RANDOM());


BatchOutputWithError := RECORD
  DueDiligence.Layouts.BatchOut;
  STRING errorCode;
END;


BatchOutputWithError myFail(dd_input_dist le) := TRANSFORM
	SELF.errorCode := FAILCODE + FAILMESSAGE;
	SELF := le;
	SELF := [];
END;

dueDiligenceResults := SOAPCALL(dd_input_dist, 
                                roxieIP,
                                'DueDiligence.DueDiligence_Batch_Service', 
                                {dd_input_dist}, 
                                DATASET(BatchOutputWithError),
                                RETRY(5), TIMEOUT(500),
                                PARALLEL(threads), 
                                ONFAIL(myFail(LEFT)));
                      
                      

droppedInput := JOIN(inputRecords, dueDiligenceResults,
                      LEFT.seq = RIGHT.seq AND
                      LEFT.Account = RIGHT.acctNo,
                      TRANSFORM({RECORDOF(LEFT) - seq}, SELF := LEFT;), 
                      LEFT ONLY); //These are in the format as input to be reprocessed	


                                                              
processedResults := SORT(dueDiligenceResults(errorCode = ''), seq);		






OUTPUT(COUNT(input), NAMED('inputRecords_count'));  
OUTPUT(CHOOSEN(inputRecords, eyeball), NAMED('inputRecords'));  

OUTPUT(COUNT(reqInput), NAMED('reqInput_count'));
OUTPUT(CHOOSEN(reqInput, eyeball), NAMED('reqInput'));
                      
OUTPUT(COUNT(dueDiligenceResults), NAMED('dueDiligenceResults_count'));                      
OUTPUT(CHOOSEN(dueDiligenceResults, eyeball), NAMED('dueDiligenceResults')); 

OUTPUT(COUNT(dueDiligenceResults(errorCode <> '')), NAMED('dueDiligenceResultsError_count'));
OUTPUT(CHOOSEN(dueDiligenceResults(errorCode <> ''), eyeball), NAMED('dueDiligenceResultsError')); 

OUTPUT(COUNT(droppedInput), NAMED('droppedInput_count'));
OUTPUT(CHOOSEN(droppedInput, eyeball), NAMED('droppedInput')); 

OUTPUT(COUNT(processedResults), NAMED('processedResults_count'));
OUTPUT(CHOOSEN(processedResults, eyeball), NAMED('processedResults')); 


OUTPUT(processedResults,, outputFile, CSV(HEADING(single), QUOTE('"')));	                   
OUTPUT(dueDiligenceResults(errorCode <> ''),, outputFile + '_err', CSV(HEADING(single), QUOTE('"')));	  
OUTPUT(droppedInput,, outputFile + '_reprocess', CSV(QUOTE('"')));       