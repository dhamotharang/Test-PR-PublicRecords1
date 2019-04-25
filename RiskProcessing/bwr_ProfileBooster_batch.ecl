#workunit('name','Profile Booster');
import risk_indicators, ProfileBooster, ut, RiskWise;

/* *****************************************************
 *                   Options Section                   *
 *******************************************************/

inputFile :=  '~tfuerstenberg::in::carfinance_4176_f_s_in';   
outputFile := '~kvhtemp::out::ProfileBooster_';

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
 string historydateyyyymm;
 string LexID; 
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
string9   AttributesVersionRequest	:= 'PBATTRV1';

PB_input_batch := record
	dataset(ProfileBooster.Layouts.Layout_PB_In) batch_in;
	unsigned1 DPPAPurpose      					:= 0;		//does not apply
	unsigned1 GLBPurpose       					:= 0;		//does not apply
	string5		IndustryClass							:= '';
	string50 	DataRestrictionMask       := DataRestrictionMask;
	string9   AttributesVersionRequest	:= AttributesVersionRequest;
	string50 	DataPermissionMask       	:= DataPermissionMask;
END;


PB_input_batch inputTForm(wseq le, INTEGER c) := TRANSFORM
	r2 := project(ut.ds_oneRecord, transform(ProfileBooster.Layouts.Layout_PB_In, 
  self.AcctNo  	     := le.input.AccountNumber;
  self.seq        	 := c;
  // self.LexID       	 := 0;	//to default input LexID to zero
  self.LexID       	 := (integer)le.input.LexID;  //to pass in the LexID from input
	self.Name_First    := le.input.FirstName ;
	self.Name_Middle   := le.input.MiddleName; 
	self.Name_Last     := le.input.LastName ; 
	self.Name_Suffix   := ''; 
	self.ssn           := le.input.SSN;
	self.dob           := le.input.DateOfBirth;
	self.phone10       := le.input.HomePhone;
	self.street_addr   := le.input.StreetAddress; 
	self.City_name     := le.input.City;
	self.st            := le.input.State;
	self.z5            := le.input.Zip;
	self.historydate   := (integer)le.input.historydateyyyymm[1..6];  //to run in archive mode
	// self.historydate   := 999999;	//to run in current mode
	self					     := []));	//to run in current mode
	SELF.batch_in := r2;
end;

soap_in := distribute(project(wseq, inputTForm(left, counter)));
output(choosen(soap_in, eyeball), named('soap_in'));

xlayout := RECORD
	ProfileBooster.Layouts.Layout_PB_BatchOutFlat;
	STRING errorcode;
END;

xlayout myFail(soap_in le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF := le;
	SELF := [];
END;

PBResults := soapcall(soap_in, roxieIP,
				'ProfileBooster.Batch_Service', 
				{soap_in}, 
				DATASET(xlayout),
				PARALLEL(threads), 
				onFail(myFail(LEFT)));
				
output(count(PBResults), named('countPBResults'));
output(choosen(PBResults, eyeball),named('PBResults'));
output(PBResults(errorcode<>''),,outputFile + '_err',CSV(QUOTE('"')), overwrite);  //writes all errors to a separate perm file
output(choosen(PBResults(errorcode<>''), eyeball),named('ErrorCodes'));

finalLayout := RECORD
	ProfileBooster.Layouts.Layout_PB_BatchOutFlat;
END;

finalLayout getFile_Ind(PBResults le, wseq ri) := TRANSFORM
		SELF.seq 					:= (integer)ri.input.accountnumber;
		SELF.AcctNo 			:= ri.old_account;
		SELF							:= le;
end;

finalResults := join(PBResults(errorcode=''), wseq,
										 left.AcctNo = right.input.accountnumber,
										 getFile_Ind(left, right), left outer);
output(count(finalResults), named('countFinalResults'));
output(choosen(finalResults, eyeball), named('finalResults'));
output(finalResults,, outputFile + '_' + thorlib.wuid(),CSV(heading(single), quote('"')), overwrite);
