Import Riskview, Doxie, Risk_Indicators, dx_FirstData; 
// BWR to read in RV5 files and append Best SSN.  Then join to the FD file to append DL/DL state


RV50output_layout := record
	unsigned8 time_ms{xpath('_call_latency_ms')} := 0;  // picks up timing
	riskview.layouts.layout_riskview5_batch_response;
	STRING errorcode;
END;

FDFinalLayout := Record
  STRING30  account_number; 
  Unsigned6 LexID;
	STRING20  DL_Number;
	STRING2   DL_State;
  STRING9   ssn ;
  string   archive_date ;

END;

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
    string employername;
    string historydate;

end;


recordsToRun := 0; // Set to 0 or -1 to run ALL records in the file

// Please use the same DRM that was used to run RV50 file
DataRestriction := '10000100010001000000000000000000000000000';   

// File name that was the input to RV50
RVInputFile_temp := '~tfuerstenberg::in::safco_8815_ttdapps_061919_cox_in.csv'; 
//  Put RV50 result file name here  
RVOutFile := '~tfuerstenberg::out::safco_8815_ttdapps_061919_cox_rv50_w20190621-162201' ; 

// Change output file name
FDOutFileName := '~mwalklin::out::CustomerEngagement_FD_out_';
							

RVPIIFile := DATASET(RVInputFile_temp, prii_layout, CSV(QUOTE('"')));
output(RVPIIFile, named('RV50PII_File'));
							
RVFile := IF(recordsToRun > 0, CHOOSEN(DATASET(RVOutFile, RV50output_layout, CSV(QUOTE('"'),heading(single))),recordsToRun,1000),
              DATASET(RVOutFile, RV50output_layout, CSV(QUOTE('"'),heading(single))));
							
Output(Count(RVFile), named('CountRV50ResultRecords'));

RVdids := project(RVFile, transform(FDFinalLayout, 
                                    self.account_number := left.acctno, 
                                    self.LexID := (Unsigned6)left.LexID,
                                    self := []));
																		
//Adding Consumer Data from Input PII file                                    
AppendPII := join(RVdids, RVPIIFile, left.Account_number = right.Account,
                    transform(FDFinalLayout,  self.archive_date := If(length(right.historydate) = 6, right.historydate + '01', right.historydate),
                                              self.ssn := right.SSN,
																							self.DL_Number := right.DLNumber,
																							self.DL_state := right.DLState,
                                              self := left), left outer);
																						
output(AppendPII, named('AppendPII'));
output(Count(AppendPII), named('CountRecsAfterAppendPII'));

unique_dids := dedup(sort(project(distribute(AppendPII(ssn = '' and LexID <> 0), hash64(LexID)),
																	transform(doxie.layout_references, self.did := left.LexID)), did, LOCAL), did, LOCAL);

output(count(unique_dids), named('CountRecsWNoSSN'));

//Append Best SSN for records where SSN wasn't provided on input
bestSSN := risk_indicators.collection_shell_mod.getBestCleaned(unique_dids, 
																																	DataRestriction, 
																																	GLB_Purpose:=1, 
																																	clean_address:=false); // don't need clean address, just the best SSN
	
output(COUNT(bestSSN(ssn <> '')), NAMED('CountSSNsAppended'));

bestSSNappended := join(distribute(AppendPII, hash64(LexID)), 
													distribute(bestSSN, hash64(did)),  
													left.LexID=right.did,
												  TRANSFORM(FDFinalLayout,
																	self.lexid := left.lexid,
																	SELF.ssn := If(left.ssn <> '', left.ssn, right.ssn),
																	SELF := left), left outer, LOCAL);
                                  
 
 output(bestSSNappended, named('SSNappended'));
 output(Count(bestSSNappended), named('RecCountAfterSSNappended'));
 
// First Data key used to append DL Number/State based on LexID 
FDKey :=  dx_FirstData.key_DID();



FDFinalLayout GetDL(bestSSNappended le, FDKey ri) := TRANSFORM	

  SELF.account_number := le.ACCOUNT_NUMBER; 
  SELF.LexID := le.lexid;
	SELF.DL_Number := if(ri.DL_ID <> '', ri.DL_ID, le.DL_Number);
	SELF.DL_State := if(ri.dl_state <> '', ri.dl_state, le.dl_state);
  SELF.ssn := le.ssn;
  SELF.archive_date := le.archive_date;
	
END;

output(Count(bestSSNappended(dl_number = '')),named('CountRecsWnoDL'));

// The LexID is a string value on the FD key, INTFORMAT used to match Input LexID to key.
GetFDdata := join(bestSSNappended, FDKey, left.lexid = right.lex_id ,
																					//  Date logic incase it is decided to use it
																					// and 
																					// left.archive_date >= If(right.FIRST_SEEN_DATE_TRUE = '', '19010101', right.FIRST_SEEN_DATE_TRUE),
																					GetDL(LEFT,RIGHT), LEFT OUTER, Keep(1));

OUTPUT(GetFDdata, NAMED('GetFDdata'));
OUTPUT(Count(GetFDdata), NAMED('RecCountAfterFDdataAppend'));


OUTPUT(Count(GetFDdata(Dl_number <> '')), NAMED('CountRecsWithDLAfterFDappend'));

//Output file with results to send to First Data
output(GetFDdata,, FDOutFileName + thorlib.wuid(),CSV(QUOTE('"'),heading(single))); 