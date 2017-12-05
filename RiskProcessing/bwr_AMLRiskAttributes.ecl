#workunit('name','AML Batch');

import Models, risk_indicators, aml, ut, RiskWise, Gateway;


/* *****************************************************
 *                   Options Section                   *
 *******************************************************/
inputFile :=  ut.foreign_prod + 'jpyon::in::rbs_1179_bus_bus_con_f_s_in';
outputFile := '~mwalklin::out::rbs_1179_aml_attrib_out' + thorlib.wuid();  //  change output file name to person running script


/* 
 * Number of records to run from the input file.  
 * Set to 0 to run ALL records in the input file.
 */
eyeball := 10;
unsigned record_limit :=   0;    //number of records to read from input file; 0 means ALL



/* 
 * Roxie the ECL Query is located on 
 */
// RoxieBatch
roxieIP := RiskWise.Shortcuts.prod_batch_neutral; 


/* *****************************************************
 *                      Main Script                    *
 *******************************************************/
layout:= record
	string	AccountNumber	;
	string	CompanyName	;
	string	AlternateCompanyName	;
	string	BusAddr	;
	string	BusCity	;
	string	BusState	;
	string	BusZip	;
	string	BusinessPhone	;
	string	TaxIdNumber	;
	string	BusinessIPAddress ;
	string	IndvFirstName	;
	string	IndvMiddleName ;
	string	IndvLastName	;
	string	IndvNameSuffix  ;
	string	IndvAddr	;
	string	IndvCity	;
	string	IndvState	;
	string	IndvZip	;
	string	IndvSSN	;
	string	IndvDOB	;
	string  IndvAge   ;
	string	IndvDLNumber	;
	string	IndvDLState	;
	string	IndvHomePhone	;
	string	IndvEmailAddress	;
	string  IndvFormerLastName ;
	integer	HistoryDateYYYYMM;
	string10 CustTypeCd;     // Needs to be either 'I' for Individual  or  'B' for BUSINESS
	string15 LexID;
end;

f := IF(record_limit = 0, 
                DATASET(inputFile, Layout, CSV(QUOTE('"'))),
                CHOOSEN(DATASET(inputFile, Layout, csv(QUOTE('"'))), record_limit));
OUTPUT (choosen(f,eyeball), NAMED ('input'));

string DataRestrictionMask := '0000000000000000000000000';	// byte 6, if 1, restricts experian, byte 8, if 1, restricts equifax, 
																								// byte 10 restricts Transunion, 12 restricts ADVO, 13 restricts bureau deceased data
unsigned1 glba := 1;
unsigned1 dppa := 3;

AML_input_batch := record
	dataset(AML.Layouts.AMLBatchInLayout) batch_in;
	unsigned1 glb       								:= glba;
	unsigned1 dppa      								:= dppa ;
	string50 DataRestriction       	    := DataRestrictionMask ;
	string32 AttributesVersion 				:= '2';  // THE Code DEFAULT IS VERSION 1 -  CHANGE TO 1 or LEAVE BLANK IF YOU WANT VERSION 1 ATTRIBUTES
  DATASET(Gateway.Layouts.Config) gateways;
END;



AML_input_batch inputTForm(f le, INTEGER c) := TRANSFORM
r2 := project(ut.ds_oneRecord, transform(AML.Layouts.AMLBatchInLayout, 
		CustTypeCd := Map((unsigned6)le.LexID <> 0 and le.CustTypeCd = 'I'   => 'INDIVIDUAL',
								      (unsigned6)le.LexID <> 0  and le.CustTypeCd = 'B'   => 'BUSINESS',
											(unsigned6)le.LexID = 0 and le.CustTypeCd = 'B'   => 'BUSINESS',
											(unsigned6)le.LexID = 0 and le.CustTypeCd = 'I'   => 'INDIVIDUAL',
											(unsigned6)le.LexID = 0 and le.CompanyName <> ''   => 'BUSINESS',
										 'INDIVIDUAL'); 
  self.HistoryDateYYYYMM  := 999999;	//   use for realtime
  // self.HistoryDateYYYYMM  := le.HistoryDateYYYYMM;	  // use for archive date from file
  self.AcctNo  	     :=  le.AccountNumber;
	self.CustType   	 := CustTypeCd;
  self.seq        	 := c;
	self.LexID      	 := (unsigned6)le.LexID;
	self.Business_Name := le.CompanyName;
	self.DBA           := le.AlternateCompanyName;
	self.TaxiD         := le.TaxIdNumber;             
	self.Name_First    := if(CustTypeCd = 'BUSINESS', '', le.IndvFirstName) ;
	self.Name_Middle   := if(CustTypeCd = 'BUSINESS', '', le.IndvMiddleName) ; 
	self.Name_Last     := if(CustTypeCd = 'BUSINESS', '', le.IndvLastName) ; 
	self.ssn           := le.IndvSSN ;
	self.dob           := le.IndvDOB;

	self.street_addr      := if(CustTypeCd = 'INDIVIDUAL', le.IndvAddr, le.BusAddr); 
	self.City_name        := if(CustTypeCd = 'INDIVIDUAL', le.IndvCity, le.BusCity);
	self.st              	:= if(CustTypeCd = 'INDIVIDUAL', le.IndvState, le.BusState);
	self.z5            		:= if(CustTypeCd = 'INDIVIDUAL', le.IndvZip, le.BusZip);
	self.phone            := if(CustTypeCd = 'INDIVIDUAL', le.IndvHomePhone, le.BusinessPhone);
	
	self := []));
	SELF.batch_in := r2; 
	// NO GATEWAY
	// SELF.gateways := []; // use this one for NO  NEWS PROFILE RESULTS  Bridger 
	//CERT
	self.gateways := dataset([{'searchcore', 'HTTP://api_qa_gw_roxie:g0h3%40t2x@gatewaycertesp.sc.seisint.com:7726/WsGateway/?ver_=1.93'}], Gateway.Layouts.Config);  // CERT use this one to run NEWS PROFILE FROM BRIDGER SEARCH CORE	
  // PROD GATEWAY
	// self.gateways := dataset([{ 'searchcore', 'HTTP://rw_data_prod:Password01@gatewayprodesp.sc.seisint.com:7726/WsGateway/?ver_=1.93'}], Gateway.Layouts.Config);   //  PROD use this one to run Neg News	

end;
p_f1 := project(f, inputTForm(left, counter));
p_f := distribute(p_f1, random());

output(choosen(p_f,eyeball), named('amlInput'));

/* 
 * Number of parallel calls to run in the SOAPCALL to the Roxie Query 
 */
threads := 10;  

xlayout := RECORD
	AML.Layouts.AMLBatchOut;
	STRING errorcode;
END;

xlayout myFail(p_f le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF := le;
	SELF := [];
END;

AMLResults := soapcall(p_f, roxieIP,
				'AML.AML_Batch_Service', 
				{p_f}, 
				DATASET(xlayout),
				PARALLEL(threads), 
				onFail(myFail(LEFT)));
				
output(count(AMLResults), named('countAMLResults'));

SortAMLResults := sort(AMLResults, AcctNo);   

output(SortAMLResults);
output(SortAMLResults,, outputFile,CSV(heading(single), quote('"')));

output(choosen(SortAMLResults(errorcode<>''), eyeball),named('ErrorCodes'));
output(SortAMLResults(errorcode<>''),,outputFile + '_err',CSV(QUOTE('"')));









