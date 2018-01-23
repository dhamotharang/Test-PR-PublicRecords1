EXPORT CapitalOne_RVAttributes_V2_Macro (fcraroxie_IP,neutralroxie_IP, Thread, Timeout, Retry, Input_file_name,Output_file_name, records_ToRun):= functionmacro

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

archive_date := (integer) ut.getdate ;

// string DataRestrictionMask  := '10000100010001 '; // to restrict fares, experian, transunion and experian FCRA

//*********custom settings**********

DRM:=Scoring_Project_PIP.User_Settings_Module.RV_Attributes_V2_BATCH_CapOne_settings.DRM;

IsPreScreen:=Scoring_Project_PIP.User_Settings_Module.RV_Attributes_V2_BATCH_CapOne_settings.IsPreScreen;

IncludeVersion2:=Scoring_Project_PIP.User_Settings_Module.RV_Attributes_V2_BATCH_CapOne_settings.IncludeVersion2;

isFCRA:=if(Scoring_Project_PIP.User_Settings_Module.RV_Attributes_V2_BATCH_CapOne_settings.isFCRA=true,'FCRA','NONFCRA');

HistoryDate := 999999;

//***********************************

//==================  input file layout  ========================


layout_input :=Record
                Scoring_Project_Macros.Regression.global_layout;
                Scoring_Project_Macros.Regression.pii_layout;
                Scoring_Project_Macros.Regression.runtime_layout;
End;




f1 := IF(no_of_records <= 0, dataset( infile_name, layout_input, thor),
                            CHOOSEN(DATASET( infile_name, layout_input,thor), no_of_records));



ds_input := distribute(f1, hash64(AccountNumber));


layout_soap_input := RECORD
	DATASET(Risk_Indicators.Layout_Batch_In) batch_in;
	DATASET(Risk_Indicators.Layout_Gateways_In) gateways;
	STRING DataRestrictionMask;
	boolean IncludeVersion2;
	BOOLEAN IsPreScreen;	
END;

Risk_Indicators.Layout_Batch_In make_batch_in(ds_input le, integer c) := TRANSFORM
	self.seq := le.AccountNumber;
	SELF.acctno := (string)le.AccountNumber;
	SELF.Name_First := le.FirstName;
	SELF.Name_Middle := le.MiddleName;
	SELF.Name_Last := le.LastName;
	SELF.street_addr := le.StreetAddress;
	SELF.p_City_name := le.City;
	SELF.St := le.State;
	SELF.z5 := le.Zip;
	// SELF.Home_Phone := le.HomePhone;
	SELF.SSN := le.SSN;
	// SELF.DOB := le.DateOfBirth;
	// SELF.Work_Phone := le.WorkPhone;
	self.historydateyyyymm := HistoryDate;//le.historydateyyyymm ;
	SELF := le;
	SELF := [];
END;

layout_soap_input make_rv_in(ds_input le, integer c) := TRANSFORM
	batch := PROJECT(le, make_batch_in(LEFT, c));
	SELF.batch_in := batch;
	SELF.gateways := DATASET([{isFCRA, neutralroxieIP}], risk_indicators.layout_gateways_in);
	SELF.IsPreScreen := IsPreScreen;		
	self.IncludeVersion2 := IncludeVersion2;
	SELF.DataRestrictionMask := DRM;
END;
	
soap_in := DISTRIBUTE(PROJECT(ds_input, make_rv_in(LEFT, counter)), RANDOM());
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

soap_results := soapcall(soap_in, fcraroxieIP ,
										'models.RiskView_Batch_Service', 
										{soap_in},
                    dataset(roxie_out_layout), 
										RETRY(retry), TIMEOUT(timeout),
										parallel(threads) ,
										onfail(myfail(LEFT)));

// output(choosen(soap_results, eyeball), named('soap_results'));
errors := soap_results(errorcode<>'');
// output(choosen(errors, eyeball), named('batch20_errors'));
// output(count(errors), named('batch20_error_count'));


			//GLOBAL OUTPUT LAYOUT
Global_output_lay:= RECORD	 
Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_BATCH_Capitalone_Attributes_V2_Global_Layout;			 
END;

rv_attributes_v2 := project(soap_results, 
	transform(Global_output_lay, 
		self.accountnumber := left.acctno;
		self.history_date := (string6)archive_date;
		self.DID := (integer)left.did; 
		self := left;
		self:=[];
		));	
		
		
// final_layout := record
// recordof(rv_attributes_v2);
	// #if(include_internal_extras)
		// RiskProcessing.layout_internal_extras;
	// #end	
// end;	


Global_output_lay xform1(rv_attributes_v2 l, soap_in r) := TRANSFORM
	#if(include_internal_extras)
		                        self.DID := l.did; 
		                        self.historydate := (string)r.batch_in[1].HistoryDateYYYYMM;
				                    self.FNamePop := r.batch_in[1].Name_First<>'';
			                     	self.LNamePop := r.batch_in[1].Name_Last<>'';
				                    self.AddrPop := r.batch_in[1].street_addr<>'';
			                    	self.SSNLength := (string)(length(trim(r.batch_in[1].ssn,left,right))) ;
			                    	self.DOBPop := r.batch_in[1].dob<>'';
	                      			// self.EmailPop := right.batch_in[1].email<>'';
			                     	self.IPAddrPop := r.batch_in[1].ip_addr<>''; 
			                    	self.HPhnPop := r.batch_in[1].Home_Phone<>'';
	#end;
	self := l;
	self := [];
	
	end;

	final_output:=join(rv_attributes_v2,soap_in,left.accountnumber=(string)right.batch_in[1].acctno ,xform1(left, right));
	
op_final := output(final_output ,,outfile_name,thor, compressed,overwrite);


return op_final;

endmacro;