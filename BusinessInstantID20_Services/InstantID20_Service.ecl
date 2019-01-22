/*--SOAP--
<message name="BusinessInstantID20_Service">
	<part name="BusinessInstantID20Request" type="tns:XmlDataSet" cols="110" rows="75"/>
	<part name="DPPAPurpose" type="xsd:integer"/>
	<part name="GLBPurpose" type="xsd:integer"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="BIID20ProductType" type="xsd:integer"/> <!-- 1,2,3 -->
  <part name="Gateways" type="tns:XmlDataSet" cols="100" rows="8"/>
</message>
*/
/*--INFO-- This Service is the interface into the Business InstantID ECL service, version 2.0. */

IMPORT BIPV2, Business_Risk_BIP, Gateway, iesp, MDR, OFAC_XG5, Risk_Indicators, Risk_Reporting, Royalty, STD, Inquiry_AccLogs;

EXPORT InstantID20_Service() := MACRO

		#OPTION('embeddedWarningsAsErrors',0);

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
    'Gateways'
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
			string20 CompanyID              := if(users.CompanyId != '', users.CompanyId, outofbandCompanyID);
			string20 FunctionName           := '' : STORED('_LogFunctionName');
			string50 ESPMethod              := '' : STORED('_ESPMethodName');
			string10 InterfaceVersion       := '' : STORED('_ESPClientInterfaceVersion');
			string5 DeliveryMethod          := '' : STORED('_DeliveryMethod');
			string5 DeathMasterPurpose      := '' : STORED('__deathmasterpurpose');
			outofbandssnmask                := '' : STORED('SSNMask');
			string10 SSN_Mask               := if(users.SSNMask != '', users.SSNMask, outofbandssnmask);
			outofbanddobmask                := '' : STORED('DOBMask');
			string10 DOB_Mask               := if(users.DOBMask != '', users.DOBMask, outofbanddobmask);
			BOOLEAN DL_Mask                 := users.DLMask;
			BOOLEAN ExcludeDMVPII           := users.ExcludeDMVPII;
			BOOLEAN DisableOutcomeTracking  := False : STORED('OutcomeTrackingOptOut');
			BOOLEAN ArchiveOptIn            := False : STORED('instantidarchivingoptin');

			//Look up the industry by the company ID.
			Industry_Search := Inquiry_AccLogs.Key_Inquiry_industry_use_vertical_login(FALSE)(s_company_id = CompanyID and s_product_id = (String)Risk_Reporting.ProductID.Business_Risk__InstantID_20_Service);
		/* ************* End Scout Fields **************/
		
		ds_Input := DATASET([xfm_LoadInput]); // see this transform in Macros.mac_LoadInput()
		
		// 2.  Load the Options and LinkingOptions modules.		
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
			EXPORT DATASET(Gateway.Layouts.Config) Gateways   := PROJECT( _Gateways, TRANSFORM( Gateway.Layouts.Config, SELF := LEFT, SELF := [] ) );
			EXPORT BOOLEAN		include_ofac                    := _include_ofac;
		  EXPORT BOOLEAN		include_additional_watchlists   := _include_additional_watchlists;
			EXPORT BOOLEAN    DisableIntermediateShellLogging := _DisableIntermediateShellLogging;
			EXPORT BusinessInstantID20_Services.Types.productTypeEnum BIID20_productType := _BIID20ProductType;
			EXPORT BOOLEAN    useSBFE := DataPermissionMask[12] NOT IN BusinessInstantID20_Services.Constants.RESTRICTED_SET;
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

		// 4. Pass input to BIID 2.0 logic.
		ds_BIID_results := BusinessInstantID20_Services.InstantID20_Records(ds_Input, Options, linkingOptions, ExcludeWatchlists);

		//4.5 Call Testseeds Function
		TestSeed_Results := BusinessInstantID20_Services.BIIDv2_TestSeed_Function(ds_Input, _TestData_TableName, , Options);

		// 5. Project into IESP output.
		results_pre := PROJECT( ds_BIID_results, BusinessInstantID20_Services.xfm_ToIespLayout(LEFT) );
	
		//5.5 Choose the correct result
		results := IF(_TestData_Enabled, TestSeed_Results, results_pre);
		
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
		
		//Log to Deltabase
		Deltabase_Logging_prep := project(results_iesp, transform(Risk_Reporting.Layouts.LOG_Deltabase_Layout_Record,
																										 self.company_id := (Integer)CompanyID,
																										 self.login_id := _LoginID,
																										 self.product_id := Risk_Reporting.ProductID.Business_Risk__InstantID_20_Service,
																										 self.function_name := FunctionName,
																										 self.esp_method := ESPMethod,
																										 self.interface_version := InterfaceVersion,
																										 self.delivery_method := DeliveryMethod,
																										 self.date_added := (STRING8)Std.Date.Today(),
																										 self.death_master_purpose := DeathMasterPurpose,
																										 self.ssn_mask := SSN_Mask,
																										 self.dob_mask := DOB_Mask,
																										 self.dl_mask := (String)(Integer)DL_Mask,
																										 self.exclude_dmv_pii := (String)(Integer)ExcludeDMVPII,
																										 self.scout_opt_out := (String)(Integer)DisableOutcomeTracking,
																										 self.archive_opt_in := (String)(Integer)ArchiveOptIn,
                                                     self.glb := _GLBA_Purpose,
                                                     self.dppa := _DPPA_Purpose,
																										 self.data_restriction_mask := _DataRestrictionMask,
																										 self.data_permission_mask := __DataPermissionMask,
																										 self.industry := Industry_Search[1].Industry,
																										 // self.i_attributes_name := Attributes_Requested[1].AttributeGroup,
																										 self.i_ssn := search.AuthorizedRep1.SSN,
                                                     self.i_dob := _Rep1_DateOfBirth;
                                                     self.i_name_full := search.AuthorizedRep1.Name.Full,
																										 self.i_name_first := search.AuthorizedRep1.Name.First,
																										 self.i_name_last := search.AuthorizedRep1.Name.Last,
																										 self.i_lexid := (Integer)search.AuthorizedRep1.UniqueId,
																										 self.i_address := If(trim(search.AuthorizedRep1.address.streetaddress1)!='',
                                                                          trim(search.AuthorizedRep1.address.streetaddress1 + ' ' + search.AuthorizedRep1.address.streetaddress2),
																																				 Address.Addr1FromComponents(search.AuthorizedRep1.address.streetnumber,
																																				 search.AuthorizedRep1.address.streetpredirection, search.AuthorizedRep1.address.streetname,
																																				 search.AuthorizedRep1.address.streetsuffix, search.AuthorizedRep1.address.streetpostdirection,
																																				 search.AuthorizedRep1.address.unitdesignation, search.AuthorizedRep1.address.unitnumber)),
																										 self.i_city := search.AuthorizedRep1.address.City,
																										 self.i_state := search.AuthorizedRep1.address.State,
																										 self.i_zip := search.AuthorizedRep1.address.Zip5,
																										 self.i_dl := search.AuthorizedRep1.DriverLicenseNumber,
																										 self.i_dl_state := search.AuthorizedRep1.DriverLicenseState,
                                                     self.i_home_phone := search.AuthorizedRep1.Phone,
																										 self.i_tin := search.Company.FEIN,
																										 self.i_name_first_2 := search.AuthorizedRep2.Name.First,
																										 self.i_name_last_2 := search.AuthorizedRep2.Name.Last,
																										 self.i_name_first_3 := search.AuthorizedRep3.Name.First,
																										 self.i_name_last_3 := search.AuthorizedRep3.Name.Last,
																										 self.i_name_first_4 := search.AuthorizedRep4.Name.First,
																										 self.i_name_last_4 := search.AuthorizedRep4.Name.Last,
																										 self.i_name_first_5 := search.AuthorizedRep5.Name.First,
																										 self.i_name_last_5 := search.AuthorizedRep5.Name.Last,
                                                     self.i_bus_name := search.Company.CompanyName,
																										 self.i_alt_bus_name := search.Company.AlternateCompanyName,
																										 self.i_bus_address := If(trim(search.Company.address.streetaddress1)!='', search.Company.address.streetaddress1,
																																									 Address.Addr1FromComponents(search.Company.address.streetnumber,
																																									 search.Company.address.streetpredirection, search.Company.address.streetname,
																																									 search.Company.address.streetsuffix, search.Company.address.streetpostdirection,
																																									 search.Company.address.unitdesignation, search.Company.address.unitnumber)),
																										 self.i_bus_city := search.Company.address.City,
																										 self.i_bus_state := search.Company.address.State,
																										 self.i_bus_zip := search.Company.address.Zip5,
                                                     self.i_bus_phone := search.Company.Phone,
																										 self.i_model_name_1 := 'BVI',
																										 self.i_model_name_2 := 'CVI',
																										 self.o_score_1    := (String)left.Result.CompanyResults.BusinessVerification.Index,
																										 self.o_reason_1_1 := left.Result.CompanyResults.RiskIndicators[1].RiskCode,
																										 self.o_reason_1_2 := left.Result.CompanyResults.RiskIndicators[2].RiskCode,
																										 self.o_reason_1_3 := left.Result.CompanyResults.RiskIndicators[3].RiskCode,
																										 self.o_reason_1_4 := left.Result.CompanyResults.RiskIndicators[4].RiskCode,
																										 self.o_reason_1_5 := left.Result.CompanyResults.RiskIndicators[5].RiskCode,
																										 self.o_reason_1_6 := left.Result.CompanyResults.RiskIndicators[6].RiskCode,
																										 self.o_score_2    := (String)left.Result.AuthorizedRepresentativeResults[1].ComprehensiveVerificationIndex,
																										 self.o_reason_2_1 := left.Result.AuthorizedRepresentativeResults[1].RiskIndicators[1].RiskCode,
																										 self.o_reason_2_2 := left.Result.AuthorizedRepresentativeResults[1].RiskIndicators[2].RiskCode,
																										 self.o_reason_2_3 := left.Result.AuthorizedRepresentativeResults[1].RiskIndicators[3].RiskCode,
																										 self.o_reason_2_4 := left.Result.AuthorizedRepresentativeResults[1].RiskIndicators[4].RiskCode,
																										 self.o_reason_2_5 := left.Result.AuthorizedRepresentativeResults[1].RiskIndicators[5].RiskCode,
																										 self.o_reason_2_6 := left.Result.AuthorizedRepresentativeResults[1].RiskIndicators[6].RiskCode,
																										 self.o_lexid := (Integer)left.Result.AuthorizedRepresentativeResults[1].UniqueID,
                                                     self.o_seleid := left.Result.CompanyResults.BusinessIds.Seleid,
																										 self := left,
																										 self := [] ));
		Deltabase_Logging := DATASET([{Deltabase_Logging_prep}], Risk_Reporting.Layouts.LOG_Deltabase_Layout);
		// #stored('Deltabase_Log', Deltabase_Logging);

		//Improved Scout Logging
		IF(~DisableOutcomeTracking and NOT _TestData_Enabled, OUTPUT(Deltabase_Logging, NAMED('LOG_log__mbs_transaction__log__scout')));
		
	// DEBUGs:
	// OUTPUT( ds_Input, NAMED('Input') );
	// OUTPUT( Options );
	// OUTPUT( linkingOptions );
	// OUTPUT( ds_BIID_results, NAMED('BIID_results') );

	// 7. Results!
	OUTPUT( results_iesp, NAMED('Results') );

ENDMACRO;
