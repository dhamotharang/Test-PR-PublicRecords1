EXPORT RV_Scores_LN_IDA_XML_Macro(fcraroxie_IP, neutralroxie_IP, Thread, Timeout, retry, Input_file_name, Output_file_name, records_ToRun):= FUNCTIONMACRO

		IMPORT Models, iESP, Risk_Indicators, RiskWise, RiskProcessing, UT, Gateway;

		unsigned8 no_of_records := records_ToRun;
		integer eyeball := 50;
		integer retry := retry;
		integer timeout := timeout;
		integer threads := Thread;
		String neutralroxieIP := neutralroxie_IP ; 
		String fcraroxieIP := fcraroxie_IP;
		Infile_name :=  Input_file_name;
		String outfile_name :=  Output_file_name ;
    gateways := Gateway;

		//*********** SETTINGS ********************************

		DataRestrictionMask := '10000100010001';
		isFCRA := 'FCRA';
		company_ID := '101570';
		gateway_set := DATASET([{'neutralroxie', NeutralRoxieIP}], Risk_Indicators.Layout_Gateways_In) + 
															RiskWise.shortcuts.cert_gw_IDA;
		// export cert_gw_IDA := dataset( [{'idareport','https://rw_score_dev:Password01@10.176.68.164:8726/wsgatewayex/?ver_=2.84'}], risk_indicators.layout_gateways_in );// RiskWise.shortcuts.cert_gw_IDA
		
		AttributesVersion := '';  // AttributesVersion := 'riskviewattrv5';
    intendedPurpose := 'APPLICATION';
		
    // models		
		model1 := 'RVG2005_0'; //'RVG1502_0'; 
		model2 := ''; //'RVB1503_0'; 
		model3 := ''; //'RVA1503_0'; 
		model4 := ''; //'RVT1503_0'; 
		model5 := ''; //'RVS1706_0'; 
		
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
																	
		//*********** RV Attributes V5 XML SETUP AND SOAPCALL ******************

		soapLayout := RECORD
			DATASET(iesp.riskview2.t_RiskView2Request) RiskView2Request := DATASET([], iesp.riskview2.t_RiskView2Request);
			STRING HistoryDateTimeStamp := '';
			STRING _transactionid := '';
			// DATASET(Gateway.Layouts.Config) gateways := DATASET([], Gateway.Layouts.Config);
			DATASET(Risk_Indicators.Layout_Gateways_In) gateways := DATASET([], Risk_Indicators.Layout_Gateways_In);
		END;

		soapLayout intoSOAP(ds_raw_input le, UNSIGNED4 c) := TRANSFORM
			name := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_Name,
								SELF.First := le.FirstName;
								SELF.Middle := le.MiddleName;
								SELF.Last := le.LastName;
								SELF := []))[1];
			address := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_Address,
								SELF.StreetAddress1 := le.StreetAddress;
								SELF.City := le.City;
								SELF.State := le.State;
								SELF.Zip5 := le.Zip;
								SELF := []))[1];
			dob := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_Date,
								SELF.Year := (integer)le.DateOfBirth[1..4];
								SELF.Month := (integer)le.DateOfBirth[5..6];
								SELF.Day := (integer)le.DateOfBirth[7..8];
								SELF := []))[1];
			
			search := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.riskview2.t_RiskView2SearchBy,
								self.seq := (string)le.AccountNumber;
								SELF.Name := name;
								SELF.Address := address;
								SELF.DOB := dob;
								SELF.SSN := le.SSN;
								SELF.DriverLicenseNumber := le.DLNumber;
								SELF.DriverLicenseState := le.DLState;
								SELF.HomePhone := le.HomePhone;
								SELF.WorkPhone := le.WorkPhone;
								SELF := []));
			
			models := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.riskview2.t_RiskView2Models,
								SELF.Names := IF(model1 <> '', DATASET([{model1}], iesp.share.t_StringArrayItem), DATASET([], iesp.share.t_StringArrayItem)) + 
															IF(model2 <> '', DATASET([{model2}], iesp.share.t_StringArrayItem), DATASET([], iesp.share.t_StringArrayItem)) +
															IF(model3 <> '', DATASET([{model3}], iesp.share.t_StringArrayItem), DATASET([], iesp.share.t_StringArrayItem)) +
															IF(model4 <> '', DATASET([{model4}], iesp.share.t_StringArrayItem), DATASET([], iesp.share.t_StringArrayItem)) +
															IF(model5 <> '', DATASET([{model5}], iesp.share.t_StringArrayItem), DATASET([], iesp.share.t_StringArrayItem)) ;
															
								SELF.ModelOptions := DATASET([], iesp.riskview_share.t_ModelOptionRV);
								SELF := []));
			option := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.riskview2.t_RiskView2Options,
								SELF.IncludeModels := models[1];
								SELF.AttributesVersionRequest := AttributesVersion;
								SELF.IncludeReport := FALSE; 
								// self.FFDOptionsMask := (string)FFD;
								SELF.IntendedPurpose := intendedPurpose;
								SELF := []));
			
			users := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_User,
								SELF.DataRestrictionMask := DataRestrictionMask;
								SELF.CompanyId := company_ID;
								SELF.AccountNumber := (STRING) le.AccountNumber;
								SELF.TestDataEnabled := FALSE;
								SELF.OutcomeTrackingOptOut := TRUE;
								SELF := []));
			
			SELF.RiskView2Request := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.riskview2.t_RiskView2Request, 
								SELF.SearchBy := search[1];
								SELF.Options := option[1];
								SELF.User := users[1];
								SELF := []));
			
			SELF.HistoryDateTimeStamp := (string)HistoryDate;
			SELF._transactionid := 'QATEST_' + c;
			SELF.Gateways := gateway_set;
		END;

	  //ds_soap_in
		soap_in := DISTRIBUTE(PROJECT(ds_raw_input, intoSOAP(LEFT, COUNTER)), RANDOM());
		
		//Soap output layout		
		layout_Soap_output := RECORD
			unsigned8 time_ms {xpath('_call_latency_ms')} := 0;  // picks up timing 
			iesp.riskview2.t_RiskView2Response;
			STRING errorcode;
		END;

		layout_Soap_output myFail(soap_in le) := TRANSFORM
			self.result.inputecho.seq := le.riskview2request[1].SearchBy.seq;
			SELF.errorcode := FAILCODE + FAILMESSAGE;
			SELF := le;
			SELF := [];
		END;

		// output(soap_in,,'~nkoubsky::in::IDA_XML_request',XML, overwrite, expire(2));

	  //*********** PERFORMING SOAPCALL TO ROXIE ************ 
		
		Soap_output := SOAPCALL(soap_in, 
						FCRARoxieIP,
						'RiskView.Search_Service', 
						{soap_in}, 
						DATASET(layout_Soap_output),
						RETRY(RETRY), TIMEOUT(timeout),
						PARALLEL(threads), onFail(myFail(LEFT)));
		
		// ***************************************************************************************************
		// *********************** Transform into layout for use in daily reports ****************************
		// ***************************************************************************************************
		
		//GLOBAL OUTPUT LAYOUT
		Global_output_lay:= RECORD	 
				unsigned8 time_ms := 0;  
				string accountnumber;
				string30 acctno;
				string12  LexID;
				string3 Custom_Index;
				string30 Custom_Score_Name := '';
				string3 Custom_score;
				string3 Custom_reason1;
				string3 Custom_reason2;
				string3 Custom_reason3;
				string3 Custom_reason4;
				string3 Custom_reason5;
				string4 Alert1;
				string4 Alert2;
				string4 Alert3;
				string4 Alert4;
				string4 Alert5;
				string4 Alert6;
				string4 Alert7;
				string4 Alert8;
				string4 Alert9;
				string4 Alert10;
				STRING errorcode;
				RiskProcessing.layout_internal_extras;	
		END;

    //Mapping Version5 attributes 	
		flattened_result := project(Soap_output, 
			transform(Global_output_lay,
			self.time_ms := left.time_ms;			
			self.accountnumber := left.result.inputecho.seq,
			self.acctno := left.result.inputecho.seq,
			self.did := (integer)left.result.UniqueId;
			
			self.Custom_Index := '';
			self.Custom_Score_Name := left.result.models[1].name;
			self.Custom_score := (string)left.result.models[1].scores[1].value;
			self.Custom_reason1 := left.result.models[1].scores[1].ScoreReasons(sequence=1)[1].ReasonCode;
			self.Custom_reason2 := left.result.models[1].scores[1].ScoreReasons(sequence=2)[1].ReasonCode;
			self.Custom_reason3 := left.result.models[1].scores[1].ScoreReasons(sequence=3)[1].ReasonCode;
			self.Custom_reason4 := left.result.models[1].scores[1].ScoreReasons(sequence=4)[1].ReasonCode;
			self.Custom_reason5 := left.result.models[1].scores[1].ScoreReasons(sequence=5)[1].ReasonCode;

			self.Alert1 := left.result.alerts[1].code;
			self.Alert2 := left.result.alerts[2].code;
			self.Alert3 := left.result.alerts[3].code;
			self.Alert4 := left.result.alerts[4].code;
			self.Alert5 := left.result.alerts[5].code;
			self.Alert6 := left.result.alerts[6].code;
			self.Alert7 := left.result.alerts[7].code;
			self.Alert8 := left.result.alerts[8].code;
			self.Alert9 := left.result.alerts[9].code;
			self.Alert10 := left.result.alerts[10].code;
			self := left;
			self := []
			));
			
	  //Appeding internal extras to Soap output file 
		Global_output_lay normit(flattened_result L, soap_in R) := TRANSFORM
			self.historydate := (STRING)r.HistoryDateTimeStamp;
			self.FNamePop := r.RiskView2Request[1].SearchBy.Name.First<>'';
			self.LNamePop := r.RiskView2Request[1].SearchBy.Name.Last<>'';
			self.AddrPop := r.RiskView2Request[1].SearchBy.Address.StreetAddress1<>'';
			self.SSNLength := (STRING)(length(trim(r.RiskView2Request[1].SearchBy.ssn,left,right))) ;
			self.DOBPop := r.RiskView2Request[1].SearchBy.dob.year<>0 and r.RiskView2Request[1].SearchBy.dob.year<>0 and r.RiskView2Request[1].SearchBy.dob.year<>0 ;
			self.IPAddrPop := r.RiskView2Request[1].SearchBy.ipaddress<>'';
			self.HPhnPop := r.RiskView2Request[1].SearchBy.HomePhone<>'';
		  self := L;
			self := [];
		END;
				 
		ds_with_extras := JOIN(flattened_result,soap_in,LEFT.accountnumber=(STRING)RIGHT.RiskView2Request[1].user.accountnumber,normit(LEFT,RIGHT));

		final_output := output(ds_with_extras ,,outfile_name, thor, compressed, overwrite);
		
		RETURN final_output;
ENDMACRO; 