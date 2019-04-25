EXPORT FCRA_LiensV2Service_Macro(fcraroxie_IP, neutralroxie_IP, Thread, Timeout, Retry, Input_file_name, Output_file_name, records_ToRun):= FUNCTIONMACRO

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

		FCRAPurposeCode := 6;           //6 makes us use only Insurance Lien/Judgement
		// DPPA:=Scoring_Project_PIP.User_Settings_Module.RV_Scores_XML_Tmobile_rvt1212_1_settings.DPPA;
		DPPA:=6;    //may be outdated and not needed
		// GLB:=Scoring_Project_PIP.User_Settings_Module.RV_Scores_XML_Tmobile_rvt1212_1_settings.GLB;
		GLB:=1;
		HistoryDate := 999999;

		//*****************************************************

	  //************** INPUT FILE GENERATION ****************


		// layout_input := RECORD                                           //INPUT FILE ONLY NEEDS LEXID POPULATED
			// Scoring_Project_Macros.Regression.global_layout;
			// Scoring_Project_Macros.Regression.pii_layout;
			// Scoring_Project_Macros.Regression.runtime_layout;
		// END;

		// ds_raw_input := IF(no_of_records = 0, 
										// DATASET(Infile_name, layout_input, thor),
										// CHOOSEN(DATASET(Infile_name, layout_input, thor), no_of_records));
										
	layout_input := RECORD                                           //INPUT FILE ONLY NEEDS LEXID POPULATED
			INTEGER3 AccountNumber;
			UNSIGNED6 	DID;
		END;		
		
ds_raw_input := Dataset([{1, 46},{2,79},{3,129},{4,149}], layout_input); 
	
	
	  //*********** T_Mobile RVT1212 XML SETUP AND SOAPCALL ******************
		
		// layout_soap_input := record
			// STRING AccountNumber;
			// STRING FirstName;
			// STRING MiddleName;
			// STRING LastName;
			// STRING NameSuffix;
			// STRING StreetAddress;
			// STRING City;
			// STRING State;
			// STRING Zip;
			// STRING Country;
			// STRING SSN;
			// STRING DateOfBirth;
			// STRING Age;
			// STRING DLNumber;
			// STRING DLState;
			// STRING Email;
			// STRING IPAddress;
			// STRING HomePhone;
			// STRING WorkPhone;
			// STRING EmployerName;
			// STRING FormerName;
			// INTEGER GLBPurpose;
			// INTEGER DPPAPurpose;
			// integer HistoryDateYYYYMM := HistoryDate;
			// boolean Attributes :=False;
			// dataset(Models.Layout_Score_Chooser) scores;
			// dataset(Risk_Indicators.Layout_Gateways_In) gateways;
			// unsigned6 did;
		// end;

		layout_soap_input := record
			String AccountNumber;
			unsigned6 did;
			Integer fcraPurpose;
			Integer GLBPurpose;
			Integer DPPAPurpose;
			dataset(Risk_Indicators.Layout_Gateways_In) gateways;
			integer HistoryDateYYYYMM := HistoryDate;
		end;


		layout_soap_input append_settings(ds_raw_input le, INTEGER c) := TRANSFORM
			self.Accountnumber := (STRING)le.AccountNumber;	
			self.HistoryDateYYYYMM := HistoryDate;
			self.gateways := dataset([{'neutralroxie', neutralroxieIP}], risk_indicators.Layout_Gateways_In);
			self.glbpurpose := GLB;
			self.dppapurpose := DPPA;
			self.fcraPurpose := FCRAPurposeCode;
			SELF := le;
			self := [];
		end;
	
    //ds_soap_in
		soap_in := DISTRIBUTE(PROJECT(ds_raw_input, append_settings(LEFT, counter)), Random());
		
		//Soap output layout
		layout_Soap_output := RECORD
			STRING30 AccountNumber;
			unsigned6 did := 0;
			iesp.lienjudgement.t_LienJudgmentSearchResponse;
			STRING errorcode;
		END;

		layout_Soap_output myFail(soap_in le) := TRANSFORM
			SELF.errorcode := FAILCODE + FAILMESSAGE;
			self.AccountNumber:=le.AccountNumber;
			SELF := le;
			SELF := [];
		END;

  //*********** PERFORMING SOAPCALL TO ROXIE ************ 
	
		Soap_output := soapcall(soap_in, fcraroxieIP,
						'liensv2_services.lienssearchservicefcra', {soap_in}, 
						DATASET(layout_Soap_output),
						RETRY(retry), TIMEOUT(timeout), LITERAL,
						XPATH('liensv2_services.lienssearchservicefcraResponse/Results/Result/Dataset[@name=\'Results\']/Row'),
						PARALLEL(threads), onFail(myFail(LEFT)));
						
	  // ***************************************************************************************************
		// *********************** Transform into layout for use in daily reports ****************************
		// ***************************************************************************************************
		
		//GLOBAL OUTPUT LAYOUT
		Global_output_lay:= RECORD	 
			STRING30 AccountNumber;
			unsigned6 did := 0;
			iesp.lienjudgement.t_LienJudgmentSearchResponse;
			STRING errorcode;
		END;

    //Appeding additional internal extras to Soap output file 
		Global_output_lay normit(Soap_output L, soap_in R) := transform
			self.AccountNumber := L.AccountNumber;
			self.DID := l.did; 
			self.historydate := (string)r.HistoryDateYYYYMM;
			self := L;
		  self := [];
		END;

		ds_with_extras := JOIN(Soap_output,soap_in,LEFT.accountnumber=RIGHT.accountnumber,normit(LEFT,RIGHT));
	
    //final file out to thor
		final_output := output(ds_with_extras,, outfile_name , thor,compressed, OVERWRITE);

		RETURN final_output;

ENDMACRO;