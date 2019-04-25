EXPORT Didville_Best_Addr_Macro (roxie_ip,Gateway, Thread, Timeout, Retry, Input_file_name,Output_file_name, records_ToRun):= functionmacro

IMPORT scoring, risk_indicators, riskwise, ut;

import ut;
import std, Scoring_Project, ashirey,Scoring_Project_Macros, zz_bbraaten2, Scoring_Project_DailyTracking;

unsigned8 no_of_records := records_ToRun;
unsigned1 eyeball := 10;
integer retry := retry;
integer timeout := timeout;
integer threads := Thread;

String neutralroxieIP := roxie_ip ; 
gateways := Gateway;
String Infile_name :=  Input_file_name;
String outfile_name :=  Output_file_name ;


		// *********** SETTINGS ********************************

		DataRestrictionMask:=Scoring_Project_PIP.User_Settings_Module.RV_Attributes_V5_BATCH_Prescreen_Capone_settings.DRM;
		DataPermissionMask:=Scoring_Project_PIP.User_Settings_Module.RV_Attributes_V5_BATCH_Prescreen_Capone_settings.DPM;
		fuzzy_wuzzy_was_a_bear := 'ALL';
		GLB_Didville := 1;
		GLB_data := true;
		patriotproc := true;
		IncludeRanking := true;
			
    // models		
		model1 := ''; //  Prescreen model not implemented yet in RV5.
		model2 := ''; 
		model3 := ''; 
		model4 := ''; 
		
		HistoryDate := 999999;
		
		//*****************************************************

	  //************** INPUT FILE GENERATION ****************	

		layout_input := RECORD
			Scoring_Project_Macros.Regression.global_layout;
			Scoring_Project_Macros.Regression.pii_layout;
			Scoring_Project_Macros.Regression.runtime_layout;
		END;

		ds_raw_input := IF(no_of_records = 0, 
										DATASET(Infile_name, layout_input, thor),
										CHOOSEN(DATASET(Infile_name, layout_input, thor), no_of_records));
			
// output(choosen(	ds_raw_input, eyeball), named('ds_raw_input'));		
			
		//*********** RV Attributes V5 XML SETUP AND SOAPCALL ******************
soapLayout_didville := RECORD
    string acctno;
	string did;
	String  ssn;
	String  dob;
	String phoneno;
	String  title;
	String name_first;
	String name_middle;
	String name_last;
	String  name_suffix;
	String prim_range;
	String  predir;
	String prim_name;
	String  suffix;
	String  postdir;
	String unit_desig;
	String  sec_range;
	String p_city_name;
	String  st;
	String  z5;
	String  zip4;
  
end;

soap_inrec_didville := record

boolean IncludeRanking := true;
	dataset(soapLayout_didville) did_batch_in;
end;



soap_inrec_didville t_f_didville(ds_raw_input le, integer c) := transform

	self.IncludeRanking := IncludeRanking;
	self.did_batch_in := project(le, transform(soapLayout_didville,
																					self.acctno := (string)(unsigned)le.AccountNumber;
																					self.did := (string)(unsigned)le.placeholder_1;

																					self := [];
																					));
self := [];																					
end;
		

soap_input_didville := project(ds_raw_input, t_f_didville(left, counter));
		
// output(choosen(	soap_input_didville, eyeball), named('soap_input_didville'));		


layout_Soap_output2 := RECORD
		DidVille.Layout_Did_OutBatch_Raw;

			STRING errorcode;
END;

layout_Soap_output2 myFail_didville(soap_inrec_didville le) := TRANSFORM
			SELF.errorcode := FAILCODE + FAILMESSAGE;
			SELF := le;
			SELF := [];
END;

	  //*********** PERFORMING SOAPCALL TO ROXIE ************ 
		
		didville_Soap_output := SOAPCALL(soap_input_didville, 
						neutralroxieIP,
						'didville.did_batch_service_raw', 
						{soap_input_didville}, 
						DATASET(layout_Soap_output2),
						RETRY(RETRY), TIMEOUT(timeout),
						PARALLEL(threads), onFail(myFail_didville(LEFT)));
		

// output(choosen(	didville_Soap_output, eyeball), named('didville_Soap_output'));		
	 

layout_Soap_output2 trans(didville_Soap_output le) := transform
	 self.acctno := (string)(unsigned)le.acctno;
	 self.did := (string)(unsigned)le.did;
	 self.best_addr1 := le.best_addr1;
	 self.best_city := le.best_city;
	 self.best_state := le.best_state;
	 self.best_zip := le.best_zip;
	 self.best_zip4 := le.best_zip4;
	 self.best_addr_date := le.best_addr_date;
	 // self := [];
	 self := le;
END;
	 
	 ds_out_clean := project(didville_Soap_output, trans(left));
	 
	 // outfile_name := '~bbraaten::out::didville_raw_address_rank::Header_201702_20170419';
fin_out := output(ds_out_clean ,,outfile_name, thor, compressed, overwrite);


return fin_out;
endmacro;