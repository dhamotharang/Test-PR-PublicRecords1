/*--SOAP--
<message name="BusinessInstantID20_Service">
  <part name="BusinessInstantID20Request" type="tns:XmlDataSet" cols="110" rows="75"/>
  <part name="DPPAPurpose" type="xsd:integer"/>
  <part name="GLBPurpose" type="xsd:integer"/>
  <part name="DataRestrictionMask" type="xsd:string"/>
  <part name="DataPermissionMask" type="xsd:string"/>
  <part name="BIID20ProductType" type="xsd:integer"/> <!-- 1,2,3,4 -->
  <part name="Gateways" type="tns:XmlDataSet" cols="100" rows="8"/>
  <part name="OFACVersion" type="xsd:integer"/>

</message>
*/
/*--INFO-- This Service is the interface into the Business InstantID ECL service, version 2.0. */

IMPORT BIPV2, Business_Risk_BIP, Gateway, iesp, MDR, OFAC_XG5, Risk_Indicators, Risk_Reporting, Royalty, STD, Inquiry_AccLogs, LNSmallBusiness, BusinessInstantID20_Services;

EXPORT InstantID20_Service() := MACRO

		#OPTION('embeddedWarningsAsErrors',0);
    
   // #option ('optimizelevel', 0); // NEVER RELEASE THIS LINE OF CODE TO PROD
                                    // this is for deploying to a 100-way as 
                                    // the service is large.
                                    // This service won't run on a 1-way.
		/* ************************************************************************
		 *                      Force the order on the WsECL page                 *
		 ************************************************************************ */
		#WEBSERVICE(FIELDS(
    'BusinessInstantID20Request',
    'DPPAPurpose',
		 'GLBPurpose',
		 'DataRestrictionMask',
		 'DataPermissionMask',
		 'BIID20ProductType',
    'Gateways',
    'OFACVersion',
		 'LexIdSourceOptout',
		 '_TransactionId',
		 '_BatchUID',
		 '_GCID'
		 ));

		/* ************************************************************************
		 *                          Grab service inputs                           *
		 ************************************************************************ */
		 
		requestIn := DATASET([], iesp.businessinstantid20.t_BusinessInstantID20Request) : STORED('BusinessInstantID20Request', FEW);
		firstRow  := requestIn[1] : INDEPENDENT; // Since this is realtime and not batch, should only have one row on input.
		search    := GLOBAL(firstRow.SearchBy);
		option    := GLOBAL(firstRow.Options);
		users     := GLOBAL(firstRow.User); 

		// 1. Read the input params and load them into a dataset.
		BusinessInstantID20_Services.Macros.mac_ReadInputIESP()
		BusinessInstantID20_Services.Macros.mac_ReadOptions()
		BusinessInstantID20_Services.Macros.mac_LoadInput()

		/* **********************************************
			 *  Fields needed for improved Scout Logging  *
			 **********************************************/
		string32 _LoginID               := ''	: STORED('_LoginID');
		outofbandCompanyID							:= '' : STORED('_CompanyID');
		string20 CompanyID              := IF(users.CompanyId != '', users.CompanyId, outofbandCompanyID);
		string20 FunctionName           := '' : STORED('_LogFunctionName');
		string50 ESPMethod              := '' : STORED('_ESPMethodName');
		string10 InterfaceVersion       := '' : STORED('_ESPClientInterfaceVersion');
		string5 DeliveryMethod          := '' : STORED('_DeliveryMethod');
		string5 DeathMasterPurpose      := '' : STORED('__deathmasterpurpose');
		outofbandssnmask                := '' : STORED('SSNMask');
		string10 SSN_Mask               := IF(users.SSNMask != '', users.SSNMask, outofbandssnmask);
		outofbanddobmask                := '' : STORED('DOBMask');
		string10 DOB_Mask               := IF(users.DOBMask != '', users.DOBMask, outofbanddobmask);
		BOOLEAN DL_Mask                 := users.DLMask;
		BOOLEAN ExcludeDMVPII           := users.ExcludeDMVPII;
		BOOLEAN DisableOutcomeTracking  := FALSE : STORED('OutcomeTrackingOptOut');
		BOOLEAN ArchiveOptIn            := FALSE : STORED('instantidarchivingoptin');
		unsigned1 LexIdSourceOptout 		:= 1 : STORED('LexIdSourceOptout');
		string TransactionID 						:= '' : STORED('_TransactionId');
		string BatchUID 								:= '' : STORED('_BatchUID');
		unsigned6 GlobalCompanyId			  := 0 : STORED('_GCID');

			//Look up the industry by the company ID.
			Industry_Search := Inquiry_AccLogs.Key_Inquiry_industry_use_vertical_login(FALSE)(s_company_id = CompanyID and s_product_id = (String)Risk_Reporting.ProductID.Business_Risk__InstantID_20_Service);
		/* ************* End Scout Fields **************/
		
		ds_Input := DATASET([xfm_LoadInput]); // see this transform in Macros.mac_LoadInput()
    
    /* For IID-B Lite Project */
    /* Placing input of authorized representatives 2 - 5 in its own definition */
    myAuthReps := ds_Input.AuthReps[2..];
    
    /* Checking whether at least one field for representatives 2 though 5 has been filled out */
    checkRepsFilled := EXISTS(myAuthReps(NOT(NameTitle = '' AND 
                                             FullName = '' AND 
                                             FirstName = '' AND 
                                             MiddleName = '' AND 
                                             LastName = '' AND 
                                             NameSuffix = '' AND 
                                             FormerLastName = '' AND 
                                             StreetAddress1 = '' AND 
                                             StreetAddress2 = '' AND 
                                             City = '' AND 
                                             Zip = '' AND 
                                             SSN = '' AND 
                                             DateOfBirth = '' AND 
                                             Age = '' AND 
                                             DLNumber = '' AND 
                                             DLState = '' AND 
                                             Phone10 = '' AND 
                                             Email = '')));
                                             
    /* Checks if product type is the VALIDATE solution and creates a defination for it */                                     
    isValidate := IF(_BIID20ProductType = 4, TRUE, FALSE);
    
    /* Checks whether product type is 4 and if at least one field has been filled out. If so, throw error based on acceptance criteria. Or else, continue on */
    IF((isValidate AND checkRepsFilled), FAIL('Only Authorized Representative 1 is allowed on input with InstantID Business Validate Solution; please refer to your product manual for guidance.'));  
    
    
		// 2.  Load the Options and LinkingOptions modules.		
		Gateway.Layouts.Config Options_gateway_switch(iesp.businessinstantid20.t_BIID20Gateway le) := transform
			self.servicename	:= if((le.servicename in BusinessInstantID20_Services.Constants.SET_TARGUS_SERVICENAMES AND NOT _DataPermissionMask[Risk_Indicators.iid_constants.posTargusPermission]='1'), '', le.servicename);
			self.url 					:= if((le.servicename in BusinessInstantID20_Services.Constants.SET_TARGUS_SERVICENAMES AND NOT _DataPermissionMask[Risk_Indicators.iid_constants.posTargusPermission]='1'), '', le.url);
			self							:= le;
			self							:= [];
		end;
		Options := MODULE(BusinessInstantID20_Services.iOptions)
			// Clean up the Options and make sure that defaults are enforced. RULE: For this product, 
			// if we're retrieving SBFE data (DPM[12] value set to '1'), then we cannot retrieve Experian
			// data. Set OverRideExperianRestriction = TRUE/FALSE based on whether SBFE is allowed.
			EXPORT UNSIGNED1	DPPA_Purpose 				 := _DPPA_Purpose;
			EXPORT UNSIGNED1	GLBA_Purpose 				 := _GLBA_Purpose;
			EXPORT STRING50		DataRestrictionMask	 := IF(_DataRestrictionMask = '', Business_Risk_BIP.Constants.Default_DataRestrictionMask, _DataRestrictionMask);
			EXPORT STRING50		DataPermissionMask	 := IF(_DataPermissionMask  = '', Business_Risk_BIP.Constants.Default_DataPermissionMask, _DataPermissionMask);
			EXPORT STRING10		IndustryClass				 := _IndustryClass;
			EXPORT UNSIGNED1	LinkSearchLevel			 := IF(_LinkSearchLevel BETWEEN Business_Risk_BIP.Constants.LinkSearch.Default AND Business_Risk_BIP.Constants.LinkSearch.UltID, _LinkSearchLevel, Business_Risk_BIP.Constants.LinkSearch.Default);
			EXPORT UNSIGNED1	BusShellVersion			 := MAX(Business_Risk_BIP.Constants.BusShellVersion_v22, _BusShellVersion);
			EXPORT UNSIGNED1	MarketingMode				 := MAX(MIN(_MarketingMode, 1), 0);
			EXPORT STRING50		AllowedSources			 := STD.Str.ToUpperCase(_AllowedSources);
			EXPORT UNSIGNED1	BIPBestAppend				 := IF(_BIPBestAppend BETWEEN Business_Risk_BIP.Constants.BIPBestAppend.Default AND Business_Risk_BIP.Constants.BIPBestAppend.OverwriteWithBest, _BIPBestAppend, Business_Risk_BIP.Constants.BIPBestAppend.Default);
			EXPORT UNSIGNED1	OFAC_Version				 := MAX(MIN(_OFAC_Version, BusinessInstantID20_Services.Constants.MAX_OFAC_VERSION), 0);
			EXPORT BOOLEAN    IncludeTargusGateway := _IncludeTargusGateway;
			EXPORT REAL				Global_Watchlist_Threshold	:= MAX(MIN(_Global_Watchlist_Threshold, 1), 0);
			EXPORT BOOLEAN    OverRideExperianRestriction := MAP( _OverRideExperianRestriction = TRUE => TRUE, _DataPermissionMask[12] IN BusinessInstantID20_Services.Constants.RESTRICTED_SET => TRUE, FALSE );
			EXPORT BOOLEAN    RunTargusGatewayAnywayForTesting := _RunTargusGateway;
			EXPORT DATASET(iesp.Share.t_StringArrayItem) Watchlists_Requested := _Watchlists_Requested;
			EXPORT DATASET(Gateway.Layouts.Config) Gateways   := PROJECT(_Gateways, Options_gateway_switch(left));
			EXPORT BOOLEAN		include_ofac                    := _include_ofac;
		  EXPORT BOOLEAN		include_additional_watchlists   := _include_additional_watchlists;
			EXPORT BOOLEAN    DisableIntermediateShellLogging := _DisableIntermediateShellLogging;
			EXPORT BusinessInstantID20_Services.Types.productTypeEnum BIID20_productType := _BIID20ProductType;
			EXPORT BOOLEAN    useSBFE := DataPermissionMask[12] NOT IN BusinessInstantID20_Services.Constants.RESTRICTED_SET;
			EXPORT DATASET(LNSmallBusiness.Layouts.AttributeGroupRec) AttributesRequested := PROJECT(option.AttributesVersionRequest, TRANSFORM(LNSmallBusiness.Layouts.AttributeGroupRec, SELF.AttributeGroup := STD.Str.ToUpperCase(LEFT.Value)));
			EXPORT DATASET(LNSmallBusiness.Layouts.ModelNameRec) ModelsRequested := 
				PROJECT(option.IncludeModels.Names, 
				TRANSFORM(LNSmallBusiness.Layouts.ModelNameRec, 
					SELF.ModelName := STD.Str.ToUpperCase(LEFT.Value)));
			EXPORT DATASET(LNSmallBusiness.Layouts.ModelOptionsRec) ModelOptions := 
				PROJECT(option.IncludeModels.ModelOptions,
				TRANSFORM(LNSmallBusiness.Layouts.ModelOptionsRec, 
					SELF.OptionName := STD.Str.ToUpperCase(TRIM(LEFT.OptionName, LEFT, RIGHT)), 
					SELF.OptionValue := STD.Str.ToUpperCase(TRIM(LEFT.OptionValue, LEFT, RIGHT))));
		END;

  IF( Options.OFAC_Version != 4 AND OFAC_XG5.constants.wlALLV4 IN SET(Options.Watchlists_Requested, value),
      FAIL( OFAC_XG5.Constants.ErrorMsg_OFACversion ) );
      
  ExcludeWatchLists := option.ExcludeWatchLists;

		// Generate the linking parameters to be used in BIP's kFetch (Key Fetch) - These parameters should be global so figure them out here and pass around appropriately
		linkingOptions := MODULE(BIPV2.mod_sources.iParams)
			EXPORT STRING DataRestrictionMask		:= Options.DataRestrictionMask; // Note: Must unfortunately leave as undefined STRING length to match the module definition
			EXPORT BOOLEAN ignoreFares					:= FALSE; // From AutoStandardI.DataRestrictionI, this is a User Configurable Input Option to Ignore FARES data - since the Business Shell doesn't accept this input default it to FALSE to always utilize whatever the DataRestrictionMask allows
			EXPORT BOOLEAN ignoreFidelity				:= FALSE; // From AutoStandardI.DataRestrictionI, this is a User Configurable Input Option to Ignore Fidelity data - since the Business Shell doesn't accept this input default it to FALSE to always utilize whatever the DataRestrictionMask allows
			EXPORT BOOLEAN AllowAll							:= IF(Options.AllowedSources = Business_Risk_BIP.Constants.AllowDNBDMI, TRUE, FALSE); // When TRUE this will unmask DNB DMI data - NO CUSTOMERS CAN USE THIS, FOR RESEARCH PURPOSES ONLY
			EXPORT BOOLEAN AllowGLB							:= Risk_Indicators.iid_constants.GLB_OK(Options.GLBA_Purpose, FALSE /*isFCRA*/);
			EXPORT BOOLEAN AllowDPPA						:= Risk_Indicators.iid_constants.DPPA_OK(Options.DPPA_Purpose, FALSE /*isFCRA*/);
			EXPORT UNSIGNED1 DPPAPurpose				:= Options.DPPA_Purpose;
			EXPORT UNSIGNED1 GLBPurpose					:= Options.GLBA_Purpose;
			EXPORT BOOLEAN IncludeMinors				:= TRUE; // Shouldn't really have an impact on business searches, set to TRUE for now
			EXPORT BOOLEAN LNBranded						:= TRUE; // Not entirely certain what effect this has
		END;
	
		// 3. Check to ensure minimum input requirements are met.
		MinimumInputMet := 
				(_CompanyName != '' OR _AltCompanyName != '') AND 
				(_StreetAddress1 != '' OR _StreetAddress2 != '') AND 
				(_Zip != '' OR (_City != '' AND _State != ''));
			
		IF( NOT MinimumInputMet,
			FAIL('Error - Minimum input fields required: please refer to your product manual for guidance.'));

    IF( Options.OFAC_Version = 4 AND ExcludeWatchlists = FALSE AND NOT EXISTS(Options.Gateways(servicename = 'bridgerwlc')), 
			FAIL(Risk_Indicators.iid_constants.OFAC4_NoGateway)); // Due to this RQ-14881 ExcludeWatchlists works with other versions of OFAC in this query. 
                                                            // Please refer to the ticket if needing further details.

    Boolean useUpdatedBipAppend := false;
    
    // 4. Pass input to BIID 2.0 logic.
    ds_BIID_results := BusinessInstantID20_Services.InstantID20_Records(ds_Input, Options, linkingOptions, ExcludeWatchlists,
                                                                        LexIdSourceOptout := LexIdSourceOptout, 
                                                                        TransactionID := TransactionID, 
                                                                        BatchUID := BatchUID, 
                                                                        GlobalCompanyID := GlobalCompanyID,
																		                                    useUpdatedBipAppend := useUpdatedBipAppend
																		                                    );
   
   
    #IF(Models.LIB_BusinessRisk_Models().TurnOnValidation = FALSE)
	
		
    // 4.5 Call Testseeds Function
		TestSeed_Results := BusinessInstantID20_Services.BIIDv2_TestSeed_Function(ds_Input, _TestData_TableName, , Options, isValidate);

		// 5. Project into IESP output.
		results_pre := PROJECT( ds_BIID_results, BusinessInstantID20_Services.xfm_ToIespLayout(LEFT, isValidate) );

		// 5.5 Choose the correct result
		results := IF(_TestData_Enabled, TestSeed_Results, results_pre);
		// results := results_pre;
		
		results_iesp := 
			PROJECT(
				results, 
				TRANSFORM( iesp.businessinstantid20.t_BIID20Response,
					SELF._Header := IF( NOT _TestData_Enabled, iesp.ECL2ESP.GetHeaderRow()), // Don't populate the header row if testseeds are requested.
					SELF.Result  := results[1]
				)
			);	
													
		// 6. Intermediate logging. - no longer exists for this query

		// 7. Calculate Royalties. For SBFE...:		
		ds_SBFEData := 
			PROJECT(
				ds_BIID_results,
				TRANSFORM( { UNSIGNED1 SBFEAccountCount },
					SELF.SBFEAccountCount :=
						(INTEGER)( TRIM(LEFT.SBFEVerification.time_on_sbfe) != '' OR 
						           TRIM(LEFT.SBFEVerification.last_seen_sbfe) != '' OR 
						           TRIM(LEFT.SBFEVerification.count_of_trades_sbfe) != '' )
				)
			);
			
		SBFE_royalties := IF( _TestData_Enabled, Royalty.RoyaltySBFE.GetNoRoyalties(), Royalty.RoyaltySBFE.GetOnlineRoyalties(ds_SBFEData) );

		// ...and for Targus Gateway. As of 2/2017 Targus is NOT being used by this product, 
		// so we're returning zeroes:		
		PhoneSources       := DATASET( [], Business_Risk_BIP.Layouts.LayoutSources ); // Empty.
		Targus_hit         := COUNT(PhoneSources(source = MDR.sourceTools.src_Targus_Gateway)) > 0;
		TargusType         := IF( Targus_hit, Phones.Constants.TargusType.WirelessConnectionSearch + Phones.Constants.TargusType.PhoneDataExpress, '' );
		Targus_PhoneSource := PhoneSources(source = MDR.sourceTools.src_Targus_Gateway);
		Targus_royalties   := Royalty.RoyaltyTargus.GetOnlineRoyalties(Targus_PhoneSource, source, TargusType, TRUE, TRUE, FALSE, FALSE);

		total_royalties := SBFE_royalties + Targus_royalties;
		
		
		
		OUTPUT(total_royalties, NAMED('RoyaltySet'));
		
		// Log to Deltabase
		Deltabase_Logging_prep := PROJECT(results_iesp, TRANSFORM(Risk_Reporting.Layouts.LOG_Deltabase_Layout_Record,
																										 SELF.company_id := (INTEGER)CompanyID,
																										 SELF.login_id := _LoginID,
																										 SELF.product_id := Risk_Reporting.ProductID.Business_Risk__InstantID_20_Service,
																										 SELF.function_name := FunctionName,
																										 SELF.esp_method := ESPMethod,
																										 SELF.interface_version := InterfaceVersion,
																										 SELF.delivery_method := DeliveryMethod,
																										 SELF.date_added := (STRING8)Std.Date.Today(),
																										 SELF.death_master_purpose := DeathMasterPurpose,
																										 SELF.ssn_mask := SSN_Mask,
																										 SELF.dob_mask := DOB_Mask,
																										 SELF.dl_mask := (STRING)(INTEGER)DL_Mask,
																										 SELF.exclude_dmv_pii := (STRING)(INTEGER)ExcludeDMVPII,
																										 SELF.scout_opt_out := (STRING)(INTEGER)DisableOutcomeTracking,
																										 SELF.archive_opt_in := (STRING)(INTEGER)ArchiveOptIn,
                                                     SELF.glb := _GLBA_Purpose,
                                                     SELF.dppa := _DPPA_Purpose,
																										 SELF.data_restriction_mask := _DataRestrictionMask,
																										 SELF.data_permission_mask := __DataPermissionMask,
																										 SELF.industry := Industry_Search[1].Industry,
																										 //self.i_attributes_name := Attributes_Requested[1].AttributeGroup,
																										 SELF.i_ssn := search.AuthorizedRep1.SSN,
                                                     SELF.i_dob := _Rep1_DateOfBirth;
                                                     SELF.i_name_full := search.AuthorizedRep1.Name.Full,
																										 SELF.i_name_first := search.AuthorizedRep1.Name.First,
																										 SELF.i_name_last := search.AuthorizedRep1.Name.Last,
																										 SELF.i_lexid := (Integer)search.AuthorizedRep1.UniqueId,
																										 SELF.i_address := IF(TRIM(search.AuthorizedRep1.address.streetaddress1)!='',
                                                                          TRIM(search.AuthorizedRep1.address.streetaddress1 + ' ' + search.AuthorizedRep1.address.streetaddress2),
																																				 Address.Addr1FromComponents(search.AuthorizedRep1.address.streetnumber,
																																				 search.AuthorizedRep1.address.streetpredirection, search.AuthorizedRep1.address.streetname,
																																				 search.AuthorizedRep1.address.streetsuffix, search.AuthorizedRep1.address.streetpostdirection,
																																				 search.AuthorizedRep1.address.unitdesignation, search.AuthorizedRep1.address.unitnumber)),
																										 SELF.i_city := search.AuthorizedRep1.address.City,
																										 SELF.i_state := search.AuthorizedRep1.address.State,
																										 SELF.i_zip := search.AuthorizedRep1.address.Zip5,
																										 SELF.i_dl := search.AuthorizedRep1.DriverLicenseNumber,
																										 SELF.i_dl_state := search.AuthorizedRep1.DriverLicenseState,
                                                     SELF.i_home_phone := search.AuthorizedRep1.Phone,
																										 SELF.i_tin := search.Company.FEIN,
																										 SELF.i_name_first_2 := search.AuthorizedRep2.Name.First,
																										 SELF.i_name_last_2 := search.AuthorizedRep2.Name.Last,
																										 SELF.i_name_first_3 := search.AuthorizedRep3.Name.First,
																										 SELF.i_name_last_3 := search.AuthorizedRep3.Name.Last,
																										 SELF.i_name_first_4 := search.AuthorizedRep4.Name.First,
																										 SELF.i_name_last_4 := search.AuthorizedRep4.Name.Last,
																										 SELF.i_name_first_5 := search.AuthorizedRep5.Name.First,
																										 SELF.i_name_last_5 := search.AuthorizedRep5.Name.Last,
                                                     SELF.i_bus_name := search.Company.CompanyName,
																										 SELF.i_alt_bus_name := search.Company.AlternateCompanyName,
																										 SELF.i_bus_address := IF(TRIM(search.Company.address.streetaddress1)!='', search.Company.address.streetaddress1,
																																									 Address.Addr1FromComponents(search.Company.address.streetnumber,
																																									 search.Company.address.streetpredirection, search.Company.address.streetname,
																																									 search.Company.address.streetsuffix, search.Company.address.streetpostdirection,
																																									 search.Company.address.unitdesignation, search.Company.address.unitnumber)),
																										 SELF.i_bus_city := search.Company.address.City,
																										 SELF.i_bus_state := search.Company.address.State,
																										 SELF.i_bus_zip := search.Company.address.Zip5,
                                                     SELF.i_bus_phone := search.Company.Phone,
																										 SELF.i_model_name_1 := 'BVI',
																										 SELF.i_model_name_2 := 'CVI',
																										 SELF.o_score_1    := (STRING)LEFT.Result.CompanyResults.BusinessVerification.Index,
																										 SELF.o_reason_1_1 := LEFT.Result.CompanyResults.RiskIndicators[1].RiskCode,
																										 SELF.o_reason_1_2 := LEFT.Result.CompanyResults.RiskIndicators[2].RiskCode,
																										 SELF.o_reason_1_3 := LEFT.Result.CompanyResults.RiskIndicators[3].RiskCode,
																										 SELF.o_reason_1_4 := LEFT.Result.CompanyResults.RiskIndicators[4].RiskCode,
																										 SELF.o_reason_1_5 := LEFT.Result.CompanyResults.RiskIndicators[5].RiskCode,
																										 SELF.o_reason_1_6 := LEFT.Result.CompanyResults.RiskIndicators[6].RiskCode,
																										 SELF.o_score_2    := (String)LEFT.Result.AuthorizedRepresentativeResults[1].ComprehensiveVerificationIndex,
																										 SELF.o_reason_2_1 := LEFT.Result.AuthorizedRepresentativeResults[1].RiskIndicators[1].RiskCode,
																										 SELF.o_reason_2_2 := LEFT.Result.AuthorizedRepresentativeResults[1].RiskIndicators[2].RiskCode,
																										 SELF.o_reason_2_3 := LEFT.Result.AuthorizedRepresentativeResults[1].RiskIndicators[3].RiskCode,
																										 SELF.o_reason_2_4 := LEFT.Result.AuthorizedRepresentativeResults[1].RiskIndicators[4].RiskCode,
																										 SELF.o_reason_2_5 := LEFT.Result.AuthorizedRepresentativeResults[1].RiskIndicators[5].RiskCode,
																										 SELF.o_reason_2_6 := LEFT.Result.AuthorizedRepresentativeResults[1].RiskIndicators[6].RiskCode,
																										 SELF.o_lexid := (INTEGER)LEFT.Result.AuthorizedRepresentativeResults[1].UniqueID,
                                                     SELF.o_seleid := left.Result.CompanyResults.BusinessIds.Seleid,
																										 SELF := LEFT,
																										 SELF := [] ));
		Deltabase_Logging := DATASET([{Deltabase_Logging_prep}], Risk_Reporting.Layouts.LOG_Deltabase_Layout);
		// #stored('Deltabase_Log', Deltabase_Logging);

		// Improved Scout Logging
		IF(~DisableOutcomeTracking AND NOT _TestData_Enabled, OUTPUT(Deltabase_Logging, NAMED('LOG_log__mbs_transaction__log__scout')));
		
    // DEBUGs:
    // OUTPUT( ds_Input, NAMED('Input') );
    // OUTPUT( Options );
    // OUTPUT( linkingOptions );
    // OUTPUT( ds_BIID_results, NAMED('BIID_results') );
    // OUTPUT(myAuthReps, NAMED('myAuthRepsTwoThroughFive'));
    // OUTPUT(ds_Input.AuthReps[1], NAMED('dsInputAuthorizedRep1'));
    // OUTPUT(ds_Input.AuthReps[2], NAMED('dsInputAuthorizedRep2'));
    // OUTPUT(ds_Input.AuthReps[3], NAMED('dsInputAuthorizedRep3'));
    // OUTPUT(checkRepsFilled, NAMED('AreRepsTwoThroughFiveFilled'));    
    // OUTPUT(ds_BIID_results, NAMED('ds_BIID_results'));    
    // OUTPUT(isValidate, NAMED('isValidate'));
    // OUTPUT(_BIID20ProductType, NAMED('_BIID20ProductType'));

	// 7. Results!
	OUTPUT( results_iesp, NAMED('Results') );
#ELSE //Else, output the model results directly
// return ds_BIID_results := BusinessInstantID20_Services.InstantID20_Records(ds_Input, Options, linkingOptions, ExcludeWatchlists);
OUTPUT (ds_BIID_results, NAMED('MODELRESULTS'));

#END
	
ENDMACRO;
