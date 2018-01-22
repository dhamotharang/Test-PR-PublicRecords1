EXPORT T_Mobile_RVT1210_Macro (fcraroxie_IP, neutralroxie_IP, Thread, Timeout, Retry, Input_file_name, Output_file_name, records_ToRun):= FUNCTIONMACRO

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
		paramsT := dataset([{'Custom', 'rvt1210_1'}], models.Layout_Parameters);

		//*********** SETTINGS ********************************

		DPPA:=Scoring_Project_PIP.User_Settings_Module.RV_Scores_XML_Tmobile_rvt1210_1_settings.DPPA;
		GLB:=Scoring_Project_PIP.User_Settings_Module.RV_Scores_XML_Tmobile_rvt1210_1_settings.GLB;
		DRM:=Scoring_Project_PIP.User_Settings_Module.RV_Scores_XML_Tmobile_rvt1210_1_settings.DRM;
		HISTORYDATE := 999999;

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
			 
    //*********** T_Mobile RVT1210 XML SETUP AND SOAPCALL ******************
			 
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
			string DataRestrictionMask;	
			integer HistoryDateYYYYMM := 999999;
			boolean Attributes :=False;
			dataset(Models.Layout_Score_Chooser) scores;
			dataset(Risk_Indicators.Layout_Gateways_In) gateways;
			unsigned6 did;
		END;

		layout_soap_input append_settings(ds_raw_input le, INTEGER c) := TRANSFORM
			SELF.Accountnumber := (STRING)le.accountnumber;	
			SELF.Attributes := False;
			self.HistoryDateYYYYMM := HistoryDate;
			self.DataRestrictionMask := DRM;  
			self.scores := dataset([{'Models.RVTelecom_Service', fcraroxieIP,paramsT}], models.Layout_Score_Chooser);		 
			self.gateways := dataset([{'neutralroxie', neutralroxieIP}], risk_indicators.Layout_Gateways_In);
			SELF := le;
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
		  Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_XML_T_mobile_RVT1210_1_v4_Global_Layout;			 
		END;

		//Appeding additional internal extras to Soap output file 
		Global_output_lay normit(Soap_output L, soap_in R) := transform
			self.Acctno := L.AccountNumber;
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
			teleModel1 := l.models[1].scores(description='Telecom' or description='TelecomRVT12101');
			teleModel2 := l.models[2].scores(description='Telecom'or description='TelecomRVT12101');
			teleModel3 := l.models[3].scores(description='Telecom'or description='TelecomRVT12101');
			teleModel4 := l.models[4].scores(description='Telecom'or description='TelecomRVT12101');
			teleModel5 := l.models[5].scores(description='Telecom'or description='TelecomRVT12101');
			teleModel6 := l.models[6].scores(description='Telecom'or description='TelecomRVT12101');								
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
		  self := L;
		  self := [];
		END;

		ds_with_extras := JOIN(Soap_output,soap_in,LEFT.accountnumber=RIGHT.accountnumber,normit(LEFT,RIGHT));

		//final file out to thor
		final_output := output(ds_with_extras,, outfile_name , thor, compressed, OVERWRITE);

		RETURN final_output;

ENDMACRO;