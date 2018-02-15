EXPORT RV_Scores_V3_BATCH_Macro(fcraroxie_IP, neutralroxie_IP, Thread, Timeout, Retry, Input_file_name, Output_file_name, records_ToRun):= FUNCTIONMACRO

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

    //*********** SETTINGS ********************************

		DRM:=Scoring_Project_PIP.User_Settings_Module.RV_Scores_V3_BATCH_Generic_settings.DRM;
		isFCRA:=if(Scoring_Project_PIP.User_Settings_Module.RV_Scores_V3_BATCH_Generic_settings.isFCRA=true,'FCRA','NONFCRA');
		IncludeVersion3:=Scoring_Project_PIP.User_Settings_Module.RV_Scores_V3_BATCH_Generic_settings.IncludeVersion3;
		// IsPreScreen:=Scoring_Project_PIP.User_Settings_Module.RV_Scores_V3_BATCH_Generic_settings.IsPreScreen;
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

    //*********** RV Scores V3 BATCH SETUP AND SOAPCALL ******************
		
		layout_soap_input := RECORD
			DATASET(Risk_Indicators.Layout_Batch_In) batch_in;
			DATASET(Risk_Indicators.Layout_Gateways_In) gateways;
			STRING DataRestrictionMask;
			boolean IncludeVersion3;
			boolean IncludeAllScores;
			// BOOLEAN IsPreScreen;	
			integer Flagshipversion;
		END;

		Risk_Indicators.Layout_Batch_In make_batch_in(ds_raw_input le, integer c) := TRANSFORM
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

		layout_soap_input append_settings(ds_raw_input le, integer c) := TRANSFORM
			batch := PROJECT(le, make_batch_in(LEFT, c));
			SELF.batch_in := batch;
			SELF.gateways := DATASET([{isFCRA, neutralroxieIP}], risk_indicators.layout_gateways_in);
			// SELF.IsPreScreen := IsPreScreen;		
			self.IncludeVersion3 := IncludeVersion3;
			self.IncludeAllScores := true;
			SELF.DataRestrictionMask := DRM;
			SELF.FlagshipVersion := 3;  
		END;
			
    //ds_soap_in
		soap_in := DISTRIBUTE(PROJECT(ds_raw_input, append_settings(LEFT, counter)), Random());
		
		//Soap output layout
		layout_Soap_output := RECORD
	unsigned8 time_ms {xpath('_call_latency_ms')} := 0;  // picks up timing 
			
			STRING30 AccountNumber;
			unsigned6 did := 0;
			models.Layout_RiskView_Batch_Out;
			string200 errorcode;
		END;
					 
		layout_Soap_output myfail(soap_in L) := transform
			SELF.errorcode := FAILCODE + FAILMESSAGE;
			self.acctno := l.batch_in[1].acctno;
			self := [];
		end;

		//*********** PERFORMING SOAPCALL TO ROXIE ************ 
		
		Soap_output := soapcall(soap_in, fcraroxieIP ,
												'models.RiskView_Batch_Service', 
												{soap_in},
												dataset(layout_Soap_output), 
												RETRY(retry), TIMEOUT(timeout),
												parallel(threads) ,
												onfail(myfail(LEFT)));

		// ***************************************************************************************************
		// *********************** Transform into layout for use in daily reports ****************************
		// ***************************************************************************************************
				
	  //GLOBAL OUTPUT LAYOUT
		Global_output_lay:= RECORD	 
	    Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_Generic_allflagships_V3_Global_Layout;			 
		END;

    //Appeding additional internal extras to Soap output file 
    //Mapping Version3 scores and reason codes
		Global_output_lay v3_trans(Soap_output L, soap_in R) := transform
														 self.time_ms := l.time_ms;  
			
			self.Acctno :=(string) R.batch_in[1].acctno;
			self.DID := l.did; 
			self.historydate := (string) R.batch_in[1].HistoryDateYYYYMM;
			self.FNamePop :=  R.batch_in[1].Name_First<>'';
			self.LNamePop :=  R.batch_in[1].Name_Last<>'';
			self.AddrPop :=  R.batch_in[1].street_addr<>'';
			self.SSNLength := (string)(length(trim( R.batch_in[1].ssn,left,right))) ;
			self.DOBPop :=  R.batch_in[1].dob<>'';
			self.IPAddrPop :=  R.batch_in[1].ip_addr<>'';
			self.HPhnPop :=  R.batch_in[1].Home_Phone<>'';		 
			self.rv_score_auto :=  l.score1  ;
			self.rv_auto_reason :=  l.reason1  ;
			self.rv_auto_reason2 :=  l.reason2  ;
			self.rv_auto_reason3 :=  l.reason3  ;
			self.rv_auto_reason4 :=  l.reason4  ;
			self.rv_score_bank :=  l.score2  ;
			self.rv_bank_reason :=  l.reason5  ;
			self.rv_bank_reason2 :=  l.reason6  ;
			self.rv_bank_reason3 :=  l.reason7  ;
			self.rv_bank_reason4 :=  l.reason8  ;
			self.rv_score_retail :=  l.score3  ;
			self.rv_retail_reason :=  l.reason9  ;
			self.rv_retail_reason2 :=  l.reason10  ;
			self.rv_retail_reason3 :=  l.reason11  ;
			self.rv_retail_reason4 :=  l.reason12  ;
			self.rv_score_telecom :=  l.score4  ;
			self.rv_telecom_reason :=  l.reason13  ;
			self.rv_telecom_reason2 :=  l.reason14  ;
			self.rv_telecom_reason3 :=  l.reason15  ;
			self.rv_telecom_reason4 :=  l.reason16  ;
			self.rv_score_money :=  l.score5  ;
			self.rv_money_reason :=  l.reason17  ;
			self.rv_money_reason2 :=  l.reason18  ;
			self.rv_money_reason3 :=  l.reason19  ;
			self.rv_money_reason4 :=  l.reason20  ;
			self.rv_score_prescreen :='';
			self.rv_prescreen_reason :='';
			self := L;
			self := [];
		END;
			 
		ds_with_extras := JOIN(Soap_output,soap_in,LEFT.Acctno=(string)RIGHT.batch_in[1].acctno,v3_trans(LEFT,RIGHT));

		//final file out to thor
		final_output := output(ds_with_extras ,,outfile_name,thor, compressed,overwrite);

		RETURN final_output ;
		
ENDMACRO; 