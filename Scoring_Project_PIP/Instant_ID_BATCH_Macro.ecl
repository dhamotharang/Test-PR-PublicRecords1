 // #workunit('name','Consumer IID Process_Batch');
// #option ('hthorMemoryLimit', 1000);

EXPORT Instant_ID_BATCH_Macro (roxie_ip,Gateway_dummy, Thread, Timeout, Retry, Input_file_name,Output_file_name, records_ToRun):= functionmacro

import ut, Risk_Indicators, riskwise, models;

unsigned8 no_of_records := records_ToRun;
unsigned1 eyeball := 10;
integer retry := retry;
integer timeout := timeout;
integer threads := Thread;

String roxieIP := roxie_ip ;  
gateways := Gateway;
String Infile_name :=  Input_file_name;
String outfile_name :=  Output_file_name ;

include_internal_extras:=true;


//*********custom settings**********


DRM:=Scoring_Project_PIP.User_Settings_Module.IID_Scores_V0_BATCH_Generic_settings.DRM;
// IncludeVersion4:=Scoring_Project_PIP.User_Settings_Module.IID_Scores_V0_BATCH_Generic_settings.IncludeVersion4;
// IsPreScreen:=Scoring_Project_PIP.User_Settings_Module.IID_Scores_V0_BATCH_Generic_settings.IsPreScreen;
// isFCRA:=if(Scoring_Project_PIP.User_Settings_Module.IID_Scores_V0_BATCH_Generic_settings.isFCRA=true,'FCRA','NONFCRA');

	HistoryDate := 999999;

//**********************************
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

//==================  input file layout  ========================
layout_input := RECORD
    Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
END;
f1 := IF(no_of_records = 0, dataset( Infile_name, layout_input,thor), choosen(dataset ( Infile_name, layout_input,thor), no_of_records));

f := distribute(f1, hash64(AccountNumber));


Layout_Attributes_In := RECORD
	string name;
END;

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
	SELF.Accountnumber := (STRING)le.accountnumber;	
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
	
self.HistoryDateYYYYMM := 999999;

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

p_f := project(f, t_f(left, counter));
// output(p_f, named('CIID_Input'));

dist_dataset := PROJECT(p_f,TRANSFORM(layout_soap,SELF := LEFT));

layout_soap_input := RECORD
	DATASET(Risk_Indicators.Layout_Batch_In) batch_in;
	// DATASET(Risk_Indicators.Layout_Gateways_In) gateways;
	STRING DataRestrictionMask;
	// boolean IncludeVersion4;
	// BOOLEAN IsPreScreen;	
END;

Risk_Indicators.Layout_Batch_In make_batch_in(p_f le, integer c) := TRANSFORM
	self.seq := c;
	SELF.acctno := le.accountnumber;
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
self.HistoryDateYYYYMM := 999999;
	SELF := le;
	SELF := [];
END;

layout_soap_input make_rv_in(p_f le, integer c) := TRANSFORM
	batch := PROJECT(le, make_batch_in(LEFT, c));
	SELF.batch_in := batch;
	// SELF.gateways := DATASET([{isFCRA, roxieIP}], risk_indicators.layout_gateways_in);
	// SELF.IsPreScreen := IsPreScreen;		
	// self.IncludeVersion4 := IncludeVersion4;
	SELF.DataRestrictionMask := DRM;
	END;
	
soap_in := PROJECT(p_f, make_rv_in(LEFT, counter));
	
xlayout := RECORD
	unsigned8 time_ms {xpath('_call_latency_ms')} := 0;  // picks up timing 
	// (risk_indicators.Layout_InstandID_NuGen)
	risk_indicators.Layout_InstantID_NuGen_Denorm; // layout changed for popuplating reason codes. Ref email 10/09/2015 from Ben
	STRING errorcode;
END;

xlayout myFail(soap_in le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF.AcctNo := le.batch_in[1].acctno;
	SELF := le;
	SELF := [];
END;

resu := soapcall(soap_in, roxieIP,
				'risk_indicators.InstantID_batch', {soap_in}, 
				DATASET(xlayout), RETRY(3), TIMEOUT(120),
				PARALLEL(threads), onFail(myFail(LEFT)));
				

//GLOBAL OUTPUT LAYOUT
Global_output_lay:= RECORD	 
Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_InstantId_Global_Layout;			 
END;

Global_output_lay normit(resu L, p_f R) := transform
	SELF.Acctno := R.old_account_number;

	self.nas_summary := (integer)L.nas_summary;
	self.nap_summary := (integer)L.nap_summary;
	self.CVI := L.cvi;
	self.additional_score1 := (integer)L.additional_score1;
	self.additional_score2 :=(integer)L.additional_score2;
	self.seq := (integer)intformat((integer)L.seq,12,1);
	self.age := if (L.age = '***', '', L.age);
	self.did:=(integer)L.did;
	self.transaction_id:=(integer)L.transaction_id;
	self := L;
  self := [];
end;

j_f := JOIN(resu,p_f,LEFT.acctno=RIGHT.accountnumber,normit(LEFT,RIGHT));


      Global_output_lay xform1(j_f l, soap_in r) := TRANSFORM
      	#if(include_internal_extras)
      		                  self.DID := l.did; 
      		                  self.historydate := (string)r.batch_in[1].HistoryDateYYYYMM;
				                    self.FNamePop := r.batch_in[1].Name_First<>'';
			                     	self.LNamePop := r.batch_in[1].Name_Last<>'';
				                    self.AddrPop := r.batch_in[1].street_addr<>'';
			                    	self.SSNLength := (string)(length(trim(r.batch_in[1].ssn,left,right))) ;
			                    	self.DOBPop := r.batch_in[1].dob<>'';
	                      			// self.EmailPop := r.batch_in[1].email<>'';
			                     	self.IPAddrPop := r.batch_in[1].ip_addr<>''; 
			                    	self.HPhnPop := r.batch_in[1].Home_Phone<>'';
      	#end;
      	self := l;
      	self := [];
      	
      	end;
      	
      	final_output:=join(j_f,soap_in,left.acctno=(string)right.batch_in[1].acctno ,xform1(left, right));	

op_final := output(final_output,, outfile_name, thor,compressed,OVERWRITE);

return op_final;

endmacro;