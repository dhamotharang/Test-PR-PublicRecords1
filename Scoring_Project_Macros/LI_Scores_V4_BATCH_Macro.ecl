EXPORT LI_Scores_V4_BATCH_Macro (roxie_ip,Gateway_dummy, Thread, Timeout, Retry, Input_file_name,Output_file_name, records_ToRun):= functionmacro


IMPORT Models, iESP, Risk_Indicators, RiskWise, UT, RiskProcessing ;

unsigned8 no_of_records := records_ToRun;
unsigned1 eyeball := 10;
integer retry := retry;
integer timeout := timeout;
integer threads := Thread;

String roxieIP := roxie_ip ; 
gateways := Gateway;
String Infile_name :=  Input_file_name;
String outfile_name :=  Output_file_name ;


model := 'msn1106_0' ;   // Flagship Score




// Versions Available: 1, 3 and 4
version := 3;

// new internal fields for debugging, set to false so they are excluded from the layout by default
include_internal_extras := true;


//*********custom settings**********

DRM:=Scoring_Project_PIP.User_Settings_Module.LI_Scores_V4_BATCH_Generic_msn1106_0_settings.DRM;
isFCRA:=if(Scoring_Project_PIP.User_Settings_Module.LI_Scores_V4_BATCH_Generic_msn1106_0_settings.isFCRA=true,'FCRA','NONFCRA');
IncludeVersion4:=if(Scoring_Project_PIP.User_Settings_Module.LI_Scores_V4_BATCH_Generic_msn1106_0_settings.IncludeVersion4,4,3);

HistoryDate := 999999;

//***********************************

// Boca Shell Version
bocaShellVersion := 4;

// Set to TRUE to run the ADL Based Boca Shell, FALSE to skip it
runADL := TRUE;

// Universally Set the History Date for ALL records. Set to 0 to use the History Date located on each record of the input file
// histDateYYYYMM := 0;

/* **************************************
 *         MAIN SCRIPT CODE             *
 ****************************************/
layout_input := RECORD
    Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
END;

f_all := DATASET( infile_name, layout_input, thor);
f := IF(no_of_Records = 0, f_all, CHOOSEN(f_all, no_of_Records));

				layout_soap := record
	STRING AccountNumber;
	STRING FirstName;
	STRING MiddleName;
	STRING LastName;
	STRING NameSuffix;
	STRING StreetAddress;
	string PrimRange;
	string PreDir;
	string Primname;
	string AddrSuffix;
	string PostDir;
	string UnitDesignation;
	string SecRange;
	STRING City;
	STRING State;
	STRING Zip;
	STRING Country;
	STRING SSN;
	STRING DateOfBirth;
	STRING Age;
	STRING DLNumber;
	STRING DLState;
	STRING Email;
	STRING IPAddress;
	STRING HomePhone;
	STRING WorkPhone;
	STRING EmployerName;
	STRING FormerName;
	INTEGER GLBPurpose;
	INTEGER DPPAPurpose;
	string DataRestrictionMask;
	integer HistoryDateYYYYMM;
	string neutral_gateway := '';	
	dataset(Models.Layout_Score_Chooser) scores;
	
	boolean OfacOnly;
	integer OFACversion;
	boolean IncludeOfac;
	boolean IncludeAdditionalWatchLists;
	real GlobalWatchlistThreshold;
	boolean PoBoxCompliance;
	boolean IncludeMSoverride;
	boolean IncludeCLoverride;
	boolean IncludeDLVerification;
	string44 PassportUpperLine;
	string44 PassportLowerLine;
	string6 Gender;
	integer DOBradius;
  boolean usedobfilter;
	
	boolean ExactFirstNameMatch;
	boolean ExactFirstNameMatchAllowNicknames;
	boolean ExactLastNameMatch;
	boolean ExactPhoneMatch;
	boolean ExactSSNMatch;

	boolean IncludeAllRiskIndicators;
	
	dataset(risk_indicators.layouts.Layout_DOB_Match_Options) DOBMatchOptions;

end;

l := RECORD
	STRING old_account_number;
	layout_soap;
END;


parms := dataset ([],models.Layout_Parameters);

l t_f(f le, INTEGER c) := TRANSFORM
	SELF.old_account_number := (string)le.AccountNumber;
	SELF.Accountnumber := (STRING)le.AccountNumber;	
	SELF.DPPAPurpose := 3;
	SELF.GLBPurpose := 1;
	
	self.DataRestrictionMask := DRM;	// byte 6, if 1, restricts experian, byte 8, if 1, restricts equifax, 
																								// byte 10 restricts Transunion, 12 restricts ADVO, 13 restricts bureau deceased data

	self.PoBoxCompliance := false;
	self.IncludeMSoverride := false;
	self.IncludeCLoverride := false;
	self.usedobfilter := false;
  self.DOBradius := 2;

	self.OfacOnly := false;
	self.OFACversion := 2;
	self.IncludeOfac := true;
	self.IncludeAdditionalWatchLists := false;
	self.GlobalWatchlistThreshold := 0.84;
	
	self.IncludeDLVerification := false;
	self.PassportUpperLine := '';
	self.PassportLowerLine := '';
	self.Gender := '';
	
self.HistoryDateYYYYMM := HistoryDate;

	self.ExactFirstNameMatch := false;
	self.ExactFirstNameMatchAllowNicknames := false;
	self.ExactLastNameMatch := false;
	self.ExactPhoneMatch := false;
	self.ExactSSNMatch := false;

	self.IncludeAllRiskIndicators := false;
	
	// possible input options 'FuzzyCCYYMMDD','FuzzyCCYYMM''ExactCCYYMMDD''ExactCCYYMM''RadiusCCYY', if using the radius, then 0-3 is the range
	// self.DOBMatchOptions := dataset([{'RadiusCCYY','3'}], risk_indicators.layouts.Layout_DOB_Match_Options);

	SELF := le;
	self := [];
end;

p_f2 := project(f, t_f(left, counter));
//output(p_f2, named('CIID_Input'));

dist_dataset2 :=  distribute(PROJECT(p_f2,TRANSFORM(layout_soap,SELF := LEFT)), random());

xlayout2 := RECORD
	// (risk_indicators.Layout_InstandID_NuGen)
	STRING30 AcctNo;
// new field:
	unsigned6 did;
	STRING errorcode;
END;

xlayout2 myFail3(dist_dataset2 le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF.AcctNo := le.AccountNumber;
	SELF := le;
	SELF := [];
END;

iid_output :=  soapcall(dist_dataset2, roxieIP,
				'risk_indicators.InstantID', {dist_dataset2}, 
				DATASET(xlayout2), RETRY(3), TIMEOUT(120),
				PARALLEL(threads), onFail(myFail3(LEFT)));
 					

//added by Chad
ds_input := IF (no_of_records = 0, f, CHOOSEN (f , no_of_records));

// ds_input;

layout_soap_input := RECORD
	DATASET(Risk_Indicators.Layout_Batch_In) batch_in;
	DATASET(Risk_Indicators.Layout_Gateways_In) gateways;
	STRING DataRestrictionMask;
	// boolean IncludeVersion4;
	INTEGER Version;
	INTEGER HistoryDateYYYYMM;
	BOOLEAN ADL_Based_Shell;
	string ModelName:= '';
	
	//BOOLEAN IsPreScreen;	
END;

Risk_Indicators.Layout_Batch_In make_batch_in(ds_input le, integer c) := TRANSFORM
	self.seq := c;
	SELF.acctno := (STRING)le.accountnumber;
	SELF.Name_First := le.FirstName;
	SELF.Name_Middle := le.MiddleName;
	SELF.Name_Last := le.LastName;
	SELF.street_addr := le.StreetAddress;
	SELF.p_City_name := le.CITY;
	SELF.St := le.STATE;
	SELF.z5 := le.ZIP;
	SELF.Home_Phone := le.HomePhone;
	SELF.SSN := le.SSN;
	SELF.DOB := le.DateOfBirth;
	SELF.Work_Phone := le.WorkPhone;
	self.historydateyyyymm := 999999 ;
	SELF := le;
	SELF := [];
END;

layout_soap_input make_rv_in(ds_input le, integer c) := TRANSFORM
	batch := PROJECT(le, make_batch_in(LEFT, c));
	SELF.batch_in := batch;
	SELF.gateways := DATASET([{isFCRA, roxieIP}], risk_indicators.layout_gateways_in);
	// SELF.IsPreScreen := true;		
	// self.IncludeVersion4 := true;
	SELF.Version := IncludeVersion4;
	SELF.adl_based_shell := true;
	SELF.ModelName:= model ;
  SELF.DataRestrictionMask := DRM;  // to allow use of both Equifax and Experian, this is the default value for all legacy scoring products
self.HistoryDateYYYYMM := HistoryDate;
	END;
	
	soap_in :=  distribute(PROJECT(ds_input, make_rv_in(LEFT, counter)), random());
//End added by chad
// soap_in;


// Now run the LeadIntegrity attributes
LeadIntegrityoutput := RECORD
	// unsigned6 did;
  // models.layouts.layout_LeadIntegrity_attributes_batch ;
	// Models.layouts.layout_LeadIntegrity_attributes_batch_flattened;
     models.layouts.layout_LeadIntegrity_attributes_batch 	;
	STRING errorcode;
END;

LeadIntegrityoutput myFail2(soap_in le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	self.acctno:=le.batch_in[1].acctno;
	SELF := le;
	SELF := [];
END;


				
LeadIntegrity_attributes := SOAPCALL(soap_in, roxieIP,
				'Models.LeadIntegrity_Batch_Service', {soap_in}, 
				DATASET(LeadIntegrityoutput),
				PARALLEL(threads), onFail(myFail2(LEFT)));				
				
// OUTPUT(CHOOSEN(LeadIntegrity_attributes(errorcode=''), eyeball), NAMED('LeadIntegrity_results'));
// OUTPUT(CHOOSEN(LeadIntegrity_attributes(errorcode<>''), eyeball), NAMED('LeadIntegrity_errors'));

// op_final := output(LeadIntegrity_attributes,, outfile_name, thor, OVERWRITE);


	layout_slimmed := RECORD
	STRING20 seq;
	STRING30 acctno;
	// string name;
	string3 score;
	string2 rc1;
	string2 rc2;
	string2 rc3;
	string2 rc4;
//	string2 rc5;
//	string2 rc6;
	
END;
	
	//GLOBAL OUTPUT LAYOUT
Global_output_lay:= RECORD	 
Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_LeadIntegrity_V4_Generic_MSN1210_1_Global_Layout;			 
END;

	Global_output_lay slim_v4( LeadIntegrity_attributes le ) := TRANSFORM
		// self.accountnumber := le.acctno ; // original account number not available here...
		// SELF.seq := le.Seq; // ...so hang onto the seq
    	
	  self.seq    := le.seq;
		self.acctno := le.acctno ;
		self.score  := le.score1;
		self.rc1    := le.reason1;
		self.rc2    := le.reason2;
		self.rc3    := le.reason3;
		self.rc4    := le.reason4;		
		self:=le;
		self:=[];		
				
	END;

	slim_attr := project( LeadIntegrity_attributes, slim_v4(left) );
	

/* did_append_lay := RECORD
   	recordof(slim_attr);
   		unsigned6 did;
   	// RiskProcessing.layout_internal_extras;
   END;
*/


did_append_ds:=JOIN(slim_attr, iid_output, LEFT.acctno = (STRING)RIGHT.AcctNo,
   													TRANSFORM(Global_output_lay,
   													SELF.DID := RIGHT.DID;   									
   													SELF := LEFT;   						
   													), left outer);
// interalextras_lay := RECORD
	// recordof(slim_attr);		
	// RiskProcessing.layout_internal_extras;
// END;
 ds_with_extras := JOIN(did_append_ds, soap_in, LEFT.acctno = (STRING)RIGHT.batch_in[1].acctno,
   													TRANSFORM(Global_output_lay,
   												  self.historydate := (string)right.batch_in[1].HistoryDateYYYYMM;
				                    self.FNamePop := right.batch_in[1].Name_First<>'';
			                     	self.LNamePop := right.batch_in[1].Name_Last<>'';
				                    self.AddrPop := right.batch_in[1].street_addr<>'';
			                    	self.SSNLength := (string)(length(trim(right.batch_in[1].ssn,left,right))) ;
			                    	self.DOBPop := right.batch_in[1].dob<>'';
	                      			// self.EmailPop := right.batch_in[1].email<>'';
			                     	self.IPAddrPop := right.batch_in[1].ip_addr<>''; 
			                    	self.HPhnPop := right.batch_in[1].Home_Phone<>'';
   													   SELF := LEFT;
   												   	 SELF := []
   													));

								
	
	
	op_final := output(ds_with_extras,, outfile_name, thor, compressed,OVERWRITE);
	
return op_final;

endmacro;