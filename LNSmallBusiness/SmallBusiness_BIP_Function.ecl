IMPORT Address, BIPv2, Business_Risk_BIP, BusinessCredit_Services, Cortera, Gateway, IESP, 
       Models, Risk_Indicators, Risk_Reporting, RiskWise, Suspicious_Fraud_LN, 
       UT, Royalty, Address;

EXPORT SmallBusiness_BIP_Function (
											DATASET(LNSmallBusiness.BIP_Layouts.Input) Input,
											UNSIGNED1	DPPA_Purpose					= Business_Risk_BIP.Constants.Default_DPPA,
											UNSIGNED1	GLBA_Purpose					= Business_Risk_BIP.Constants.Default_GLBA,
											STRING50	DataRestrictionMask_in	  = Business_Risk_BIP.Constants.Default_DataRestrictionMask,
											STRING50	DataPermissionMask		= Business_Risk_BIP.Constants.Default_DataPermissionMask,
											STRING10	IndustryClass				  = Business_Risk_BIP.Constants.Default_IndustryClass,
											UNSIGNED1	LinkSearchLevel			  = Business_Risk_BIP.Constants.LinkSearch.Default,
											UNSIGNED1	MarketingMode				  = Business_Risk_BIP.Constants.Default_MarketingMode,
											STRING50	AllowedSources				= Business_Risk_BIP.Constants.Default_AllowedSources,
											UNSIGNED1	OFAC_Version					= Business_Risk_BIP.Constants.Default_OFAC_Version,
											REAL			Global_Watchlist_Threshold	= Business_Risk_BIP.Constants.Default_Global_Watchlist_Threshold,
											DATASET(iesp.Share.t_StringArrayItem) Watchlists_Requested = Business_Risk_BIP.Constants.Default_Watchlists_Requested,
											DATASET(Gateway.Layouts.Config) Gateways = Business_Risk_BIP.Constants.Default_Gateways_Requested,
											DATASET(LNSmallBusiness.Layouts.AttributeGroupRec) AttributesRequested = DATASET([], LNSmallBusiness.Layouts.AttributeGroupRec),
											DATASET(LNSmallBusiness.Layouts.ModelNameRec) ModelsRequested = DATASET([], LNSmallBusiness.Layouts.ModelNameRec),
											DATASET(LNSmallBusiness.Layouts.ModelOptionsRec) ModelOptions = DATASET([], LNSmallBusiness.Layouts.ModelOptionsRec),
											BOOLEAN DisableIntermediateShellLogging = FALSE,
											BOOLEAN IncludeTargusGateway = FALSE,
											BOOLEAN RunTargusGateway = FALSE,
											UNSIGNED2 BIPIDWeightThreshold = LNSmallBusiness.Constants.BIPID_WEIGHT_THRESHOLD.DEFAULT_VALUE,
                      BOOLEAN CorteraRetrotest = FALSE,
											DATASET(Cortera.layout_Retrotest_raw) ds_CorteraRetrotestRecsRaw = DATASET([],Cortera.layout_Retrotest_raw),
           BOOLEAN AppendBestsFromLexIDs = FALSE           
																							) := FUNCTION

	RESTRICTED_SET := ['0', ''];

	// Use the SBFE restriction to return Scores or not.
	allow_SBFE_scores := DataPermissionMask[12] NOT IN RESTRICTED_SET;
  BusShellv22_scores_requested := EXISTS(ModelsRequested(ModelName IN BusinessCredit_Services.Constants.MODEL_NAME_SETS.CREDIT_BLENDED_SLBB_SLBO+ BusinessCredit_Services.Constants.MODEL_NAME_SETS.CREDIT_BLENDED_SLBBNFEL_SLBONFEL));
  
/* ************************************************************************
	 *                    Set common Business Shell Options                 *
	 ************************************************************************ */
	UNSIGNED1	BusShellVersion	:= MAP((UNSIGNED)AttributesRequested(AttributeGroup[1..18] = 'SMALLBUSINESSATTRV')[1].AttributeGroup[19..] = 2 => Business_Risk_BIP.Constants.BusShellVersion_v30,
                                    BusShellv22_scores_requested                                                                           => Business_Risk_BIP.Constants.BusShellVersion_v22,
                                   (UNSIGNED)AttributesRequested(AttributeGroup[1..18] = 'SMALLBUSINESSATTRV')[1].AttributeGroup[19..] = 1 => Business_Risk_BIP.Constants.BusShellVersion_v21,
                                                                                                                                              Business_Risk_BIP.Constants.Default_BusShellVersion);
	
  
	// Create a datarow to add to the intermediate log.
	Risk_Reporting.Layouts.Business_Risk_Job_Options xfm_options := TRANSFORM
		SELF.DPPA_Purpose	              := DPPA_Purpose;
		SELF.GLBA_Purpose	              := GLBA_Purpose;
		SELF.DataRestrictionMask        := DataRestrictionMask_in;
		SELF.DataPermissionMask         := DataPermissionMask;
		SELF.IndustryClass              := IndustryClass;
		SELF.LinkSearchLevel            := LinkSearchLevel;
		SELF.MarketingMode              := MarketingMode;
		SELF.AllowedSources             := AllowedSources;
		SELF.OFAC_Version               := OFAC_Version;
		SELF.Global_Watchlist_Threshold := Global_Watchlist_Threshold;
		SELF.IncludeTargusGateway       := (UNSIGNED1)IncludeTargusGateway;
		SELF.Watchlists_Requested       := Watchlists_Requested;
		SELF.Gateways                   := Gateways;
		SELF.AttributesRequested        := AttributesRequested;
		SELF.ModelsRequested            := ModelsRequested;
		SELF.ModelOptions               := ModelOptions;	
	END;
	
	rw_options := ROW( xfm_options );
	
/* ************************************************************************
	 *     Uniquely Sequence Input and Convert to Business Shell inputs     *
	 ************************************************************************ */
	// Generate the linking parameters to be used in BIP's kFetch (Key Fetch) - These parameters should be global so figure them out here and pass around appropriately
	linkingOptions := MODULE(BIPV2.mod_sources.iParams)
		EXPORT STRING DataRestrictionMask		:= DataRestrictionMask_in; // Note: Must unfortunately leave as undefined STRING length to match the module definition
		EXPORT BOOLEAN ignoreFares					:= FALSE; // From AutoStandardI.DataRestrictionI, this is a User Configurable Input Option to Ignore FARES data - since the Business Shell doesn't accept this input default it to FALSE to always utilize whatever the DataRestrictionMask allows
		EXPORT BOOLEAN ignoreFidelity				:= FALSE; // From AutoStandardI.DataRestrictionI, this is a User Configurable Input Option to Ignore Fidelity data - since the Business Shell doesn't accept this input default it to FALSE to always utilize whatever the DataRestrictionMask allows
		EXPORT BOOLEAN AllowAll							:=  FALSE; // When TRUE this will unmask DNB DMI data - NO CUSTOMERS CAN USE THIS, FOR RESEARCH PURPOSES ONLY
		EXPORT BOOLEAN AllowGLB							:= Risk_Indicators.iid_constants.GLB_OK(GLBA_Purpose, FALSE /*isFCRA*/);
		EXPORT BOOLEAN AllowDPPA						:= Risk_Indicators.iid_constants.DPPA_OK(DPPA_Purpose, FALSE /*isFCRA*/);
		EXPORT UNSIGNED1 DPPAPurpose				:= DPPA_Purpose;
		EXPORT UNSIGNED1 GLBPurpose					:= GLBA_Purpose;
		EXPORT BOOLEAN IncludeMinors				:= TRUE; // Shouldn't really have an impact on business searches, set to TRUE for now
		EXPORT BOOLEAN LNBranded						:= TRUE; // Not entirely certain what effect this has
	END;
   
	SeqInput_Raw := PROJECT(Input, TRANSFORM(LNSmallBusiness.BIP_Layouts.InputWSeq, SELF.Seq := COUNTER; SELF := LEFT));
 SeqInput := IF(AppendBestsFromLexIDs, LNSmallBusiness.SmallBusiness_BIP_Append_Inputs(SeqInput_Raw, linkingOptions), SeqInput_Raw) ;
 
	Business_Risk_BIP.Layouts.Input convertToBusinessShellInput(SeqInput le) := TRANSFORM
		SELF.Seq := le.Seq;
		SELF.AcctNo := le.AcctNo;
		SELF.HistoryDate := IF(le.HistoryDateYYYYMM > 0, le.HistoryDateYYYYMM, le.HistoryDate);
		SELF.HistoryDateTime := IF(le.HistoryDate > 0, le.HistoryDate, le.HistoryDateYYYYMM);
		SELF.CompanyName := le.Bus_Company_Name;
		SELF.AltCompanyName := le.Bus_Doing_Business_As;
		SELF.StreetAddress1 := le.Bus_Street_Address1;
		SELF.StreetAddress2 := le.Bus_Street_Address2;
		SELF.City := le.Bus_City;
		SELF.State := le.Bus_State;
		SELF.Zip := IF((INTEGER)le.Bus_Zip > 0, le.Bus_Zip, TRIM(le.Bus_Zip5) + TRIM(le.Bus_Zip4));
		SELF.Prim_Range := le.Bus_Prim_Range;
		SELF.PreDir := le.Bus_PreDir;
		SELF.Prim_Name := le.Bus_Prim_Name;
		SELF.Addr_Suffix := le.Bus_Addr_Suffix;
		SELF.PostDir := le.Bus_PostDir;
		SELF.Unit_Desig := le.Bus_Unit_Desig;
		SELF.Sec_Range := le.Bus_Sec_Range;
		SELF.FEIN := le.Bus_FEIN;
		SELF.Phone10 := le.Bus_Phone10;
		// SELF.IPAddr := '';
		// SELF.CompanyURL := '';
		SELF.SIC := le.Bus_SIC_Code;
		SELF.NAIC := le.Bus_NAIC_Code;
		SELF.Bus_Structure := le.Bus_Structure;
		SELF.Years_in_Business := le.Bus_Years_in_Business;
		SELF.Bus_Start_Date := le.Bus_Start_Date;
		SELF.Yearly_Revenue := le.Bus_Yearly_Revenue;
		SELF.Fax_Number := le.Bus_Fax_Number;
    SELF.Rep_LexID    := le.Rep_1_LexID;
		SELF.Rep_FullName := le.Rep_1_Full_Name;
		SELF.Rep_FirstName := le.Rep_1_First_Name;
		SELF.Rep_MiddleName := le.Rep_1_Middle_Name;
		SELF.Rep_LastName := le.Rep_1_Last_Name;
		SELF.Rep_NameSuffix := le.Rep_1_Suffix;
		SELF.Rep_FormerLastName := le.Rep_1_Former_Last_Name;
		SELF.Rep_StreetAddress1 := le.Rep_1_Street_Address1;
		SELF.Rep_StreetAddress2 := le.Rep_1_Street_Address2;
		SELF.Rep_City := le.Rep_1_City;
		SELF.Rep_State := le.Rep_1_State;
		SELF.Rep_Zip := IF((INTEGER)le.Rep_1_Zip > 0, le.Rep_1_Zip, TRIM(le.Rep_1_Zip5) + TRIM(le.Rep_1_Zip4));
		SELF.Rep_Prim_Range := le.Rep_1_Prim_Range;
		SELF.Rep_PreDir := le.Rep_1_PreDir;
		SELF.Rep_Prim_Name := le.Rep_1_Prim_Name;
		SELF.Rep_Addr_Suffix := le.Rep_1_Addr_Suffix;
		SELF.Rep_PostDir := le.Rep_1_PostDir;
		SELF.Rep_Unit_Desig := le.Rep_1_Unit_Desig;
		SELF.Rep_Sec_Range := le.Rep_1_Sec_Range;
		SELF.Rep_SSN := le.Rep_1_SSN;
		SELF.Rep_DateOfBirth := le.Rep_1_DOB;
		SELF.Rep_Phone10 := le.Rep_1_Phone10;
		SELF.Rep_Age := le.Rep_1_Age;
		SELF.Rep_DLNumber := le.Rep_1_DL_Number;
		SELF.Rep_DLState := le.Rep_1_DL_State;
		SELF.Rep_BusinessTitle := le.Rep_1_Business_Title;
		SELF.Rep2_LexID    := le.Rep_2_LexID;
		SELF.Rep2_FullName := le.Rep_2_Full_Name;
		SELF.Rep2_FirstName := le.Rep_2_First_Name;
		SELF.Rep2_MiddleName := le.Rep_2_Middle_Name;
		SELF.Rep2_LastName := le.Rep_2_Last_Name;
		SELF.Rep2_NameSuffix := le.Rep_2_Suffix;
		SELF.Rep2_FormerLastName := le.Rep_2_Former_Last_Name;
		SELF.Rep2_StreetAddress1 := le.Rep_2_Street_Address1;
		SELF.Rep2_StreetAddress2 := le.Rep_2_Street_Address2;
		SELF.Rep2_City := le.Rep_2_City;
		SELF.Rep2_State := le.Rep_2_State;
		SELF.Rep2_Zip := IF((INTEGER)le.Rep_2_Zip > 0, le.Rep_2_Zip, TRIM(le.Rep_2_Zip5) + TRIM(le.Rep_2_Zip4));
		SELF.Rep2_Prim_Range := le.Rep_2_Prim_Range;
		SELF.Rep2_PreDir := le.Rep_2_PreDir;
		SELF.Rep2_Prim_Name := le.Rep_2_Prim_Name;
		SELF.Rep2_Addr_Suffix := le.Rep_2_Addr_Suffix;
		SELF.Rep2_PostDir := le.Rep_2_PostDir;
		SELF.Rep2_Unit_Desig := le.Rep_2_Unit_Desig;
		SELF.Rep2_Sec_Range := le.Rep_2_Sec_Range;
		SELF.Rep2_SSN := le.Rep_2_SSN;
		SELF.Rep2_DateOfBirth := le.Rep_2_DOB;
		SELF.Rep2_Phone10 := le.Rep_2_Phone10;
		SELF.Rep2_Age := le.Rep_2_Age;
		SELF.Rep2_DLNumber := le.Rep_2_DL_Number;
		SELF.Rep2_DLState := le.Rep_2_DL_State;
		SELF.Rep2_BusinessTitle := le.Rep_2_Business_Title;
		SELF.Rep3_LexID    := le.Rep_3_LexID;
		SELF.Rep3_FullName := le.Rep_3_Full_Name;
		SELF.Rep3_FirstName := le.Rep_3_First_Name;
		SELF.Rep3_MiddleName := le.Rep_3_Middle_Name;
		SELF.Rep3_LastName := le.Rep_3_Last_Name;
		SELF.Rep3_NameSuffix := le.Rep_3_Suffix;
		SELF.Rep3_FormerLastName := le.Rep_3_Former_Last_Name;
		SELF.Rep3_StreetAddress1 := le.Rep_3_Street_Address1;
		SELF.Rep3_StreetAddress2 := le.Rep_3_Street_Address2;
		SELF.Rep3_City := le.Rep_3_City;
		SELF.Rep3_State := le.Rep_3_State;
		SELF.Rep3_Zip := IF((INTEGER)le.Rep_3_Zip > 0, le.Rep_3_Zip, TRIM(le.Rep_3_Zip5) + TRIM(le.Rep_3_Zip4));
		SELF.Rep3_Prim_Range := le.Rep_3_Prim_Range;
		SELF.Rep3_PreDir := le.Rep_3_PreDir;
		SELF.Rep3_Prim_Name := le.Rep_3_Prim_Name;
		SELF.Rep3_Addr_Suffix := le.Rep_3_Addr_Suffix;
		SELF.Rep3_PostDir := le.Rep_3_PostDir;
		SELF.Rep3_Unit_Desig := le.Rep_3_Unit_Desig;
		SELF.Rep3_Sec_Range := le.Rep_3_Sec_Range;
		SELF.Rep3_SSN := le.Rep_3_SSN;
		SELF.Rep3_DateOfBirth := le.Rep_3_DOB;
		SELF.Rep3_Phone10 := le.Rep_3_Phone10;
		SELF.Rep3_Age := le.Rep_3_Age;
		SELF.Rep3_DLNumber := le.Rep_3_DL_Number;
		SELF.Rep3_DLState := le.Rep_3_DL_State;
		SELF.Rep3_BusinessTitle := le.Rep_3_Business_Title;
		
		SELF := le;
		SELF := [];
	END;
	Shell_Input := PROJECT(SeqInput, convertToBusinessShellInput(LEFT));
	 
/* ************************************************************************
	 *                      Grab Business Shell Results                     *
	 ************************************************************************ */	
	Shell_Results_pre := Business_Risk_BIP.LIB_Business_Shell_Function(Shell_Input,
																																 DPPA_Purpose,
																																 GLBA_Purpose,
																																 DataRestrictionMask_in,
																																 DataPermissionMask,
																																 IndustryClass,
																																 LinkSearchLevel,
																																 BusShellVersion,
																																 MarketingMode,
																																 AllowedSources,
																																 Business_Risk_BIP.Constants.BIPBestAppend.Default,
																																 OFAC_Version,
																																 Global_Watchlist_Threshold,
																																 Watchlists_Requested,
																																 Business_Risk_BIP.Constants.DefaultJoinType, 
																																 IncludeTargusGateway,
																																 Gateways,
																																 RunTargusGateway, /* for testing purposes only */ 
																																 FALSE,
																																 FALSE,
																																 FALSE,
                                 CorteraRetrotest,
																																 ds_CorteraRetrotestRecsRaw);

	Business_Risk_BIP.Layouts.Shell fn_transformToNoHit( Business_Risk_BIP.Layouts.Shell shell_results ) :=
		FUNCTION
			// First force a no-hit result for the Business Shell record.
			BlankShell_pre := 
				PROJECT( shell_results, Business_Risk_BIP.xfm_finalizeBlankShellFields( LEFT, BusShellVersion ) );
			
			// Render blank SBFE data if the DataPermissionMask restricts SBFE data.
			BlankShell_restricted := 
				PROJECT( BlankShell_pre, TRANSFORM( Business_Risk_BIP.Layouts.Shell, SELF.SBFE := [], SELF := LEFT ) );
			
			// Render blank SBFE enhancement (v2.1) attributes if the Business Shell version is less than 2.1.
			BlankShell_v20 := 
				PROJECT(BlankShell_pre, Business_Risk_BIP.xfm_blankOutSBFEEnhancementAttrs(LEFT));

			BlankShell := MAP( NOT allow_SBFE_scores							 																=> BlankShell_restricted,
												 BusShellVersion <= Business_Risk_BIP.Constants.BusShellVersion_v20 => BlankShell_v20,
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
	BSVersion           := if(BusShellVersion = Business_Risk_BIP.Constants.BusShellVersion_v22, 51, 50);
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
	UNSIGNED8 BSOptions := Risk_Indicators.iid_constants.BSOptions.IncludeFraudVelocity +
												 Risk_Indicators.iid_constants.BSOptions.RetainInputDID;

/* Need this used if want same results as a separate boca shell
boolean RetainInputDID := false;
unsigned8 BSOptions := 
	if(Include_DL_Verification, risk_indicators.iid_constants.BSOptions.IncludeDoNotMail +
										 risk_indicators.iid_constants.BSOptions.IncludeFraudVelocity,
											0) +
	if(RetainInputDID, Risk_Indicators.iid_constants.BSOptions.RetainInputDID, 0 ) +
	if(bsVersion >= 50, risk_indicators.iid_constants.BSOptions.IncludeHHIDSummary, 0);
*/
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
	
	IID := Risk_Indicators.InstantID_Function(IID_Prep, Gateways,	DPPA_Purpose,	GLBA_Purpose, IsUtility, LN_Branded, OFAC_Only, SuppressNearDups, Require2ele, IsFCRA, 
	From_BIID, ExcludeWatchLists, From_IT1O, OFAC_Version, Include_OFAC, Addtl_Watchlists, Global_Watchlist_Threshold, DOB_Radius, BSVersion, In_DataRestriction := DataRestrictionMask_in, 
	in_runDLverification := include_DL_verification, in_append_best := AppendBest, in_BSOptions := BSOptions, in_LastSeenThreshold := LastSeenThreshold, in_DataPermission := DataPermissionMask);
	
	Clam := Risk_Indicators.Boca_Shell_Function(IID, Gateways,	DPPA_Purpose,	GLBA_Purpose, IsUtility, LN_Branded, IncludeRel, IncludeDL, IncludeVeh, IncludeDerog, BSVersion, DoScore, Nugen, DataRestriction := DataRestrictionMask_in, BSOptions := BSOptions, DataPermission := DataPermissionMask);																							 
	
	Blank_Boca_Shell := GROUP(DATASET([], Risk_Indicators.Layout_Boca_Shell), Seq);
	
	Boca_Shell_Grouped := IF(EXISTS(ModelsRequested(ModelName in BusinessCredit_Services.Constants.MODEL_NAME_SETS.BLENDED_ALL)), Clam, Blank_Boca_Shell); //don't call the boca shell if a model doesn't need it
	
/* ************************************************************************
	 *                       Prepare Attribute Outputs                      *
	 ************************************************************************ */
	Attribute_Results := LNSmallBusiness.getSmallBusinessAttributes(Shell_Results, BusShellVersion);
	
/* **************************************************************************
	 *                            Calculate Scores                            *
	 * Note: The model score range is 501-900 with an exception score of 222. *
	 ************************************************************************ */	 
	shell_res_grpd := GROUP(SORT(Shell_Results,seq),seq);
	
	#if(Models.LIB_BusinessRisk_Models().TurnOnValidation = FALSE)
	
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
		IF( EXISTS(ModelsRequested(ModelName = 'SBBM9999_9')), 
				setModelName('SBBM9999_9', Models.LIB_BusinessRisk_Function(shell_res_grpd, 'SBBM9999_9')) ) + 
		IF( EXISTS(ModelsRequested(ModelName = 'SBOM9999_9')), 
				setModelName('SBOM9999_9', Models.LIB_BusinessRisk_Function(shell_res_grpd, 'SBOM9999_9')) ) + 
		// Actual model names:
		IF( EXISTS(ModelsRequested(ModelName = BusinessCredit_Services.Constants.BLENDED_SCORE_MODEL)), 
				setModelName(BusinessCredit_Services.Constants.BLENDED_SCORE_MODEL, Models.LIB_BusinessRisk_Function(shell_res_grpd, BusinessCredit_Services.Constants.BLENDED_SCORE_MODEL, boca_shell_grouped)) ) + 
		IF( EXISTS(ModelsRequested(ModelName = BusinessCredit_Services.Constants.CREDIT_SCORE_MODEL)), 
				setModelName(BusinessCredit_Services.Constants.CREDIT_SCORE_MODEL, Models.LIB_BusinessRisk_Function(shell_res_grpd, BusinessCredit_Services.Constants.CREDIT_SCORE_MODEL)) ) + 		
		IF( EXISTS(ModelsRequested(ModelName = BusinessCredit_Services.Constants.BLENDED_SCORE_SLBB)), 
				setModelName(BusinessCredit_Services.Constants.BLENDED_SCORE_SLBB, Models.LIB_BusinessRisk_Function(shell_res_grpd, BusinessCredit_Services.Constants.BLENDED_SCORE_SLBB, boca_shell_grouped)) ) + 
		IF( EXISTS(ModelsRequested(ModelName = BusinessCredit_Services.Constants.CREDIT_SCORE_SLBO)), 
				setModelName(BusinessCredit_Services.Constants.CREDIT_SCORE_SLBO, Models.LIB_BusinessRisk_Function(shell_res_grpd, BusinessCredit_Services.Constants.CREDIT_SCORE_SLBO)) ) + 		

		DATASET([], Layout_ModelOut_Plus);

	// If no rep info is input, but a blended model is requested, set the score to 0 and blank out the reason codes since there isn't enough info to calculate.
	Model_Results_Good_Inputs := JOIN(Model_Results_unsorted, SeqInput, LEFT.Seq = RIGHT.Seq, TRANSFORM(RECORDOF(LEFT),
		Invalid_Blended_Request := LEFT.ModelName IN BusinessCredit_Services.Constants.MODEL_NAME_SETS.BLENDED_ALL AND 
																													(TRIM(RIGHT.Rep_1_Full_Name) = '' AND TRIM(RIGHT.Rep_1_First_Name) = '' AND TRIM(RIGHT.Rep_1_Last_Name) = '');
		SELF.Score := IF(Invalid_Blended_Request, '0', LEFT.Score);
		SELF.ri := IF(Invalid_Blended_Request, DATASET([],	Risk_Indicators.Layout_Desc), LEFT.ri);
		SELF := LEFT), 
		LEFT OUTER, KEEP(1));
		
	Model_Results_sorted := 
		SORT( 
			Model_Results_Good_Inputs, // Sort to the top the "real" model names.
			seq,
			IF( StringLib.StringFind(ModelName,'1601_0_0',1) > 0, 0, 1 ), 
			ModelName 
		);
	
	Model_Results := IF( allow_SBFE_scores or BusShellv22_scores_requested,
																	Model_Results_sorted, 
																	DATASET([], Layout_ModelOut_Plus) );
	
/* ************************************************************************
	 *             Flatten Model results for Intermediate Log               *
	 ************************************************************************ */
	layout_model_results_flat := RECORD
		UNSIGNED4 seq;
		STRING20 Model_Name; // e.g. 'SBBM1601_0_0' / BusinessCredit_Services.Constants.BLENDED_SCORE_MODEL
		STRING3 Model_Score;
		STRING5 Model_RC1;  // RC = Reason Code
		STRING5 Model_RC2;
		STRING5 Model_RC3;
		STRING5 Model_RC4;
	END;
	
	Model_Results_flat := 
		PROJECT(
			Model_Results,
			TRANSFORM( layout_model_results_flat,
				SELF.seq := LEFT.seq,
				SELF.Model_Name  := LEFT.ModelName,
				SELF.Model_Score := LEFT.Score,
				SELF.Model_RC1   := LEFT.ri[1].hri,
				SELF.Model_RC2   := LEFT.ri[2].hri,
				SELF.Model_RC3   := LEFT.ri[3].hri,
				SELF.Model_RC4   := LEFT.ri[4].hri
			)
		);
	
	Shell_Results_plus_Scores_pre_denorm := 
		PROJECT( 
			Shell_Results, 
			TRANSFORM( LNSmallBusiness.BIP_Layouts.Business_Shell_Plus_Scores_Layout, SELF := LEFT, SELF := [] ) 
		);
		
	LNSmallBusiness.BIP_Layouts.Business_Shell_Plus_Scores_Layout xfm_addScores(LNSmallBusiness.BIP_Layouts.Business_Shell_Plus_Scores_Layout le, DATASET(layout_model_results_flat) allRows) :=
		TRANSFORM
			SELF.Model_1_Name  := allRows[1].Model_Name;
			SELF.Model_1_Score := allRows[1].Model_Score;
			SELF.Model_1_RC1   := allRows[1].Model_RC1;
			SELF.Model_1_RC2   := allRows[1].Model_RC2;
			SELF.Model_1_RC3   := allRows[1].Model_RC3;
			SELF.Model_1_RC4   := allRows[1].Model_RC4;
			SELF.Model_2_Name  := allRows[2].Model_Name;
			SELF.Model_2_Score := allRows[2].Model_Score;
			SELF.Model_2_RC1   := allRows[2].Model_RC1;
			SELF.Model_2_RC2   := allRows[2].Model_RC2;
			SELF.Model_2_RC3   := allRows[2].Model_RC3;
			SELF.Model_2_RC4   := allRows[2].Model_RC4;
			SELF := le;
			SELF := [];
		END;
		
	Shell_Results_plus_Scores :=
		DENORMALIZE(
			Shell_Results_plus_Scores_pre_denorm, Model_Results_flat,
			LEFT.seq = RIGHT.seq,
			GROUP,
			xfm_addScores(LEFT,ROWS(RIGHT))
		);

/* **************************************
   *   Bus Shell Logging Functionality  *
   ************************************** */
	productID := Risk_Reporting.ProductID.LNSmallBusiness__SmallBusiness_Service;
	intermediate_Log := IF(DisableIntermediateShellLogging = TRUE, DATASET([], Risk_Reporting.Layouts.LOG_Business_Shell), Risk_Reporting.To_LOG_Business_Shell(Shell_Results_plus_Scores, productID, BusShellVersion, Risk_Reporting.ProcessType.Internal, rw_options));
	#stored('Intermediate_Log', intermediate_log);
 /* ************ End Logging ************/
		
/* ************************************************************************
	 *                        Add Back our Input Echo                       *
	 ************************************************************************ */
	withAttributes := 
		JOIN(
			SeqInput, Attribute_Results, 
			LEFT.Seq = RIGHT.Seq, 
			TRANSFORM( LNSmallBusiness.BIP_Layouts.IntermediateLayout, 
				SELF.Input_Echo := LEFT; 
				SELF := RIGHT
			), 
			LEFT OUTER, ATMOST(1));
	
	// Merge Attributes and Scores
	iesp.smallbusinessanalytics.t_SBAScoreHRI getScoreResults(Layout_ModelOut_Plus le) := TRANSFORM
		SELF._Type := '';
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
	
	iesp.smallbusinessanalytics.t_SBAModelHRI getModelResults(Layout_ModelOut_Plus le) := TRANSFORM
		SELF.Name := le.ModelName;
		SELF.Scores := PROJECT(le, getScoreResults(LEFT));
	END;
	
	withScores := 
		JOIN(
			withAttributes, Model_Results, 
			LEFT.Seq = RIGHT.Seq, 
			TRANSFORM( LNSmallBusiness.BIP_Layouts.IntermediateLayout, 
				SELF.ModelResults := PROJECT(RIGHT, getModelResults(LEFT));
				SELF := LEFT
			), 
			LEFT OUTER, ATMOST(iesp.Constants.SBAnalytics.MaxModelCount));
	
	Final := 
		ROLLUP(
			SORT(withScores, Seq), 
			LEFT.Seq = RIGHT.Seq, 
			TRANSFORM( LNSmallBusiness.BIP_Layouts.IntermediateLayout,
				SELF.ModelResults := CHOOSEN(LEFT.ModelResults + RIGHT.ModelResults, iesp.Constants.SBAnalytics.MaxModelCount);
				SELF := LEFT));
				
	// Attach the PhoneSources child dataset to the intermediateLayout for royalty purposes,
	// and calculate BillingHit.
	getBillingHitFromScores( DATASET(iesp.smallbusinessanalytics.t_SBAModelHRI) ModelResults ) := FUNCTION
		BlendedScore := ModelResults(Name in [BusinessCredit_Services.Constants.BLENDED_SCORE_MODEL, BusinessCredit_Services.Constants.BLENDED_SCORE_SLBB,BusinessCredit_Services.Constants.BLENDED_SCORE_SLBBNFEL])[1].Scores[1].Value;
		CreditScore  := ModelResults(Name in [BusinessCredit_Services.Constants.CREDIT_SCORE_MODEL, BusinessCredit_Services.Constants.CREDIT_SCORE_SLBO])[1].Scores[1].Value;
		isBillingHit := BlendedScore NOT IN [0,222] OR CreditScore NOT IN [0,222];
		RETURN isBillingHit;
	END;

	LNSmallBusiness.BIP_Layouts.IntermediateLayout_plus_PhoneSources xfm_getPhoneSourcesAndBillingHit( LNSmallBusiness.BIP_Layouts.IntermediateLayout le, Business_Risk_BIP.Layouts.Shell ri ) := 
		TRANSFORM
				BillingHitFromScores := (INTEGER)getBillingHitFromScores(le.ModelResults);
				SELF.PhoneSources := ri.PhoneSources;
				SELF.BillingHit := IF( (INTEGER)le.BillingHit + BillingHitFromScores > 0, '1', '0' );
        SELF.Rep_LexID := ri.Clean_Input.Rep_Lexid;
				SELF := le;
		END;
	
	Final_plus_PhoneSources :=
		JOIN(
			Final, Shell_Results,
			LEFT.Seq = RIGHT.Seq,
			xfm_getPhoneSourcesAndBillingHit(LEFT,RIGHT),
			LEFT OUTER
		);

	// Finally, attach the MatchWeight and make PhonesSources and BIPIDs null if there is a no-hit.
	Final_plus_MatchWeight :=
		JOIN(
			Final_plus_PhoneSources, Shell_Results_pre,
			LEFT.Seq = RIGHT.Seq,
			TRANSFORM( LNSmallBusiness.BIP_Layouts.IntermediateLayout_plus_PhoneSources,
					isGoodHit := (UNSIGNED3)RIGHT.Verification.InputIDMatchConfidence >= BIPIDWeightThreshold;
				SELF.MatchWeight  := (UNSIGNED3)RIGHT.Verification.InputIDMatchConfidence;
				SELF.PhoneSources := IF( isGoodHit, LEFT.PhoneSources, DATASET( [], Business_Risk_BIP.Layouts.LayoutSources ) );
				SELF.PowID        := IF( isGoodHit, LEFT.PowID , 0 );
				SELF.ProxID       := IF( isGoodHit, LEFT.ProxID, 0 );
				SELF.SeleID       := IF( isGoodHit, LEFT.SeleID, 0 );
				SELF.OrgID        := IF( isGoodHit, LEFT.OrgID , 0 );
				SELF.UltID        := IF( isGoodHit, LEFT.UltID , 0 );
        SELF.Rep_LexID := IF(isGoodHit, LEFT.Rep_LexID, 0);
				SELF := LEFT
			),
			LEFT OUTER
		);	
	
	// -------------------------------
	//        DEBUGGING SECTION
	// -------------------------------
	// OUTPUT(SeqInput, NAMED('SeqInput'));
	// OUTPUT(Model_Results, NAMED('Model_Results'));
	// OUTPUT(Model_Results_flat, NAMED('Model_Results_flat'));
	// OUTPUT(withAttributes, NAMED('withAttributes'));
	// OUTPUT(withScores, NAMED('withScores'));
	// OUTPUT(Final, NAMED('Final'));	
	
	// Weight_SBA := Shell_Results_pre[1].Verification.InputIDMatchConfidence;
	// OUTPUT( Weight_SBA, NAMED('MatchWeight_SBA') );
	
	RETURN Final_plus_MatchWeight;
	
#else // Else, output the model results directly
	return Models.LIB_BusinessRisk_Models(shell_res_grpd , bocaShell := boca_shell_grouped).ValidatingModel;
#end
END;