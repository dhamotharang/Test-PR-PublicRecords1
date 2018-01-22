
// #workunit('name','Business IID Batch');
// #option ('hthorMemoryLimit', 1000);

EXPORT Business_Instant_Id_Batch_Macro (roxie_ip,Gateway_dummy, Thread, Timeout, Retry, Input_file_name,Output_file_name, records_ToRun):= functionmacro


import models, Risk_Indicators, Business_Risk, ut, riskwise;

/* *****************************************************
 *                   Options Section                   *
 *******************************************************/
unsigned8 no_of_records := records_ToRun;
unsigned1 eyeball := 10;
integer retry := retry;
integer timeout := timeout;
integer threads := Thread;

String roxieIP := roxie_ip ; 
// gateways := Gateway;
String Infile_name :=  Input_file_name;
String outfile_name :=  Output_file_name ;

// gateways := Gateway;
Gateway := DATASET([], Gateway.Layouts.Config);

include_internal_extras:=true;

//***********custom settings**************************

	DPPA:= scoring_project_pip.User_Settings_Module.BIID_BATCH_Generic_settings.DPPA;//CHANGED FROM '' TO 3 
  GLB:= scoring_project_pip.User_Settings_Module.BIID_BATCH_Generic_settings.GLB;//CHANGED FROM '' TO 1

	
	// unsigned1	DPPAPurpose:= 3;//CHANGED FROM '' TO 3 
  // unsigned1	GLBPurpose:= 1;//CHANGED FROM '' TO 1
	STRING DataRestrictionMask := '';
	// UNSIGNED1 BSversion := 41;
	// boolean isFCRA := false;	
	
	HistoryDate := 999999;
	
	//***************************************************

//****************************************************

/* *****************************************************
 *                      Main Script                    *
 *******************************************************/
/* layout:= record
   	string	AccountNumber	;
   	string	CompanyName	;
   	string	AlternateCompanyName	;
   	string	addr	;
   	string	city	;
   	string	state	;
   	string	zip	;
   	string	BusinessPhone	;
   	string	TaxIdNumber	;
   	string	BusinessIPAddress ;
   	string	RepresentativeFirstName	;
   	string	RepresentativeMiddleName ;
   	string	RepresentativeLastName	;
   	string	RepresentativeNameSuffix  ;
   	string	RepresentativeAddr	;
   	string	RepresentativeCity	;
   	string	RepresentativeState	;
   	string	RepresentativeZip	;
   	string	RepresentativeSSN	;
   	string	RepresentativeDOB	;
   	string  RepresentativeAge   ;
   	string	RepresentativeDLNumber	;
   	string	RepresentativeDLState	;
   	string	RepresentativeHomePhone	;
   	string	RepresentativeEmailAddress	;
   	string  RepresentativeFormerLastName ;
   	integer	HistoryDateYYYYMM;
   end;
*/

								
								
 layout:=Record
                Scoring_Project_Macros.Regression.global_layout;
                Scoring_Project_Macros.Regression.pii_layout;
                Scoring_Project_Macros.Regression.bus_layout;
                Scoring_Project_Macros.Regression.runtime_layout;
End;


								
f1 := IF(no_of_records = 0, 
                DATASET(Infile_name, Layout, thor),
                CHOOSEN(DATASET(Infile_name, Layout, thor), no_of_records));
f := f1;



layout_soap_input := RECORD
	DATASET(Business_Risk.Layout_Input_Moxie_2) batch_in;
	STRING dppapurpose;
	String GLBPurpose;
END;

Business_Risk.Layout_Input_Moxie_2 make_batch_in(f le, integer c) := TRANSFORM
self.acctno :=(string) le.AccountNumber;
self.name_company := le.name_company;
self.street_addr := le.street_addr2;
self.p_city_name := le.p_city_name_2;
self.st := le.st_2;
self.z5 := le.z5_2;
self.phoneno := le.phoneno;
self.fein := le.fein;
self.name_first := le.firstname;
self.name_last := le.lastname;
self.street_addr2 := le.streetaddress;
self.p_city_name_2 := le.city;
self.st_2 := le.state;
self.z5_2 := le.zip;
self.ssn := le.ssn;
self.dob := le.dateofbirth;
self.phone_2 := le.homephone;
self.HistoryDateYYYYMM := HistoryDate;
self := le;
self := [];
end;

layout_soap_input make_rv_in(f le, integer c) := TRANSFORM
	batch := PROJECT(le, make_batch_in(LEFT, c));
	SELF.batch_in := batch;
	self.dppapurpose :=(string)DPPA;
	self.GLBPurpose := (string)GLB;
	END;

indata := DISTRIBUTE(PROJECT(F, make_rv_in(LEFT, counter)), Random());
// output(indata, named('biid_in'));

errx := record
	string errorcode := '';
	business_risk.Layout_Final_Denorm - score - RepSSNValid - Attributes - BusRiskIndicators - RepRiskIndicators;  // requested to take the score field out of the layout during testprocessing because batch customers don't see it
	DATASET(Models.Layout_Model) models;
end;

errx err_out(indata L) := transform
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	self.account:=l.batch_in[1].acctno;
	self := L;
	self := [];
end;



results := soapcall(indata, roxieIP,
				'Business_Risk.InstantID_Batch_Service', {indata},
				dataset(errx), RETRY(retry), TIMEOUT(timeout),
				PARALLEL(threads), onfail(err_out(LEFT)));

//GLOBAL OUTPUT LAYOUT
Global_output_lay:= RECORD	 
Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_BusinessInstantId_Global_Layout;			 
END;


NewRecs := PROJECT(results,TRANSFORM(Global_output_lay,self.bnap:=left.bnap_indicator;
                                             self.bnas:=left.bnas_indicator;
																						 self.bnat:=left.bnat_indicator;
																						 self.acctno:=left.account;
																						 SELF :=LEFT;
																						 SELF :=[];
																						 ));

   
			
			did_results:=Scoring_Project_Macros.IID_macro(f,threads,roxieIP,DPPA,GLB,DataRestrictionMask,HistoryDate);  
         
    							 
         
         Global_output_lay xform(did_results l, NewRecs r) := TRANSFORM
         self.did := l.did;
         self := r;
         end;
         
         res := JOIN(did_results, NewRecs, left.acctno = right.acctno, xform(left, right),right outer);
         
   
         
         Global_output_lay xform1(res l, indata r) := TRANSFORM
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
			                    	self.HPhnPop := r.batch_in[1].phone_2<>'';
                           	#end;
         	self := l;
         	self := [];
         	
         	end;
         	
         	final_output:=join(res,indata,left.acctno=(string)right.batch_in[1].acctno ,xform1(left, right));


// output(results, named('biid_results'));
op_final := output(final_output,, outfile_name, thor,compressed, OVERWRITE);



return op_final;

endmacro;