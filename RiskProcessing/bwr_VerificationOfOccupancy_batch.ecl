#workunit('name','Verification Of Occupancy');
import Models, risk_indicators, VerificationOfOccupancy, ut, RiskWise;

/* *****************************************************
 *                   Options Section                   *
 *******************************************************/

inputFile :=  '~tfuerstenberg::in::pioneer_4959_may2013_unbooked_f_s_in2';   //FannieMae large sample file (543,857 records)
outputFile := '~tfuerstenberg::out::VerOfOcc_';

eyeball := 20;
unsigned record_limit :=   0;    //number of records to read from input file; 0 means ALL

//Number of parallel calls to run in the SOAPCALL to the Roxie Query 
threads := 30;

//Roxie the ECL Query is located on 
roxieIP := RiskWise.Shortcuts.prod_batch_analytics_roxie; 

//Input file layout
 prii_layout := RECORD
 STRING AccountNumber;
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
 integer historydateyyyymm;
END;

raw_input := IF(record_limit = 0, 
                DATASET(inputFile, prii_layout, CSV(QUOTE('"'))),
                CHOOSEN(DATASET(inputFile, prii_layout, csv(QUOTE('"'))), record_limit));
OUTPUT (choosen(raw_input, eyeball), NAMED ('input'));

wseq_layout := RECORD
 prii_layout input; 
 string30 old_account ;
END;

wseq_layout getSeq(raw_input le, INTEGER c) := TRANSFORM
  self.old_account   				:= le.AccountNumber;
  self.input.AccountNumber 	:= (string)c;
	self.input							 	:= le;
end;

wseq := project(raw_input, getSeq(left, counter));
// output(choosen(wseq, eyeball), named('wseq'));

string DataRestrictionMask := '0000000000000000000000000';	// byte 6, if 1, restricts experian, byte 8, if 1, restricts equifax, 
																								// byte 10 restricts Transunion, 12 restricts ADVO, 13 restricts bureau deceased data
string DataPermissionMask := '0000000000000';			// byte 10 restricts SSA Death Master - set to '1' to allow
unsigned1 glba := 1;
unsigned1 dppa := 3;
string9   AttributesVersionRequest	:= 'VOOATTRV1';
boolean   IncludeModel     					:= true;    // set to 'true' to return the score

VOO_input_batch := record
	dataset(VerificationOfOccupancy.Layouts.Layout_VOOBatchIn) batch_in;
	unsigned1 DPPAPurpose      					:= dppa ;
	unsigned1 GLBPurpose       					:= glba;
	string5		IndustryClass							:= '';
	string50 	DataRestrictionMask       := DataRestrictionMask;
	string9   AttributesVersionRequest	:= AttributesVersionRequest;
	boolean   IncludeModel     					:= IncludeModel;	
	string50 	DataPermissionMask       	:= DataPermissionMask;
END;


VOO_input_batch inputTForm(wseq le, INTEGER c) := TRANSFORM
	r2 := project(ut.ds_oneRecord, transform(VerificationOfOccupancy.Layouts.Layout_VOOBatchIn, 
  self.AcctNo  	     := le.input.AccountNumber;
  self.seq        	 := c;
	self.Name_First    := le.input.FirstName ;
	self.Name_Middle   := le.input.MiddleName ; 
	self.Name_Last     := le.input.LastName ; 
	self.ssn           := le.input.SSN;
	self.dob           := le.input.DateOfBirth;
	self.street_addr   := le.input.StreetAddress; 
	self.City_name     := le.input.City;
	self.st            := le.input.State;
	self.z5            := le.input.Zip;
  self.AsOf      		 := (string)le.input.historydateyyyymm + '01';	
	self := []));
	SELF.batch_in := r2;
end;

soap_in := distribute(project(wseq, inputTForm(left, counter)));
output(choosen(soap_in, eyeball), named('soap_in'));

xlayout := RECORD
	VerificationOfOccupancy.Layouts.Layout_VOOBatchOutFlat;
	STRING errorcode;
END;

xlayout myFail(soap_in le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF := le;
	SELF := [];
END;

VOOResults := soapcall(soap_in, roxieIP,
				'VerificationOfOccupancy.Batch_Service', 
				{soap_in}, 
				DATASET(xlayout),
				PARALLEL(threads), 
				onFail(myFail(LEFT)));
				
// output(count(VOOResults), named('countVOOResults'));
// output(choosen(VOOResults, eyeball),named('VOOResults'));
// output(VOOResults(errorcode<>''),,outputFile + '_err',CSV(QUOTE('"')), overwrite);
output(choosen(VOOResults(errorcode<>''), eyeball),named('ErrorCodes'));

finalLayout := RECORD
	VerificationOfOccupancy.Layouts.Layout_VOOBatchOutFlat;
END;

finalLayout getFile_Ind(VOOResults le, wseq ri) := TRANSFORM
		SELF.seq 					:= (integer)ri.input.AccountNumber;
		SELF.AcctNo 			:= ri.old_account;
		SELF							:= le;
end;

finalResults := join(VOOResults, wseq,
										 left.AcctNo = right.input.AccountNumber,
										 getFile_Ind(left, right), left outer);
output(count(finalResults), named('countFinalResults'));
output(choosen(finalResults, eyeball), named('finalResults'));
output(finalResults,, outputFile + '_' + thorlib.wuid(),CSV(heading(single), quote('"')), overwrite);
