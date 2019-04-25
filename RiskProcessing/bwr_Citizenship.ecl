#workunit('name','Citizenship Batch');

IMPORT Citizenship, Data_Services, DueDiligence, RiskWise, STD;

/* *****************************************************
 *                   Options Section                   *
 *******************************************************/
inputFile := Data_Services.foreign_prod + 'evanheel::in::usaa_03182019_in.csv';
outputFile := '~tgertken::out::cit_out_' + thorlib.wuid();  //  change output file name to person running script


//Depending on which product(s) you are requesting will depend on which option(s) you select here:
//  (1)Citizenship ONLY - provide an input model name (is required for requesting citizenship)
//  (2)Citizenship + Person Due Diligence Attributes - provide an input model name AND Due Diligence version
//      **Leaving defaults will produce Citizenship only
//      **This can only run individuals - all businesses must be run via the RiskProcessing.bwr_DueDiligence
//
//
//  MINIMUM INPUTS for Citizenship + Person Due Diligence Attributes:
//            There is no minimum PII requirements for either product.  All records will process


//Currently only model available: CIT1808_0_0
STRING citizenshipInputModelName := 'CIT1808_0_0';   

//Currently only version '3' is supported; valid values: '', '3'
STRING ddVersionRequested := '';  //With '' Citizenscore only
                                  //With ’3’ Citizenscore and Dueligience
                  

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
UNSIGNED threads := 30;        //Number of parallel calls to run in the SOAPCALL to the Roxie Query 




/* *****************************************************
 *                      Main Script                    *
 *******************************************************/
layout:= record
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
inputRecords := PROJECT(input, TRANSFORM({UNSIGNED seq, RECORDOF(LEFT)}, SELF.seq := COUNTER; SELF := LEFT;));




DD_input := record
	DATASET(DueDiligence.Layouts.BatchInLayout) batch_in;
  STRING attributesVersion := ddVersionRequested;
  STRING modelName := citizenshipInputModelName;
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
                                                                        
                                                                        SELF.custType := DueDiligence.Constants.INDIVIDUAL;
                                                                        SELF.ssn := LEFT.SSN;
                                                                        
                                                                        
                                                                        SELF.firstName := LEFT.FirstName;
                                                                        SELF.middleName := LEFT.MiddleName;
                                                                        SELF.lastName := LEFT.LastName;
                                                                        
                                                                        SELF.dob := LEFT.DateOfBirth;
                                                                        
                                                                        SELF.streetAddress1 := LEFT.StreetAddress;
                                                                        SELF.city := LEFT.City;
                                                                        SELF.state := LEFT.State;
                                                                        SELF.zip5 := LEFT.Zip[..5];
                                                                        SELF.zip4 := LEFT.Zip[6..];

                                                                        SELF.phone := LEFT.HomePhone;
                                                                        SELF.phone2 := LEFT.WorkPhone;
                                                                        
                                                                        SELF.dlNumber := LEFT.DLNumber;
                                                                        SELF.dlState := LEFT.DLState;
                                                                        
                                                                        SELF.emailAddress := LEFT.Email;
                                                                        SELF.HistoryDateYYYYMMDD := IF(runInRealTime, 99999999, (UNSIGNED4)LEFT.HistoryDate);
                                   
                                                                        SELF := [];)]);));


cit_input_dist := DISTRIBUTE(reqInput, RANDOM());



                                                  
BatchOutputWithError := RECORD
  DueDiligence.Layouts.BatchOut;
  STRING errorCode;
END;

BatchOutputWithError myFail(cit_input_dist le) := TRANSFORM
	SELF.errorCode := FAILCODE + FAILMESSAGE;
	SELF := le;
	SELF := [];
END;

citizenshipResults := SOAPCALL(cit_input_dist, 
                          roxieIP,
                          'DueDiligence.DueDiligence_Batch_Service', 
                          {cit_input_dist}, 
                          DATASET(BatchOutputWithError),
                          RETRY(5), TIMEOUT(500),
                          PARALLEL(threads), 
                          ONFAIL(myFail(LEFT)));
                      

processedResults := SORT(citizenshipResults(errorCode = ''), seq);


droppedRequests := JOIN(inputRecords, citizenshipResults,
                          LEFT.seq = RIGHT.seq,
                          TRANSFORM({RECORDOF(LEFT) -seq}, SELF := LEFT;), 
                          LEFT ONLY); 
                      


																										
                                            
                                                  
                                                  


                                                
OUTPUT(COUNT(input), NAMED('inputRecords_count'));  
OUTPUT(CHOOSEN(inputRecords, eyeball), NAMED('inputRecords'));  

OUTPUT(COUNT(reqInput), NAMED('reqInput_count'));
OUTPUT(CHOOSEN(reqInput, eyeball), NAMED('reqInput'));
                     
OUTPUT(COUNT(citizenshipResults), NAMED('citizenshipResults_count'));                      
OUTPUT(CHOOSEN(citizenshipResults, eyeball), NAMED('citizenshipResults')); 

OUTPUT(COUNT(citizenshipResults(errorCode <> '')), NAMED('citizenshipResultsError_count'));
OUTPUT(CHOOSEN(citizenshipResults(errorCode <> ''), eyeball), NAMED('citizenshipResultsError')); 

OUTPUT(COUNT(droppedRequests), NAMED('droppedRequests_count'));
OUTPUT(CHOOSEN(droppedRequests, eyeball), NAMED('droppedRequests')); 

OUTPUT(COUNT(processedResults), NAMED('processedResults_count'));
OUTPUT(CHOOSEN(processedResults, eyeball), NAMED('processedResults')); 


OUTPUT(processedResults,, outputFile, CSV(HEADING(single), QUOTE('"')));	                   
OUTPUT(citizenshipResults(errorCode <> ''),, outputFile + '_err', CSV(HEADING(single), QUOTE('"')));	  
OUTPUT(droppedRequests,, outputFile + '_reprocess', CSV(QUOTE('"')));       