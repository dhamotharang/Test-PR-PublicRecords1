/*--SOAP--
<message name="BusinessInstantID20_Batch_Service">
	<part name="Batch_In" type="tns:XmlDataSet" cols="100" rows="25"/>
	<!-- Option Fields --> 
	<part name="DPPAPurpose" type="xsd:integer"/>
	<part name="GLBPurpose" type="xsd:integer"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="IndustryClass" type="xsd:string"/>
	<part name="HistoryDate" type="xsd:integer"/>
	<part name="LinkSearchLevel" type="xsd:integer"/>
	<part name="MarketingMode" type="xsd:integer"/>
	<part name="BusShellVersion" type="xsd:integer"/>
	<part name="AllowedSources" type="xsd:string"/>
	<part name="BIPBestAppend" type="xsd:integer"/>
  <part name="OFAC_Version" type="xsd:integer"/>
  <part name="Global_Watchlist_Threshold" type="xsd:real"/>
	<part name="IncludeTargusGateway" type="xsd:boolean"/>
	<part name="Gateways" type="tns:XmlDataSet" cols="100" rows="8"/>
	<part name="BIID20ProductType" type="xsd:integer"/> <!-- 1,2,3 -->
	<part name="ForRetroTesting" type="xsd:boolean"/>
	<part name="ReturnDetailedRoyalties" type="xsd:boolean"/>
	<part name="ModelName1" type="xsd:string"/>
	<part name="ModelName2" type="xsd:string"/>
	<part name="ModelName3" type="xsd:string"/>
	<part name="ModelName4" type="xsd:string"/>
	<part name="ModelName5" type="xsd:string"/>

	<!-- ----------[ Consumer InstantID options, params ]---------- -->
	<part name="CompanyID" type="xsd:string"/>
	<part name="DisallowInsurancePhoneHeaderGateway" type="xsd:boolean"/>
	<part name="DOBMatchType" type="xsd:string"/>
	<part name="DOBMatchYearRadius" type="xsd:unsignedInt"/>
	<part name="DOBRadius" type="xsd:unsignedInt"/>
	<part name="EnableEmergingID" type="xsd:boolean"/>
	<part name="ExactAddrMatch" type="xsd:boolean"/>
	<part name="ExactDOBMatch" type="xsd:boolean"/>
	<part name="ExactDriverLicenseMatch" type="xsd:boolean"/>
	<part name="ExactFirstNameMatch" type="xsd:boolean"/>
	<part name="ExactFirstNameMatchAllowNicknames" type="xsd:boolean"/>
	<part name="ExactLastNameMatch" type="xsd:boolean"/>
	<part name="ExactPhoneMatch" type="xsd:boolean"/>
	<part name="ExactSSNMatch" type="xsd:boolean"/>
	<part name="ExcludeWatchLists" type="xsd:boolean"/>
	<part name="IIDVersionOverride" type="xsd:boolean"/>
	<part name="IncludeAdditionalWatchLists" type="xsd:boolean"/>
	<part name="IncludeAllRiskIndicators" type="xsd:boolean"/>
	<part name="IncludeCLOverride" type="xsd:boolean"/>
	<part name="IncludeDLVerification" type="xsd:boolean"/>
	<part name="IncludeDOBinCVI" type="xsd:boolean"/>
	<part name="IncludeDPBC" type="xsd:boolean"/>
	<part name="IncludeDriverLicenseInCVI" type="xsd:boolean"/>
	<part name="IncludeMIoverride" type="xsd:boolean"/>
	<part name="IncludeMSoverride" type="xsd:boolean"/>
	<part name="IncludeOfac" type="xsd:boolean"/> 
	<part name="IncludeTargusE3220Gateway" type="xsd:boolean"/>
	<part name="IncludeBridgerXG5Gateway" type="xsd:boolean"/>
	<part name="InstantIDVersion" type="xsd:string"/>
	<part name="LastSeenThreshold" type="xsd:string"/>
	<part name="NameInputOrder" type="xsd:string"/>
	<part name="OfacOnly" type="xsd:boolean"/>
	<part name="PoBoxCompliance" type="xsd:boolean"/>
	<part name="UseDOBFilter" type="xsd:boolean"/>

	<!-- ----------[ Watchlists ]---------- -->
	<part name="Include_ALL_Watchlist"  type="xsd:boolean"/>
	<part name="Include_ALLV4_Watchlist"  type="xsd:boolean"/>
	<part name="Include_BES_Watchlist"  type="xsd:boolean"/>
	<part name="Include_BIS_Watchlist"  type="xsd:boolean"/>
	<part name="Include_CFTC_Watchlist" type="xsd:boolean"/>
	<part name="Include_DTC_Watchlist"  type="xsd:boolean"/>
	<part name="Include_EUDT_Watchlist" type="xsd:boolean"/>
	<part name="Include_FAR_Watchlist"  type="xsd:boolean"/>
	<part name="Include_FBI_Watchlist"  type="xsd:boolean"/>
	<part name="Include_FCEN_Watchlist" type="xsd:boolean"/>
	<part name="Include_IMW_Watchlist"  type="xsd:boolean"/>
	<part name="Include_OCC_Watchlist"  type="xsd:boolean"/>
	<part name="Include_OSFI_Watchlist" type="xsd:boolean"/>
	<part name="Include_PEP_Watchlist"  type="xsd:boolean"/>
	<part name="Include_SDT_Watchlist"  type="xsd:boolean"/>
	<part name="Include_UNNT_Watchlist" type="xsd:boolean"/>
	<part name="Include_WBIF_Watchlist" type="xsd:boolean"/>
	
	<!-- ----------[ Added for OFAC v. 4 ]---------- -->
	<part name="Include_ADFA_Watchlist" type="xsd:boolean"/>
	<part name="Include_FAJC_Watchlist" type="xsd:boolean"/>
	<part name="Include_FATF_Watchlist" type="xsd:boolean"/>
	<part name="Include_FBIH_Watchlist" type="xsd:boolean"/>
	<part name="Include_FBIS_Watchlist" type="xsd:boolean"/>
	<part name="Include_FBIT_Watchlist" type="xsd:boolean"/>
	<part name="Include_FBIW_Watchlist" type="xsd:boolean"/>
	<part name="Include_HKMA_Watchlist" type="xsd:boolean"/>
	<part name="Include_MASI_Watchlist" type="xsd:boolean"/>
	<part name="Include_OFFC_Watchlist" type="xsd:boolean"/>
	<part name="Include_PMLC_Watchlist" type="xsd:boolean"/>
	<part name="Include_PMLJ_Watchlist" type="xsd:boolean"/>
</message>
*/
/*--INFO-- This Service is the interface into the Business InstantID ECL service, version 2.0. */

IMPORT BIPV2, Business_Risk_BIP, Gateway, iesp, MDR, OFAC_XG5, Patriot, Risk_Indicators, Royalty, STD;

EXPORT InstantID20_Batch_Service() := MACRO

		#OPTION('embeddedWarningsAsErrors',0);

		/* ************************************************************************
		 *                      Force the order on the WsECL page                 *
		 ************************************************************************ */
		#WEBSERVICE(FIELDS(
		'Batch_In',
		'DPPAPurpose',
		'GLBPurpose',
		'DataRestrictionMask',
		'DataPermissionMask',
		'IndustryClass',
		'HistoryDate',
		'LinkSearchLevel',
		'MarketingMode',
		'BusShellVersion',
		'AllowedSources',
		'BIPBestAppend',
		'OFAC_version',
		'Global_Watchlist_Threshold',
		'Gateways',
		'BIID20ProductType',
		'ForRetroTesting',
		'ReturnDetailedRoyalties',
		'ModelName1',
		'ModelName2',
		'ModelName3',
		'ModelName4',
		'ModelName5',
		'DisallowInsurancePhoneHeaderGateway',
		'DOBMatchType',
		'DOBMatchYearRadius',
		'DOBRadius',
		'EnableEmergingID',
		'ExactAddrMatch',
		'ExactDOBMatch',
		'ExactDriverLicenseMatch',
		'ExactFirstNameMatch',
		'ExactFirstNameMatchAllowNicknames',
		'ExactLastNameMatch',
		'ExactPhoneMatch',
		'ExactSSNMatch',
		'ExcludeWatchLists',
		'IIDVersionOverride',
		'IncludeAdditionalWatchlists',
		'IncludeAllRiskIndicators',
		'IncludeCLOverride',
		'IncludeDLVerification',
		'IncludeDOBInCVI',
		'IncludeDPBC',
		'IncludeDriverLicenseInCVI',
		'IncludeMIOverride',
		'IncludeMSOverride',
		'IncludeOFAC',
		'IncludeTargusE3220Gateway',
		'IncludeBridgerXG5Gateway',
		'InstantIDVersion',
		'LastSeenThreshold',
		'NameInputOrder',
		'OfacOnly',
		'PoBoxCompliance',
		'UseDOBFilter',
		'Include_ALL_Watchlist',
		'Include_ALLV4_Watchlist',
		'Include_BES_Watchlist',
		'Include_BIS_Watchlist',
		'Include_CFTC_Watchlist',
		'Include_DTC_Watchlist',
		'Include_EUDT_Watchlist',
		'Include_FAR_Watchlist',
		'Include_FBI_Watchlist',
		'Include_FCEN_Watchlist',
		'Include_IMW_Watchlist',
		'Include_OCC_Watchlist',
		'Include_OSFI_Watchlist',
		'Include_PEP_Watchlist',
		'Include_SDT_Watchlist',
		'Include_UNNT_Watchlist',
		'Include_WBIF_Watchlist',
		'Include_ADFA_Watchlist',
		'Include_FAJC_Watchlist',
		'Include_FATF_Watchlist',
		'Include_FBIH_Watchlist',
		'Include_FBIS_Watchlist',
		'Include_FBIT_Watchlist',
		'Include_FBIW_Watchlist',
		'Include_HKMA_Watchlist',
		'Include_MASI_Watchlist',
		'Include_OFFC_Watchlist',
		'Include_PMLC_Watchlist',
		'Include_PMLJ_Watchlist'
		));

		/* ************************************************************************
		 *                          Grab service inputs                           *
		 ************************************************************************ */

		// 1. Construct a Watchlist dataset.
		boolean Include_ALL_Watchlist := false : stored('Include_ALL_Watchlist');
    boolean Include_ALLV4_Watchlist:= false : stored('Include_ALLV4_Watchlist');
		boolean Include_BES_Watchlist := false : stored('Include_BES_Watchlist');
		boolean Include_CFTC_Watchlist:= false : stored('Include_CFTC_Watchlist');
		boolean Include_DTC_Watchlist := false : stored('Include_DTC_Watchlist');
		boolean Include_EUDT_Watchlist:= false : stored('Include_EUDT_Watchlist');
		boolean Include_FBI_Watchlist := false : stored('Include_FBI_Watchlist');
		boolean Include_FCEN_Watchlist:= false : stored('Include_FCEN_Watchlist');
		boolean Include_FAR_Watchlist := false : stored('Include_FAR_Watchlist');
		boolean Include_IMW_Watchlist := false : stored('Include_IMW_Watchlist');
		boolean Include_OFAC_Watchlist:= false : stored('Include_OFAC_Watchlist');
		boolean Include_OCC_Watchlist := false : stored('Include_OCC_Watchlist');
		boolean Include_OSFI_Watchlist:= false : stored('Include_OSFI_Watchlist');
		boolean Include_PEP_Watchlist := false : stored('Include_PEP_Watchlist');
		boolean Include_SDT_Watchlist := false : stored('Include_SDT_Watchlist');
		boolean Include_BIS_Watchlist := false : stored('Include_BIS_Watchlist');
		boolean Include_UNNT_Watchlist:= false : stored('Include_UNNT_Watchlist');
		boolean Include_WBIF_Watchlist:= false : stored('Include_WBIF_Watchlist');

		boolean Include_ADFA_Watchlist:= false : stored('Include_ADFA_Watchlist');
		boolean Include_FAJC_Watchlist:= false : stored('Include_FAJC_Watchlist');
		boolean Include_FATF_Watchlist:= false : stored('Include_FATF_Watchlist');
		boolean Include_FBIH_Watchlist:= false : stored('Include_FBIH_Watchlist');
		boolean Include_FBIS_Watchlist:= false : stored('Include_FBIS_Watchlist');
		boolean Include_FBIT_Watchlist:= false : stored('Include_FBIT_Watchlist');
		boolean Include_FBIW_Watchlist:= false : stored('Include_FBIW_Watchlist');
		boolean Include_HKMA_Watchlist:= false : stored('Include_HKMA_Watchlist');
		boolean Include_MASI_Watchlist:= false : stored('Include_MASI_Watchlist');
		boolean Include_OFFC_Watchlist:= false : stored('Include_OFFC_Watchlist');
		boolean Include_PMLC_Watchlist:= false : stored('Include_PMLC_Watchlist');
		boolean Include_PMLJ_Watchlist:= false : stored('Include_PMLJ_Watchlist');

		dWL := dataset([], iesp.share.t_StringArrayItem) +
				if(Include_ALL_Watchlist, dataset([{patriot.constants.wlALL}], iesp.share.t_StringArrayItem)) +
        if(Include_ALLV4_Watchlist, dataset([{patriot.constants.wlALLV4}], iesp.share.t_StringArrayItem)) +
				if(Include_BES_Watchlist, dataset([{patriot.constants.wlBES}], iesp.share.t_StringArrayItem)) +
				if(Include_CFTC_Watchlist, dataset([{patriot.constants.wlCFTC}], iesp.share.t_StringArrayItem)) +
				if(Include_DTC_Watchlist, dataset([{patriot.constants.wlDTC}], iesp.share.t_StringArrayItem)) +
				if(Include_EUDT_Watchlist, dataset([{patriot.constants.wlEUDT}], iesp.share.t_StringArrayItem)) +
				if(Include_FBI_Watchlist, dataset([{patriot.constants.wlFBI}], iesp.share.t_StringArrayItem)) +
				if(Include_FCEN_Watchlist, dataset([{patriot.constants.wlFCEN}], iesp.share.t_StringArrayItem)) +
				if(Include_FAR_Watchlist, dataset([{patriot.constants.wlFAR}], iesp.share.t_StringArrayItem)) +
				if(Include_IMW_Watchlist, dataset([{patriot.constants.wlIMW}], iesp.share.t_StringArrayItem)) +
				if(Include_OFAC_Watchlist, dataset([{patriot.constants.wlOFAC}], iesp.share.t_StringArrayItem)) +
				if(Include_OCC_Watchlist, dataset([{patriot.constants.wlOCC}], iesp.share.t_StringArrayItem)) +
				if(Include_OSFI_Watchlist, dataset([{patriot.constants.wlOSFI}], iesp.share.t_StringArrayItem)) +
				if(Include_PEP_Watchlist, dataset([{patriot.constants.wlPEP}], iesp.share.t_StringArrayItem)) +
				if(Include_SDT_Watchlist, dataset([{patriot.constants.wlSDT}], iesp.share.t_StringArrayItem)) +
				if(Include_BIS_Watchlist, dataset([{patriot.constants.wlBIS}], iesp.share.t_StringArrayItem)) +
				if(Include_UNNT_Watchlist, dataset([{patriot.constants.wlUNNT}], iesp.share.t_StringArrayItem)) +
				if(Include_WBIF_Watchlist, dataset([{patriot.constants.wlWBIF}], iesp.share.t_StringArrayItem)) +
				if(Include_ADFA_Watchlist, dataset([{patriot.constants.wlADFA}], iesp.share.t_StringArrayItem)) +
				if(Include_FAJC_Watchlist, dataset([{patriot.constants.wlFAJC}], iesp.share.t_StringArrayItem)) +
				if(Include_FATF_Watchlist, dataset([{patriot.constants.wlFATF}], iesp.share.t_StringArrayItem)) +
				if(Include_FBIH_Watchlist, dataset([{patriot.constants.wlFBIH}], iesp.share.t_StringArrayItem)) +
				if(Include_FBIS_Watchlist, dataset([{patriot.constants.wlFBIS}], iesp.share.t_StringArrayItem)) +
				if(Include_FBIT_Watchlist, dataset([{patriot.constants.wlFBIT}], iesp.share.t_StringArrayItem)) +
				if(Include_FBIW_Watchlist, dataset([{patriot.constants.wlFBIW}], iesp.share.t_StringArrayItem)) +
				if(Include_HKMA_Watchlist, dataset([{patriot.constants.wlHKMA}], iesp.share.t_StringArrayItem)) +
				if(Include_MASI_Watchlist, dataset([{patriot.constants.wlMASI}], iesp.share.t_StringArrayItem)) +
				if(Include_OFFC_Watchlist, dataset([{patriot.constants.wlOFFC}], iesp.share.t_StringArrayItem)) +
				if(Include_PMLC_Watchlist, dataset([{patriot.constants.wlPMLC}], iesp.share.t_StringArrayItem)) +
				if(Include_PMLJ_Watchlist, dataset([{patriot.constants.wlPMLJ}], iesp.share.t_StringArrayItem));

		_Watchlists_Requested := dWL(value<>'');
    
    Boolean ExcludeWatchLists := BusinessInstantID20_Services.Constants.EXCLUDEWATCHLISTS        : stored('ExcludeWatchLists');

		// 2. Define DOB options.
		STRING  DOBMatchType := ''								: stored('DOBMatchType');
		INTEGER DOBMatchYearRadius := 0						: stored('DOBMatchYearRadius');
		_DOBMatchOptions := dataset([{DOBMatchType, DOBMatchYearRadius}], iesp.businessinstantid20.t_BIID20DOBMatchOptions);

		#STORED('DOBMatchOptions', _DOBMatchOptions);

		// 3. Read the option params.
		BusinessInstantID20_Services.Macros.mac_ReadOptionsBatch()
			
		// 4.  Load the Options and LinkingOptions modules.	
		Options := MODULE(BusinessInstantID20_Services.iOptions)
			// Clean up the Options and make sure that defaults are enforced. RULE: For this product, 
			// if we're retrieving SBFE data (DPM[12] value set to '1'), then we cannot retrieve Experian
			// data. Set OverRideExperianRestriction = TRUE/FALSE based on whether SBFE is allowed.
			EXPORT UNSIGNED1	DPPA_Purpose 				 := _DPPA_Purpose;
			EXPORT UNSIGNED1	GLBA_Purpose 				 := _GLBA_Purpose;
			EXPORT STRING50		DataRestrictionMask	 := _DataRestrictionMask;
			EXPORT STRING50		DataPermissionMask	 := _DataPermissionMask;
			EXPORT STRING10		IndustryClass				 := _IndustryClass;
			EXPORT UNSIGNED1	LinkSearchLevel			 := IF(_LinkSearchLevel BETWEEN Business_Risk_BIP.Constants.LinkSearch.Default AND Business_Risk_BIP.Constants.LinkSearch.UltID, _LinkSearchLevel, Business_Risk_BIP.Constants.LinkSearch.Default);
			EXPORT UNSIGNED1	BusShellVersion			 := MAX(Business_Risk_BIP.Constants.BusShellVersion_v22, _BusShellVersion);
			EXPORT UNSIGNED1	MarketingMode				 := MAX(MIN(_MarketingMode, 1), 0);
			EXPORT STRING50		AllowedSources			 := STD.Str.ToUpperCase(_AllowedSources);
			EXPORT UNSIGNED1	BIPBestAppend				 := IF(_BIPBestAppend BETWEEN Business_Risk_BIP.Constants.BIPBestAppend.Default AND Business_Risk_BIP.Constants.BIPBestAppend.OverwriteWithBest, _BIPBestAppend, Business_Risk_BIP.Constants.BIPBestAppend.Default);
			EXPORT UNSIGNED1	OFAC_Version				 := MAX(MIN(_OFAC_Version, BusinessInstantID20_Services.Constants.MAX_OFAC_VERSION), 0);
			EXPORT BOOLEAN    IncludeTargusGateway := _IncludeTargusGateway;
			EXPORT REAL				Global_Watchlist_Threshold	     := MAX(MIN(_Global_Watchlist_Threshold, 1), 0);
			EXPORT BOOLEAN    OverRideExperianRestriction      := MAP( _OverRideExperianRestriction = TRUE => TRUE, _DataPermissionMask[12] IN BusinessInstantID20_Services.Constants.RESTRICTED_SET => TRUE, FALSE );
			EXPORT BOOLEAN    RunTargusGatewayAnywayForTesting := _RunTargusGateway;
			EXPORT DATASET(Gateway.Layouts.Config) Gateways    := PROJECT( _Gateways, TRANSFORM( Gateway.Layouts.Config, SELF := LEFT, SELF := [] ) );
			EXPORT BOOLEAN		include_ofac                     := if(ExcludeWatchLists = TRUE, FALSE, _include_ofac);
		  EXPORT BOOLEAN		include_additional_watchlists    := if(ExcludeWatchLists = TRUE, FALSE, _include_additional_watchlists);
			EXPORT BOOLEAN    DisableIntermediateShellLogging  := TRUE; // We never intermediate-log batch jobs.
			EXPORT DATASET(iesp.Share.t_StringArrayItem) Watchlists_Requested := _Watchlists_Requested;
			EXPORT BusinessInstantID20_Services.Types.productTypeEnum BIID20_productType := _BIID20ProductType;
			EXPORT BOOLEAN    useSBFE              := DataPermissionMask[12] NOT IN BusinessInstantID20_Services.Constants.RESTRICTED_SET;
		END;

  IF( Options.OFAC_Version != 4 AND OFAC_XG5.constants.wlALLV4 IN SET(Options.Watchlists_Requested, value),
      FAIL( OFAC_XG5.Constants.ErrorMsg_OFACversion ) );

		// 5. Generate the linking parameters to be used in BIP's kFetch (Key Fetch) - These 
		// parameters should be global so figure them out here and pass around appropriately.
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
		
		// 6. Load the batch input.		
		DATASET(BusinessInstantID20_Services.Layouts.BatchInput) ds_Input_pre := DATASET([], BusinessInstantID20_Services.Layouts.BatchInput) : STORED('Batch_In');

		// 7. The flag "_ForRetroTesting" is set to TRUE for retro-testing purposes prior to going live, 
		// so that customers can evaluate this product. In this case, only one record at a time is sent 
		// to this service via SOAPCALL( ), even though it is a batch service; we'll therefore evaluate 
		// only the first record to determine whether minimum input criteria were met.
		BOOLEAN _ForRetroTesting := FALSE : STORED('ForRetroTesting');
		
		firstRec := ROW(ds_Input_pre[1], BusinessInstantID20_Services.Layouts.BatchInput);
		
		MinimumInputMet := 
				(firstRec.CompanyName != '' OR firstRec.AltCompanyName != '') AND 
				(firstRec.StreetAddress1 != '' OR firstRec.StreetAddress2 != '') AND 
				(firstRec.Zip != '' OR (firstRec.City != '' AND firstRec.State != ''));
			
		IF( _ForRetroTesting AND NOT MinimumInputMet,
			FAIL('Error - Minimum input fields required: please refer to your product manual for guidance.'));

		IF( Options.OFAC_Version = 4 AND ExcludeWatchlists = FALSE AND NOT EXISTS(Options.Gateways(servicename = 'bridgerwlc')), 
			FAIL(Risk_Indicators.iid_constants.OFAC4_NoGateway)); // Due to this RQ-14881 ExcludeWatchlists works with other versions of OFAC in this query. 
                                                            // Please refer to the ticket if needing further details.
    
		ds_Input := PROJECT( ds_Input_pre, BusinessInstantID20_Services.Transforms(Options).xfm_LoadInput(LEFT,COUNTER) );
	
		// 8. Pass all input to BIID 2.0 logic.
		ds_BIID_results := BusinessInstantID20_Services.InstantID20_Records(ds_Input, Options, linkingOptions, ExcludeWatchlists);
				
		// 9. Product output:
		results_batch := PROJECT( ds_BIID_results, BusinessInstantID20_Services.xfm_ToBatchLayout(LEFT, Options) );

		// 10. Calculate Royalties

		// For SBFE...:
		ds_SBFEData := 
			PROJECT(
				ds_BIID_results,
				TRANSFORM( { STRING acctno, UNSIGNED1 SBFEAccountCount },
					SELF.acctno := LEFT.InputEcho.acctno,
					SELF.SBFEAccountCount :=
						(INTEGER)( TRIM(LEFT.SBFEVerification.time_on_sbfe) != '' OR 
						           TRIM(LEFT.SBFEVerification.last_seen_sbfe) != '' OR 
						           TRIM(LEFT.SBFEVerification.count_of_trades_sbfe) != '' )
				)
			);
			
		SBFE_royalties := Royalty.RoyaltySBFE.GetBatchRoyaltiesByAcctno(ds_Input, ds_SBFEData);

		// ...and for Targus Gateway. As of 2/2017 Targus is NOT being used by this product, 
		// so we're returning zeroes: 
		layout_targus_temp := RECORD
			STRING30 acctno;
			Business_Risk_BIP.Layouts.LayoutSources;	
			STRING5 TargusType;
		END;
		
		targus_type := Phones.Constants.TargusType.WirelessConnectionSearch + Phones.Constants.TargusType.PhoneDataExpress;
			
		targus_data := 
			PROJECT(
				ds_BIID_results,
				TRANSFORM( layout_targus_temp,
					SELF.acctno        := LEFT.InputEcho.acctno,
					SELF.Source        := MDR.sourceTools.src_Targus_Gateway,
					SELF.DateFirstSeen := '',
					SELF.DateLastSeen  := '',
					SELF.RecordCount   := 0,
					SELF.TargusType    := ''
				)
			);
		
		Targus_royalties_pre := Royalty.RoyaltyTargus.GetBatchRoyaltiesByAcctno(ds_Input, targus_data, source, , acctno, acctno);
		Targus_royalties := PROJECT( Targus_royalties_pre, TRANSFORM( Royalty.Layouts.RoyaltyForBatch, SELF.source_type := 'G', SELF := LEFT ) ); // 'G' = Gateway source
		
		total_royalties_pre := SORT( (SBFE_royalties + Targus_royalties), acctno, royalty_type_code );
		total_royalties := Royalty.GetBatchRoyalties( total_royalties_pre, _ReturnDetailedRoyalties );

		OUTPUT(total_royalties, NAMED('RoyaltySet'));
		
		// DEBUGs:
		// OUTPUT( ds_BIID_results, NAMED('BIID_Results') );
		
		OUTPUT( results_batch, NAMED('Results') );

ENDMACRO;