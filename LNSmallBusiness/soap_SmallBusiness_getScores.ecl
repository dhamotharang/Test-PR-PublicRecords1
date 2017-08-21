// Called by Business_Credit_Scoring.fn_GetScores

IMPORT Business_Risk_BIP, iesp, Models, Risk_Indicators, RiskWise;

EXPORT soap_SmallBusiness_getScores( DATASET(Business_Risk_BIP.Layouts.Input) inputFile, 
                                   Business_Risk_BIP.LIB_Business_Shell_LIBIN options, 
                                   SET OF STRING set_model_names = [],
																	 UNSIGNED4 historydate = 0, // "archive date": YYYYMM, YYYYMMDD, or YYYYMMDDTTTT
																	 INTEGER threads = 2,
																	 STRING RoxieIP = RiskWise.shortcuts.prod_batch_neutral,
																	 INTEGER recordsToRun = 0) := 
	FUNCTION				
	
		// Description:
		// Run the Business Shell via SOAPCALL against Business_Risk_BIP.Business_Shell
		// _Service. Return the scores only, appended to "inputFile" passed in above.
		
		// 1. Some configurations.
		USE_RECORD_HISTORYDATE := 0;
		
		// Universally Set the History Date for ALL records. Set to 0 to use the History 
		// Date located on each record of the input file.
		histDate := historydate; // YYYYMM, YYYYMMDD, or YYYYMMDDTTTT
		
		// 2. Configure SOAPCALL. 
		
		SOAPLayout := RECORD
			INTEGER Seq;
			STRING AcctNo;
			STRING CompanyName;
			STRING AltCompanyName;
			STRING StreetAddress1;
			STRING StreetAddress2;
			STRING City;
			STRING State;
			STRING Zip9;
			STRING Prim_Range;
			STRING PreDir;
			STRING Prim_Name;
			STRING Addr_Suffix;
			STRING PostDir;
			STRING Unit_Desig;
			STRING Sec_Range;
			STRING Zip5;
			STRING Zip4;
			STRING Lat;
			STRING Long;
			STRING Addr_Type; 
			STRING Addr_Status;
			STRING County;
			STRING Geo_Block;
			STRING FEIN;
			STRING Phone10;
			STRING IPAddr;
			STRING CompanyURL;
			STRING Rep_FullName;
			STRING Rep_NameTitle;
			STRING Rep_FirstName;
			STRING Rep_MiddleName;
			STRING Rep_LastName;
			STRING Rep_NameSuffix;
			STRING Rep_FormerLastName;
			STRING Rep_StreetAddress1;
			STRING Rep_StreetAddress2;
			STRING Rep_City;
			STRING Rep_State;
			STRING Rep_Zip;
			STRING Rep_Prim_Range;
			STRING Rep_PreDir;
			STRING Rep_Prim_Name;
			STRING Rep_Addr_Suffix;
			STRING Rep_PostDir;
			STRING Rep_Unit_Desig;
			STRING Rep_Sec_Range;
			STRING Rep_Zip5;
			STRING Rep_Zip4;
			STRING Rep_Lat;
			STRING Rep_Long;
			STRING Rep_Addr_Type;
			STRING Rep_Addr_Status;
			STRING Rep_County;
			STRING Rep_Geo_Block;
			STRING Rep_SSN;
			STRING Rep_DateOfBirth;
			STRING Rep_Phone10;
			STRING Rep_Age;
			STRING Rep_DLNumber;
			STRING Rep_DLState;
			STRING Rep_Email;
			INTEGER Rep_LexID;
			INTEGER DPPA_Purpose;
			INTEGER GLBA_Purpose;
			STRING Data_Restriction_Mask;
			STRING Data_Permission_Mask;
			INTEGER MarketingMode;
			INTEGER HistoryDate;
			INTEGER LinkSearchLevel;
			INTEGER BIPBestAppend;
			STRING SIC_Code;
			STRING NAIC_Code;
			UNSIGNED6 PowID;
			UNSIGNED6 ProxID;
			UNSIGNED6 SeleID;
			UNSIGNED6 OrgID;
			UNSIGNED6 UltID;
		END;

		SOAPLayout intoSOAP(InputFile le) := TRANSFORM
			SELF.seq            := le.Seq;
			SELF.AcctNo         := le.AcctNo;
			// Business info
			SELF.PowID          := le.PowID;
			SELF.ProxID         := le.ProxID;
			SELF.SeleID         := le.SeleID;
			SELF.OrgID          := le.OrgID;
			SELF.UltID          := le.UltID;
			SELF.CompanyName    := le.CompanyName;
			SELF.AltCompanyName := le.AltCompanyName;
			SELF.StreetAddress1 := le.StreetAddress1;
			SELF.StreetAddress2 := le.StreetAddress2;
			SELF.City           := le.City;
			SELF.State          := le.State;
			SELF.Zip9           := le.Zip;
			SELF.Prim_Range     := le.Prim_Range;
			SELF.PreDir         := le.PreDir;
			SELF.Prim_Name      := le.Prim_Name;
			SELF.Addr_Suffix    := le.Addr_Suffix;
			SELF.PostDir        := le.PostDir;
			SELF.Unit_Desig     := le.Unit_Desig;
			SELF.Sec_Range      := le.Sec_Range;
			SELF.Zip5           := le.Zip5;
			SELF.Zip4           := le.Zip4;
			SELF.Lat            := le.Lat;
			SELF.Long           := le.Long;
			SELF.Addr_Type      := le.Addr_Type; 
			SELF.Addr_Status    := le.Addr_Status;
			SELF.County         := le.County;
			SELF.Geo_Block      := le.Geo_Block;	
			SELF.FEIN           := le.FEIN;
			SELF.Phone10        := le.Phone10;
			SELF.IPAddr         := le.IPAddr;
			SELF.CompanyURL     := le.CompanyURL;
			SELF.SIC_Code       := le.SIC;
			SELF.NAIC_Code      := le.NAIC;
			// Aauthorized Rep info
			SELF.Rep_FullName       := le.Rep_FullName;
			SELF.Rep_NameTitle      := le.Rep_NameTitle;
			SELF.Rep_FirstName      := le.Rep_FirstName;
			SELF.Rep_MiddleName     := le.Rep_MiddleName;
			SELF.Rep_LastName       := le.Rep_LastName;
			SELF.Rep_NameSuffix     := le.Rep_NameSuffix;
			SELF.Rep_FormerLastName := le.Rep_FormerLastName;
			SELF.Rep_StreetAddress1 := le.Rep_StreetAddress1;
			SELF.Rep_StreetAddress2 := le.Rep_StreetAddress2;
			SELF.Rep_City           := le.Rep_City;
			SELF.Rep_State          := le.Rep_State;
			SELF.Rep_Zip            := le.Rep_Zip;
			SELF.Rep_Prim_Range     := le.Rep_Prim_Range;
			SELF.Rep_PreDir         := le.Rep_PreDir;
			SELF.Rep_Prim_Name      := le.Rep_Prim_Name;
			SELF.Rep_Addr_Suffix    := le.Rep_Addr_Suffix;
			SELF.Rep_PostDir        := le.Rep_PostDir;
			SELF.Rep_Unit_Desig     := le.Rep_Unit_Desig;
			SELF.Rep_Sec_Range      := le.Rep_Sec_Range;
			SELF.Rep_Zip5           := le.Rep_Zip5;
			SELF.Rep_Zip4           := le.Rep_Zip4;
			SELF.Rep_Lat            := le.Rep_Lat;
			SELF.Rep_Long           := le.Rep_Long;
			SELF.Rep_Addr_Type      := le.Rep_Addr_Type;
			SELF.Rep_Addr_Status    := le.Rep_Addr_Status;
			SELF.Rep_County         := le.Rep_County;
			SELF.Rep_Geo_Block      := le.Rep_Geo_Block;
			SELF.Rep_SSN            := le.Rep_SSN;
			SELF.Rep_DateOfBirth    := le.Rep_DateOfBirth;
			SELF.Rep_Phone10        := le.Rep_Phone10;
			SELF.Rep_Age            := le.Rep_Age;
			SELF.Rep_DLNumber       := le.Rep_DLNumber;
			SELF.Rep_DLState        := le.Rep_DLState;
			SELF.Rep_Email          := le.Rep_Email;
			// Service configuration
			SELF.DPPA_Purpose          := options.DPPA_Purpose;
			SELF.GLBA_Purpose          := options.GLBA_Purpose;
			SELF.Data_Restriction_Mask := options.DataRestrictionMask;
			SELF.Data_Permission_Mask  := options.DataPermissionMask;
			SELF.HistoryDate           := 
				IF(histDate = USE_RECORD_HISTORYDATE, MAX(le.HistoryDate,le.HistoryDateTime), histDate);
			SELF.MarketingMode         := options.MarketingMode;
			SELF.LinkSearchLevel       := options.LinkSearchLevel;
			SELF.BIPBestAppend         := 0;
			
			SELF := [];
		END;

		InputBusShell := DISTRIBUTE(PROJECT(InputFile, intoSOAP(LEFT)), RANDOM() % 50); // DISTRIBUTE as a 50-way

		xLayout := RECORD
			Business_Risk_BIP.Layouts.OutputLayout;
			STRING200 ErrorCode := '';
		END;

		xLayout myFail(SOAPLayout le) := TRANSFORM
			SELF.ErrorCode := FAILCODE + ' ' + FAILMESSAGE;
			SELF.Input_Echo.AcctNo := le.AcctNo;
			SELF := [];
		END;

		// 3. Run Business Shell. Output from Business_Risk_BIP.Business_Shell_Service is 
		// Business_Risk_BIP.Layouts.OutputLayout (slimmer shell, basically).
		shell_results := 
				SOAPCALL(
					InputBusShell,
					RoxieIP,
					'Business_Risk_BIP.Business_Shell_Service',
					{InputBusShell},
					DATASET(xLayout),
					PARALLEL(threads),
					RETRY(3), TIMEOUT(300),
					onFail(myFail(LEFT))
				);

		// 4. Transform back to Business_Risk_BIP.Layouts.Shell and join back to inputFile to 
		// retrieve the seq number.
		shell_results_with_seq :=
			JOIN(
				inputFile, shell_results,
				LEFT.seq = RIGHT.input_echo.seq,
				TRANSFORM( Business_Risk_BIP.Layouts.Shell,
					SELF.seq := LEFT.seq,
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []
				),
				INNER
			);
			
		shell_res_grpd := GROUP(SORT(shell_results_with_seq,seq),seq);
		
		// 5. Run Business Shell results through Models.
		Layout_ModelOut_pre := RECORD
			UNSIGNED Seq;
			STRING ModelName := '';
			STRING _Type     := '';
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
							SELF._Type := '0-999',
							SELF.Score := LEFT.Score,
							SELF.RiskLevel :=
								MAP(
									(UNSIGNED)LEFT.Score BETWEEN 501 AND 650 => 'HIGH',
									(UNSIGNED)LEFT.Score BETWEEN 651 AND 750 => 'MED',
									(UNSIGNED)LEFT.Score BETWEEN 751 AND 900 => 'LOW',
									(UNSIGNED)LEFT.Score = 222               => 'NO HIT',
									/* default...........................: */   'UNK'								
								);
							SELF := LEFT
						)
					);
					
				RETURN with_model_name;
			END;
		
		Model_Results :=  
			IF( 'SBOM1601_0_0' IN set_model_names, // non-blended or Business Only model
					setModelName('SBOM1601_0_0', Models.LIB_BusinessRisk_Function(shell_res_grpd, 'SBOM1601_0_0')) ) + 		
			IF( 'SBBM1601_0_0' IN set_model_names, // blended model
					setModelName('SBBM1601_0_0', Models.LIB_BusinessRisk_Function(shell_res_grpd, 'SBBM1601_0_0')) ) + 
			DATASET([], Layout_ModelOut_pre);

		// 6. Add Back our Input Echo.
		layout_ReasonCodes := RECORD
			STRING1 SeqNo;
			STRING5 ReasonCode;
			STRING150 ReasonCodeDesc;
		END;
		
		layout_ModelOut := RECORD
			STRING ModelName := '';
			STRING _Type     := '';
			STRING Score     := '';
			STRING RiskLevel := '';
			DATASET(layout_ReasonCodes) ReasonCodes;
		END;
		
		layout_out_rolled := RECORD
			Business_Risk_BIP.Layouts.Input;
			DATASET(Layout_ModelOut) ModelResults;
		END;
		
		Layout_ModelOut getModelResults(Layout_ModelOut_pre le) :=
			TRANSFORM
				SELF.ModelName := le.ModelName;
				SELF._Type     := le._Type;
				SELF.Score     := le.Score;
				SELF.RiskLevel := le.RiskLevel;
				SELF.ReasonCodes := 
					PROJECT(
						le.ri,
						TRANSFORM( layout_ReasonCodes,
							SELF.SeqNo := (STRING)COUNTER;
							SELF.ReasonCode := LEFT.hri;
							SELF.ReasonCodeDesc := LEFT.desc;						
						)
					);
			END;
		
		withScores := 
			JOIN(
				inputFile, Model_Results, 
				LEFT.Seq = RIGHT.Seq, 
				TRANSFORM( layout_out_rolled, 
					SELF.ModelResults := PROJECT(RIGHT, getModelResults(LEFT));
					SELF := LEFT
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
						
		// results_sample := CHOOSEN(results, 10);
		
		// 7. ...write to disk... 
		// outputFileName := 'sbfe::out::get_scores_' + WORKUNIT;
		// OUTPUT(results,, outputFileName); 
		
		// 8. ...and return a sample.
		RETURN results;
	END;
	