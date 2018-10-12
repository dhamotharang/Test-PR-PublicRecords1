IMPORT Address, BusinessCredit_Services, Business_Risk_BIP, Gateway, iesp, Models, Risk_Indicators, Riskwise, ut;

EXPORT fn_SmallBusiness_getScores( DATASET(Business_Risk_BIP.Layouts.Input) Shell_Input, 
                                   Business_Risk_BIP.LIB_Business_Shell_LIBIN options, 
                                   SET OF STRING set_model_names = [] ) := 
	FUNCTION

		RESTRICTED_SET := ['0', ''];

		// Use the SBFE restriction to return Scores or not.
		allow_scores := options.DataPermissionMask[12] NOT IN RESTRICTED_SET;
	
		// 1. Run Business Shell.
		shell_results := Business_Risk_BIP.Business_Shell_Function(Shell_Input, options);
		shell_res_grpd := GROUP(SORT(shell_results,seq),seq);

		// 2. Run Consumer Shell to configure the Boca_Shell param for the SBBM1601_0_0 model.
		// Borrowed/stolen from LNSmallBusiness.SmallBusiness_BIP_Function.
		Gateways            := Gateway.Constants.void_gateway;
		DPPA_Purpose        := options.DPPA_Purpose;
		GLBA_Purpose        := options.GLBA_Purpose;
		IsUtility           := StringLib.StringToUpperCase(options.IndustryClass) = 'UTILI';
		IncludeRel          := TRUE;
		IncludeDL           := TRUE;
		IncludeVeh          := TRUE;
		IncludeDerog        := TRUE;
		BSVersion           := 50;
		IsFCRA              := FALSE;
		LN_Branded          := FALSE;
		OFAC_Only           := TRUE;
		SuppressNearDups    := FALSE;
		Require2ele         := FALSE;
		From_BIID           := FALSE;
		ExcludeWatchlists   := FALSE;
		From_IT1O           := FALSE;
		OFAC_Version        := 1;
		Include_OFAC        := FALSE;
		Addtl_Watchlists    := FALSE;
		Global_Watchlist_Threshold := options.Global_Watchlist_Threshold;
		DataRestrictionMask := options.DataRestrictionMask;
		DataPermissionMask  := options.DataPermissionMask;
		Watchlist_Threshold := 0.84;
		DOB_Radius          := -1;
		DoScore             := TRUE;
		Nugen               := TRUE;
		Include_DL_Verification     := TRUE;
		UNSIGNED1 AppendBest        := 1;   // search best file
		UNSIGNED3 LastSeenThreshold := Risk_Indicators.iid_constants.max_unsigned3;
		UNSIGNED8 BSOptions := 
			Risk_Indicators.iid_constants.BSOptions.IncludeFraudVelocity | Risk_Indicators.iid_constants.BSOptions.RetainInputDID;

		Layout_AcctNo := RECORD
			UNSIGNED4 input_seq;
			STRING30 acctno;
			Risk_Indicators.Layout_Input;
		END;
		
		Layout_AcctNo iidPrep(Shell_Input le, INTEGER c) := TRANSFORM
			// save input data for output
			SELF.input_seq := le.seq;
			SELF.acctno := le.acctno;
		
			SELF.seq := c; // input seq is overwritten. abandon all hope, ye who enter here.
			historydate := IF(le.HistoryDateTime = 0,
												risk_indicators.iid_constants.default_history_date,
												(UNSIGNED)(((STRING)le.HistoryDateTime)[1..6]));
			SELF.historydate := IF(le.historyDateTime > 0,(UNSIGNED)(((STRING)le.historyDateTime)[1..6]), historydate);								
			SELF.historyDateTimeStamp := risk_indicators.iid_constants.mygetdateTimeStamp((STRING)le.historydateTime, historydate);							
			SELF.ssn := le.Rep_SSN;
			SELF.dob := le.Rep_DateOfBirth;
			SELF.age := IF((INTEGER)le.Rep_Age = 0 and (INTEGER)le.Rep_DateOfBirth != 0,
							(STRING3)ut.Age((UNSIGNED)le.Rep_DateOfBirth, (UNSIGNED)risk_indicators.iid_constants.myGetDate(historydate)), 
							(STRING)((INTEGER)le.Rep_Age));
			SELF.phone10  := le.Rep_Phone10;
			
			cleaned_name := Address.CleanPerson73(le.Rep_FullName);
			BOOLEAN valid_cleaned := le.Rep_FullName <> '';
			
			SELF.fname  := StringLib.StringToUppercase(if(le.Rep_FirstName=''   AND valid_cleaned, cleaned_name[6..25], le.Rep_FirstName));
			SELF.lname  := StringLib.StringToUppercase(if(le.Rep_LastName=''    AND valid_cleaned, cleaned_name[46..65], le.Rep_LastName));
			SELF.mname  := StringLib.StringToUppercase(if(le.Rep_MiddleName=''  AND valid_cleaned, cleaned_name[26..45], le.Rep_MiddleName));
			SELF.suffix := StringLib.StringToUppercase(if(le.Rep_NameSuffix ='' AND valid_cleaned, cleaned_name[66..70], le.Rep_NameSuffix));	
			SELF.title  := StringLib.StringToUppercase(if(valid_cleaned, cleaned_name[1..5],''));

			Street_Address := risk_indicators.MOD_AddressClean.street_address(le.Rep_StreetAddress1);
			clean_a2 := risk_indicators.MOD_AddressClean.clean_addr(Street_Address, le.Rep_City, le.Rep_State, le.Rep_Zip ) ;											

			SELF.in_streetAddress := le.Rep_StreetAddress1;
			SELF.in_city          := le.Rep_City;
			SELF.in_state         := le.Rep_State;
			SELF.in_zipCode       := le.Rep_Zip;
				
			SELF.prim_range    := clean_a2[1..10];
			SELF.predir        := clean_a2[11..12];
			SELF.prim_name     := clean_a2[13..40];
			SELF.addr_suffix   := clean_a2[41..44];
			SELF.postdir       := clean_a2[45..46];
			SELF.unit_desig    := clean_a2[47..56];
			SELF.sec_range     := clean_a2[57..65];
			SELF.p_city_name   := clean_a2[90..114];
			SELF.st            := clean_a2[115..116];
			SELF.z5            := clean_a2[117..121];
			SELF.zip4          := clean_a2[122..125];
			SELF.lat           := clean_a2[146..155];
			SELF.long          := clean_a2[156..166];
			SELF.addr_type     := clean_a2[139];
			SELF.addr_status   := clean_a2[179..182];
			SELF.county        := clean_a2[143..145];
			SELF.geo_blk       := clean_a2[171..177];
			
			SELF.dl_number := StringLib.StringToUppercase(riskwise.cleanDL_num(le.Rep_DLNumber));
			SELF.dl_state  := StringLib.StringToUppercase(le.Rep_DLState);

			SELF := [];
		END;
		
		IID_Prep_Acct := PROJECT(Shell_Input, iidPrep(LEFT,COUNTER));

		IID_Prep := PROJECT(IID_Prep_Acct, Risk_Indicators.Layout_Input );
		
		IID  := Risk_Indicators.InstantID_Function(IID_Prep, Gateways,	DPPA_Purpose,	GLBA_Purpose, IsUtility, LN_Branded, OFAC_Only, SuppressNearDups, Require2ele, IsFCRA, 
						From_BIID, ExcludeWatchLists, From_IT1O, OFAC_Version, Include_OFAC, Addtl_Watchlists, Global_Watchlist_Threshold, DOB_Radius, BSVersion, In_DataRestriction := DataRestrictionMask, 
						in_runDLverification := include_DL_verification, in_append_best := AppendBest, in_BSOptions := BSOptions, in_LastSeenThreshold := LastSeenThreshold, in_DataPermission := DataPermissionMask);
		
		Clam := Risk_Indicators.Boca_Shell_Function(IID, Gateways,	DPPA_Purpose,	GLBA_Purpose, IsUtility, LN_Branded, IncludeRel, IncludeDL, IncludeVeh, IncludeDerog, BSVersion, DoScore, Nugen, DataRestriction := DataRestrictionMask, BSOptions := BSOptions, DataPermission := DataPermissionMask);																							 
		
		Blank_Boca_Shell := GROUP(DATASET([], Risk_Indicators.Layout_Boca_Shell), Seq);
		
		Boca_Shell_Grouped := IF(BusinessCredit_Services.Constants.BLENDED_SCORE_MODEL IN set_model_names or
		BusinessCredit_Services.Constants.BLENDED_SCORE_SLBB IN set_model_names or BusinessCredit_Services.Constants.BLENDED_SCORE_SLBBNFEL IN set_model_names, Clam, Blank_Boca_Shell); //don't call the boca shell if a model doesn't need it
				
		// 3. Run Business Shell results through models; include Boca_Shell_Grouped in the call to the SBBM model.
		Layout_ModelOut_pre := RECORD
			UNSIGNED Seq;
			STRING ModelName := '';
			// STRING _Type     := '';
			STRING MinRange  := '';
			STRING MaxRange  := '';
			STRING Score     := '';
			STRING RiskLevel := '';
			DATASET(Risk_Indicators.Layout_Desc) ri;
		END;
		
		setModelName(STRING Model_Name, DATASET(Models.Layout_ModelOut) Model_Results) := 
			FUNCTION
				with_model_name := 
					PROJECT(
						Model_Results, 
						TRANSFORM( Layout_ModelOut_pre, 
							SELF.ModelName := Model_Name,
							// SELF._Type := '0-900',
							SELF.MinRange := BusinessCredit_Services.Constants.MIN_SCORE_RANGE,
							SELF.MaxRange := BusinessCredit_Services.Constants.MAX_SCORE_RANGE,
							SELF.Score := LEFT.Score,
							SELF.RiskLevel :=
								MAP(
									(UNSIGNED)LEFT.Score BETWEEN 501 AND 650 => LNSmallBusiness.Constants.RISK_LEVEL_HIGH,
									(UNSIGNED)LEFT.Score BETWEEN 651 AND 750 => LNSmallBusiness.Constants.RISK_LEVEL_MEDIUM,
									(UNSIGNED)LEFT.Score BETWEEN 751 AND 900 => LNSmallBusiness.Constants.RISK_LEVEL_LOW,
									(UNSIGNED)LEFT.Score = 222               => LNSmallBusiness.Constants.RISK_LEVEL_NO_HIT,
									/* default...........................: */   LNSmallBusiness.Constants.RISK_LEVEL_DEFAULT								
								);
							SELF := LEFT
						)
					);
					
				RETURN with_model_name;
			END;
		
		Model_Results_pre :=  
			IF( BusinessCredit_Services.Constants.CREDIT_SCORE_MODEL IN set_model_names, // non-blended or Business Only model
					setModelName(BusinessCredit_Services.Constants.CREDIT_SCORE_MODEL, Models.LIB_BusinessRisk_Function(shell_res_grpd, BusinessCredit_Services.Constants.CREDIT_SCORE_MODEL)) ) + 		
			IF( BusinessCredit_Services.Constants.BLENDED_SCORE_MODEL IN set_model_names, // blended model
					setModelName(BusinessCredit_Services.Constants.BLENDED_SCORE_MODEL, Models.LIB_BusinessRisk_Function(shell_res_grpd, BusinessCredit_Services.Constants.BLENDED_SCORE_MODEL, Boca_Shell_Grouped)) ) + 
			IF( BusinessCredit_Services.Constants.CREDIT_SCORE_SLBO IN set_model_names, // non-blended or Business Only model
					setModelName(BusinessCredit_Services.Constants.CREDIT_SCORE_SLBO, Models.LIB_BusinessRisk_Function(shell_res_grpd, BusinessCredit_Services.Constants.CREDIT_SCORE_SLBO)) ) + 		
			IF( BusinessCredit_Services.Constants.BLENDED_SCORE_SLBB IN set_model_names, // blended model
					setModelName(BusinessCredit_Services.Constants.BLENDED_SCORE_SLBB, Models.LIB_BusinessRisk_Function(shell_res_grpd, BusinessCredit_Services.Constants.BLENDED_SCORE_SLBB, Boca_Shell_Grouped)) ) + 

			IF( BusinessCredit_Services.Constants.BLENDED_SCORE_SLBBNFEL IN set_model_names, // blended model no felonies
					setModelName(BusinessCredit_Services.Constants.BLENDED_SCORE_SLBBNFEL, Models.LIB_BusinessRisk_Function(shell_res_grpd, BusinessCredit_Services.Constants.BLENDED_SCORE_SLBBNFEL, Boca_Shell_Grouped)) ) + 
            IF( BusinessCredit_Services.Constants.CREDIT_SCORE_SLBONFEL IN set_model_names, // non-blended or Business Only model
					setModelName(BusinessCredit_Services.Constants.CREDIT_SCORE_SLBONFEL, Models.LIB_BusinessRisk_Function(shell_res_grpd, BusinessCredit_Services.Constants.CREDIT_SCORE_SLBONFEL)) ) + 	
       
			DATASET([], Layout_ModelOut_pre);

		Model_Results := IF( allow_scores or 
						(BusinessCredit_Services.Constants.BLENDED_SCORE_SLBB IN set_model_names OR
						BusinessCredit_Services.Constants.CREDIT_SCORE_SLBO IN set_model_names or
						BusinessCredit_Services.Constants.BLENDED_SCORE_SLBBNFEL IN set_model_names OR
						BusinessCredit_Services.Constants.CREDIT_SCORE_SLBONFEL IN set_model_names),
						Model_Results_pre, 
						DATASET([], Layout_ModelOut_pre) );

		// 3. Add Back our Input Echo.
		layout_ReasonCodes := RECORD
			STRING1 SeqNo;
			STRING5 ReasonCode;
			STRING150 ReasonCodeDesc;
		END;
		
		layout_ModelOut := RECORD
			STRING ModelName := '';
			// STRING _Type     := '';
			STRING MinRange  := '';
			STRING MaxRange  := '';
			STRING Score     := '';
			STRING RiskLevel := '';
			DATASET(layout_ReasonCodes) ReasonCodes;
		END;
		
		layout_PhoneSources := record
			STRING2 Source {xpath('Source')};
			STRING6 DateFirstSeen {xpath('DateFirstSeen')};
			STRING6 DateLastSeen {xpath('DateLastSeen')};
			UNSIGNED4 RecordCount {xpath('RecordCount')};
		end;		
		
		layout_out_rolled := RECORD
			Business_Risk_BIP.Layouts.Input;
			DATASET(Layout_ModelOut) ModelResults;
			DATASET(layout_PhoneSources) PhoneSources;
			UNSIGNED2 Weight;
		END;
		
		Layout_ModelOut getModelResults(Layout_ModelOut_pre le, STRING3 BIPID_Weight) :=
			TRANSFORM
				isHit := (UNSIGNED)BIPID_Weight >= BusinessCredit_Services.Constants.BIPID_WEIGHT_THRESHOLD;
				NoHit_ReasonCode := 'B068';
				
				ReasonCodes_Hit :=
					PROJECT(
						le.ri,
						TRANSFORM( layout_ReasonCodes,
							SELF.SeqNo := (STRING)COUNTER;
							SELF.ReasonCode := LEFT.hri;
							SELF.ReasonCodeDesc := LEFT.desc;						
						)
					);
					
				ReasonCodes_NoHit := 
					DATASET( 
						[
							{'1', NoHit_ReasonCode, Risk_Indicators.getHRIDesc(NoHit_ReasonCode)},
							{'2',               '',                                           ''},
							{'3',               '',                                           ''},
							{'4',               '',                                           ''}
						], 
						layout_ReasonCodes 
					);
				
				SELF.ModelName   := le.ModelName;
				// SELF._Type       := le._Type;
				SELF.MinRange    := le.MinRange;
				SELF.MaxRange    := le.MaxRange;
				SELF.Score       := IF( isHit, le.Score    , BusinessCredit_Services.Constants.NO_HIT_SCORE );
				SELF.RiskLevel   := IF( isHit, le.RiskLevel, LNSmallBusiness.Constants.RISK_LEVEL_NO_HIT );
				SELF.ReasonCodes := IF( isHit, ReasonCodes_Hit, ReasonCodes_NoHit );
			END;
		
		withScores := 
			JOIN(
				shell_results, Model_Results, 
				LEFT.Seq = RIGHT.Seq, 
				TRANSFORM( layout_out_rolled, 
						BIPID_Weight := LEFT.Verification.InputIDMatchConfidence;
					SELF.ModelResults := PROJECT(RIGHT, getModelResults(LEFT,BIPID_Weight));
					SELF.PhoneSources	:= IF( (UNSIGNED)LEFT.Verification.InputIDMatchConfidence >= BusinessCredit_Services.Constants.BIPID_WEIGHT_THRESHOLD, PROJECT(shell_res_grpd.phonesources, layout_PhoneSources), DATASET([], layout_PhoneSources) );
					SELF.Weight := (UNSIGNED2)BIPID_Weight;
					SELF := LEFT.Input_Echo;
				), 
				LEFT OUTER, 
				ATMOST(iesp.Constants.SBAnalytics.MaxModelCount));
		
		results := 
			ROLLUP(
				SORT(withScores, Seq), 
				LEFT.Seq = RIGHT.Seq, 
				TRANSFORM( layout_out_rolled,
					SELF.ModelResults := LEFT.ModelResults + RIGHT.ModelResults;
					SELF := LEFT));
						
		// OUTPUT( Shell_Input, NAMED('Shell_Input'));
		// OUTPUT( shell_results, NAMED('shell_results'));
		// OUTPUT( shell_res_grpd, NAMED('shell_res_grpd') );
		// OUTPUT( Model_Results, NAMED('Model_Results') );
		
		RETURN results;
	END;