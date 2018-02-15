EXPORT RV_Scores_V3_XML_Macro(fcraroxie_IP, neutralroxie_IP, Thread, Timeout, Retry, Input_file_name, Output_file_name, records_ToRun):= FUNCTIONMACRO

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

		DRM:=Scoring_Project_PIP.User_Settings_Module.RV_Scores_V3_xml_Generic_settings.DRM;

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
		
    //*********** RV Scores V3 XML SETUP AND SOAPCALL ******************
		
		layout_soap := record
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
			STRING datarestrictionmask;
			// INTEGER GLBPurpose;
			// INTEGER DPPAPurpose;
			integer HistoryDateYYYYMM;
			boolean Attributes :=False;
			dataset(Models.Layout_Score_Chooser) scores;
			dataset(Risk_Indicators.Layout_Gateways_In) gateways;
			string IntendedPurpose := '';
		end;

		// version 3 models
		paramsA := dataset([{'Custom', 'rva1003_0'}], models.Layout_Parameters);	// use this for non-version1 models, also possibly change the scores that you call below
		paramsB := dataset([{'Custom', 'rvb1003_0'}], models.Layout_Parameters);	// use this for non-version1 models, also possibly change the scores that you call below
		paramsR := dataset([{'Custom', 'rvr1003_0'}], models.Layout_Parameters);	// use this for non-version1 models, also possibly change the scores that you call below
		paramsT := dataset([{'Custom', 'rvt1003_0'}], models.Layout_Parameters);	// use this for non-version1 models, also possibly change the scores that you call below
		paramsM := dataset([{'Custom', 'rvg1003_0'}], models.Layout_Parameters);	// use this for non-version1 models, also possibly change the scores that you call below
		paramsP := dataset([{'Custom', 'rvp1003_0'}], models.Layout_Parameters);	// use this for non-version1 models, also possibly change the scores that you call below

		layout_soap append_settings(ds_raw_input le, INTEGER c) := TRANSFORM
			self.Accountnumber := (STRING)le.accountnumber;	
			self.Attributes := False;
      // use this for all 4 scores
			self.scores := dataset([{'Models.RVAuto_Service', fcraroxieIP, paramsA},{'Models.RVBankCard_Service', fcraroxieIP,paramsB},
									            {'Models.RVRetail_Service', fcraroxieIP,paramsR},{'Models.RVTelecom_Service', fcraroxieIP,paramsT},
								             	{'Models.RVMoney_Service', fcraroxieIP,paramsM}], models.Layout_Score_Chooser); 
			self.gateways := dataset([{'neutralroxie', neutralroxieIP}], risk_indicators.Layout_Gateways_In);
			self.IntendedPurpose := '';
			self.HistoryDateYYYYMM := HistoryDate;
			self.datarestrictionmask:=DRM;
			// self.dppapurpose:=DPPA;	
			SELF := le;
			self := [];
		end;

    //ds_soap_in
		soap_in := DISTRIBUTE(PROJECT(ds_raw_input, append_settings(LEFT, counter)), Random());
		
		// run the prescreen score as seperate soapcall so you can send in the intended purpose
		//ds_soap_in_prescreen
		soap_in_prescreen := DISTRIBUTE(PROJECT(soap_in,TRANSFORM(layout_soap,
																						self.IntendedPurpose := 'PRESCREENING'; 
																						self.scores := dataset([{'Models.RVPrescreen_Service', fcraroxieIP,paramsP}], models.Layout_Score_Chooser); 
																						SELF := LEFT)), Random());
																						
	
	  //Soap output layout
	  layout_Soap_output := RECORD
	unsigned8 time_ms {xpath('_call_latency_ms')} := 0;  // picks up timing 
		
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
						
	
		Soap_output_prescreen := soapcall(soap_in_prescreen, fcraroxieIP,
						'Models.RiskView_Testing_Service', {soap_in_prescreen}, 
						DATASET(layout_Soap_output),
						RETRY(retry), TIMEOUT(timeout), LITERAL,
						XPATH('Models.RiskView_Testing_ServiceResponse/Results/Result/Dataset[@name=\'Results\']/Row'),
						PARALLEL(threads), onFail(myFail(LEFT)));
						
		// ***************************************************************************************************
		// *********************** Transform into layout for use in daily reports ****************************
		// ***************************************************************************************************
						
		//GLOBAL OUTPUT LAYOUT
		Global_output_lay:= RECORD	 
		  Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_Generic_allflagships_V3_Global_Layout;			 
		END;

		//Appeding additional internal extras to Soap output file 
    //Mapping Version3 scores and reason codes
		Global_output_lay normit(layout_Soap_output L, soap_in R) := transform
self.time_ms := l.time_ms;			 
			 SELF.Acctno := R.accountnumber;
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
	
			// score fields 
			autoModel1 := l.models[1].scores(description='Auto' or description='AutoRVA10071' or description='AutoRVA10072');
			autoModel2 := l.models[2].scores(description='Auto' or description='AutoRVA10071' or description='AutoRVA10072');
			autoModel3 := l.models[3].scores(description='Auto' or description='AutoRVA10071' or description='AutoRVA10072');
			autoModel4 := l.models[4].scores(description='Auto' or description='AutoRVA10071' or description='AutoRVA10072');
			autoModel5 := l.models[5].scores(description='Auto' or description='AutoRVA10071' or description='AutoRVA10072');
			autoModel6 := l.models[6].scores(description='Auto' or description='AutoRVA10071' or description='AutoRVA10072');
			
			bankModel1 := l.models[1].scores(description='BankCard');
			bankModel2 := l.models[2].scores(description='BankCard');
			bankModel3 := l.models[3].scores(description='BankCard');
			bankModel4 := l.models[4].scores(description='BankCard');
			bankModel5 := l.models[5].scores(description='BankCard');
			bankModel6 := l.models[6].scores(description='BankCard');
			
			retaModel1 := l.models[1].scores(description='Retail' or description='RetailRVR10081');
			retaModel2 := l.models[2].scores(description='Retail' or description='RetailRVR10081');
			retaModel3 := l.models[3].scores(description='Retail' or description='RetailRVR10081');
			retaModel4 := l.models[4].scores(description='Retail' or description='RetailRVR10081');
			retaModel5 := l.models[5].scores(description='Retail' or description='RetailRVR10081');
			retaModel6 := l.models[6].scores(description='Retail' or description='RetailRVR10081');
			
			teleModel1 := l.models[1].scores(description='Telecom');
			teleModel2 := l.models[2].scores(description='Telecom');
			teleModel3 := l.models[3].scores(description='Telecom');
			teleModel4 := l.models[4].scores(description='Telecom');
			teleModel5 := l.models[5].scores(description='Telecom');
			teleModel6 := l.models[6].scores(description='Telecom');
			
			monyModel1 := l.models[1].scores(description='Money');
			monyModel2 := l.models[2].scores(description='Money');
			monyModel3 := l.models[3].scores(description='Money');
			monyModel4 := l.models[4].scores(description='Money');
			monyModel5 := l.models[5].scores(description='Money');
			monyModel6 := l.models[6].scores(description='Money');
			
			presModel1 := l.models[1].scores(description='PreScreen');
			presModel2 := l.models[2].scores(description='PreScreen');
			presModel3 := l.models[3].scores(description='PreScreen');
			presModel4 := l.models[4].scores(description='PreScreen');
			presModel5 := l.models[5].scores(description='PreScreen');
			presModel6 := l.models[6].scores(description='PreScreen');

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
			
			self.rv_score_bank := map(  bankModel1[1].i <> '' => bankModel1[1].i,
										bankModel2[1].i <> '' => bankModel2[1].i,
										bankModel3[1].i <> '' => bankModel3[1].i,
										bankModel4[1].i <> '' => bankModel4[1].i,
										bankModel5[1].i <> '' => bankModel5[1].i,
										bankModel6[1].i <> '' => bankModel6[1].i,
										'');
			self.rv_bank_reason := map( bankModel1[1].i <> '' => bankModel1[1].reason_codes[1].reason_code,
										bankModel2[1].i <> '' => bankModel2[1].reason_codes[1].reason_code,
										bankModel3[1].i <> '' => bankModel3[1].reason_codes[1].reason_code,
										bankModel4[1].i <> '' => bankModel4[1].reason_codes[1].reason_code,
										bankModel5[1].i <> '' => bankModel5[1].reason_codes[1].reason_code,
										bankModel6[1].i <> '' => bankModel6[1].reason_codes[1].reason_code,
										'');
			self.rv_bank_reason2 := map(bankModel1[1].i <> '' => bankModel1[1].reason_codes[2].reason_code,
										bankModel2[1].i <> '' => bankModel2[1].reason_codes[2].reason_code,
										bankModel3[1].i <> '' => bankModel3[1].reason_codes[2].reason_code,
										bankModel4[1].i <> '' => bankModel4[1].reason_codes[2].reason_code,
										bankModel5[1].i <> '' => bankModel5[1].reason_codes[2].reason_code,
										bankModel6[1].i <> '' => bankModel6[1].reason_codes[2].reason_code,
										'');
			self.rv_bank_reason3 := map(bankModel1[1].i <> '' => bankModel1[1].reason_codes[3].reason_code,
										bankModel2[1].i <> '' => bankModel2[1].reason_codes[3].reason_code,
										bankModel3[1].i <> '' => bankModel3[1].reason_codes[3].reason_code,
										bankModel4[1].i <> '' => bankModel4[1].reason_codes[3].reason_code,
										bankModel5[1].i <> '' => bankModel5[1].reason_codes[3].reason_code,
										bankModel6[1].i <> '' => bankModel6[1].reason_codes[3].reason_code,
										'');
			self.rv_bank_reason4 := map(bankModel1[1].i <> '' => bankModel1[1].reason_codes[4].reason_code,
										bankModel2[1].i <> '' => bankModel2[1].reason_codes[4].reason_code,
										bankModel3[1].i <> '' => bankModel3[1].reason_codes[4].reason_code,
										bankModel4[1].i <> '' => bankModel4[1].reason_codes[4].reason_code,
										bankModel5[1].i <> '' => bankModel5[1].reason_codes[4].reason_code,
										bankModel6[1].i <> '' => bankModel6[1].reason_codes[4].reason_code,
										'');
										
			self.rv_score_retail := map(retaModel1[1].i <> '' => retaModel1[1].i,
										retaModel2[1].i <> '' => retaModel2[1].i,
										retaModel3[1].i <> '' => retaModel3[1].i,
										retaModel4[1].i <> '' => retaModel4[1].i,
										retaModel5[1].i <> '' => retaModel5[1].i,
										retaModel6[1].i <> '' => retaModel6[1].i,
										'');
			self.rv_retail_reason := map( retaModel1[1].i <> '' => retaModel1[1].reason_codes[1].reason_code,
										retaModel2[1].i <> '' => retaModel2[1].reason_codes[1].reason_code,
										retaModel3[1].i <> '' => retaModel3[1].reason_codes[1].reason_code,
										retaModel4[1].i <> '' => retaModel4[1].reason_codes[1].reason_code,
										retaModel5[1].i <> '' => retaModel5[1].reason_codes[1].reason_code,
										retaModel6[1].i <> '' => retaModel6[1].reason_codes[1].reason_code,
										'');
			self.rv_retail_reason2 := map(retaModel1[1].i <> '' => retaModel1[1].reason_codes[2].reason_code,
										retaModel2[1].i <> '' => retaModel2[1].reason_codes[2].reason_code,
										retaModel3[1].i <> '' => retaModel3[1].reason_codes[2].reason_code,
										retaModel4[1].i <> '' => retaModel4[1].reason_codes[2].reason_code,
										retaModel5[1].i <> '' => retaModel5[1].reason_codes[2].reason_code,
										retaModel6[1].i <> '' => retaModel6[1].reason_codes[2].reason_code,
										'');
			self.rv_retail_reason3 := map(retaModel1[1].i <> '' => retaModel1[1].reason_codes[3].reason_code,
										retaModel2[1].i <> '' => retaModel2[1].reason_codes[3].reason_code,
										retaModel3[1].i <> '' => retaModel3[1].reason_codes[3].reason_code,
										retaModel4[1].i <> '' => retaModel4[1].reason_codes[3].reason_code,
										retaModel5[1].i <> '' => retaModel5[1].reason_codes[3].reason_code,
										retaModel6[1].i <> '' => retaModel6[1].reason_codes[3].reason_code,
										'');
			self.rv_retail_reason4 := map(retaModel1[1].i <> '' => retaModel1[1].reason_codes[4].reason_code,
										retaModel2[1].i <> '' => retaModel2[1].reason_codes[4].reason_code,
										retaModel3[1].i <> '' => retaModel3[1].reason_codes[4].reason_code,
										retaModel4[1].i <> '' => retaModel4[1].reason_codes[4].reason_code,
										retaModel5[1].i <> '' => retaModel5[1].reason_codes[4].reason_code,
										retaModel6[1].i <> '' => retaModel6[1].reason_codes[4].reason_code,
										'');							
										
			self.rv_score_telecom := map(   teleModel1[1].i <> '' => teleModel1[1].i,
											teleModel2[1].i <> '' => teleModel2[1].i,
											teleModel3[1].i <> '' => teleModel3[1].i,
											teleModel4[1].i <> '' => teleModel4[1].i,
											teleModel5[1].i <> '' => teleModel5[1].i,
											teleModel6[1].i <> '' => teleModel6[1].i,
											'');
			self.rv_telecom_reason := map( teleModel1[1].i <> '' => teleModel1[1].reason_codes[1].reason_code,
										teleModel2[1].i <> '' => teleModel2[1].reason_codes[1].reason_code,
										teleModel3[1].i <> '' => teleModel3[1].reason_codes[1].reason_code,
										teleModel4[1].i <> '' => teleModel4[1].reason_codes[1].reason_code,
										teleModel5[1].i <> '' => teleModel5[1].reason_codes[1].reason_code,
										teleModel6[1].i <> '' => teleModel6[1].reason_codes[1].reason_code,
										'');
			self.rv_telecom_reason2 := map(teleModel1[1].i <> '' => teleModel1[1].reason_codes[2].reason_code,
										teleModel2[1].i <> '' => teleModel2[1].reason_codes[2].reason_code,
										teleModel3[1].i <> '' => teleModel3[1].reason_codes[2].reason_code,
										teleModel4[1].i <> '' => teleModel4[1].reason_codes[2].reason_code,
										teleModel5[1].i <> '' => teleModel5[1].reason_codes[2].reason_code,
										teleModel6[1].i <> '' => teleModel6[1].reason_codes[2].reason_code,
										'');
			self.rv_telecom_reason3 := map(teleModel1[1].i <> '' => teleModel1[1].reason_codes[3].reason_code,
										teleModel2[1].i <> '' => teleModel2[1].reason_codes[3].reason_code,
										teleModel3[1].i <> '' => teleModel3[1].reason_codes[3].reason_code,
										teleModel4[1].i <> '' => teleModel4[1].reason_codes[3].reason_code,
										teleModel5[1].i <> '' => teleModel5[1].reason_codes[3].reason_code,
										teleModel6[1].i <> '' => teleModel6[1].reason_codes[3].reason_code,
										'');
			self.rv_telecom_reason4 := map(teleModel1[1].i <> '' => teleModel1[1].reason_codes[4].reason_code,
										teleModel2[1].i <> '' => teleModel2[1].reason_codes[4].reason_code,
										teleModel3[1].i <> '' => teleModel3[1].reason_codes[4].reason_code,
										teleModel4[1].i <> '' => teleModel4[1].reason_codes[4].reason_code,
										teleModel5[1].i <> '' => teleModel5[1].reason_codes[4].reason_code,
										teleModel6[1].i <> '' => teleModel6[1].reason_codes[4].reason_code,
										'');								
											
			self.rv_score_money := map( monyModel1[1].i <> '' => monyModel1[1].i,
										monyModel2[1].i <> '' => monyModel2[1].i,
										monyModel3[1].i <> '' => monyModel3[1].i,
										monyModel4[1].i <> '' => monyModel4[1].i,
										monyModel5[1].i <> '' => monyModel5[1].i,
										monyModel6[1].i <> '' => monyModel6[1].i,
										'');
			self.rv_money_reason := map(monyModel1[1].i <> '' => monyModel1[1].reason_codes[1].reason_code,
										monyModel2[1].i <> '' => monyModel2[1].reason_codes[1].reason_code,
										monyModel3[1].i <> '' => monyModel3[1].reason_codes[1].reason_code,
										monyModel4[1].i <> '' => monyModel4[1].reason_codes[1].reason_code,
										monyModel5[1].i <> '' => monyModel5[1].reason_codes[1].reason_code,
										monyModel6[1].i <> '' => monyModel6[1].reason_codes[1].reason_code,
										'');
			self.rv_money_reason2 := map(monyModel1[1].i <> '' => monyModel1[1].reason_codes[2].reason_code,
										monyModel2[1].i <> '' => monyModel2[1].reason_codes[2].reason_code,
										monyModel3[1].i <> '' => monyModel3[1].reason_codes[2].reason_code,
										monyModel4[1].i <> '' => monyModel4[1].reason_codes[2].reason_code,
										monyModel5[1].i <> '' => monyModel5[1].reason_codes[2].reason_code,
										monyModel6[1].i <> '' => monyModel6[1].reason_codes[2].reason_code,
										'');
			self.rv_money_reason3 := map(monyModel1[1].i <> '' => monyModel1[1].reason_codes[3].reason_code,
										monyModel2[1].i <> '' => monyModel2[1].reason_codes[3].reason_code,
										monyModel3[1].i <> '' => monyModel3[1].reason_codes[3].reason_code,
										monyModel4[1].i <> '' => monyModel4[1].reason_codes[3].reason_code,
										monyModel5[1].i <> '' => monyModel5[1].reason_codes[3].reason_code,
										monyModel6[1].i <> '' => monyModel6[1].reason_codes[3].reason_code,
										'');
			self.rv_money_reason4 := map(monyModel1[1].i <> '' => monyModel1[1].reason_codes[4].reason_code,
										monyModel2[1].i <> '' => monyModel2[1].reason_codes[4].reason_code,
										monyModel3[1].i <> '' => monyModel3[1].reason_codes[4].reason_code,
										monyModel4[1].i <> '' => monyModel4[1].reason_codes[4].reason_code,
										monyModel5[1].i <> '' => monyModel5[1].reason_codes[4].reason_code,
										monyModel6[1].i <> '' => monyModel6[1].reason_codes[4].reason_code,
										'');							
										
			self.rv_score_prescreen := map( presModel1[1].i <> '' => presModel1[1].i,
											presModel2[1].i <> '' => presModel2[1].i,
											presModel3[1].i <> '' => presModel3[1].i,
											presModel4[1].i <> '' => presModel4[1].i,
											presModel5[1].i <> '' => presModel5[1].i,
											presModel6[1].i <> '' => presModel6[1].i,
											'');
			self.RV_prescreen_reason := map( presModel1[1].i <> '' => presModel1[1].reason_codes[1].reason_code,
											presModel2[1].i <> '' => presModel2[1].reason_codes[1].reason_code,
											presModel3[1].i <> '' => presModel3[1].reason_codes[1].reason_code,
											presModel4[1].i <> '' => presModel4[1].reason_codes[1].reason_code,
											presModel5[1].i <> '' => presModel5[1].reason_codes[1].reason_code,
											presModel6[1].i <> '' => presModel6[1].reason_codes[1].reason_code,
											'');		
		  self := L;
		  self := [];
	  END;

		ds_with_extras := JOIN(Soap_output,soap_in,LEFT.accountnumber=RIGHT.accountnumber,normit(LEFT,RIGHT));

		ds_prescreen := JOIN(Soap_output_prescreen,soap_in_prescreen,LEFT.accountnumber=RIGHT.accountnumber,normit(LEFT,RIGHT));

    //appening prescreen scores
		ds_final := join(ds_with_extras, ds_prescreen, left.acctno=right.acctno, transform(Global_output_lay, 
																																		self.rv_score_prescreen := right.rv_score_prescreen;
																																		self.RV_prescreen_reason := right.rv_prescreen_reason;
																																		self := left) );

	  //final file out to thor
		final_output :=  output(ds_final,,outfile_name ,thor, compressed, overwrite );

		RETURN  final_output;

ENDMACRO; 