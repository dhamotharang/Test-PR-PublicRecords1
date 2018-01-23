EXPORT Santander_RVA1304_1_Macro(fcraroxie_IP, neutralroxie_IP, Thread, Timeout, Retry, Input_file_name, Output_file_name, records_ToRun):= FUNCTIONMACRO

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
		paramsA := dataset([{'Custom', 'rva1304_1'}], models.Layout_Parameters);

	  //*********** SETTINGS ********************************

		DPPA:=Scoring_Project_PIP.User_Settings_Module.RV_Scores_XML_Santander_1304_1_settings.DPPA;
		GLB:=Scoring_Project_PIP.User_Settings_Module.RV_Scores_XML_Santander_1304_1_settings.GLB;
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

   //*********** Santander RVA1304_1 XML SETUP AND SOAPCALL ******************
	 
		layout_soap_input := RECORD
			STRING AccountNumber;
			STRING FirstName;
			STRING MiddleName;
			STRING LastName;
			STRING NameSuffix;
			STRING StreetAddress;
			STRING City;
			STRING State;
			STRING Zip;
			STRING Country;
			STRING SSN;
			STRING DateOfBirth;
			STRING Age;
			STRING DLNumber;
			STRING DLState;
			STRING Email;
			STRING IPAddress;
			STRING HomePhone;
			STRING WorkPhone;
			STRING EmployerName;
			STRING FormerName;
			INTEGER GLBPurpose;
			INTEGER DPPAPurpose;
			integer HistoryDateYYYYMM := HistoryDate;
			boolean Attributes :=False;
			dataset(Models.Layout_Score_Chooser) scores;
			dataset(Risk_Indicators.Layout_Gateways_In) gateways;
			unsigned6 did;
		END;

	  layout_soap_input append_settings(ds_raw_input le, INTEGER c) := TRANSFORM
			SELF.Accountnumber := (STRING)le.AccountNumber;	
			SELF.Attributes := False;
			self.scores := dataset([{'Models.RVAuto_Service', fcraroxieIP, paramsA}], models.Layout_Score_Chooser); 		 
			self.gateways := dataset([{'neutralroxie', neutralroxieIP}], risk_indicators.Layout_Gateways_In);
			self.HistoryDateYYYYMM := HistoryDate;
			self.glbpurpose := GLB;
			self.dppapurpose := DPPA;
			SELF := le;
			self := [];
		end;
		
    //ds_soap_in
		soap_in := DISTRIBUTE(PROJECT(ds_raw_input, append_settings(LEFT, counter)), Random());

		//Soap output layout
		layout_Soap_output := RECORD
			STRING30 AccountNumber;
			unsigned6 did := 0;
			DATASET(Models.Layout_Model) models;
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
						'Models.RiskView_Testing_Service', {soap_in}, 
						DATASET(layout_Soap_output),
						RETRY(retry), TIMEOUT(timeout), LITERAL,
						XPATH('Models.RiskView_Testing_ServiceResponse/Results/Result/Dataset[@name=\'Results\']/Row'),
						PARALLEL(threads), onFail(myFail(LEFT)));
						
		// ***************************************************************************************************
		// *********************** Transform into layout for use in daily reports ****************************
		// ***************************************************************************************************
								
	  //GLOBAL OUTPUT LAYOUT
		Global_output_lay:= RECORD	 
		  Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_XML_Santander_RVA1304_1_V3_Global_Layout;			 
		END;

		//Appeding additional internal extras to Soap output file 
		Global_output_lay normit(Soap_output L, soap_in R) := TRANSFORM
			self.Acctno := L.accountnumber;
			self.DID := l.did; 
			self.historydate := (string)r.HistoryDateYYYYMM;
			self.FNamePop := r.firstname<>'';
			self.LNamePop := r.lastname<>'';
			self.AddrPop := r.streetaddress<>'';
			self.SSNLength := (string)(length(trim(r.ssn,left,right))) ;
			self.DOBPop := r.dateofbirth<>'';
			self.EmailPop := r.email<>'';
			self.IPAddrPop := r.ipaddress<>'';
			self.HPhnPop := r.homephone<>'';
			autoModel1 := l.models[1].scores(description='Auto' or description='AutoRVA13041' or description='AutoRVA13042');
			autoModel2 := l.models[2].scores(description='Auto' or description='AutoRVA13041' or description='AutoRVA13042');
			autoModel3 := l.models[3].scores(description='Auto' or description='AutoRVA13041' or description='AutoRVA13042');
			autoModel4 := l.models[4].scores(description='Auto' or description='AutoRVA13041' or description='AutoRVA13042');
			autoModel5 := l.models[5].scores(description='Auto' or description='AutoRVA13041' or description='AutoRVA13042');
			autoModel6 := l.models[6].scores(description='Auto' or description='AutoRVA13041' or description='AutoRVA13042');
			self.rv_score_auto := map(  autoModel1[1].i <> '' => autoModel1[1].i,
									autoModel2[1].i <> '' => autoModel2[1].i,
									autoModel3[1].i <> '' => autoModel3[1].i,
									autoModel4[1].i <> '' => autoModel4[1].i,
									autoModel5[1].i <> '' => autoModel5[1].i,
									autoModel6[1].i <> '' => autoModel6[1].i,
									'');
			self.rv_auto_reason := map( autoModel1[1].i <> '' => autoModel1[1].reason_codes[1].reason_code,
									autoModel2[1].i <> '' => autoModel2[1].reason_codes[1].reason_code,
									autoModel3[1].i <> '' => autoModel3[1].reason_codes[1].reason_code,
									autoModel4[1].i <> '' => autoModel4[1].reason_codes[1].reason_code,
									autoModel5[1].i <> '' => autoModel5[1].reason_codes[1].reason_code,
									autoModel6[1].i <> '' => autoModel6[1].reason_codes[1].reason_code,
									'');
			self.rv_auto_reason2 := map(autoModel1[1].i <> '' => autoModel1[1].reason_codes[2].reason_code,
									autoModel2[1].i <> '' => autoModel2[1].reason_codes[2].reason_code,
									autoModel3[1].i <> '' => autoModel3[1].reason_codes[2].reason_code,
									autoModel4[1].i <> '' => autoModel4[1].reason_codes[2].reason_code,
									autoModel5[1].i <> '' => autoModel5[1].reason_codes[2].reason_code,
									autoModel6[1].i <> '' => autoModel6[1].reason_codes[2].reason_code,
									'');
			self.rv_auto_reason3 := map(autoModel1[1].i <> '' => autoModel1[1].reason_codes[3].reason_code,
									autoModel2[1].i <> '' => autoModel2[1].reason_codes[3].reason_code,
									autoModel3[1].i <> '' => autoModel3[1].reason_codes[3].reason_code,
									autoModel4[1].i <> '' => autoModel4[1].reason_codes[3].reason_code,
									autoModel5[1].i <> '' => autoModel5[1].reason_codes[3].reason_code,
									autoModel6[1].i <> '' => autoModel6[1].reason_codes[3].reason_code,
									'');
			self.rv_auto_reason4 := map(autoModel1[1].i <> '' => autoModel1[1].reason_codes[4].reason_code,
									autoModel2[1].i <> '' => autoModel2[1].reason_codes[4].reason_code,
									autoModel3[1].i <> '' => autoModel3[1].reason_codes[4].reason_code,
									autoModel4[1].i <> '' => autoModel4[1].reason_codes[4].reason_code,
									autoModel5[1].i <> '' => autoModel5[1].reason_codes[4].reason_code,
									autoModel6[1].i <> '' => autoModel6[1].reason_codes[4].reason_code,
									'');
			self.rv_auto_reason5 := map(autoModel1[1].i <> '' => autoModel1[1].reason_codes[5].reason_code,
									autoModel2[1].i <> '' => autoModel2[1].reason_codes[5].reason_code,
									autoModel3[1].i <> '' => autoModel3[1].reason_codes[5].reason_code,
									autoModel4[1].i <> '' => autoModel4[1].reason_codes[5].reason_code,
									autoModel5[1].i <> '' => autoModel5[1].reason_codes[5].reason_code,
									autoModel6[1].i <> '' => autoModel6[1].reason_codes[5].reason_code,
									'');	
			self := L;
			self := [];
		END;

		ds_with_extras := JOIN(Soap_output,soap_in,LEFT.accountnumber=RIGHT.accountnumber,normit(LEFT,RIGHT));

		final_output := output(ds_with_extras,, outfile_name, thor, compressed, OVERWRITE);

		//final file out to thor
		RETURN final_output;
		
ENDMACRO;