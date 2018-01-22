EXPORT RV_Scores_V3_ENOVA_XML_Macro(fcraroxie_IP, neutralroxie_IP, Thread, Timeout, Retry, Input_file_name, Output_file_name, records_ToRun):= FUNCTIONMACRO

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
		 
    //*********** RV Scores V3 ENOVA XML SETUP AND SOAPCALL ******************

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
			STRING GLBPurpose;
			STRING DPPAPurpose;
			integer HistoryDateYYYYMM := HistoryDate;
			boolean Attributes := False;
			dataset(Models.Layout_Score_Chooser) scores;
			dataset(Risk_Indicators.Layout_Gateways_In) gateways;
			unsigned6 did;
		END;

		// version 4 models
		paramsA := dataset([{'Custom', 'rva1104_0'}], models.Layout_Parameters);	
		paramsB := dataset([{'Custom', 'rvb1104_0'}], models.Layout_Parameters);	
		paramsR := dataset([{'Custom', 'rvr1103_0'}], models.Layout_Parameters);
		paramsT := dataset([{'Custom', 'rvt1104_0'}], models.Layout_Parameters);	
		paramsM := dataset([{'Custom', 'rvg1103_0'}], models.Layout_Parameters);
		paramsP := dataset([{'Custom', 'rvp1104_0'}], models.Layout_Parameters);	

		layout_soap_input append_settings(ds_raw_input le, INTEGER c) := TRANSFORM
			self.Accountnumber := (STRING)le.Accountnumber;	
			self.FirstName:=le.firstname;
			self.LastName:=le.LastName;
			self.StreetAddress:=le.StreetAddress;
			self.City:=le.City;
			self.State:=le.State;	
			self.Zip:=le.Zip;
			self.HomePhone:=le.HomePhone;
			self.SSN:=le.SSN;	
			self.DateOfBirth:=le.DateOfBirth;
			self.DLNumber:=le.DLNumber;	
			self.DLState:=le.DLState;
			SELF.Attributes := False;
			// use this for all 6 scores
			self.scores := dataset([{'Models.RVAuto_Service', fcraroxieIP, paramsA},{'Models.RVBankCard_Service', fcraroxieIP,paramsB},
								            	{'Models.RVRetail_Service', fcraroxieIP,paramsR},{'Models.RVTelecom_Service', fcraroxieIP,paramsT},
									            {'Models.RVMoney_Service', fcraroxieIP,paramsM},{'Models.RVPrescreen_Service', fcraroxieIP,paramsP}], models.Layout_Score_Chooser); 
			self.gateways := dataset([{'neutralroxie', neutralroxieIP}], risk_indicators.Layout_Gateways_In);
			self := le;
			self := [];
		END;
		
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
	   	Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_XML_ENOVA_rvg1103_0_V4_Global_Layout;			 
		END;
    
		//Appeding additional internal extras to Soap output file
		Global_output_lay normit(Soap_output L, soap_in R) := transform
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
			
			retaModel1 := l.models[1].scores(description='Retail');
			retaModel2 := l.models[2].scores(description='Retail');
			retaModel3 := l.models[3].scores(description='Retail');
			retaModel4 := l.models[4].scores(description='Retail');
			retaModel5 := l.models[5].scores(description='Retail');
			retaModel6 := l.models[6].scores(description='Retail');
			
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
			self.rv_auto_reason5 := map(autoModel1[1].i <> '' => autoModel1[1].reason_codes[5].reason_code,
										autoModel2[1].i <> '' => autoModel2[1].reason_codes[5].reason_code,
										autoModel3[1].i <> '' => autoModel3[1].reason_codes[5].reason_code,
										autoModel4[1].i <> '' => autoModel4[1].reason_codes[5].reason_code,
										autoModel5[1].i <> '' => autoModel5[1].reason_codes[5].reason_code,
										autoModel6[1].i <> '' => autoModel6[1].reason_codes[5].reason_code,
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
			self.rv_bank_reason5 := map(bankModel1[1].i <> '' => bankModel1[1].reason_codes[5].reason_code,
										bankModel2[1].i <> '' => bankModel2[1].reason_codes[5].reason_code,
										bankModel3[1].i <> '' => bankModel3[1].reason_codes[5].reason_code,
										bankModel4[1].i <> '' => bankModel4[1].reason_codes[5].reason_code,
										bankModel5[1].i <> '' => bankModel5[1].reason_codes[5].reason_code,
										bankModel6[1].i <> '' => bankModel6[1].reason_codes[5].reason_code,
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
			self.rv_retail_reason5 := map(retaModel1[1].i <> '' => retaModel1[1].reason_codes[5].reason_code,
										retaModel2[1].i <> '' => retaModel2[1].reason_codes[5].reason_code,
										retaModel3[1].i <> '' => retaModel3[1].reason_codes[5].reason_code,
										retaModel4[1].i <> '' => retaModel4[1].reason_codes[5].reason_code,
										retaModel5[1].i <> '' => retaModel5[1].reason_codes[5].reason_code,
										retaModel6[1].i <> '' => retaModel6[1].reason_codes[5].reason_code,
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
			self.rv_telecom_reason5 := map(teleModel1[1].i <> '' => teleModel1[1].reason_codes[5].reason_code,
										teleModel2[1].i <> '' => teleModel2[1].reason_codes[5].reason_code,
										teleModel3[1].i <> '' => teleModel3[1].reason_codes[5].reason_code,
										teleModel4[1].i <> '' => teleModel4[1].reason_codes[5].reason_code,
										teleModel5[1].i <> '' => teleModel5[1].reason_codes[5].reason_code,
										teleModel6[1].i <> '' => teleModel6[1].reason_codes[5].reason_code,
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
			self.rv_money_reason5 := map(monyModel1[1].i <> '' => monyModel1[1].reason_codes[5].reason_code,
										monyModel2[1].i <> '' => monyModel2[1].reason_codes[5].reason_code,
										monyModel3[1].i <> '' => monyModel3[1].reason_codes[5].reason_code,
										monyModel4[1].i <> '' => monyModel4[1].reason_codes[5].reason_code,
										monyModel5[1].i <> '' => monyModel5[1].reason_codes[5].reason_code,
										monyModel6[1].i <> '' => monyModel6[1].reason_codes[5].reason_code,
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

    //final file out to thor
		final_output :=  output(ds_with_extras,,outfile_name,thor,compressed, overwrite );

		RETURN final_output;

ENDMACRO;