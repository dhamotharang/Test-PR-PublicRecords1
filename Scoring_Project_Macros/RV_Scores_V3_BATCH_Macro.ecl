EXPORT RV_Scores_V3_BATCH_Macro (fcraroxie_IP,neutralroxie_IP, Thread, Timeout, Retry, Input_file_name,Output_file_name, records_ToRun):= functionmacro


IMPORT Models, iESP, Risk_Indicators, RiskWise, RiskProcessing, UT;

unsigned8 no_of_records := records_ToRun;
integer eyeball := 50;
integer retry := retry;
integer timeout := timeout;
integer threads := Thread;

String neutralroxieIP := neutralroxie_IP ; 
String fcraroxieIP := fcraroxie_IP ;

Infile_name :=  Input_file_name;

include_internal_extras := true;

String outfile_name :=  Output_file_name ;

// archive_date := (integer) ut.getdate ;
// today         := ut.GetDate[3..];

//*********custom settings**********


DRM:=Scoring_Project_PIP.User_Settings_Module.RV_Scores_V3_BATCH_Generic_settings.DRM;
isFCRA:=if(Scoring_Project_PIP.User_Settings_Module.RV_Scores_V3_BATCH_Generic_settings.isFCRA=true,'FCRA','NONFCRA');
IncludeVersion3:=Scoring_Project_PIP.User_Settings_Module.RV_Scores_V3_BATCH_Generic_settings.IncludeVersion3;
IsPreScreen:=Scoring_Project_PIP.User_Settings_Module.RV_Scores_V3_BATCH_Generic_settings.IsPreScreen;

	HistoryDate := 999999;

// string DataRestrictionMask  := '10000100010001 '; // to restrict fares, experian, transunion and experian FCRA

//**********************************

//==================  input file layout  ========================
layout_input := RECORD
    Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
END;

f1 := IF(no_of_records <= 0, dataset( infile_name, layout_input, thor),
                            CHOOSEN(DATASET( infile_name, layout_input, thor), no_of_records));

ds_input := distribute(f1, hash64(accountnumber));


// FCRA service settings
// fcraroxieIP := riskwise.shortcuts.staging_fcra_roxieip ;


layout_soap_input := RECORD
	DATASET(Risk_Indicators.Layout_Batch_In) batch_in;
	DATASET(Risk_Indicators.Layout_Gateways_In) gateways;
	STRING DataRestrictionMask;
	boolean IncludeVersion3;
	boolean IncludeAllScores;
	BOOLEAN IsPreScreen;	
	integer Flagshipversion;
END;

Risk_Indicators.Layout_Batch_In make_batch_in(ds_input le, integer c) := TRANSFORM
	self.seq := c;
	SELF.acctno := (string)le.accountnumber;
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
	self.historydateyyyymm := HistoryDate;
	SELF := le;
	SELF := [];
END;

layout_soap_input make_rv_in(ds_input le, integer c) := TRANSFORM
	batch := PROJECT(le, make_batch_in(LEFT, c));
	SELF.batch_in := batch;
	SELF.gateways := DATASET([{isFCRA, neutralroxieIP}], risk_indicators.layout_gateways_in);
	SELF.IsPreScreen := IsPreScreen;		
	self.IncludeVersion3 := IncludeVersion3;
	self.IncludeAllScores := true;
	SELF.DataRestrictionMask := DRM;
	SELF.FlagshipVersion := 3;  // as Brenton suggested we are using version3 model 
END;
	
soap_in := PROJECT(ds_input, make_rv_in(LEFT, counter));
// OUTPUT(CHOOSEN(soap_in, eyeball), NAMED('soap_in'));

roxie_out_layout := RECORD
	STRING30 AccountNumber;
	unsigned6 did := 0;
	models.Layout_RiskView_Batch_Out;
	string200 errorcode;
END;
       
roxie_out_layout myfail(soap_in L) := transform
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	self.acctno := l.batch_in[1].acctno;
	self := [];
end;

resu := soapcall(soap_in, fcraroxieIP ,
										'models.RiskView_Batch_Service', 
										{soap_in},
                    dataset(roxie_out_layout), 
										RETRY(retry), TIMEOUT(timeout),
										parallel(threads) ,
										onfail(myfail(LEFT)));

// output(choosen(resu, eyeball), named('soap_results'));
errors := resu(errorcode<>'');
// output(choosen(errors, eyeball), named('errors'));
// op2 := output(count(errors), named('rv_batch30_score_error_count'));

just_rv_scores_v3 := 


 
 RECORD
	STRING30 acctNo;
	string3 RV_score_auto;
	string3 RV_auto_reason;
	string3 RV_auto_reason2;
	string3 RV_auto_reason3;
	string3 RV_auto_reason4;
	string3 RV_score_bank;
	string3 RV_bank_reason;
	string3 RV_bank_reason2;
	string3 RV_bank_reason3;
	string3 RV_bank_reason4;
	string3 RV_score_retail;
	string3 RV_retail_reason;
	string3 RV_retail_reason2;
	string3 RV_retail_reason3;
	string3 RV_retail_reason4;
	string3 RV_score_telecom;
	string3 RV_telecom_reason;
	string3 RV_telecom_reason2;
	string3 RV_telecom_reason3;
	string3 RV_telecom_reason4;
	string3 RV_score_money;
	string3 RV_money_reason;
	string3 RV_money_reason2;
	string3 RV_money_reason3;
	string3 RV_money_reason4;
	string3 RV_score_prescreen;
	string3 RV_prescreen_reason;

  string200 errorcode;
 END;



/* rv_scores_v3 := project(resu, 
   	transform(just_rv_scores_v3, 
   	self.acctNo := left.acctno;
   	
   SELF.rv_score_auto :=  left.score1  ;
   SELF.rv_auto_reason :=  left.reason1  ;
   SELF.rv_auto_reason2 :=  left.reason2  ;
   SELF.rv_auto_reason3 :=  left.reason3  ;
   SELF.rv_auto_reason4 :=  left.reason4  ;
   SELF.rv_score_bank :=  left.score2  ;
   SELF.rv_bank_reason :=  left.reason5  ;
   SELF.rv_bank_reason2 :=  left.reason6  ;
   SELF.rv_bank_reason3 :=  left.reason7  ;
   SELF.rv_bank_reason4 :=  left.reason8  ;
   SELF.rv_score_retail :=  left.score3  ;
   SELF.rv_retail_reason :=  left.reason9  ;
   SELF.rv_retail_reason2 :=  left.reason10  ;
   SELF.rv_retail_reason3 :=  left.reason11  ;
   SELF.rv_retail_reason4 :=  left.reason12  ;
   SELF.rv_score_telecom :=  left.score4  ;
   SELF.rv_telecom_reason :=  left.reason13  ;
   SELF.rv_telecom_reason2 :=  left.reason14  ;
   SELF.rv_telecom_reason3 :=  left.reason15  ;
   SELF.rv_telecom_reason4 :=  left.reason16  ;
   SELF.rv_score_money :=  left.score5  ;
   SELF.rv_money_reason :=  left.reason17  ;
   SELF.rv_money_reason2 :=  left.reason18  ;
   SELF.rv_money_reason3 :=  left.reason19  ;
   SELF.rv_money_reason4 :=  left.reason20  ;
   SELF.RV_score_prescreen :='';
   SELF.RV_prescreen_reason :='';
   
   self := left;
   		));			
   		
*/
		
/* 		ox := RECORD
   	recordof(just_rv_scores_v3);
   	#if(include_internal_extras)
   		RiskProcessing.layout_internal_extras;
   	#end
   
   END;
*/

			//GLOBAL OUTPUT LAYOUT
Global_output_lay:= RECORD	 
Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_Generic_allflagships_V3_Global_Layout;			 
END;



 Global_output_lay normit(resu L, soap_in R) := transform
   	SELF.Acctno :=(string) R.batch_in[1].acctno;
   	
   	#if(include_internal_extras)
   		self.DID := l.did; 
   		self.historydate := (string) R.batch_in[1].HistoryDateYYYYMM;
   		self.FNamePop :=  R.batch_in[1].Name_First<>'';
   		self.LNamePop :=  R.batch_in[1].Name_Last<>'';
   		self.AddrPop :=  R.batch_in[1].street_addr<>'';
   		self.SSNLength := (string)(length(trim( R.batch_in[1].ssn,left,right))) ;
   		self.DOBPop :=  R.batch_in[1].dob<>'';
   		// self.EmailPop := r.email<>'';
   		self.IPAddrPop :=  R.batch_in[1].ip_addr<>'';
   		self.HPhnPop :=  R.batch_in[1].Home_Phone<>'';
   	#end;
   
SELF.rv_score_auto :=  L.score1  ;
SELF.rv_auto_reason :=  L.reason1  ;
SELF.rv_auto_reason2 :=  L.reason2  ;
SELF.rv_auto_reason3 :=  L.reason3  ;
SELF.rv_auto_reason4 :=  L.reason4  ;
SELF.rv_score_bank :=  L.score2  ;
SELF.rv_bank_reason :=  L.reason5  ;
SELF.rv_bank_reason2 :=  L.reason6  ;
SELF.rv_bank_reason3 :=  L.reason7  ;
SELF.rv_bank_reason4 :=  L.reason8  ;
SELF.rv_score_retail :=  L.score3  ;
SELF.rv_retail_reason :=  L.reason9  ;
SELF.rv_retail_reason2 :=  L.reason10  ;
SELF.rv_retail_reason3 :=  L.reason11  ;
SELF.rv_retail_reason4 :=  L.reason12  ;
SELF.rv_score_telecom :=  L.score4  ;
SELF.rv_telecom_reason :=  L.reason13  ;
SELF.rv_telecom_reason2 :=  L.reason14  ;
SELF.rv_telecom_reason3 :=  L.reason15  ;
SELF.rv_telecom_reason4 :=  L.reason16  ;
SELF.rv_score_money :=  L.score5  ;
SELF.rv_money_reason :=  L.reason17  ;
SELF.rv_money_reason2 :=  L.reason18  ;
SELF.rv_money_reason3 :=  L.reason19  ;
SELF.rv_money_reason4 :=  L.reason20  ;
SELF.RV_score_prescreen :='';
SELF.RV_prescreen_reason :='';

   	self := L;
   self := [];
   end;
   
   j_f := JOIN(resu,soap_in,LEFT.Acctno=(string)RIGHT.batch_in[1].acctno,normit(LEFT,RIGHT));


op_final := output(j_f ,,outfile_name,thor, compressed,overwrite);

return op_final ;
endmacro; 	 