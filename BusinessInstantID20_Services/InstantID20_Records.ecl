IMPORT BIPV2, Business_Risk_BIP, MDR, Risk_Reporting, LNSmallBusiness, BusinessInstantID20_Services, iesp, std, Models, Risk_Indicators;

EXPORT InstantID20_Records( DATASET(BusinessInstantID20_Services.layouts.InputCompanyAndAuthRepInfo) ds_input,
                             BusinessInstantID20_Services.iOptions Options,
														 BIPV2.mod_sources.iParams linkingOptions,
                             Boolean ExcludeWatchlists) := 
	FUNCTION

		AllowedSourcesSet := BusinessInstantID20_Services.set_AllowedSources( Options );

		
		// 0.  Rename "input" for Verification purposes later: more reader-friendly.
		ds_OriginalInput := ds_input;
		
		// 1. Run Business Shell.
		mod_BusShell := BusinessInstantID20_Services.mod_BusinessShell(ds_OriginalInput, Options);

		ds_Shell_Results := mod_BusShell.Records;
		
		// 2.  Clean the Business and the Authorized Rep data.	
		// *** TODO: Create exportable attribute in mod_BusinessShell containing cleaned AuthRep 
		// fields; these can be read from the Business Shell. Include LexIDs also, so we can get
		// rid of fn_AppendLexIDs( ) below. Also add a Targus hit indicator in case we ever want 
		// to use that Gateway. ***
		ds_CleanedInput := BusinessInstantID20_Services.fn_CleanInput(ds_OriginalInput);
		
		// 3.  Append LexIDs.
		ds_WithLexIDs := BusinessInstantID20_Services.fn_AppendLexIDs(ds_CleanedInput, Options);
		
		// 4.  Get BIPIDs. These'll be passed into any kFetches later. 
		ds_BIPIDs := mod_BusShell.BIPIDs;

		// 4.a.  Don't run searches on records that have no BIPIDs.
		ds_NoBIPIDsFound := ds_BIPIDs(PowID = 0 AND ProxID = 0 AND SeleID = 0 AND OrgID = 0 AND UltID = 0);

		// 4.b.  Only run searches on records that have BIPIDs.
		ds_BIPIDsFound := ds_BIPIDs(PowID <> 0 OR ProxID <> 0 OR SeleID <> 0 OR OrgID <> 0 OR UltID <> 0);
						
		// 5. Get Best Business info.
		ds_BestBusinessInfo := BusinessInstantID20_Services.fn_GetBestBusinessInfo(ds_BIPIDsFound, Options, linkingOptions);

		// 6. Get Business Header records.
		ds_BusinessHeaderRecs := BusinessInstantID20_Services.fn_GetHeaderRecords(ds_CleanedInput, ds_BIPIDsFound, Options, linkingOptions, AllowedSourcesSet);
		
		// 7. Get Verification info.
		ds_VerificationInfo := BusinessInstantID20_Services.fn_GetVerificationInfo(ds_CleanedInput, ds_BusinessHeaderRecs, ds_Shell_Results, Options);
		
		// 8. Get Firmographics info.
		ds_FirmographicsInfo := BusinessInstantID20_Services.fn_GetFirmographics(ds_CleanedInput, ds_BIPIDsFound, Options, linkingOptions, AllowedSourcesSet);
		
		// 9. Get Parent company info.
		ds_ParentInfo := BusinessInstantID20_Services.fn_getParentInfo(ds_CleanedInput, ds_BusinessHeaderRecs, Options, linkingOptions);
		
		// 10. Get Business names and addresses by Phone number.
		ds_BusinessesByPhone := BusinessInstantID20_Services.fn_GetBusinessByPhone( ds_OriginalInput, ds_BIPIDsFound, Options, linkingOptions );
		
		// 11. Get Phone numbers by Business address; pass in ds_CleanedInput for the address parts.
		ds_PhonesByAddress := BusinessInstantID20_Services.fn_GetPhonesByAddress( ds_CleanedInput, ds_BIPIDsFound, Options, linkingOptions );
		
		// 12. Get Business names and addresses by FEIN.
		ds_BusinessesByFEIN := BusinessInstantID20_Services.fn_GetBusinessByFEIN( ds_OriginalInput, ds_BIPIDsFound, Options, linkingOptions );
		
		// 13. Get GlobalWatchlist info.
		ds_GlobalWatchlistInfo := BusinessInstantID20_Services.fn_GetGlobalWatchlistInfo( ds_OriginalInput, Options );
		
		// 14. Get Consumer InstantID records for *valid* Auth Reps.
		ds_CleanedInputWithValidAuthReps := 
			PROJECT( 
				ds_CleanedInput,
				TRANSFORM( BusinessInstantID20_Services.Layouts.InputCompanyAndAuthRepInfoClean,
					SELF.AuthReps := BusinessInstantID20_Services.fn_MeetsAuthRepMinInputRequirements( LEFT.AuthReps ),
					SELF := LEFT
				)
			);
			
		ds_ConsumerInstantIDInfo := BusinessInstantID20_Services.fn_GetConsumerInstantIDRecs( ds_CleanedInputWithValidAuthReps, Options, ds_GlobalWatchlistInfo );
		
		// 15. Get Person titles within the Business.
		ds_PersonRoleInfo := BusinessInstantID20_Services.fn_GetPersonRoles(ds_WithLexIDs, ds_BIPIDsFound, Options, linkingOptions, AllowedSourcesSet);
		    
    // 16. Get Models 
    Input := DATASET([], LNSmallBusiness.BIP_Layouts.Input);
    AppendBestsFromLexIDs := FALSE;
    UNSIGNED1	LinkSearchLevel      := Business_Risk_BIP.Constants.LinkSearch.Default;
    UNSIGNED1	MarketingMode        := Business_Risk_BIP.Constants.Default_MarketingMode;
    Layout_ModelOut_Plus := RECORD
      Models.Layout_ModelOut;
      STRING ModelName := '';
    END;
    // ds_Models_temp := BusinessInstantID20_Services.fn_GetModels(Input,ds_Shell_Results,ds_OriginalInput,LinkSearchLevel,MarketingMode,Options,AppendBestsFromLexIDs);
    ds_Models_temp := DATASET([], Layout_ModelOut_Plus);
    iesp.smallbusinessanalytics.t_SBAScoreHRI getScoreResults(Layout_ModelOut_Plus le) := TRANSFORM
      SELF._Type := IF((INTEGER)le.Score=0,'','0-999');
      SELF.Value := (INTEGER)le.Score;
      SELF.ScoreReasons := 
        PROJECT(
          le.ri, 
          TRANSFORM( iesp.smallbusinessanalytics.t_SBARiskIndicator,
            SELF.Sequence := COUNTER;
            SELF.ReasonCode := LEFT.hri;
            SELF.Description := IF(LEFT.hri NOT IN ['', '00'], Risk_Indicators.getHRIDesc(LEFT.hri), '');
          ));
    END;
	  iesp.smallbusinessanalytics.t_SBAModelHRI xfm_Models(Layout_ModelOut_Plus le ) :=
      TRANSFORM
        SELF.name := le.modelname;
        SELF.Scores := PROJECT(le, getScoreResults(LEFT));
      END;
    ds_Models := PROJECT( ds_Models_temp, xfm_Models(LEFT));
    
    // 17. Get Attributes
    mod_Attributes := BusinessInstantID20_Services.mod_GetAttributes(ds_Shell_Results, Options);
    // ds_Attributes := mod_Attributes.ds_Version1+mod_Attributes.ds_Version101+mod_Attributes.ds_Version2+mod_Attributes.ds_SBFE;
    ds_Attributes := DATASET([],iesp.smallbusinessanalytics.t_SBAAttributesGroup);
   
    // 18. Get Company Address Risk
    ds_AddressRisk := BusinessInstantID20_Services.fn_CalculateAddressIsCMRA(ds_CleanedInput);
    
   // ---------------[ Transform to output ]---------------
	
		_transforms := BusinessInstantID20_Services.Transforms(Options);
		
		// Echo the input.
		ds_OutputWithEcho :=	
			PROJECT( ds_OriginalInput, _transforms.xfm_AddInputEcho(LEFT) );

		// Add the BIPIDs back to the cleaned input.
		ds_OutputWithBIPIDs := 
			JOIN(
				ds_WithLexIDs, ds_BIPIDs, 
				LEFT.Seq = RIGHT.UniqueID, 
				TRANSFORM( BusinessInstantID20_Services.layouts.InputCompanyAndAuthRepInfoClean,
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []
				),
				LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);

		// Add Cleaned data, LexIDs, and BIPIDs, to the Original input.		
		ds_OutputWithCleanedDataEtc := 
			JOIN( 
				ds_OutputWithEcho, ds_OutputWithBIPIDs, 
				LEFT.InputEcho.Seq = RIGHT.Seq, 
				_transforms.xfm_AddCleanedDataEtc(LEFT,RIGHT), 
				LEFT OUTER, KEEP(1), PARALLEL, FEW );

		// Add Business Best Info.		
		ds_OutputWithBestInfo := 
			JOIN( 
				ds_OutputWithCleanedDataEtc, ds_BestBusinessInfo, 
				LEFT.InputEcho.Seq = RIGHT.Seq, 
				_transforms.xfm_AddBestInfo(LEFT,RIGHT), 
				LEFT OUTER, KEEP(1), PARALLEL, FEW );
		
		// Add Firmographic info.
		ds_OutputWithFirmographics := 
			JOIN( 
				ds_OutputWithBestInfo, ds_FirmographicsInfo, 
				LEFT.InputEcho.Seq = RIGHT.Seq, 
				_transforms.xfm_AddFirmographics(LEFT,RIGHT), 
				LEFT OUTER, KEEP(1), PARALLEL, FEW );
	
		// Add Parent Company info.
		ds_OutputWithParentInfo := 
			JOIN( 
				ds_OutputWithFirmographics, ds_ParentInfo, 
				LEFT.InputEcho.Seq = RIGHT.Seq, 
				_transforms.xfm_AddParentInfo(LEFT,RIGHT), 
				LEFT OUTER, KEEP(1), PARALLEL, FEW );
		
		// Add Businesses by Phone.
		ds_OutputWithBusinessesByPhone := 
			JOIN( 
				ds_OutputWithParentInfo, ds_BusinessesByPhone, 
				LEFT.InputEcho.Seq = RIGHT.Seq, 
				_transforms.xfm_AddBusinessesByPhone(LEFT,RIGHT), 
				LEFT OUTER, KEEP(1), PARALLEL, FEW );

		// Add Phones by Business address.
		ds_OutputWithPhonesByAddress := 
			JOIN( 
				ds_OutputWithBusinessesByPhone, ds_PhonesByAddress, 
				LEFT.InputEcho.Seq = RIGHT.Seq, 
				_transforms.xfm_AddPhonesByAddress(LEFT,RIGHT), 
				LEFT OUTER, KEEP(1), PARALLEL, FEW );

		// Add Businesses by FEIN.
		ds_OutputWithBusinessesByFEIN := 
			JOIN( 
				ds_OutputWithPhonesByAddress, ds_BusinessesByFEIN, 
				LEFT.InputEcho.Seq = RIGHT.Seq, 
				_transforms.xfm_AddBusinessesByFEIN(LEFT,RIGHT), 
				LEFT OUTER, KEEP(1), PARALLEL, FEW );

		// Add OFAC/Global Watchlist info.
		ds_OutputWithOFACGWL := 
			JOIN( 
				ds_OutputWithBusinessesByFEIN, ds_GlobalWatchlistInfo, 
				LEFT.InputEcho.Seq = RIGHT.Seq, 
				_transforms.xfm_AddOFACGWL(LEFT,RIGHT), 
				LEFT OUTER, KEEP(1), PARALLEL, FEW );
        
    // Add Company Address Risk
    ds_OutputWithAddressRisk :=
      JOIN(
        ds_OutputWithOFACGWL, ds_AddressRisk,
        LEFT.InputEcho.Seq = RIGHT.Seq, 
				_transforms.xfm_AddAddressRisk(LEFT,RIGHT), 
				LEFT OUTER, KEEP(1), PARALLEL, FEW );

    // Join Watchlist info to Consumer InstantID.
    ds_ConsumerInstantIDwithWatchlist := 
    JOIN( 
				ds_ConsumerInstantIDInfo, ds_GlobalWatchlistInfo,
				LEFT.Seq = RIGHT.Seq, 
				_transforms.xfm_AddConsumerInstantIDWatchlist(LEFT,RIGHT,(INTEGER)LEFT.rep_whichone,options), 
				LEFT OUTER, KEEP(1), PARALLEL, FEW );
		
    // Add Consumer InstantID records with AuthRep Watchlists.		
		ds_OutputWithConsumerInstantID := 
			DENORMALIZE( 
				ds_OutputWithAddressRisk, ds_ConsumerInstantIDwithWatchlist, 
				LEFT.Seq = RIGHT.Seq,
				GROUP,
				TRANSFORM(BusinessInstantID20_Services.layouts.OutputLayout_intermediate, 
					SELF.InputEcho.NumberValidAuthRepsInput := COUNT(ROWS(RIGHT)),
					SELF.ConsumerInstantID := PROJECT(ROWS(RIGHT), TRANSFORM(BusinessInstantID20_Services.Layouts.ConsumerInstantIDLayout, SELF := LEFT)),
          SELF := LEFT,
					SELF := []) );				
		ds_OutputWithPersonRoles := 
			JOIN( 
				ds_OutputWithConsumerInstantID, ds_PersonRoleInfo, 
				LEFT.InputEcho.Seq = RIGHT.Seq, 
				_transforms.xfm_AddPersonRoles(LEFT,RIGHT), 
				LEFT OUTER, KEEP(1), PARALLEL, FEW );
		
		// Add data from the business shell.
		ds_Shell_Results_WatchlistVerfication := // This part supresses reason code 10 when watchlists aren't wanted since the fields it looks at comes from the business shell
			PROJECT( 
				ds_Shell_Results,
				TRANSFORM( Business_Risk_BIP.Layouts.Shell,
					SELF.Verification.VerWatchlistNameMatch := if(ExcludeWatchLists = true, '0', left.Verification.VerWatchlistNameMatch),
					SELF.Verification.VerWatchlistAltNameMatch := if(ExcludeWatchLists = true, '0', left.Verification.VerWatchlistAltNameMatch),
          SELF := LEFT
				)
			);
    
		ds_OutputWithScoresAndBusinessShellData := 
			JOIN( 
				ds_OutputWithPersonRoles, ds_Shell_Results_WatchlistVerfication, 
				LEFT.InputEcho.Seq = RIGHT.Seq, 
				_transforms.xfm_AddScoresAndBusinessShellData(LEFT,RIGHT,ds_OriginalInput,ds_GlobalWatchlistInfo), 
				LEFT OUTER, KEEP(1), PARALLEL, FEW );		

		ds_OutputWithVerificationInfo := 
			JOIN( 
				ds_OutputWithScoresAndBusinessShellData, ds_VerificationInfo,
				LEFT.InputEcho.Seq = RIGHT.Seq, 
				_transforms.xfm_AddVerificationInfo(LEFT,RIGHT), 
				LEFT OUTER, KEEP(1), PARALLEL, FEW );
		
		// Add Models and Attributes
    BusinessInstantID20_Services.layouts.OutputLayout_intermediate xfm_AddAttributes(BusinessInstantID20_Services.layouts.OutputLayout_intermediate le) :=
        TRANSFORM
          SELF.AttributeGroup := ds_Attributes;
          SELF.Models := ds_Models;
          SELF := le;
          SELF := [];
        END;    
    ds_OutputWithModelsAndAttributes := 
      PROJECT(
        ds_OutputWithVerificationInfo, xfm_AddAttributes(LEFT));     
	
		// Suppress if BVI IN ['','0'] or BVI Description code in ('311','411','412').
		ds_Suppressed := BusinessInstantID20_Services.fn_SuppressNoHitRecords(ds_OutputWithModelsAndAttributes);
	
		ds_Final := SORT( ds_Suppressed, seq );

		/* **********************************************************************
		 *   BIID 2.0 Intermediate Logging: log the Business Shell only since   *
		 *   the BIID 2.0 outputis logged in SCOUT/SOAT input/output database.  *
		 ************************************************************************ */
		productID := Risk_Reporting.ProductID.Business_Risk__InstantID_20_Service;
		
		intermediate_Log := 
			IF(
				Options.DisableIntermediateShellLogging, 
				DATASET([], Risk_Reporting.Layouts.LOG_BIID20), 
				Risk_Reporting.To_LOG_BIID20(ds_Shell_Results, productID, Risk_Reporting.ProcessType.Internal, Options)
			);
		
		#STORED('Intermediate_Log', intermediate_log);
		
		/* ************ End Logging ************/
 
		// DEBUGs.............:
		// OUTPUT( ds_OriginalInput, NAMED('OriginalInput') );
		// OUTPUT( ds_Shell_Results, NAMED('ds_Shell_Results') );
		// OUTPUT( ds_CleanedInput, NAMED('CleanedInput') );
		// OUTPUT( ds_WithLexIDs, NAMED('WithLexIDs') );
		// OUTPUT( ds_BIPIDs, NAMED('BIPIDs') );
		// OUTPUT( ds_NoBIPIDsFound, NAMED('NoBIPIDsFound') );
		// OUTPUT( ds_BIPIDsFound, NAMED('BIPIDsFound') );
		// OUTPUT( ds_BestBusinessInfo, NAMED('BestBusinessInfo') );
		// OUTPUT( CHOOSEN(ds_BusinessHeaderRecs,100), NAMED('ds_BusinessHeaderRecs') );
		// OUTPUT( ds_VerificationInfo, NAMED('VerificationInfo') );
		// OUTPUT( ds_FirmographicsInfo, NAMED('FirmographicsInfo') );
		// OUTPUT( ds_ParentInfo, NAMED('ParentInfo') );
		// OUTPUT( ds_BusinessesByPhone, NAMED('BusinessesByPhone') );
		// OUTPUT( ds_PhonesByAddress, NAMED('PhonesByAddress') );
		// OUTPUT( ds_BusinessesByFEIN, NAMED('BusinessesByFEIN') );
		// OUTPUT( ds_GlobalWatchlistInfo, NAMED('GlobalWatchlistInfo') );
		// OUTPUT( ds_CleanedInputWithValidAuthReps, NAMED('CleanedInputWithValidAuthReps') );
		// OUTPUT( ds_ConsumerInstantIDInfo, NAMED('ConsumerInstantIDInfo') );
		// OUTPUT( ds_PersonRoleInfo, NAMED('PersonRoleInfo') );
		// OUTPUT( ds_OutputWithScoresAndBusinessShellData, NAMED('OutputWithScoresAndBusinessShellData') );
		// OUTPUT( ds_Models_temp, NAMED('ds_Models_temp') );
		// OUTPUT( ds_Models, NAMED('ds_Models') );
		// OUTPUT( ds_Attributes, NAMED('ds_Attributes') );
		// OUTPUT( ds_OutputWithModelsAndAttributes, NAMED('ds_OutputWithModelsAndAttributes') );
		// OUTPUT( ds_OutputWithVerificationInfo, NAMED('ds_OutputWithVerificationInfo') );
		// OUTPUT( ds_ConsumerInstantIDWatchlist, NAMED('ds_ConsumerInstantIDWatchlist') );
		// OUTPUT( ds_OutputWithOFACGWL, NAMED('ds_OutputWithOFACGWL') );
		// OUTPUT( ds_OutputWithConsumerInstantID, NAMED('ds_OutputWithConsumerInstantID') );
		// OUTPUT( ds_riskIndAuthRep1, NAMED('ds_riskIndAuthRep1') );
		// OUTPUT( ds_riskIndAuthRep1Fua, NAMED('ds_riskIndAuthRep1Fua') );
		// OUTPUT( ds_riskInd, NAMED('ds_riskInd') );
		// OUTPUT( ds_riskIndBusn, NAMED('ds_riskIndBusn') );
		// OUTPUT( ds_riskIndBusnPre, NAMED('ds_riskIndBusnPre') );
		// OUTPUT( ds_OutputWithWatchlistRiskIndicators, NAMED('ds_OutputWithWatchlistRiskIndicators') );
		// OUTPUT( ds_AddressRisk, named('ds_AddressRisk') );
		// OUTPUT( ds_OutputWithAddressRisk, named('ds_OutputWithAddressRisk') );
    // OUTPUT( ds_OutputWithEcho, named('ds_OutputWithEcho') );
		RETURN ds_Final;

	END;

