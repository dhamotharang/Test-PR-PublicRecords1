 EXPORT Chase_BIID_BATCH_Macro(roxie_ip,Gateway_dummy, Thread, Timeout, Retry, Input_file_name,Output_file_name, records_ToRun):= functionmacro

import models, Risk_Indicators, Business_Risk, ut, riskwise;


IMPORT Models, Risk_Indicators, RiskWise, UT, scoring;

unsigned8 no_of_records := records_ToRun;
unsigned1 eyeball := 10;
integer retry := retry;
integer timeout := timeout;
integer threads := Thread;

String roxieIP := roxie_ip ; 
gateways := Gateway;
String Infile_name :=  Input_file_name;
String outfile_name :=  Output_file_name ;

// gateways := Gateway;
Gateway := DATASET([], Gateway.Layouts.Config);

include_internal_extras:=true;


//*********custom settings**********

DPPA:=Scoring_Project_PIP.User_Settings_Module.BIID_BATCH_Chase_settings.DPPA;
GLB:=Scoring_Project_PIP.User_Settings_Module.BIID_BATCH_Chase_settings.GLB;

	// unsigned1	DPPAPurpose:= 3;//CHANGED FROM '' TO 3 
  // unsigned1	GLBPurpose:= 1;//CHANGED FROM '' TO 1
	STRING DataRestrictionMask := '';
	// UNSIGNED1 BSversion := 41;
	// boolean isFCRA := false;
	HistoryDate := 999999;
	
//**********************************

/* *****************************************************
 *                      Main Script                    *
 *******************************************************/
 
 layout:=Record
                Scoring_Project_Macros.Regression.global_layout;
                Scoring_Project_Macros.Regression.pii_layout;
                Scoring_Project_Macros.Regression.bus_layout;
                Scoring_Project_Macros.Regression.runtime_layout;
End;


								
f1 := IF(no_of_records = 0, 
                DATASET(Infile_name, Layout, thor),
                CHOOSEN(DATASET(Infile_name, Layout, thor), no_of_records));

								
f := DISTRIBUTE(f1, RANDOM());
//f := f1 (AccountNumber = '6'); //Use to test single customer number
// output(f);





layout_soap_input := RECORD
					DATASET(Business_Risk.Layout_Input_Moxie_2) batch_in;
					boolean hb := false;
					integer glb;
					integer dppa;
					boolean IncludeFraudScores := true;
					boolean IsPOBoxCompliant := false;
					boolean ofac_only := false;
					boolean ExcludeWatchLists := false;
					unsigned1 OFAC_version :=2;
					boolean Include_Additional_watchlists := true;
					boolean Include_Ofac := true;
					real Global_WatchList_Threshold :=.84;
					boolean use_dob_filter := FALSE;
					integer2 dob_radius := 2;
					string  model_name_value := '';
					boolean IncludeTargus3220 := true ;
					boolean IncludeMSoverride:= FALSE;
					boolean IncludeDLVerification:= FALSE;
					string AttributesVersionRequest:= 'BIIDATTRIBUTESV1';
					boolean Include_ALL_Watchlist:= FALSE;
					boolean Include_BES_Watchlist:= FALSE;
					boolean Include_CFTC_Watchlist:= FALSE;
					boolean Include_DTC_Watchlist:= FALSE;
					boolean Include_EUDT_Watchlist:= FALSE;
					boolean Include_FBI_Watchlist:= FALSE;
					boolean Include_FCEN_Watchlist:= FALSE;
					boolean Include_FAR_Watchlist:= FALSE;
					boolean Include_IMW_Watchlist:= FALSE;
					boolean Include_OFAC_Watchlist:= FALSE;
					boolean Include_OCC_Watchlist:= FALSE;
					boolean Include_OSFI_Watchlist:= FALSE;
					boolean Include_PEP_Watchlist:= FALSE;
					boolean Include_SDT_Watchlist:= FALSE;
					boolean Include_BIS_Watchlist:= FALSE;
					boolean Include_UNNT_Watchlist:= FALSE;
					boolean Include_WBIF_Watchlist:= FALSE;

END;

Business_Risk.Layout_Input_Moxie_2 make_batch_in(f le, integer c) := TRANSFORM
self.acctno := (string)le.accountnumber;
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
	self.dppa := (integer)DPPA;
	self.glb := (integer)GLB;
	self.includefraudscores := true;
END;

indata := DISTRIBUTE(PROJECT(F, make_rv_in(LEFT, counter)), Random());
// output(indata, named('biid_in'));

// CHASE BIID Fraud scores and attributes added bugzilla 182843
errx := record
	string errorcode := '';
	// business_risk.Layout_Final_Denorm - score - RepSSNValid - Attributes - BusRiskIndicators - RepRiskIndicators;  // requested to take the score field out of the layout during testprocessing because batch customers don't see it
	business_risk.Layout_Final_Denorm; 
		string3 fd_score1;
	string3 fd_score2;
	string3 fd_score3;
	string4	fd_Reason1;
	string100	fd_Desc1;
	string4	fd_Reason2;
	string100	fd_Desc2;
	string4	fd_Reason3;
	string100	fd_Desc3;
	string4	fd_Reason4;
	string100	fd_Desc4;
	// business_risk.extra_fields - recordcount - SEQ_NUMBERS;
	DATASET(Models.Layout_Model) models;
		STRING1 Rep_Lien_Unrel_Lvl := ''; // 0-5
	STRING1 Rep_Prop_Owner := ''; // 0-2
	STRING2 Rep_Prof_License_Category := ''; // (-1)-5
	STRING1 Rep_Accident_Count := ''; // 0-3
	STRING1 Rep_Paydayloan_Flag := ''; // Boolean (0-1)
	STRING2 Rep_Age_Lvl := ''; // 18, 25, 35, 45, 46
	STRING1 Rep_Bankruptcy_Count := ''; // 0-3
	STRING1 Rep_Ssns_Per_Adl := ''; // 0-4
	STRING1 Rep_Past_Arrest := ''; // Boolean (0-1)
	STRING3 Rep_Add1_Lres_Lvl := ''; // 0, 12, 24, 48, 72, 96, 192, 193
	STRING1 Rep_Criminal_Assoc_Lvl := ''; // 0, 1, 3, 4
	STRING1 Rep_Felony_Count := ''; // 0-2
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


// output(results, named('biid_results'));

//GLOBAL OUTPUT LAYOUT
Global_output_lay:= RECORD	 
Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_CHASE_BusinessInstantId_Global_Layout;			 
END;

NewRecs := PROJECT(results,TRANSFORM(Global_output_lay,self.bnap:=left.bnap_indicator;
                                             self.bnas:=left.bnas_indicator;
																						 self.bnat:=left.bnat_indicator;
																						 self.acctno:=left.account;
																						 SELF := LEFT;
																						 SELF := [];
					));


   
  	did_results:=Scoring_Project_Macros.IID_macro(f1,threads,roxieIP,DPPA,GLB,DataRestrictionMask,HistoryDate);
      
      							
     
      
      Global_output_lay xform(did_results l, NewRecs r) := TRANSFORM
      self.did := l.did;
      self := r;
      end;
      
      res := JOIN(did_results, NewRecs, left.acctno =right.acctno, xform(left, right),right outer);
      
    
        
      Global_output_lay xform1(res l, indata r) := TRANSFORM
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
			                    	self.HPhnPop := r.batch_in[1].phone_2<>'';
      	#end;
      	self := l;
      	self := [];
      	
      	end;
      	
      	final_output:=join(res,indata,left.acctno=(string)right.batch_in[1].acctno ,xform1(left, right));	

// output(results, named('biid_results'));
op_final := output(final_output,, outfile_name,thor,compressed, OVERWRITE);

return op_final;

endmacro;