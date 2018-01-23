EXPORT Chase_PIO2_XML_Macro (roxie_ip,Gateway_dummy, Thread, Timeout, Retry, Input_file_name,Output_file_name, records_ToRun):= functionmacro

IMPORT Models, Risk_Indicators, RiskWise, Scoring, UT;
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
// gateways := Gateway;
Gateway := DATASET([], Gateway.Layouts.Config);
String Infile_name :=  Input_file_name;
String outfile_name :=  Output_file_name ;



fcraRoxie  := riskwise.shortcuts.staging_fcra_roxieIP; 

//*********custom settings**********

DPPA:=Scoring_Project_PIP.User_Settings_Module.PRIO_Scores_XML_Chase_PIO2_settings.DPPA;
GLB:=Scoring_Project_PIP.User_Settings_Module.PRIO_Scores_XML_Chase_PIO2_settings.GLB;


	// unsigned1	DPPAPurpose:= 3;//CHANGED FROM '' TO 3 
  // unsigned1	GLBPurpose:= 1;//CHANGED FROM '' TO 1
	STRING DataRestrictionMask := '';
	// UNSIGNED1 BSversion := 41;
	
	isFCRA :=Scoring_Project_PIP.User_Settings_Module.PRIO_Scores_XML_Chase_PIO2_settings.isFCRA;
	HistoryDate := 999999;

//*********************************

include_internal_extras:=true;

/* **************************************
 *         MAIN SCRIPT CODE             *
 ****************************************/
layout_input := RECORD
    Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
END;
	


f := IF(no_of_records <= 0, dataset( infile_name, layout_input, thor), CHOOSEN(DATASET( infile_name, layout_input, thor), no_of_records));

// output(CHOOSEN(f, eyeball), NAMED('Sample_Raw_Input'));
// output(count(f), NAMED('Number_Of_Records_On_Input'));


//mapping
sghatti.Layout_PRIO_Soapcall into_PRIO_input(f le) := transform
 	self.acctno := (string)le.accountnumber;
	self.account := (string)le.accountnumber;
	self.tribcode := 'pi02';  // !! replace the tribcode here !!
//	self.HistoryDateYYYYMM :='200607';
//	self.run_Seed:=false ;

	
	SELF.first := le.firstname;
	SELF.last := le.lastname;
	SELF.addr := le.streetaddress;
	SELF.city:= le.city;
	SELF.state := le.state;
	SELF.zip := le.zip;
	SELF.hphone := le.homephone;
	SELF.socs := le.ssn;
	SELF.dob := le.dateofbirth;
	self.HistoryDateYYYYMM := HistoryDate;
	self.dppapurpose := DPPA;
	self.glbpurpose := GLB;
	self := le;
	self := [];
end;

soap_in := DISTRIBUTE(project(f,into_PRIO_input(LEFT)), RANDOM());
// output(CHOOSEN(soap_in,eyeball), named('Sample_soap_in'));

serviceName := if(isFCRA, 'RiskWiseFCRA.RiskWiseMainPRIO', 'RiskWise.RiskWiseMainPRIO');
ip := if(isFCRA, fcraRoxie, roxieIP);

// xlayout := RECORD
  // Riskwise.Layout_PRIO;
	// STRING errorcode;
// END;
//GLOBAL OUTPUT LAYOUT
Global_output_lay:= RECORD	 
Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_Chase_PIO2_Global_Layout;			 
END;


Global_output_lay myFail(soap_in le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	self.acctno:=le.account;
	SELF := le;
	SELF := [];
END;

s_o := SOAPCALL(soap_in, ip,
				serviceName, {soap_in}, 
				DATASET(Global_output_lay),
        RETRY(retry), TIMEOUT(timeout), LITERAL,
        XPATH(serviceName + 'Response/Results/Result/Dataset[@name=\'Results\']/Row'),
				PARALLEL(threads), onFail(myFail(LEFT)));

// output(CHOOSEN(s, eyeball), named('Sample_results'));

//output(s,, outputFile, thor), overwrite);
//output(s(errorcode<>''),, outputFile + '_error', thor), overwrite);

s := project(s_o, transform(recordof(s_o),
             self.acctno := left.account,
						 self := left));
						 
						 
 
      
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
      
      
  did_results:=Scoring_Project_Macros.IID_macro(f,threads,roxieIP,DPPA,GLB,DataRestrictionMask,HistoryDate); 
      
      							
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
      		self.historydate := (string)r.HistoryDateYYYYMM;
      		self.FNamePop := r.first<>'';
      		self.LNamePop := r.last<>'';
      		self.AddrPop := r.addr<>'';
      		self.SSNLength := (string)(length(trim(r.socs,left,right))) ;
      		self.DOBPop := r.dob<>'';
      		self.EmailPop := r.email<>'';
      		// self.IPAddrPop := r.ipaddress<>'';
      		self.HPhnPop := r.hphone<>'';
      	#end;
      	self := l;
      	self := [];
      	
      	end;
      	
      	final_output:=join(res,soap_in,left.acctno=(string)right.acctno ,xform1(left, right));	
   


						 
op_final := output(final_output,, outfile_name, thor,compressed, OVERWRITE);


return op_final;

endmacro;