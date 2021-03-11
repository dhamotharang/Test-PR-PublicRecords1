IMPORT BusinessInstantID20_Services, UT, LNSmallBusiness, Business_Risk_BIP, STD, BusinessCredit_Services, Risk_Indicators, Address, Riskwise, Models, BIPV2;

// The following function obtains Models
EXPORT fn_GetModels(DATASET(LNSmallBusiness.BIP_Layouts.Input) Input,
                    DATASET(Business_Risk_BIP.Layouts.Shell) Shell_Results_pre,
                    DATASET(BusinessInstantID20_Services.layouts.InputCompanyAndAuthRepInfo) ds_input,
                    // STRING10	IndustryClass				  = Business_Risk_BIP.Constants.Default_IndustryClass,
										UNSIGNED1	LinkSearchLevel			  = Business_Risk_BIP.Constants.LinkSearch.Default,
										UNSIGNED1	MarketingMode				  = Business_Risk_BIP.Constants.Default_MarketingMode,
                    BusinessInstantID20_Services.iOptions Options,
                    BOOLEAN AppendBestsFromLexIDs = FALSE
                   ) :=

  FUNCTION
    linkingOptions := MODULE(BIPV2.mod_sources.iParams)
      EXPORT STRING DataRestrictionMask		:= Options.DataRestrictionMask; // Note: Must unfortunately leave as undefined STRING length to match the module definition
      EXPORT BOOLEAN ignoreFares					:= FALSE; // From AutoStandardI.DataRestrictionI, this is a User Configurable Input Option to Ignore FARES data - since the Business Shell doesn't accept this input default it to FALSE to always utilize whatever the DataRestrictionMask allows
      EXPORT BOOLEAN ignoreFidelity				:= FALSE; // From AutoStandardI.DataRestrictionI, this is a User Configurable Input Option to Ignore Fidelity data - since the Business Shell doesn't accept this input default it to FALSE to always utilize whatever the DataRestrictionMask allows
      EXPORT BOOLEAN AllowAll							:=  FALSE; // When TRUE this will unmask DNB DMI data - NO CUSTOMERS CAN USE THIS, FOR RESEARCH PURPOSES ONLY
      EXPORT BOOLEAN AllowGLB							:= Options.isValidGlb();
      EXPORT BOOLEAN AllowDPPA						:= Options.isValidDppa();
      EXPORT UNSIGNED1 DPPAPurpose				:= Options.dppa;
      EXPORT UNSIGNED1 GLBPurpose					:= Options.glb;
      EXPORT BOOLEAN IncludeMinors				:= TRUE; // Shouldn't really have an impact on business searches, set to TRUE for now
      EXPORT BOOLEAN LNBranded						:= TRUE; // Not entirely certain what effect this has
    END;

    //TO-DO: remove parameter AppendBestsFromLexIDs and check on line 30
    SeqInput_Raw := PROJECT(Input, TRANSFORM(LNSmallBusiness.BIP_Layouts.InputWSeq, SELF.Seq := COUNTER; SELF := LEFT));
    SeqInput := IF(AppendBestsFromLexIDs, LNSmallBusiness.SmallBusiness_BIP_Append_Inputs(SeqInput_Raw, linkingOptions), SeqInput_Raw) ;
    Business_Risk_BIP.Layouts.Input convertToBusinessShellInput(RECORDOF(ds_input) le) := TRANSFORM
				SELF.Seq                 := le.Seq;
				SELF.AcctNo              := le.AcctNo;
				SELF.HistoryDate         := (UNSIGNED3)(((STRING12)le.HistoryDate)[1..6]);
				SELF.HistoryDateTime     := le.HistoryDate;
				SELF.CompanyName         := le.CompanyName;
				SELF.AltCompanyName      := le.AltCompanyName;
				SELF.StreetAddress1      := le.StreetAddress1;
				SELF.StreetAddress2      := le.StreetAddress2;
				SELF.City                := le.City;
				SELF.State               := le.State;
				SELF.Zip                 := le.Zip;
				SELF.FEIN                := le.FEIN;
				SELF.Phone10             := le.Phone10;
				SELF.Fax_Number          := le.Fax_Number;
				// Auth Rep 1
				SELF.Rep_FullName        := le.AuthReps[1].FullName;
				SELF.Rep_FirstName       := le.AuthReps[1].FirstName;
				SELF.Rep_MiddleName      := le.AuthReps[1].MiddleName;
				SELF.Rep_LastName        := le.AuthReps[1].LastName;
				SELF.Rep_NameSuffix      := le.AuthReps[1].NameSuffix;
				SELF.Rep_FormerLastName  := le.AuthReps[1].FormerLastName;
				SELF.Rep_StreetAddress1  := le.AuthReps[1].StreetAddress1;
				SELF.Rep_StreetAddress2  := le.AuthReps[1].StreetAddress2;
				SELF.Rep_City            := le.AuthReps[1].City;
				SELF.Rep_State           := le.AuthReps[1].State;
				SELF.Rep_Zip             := le.AuthReps[1].Zip;
				SELF.Rep_SSN             := le.AuthReps[1].SSN;
				SELF.Rep_DateOfBirth     := le.AuthReps[1].DateOfBirth;
				SELF.Rep_Phone10         := le.AuthReps[1].Phone10;
				SELF.Rep_Age             := le.AuthReps[1].Age;
				SELF.Rep_DLNumber        := le.AuthReps[1].DLNumber;
				SELF.Rep_DLState         := le.AuthReps[1].DLState;
				self.Rep_LexID 					 := le.AuthReps[1].LexID;
				self.Rep_LexIDScore 		 := le.AuthReps[1].LexIDScore;
				// Auth Rep 2
				SELF.Rep2_FullName       := le.AuthReps[2].FullName;
				SELF.Rep2_FirstName      := le.AuthReps[2].FirstName;
				SELF.Rep2_MiddleName     := le.AuthReps[2].MiddleName;
				SELF.Rep2_LastName       := le.AuthReps[2].LastName;
				SELF.Rep2_NameSuffix     := le.AuthReps[2].NameSuffix;
				SELF.Rep2_FormerLastName := le.AuthReps[2].FormerLastName;
				SELF.Rep2_StreetAddress1 := le.AuthReps[2].StreetAddress1;
				SELF.Rep2_StreetAddress2 := le.AuthReps[2].StreetAddress2;
				SELF.Rep2_City           := le.AuthReps[2].City;
				SELF.Rep2_State          := le.AuthReps[2].State;
				SELF.Rep2_Zip            := le.AuthReps[2].Zip;
				SELF.Rep2_SSN            := le.AuthReps[2].SSN;
				SELF.Rep2_DateOfBirth    := le.AuthReps[2].DateOfBirth;
				SELF.Rep2_Phone10        := le.AuthReps[2].Phone10;
				SELF.Rep2_Age            := le.AuthReps[2].Age;
				SELF.Rep2_DLNumber       := le.AuthReps[2].DLNumber;
				SELF.Rep2_DLState        := le.AuthReps[2].DLState;
				self.Rep2_LexID 				 := le.AuthReps[2].LexID;
				self.Rep2_LexIDScore 		 := le.AuthReps[2].LexIDScore;
				// Auth Rep 3
				SELF.Rep3_FullName       := le.AuthReps[3].FullName;
				SELF.Rep3_FirstName      := le.AuthReps[3].FirstName;
				SELF.Rep3_MiddleName     := le.AuthReps[3].MiddleName;
				SELF.Rep3_LastName       := le.AuthReps[3].LastName;
				SELF.Rep3_NameSuffix     := le.AuthReps[3].NameSuffix;
				SELF.Rep3_FormerLastName := le.AuthReps[3].FormerLastName;
				SELF.Rep3_StreetAddress1 := le.AuthReps[3].StreetAddress1;
				SELF.Rep3_StreetAddress2 := le.AuthReps[3].StreetAddress2;
				SELF.Rep3_City           := le.AuthReps[3].City;
				SELF.Rep3_State          := le.AuthReps[3].State;
				SELF.Rep3_Zip            := le.AuthReps[3].Zip;
				SELF.Rep3_SSN            := le.AuthReps[3].SSN;
				SELF.Rep3_DateOfBirth    := le.AuthReps[3].DateOfBirth;
				SELF.Rep3_Phone10        := le.AuthReps[3].Phone10;
				SELF.Rep3_Age            := le.AuthReps[3].Age;
				SELF.Rep3_DLNumber       := le.AuthReps[3].DLNumber;
				SELF.Rep3_DLState        := le.AuthReps[3].DLState;
				self.Rep3_LexID 				 := le.AuthReps[3].LexID;
				self.Rep3_LexIDScore 		 := le.AuthReps[3].LexIDScore;
				// Auth Rep 4
				SELF.Rep4_FullName       := le.AuthReps[4].FullName;
				SELF.Rep4_FirstName      := le.AuthReps[4].FirstName;
				SELF.Rep4_MiddleName     := le.AuthReps[4].MiddleName;
				SELF.Rep4_LastName       := le.AuthReps[4].LastName;
				SELF.Rep4_NameSuffix     := le.AuthReps[4].NameSuffix;
				SELF.Rep4_FormerLastName := le.AuthReps[4].FormerLastName;
				SELF.Rep4_StreetAddress1 := le.AuthReps[4].StreetAddress1;
				SELF.Rep4_StreetAddress2 := le.AuthReps[4].StreetAddress2;
				SELF.Rep4_City           := le.AuthReps[4].City;
				SELF.Rep4_State          := le.AuthReps[4].State;
				SELF.Rep4_Zip            := le.AuthReps[4].Zip;
				SELF.Rep4_SSN            := le.AuthReps[4].SSN;
				SELF.Rep4_DateOfBirth    := le.AuthReps[4].DateOfBirth;
				SELF.Rep4_Phone10        := le.AuthReps[4].Phone10;
				SELF.Rep4_Age            := le.AuthReps[4].Age;
				SELF.Rep4_DLNumber       := le.AuthReps[4].DLNumber;
				SELF.Rep4_DLState        := le.AuthReps[4].DLState;
				self.Rep4_LexID 				 := le.AuthReps[4].LexID;
				self.Rep4_LexIDScore 		 := le.AuthReps[4].LexIDScore;
				// Auth Rep 5
				SELF.Rep5_FullName       := le.AuthReps[5].FullName;
				SELF.Rep5_FirstName      := le.AuthReps[5].FirstName;
				SELF.Rep5_MiddleName     := le.AuthReps[5].MiddleName;
				SELF.Rep5_LastName       := le.AuthReps[5].LastName;
				SELF.Rep5_NameSuffix     := le.AuthReps[5].NameSuffix;
				SELF.Rep5_FormerLastName := le.AuthReps[5].FormerLastName;
				SELF.Rep5_StreetAddress1 := le.AuthReps[5].StreetAddress1;
				SELF.Rep5_StreetAddress2 := le.AuthReps[5].StreetAddress2;
				SELF.Rep5_City           := le.AuthReps[5].City;
				SELF.Rep5_State          := le.AuthReps[5].State;
				SELF.Rep5_Zip            := le.AuthReps[5].Zip;
				SELF.Rep5_SSN            := le.AuthReps[5].SSN;
				SELF.Rep5_DateOfBirth    := le.AuthReps[5].DateOfBirth;
				SELF.Rep5_Phone10        := le.AuthReps[5].Phone10;
				SELF.Rep5_Age            := le.AuthReps[5].Age;
				SELF.Rep5_DLNumber       := le.AuthReps[5].DLNumber;
				SELF.Rep5_DLState        := le.AuthReps[5].DLState;
				self.Rep5_LexID 				 := le.AuthReps[5].LexID;
				self.Rep5_LexIDScore 		 := le.AuthReps[5].LexIDScore;
				SELF := le;
				SELF := [];
			END;

		Shell_Input := PROJECT(ds_input, convertToBusinessShellInput(LEFT));

    RESTRICTED_SET := ['0', ''];
    BIPIDWeightThreshold := LNSmallBusiness.Constants.BIPID_WEIGHT_THRESHOLD.DEFAULT_VALUE;

    // Use the SBFE restriction to return Scores or not.
    allow_SBFE_scores := Options.DataPermissionMask[12] NOT IN RESTRICTED_SET;
    SBFE_models_requested        := EXISTS(Options.ModelsRequested(ModelName IN LNSmallBusiness.Constants.set_SBFE_models));
    BusShellv22_scores_requested := EXISTS(Options.ModelsRequested(ModelName IN LNSmallBusiness.Constants.set_BusShellv22_models));

    Business_Risk_BIP.Layouts.Shell fn_transformToNoHit( Business_Risk_BIP.Layouts.Shell shell_results ) :=
      FUNCTION
        // First force a no-hit result for the Business Shell record.
        BlankShell_pre :=
          PROJECT( shell_results, Business_Risk_BIP.xfm_finalizeBlankShellFields( LEFT, Options.BusShellVersion ) );

        // Render blank SBFE data if the DataPermissionMask restricts SBFE data.
        BlankShell_restricted :=
          PROJECT( BlankShell_pre, TRANSFORM( Business_Risk_BIP.Layouts.Shell, SELF.SBFE := [], SELF := LEFT ) );

        // Render blank SBFE enhancement (v2.1) attributes if the Business Shell version is less than 2.1.
        BlankShell_v20 :=
          PROJECT(BlankShell_pre, Business_Risk_BIP.xfm_blankOutSBFEEnhancementAttrs(LEFT));

        BlankShell := MAP( NOT allow_SBFE_scores							 																=> BlankShell_restricted,
                           Options.BusShellVersion <= Business_Risk_BIP.Constants.BusShellVersion_v20 => BlankShell_v20,
                           /* default....................................................: */    BlankShell_pre );
        RETURN BlankShell;
      END;

    // Apply the product-specific Weight threshold to the Business Shell results. Any
    // results that fall below the threshold value shall be output as a no-hit.
    Shell_Results :=
      PROJECT(
        Shell_Results_pre,
        TRANSFORM( Business_Risk_BIP.Layouts.Shell,
          SELF := IF( (UNSIGNED2)LEFT.Verification.InputIDMatchConfidence >= BIPIDWeightThreshold, LEFT, fn_transformToNoHit(LEFT) ),
          SELF := []
        )
      );

  /* ************************************************************************
     *                       Boca Shell Results                             *
     ************************************************************************ */

    //Gateways := Gateway.Constants.void_gateway;
    IsUtility           := FALSE;
    IncludeRel          := TRUE;
    IncludeDL           := TRUE;
    IncludeVeh          := TRUE;
    IncludeDerog        := TRUE;


    IsFCRA              := FALSE;
    LN_Branded          := FALSE;
    OFAC_Only           := TRUE;
    SuppressNearDups    := FALSE;
    Require2ele         := FALSE;
    From_BIID           := FALSE;
    ExcludeWatchlists   := FALSE;
    From_IT1O           := FALSE;
    //OFAC_Version        := 1;
    Include_OFAC        := FALSE;
    Addtl_Watchlists    := FALSE;
    //Watchlist_Threshold := 0.84;
    DOB_Radius          := -1;
    DoScore             := TRUE;
    Nugen               := TRUE;
    Include_DL_Verification := TRUE;

    UNSIGNED1 AppendBest := 1;		// search best file
    UNSIGNED3 LastSeenThreshold := Risk_Indicators.iid_constants.max_unsigned3;
    

    //instantiating module 
    modBocaShellConfigs := BusinessInstantID20_Services.modSetBocaShellConfigurations();
    
    //setting Boca Shell version
    BSVersion := modBocaShellConfigs.setBocaShellVersion(Options.ModelsRequested, Options.BusShellVersion);
    
    //setting Boca Shell options 
    BSOptions := modBocaShellConfigs.setBocaShellOptions(Options.ModelsRequested);
    

    
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

      SELF.fname  := STD.Str.ToUpperCase(IF(le.Rep_FirstName=''   AND valid_cleaned, cleaned_name[6..25], le.Rep_FirstName));
      SELF.lname  := STD.Str.ToUpperCase(IF(le.Rep_LastName=''    AND valid_cleaned, cleaned_name[46..65], le.Rep_LastName));
      SELF.mname  := STD.Str.ToUpperCase(IF(le.Rep_MiddleName=''  AND valid_cleaned, cleaned_name[26..45], le.Rep_MiddleName));
      SELF.suffix := STD.Str.ToUpperCase(IF(le.Rep_NameSuffix ='' AND valid_cleaned, cleaned_name[66..70], le.Rep_NameSuffix));
      SELF.title  := STD.Str.ToUpperCase(IF(valid_cleaned, cleaned_name[1..5],''));

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

      SELF.dl_number := STD.Str.ToUpperCase(riskwise.cleanDL_num(le.Rep_DLNumber));
      SELF.dl_state  := STD.Str.ToUpperCase(le.Rep_DLState);

			self.DID := le.Rep_LexID;
			self.score := le.Rep_LexIDScore;

      SELF := [];
    END;

    IID_Prep_Acct := PROJECT(Shell_Input, iidPrep(LEFT,COUNTER));

    IID_Prep := PROJECT(IID_Prep_Acct, Risk_Indicators.Layout_Input );

    IID := Risk_Indicators.InstantID_Function(IID_Prep, Options.Gateways,	Options.dppa,	Options.glb, IsUtility, LN_Branded, OFAC_Only, SuppressNearDups,
                                              Require2ele, IsFCRA, From_BIID, ExcludeWatchLists, From_IT1O, Options.OFAC_Version, Options.Include_OFAC, Addtl_Watchlists, 
                                              Options.Global_Watchlist_Threshold, DOB_Radius, BSVersion, In_DataRestriction := Options.DataRestrictionMask,
                                              in_runDLverification := include_DL_verification, in_append_best := AppendBest, in_BSOptions := BSOptions, 
                                              in_LastSeenThreshold := LastSeenThreshold, in_DataPermission := Options.DataPermissionMask,
                                              LexIdSourceOptout := Options.lexid_source_optout,
                                              TransactionID := Options.transaction_id,
                                              BatchUID := Options.transaction_id,
                                              GlobalCompanyID := Options.global_company_id);

    Clam := Risk_Indicators.Boca_Shell_Function(IID, Options.Gateways,	Options.dppa,	Options.glb, IsUtility, LN_Branded, IncludeRel, IncludeDL, IncludeVeh, IncludeDerog, BSVersion, DoScore, Nugen,
                                                DataRestriction := Options.DataRestrictionMask, BSOptions := BSOptions, DataPermission := Options.DataPermissionMask,
                                                LexIdSourceOptout := Options.lexid_source_optout,
                                                TransactionID := Options.transaction_id,
                                                BatchUID := Options.transaction_id,
                                                GlobalCompanyID := Options.global_company_id);

    Blank_Boca_Shell := GROUP(DATASET([], Risk_Indicators.Layout_Boca_Shell), Seq);

    Boca_Shell_Grouped := IF(EXISTS(Options.ModelsRequested(ModelName IN BusinessCredit_Services.Constants.MODEL_NAME_SETS.BLENDED_ALL)), Clam, Blank_Boca_Shell); //don't call the boca shell if a model doesn't need it

/* **************************************************************************
	 *                            Calculate Scores                            *
	 * Note: The model score range is 501-900 with an exception score of 222. *
	 ************************************************************************ */
    shell_res_grpd := GROUP(SORT(Shell_Results,seq),seq);

    #IF(Models.LIB_BusinessRisk_Models().TurnOnValidation = FALSE)

    Layout_ModelOut_Plus := RECORD
      Models.Layout_ModelOut;
      STRING ModelName := '';
    END;

    setModelName(STRING Model_Name, DATASET(Models.Layout_ModelOut) Model_Results) :=
      FUNCTION
        RETURN PROJECT(
            Model_Results,
            TRANSFORM(Layout_ModelOut_Plus, SELF.ModelName := Model_Name; SELF := LEFT)
          );
      END;

      // Constants were not created for "test" model names. Per request, left as is.
    Model_Results_unsorted :=
      // Including fake model names to test out the model return fields within the ESP:
      IF( EXISTS(Options.ModelsRequested(ModelName = 'SBBM9999_9')),
          setModelName('SBBM9999_9', Models.LIB_BusinessRisk_Function(shell_res_grpd, 'SBBM9999_9')) ) +
      IF( EXISTS(Options.ModelsRequested(ModelName = 'SBOM9999_9')),
          setModelName('SBOM9999_9', Models.LIB_BusinessRisk_Function(shell_res_grpd, 'SBOM9999_9')) ) +
      // Actual model names:
      IF( EXISTS(Options.ModelsRequested(ModelName = BusinessCredit_Services.Constants.BLENDED_SCORE_MODEL)), 
          setModelName(BusinessCredit_Services.Constants.BLENDED_SCORE_MODEL, Models.LIB_BusinessRisk_Function(shell_res_grpd, BusinessCredit_Services.Constants.BLENDED_SCORE_MODEL, boca_shell_grouped)) ) + 
      
      IF( EXISTS(Options.ModelsRequested(ModelName = BusinessCredit_Services.Constants.BBFM1906_1_0)), 
          setModelName(BusinessCredit_Services.Constants.BBFM1906_1_0, Models.LIB_BusinessRisk_Function(shell_res_grpd, BusinessCredit_Services.Constants.BBFM1906_1_0, boca_shell_grouped)) ) + 
    
      IF( EXISTS(Options.ModelsRequested(ModelName = BusinessCredit_Services.Constants.CREDIT_SCORE_MODEL)), 
          setModelName(BusinessCredit_Services.Constants.CREDIT_SCORE_MODEL, Models.LIB_BusinessRisk_Function(shell_res_grpd, BusinessCredit_Services.Constants.CREDIT_SCORE_MODEL)) ) + 		
      
      IF( EXISTS(Options.ModelsRequested(ModelName = BusinessCredit_Services.Constants.BLENDED_SCORE_SLBB)), 
          setModelName(BusinessCredit_Services.Constants.BLENDED_SCORE_SLBB, Models.LIB_BusinessRisk_Function(shell_res_grpd, BusinessCredit_Services.Constants.BLENDED_SCORE_SLBB, boca_shell_grouped)) ) + 
      
      IF( EXISTS(Options.ModelsRequested(ModelName = BusinessCredit_Services.Constants.BLENDED_SCORE_BBFM)), 
          setModelName(BusinessCredit_Services.Constants.BLENDED_SCORE_BBFM, Models.LIB_BusinessRisk_Function(shell_res_grpd, BusinessCredit_Services.Constants.BLENDED_SCORE_BBFM, boca_shell_grouped)) ) + 
      
      IF( EXISTS(Options.ModelsRequested(ModelName = BusinessCredit_Services.Constants.BLENDED_SCORE_BBFM_NSBFEWITHEXP)), 
        setModelName(BusinessCredit_Services.Constants.BLENDED_SCORE_BBFM_NSBFEWITHEXP, Models.LIB_BusinessRisk_Function(shell_res_grpd, BusinessCredit_Services.Constants.BLENDED_SCORE_BBFM_NSBFEWITHEXP, boca_shell_grouped)) ) +    
      
      IF( EXISTS(Options.ModelsRequested(ModelName = BusinessCredit_Services.Constants.CREDIT_SCORE_SLBO)), 
          setModelName(BusinessCredit_Services.Constants.CREDIT_SCORE_SLBO, Models.LIB_BusinessRisk_Function(shell_res_grpd, BusinessCredit_Services.Constants.CREDIT_SCORE_SLBO)) ) + 		
      
      IF( EXISTS(Options.ModelsRequested(ModelName = BusinessCredit_Services.Constants.BLENDED_SCORE_SLBBNFEL)), 
          setModelName(BusinessCredit_Services.Constants.BLENDED_SCORE_SLBBNFEL, Models.LIB_BusinessRisk_Function(shell_res_grpd, BusinessCredit_Services.Constants.BLENDED_SCORE_SLBBNFEL, boca_shell_grouped)) ) + 		
      
      IF( EXISTS(Options.ModelsRequested(ModelName = BusinessCredit_Services.Constants.CREDIT_SCORE_SLBONFEL)), 
          setModelName(BusinessCredit_Services.Constants.CREDIT_SCORE_SLBONFEL, Models.LIB_BusinessRisk_Function(shell_res_grpd, BusinessCredit_Services.Constants.CREDIT_SCORE_SLBONFEL)) ) + 		


      DATASET([], Layout_ModelOut_Plus);

    // If no rep info is input, but a blended model is requested, set the score to 0 and blank out the reason codes since there isn't enough info to calculate.
    //Unless the model is BBFM1906_1_0, then use the score
  
      Model_Results_Good_Inputs := JOIN(Model_Results_unsorted, ds_input, 
                                        LEFT.Seq = RIGHT.Seq, 
                                        TRANSFORM(RECORDOF(LEFT),
                                                  Invalid_Blended_Request := LEFT.ModelName IN BusinessCredit_Services.Constants.MODEL_NAME_SETS.BLENDED_ALL 
                                                    AND (TRIM(RIGHT.AuthReps[1].FullName) = '' 
                                                    AND TRIM(RIGHT.AuthReps[1].FirstName) = ''
                                                    AND TRIM(RIGHT.AuthReps[1].LastName)  = ''
                                                    AND LEFT.ModelName != BusinessCredit_Services.Constants.BBFM1906_1_0);
                                                  SELF.Score := IF(Invalid_Blended_Request, '0', LEFT.Score);
                                                  SELF.ri := IF(Invalid_Blended_Request, DATASET([],	Risk_Indicators.Layout_Desc), LEFT.ri);
                                                  SELF := LEFT), 
                                        LEFT OUTER, 
                                        KEEP(1)); 
 


    Model_Results_sorted :=
      SORT(
        Model_Results_Good_Inputs, // Sort to the top the "real" model names.
        seq,
        IF( STD.Str.Find(ModelName,'1601_0_0',1) > 0, 0, 1 ),
        ModelName
      );

    A := allow_SBFE_scores;
    B := BusShellv22_scores_requested;
    C := SBFE_models_requested;

    Model_Results :=
      MAP(
         A AND  B AND  C => Model_Results_sorted,
         A AND  B AND ~C => Model_Results_sorted( ModelName NOT IN LNSmallBusiness.Constants.set_SBFE_models ),
         A AND ~B AND  C => Model_Results_sorted( ModelName NOT IN LNSmallBusiness.Constants.set_BusShellv22_models ),
         A AND ~B AND ~C => Model_Results_sorted( ModelName NOT IN (LNSmallBusiness.Constants.set_SBFE_models + LNSmallBusiness.Constants.set_BusShellv22_models) ),
        ~A AND  B        => Model_Results_sorted( ModelName NOT IN LNSmallBusiness.Constants.set_SBFE_models ), // this condition is the only one that needs to be corrected
        ~A AND ~B        => Model_Results_sorted( ModelName NOT IN (LNSmallBusiness.Constants.set_SBFE_models + LNSmallBusiness.Constants.set_BusShellv22_models) ),
        Model_Results_sorted( ModelName NOT IN (LNSmallBusiness.Constants.set_SBFE_models + LNSmallBusiness.Constants.set_BusShellv22_models) )
      );

  /* ************************************************************************
     *             Flatten Model results for Intermediate Log               *
     ************************************************************************ */
    // layout_model_results_flat := RECORD
      // UNSIGNED4 seq;
      // STRING20 Model_Name; // e.g. 'SBBM1601_0_0' / BusinessCredit_Services.Constants.BLENDED_SCORE_MODEL
      // STRING3 Model_Score;
      // STRING5 Model_RC1;  // RC = Reason Code
      // STRING5 Model_RC2;
      // STRING5 Model_RC3;
      // STRING5 Model_RC4;
    // END;

    // Model_Results_flat :=
      // PROJECT(
        // Model_Results,
        // TRANSFORM( layout_model_results_flat,
          // SELF.seq := LEFT.seq,
          // SELF.Model_Name  := LEFT.ModelName,
          // SELF.Model_Score := LEFT.Score,
          // SELF.Model_RC1   := LEFT.ri[1].hri,
          // SELF.Model_RC2   := LEFT.ri[2].hri,
          // SELF.Model_RC3   := LEFT.ri[3].hri,
          // SELF.Model_RC4   := LEFT.ri[4].hri
        // )
      // );

    // Shell_Results_plus_Scores_pre_denorm :=
      // PROJECT(
        // Shell_Results,
        // TRANSFORM( LNSmallBusiness.BIP_Layouts.Business_Shell_Plus_Scores_Layout, SELF := LEFT, SELF := [] )
      // );

    // LNSmallBusiness.BIP_Layouts.Business_Shell_Plus_Scores_Layout xfm_addScores(LNSmallBusiness.BIP_Layouts.Business_Shell_Plus_Scores_Layout le, DATASET(layout_model_results_flat) allRows) :=
      // TRANSFORM
        // SELF.Model_1_Name  := allRows[1].Model_Name;
        // SELF.Model_1_Score := allRows[1].Model_Score;
        // SELF.Model_1_RC1   := allRows[1].Model_RC1;
        // SELF.Model_1_RC2   := allRows[1].Model_RC2;
        // SELF.Model_1_RC3   := allRows[1].Model_RC3;
        // SELF.Model_1_RC4   := allRows[1].Model_RC4;
        // SELF.Model_2_Name  := allRows[2].Model_Name;
        // SELF.Model_2_Score := allRows[2].Model_Score;
        // SELF.Model_2_RC1   := allRows[2].Model_RC1;
        // SELF.Model_2_RC2   := allRows[2].Model_RC2;
        // SELF.Model_2_RC3   := allRows[2].Model_RC3;
        // SELF.Model_2_RC4   := allRows[2].Model_RC4;
        // SELF := le;
        // SELF := [];
      // END;

    // Shell_Results_plus_Scores :=
      // DENORMALIZE(
        // Shell_Results_plus_Scores_pre_denorm, Model_Results_flat,
        // LEFT.seq = RIGHT.seq,
        // GROUP,
        // xfm_addScores(LEFT,ROWS(RIGHT))
      // );

    // DEBUGGING OPTIONS
    // OUTPUT(SeqInput_Raw, NAMED('SeqInput_Raw'));
    // OUTPUT(SeqInput, NAMED('SeqInput'));
    // OUTPUT(Shell_Input, NAMED('Shell_Input'));
    // OUTPUT(BIPIDWeightThreshold, NAMED('BIPIDWeightThreshold'));
    // OUTPUT(allow_SBFE_scores, NAMED('allow_SBFE_scores'));
    // OUTPUT(SBFE_models_requested, NAMED('SBFE_models_requested'));
    // OUTPUT(BusShellv22_scores_requested, NAMED('BusShellv22_scores_requested'));
    // OUTPUT(Shell_Results, NAMED('Shell_Results'));
    // OUTPUT(BSVersion, NAMED('BSVersion'));
    // OUTPUT(BSOptions, NAMED('BSOptions'));
    // OUTPUT(IID_Prep_Acct, NAMED('IID_Prep_Acct'));
    // OUTPUT(IID_Prep, NAMED('IID_Prep'));
    // OUTPUT(IID, NAMED('IID'));
    // OUTPUT(Clam, NAMED('BocaShellResults'));
    // OUTPUT(Blank_Boca_Shell, NAMED('Blank_Boca_Shell'));
    // OUTPUT(Boca_Shell_Grouped, NAMED('Boca_Shell_Grouped'));
    // OUTPUT(Model_Results_unsorted, NAMED('Model_Results_unsorted'));
    // OUTPUT(Model_Results_Good_Inputs, NAMED('Model_Results_Good_Inputs'));
    // OUTPUT(Model_Results_sorted, NAMED('Model_Results_sorted'));

    RETURN Model_Results;

    #ELSE // Else, output the model results directly

//	return Models.LIB_BusinessRisk_Models(shell_res_grpd,,boca_shell_grouped,iid,,DPPA_Purpose,GLBA_Purpose,DataRestrictionMask_in,DataPermissionMask,appType).ValidatingModel;
  RETURN Models.LIB_BusinessRisk_Models(shell_res_grpd , bocaShell := boca_shell_grouped).ValidatingModel;
#END

END;
