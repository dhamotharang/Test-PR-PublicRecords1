EXPORT RV_Scores_Attributes_V4_XML_Macro(fcraroxie_IP, neutralroxie_IP, Thread, Timeout, Retry, Input_file_name, Output_file_name1_score, Output_file_name2_attr, records_ToRun):= FUNCTIONMACRO
//rvp1104_0 8/15 deprecated depmsey

IMPORT Models, iESP, Risk_Indicators, RiskWise, RiskProcessing, UT;

		unsigned8 no_of_records := records_ToRun;
		integer eyeball := 50;
		integer retry := retry;
		integer timeout := timeout;
		integer threads := Thread;
		String neutralroxieIP := neutralroxie_IP ; 
		String fcraroxieIP := fcraroxie_IP ;
		Infile_name :=  Input_file_name;
		String outfile_name1 :=  Output_file_name1_score ;
		String outfile_name2 :=  Output_file_name2_attr ;
		
		
		DRM:=Scoring_Project_PIP.User_Settings_Module.RV_Scores_V4_XML_Generic_settings.DRM;
		
		// PCG_Dev := 'http://delta_dempers_dev:g0n0l3s!@10.176.68.149:7720/WsSupport/?ver_=2.0'; //-- testing on DEV servers
		PCG_Cert := 'http://ln_api_dempsey_dev:g0n0l3s!@10.176.68.149:7720/WsSupport/?ver_=2.0'; //-- testing on DEV servers
		integer FFD := 1;

    HistoryDate := 999999;

		//*****************************************************

	  //************** INPUT FILE GENERATION ****************	

		layout_input := RECORD
			Scoring_Project_Macros.Regression.global_layout;
			Scoring_Project_Macros.Regression.pii_layout;
			Scoring_Project_Macros.Regression.runtime_layout;
		END;

		ds_raw_input := distribute(IF(no_of_records = 0, 
										DATASET(Infile_name, layout_input, thor),
										CHOOSEN(DATASET(Infile_name, layout_input, thor), no_of_records)),(integer)accountnumber);

    //*********** RV Scores V4 XML SETUP AND SOAPCALL ******************
 Layout_Attributes_In := RECORD
			string name;
		END;
		
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
			integer HistoryDateYYYYMM;
			boolean Attributes := false;
			dataset(Layout_Attributes_In) RequestedAttributeGroups;
			dataset(Models.Layout_Score_Chooser) scores;
			dataset(Risk_Indicators.Layout_Gateways_In) gateways;
			unsigned6 did;
			string FFDOptionsMask ;
			string IntendedPurpose := '';
		end;

		// version 4 models
		paramsA := dataset([{'Custom', 'rva1104_0'}], models.Layout_Parameters);	
		paramsB := dataset([{'Custom', 'rvb1104_0'}], models.Layout_Parameters);	
		paramsR := dataset([{'Custom', 'rvr1103_0'}], models.Layout_Parameters);
		paramsT := dataset([{'Custom', 'rvt1104_0'}], models.Layout_Parameters);	
		paramsM := dataset([{'Custom', 'rvg1103_0'}], models.Layout_Parameters);
		// paramsP := dataset([{'Custom', 'rvp1104_0'}], models.Layout_Parameters);	//8/15 deprecated depmsey

		layout_soap append_settings(ds_raw_input le, INTEGER c) := TRANSFORM
			self.Accountnumber := (STRING)le.accountnumber;	
			SELF.Attributes := True;
			SELF.RequestedAttributeGroups := dataset([{'version4'}], layout_attributes_in);	
			// use this for all 6 scores
			self.scores := dataset([{'Models.RVAuto_Service', fcraroxieIP, paramsA},{'Models.RVBankCard_Service', fcraroxieIP,paramsB},
								            	{'Models.RVRetail_Service', fcraroxieIP,paramsR},{'Models.RVTelecom_Service', fcraroxieIP,paramsT},
								            	{'Models.RVMoney_Service', fcraroxieIP,paramsM}],
									             models.Layout_Score_Chooser);  
			// self.gateways := dataset([{'neutralroxie', neutralroxieIP}], risk_indicators.Layout_Gateways_In);
			SELF.Gateways := DATASET([{'neutralroxie', NeutralRoxieIP}, // TransUnion Gateway
											{'delta_personcontext', PCG_Cert}], Risk_Indicators.Layout_Gateways_In);
			self.IntendedPurpose := '';
			self.HistoryDateYYYYMM := HistoryDate;
			self.datarestrictionmask := DRM;
			self.FFDOptionsMask := (string)FFD;

			self := le;
			self := [];
		END;
		
    //ds_soap_in
		soap_in := DISTRIBUTE(PROJECT(ds_raw_input, append_settings(LEFT, counter)), Random());


Layout_Attribute := RECORD, maxlength(100000)
			DATASET(Models.Layout_Parameters) Attribute;
		END;
		
		Layout_AttributeGroup := RECORD, maxlength(100000)
			string name;
			string index;
			DATASET(Layout_Attribute) Attributes;
		END;
		
		layout_RVAttributesOut := RECORD, maxlength(100000)
			string30 accountnumber;
			DATASET(Layout_AttributeGroup) AttributeGroup;
		END;
		
	

		// run the prescreen score as seperate soapcall so you can send in the intended purpose
		//ds_soap_in_prescreen
		// 8/15 deprecated depmsey
		/*
		soap_in_prescreen := PROJECT(soap_in,TRANSFORM(layout_soap,
			                                     self.IntendedPurpose := 'PRESCREENING'; 
																					 self.scores := dataset([{'Models.RVPrescreen_Service', fcraroxieIP,paramsP}], models.Layout_Score_Chooser); 
																					 self := LEFT));*/

		//Soap output layout
		layout_Soap_output := RECORD
	unsigned8 time_ms {xpath('_call_latency_ms')} := 0;  // picks up timing 

			STRING30 AccountNumber;
			unsigned6 did := 0;
			Layout_RVAttributesOut AttributeGroups;
			DATASET(Models.Layout_Model) models;
			STRING errorcode;
		END;

		layout_Soap_output myFail(soap_in le) := TRANSFORM
			SELF.errorcode := FAILCODE + FAILMESSAGE;
			// self.time_ms := le.time_ms;  
			self.AccountNumber:=le.AccountNumber;
			SELF := le;
			SELF := [];
		END;
		
		//*********** PERFORMING SOAPCALL TO ROXIE ************ 

		Soap_output := soapcall(soap_in, fcraroxieIP,
						'Models.RiskView_Testing_Service', {soap_in}, 
						DATASET(layout_Soap_output),
						RETRY(retry), TIMEOUT(timeout), 
						PARALLEL(threads), onFail(myFail(LEFT)));
						
		// 8/15 deprecated depmsey
		/*				
		Soap_output_prescreen := soapcall(soap_in_prescreen, fcraroxieIP,
						'Models.RiskView_Testing_Service', {soap_in_prescreen}, 
						DATASET(layout_Soap_output),
						RETRY(retry), TIMEOUT(timeout), 
						PARALLEL(threads), onFail(myFail(LEFT)));*/
	
					
		// ***************************************************************************************************
		// *********************** Transform into layout for use in daily reports ****************************
		// ***************************************************************************************************
	  
		//GLOBAL OUTPUT LAYOUT
		Global_output_lay:= RECORD	 
		  Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_Generic_allflagships_V4_Global_Layout;			 
		END;

    //Appeding additional internal extras to Soap output file 
		//Mapping Version4 scores and reason codes
		Global_output_lay v4_trans(Soap_output L, soap_in R) := transform
			self.time_ms := l.time_ms;  
			
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
			
			// 8/15 deprecated depmsey
		/*				
			presModel1 := l.models[1].scores(description='PreScreen');
			presModel2 := l.models[2].scores(description='PreScreen');
			presModel3 := l.models[3].scores(description='PreScreen');
			presModel4 := l.models[4].scores(description='PreScreen');
			presModel5 := l.models[5].scores(description='PreScreen');
			presModel6 := l.models[6].scores(description='PreScreen');*/

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
			// 8/15 deprecated depmsey
		/*											
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
											'');	*/	
			self := L;
		  self := [];
		END;

		ds_with_extras := JOIN(Soap_output,soap_in,LEFT.accountnumber=RIGHT.accountnumber,v4_trans(LEFT,RIGHT));

		// ds_prescreen := JOIN(Soap_output_prescreen,soap_in_prescreen,LEFT.accountnumber=RIGHT.accountnumber,v4_trans(LEFT,RIGHT));

		//appening prescreen scores	 
					// 8/15 deprecated depmsey
		/*		
		ds_final := join(ds_with_extras, ds_prescreen, left.acctno=right.acctno, transform(Global_output_lay, 
																															self.rv_score_prescreen := right.rv_score_prescreen;
																															self.RV_prescreen_reason := right.rv_prescreen_reason;
																															self.errorcode := left.errorcode + right.errorcode;
																															self := left) );*/
	
Global_output_lay2:= RECORD	 
		Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_XML_Generic_Attributes_V4_Global_Layout;			 
		END;
			
		//Appeding additional internal extras to Soap output file 
		//Mapping Version4 attributes to v4 attributes
		Global_output_lay2 v4_trans_attr(Soap_output L, soap_in R) := transform
		self.time_ms := l.time_ms;
			self.seq := (unsigned)l.accountnumber;
			self.AccountNumber := l.AccountNumber;
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
			self.errorcode := l.errorcode;				
			self.AgeOldestRecord	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='AgeOldestRecord')[1].value;
			self.AgeNewestRecord	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='AgeNewestRecord')[1].value;
			self.RecentUpdate	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='RecentUpdate')[1].value;
			self.SrcsConfirmIDAddrCount	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SrcsConfirmIDAddrCount')[1].value;
			self.InvalidDL	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InvalidDL')[1].value;
			self.VerificationFailure	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='VerificationFailure')[1].value;
			self.SSNNotFound	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SSNNotFound')[1].value;
			self.VerifiedName	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='VerifiedName')[1].value;
			self.VerifiedSSN	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='VerifiedSSN')[1].value;
			self.VerifiedPhone	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='VerifiedPhone')[1].value;
			self.VerifiedAddress	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='VerifiedAddress')[1].value;
			self.VerifiedDOB	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='VerifiedDOB')[1].value;
			self.InferredMinimumAge	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InferredMinimumAge')[1].value;
			self.BestReportedAge	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='BestReportedAge')[1].value;
			self.SubjectSSNCount	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SubjectSSNCount')[1].value;
			self.SubjectAddrCount	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SubjectAddrCount')[1].value;
			self.SubjectPhoneCount	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SubjectPhoneCount')[1].value;
			self.SubjectSSNRecentCount	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SubjectSSNRecentCount')[1].value;
			self.SubjectAddrRecentCount	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SubjectAddrRecentCount')[1].value;
			self.SubjectPhoneRecentCount	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SubjectPhoneRecentCount')[1].value;
			self.SSNIdentitiesCount	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SSNIdentitiesCount')[1].value;
			self.SSNAddrCount	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SSNAddrCount')[1].value;
			self.SSNIdentitiesRecentCount	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SSNIdentitiesRecentCount')[1].value;
			self.SSNAddrRecentCount	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SSNAddrRecentCount')[1].value;
			self.InputAddrPhoneCount	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrPhoneCount')[1].value;
			self.InputAddrPhoneRecentCount	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrPhoneRecentCount')[1].value;
			self.PhoneIdentitiesCount	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PhoneIdentitiesCount')[1].value;
			self.PhoneIdentitiesRecentCount	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PhoneIdentitiesRecentCount')[1].value;
			self.SSNAgeDeceased	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SSNAgeDeceased')[1].value;
			self.SSNRecent	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SSNRecent')[1].value;
			self.SSNLowIssueAge	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SSNLowIssueAge')[1].value;
			self.SSNHighIssueAge	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SSNHighIssueAge')[1].value;
			self.SSNIssueState	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SSNIssueState')[1].value;
			self.SSNNonUS	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SSNNonUS')[1].value;
			self.SSN3Years	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SSN3Years')[1].value;
			self.SSNAfter5 	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SSNAfter5')[1].value;
			self.SSNProblems	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SSNProblems')[1].value;
			self.InputAddrAgeOldestRecord	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrAgeOldestRecord')[1].value;
			self.InputAddrAgeNewestRecord	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrAgeNewestRecord')[1].value;
			self.InputAddrHistoricalMatch	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrHistoricalMatch')[1].value;
			self.InputAddrLenOfRes 	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrLenOfRes')[1].value;
			self.InputAddrDwellType 	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrDwellType')[1].value;
			self.InputAddrDelivery	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrDelivery')[1].value;
			self.InputAddrApplicantOwned	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrApplicantOwned')[1].value;
			self.InputAddrFamilyOwned	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrFamilyOwned')[1].value;
			self.InputAddrOccupantOwned 	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrOccupantOwned')[1].value;
			self.InputAddrAgeLastSale	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrAgeLastSale')[1].value;
			self.InputAddrLastSalesPrice	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrLastSalesPrice')[1].value;
			self.InputAddrMortgageType	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrMortgageType')[1].value;
			self.InputAddrNotPrimaryRes 	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrNotPrimaryRes')[1].value;
			self.InputAddrActivePhoneList 	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrActivePhoneList')[1].value;
			self.InputAddrTaxValue 	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrTaxValue')[1].value;
			self.InputAddrTaxYr	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrTaxYr')[1].value;
			self.InputAddrTaxMarketValue	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrTaxMarketValue')[1].value;
			self.InputAddrAVMValue	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrAVMValue')[1].value;
			self.InputAddrAVMValue12	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrAVMValue12')[1].value;
			self.InputAddrAVMValue60	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrAVMValue60')[1].value;
			self.InputAddrCountyIndex	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrCountyIndex')[1].value;
			self.InputAddrTractIndex	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrTractIndex')[1].value;
			self.InputAddrBlockIndex	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrBlockIndex')[1].value;
			self.CurrAddrAgeOldestRecord	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='CurrAddrAgeOldestRecord')[1].value;
			self.CurrAddrAgeNewestRecord	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='CurrAddrAgeNewestRecord')[1].value;
			self.CurrAddrLenOfRes 	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='CurrAddrLenOfRes')[1].value;
			self.CurrAddrDwellType 	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='CurrAddrDwellType')[1].value;
			self.CurrAddrApplicantOwned 	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='CurrAddrApplicantOwned')[1].value;
			self.CurrAddrFamilyOwned 	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='CurrAddrFamilyOwned')[1].value;
			self.CurrAddrOccupantOwned 	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='CurrAddrOccupantOwned')[1].value;
			self.CurrAddrAgeLastSale	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='CurrAddrAgeLastSale')[1].value;
			self.CurrAddrLastSalesPrice	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='CurrAddrLastSalesPrice')[1].value;
			self.CurrAddrMortgageType	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='CurrAddrMortgageType')[1].value;
			self.CurrAddrActivePhoneList 	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='CurrAddrActivePhoneList')[1].value;
			self.CurrAddrTaxValue 	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='CurrAddrTaxValue')[1].value;
			self.CurrAddrTaxYr	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='CurrAddrTaxYr')[1].value;
			self.CurrAddrTaxMarketValue	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='CurrAddrTaxMarketValue')[1].value;
			self.CurrAddrAVMValue	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='CurrAddrAVMValue')[1].value;
			self.CurrAddrAVMValue12	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='CurrAddrAVMValue12')[1].value;
			self.CurrAddrAVMValue60	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='CurrAddrAVMValue60')[1].value;
			self.CurrAddrCountyIndex	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='CurrAddrCountyIndex')[1].value;
			self.CurrAddrTractIndex	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='CurrAddrTractIndex')[1].value;
			self.CurrAddrBlockIndex	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='CurrAddrBlockIndex')[1].value;
			self.PrevAddrAgeOldestRecord	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PrevAddrAgeOldestRecord')[1].value;
			self.PrevAddrAgeNewestRecord	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PrevAddrAgeNewestRecord')[1].value;
			self.PrevAddrLenOfRes 	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PrevAddrLenOfRes')[1].value;
			self.PrevAddrDwellType 	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PrevAddrDwellType')[1].value;
			self.PrevAddrApplicantOwned 	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PrevAddrApplicantOwned')[1].value;
			self.PrevAddrFamilyOwned 	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PrevAddrFamilyOwned')[1].value;
			self.PrevAddrOccupantOwned	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PrevAddrOccupantOwned')[1].value;
			self.PrevAddrAgeLastSale	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PrevAddrAgeLastSale')[1].value;
			self.PrevAddrLastSalesPrice	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PrevAddrLastSalesPrice')[1].value;
			self.PrevAddrTaxValue	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PrevAddrTaxValue')[1].value;
			self.PrevAddrTaxYr	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PrevAddrTaxYr')[1].value;
			self.PrevAddrTaxMarketValue	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PrevAddrTaxMarketValue')[1].value;
			self.PrevAddrAVMValue	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PrevAddrAVMValue')[1].value;
			self.PrevAddrCountyIndex	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PrevAddrCountyIndex')[1].value;
			self.PrevAddrTractIndex	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PrevAddrTractIndex')[1].value;
			self.PrevAddrBlockIndex	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PrevAddrBlockIndex')[1].value;
			self.AddrMostRecentDistance	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='AddrMostRecentDistance')[1].value;
			self.AddrMostRecentStateDiff	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='AddrMostRecentStateDiff')[1].value;
			self.AddrMostRecentTaxDiff	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='AddrMostRecentTaxDiff')[1].value;
			self.AddrMostRecentMoveAge	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='AddrMostRecentMoveAge')[1].value;
			self.AddrRecentEconTrajectory	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='AddrRecentEconTrajectory')[1].value;
			self.AddrRecentEconTrajectoryIndex	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='AddrRecentEconTrajectoryIndex')[1].value;
			self.EducationAttendedCollege	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='EducationAttendedCollege')[1].value;
			self.EducationProgram2Yr	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='EducationProgram2Yr')[1].value;
			self.EducationProgram4Yr	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='EducationProgram4Yr')[1].value;
			self.EducationProgramGraduate	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='EducationProgramGraduate')[1].value;
			self.EducationInstitutionPrivate	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='EducationInstitutionPrivate')[1].value;
			self.EducationFieldofStudyType	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='EducationFieldofStudyType')[1].value;
			self.EducationInstitutionRating	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='EducationInstitutionRating')[1].value;
			self.AddrStability 	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='AddrStability')[1].value;
			self.StatusMostRecent 	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='StatusMostRecent')[1].value;
			self.StatusPrevious 	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='StatusPrevious')[1].value;
			self.StatusNextPrevious	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='StatusNextPrevious')[1].value;
			self.AddrChangeCount01	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='AddrChangeCount01')[1].value;
			self.AddrChangeCount03	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='AddrChangeCount03')[1].value;
			self.AddrChangeCount06	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='AddrChangeCount06')[1].value;
			self.AddrChangeCount12	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='AddrChangeCount12')[1].value;
			self.AddrChangeCount24 	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='AddrChangeCount24')[1].value;
			self.AddrChangeCount60 	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='AddrChangeCount60')[1].value;
			self.EstimatedAnnualIncome	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='EstimatedAnnualIncome')[1].value;
			self.PropertyOwner	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PropertyOwner')[1].value;
			self.PropOwnedCount	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PropOwnedCount')[1].value;
			self.PropOwnedTaxTotal	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PropOwnedTaxTotal')[1].value;
			self.PropOwnedHistoricalCount	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PropOwnedHistoricalCount')[1].value;
			self.PropAgeOldestPurchase	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PropAgeOldestPurchase')[1].value;
			self.PropAgeNewestPurchase	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PropAgeNewestPurchase')[1].value;
			self.PropAgeNewestSale	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PropAgeNewestSale')[1].value;
			self.PropNewestSalePrice	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PropNewestSalePrice')[1].value;
			self.PropNewestSalePurchaseIndex	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PropNewestSalePurchaseIndex')[1].value;
			self.PropPurchasedCount01	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PropPurchasedCount01')[1].value;
			self.PropPurchasedCount03	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PropPurchasedCount03')[1].value;
			self.PropPurchasedCount06	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PropPurchasedCount06')[1].value;
			self.PropPurchasedCount12	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PropPurchasedCount12')[1].value;
			self.PropPurchasedCount24	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PropPurchasedCount24')[1].value;
			self.PropPurchasedCount60	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PropPurchasedCount60')[1].value;
			self.PropSoldCount01	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PropSoldCount01')[1].value;
			self.PropSoldCount03	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PropSoldCount03')[1].value;
			self.PropSoldCount06	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PropSoldCount06')[1].value;
			self.PropSoldCount12	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PropSoldCount12')[1].value;
			self.PropSoldCount24 	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PropSoldCount24')[1].value;
			self.PropSoldCount60 	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PropSoldCount60')[1].value;
			self.AssetOwner	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='AssetOwner')[1].value;
			self.WatercraftOwner	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='WatercraftOwner')[1].value;
			self.WatercraftCount	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='WatercraftCount')[1].value;
			self.WatercraftCount01	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='WatercraftCount01')[1].value;
			self.WatercraftCount03	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='WatercraftCount03')[1].value;
			self.WatercraftCount06	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='WatercraftCount06')[1].value;
			self.WatercraftCount12 	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='WatercraftCount12')[1].value;
			self.WatercraftCount24	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='WatercraftCount24')[1].value;
			self.WatercraftCount60 	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='WatercraftCount60')[1].value;
			self.AircraftOwner	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='AircraftOwner')[1].value;
			self.AircraftCount	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='AircraftCount')[1].value;
			self.AircraftCount01	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='AircraftCount01')[1].value;
			self.AircraftCount03	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='AircraftCount03')[1].value;
			self.AircraftCount06	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='AircraftCount06')[1].value;
			self.AircraftCount12 	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='AircraftCount12')[1].value;
			self.AircraftCount24	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='AircraftCount24')[1].value;
			self.AircraftCount60 	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='AircraftCount60')[1].value;
			self.WealthIndex 	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='WealthIndex')[1].value;
			self.BusinessActiveAssociation	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='BusinessActiveAssociation')[1].value;
			self.BusinessInactiveAssociation	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='BusinessInactiveAssociation')[1].value;
			self.BusinessAssociationAge	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='BusinessAssociationAge')[1].value;
			self.BusinessTitle	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='BusinessTitle')[1].value;
			self.DerogSeverityIndex	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='DerogSeverityIndex')[1].value;
			self.DerogCount	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='DerogCount')[1].value;
			self.DerogRecentCount	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='DerogRecentCount')[1].value;
			self.DerogAge	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='DerogAge')[1].value;
			self.FelonyCount	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='FelonyCount')[1].value;
			self.FelonyAge	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='FelonyAge')[1].value;
			self.FelonyCount01	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='FelonyCount01')[1].value;
			self.FelonyCount03	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='FelonyCount03')[1].value;
			self.FelonyCount06	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='FelonyCount06')[1].value;
			self.FelonyCount12	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='FelonyCount12')[1].value;
			self.FelonyCount24	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='FelonyCount24')[1].value;
			self.FelonyCount60	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='FelonyCount60')[1].value;
			self.LienCount	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienCount')[1].value;
			self.LienFiledCount	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienFiledCount')[1].value;
			self.LienFiledAge	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienFiledAge')[1].value;
			self.LienFiledCount01	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienFiledCount01')[1].value;
			self.LienFiledCount03	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienFiledCount03')[1].value;
			self.LienFiledCount06	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienFiledCount06')[1].value;
			self.LienFiledCount12	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienFiledCount12')[1].value;
			self.LienFiledCount24	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienFiledCount24')[1].value;
			self.LienFiledCount60	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienFiledCount60')[1].value;
			self.LienReleasedCount	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienReleasedCount')[1].value;
			self.LienReleasedAge	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienReleasedAge')[1].value;
			self.LienReleasedCount01	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienReleasedCount01')[1].value;
			self.LienReleasedCount03	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienReleasedCount03')[1].value;
			self.LienReleasedCount06	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienReleasedCount06')[1].value;
			self.LienReleasedCount12	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienReleasedCount12')[1].value;
			self.LienReleasedCount24	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienReleasedCount24')[1].value;
			self.LienReleasedCount60	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienReleasedCount60')[1].value;
			self.LienFiledTotal	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienFiledTotal')[1].value;
			self.LienFederalTaxFiledTotal	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienFederalTaxFiledTotal')[1].value;
			self.LienTaxOtherFiledTotal	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienTaxOtherFiledTotal')[1].value;
			self.LienForeclosureFiledTotal	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienForeclosureFiledTotal')[1].value;
			self.LienLandlordTenantFiledTotal	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienLandlordTenantFiledTotal')[1].value;
			self.LienJudgmentFiledTotal	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienJudgmentFiledTotal')[1].value;
			self.LienSmallClaimsFiledTotal	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienSmallClaimsFiledTotal')[1].value;
			self.LienOtherFiledTotal	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienOtherFiledTotal')[1].value;
			self.LienReleasedTotal	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienReleasedTotal')[1].value;
			self.LienFederalTaxReleasedTotal	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienFederalTaxReleasedTotal')[1].value;
			self.LienTaxOtherReleasedTotal	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienTaxOtherReleasedTotal')[1].value;
			self.LienForeclosureReleasedTotal	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienForeclosureReleasedTotal')[1].value;
			self.LienLandlordTenantReleasedTotal	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienLandlordTenantReleasedTotal')[1].value;
			self.LienJudgmentReleasedTotal	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienJudgmentReleasedTotal')[1].value;
			self.LienSmallClaimsReleasedTotal	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienSmallClaimsReleasedTotal')[1].value;
			self.LienOtherReleasedTotal	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienOtherReleasedTotal')[1].value;
			self.LienFederalTaxFiledCount	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienFederalTaxFiledCount')[1].value;
			self.LienTaxOtherFiledCount	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienTaxOtherFiledCount')[1].value;
			self.LienForeclosureFiledCount	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienForeclosureFiledCount')[1].value;
			self.LienLandlordTenantFiledCount	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienLandlordTenantFiledCount')[1].value;
			self.LienJudgmentFiledCount	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienJudgmentFiledCount')[1].value;
			self.LienSmallClaimsFiledCount	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienSmallClaimsFiledCount')[1].value;
			self.LienOtherFiledCount	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienOtherFiledCount')[1].value;
			self.LienFederalTaxReleasedCount	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienFederalTaxReleasedCount')[1].value;
			self.LienTaxOtherReleasedCount	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienTaxOtherReleasedCount')[1].value;
			self.LienForeclosureReleasedCount	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienForeclosureReleasedCount')[1].value;
			self.LienLandlordTenantReleasedCount	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienLandlordTenantReleasedCount')[1].value;
			self.LienJudgmentReleasedCount	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienJudgmentReleasedCount')[1].value;
			self.LienSmallClaimsReleasedCount	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienSmallClaimsReleasedCount')[1].value;
			self.LienOtherReleasedCount	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienOtherReleasedCount')[1].value;
			self.BankruptcyCount	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='BankruptcyCount')[1].value;
			self.BankruptcyAge	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='BankruptcyAge')[1].value;
			self.BankruptcyType	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='BankruptcyType')[1].value;
			self.BankruptcyStatus	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='BankruptcyStatus')[1].value;
			self.BankruptcyCount01	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='BankruptcyCount01')[1].value;
			self.BankruptcyCount03	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='BankruptcyCount03')[1].value;
			self.BankruptcyCount06	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='BankruptcyCount06')[1].value;
			self.BankruptcyCount12	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='BankruptcyCount12')[1].value;
			self.BankruptcyCount24	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='BankruptcyCount24')[1].value;
			self.BankruptcyCount60	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='BankruptcyCount60')[1].value;
			self.EvictionCount	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='EvictionCount')[1].value;
			self.EvictionAge	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='EvictionAge')[1].value;
			self.EvictionCount01	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='EvictionCount01')[1].value;
			self.EvictionCount03	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='EvictionCount03')[1].value;
			self.EvictionCount06	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='EvictionCount06')[1].value;
			self.EvictionCount12 	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='EvictionCount12')[1].value;
			self.EvictionCount24 	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='EvictionCount24')[1].value;
			self.EvictionCount60 	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='EvictionCount60')[1].value;
			self.RecentActivityIndex	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='RecentActivityIndex')[1].value;
			self.NonDerogCount	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='NonDerogCount')[1].value;
			self.NonDerogCount01	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='NonDerogCount01')[1].value;
			self.NonDerogCount03	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='NonDerogCount03')[1].value;
			self.NonDerogCount06	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='NonDerogCount06')[1].value;
			self.NonDerogCount12	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='NonDerogCount12')[1].value;
			self.NonDerogCount24	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='NonDerogCount24')[1].value;
			self.NonDerogCount60	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='NonDerogCount60')[1].value;
			self.VoterRegistrationRecord	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='VoterRegistrationRecord')[1].value;
			self.ProfLicCount	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='ProfLicCount')[1].value;
			self.ProfLicAge	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='ProfLicAge')[1].value;
			self.ProfLicType	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='ProfLicType')[1].value;
			self.ProfLicTypeCategory	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='ProfLicTypeCategory')[1].value;
			self.ProfLicExpired	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='ProfLicExpired')[1].value;
			self.ProfLicCount01	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='ProfLicCount01')[1].value;
			self.ProfLicCount03	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='ProfLicCount03')[1].value;
			self.ProfLicCount06	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='ProfLicCount06')[1].value;
			self.ProfLicCount12	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='ProfLicCount12')[1].value;
			self.ProfLicCount24	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='ProfLicCount24')[1].value;
			self.ProfLicCount60	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='ProfLicCount60')[1].value;
			self.InquiryCollectionsRecent	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InquiryCollectionsRecent')[1].value;
			self.InquiryPersonalFinanceRecent	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InquiryPersonalFinanceRecent')[1].value;
			self.InquiryOtherRecent	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InquiryOtherRecent')[1].value;
			self.HighRiskCreditActivity	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='HighRiskCreditActivity')[1].value;
			self.SubPrimeOfferRequestCount	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SubPrimeOfferRequestCount')[1].value;
			self.SubPrimeOfferRequestCount01	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SubPrimeOfferRequestCount01')[1].value;
			self.SubPrimeOfferRequestCount03	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SubPrimeOfferRequestCount03')[1].value;
			self.SubPrimeOfferRequestCount06	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SubPrimeOfferRequestCount06')[1].value;
			self.SubPrimeOfferRequestCount12	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SubPrimeOfferRequestCount12')[1].value;
			self.SubPrimeOfferRequestCount24	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SubPrimeOfferRequestCount24')[1].value;
			self.SubPrimeOfferRequestCount60	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SubPrimeOfferRequestCount60')[1].value;
			self.InputPhoneMobile 	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputPhoneMobile')[1].value;
			self.PhoneEDAAgeOldestRecord	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PhoneEDAAgeOldestRecord')[1].value;
			self.PhoneEDAAgeNewestRecord	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PhoneEDAAgeNewestRecord')[1].value;
			self.PhoneOtherAgeOldestRecord	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PhoneOtherAgeOldestRecord')[1].value;
			self.PhoneOtherAgeNewestRecord	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PhoneOtherAgeNewestRecord')[1].value;
			self.InputPhoneHighRisk	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputPhoneHighRisk')[1].value;
			self.InputPhoneProblems	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputPhoneProblems')[1].value;
			self.EmailAddress	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='EmailAddress')[1].value;
			self.InputAddrHighRisk	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrHighRisk')[1].value;
			self.CurrAddrCorrectional	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='CurrAddrCorrectional')[1].value;
			self.PrevAddrCorrectional	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PrevAddrCorrectional')[1].value;
			self.HistoricalAddrCorrectional	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='HistoricalAddrCorrectional')[1].value;
			self.InputAddrProblems	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrProblems')[1].value;
			self.SecurityFreeze	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SecurityFreeze')[1].value;
			self.SecurityAlert	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SecurityAlert')[1].value;
			self.IDTheftFlag	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='IDTheftFlag')[1].value;
			self.ConsumerStatement	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='ConsumerStatement')[1].value;
			self.PrescreenOptOut	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PrescreenOptOut')[1].value;
		end;

		ds_slim := JOIN(Soap_output,soap_in,LEFT.accountnumber=RIGHT.accountnumber,v4_trans_attr(left,right));

		//scores	
	// output(ds_final,,outfile_name1, thor, compressed, overwrite );
	output(ds_with_extras,,outfile_name1, thor, compressed, overwrite );

		//final file out to thor
	output(ds_slim,, outfile_name2, thor, compressed, overwrite);	
			
		// output(Soap_output,named('Soap_output'));
		// output(soap_in,named('soap_in'));
		
return 0;
endmacro;
