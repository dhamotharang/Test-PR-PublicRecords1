EXPORT Chase_PIO2_BATCH_Macro (roxie_ip,Gateway_dummy, Thread, Timeout, Retry, Input_file_name,Output_file_name, records_ToRun):= functionmacro

IMPORT Models, Risk_Indicators, RiskWise, UT;
/* ********************************************************************
 *                               OPTIONS                              *
 **********************************************************************
 * recordsToRun: Number of records to run through the service. Set to *
 *    0 to run all.                                                   *
 * threads: Number of parallel threads to run. Set to 1 - 30.         *
 * isFCRA: Set to TRUE for the FCRA product, FALSE for non-FCRA.      *
 * fcraRoxie: IP Address of the FCRA roxie.                           *
 * roxieIP: IP Address of the non-FCRA roxie.                         *
 **********************************************************************/
unsigned8 no_of_records := records_ToRun;
unsigned1 eyeball := 10;
integer retry := retry;
integer timeout := timeout;
integer threads := Thread;

String roxieIP := roxie_ip ; 
gateways := Gateway;
String Infile_name :=  Input_file_name;
String outfile_name :=  Output_file_name ;
fcraroxie := riskwise.shortcuts.staging_fcra_roxieIP; 

// gateways := Gateway;
Gateway := DATASET([], Gateway.Layouts.Config);

include_internal_extras:=true;

//*********custom settings**********

DPPA:=Scoring_Project_PIP.User_Settings_Module.PRIO_Scores_BATCH_Chase_PIO2_settings.DPPA;
GLB:=Scoring_Project_PIP.User_Settings_Module.PRIO_Scores_BATCH_Chase_PIO2_settings.GLB;
DRM:=Scoring_Project_PIP.User_Settings_Module.PRIO_Scores_BATCH_Chase_PIO2_settings.DRM;

	// unsigned1	DPPAPurpose:= 3;//CHANGED FROM '' TO 3 
  // unsigned1	GLBPurpose:= 1;//CHANGED FROM '' TO 1
	// STRING DataRestrictionMask := '';
	// UNSIGNED1 BSversion := 41;
	// boolean isFCRA := false;
	HistoryDate := 999999;

//**********************************

/* **************************************
 *         MAIN SCRIPT CODE             *
 ****************************************/
layout_input := RECORD
    Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
END;
	


f1 := IF(no_of_records <= 0, dataset( infile_name, layout_input, thor), 
CHOOSEN(DATASET( infile_name, layout_input,  thor), no_of_records));

f := f1;  

// output(CHOOSEN(f, eyeball), NAMED('Sample_Raw_Input'));
// output(count(f), NAMED('Number_Of_Records_On_Input'));


//mapping

layout_soap_input := RECORD
  string tribcode := '';	
	DATASET(RiskWise.Layout_PB1O_BatchIn) batch_in;
	unsigned1	DPPAPurpose:= '';
  unsigned1	GLBPurpose:= '';
	STRING DataRestrictionMask := '';
	integer	HistoryDateyyyymm := '';
	string Gateways := '';
	end;
	
sghatti.Layout_PB1O_BatchIn make_batch_in(f le, integer c) := transform
	  // !! replace the tribcode here !!
  SELF.acctno :=(string) le.accountnumber;	
	
	SELF.name_first := le.firstname;
	SELF.name_last := le.lastname;
	SELF.street_addr := le.streetaddress;
	SELF.p_city_name:= le.city;
	SELF.st := le.state;
	SELF.z5 := le.zip;
	SELF.home_phone := le.homephone;
	SELF.ssn := le.ssn;
	SELF.DOB := le.dateofbirth;
  self.HistoryDateYYYYMM := HistoryDate;
	self := le;
	self := [];
end;

layout_soap_input make_Chase_in(f le, integer c) := TRANSFORM
	batch := PROJECT(le, make_batch_in(LEFT, c));
	SELF.batch_in := batch;
	SELF.tribcode := 'pi02';
	SELF.DPPAPurpose := DPPA;
	SELF.GLBPurpose := GLB;
	// SELF.DataRestrictionMask := Risk_Indicators.iid_constants.default_DataRestriction;
	SELF.DataRestrictionMask := DRM;
	SELF.HistoryDateYYYYMM := HistoryDate;
END;

soap_in := DISTRIBUTE(project(f,make_Chase_in(LEFT, counter)), random());
// output(soap_in, named('Sample_soap_in'));



// ip := if(isFCRA, fcraRoxie, roxieIP);

// xlayout := RECORD
  // Riskwise.Layout_PRIO;
	// STRING errorcode;
// END;

//GLOBAL OUTPUT LAYOUT
Global_output_lay:= RECORD	 
Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_Chase_PIO2_Global_Layout;			 
END;

Global_output_lay myFail(soap_in l) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	self.acctno := l.batch_in[1].acctno;
	SELF := [];
END;

s := SOAPCALL(soap_in, roxieIP,
				'RiskWise.PRIO_Batch_Service', {soap_in}, 
				DATASET(Global_output_lay),
        RETRY(retry), TIMEOUT(timeout),
        PARALLEL(threads), onFail(myFail(LEFT)));


    
      Risk_Indicators.layout_input into_did_input(f le) := TRANSFORM
      	SELF.seq := (integer)le.accountnumber;
      	SELF.fname := le.firstname;
      	SELF.mname := le.middlename;
      	SELF.lname := le.lastname;
      	SELF.in_streetAddress := le.streetaddress;
      	SELF.in_city := le.city;
      	SELF.in_state := le.state;
      	SELF.in_zipCode := le.zip;
      	SELF.phone10 := le.homephone;
      	SELF.ssn := le.ssn;
      	SELF.dob := le.dateofbirth;
      	SELF.wphone10 := le.workphone;
      	// SELF. := le.Income;
      	SELF.dl_number := le.dlnumber;
      	SELF.dl_state := le.dlstate;
      	// SELF. := le.Balance;
      	// SELF. := le.ChargeOffDate;
      	// SELF. := le.FomerLast;
      	SELF.email_address := le.email;
      	SELF.employer_name := le.company;
      	// SELF. := le.HistoryDateYYYYMM;
      	
      	SELF := [];
      END;
      
    		did_results:=Scoring_Project_Macros.IID_macro(f1,threads,roxieIP,DPPA,GLB,DRM,HistoryDate); 
      
      							
      // fin_layout := record
      // recordof(s);
      // unsigned6 did;
      // end;
      
      Global_output_lay xform(did_results l, s r) := TRANSFORM
      self.did := l.did;
      self := r;
      end;
      
      res := JOIN(did_results, s, left.acctno = right.acctno, xform(left, right),right outer);
 
      // final_layout := record
      // recordof(res);
      	// #if(include_internal_extras)
      		// RiskProcessing.layout_internal_extras;
      	// #end	
      // end;	
      
      
      Global_output_lay xform1(res l, soap_in r) := TRANSFORM
      	#if(include_internal_extras)
      		                  self.DID := l.did; 
                            self.historydate := (string)r.batch_in[1].HistoryDateYYYYMM;
				                    self.FNamePop := r.batch_in[1].Name_First<>'';
			                     	self.LNamePop := r.batch_in[1].Name_Last<>'';
				                    self.AddrPop := r.batch_in[1].street_addr<>'';
			                    	self.SSNLength := (string)(length(trim(r.batch_in[1].ssn,left,right))) ;
			                    	self.DOBPop := r.batch_in[1].dob<>'';
	                      			self.EmailPop := r.batch_in[1].email<>'';
			                     	self.IPAddrPop := r.batch_in[1].ip_addr<>''; 
			                    	self.HPhnPop := r.batch_in[1].Home_Phone<>'';
      	#end;
      	self := l;
      	self := [];
      	
      	end;
      	
      	final_output:=join(res,soap_in,left.acctno=(string)right.batch_in[1].acctno ,xform1(left, right));	


op_final := output(final_output,, outfile_name, thor, compressed,OVERWRITE);

return op_final;
endmacro;