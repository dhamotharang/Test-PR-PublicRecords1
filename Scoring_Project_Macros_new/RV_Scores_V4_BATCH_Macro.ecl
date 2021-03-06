EXPORT RV_Scores_V4_BATCH_Macro (fcraroxie_IP,neutralroxie_IP, Thread, Timeout, Retry, Input_file_name,Output_file_name, records_ToRun):= functionmacro


IMPORT Models, iESP, Risk_Indicators, RiskWise, RiskProcessing, UT;

unsigned8 no_of_records := records_ToRun;
integer eyeball := 50;
integer retry := retry;
integer timeout := timeout;
integer threads := Thread;

String neutralroxieIP := neutralroxie_IP ; 
String fcraroxieIP := fcraroxie_IP ;

Infile_name :=  Input_file_name;

String outfile_name :=  Output_file_name ;


include_internal_extras := true;

//Note:  This uses RiskView Batch Service instead or our customary RV 2.0 code
//       This matches what Cap One uses

archive_date := (integer) ut.getdate ;
// today         := ut.GetDate[3..];

string DataRestrictionMask  := '10000100010001 '; // to restrict fares, experian, transunion and experian FCRA

//==================  input file layout  ========================
layout_input := RECORD
    Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
END;
 
 
f1 := IF(no_of_records <= 0, dataset(ut.foreign_prod + infile_name, layout_input, CSV(heading(single), quote('"'))),
                            CHOOSEN(DATASET(ut.foreign_prod + infile_name, layout_input, CSV(heading(single), quote('"'))), no_of_records));

ds_input := distribute(f1, hash64(accountnumber));


// FCRA service settings
// fcraroxieIP := riskwise.shortcuts.staging_fcra_roxieip ;



layout_soap_input := RECORD
	DATASET(Risk_Indicators.Layout_Batch_In) batch_in;
	DATASET(Risk_Indicators.Layout_Gateways_In) gateways;
	STRING DataRestrictionMask;
	boolean IncludeVersion4;
	boolean IncludeAllScores;
	BOOLEAN IsPreScreen;	
	integer FlagshipVersion;

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
	self.historydateyyyymm := le.historydateyyyymm ;
	SELF := le;
	SELF := [];
END;

layout_soap_input make_rv_in(ds_input le, integer c) := TRANSFORM
	batch := PROJECT(le, make_batch_in(LEFT, c));
	SELF.batch_in := batch;
	SELF.gateways := DATASET([{'FCRA', neutralroxieIP}], risk_indicators.layout_gateways_in);
	SELF.IsPreScreen := false;		
	self.IncludeVersion4 := true;
	self.IncludeAllScores := true;
	SELF.DataRestrictionMask := DataRestrictionMask;
	SELF.FlagshipVersion := 4;
	self := [];
END;
	
soap_in := PROJECT(ds_input, make_rv_in(LEFT, counter));
// OUTPUT(CHOOSEN(soap_in, eyeball), NAMED('soap_in'));

roxie_out_layout := RECORD
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
op2 := output(count(errors), named('rv_batch40_score_error_count'));

just_rv_scores_v4 := 

 RECORD
  
	string30 acctno;
  string3 rv_score_auto;
  string3 rv_auto_reason;
  string3 rv_auto_reason2;
  string3 rv_auto_reason3;
  string3 rv_auto_reason4;
  string3 rv_auto_reason5;
  string3 rv_score_bank;
  string3 rv_bank_reason;
  string3 rv_bank_reason2;
  string3 rv_bank_reason3;
  string3 rv_bank_reason4;
  string3 rv_bank_reason5;
  string3 rv_score_retail;
  string3 rv_retail_reason;
  string3 rv_retail_reason2;
  string3 rv_retail_reason3;
  string3 rv_retail_reason4;
  string3 rv_retail_reason5;
  string3 rv_score_telecom;
  string3 rv_telecom_reason;
  string3 rv_telecom_reason2;
  string3 rv_telecom_reason3;
  string3 rv_telecom_reason4;
  string3 rv_telecom_reason5;
  string3 rv_score_money;
  string3 rv_money_reason;
  string3 rv_money_reason2;
  string3 rv_money_reason3;
  string3 rv_money_reason4;
  string3 rv_money_reason5;
  string3 rv_score_prescreen;
  string3 rv_prescreen_reason;
  string6 historydate;
	
		#if(include_internal_extras)
		RiskProcessing.layout_internal_extras;
	  #end


  string200 errorcode;
 END;

		



rv_scores_v4 := join(resu, ds_input  , 
                     left.acctno = (string)right.accountnumber,
	
	transform(just_rv_scores_v4, 
	  self.acctNo := left.acctno;
	
		SELF.rv_score_auto :=  left.score1  ;
		SELF.rv_auto_reason :=  left.reason1  ;
		SELF.rv_auto_reason2 :=  left.reason2  ;
		SELF.rv_auto_reason3 :=  left.reason3  ;
		SELF.rv_auto_reason4 :=  left.reason4  ;
		SELF.rv_auto_reason5 :=  left.reason21  ;
		SELF.rv_score_bank :=  left.score2  ;
		SELF.rv_bank_reason :=  left.reason5  ;
		SELF.rv_bank_reason2 :=  left.reason6  ;
		SELF.rv_bank_reason3 :=  left.reason7  ;
		SELF.rv_bank_reason4 :=  left.reason8  ;
		SELF.rv_bank_reason5 :=  left.reason22  ;
		SELF.rv_score_retail :=  left.score3  ;
		SELF.rv_retail_reason :=  left.reason9  ;
		SELF.rv_retail_reason2 :=  left.reason10  ;
		SELF.rv_retail_reason3 :=  left.reason11  ;
		SELF.rv_retail_reason4 :=  left.reason12  ;
		SELF.rv_retail_reason5 :=  left.reason23  ;
		SELF.rv_score_telecom :=  left.score4  ;
		SELF.rv_telecom_reason :=  left.reason13  ;
		SELF.rv_telecom_reason2 :=  left.reason14  ;
		SELF.rv_telecom_reason3 :=  left.reason15  ;
		SELF.rv_telecom_reason4 :=  left.reason16  ;
		SELF.rv_telecom_reason5 :=  left.reason24  ;
		SELF.rv_score_money :=  left.score5  ;
		SELF.rv_money_reason :=  left.reason17  ;
		SELF.rv_money_reason2 :=  left.reason18  ;
		SELF.rv_money_reason3 :=  left.reason19  ;
		SELF.rv_money_reason4 :=  left.reason20  ;
		SELF.rv_money_reason5 :=  left.reason25  ;
		SELF.RV_score_prescreen :='';
		SELF.RV_prescreen_reason :='';

		#if(include_internal_extras)
				self.DID := (integer) left.did; 
				self.historydate := (string)right.HistoryDateYYYYMM;
				self.FNamePop := right.firstname<>'';
				self.LNamePop := right.lastname<>'';
				self.AddrPop := right.streetaddress<>'';
				self.SSNLength := (string)(length(trim(right.ssn))) ;
				self.DOBPop := right.dateofbirth<>'';
				self.EmailPop := right.email<>'';
				self.IPAddrPop := false; //we have to check ip_address
				
				self.HPhnPop := right.homephone<>'';
			#end;

  self := left;
		));			





op_final := output(rv_scores_v4 ,,outfile_name,CSV(heading(single), quote('"')), overwrite);

fin_res:= sequential( op_final);

return  fin_res;

endmacro;