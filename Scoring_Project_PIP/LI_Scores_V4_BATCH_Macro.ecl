EXPORT LI_Scores_V4_BATCH_Macro(roxie_ip, Gateway_dummy, Thread, Timeout, Retry, Input_file_name, Output_file_name, records_ToRun):= FUNCTIONMACRO

IMPORT Models, iESP, Risk_Indicators, RiskWise, UT, RiskProcessing ;

		unsigned8 no_of_records := records_ToRun;
		unsigned1 eyeball := 10;
		integer retry := retry;
		integer timeout := timeout;
		integer threads := Thread;
		String roxieIP := roxie_ip ; 
		gateways := Gateway;
		String Infile_name :=  Input_file_name;
		String outfile_name :=  Output_file_name;
		model := 'msn1106_0' ;   

		//*********** SETTINGS ********************************

		DRM:=Scoring_Project_PIP.User_Settings_Module.LI_Scores_V4_BATCH_Generic_msn1106_0_settings.DRM;
		DPPA:=Scoring_Project_PIP.User_Settings_Module.LI_Scores_V4_BATCH_Generic_msn1106_0_settings.DPPA;
		GLB:=Scoring_Project_PIP.User_Settings_Module.LI_Scores_V4_BATCH_Generic_msn1106_0_settings.GLB;
		isFCRA:=if(Scoring_Project_PIP.User_Settings_Module.LI_Scores_V4_BATCH_Generic_msn1106_0_settings.isFCRA=true,'FCRA','NONFCRA');
		IncludeVersion4:=if(Scoring_Project_PIP.User_Settings_Module.LI_Scores_V4_BATCH_Generic_msn1106_0_settings.IncludeVersion4,4,3);
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

    //*********** LI Scores V4 BATCH SETUP AND SOAPCALL ******************

		layout_soap_input := RECORD
			DATASET(Risk_Indicators.Layout_Batch_In) batch_in;
			DATASET(Risk_Indicators.Layout_Gateways_In) gateways;
			STRING DataRestrictionMask;
			INTEGER Version;
			INTEGER HistoryDateYYYYMM;
			BOOLEAN ADL_Based_Shell;
			STRING ModelName:= '';
		END;

		Risk_Indicators.Layout_Batch_In make_batch_in(ds_raw_input le, integer c) := TRANSFORM
			SELF.seq := c;
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
			SELF.historydateyyyymm := 999999 ;
			SELF := le;
			SELF := [];
		END;

		layout_soap_input append_settings(ds_raw_input le, integer c) := TRANSFORM
			batch := PROJECT(le, make_batch_in(LEFT, c));
			SELF.batch_in := batch;
			SELF.gateways := DATASET([{isFCRA, roxieIP}], risk_indicators.layout_gateways_in);
			SELF.Version := IncludeVersion4;
			SELF.adl_based_shell := true;
			SELF.ModelName:= model ;
			SELF.DataRestrictionMask := DRM;  
		  SELF.HistoryDateYYYYMM := HistoryDate;
			END;
			
		//ds_soap_in
		soap_in := DISTRIBUTE(PROJECT(ds_raw_input, append_settings(LEFT, counter)), Random());
		
    //Soap output layout
		layout_Soap_output := RECORD
			unsigned8 time_ms {xpath('_call_latency_ms')} := 0;  // picks up timing 		
			models.layouts.layout_LeadIntegrity_attributes_batch 	;
			STRING errorcode;
		END;

		layout_Soap_output myFail(soap_in le) := TRANSFORM
			SELF.errorcode := FAILCODE + FAILMESSAGE;
			SELF.acctno:=le.batch_in[1].acctno;
			SELF := le;
			SELF := [];
		END;
					
		//*********** PERFORMING SOAPCALL TO ROXIE ************ 
		 
		Soap_output := SOAPCALL(soap_in, roxieIP,
						'Models.LeadIntegrity_Batch_Service', {soap_in}, 
						DATASET(layout_Soap_output),
						PARALLEL(threads), onFail(myFail(LEFT)));				
		
		// ***************************************************************************************************
		// *********************** Transform into layout for use in daily reports ****************************
		// ***************************************************************************************************
											
	  //GLOBAL OUTPUT LAYOUT
		Global_output_lay:= RECORD	 
		Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_LeadIntegrity_V4_Generic_MSN1210_1_Global_Layout;			 
		END;

			Global_output_lay v4_trans(Soap_output le ) := TRANSFORM
				self.time_ms := le.time_ms;
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

		ds_slim := project(Soap_output, v4_trans(left));

	  // calling IID macro to capture DID for appending to final output 		
	  // did_results:=Scoring_Project_PIP.IID_macro(ds_raw_input,threads,roxieIP,DPPA,GLB,DRM,HistoryDate);  
	
	  //**************** ADDING DID'S & INTERNAL EXTRAS TO RESULTS *************************** 
		
		// res:=JOIN(ds_slim, Soap_output, LEFT.acctno = (STRING)RIGHT.AcctNo,
																// TRANSFORM(Global_output_lay,
																// SELF.DID := RIGHT.DID;   									
																// SELF := LEFT;   						
																// ), left outer);

		//Appeding additional internal extras to Soap output file 
		ds_with_extras := JOIN(ds_slim, soap_in, LEFT.acctno = (STRING)RIGHT.batch_in[1].acctno,
																TRANSFORM(Global_output_lay,
																self.historydate := (string)right.batch_in[1].HistoryDateYYYYMM;
																self.FNamePop := right.batch_in[1].Name_First<>'';
																self.LNamePop := right.batch_in[1].Name_Last<>'';
																self.AddrPop := right.batch_in[1].street_addr<>'';
																self.SSNLength := (string)(length(trim(right.batch_in[1].ssn,left,right))) ;
																self.DOBPop := right.batch_in[1].dob<>'';
																self.IPAddrPop := right.batch_in[1].ip_addr<>''; 
																self.HPhnPop := right.batch_in[1].Home_Phone<>'';
																self := left;
																self := []
																));
										
		//final file out to thor
		// final_output := output(ds_with_extras);
		final_output := output(ds_with_extras,, outfile_name, thor, compressed, OVERWRITE);

		RETURN final_output;

ENDMACRO;