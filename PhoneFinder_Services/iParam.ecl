// 05/19, after 4:45pm deploy and test, remove vers1 commented out coding???
IMPORT AutoHeaderI, AutoStandardI, BatchServices, Doxie, iesp, STD;

EXPORT iParam :=
MODULE
	EXPORT DIDParams :=
	  INTERFACE(AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full)
  END;

	EXPORT SearchParams :=
	INTERFACE (doxie.IDataAccess)
		EXPORT UNSIGNED1 TransactionType     := 255;
    EXPORT STRING6   PrimarySearch       := '';
		EXPORT BOOLEAN   IsPrimarySearchPII  := FALSE;
		EXPORT BOOLEAN   ignoreFares         := FALSE;
		EXPORT BOOLEAN   ignoreFidelity      := FALSE;
		EXPORT BOOLEAN   StrictMatch         := FALSE;
		EXPORT BOOLEAN   PhoneticMatch       := FALSE;
		EXPORT UNSIGNED  PenaltyThreshold    := 10;
		EXPORT UNSIGNED  ScoreThreshold      := 10;
		EXPORT BOOLEAN   UseLastResort       := FALSE;
		EXPORT BOOLEAN   UseInHouseQSent     := FALSE;
		EXPORT BOOLEAN   UseQSent            := FALSE;
		EXPORT BOOLEAN   UseTargus           := FALSE;
		EXPORT BOOLEAN   UseMetronet         := FALSE;
		EXPORT BOOLEAN   UseEquifax	         := FALSE;
		EXPORT BOOLEAN   useWaterfallv6			 := FALSE;
		EXPORT BOOLEAN   UseAccuData_OCN		 := FALSE; // accudata_ocn gateway call
		EXPORT BOOLEAN   UseZumigoIdentity	 := FALSE; // zumigo gateway call
    EXPORT BOOLEAN   IncludePhoneMetadata:= FALSE;
		EXPORT BOOLEAN   UseDeltabase 			 := FALSE;
    EXPORT BOOLEAN   SubjectMetadataOnly := FALSE;
		EXPORT BOOLEAN 	 DetailedRoyalties 	 := FALSE;
    EXPORT BOOLEAN   SuppressNonRelevantRecs := FALSE;
		// Options for phone verification
		EXPORT BOOLEAN   VerifyPhoneName      	:= FALSE;
		EXPORT BOOLEAN	 VerifyPhoneNameAddress	:= FALSE;
		EXPORT BOOLEAN	 VerifyPhoneIsActive		:= FALSE;
    EXPORT BOOLEAN   VerifyPhoneLastName    := FALSE;
    EXPORT INTEGER   DateFirstSeenThreshold := 180;
    EXPORT INTEGER   DateLastSeenThreshold  := 30;
    EXPORT INTEGER   LengthOfTimeThreshold  := 90;
		EXPORT BOOLEAN	 UseDateFirstSeenVerify := FALSE;
	  EXPORT BOOLEAN   UseDateLastSeenVerify  := FALSE;
	  EXPORT BOOLEAN   UseLengthOfTimeVerify  := FALSE;
		EXPORT BOOLEAN   IsPhone7Search         := FALSE;

		//Deltabase
		EXPORT STRING 	TransactionID := '';
		EXPORT STRING16 CompanyId     := '';
		EXPORT STRING60 ReferenceCode := '';
		EXPORT STRING8 	SourceCode    := '';
		EXPORT STRING60 BillingCode   := '';
		EXPORT STRING60 _LoginId      := '';
		EXPORT STRING16 _CompanyId    := '';

		// Risk evaluation requests
		EXPORT DATASET(iesp.phonefinder.t_PhoneFinderRiskIndicator) RiskIndicators := DATASET([],iesp.phonefinder.t_PhoneFinderRiskIndicator);
		EXPORT BOOLEAN IncludeOtherPhoneRiskIndicators := FALSE;

		//Zumigo Options
		EXPORT UNSIGNED1 LineIdentityConsentLevel := 0;
		EXPORT STRING20  Usecase                  := '';
		EXPORT STRING3 	 ProductCode              := '';
		EXPORT STRING8	 BillingId                := '';
		// batch only options.
		EXPORT BOOLEAN   DirectMarketingSourcesOnly := FALSE;
		EXPORT INTEGER   MaxOtherPhones             := 0;
		EXPORT BOOLEAN   UseInHousePhoneMetadata    := FALSE;
		EXPORT BOOLEAN   UseAccuData_CNAM		        := FALSE; // accudata cnam gateway call

		//***************** RE-DESIGN data source options **************
		EXPORT BOOLEAN IncludePorting         := FALSE;
		EXPORT BOOLEAN ReturnPortingInfo      := FALSE;
		EXPORT BOOLEAN IncludeSpoofing        := FALSE;
		EXPORT BOOLEAN ReturnSpoofingInfo     := FALSE;
		EXPORT BOOLEAN IncludeOTP             := FALSE;
		EXPORT BOOLEAN ReturnOTPInfo          := FALSE;
		EXPORT BOOLEAN IncludeRiskIndicators  := FALSE;
		EXPORT BOOLEAN IsGetMetaData          := FALSE;
		EXPORT BOOLEAN IsGetPortedData        := FALSE;
		EXPORT BOOLEAN IncludeAccudataOCN     := FALSE;
		EXPORT BOOLEAN IncludeTargus          := FALSE;
		EXPORT BOOLEAN IncludeEquifax         := FALSE;
		EXPORT BOOLEAN IncludeTransUnionIQ411 := FALSE;
		EXPORT BOOLEAN UseTransUnionIQ411     := FALSE;
		EXPORT BOOLEAN IncludeTransUnionPVS   := FALSE;
		EXPORT BOOLEAN UseTransUnionPVS       := FALSE;
		EXPORT BOOLEAN IncludeInhousePhones   := FALSE;
		EXPORT BOOLEAN UseInhousePhones       := FALSE;
    EXPORT BOOLEAN IncludePortingDetails      := FALSE;

    //zumigo options
    EXPORT BOOLEAN NameAddressValidation        := FALSE;
    EXPORT BOOLEAN IncludeNameAddressValidation := FALSE;
    EXPORT BOOLEAN NameAddressInfo              := FALSE;
    EXPORT BOOLEAN IncludeNameAddressInfo       := FALSE;
    EXPORT BOOLEAN AccountInfo                  := FALSE;
    EXPORT BOOLEAN IncludeAccountInfo           := FALSE;
    EXPORT BOOLEAN CallHandlingInfo             := FALSE;
    EXPORT BOOLEAN IncludeCallHandlingInfo      := FALSE;
    EXPORT BOOLEAN DeviceInfo                   := FALSE;
    EXPORT BOOLEAN IncludeDeviceInfo            := FALSE;
    EXPORT BOOLEAN DeviceChangeInfo             := FALSE;
    EXPORT BOOLEAN IncludeDeviceChangeInfo      := FALSE;
    EXPORT BOOLEAN DeviceHistory                := FALSE;
    EXPORT BOOLEAN IncludeDeviceHistory         := FALSE;
    EXPORT BOOLEAN IncludeZumigoOptions         := FALSE;
    EXPORT BOOLEAN InputZumigoOptions           := FALSE;
    // zumigo end

    EXPORT BOOLEAN UseThreatMetrixRules               := FALSE;
    EXPORT BOOLEAN hasActiveIdentitycountRules        := FALSE;
    EXPORT BOOLEAN hasActivePhoneTransactionCountRule := FALSE;
    EXPORT BOOLEAN IsGovSearch := FALSE;
    EXPORT BOOLEAN UseInHousePhoneMetadataOnly := FALSE;
    EXPORT BOOLEAN SuppressRiskIndicatorWarnStatus := FALSE;
    EXPORT BOOLEAN AllowPortingData := FALSE;
    EXPORT UNSIGNED1 IconectivElepGwMaxHistories := 0; //Added for the 2021-06-02 Phone Porting Data for LE project
  END;

  EXPORT PhoneVerificationParams :=
  INTERFACE
    EXPORT BOOLEAN PhoneticMatch;
    EXPORT BOOLEAN VerifyPhoneName;
    EXPORT BOOLEAN VerifyPhoneNameAddress;
    EXPORT BOOLEAN VerifyPhoneIsActive;
    EXPORT BOOLEAN VerifyPhoneLastName;
    EXPORT INTEGER DateFirstSeenThreshold;
    EXPORT INTEGER DateLastSeenThreshold;
    EXPORT INTEGER LengthOfTimeThreshold;
    EXPORT BOOLEAN UseDateFirstSeenVerify;
    EXPORT BOOLEAN UseDateLastSeenVerify;
    EXPORT BOOLEAN UseLengthOfTimeVerify;
    EXPORT BOOLEAN IsPhone7Search;
  END;


  EXPORT GetSearchParams(iesp.phonefinder.t_PhoneFinderSearchOption pfOptions,
                          iesp.share.t_User                          pfUser) :=
  FUNCTION
    // Global module
    globalMod := AutoStandardI.GlobalModule();

    // Search module
    searchMod := PROJECT(globalMod,DIDParams,OPT);

    mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(globalMod);
    drm := mod_access.DataRestrictionMask;
    dpm := mod_access.DataPermissionMask;

    // v---- Added the next 1 line for the 2021-06-02 Phone Porting Data for LE project, 
    //       to set a boolean based on new DPM bit 38 to be used in multiple places below.
    //BOOLEAN PortingDataIsPermitted := doxie.compliance.use_IconectivPortDataValidate(dpm); //vers1??? 

    in_params := MODULE(PROJECT(mod_access, SearchParams, OPT))
      STRING vTransactionType            := pfOptions._Type;
      EXPORT UNSIGNED1 TransactionType   := IF(vTransactionType <> '',$.Constants.MapTransType2Code(vTransactionType), $.Constants.TransType.Blank); // BASIC cannot be default
      STRING6 PrimarySearchCriteria      := STD.Str.ToUpperCase(pfOptions.PrimarySearchCriteria);
      // RDP will be doing a PII search with phone input and primary search criteria as 'PII'
      EXPORT STRING6   PrimarySearch        := PrimarySearchCriteria;
      EXPORT BOOLEAN   IsPrimarySearchPII   := PrimarySearch = $.Constants.PrimarySearchCriteria;
      EXPORT BOOLEAN   StrictMatch          := AutoStandardI.InterfaceTranslator.StrictMatch_value.val(searchMod);

      EXPORT UNSIGNED  ScoreThreshold       := AutoStandardI.InterfaceTranslator.score_threshold_value.val(searchMod);
      EXPORT UNSIGNED  PenaltyThreshold     := AutoStandardI.InterfaceTranslator.penalt_threshold_value.val(PROJECT(globalMod,AutoStandardI.InterfaceTranslator.penalt_threshold_value.params));
      EXPORT BOOLEAN   useWaterfallv6	      := FALSE : STORED('useWaterfallv6');	// internal
      EXPORT BOOLEAN   IncludePhoneMetadata := pfOptions.IncludePhoneMetadata;
      BOOLEAN          SubjectMetadata      := pfOptions.SubjectMetadataOnly;
      EXPORT BOOLEAN   SubjectMetadataOnly  := IF(IncludePhoneMetadata,SubjectMetadata,FALSE);
      EXPORT BOOLEAN   SuppressNonRelevantRecs := pfOptions.SuppressNonRelevantRecs;

      // Options for phone verification
      EXPORT BOOLEAN   VerifyPhoneName				:= pfOptions.VerificationOptions.VerifyPhoneName;
      EXPORT BOOLEAN   VerifyPhoneNameAddress := pfOptions.VerificationOptions.VerifyPhoneNameAddress;
      EXPORT BOOLEAN   VerifyPhoneIsActive    := pfOptions.VerificationOptions.VerifyPhoneIsActive;
      EXPORT BOOLEAN   VerifyPhoneLastName    := pfOptions.VerificationOptions.VerifyPhoneLastName;
      EXPORT BOOLEAN   PhoneticMatch          := VerifyPhoneName OR VerifyPhoneNameAddress OR VerifyPhoneLastName OR AutoStandardI.InterfaceTranslator.phonetics.val(searchMod);
      EXPORT INTEGER   DateFirstSeenThreshold := pfOptions.VerificationOptions.DateFirstSeenThreshold;
      EXPORT INTEGER   DateLastSeenThreshold  := pfOptions.VerificationOptions.DateLastSeenThreshold;
      EXPORT INTEGER   LengthOfTimeThreshold  := pfOptions.VerificationOptions.LengthOfTimeThreshold;
      EXPORT BOOLEAN   UseDateFirstSeenVerify := pfOptions.VerificationOptions.UseDateFirstSeenVerify;
      EXPORT BOOLEAN   UseDateLastSeenVerify  := pfOptions.VerificationOptions.UseDateLastSeenVerify;
      EXPORT BOOLEAN   UseLengthOfTimeVerify  := pfOptions.VerificationOptions.UseLengthOfTimeVerify;
      // ZUMIGO
      EXPORT UNSIGNED1 LineIdentityConsentLevel := pfOptions.LineIdentityConsentLevel;
      EXPORT STRING20  Usecase                  := pfOptions.LineIdentityUseCase;
      EXPORT STRING3 	 ProductCode              := pfUser.ProductCode;
      EXPORT STRING8	 BillingId                := pfUser.BillingId;

      EXPORT STRING16 _CompanyId    := '' : STORED('_CompanyId');
      EXPORT STRING16 CompanyId     := pfUser.CompanyId;
      EXPORT STRING60 ReferenceCode := pfUser.ReferenceCode;
      EXPORT STRING8  SourceCode    := pfUser.SourceCode;
      EXPORT STRING60 _LoginId      := '' : STORED('_LoginId');
      EXPORT STRING60 BillingCode   := pfUser.BillingCode;
      EXPORT STRING   TransactionId := '' : STORED('_TransactionId');

      INTEGER  input_MaxOtherPhones := pfOptions.MaxOtherPhones; // TO RESTRICT OTHER PHONES
      EXPORT INTEGER  MaxOtherPhones	:= IF(input_MaxOtherPhones <> 0, input_MaxOtherPhones, $.Constants.MaxOtherPhones);

//*****************************		RE-DESIGN data source options **************************
      SHARED displayAll := TransactionType in [$.Constants.TransType.PREMIUM,
                                              $.Constants.TransType.ULTIMATE,
                                              $.Constants.TransType.PHONERISKASSESSMENT];
      EXPORT BOOLEAN IncludePorting           := pfOptions.IncludePorting;
      EXPORT BOOLEAN ReturnPortingInfo        := (IncludePhoneMetadata AND displayAll) OR IncludePorting;

      EXPORT BOOLEAN IncludeSpoofing          := pfOptions.IncludeSpoofing;
      EXPORT BOOLEAN ReturnSpoofingInfo       := (IncludePhoneMetadata AND TransactionType IN [$.Constants.TransType.ULTIMATE, $.Constants.TransType.PHONERISKASSESSMENT]) OR IncludeSpoofing;

      EXPORT BOOLEAN IncludeOTP               := pfOptions.IncludeOTP;
      EXPORT BOOLEAN ReturnOTPInfo            := (IncludePhoneMetadata AND displayAll) OR IncludeOTP;

      SHARED IncludeRiskIndicators_internal            := pfOptions.IncludeRiskIndicators;
      EXPORT BOOLEAN   IncludeRiskIndicators           := ((IncludePhoneMetadata AND displayAll) OR IncludeRiskIndicators_internal);
      EXPORT BOOLEAN   IncludeOtherPhoneRiskIndicators := IncludeRiskIndicators_internal OR pfOptions.IncludeOtherPhoneRiskIndicators;

      UserRules	:= DEDUP(SORT(pfOptions.RiskIndicators, riskid), riskid);
      AllRules  := DEDUP(SORT(IF(IncludeRiskIndicators AND EXISTS(UserRules), $.Constants.DefaultRiskIndicatorRules  + UserRules), riskid), riskid);

      EXPORT DATASET(iesp.phonefinder.t_PhoneFinderRiskIndicator) RiskIndicators := IF(TransactionType = $.Constants.TransType.PHONERISKASSESSMENT, UserRules, AllRules);
      EXPORT BOOLEAN IsGetPortedData         := ReturnPortingInfo OR IncludePhoneMetadata;
      EXPORT BOOLEAN IsGetMetaData           := IsGetPortedData OR ReturnSpoofingInfo OR ReturnOTPInfo OR IncludeRiskIndicators;
      BOOLEAN IncludeDeltabaseForRI          := IncludeRiskIndicators AND EXISTS(RiskIndicators(RiskId IN [6, 7, 8, 9, 15, 26, 27, 30]));
      BOOLEAN RealTimedata 			 		 := pfOptions.UseDeltabase OR IncludeDeltabaseForRI; // To get same day OTPs and Inquiries
      EXPORT BOOLEAN UseDeltabase 					 := IF(IsGetMetaData, RealTimedata, FALSE);

      EXPORT BOOLEAN IncludeAccudataOCN      := pfOptions.IncludeAccudataOCN;
      //EXPORT BOOLEAN UseAccuData_OCN         := ((IncludePhoneMetadata AND displayAll) OR IncludeAccudataOCN) AND ~doxie.compliance.isAccuDataRestricted(drm);
      //The gateway is down for past 2 months,not calling this gateway until further update from Product
      EXPORT BOOLEAN UseAccuData_OCN         := FALSE;
      EXPORT BOOLEAN IncludeTargus           := pfOptions.IncludeTargus;
      EXPORT BOOLEAN UseTargus          		 := (TransactionType = $.Constants.TransType.Ultimate OR IncludeTargus) AND ~doxie.compliance.isPhoneFinderTargusRestricted(drm);

      EXPORT BOOLEAN IncludeEquifax          := pfOptions.IncludeEquifax;
      EXPORT BOOLEAN UseEquifax         		 := (TransactionType = $.Constants.TransType.Ultimate OR IncludeEquifax) AND ~doxie.compliance.isPhoneMartRestricted(drm) AND mod_access.isValidGLB();

      EXPORT BOOLEAN IncludeTransUnionIQ411  := pfOptions.IncludeTransUnionIQ411;
      EXPORT BOOLEAN IncludeTransUnionPVS    := pfOptions.IncludeTransUnionPVS;

      EXPORT BOOLEAN UseTransUnionIQ411      := (TransactionType IN [$.Constants.TransType.Premium,$.Constants.TransType.Ultimate] OR IncludeTransUnionIQ411) AND ~doxie.compliance.isQSentRestricted(drm) AND mod_access.isValidGLB();
      EXPORT BOOLEAN UseTransUnionPVS        := (TransactionType IN [$.Constants.TransType.Premium,$.Constants.TransType.Ultimate] OR IncludeTransUnionPVS) AND ~doxie.compliance.isQSentRestricted(drm) AND mod_access.isValidGLB();
      EXPORT BOOLEAN UseQSent           	   := UseTransUnionIQ411 OR UseTransUnionPVS;
      EXPORT BOOLEAN UseInHousePhoneMetadata := pfOptions.UseInHousePhoneMetadata : STORED('UseInHousePhoneMetadata'); // Need to read from stored for options defined in MBS for API transactions as they would come under the root tag
      EXPORT BOOLEAN UseInHousePhoneMetadataOnly := UseInHousePhoneMetadata OR ~UseTransUnionPVS;
      EXPORT BOOLEAN UseAccuData_CNAM        := UseInHousePhoneMetadata AND ~doxie.compliance.isAccuDataRestricted(drm) AND TransactionType != $.Constants.TransType.PhoneRiskAssessment;

      EXPORT BOOLEAN IncludeInhousePhones    := pfOptions.IncludeInhousePhones;
      EXPORT BOOLEAN UseInhousePhones        := IncludeInhousePhones OR (displayAll OR TransactionType = $.Constants.TransType.BASIC);
      EXPORT BOOLEAN UseLastResort      		 := (IncludeInhousePhones OR TransactionType <> $.Constants.TransType.PHONERISKASSESSMENT) AND doxie.compliance.use_LastResort(dpm);
      EXPORT BOOLEAN UseInHouseQSent    	   := (IncludeInhousePhones OR TransactionType <> $.Constants.TransType.PHONERISKASSESSMENT) AND doxie.compliance.use_QSent(dpm);

      SHARED BOOLEAN full_consent   := LineIdentityConsentLevel = $.Constants.ConsentLevels.FullConsumer;
      SHARED BOOLEAN single_consent := LineIdentityConsentLevel = $.Constants.ConsentLevels.SingleConsumer;

      SHARED BOOLEAN ValidZumigoConsents          := (full_consent OR single_consent);

      BOOLEAN hasActiveDeviceRules                := EXISTS(RiskIndicators((RiskId = $.Constants.RiskRules.SimCardInfo OR RiskId = $.Constants.RiskRules.DeviceInfo) AND Active));

      SHARED BOOLEAN ValidDeviceConsentInquiry    := ValidZumigoConsents AND hasActiveDeviceRules;

      EXPORT BOOLEAN NameAddressInfo              := FALSE;
      EXPORT BOOLEAN IncludeNameAddressInfo       := FALSE;

      EXPORT BOOLEAN NameAddressValidation        := pfOptions.IncludeZumigoOptions.NameAddressValidation;
      EXPORT BOOLEAN IncludeNameAddressValidation := (full_consent AND (TransactionType = $.Constants.TransType.Ultimate OR NameAddressValidation));

      EXPORT BOOLEAN AccountInfo                  := FALSE;
      EXPORT BOOLEAN IncludeAccountInfo           := FALSE;

      EXPORT BOOLEAN CallHandlingInfo             := pfOptions.IncludeZumigoOptions.CallHandlingInfo;
      EXPORT BOOLEAN IncludeCallHandlingInfo           := full_consent AND
                                                        (TransactionType IN [PhoneFinder_Services.Constants.TransType.Ultimate,
		                                                    PhoneFinder_Services.Constants.TransType.PHONERISKASSESSMENT] OR CallHandlingInfo) AND
																												EXISTS(RiskIndicators((RiskId = $.Constants.RiskRules.CallForwarding) AND active));

      // zumigo gateway is configured to turn deviceinfo to true when devicehistory is true
      EXPORT BOOLEAN DeviceHistory               := pfOptions.IncludeZumigoOptions.DeviceHistory;
      EXPORT BOOLEAN IncludeDeviceHistory        := FALSE;

      EXPORT BOOLEAN DeviceInfo                  := pfOptions.IncludeZumigoOptions.DeviceInfo;
      EXPORT BOOLEAN IncludeDeviceInfo           := FALSE;

      EXPORT BOOLEAN DeviceChangeInfo            := pfOptions.IncludeZumigoOptions.DeviceChangeInfo;
      EXPORT BOOLEAN IncludeDeviceChangeInfo     :=(TransactionType = $.Constants.TransType.Ultimate OR DeviceChangeInfo) AND ValidDeviceConsentInquiry;

      EXPORT BOOLEAN IncludeZumigoOptions        := IncludeNameAddressValidation OR IncludeCallHandlingInfo OR IncludeDeviceHistory
                                                    OR IncludeDeviceInfo OR IncludeDeviceChangeInfo;

      EXPORT BOOLEAN UseZumigoIdentity	         := IncludeZumigoOptions AND BillingId <>'' AND doxie.compliance.use_ZumigoIdentity(dpm);

      EXPORT BOOLEAN InputZumigoOptions          := NameAddressValidation OR CallHandlingInfo OR DeviceInfo OR DeviceChangeInfo OR DeviceHistory;
      EXPORT BOOLEAN UseThreatMetrixRules        := IncludeRiskIndicators AND EXISTS(RiskIndicators((RiskId  IN $.Constants.AllThreatMetrixRules) AND Active));

      EXPORT BOOLEAN hasActiveIdentityCountRules        := IncludeRiskIndicators AND EXISTS(RiskIndicators((RiskId = $.Constants.RiskRules.IdentityCount AND Active)));
      EXPORT BOOLEAN hasActivePhoneTransactionCountRule := IncludeRiskIndicators AND EXISTS(RiskIndicators(RiskId = $.Constants.RiskRules.PhoneTransactionCount AND ACTIVE));
      EXPORT BOOLEAN IsGovsearch := application_type in AutoStandardI.Constants.GOV_TYPES;
      EXPORT BOOLEAN SuppressRiskIndicatorWarnStatus            :=  pfOptions.SuppressRiskIndicatorWarnStatus : STORED('SuppressRiskIndicatorWarnStatus'); // Need to read from stored for options defined in MBS for API transactions as they would come under the root tag;
      // v--- Revised the next line for the 2021-06-02 Phone Porting Data for LE project, since 'Porting Details' related
      //      data (for LE) will now be based upon new DPM bit 38, not a passed in include option.
      EXPORT BOOLEAN IncludePortingDetails            := //PortingDataIsPermitted; //vers1???
                                                         doxie.compliance.use_IconectivPortDataValidate(dpm); 
      EXPORT BOOLEAN AllowPortingData := TRUE; //To get Iconnective data from Phones.GetPhoneMetadata_wLERG6
      EXPORT UNSIGNED1 IconectivElepGwMaxHistories  := pfOptions.IconectivElepMaxPortHistories; // Added for the 2021-06-02 Phone Porting Data for LE project
   END;

    RETURN in_params;
  END;



  EXPORT AKParams :=
	  INTERFACE(BatchServices.Interfaces.i_AK_Config,SearchParams)
	END;

	EXPORT GetBatchParams() := FUNCTION
    // Global module
    globalMod := AutoStandardI.GlobalModule();

    // Search module
    searchMod := PROJECT(globalMod,DIDParams,OPT);

    mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(globalMod);
    drm := mod_access.DataRestrictionMask;
    dpm := mod_access.DataPermissionMask;

    // v---- Added the next 1 line for the 2021-06-02 Phone Porting Data for LE project, 
    //       to set boolean based on the new DPM bit 38 to be used in multiple places below.
    //EXPORT BOOLEAN PortingDataIsPermitted := doxie.compliance.use_IconectivPortDataValidate(dpm); //vers1???

	  // Report module
    input_Mod := MODULE(PROJECT(mod_access, SearchParams, OPT))
      EXPORT UNSIGNED1 TransactionType     := $.Constants.TransType.Blank : STORED('TransactionType'); // BASIC cannot be default
      EXPORT BOOLEAN   StrictMatch         := AutoStandardI.InterfaceTranslator.StrictMatch_value.val(searchMod);
      EXPORT BOOLEAN   PhoneticMatch       := AutoStandardI.InterfaceTranslator.phonetics.val(searchMod);
      EXPORT UNSIGNED  ScoreThreshold      := AutoStandardI.InterfaceTranslator.score_threshold_value.val(searchMod);
      EXPORT UNSIGNED  PenaltyThreshold    := AutoStandardI.InterfaceTranslator.penalt_threshold_value.val(PROJECT(globalMod,AutoStandardI.InterfaceTranslator.penalt_threshold_value.params));
      EXPORT BOOLEAN   UseLastResort       := doxie.compliance.use_LastResort(dpm) AND TransactionType <> $.Constants.TransType.PHONERISKASSESSMENT;
      EXPORT BOOLEAN   UseInHouseQSent     := doxie.compliance.use_QSent(dpm) AND TransactionType <> $.Constants.TransType.PHONERISKASSESSMENT;
      EXPORT BOOLEAN   UseQSent            := ~doxie.compliance.isQSentRestricted(drm) AND TransactionType IN [$.Constants.TransType.Premium,$.Constants.TransType.Ultimate] AND mod_access.isValidGLB();
      EXPORT BOOLEAN   UseTargus           := ~doxie.compliance.isPhoneFinderTargusRestricted(drm) AND TransactionType = $.Constants.TransType.Ultimate;
      EXPORT BOOLEAN   UseEquifax          := ~doxie.compliance.isPhoneMartRestricted(drm) AND TransactionType = $.Constants.TransType.Ultimate AND mod_access.isValidGLB();
      EXPORT BOOLEAN   useWaterfallv6			 := FALSE : STORED('useWaterfallv6');//internal
      EXPORT BOOLEAN   IncludePhoneMetadata:= FALSE : STORED('IncludePhoneMetadata');

      // EXPORT BOOLEAN   UseAccudata_ocn     := IncludePhoneMetadata AND
      //                                         ~doxie.compliance.isAccuDataRestricted(drm) AND
      //                                          TransactionType IN [$.Constants.TransType.Premium,
      //                                                             $.Constants.TransType.Ultimate,
      //                                                              $.Constants.TransType.PHONERISKASSESSMENT]; // accudata_ocn gateway call
      //The gateway is down for past 2 months,not calling this gateway until further update from Product
      EXPORT BOOLEAN   UseAccudata_ocn     := FALSE;
             BOOLEAN   SubjectMetadata 		 := FALSE : STORED('SubjectMetadataOnly');
      EXPORT BOOLEAN   SubjectMetadataOnly := IF(IncludePhoneMetadata,SubjectMetadata,FALSE);
      EXPORT BOOLEAN   SuppressNonRelevantRecs := FALSE : STORED('SuppressNonRelevantRecs');

      EXPORT BOOLEAN 	 DetailedRoyalties 	            := FALSE : STORED('ReturnDetailedRoyalties');
      EXPORT UNSIGNED1 LineIdentityConsentLevel       := 0 : STORED('LineIdentityConsentLevel');
      EXPORT STRING20  Usecase                        := '': STORED('LineIdentityUseCase');
      EXPORT STRING3 	 ProductCode                    := '': STORED('ProductCode');
      EXPORT STRING8	 BillingId                      := '': STORED('BillingId');
             BOOLEAN   DirectMarketing                := FALSE : STORED('DirectMarketingSourcesOnly');
      EXPORT BOOLEAN   DirectMarketingSourcesOnly     := DirectMarketing AND TransactionType = $.Constants.TransType.BASIC;
      EXPORT INTEGER   MaxOtherPhones		              := iesp.Constants.Phone_Finder.MaxOtherPhones;// TO LIMIT OTHER PHONES

      EXPORT BOOLEAN   UseInHousePhoneMetadata	:= FALSE : STORED('UseInHousePhoneMetadata');
      EXPORT BOOLEAN   UseInHousePhoneMetadataOnly := UseInHousePhoneMetadata OR ~UseTransUnionPVS;
      EXPORT BOOLEAN   UseAccuData_CNAM         := UseInHousePhoneMetadata AND ~doxie.compliance.isAccuDataRestricted(drm) AND TransactionType != $.Constants.TransType.PhoneRiskAssessment;


      EXPORT BOOLEAN   VerifyPhoneName        :=  FALSE : STORED('VerifyPhoneName');
      EXPORT BOOLEAN   VerifyPhoneNameAddress :=  FALSE : STORED('VerifyPhoneNameAddress');

      //*****************************		RE-DESIGN data source options **************************

      SHARED displayAll := TransactionType in [ $.Constants.TransType.PREMIUM,
                                                $.Constants.TransType.ULTIMATE,
                                                $.Constants.TransType.PHONERISKASSESSMENT];

      // v--- Moved and revised the next line for the 2021-06-02 Phone Porting Data for LE project, since 'Porting Details' related
      //      data (for LE) will now be based upon new DPM bit 38, not passed in include option.
      EXPORT BOOLEAN IncludePortingDetails    := //PortingDataIsPermitted;//vers1???
                                                 doxie.compliance.use_IconectivPortDataValidate(dpm); // v--- Revised the next line for the 2021-06-02 Phone Porting Data for LE project
      EXPORT BOOLEAN ReturnPortingInfo        := (IncludePhoneMetadata AND displayAll) OR //PortingDataIsPermitted; //vers1???
                                                                                          IncludePortingDetails;
      
      EXPORT BOOLEAN ReturnSpoofingInfo       := IncludePhoneMetadata AND TransactionType IN [$.Constants.TransType.ULTIMATE,$.Constants.TransType.PHONERISKASSESSMENT];

      EXPORT BOOLEAN ReturnOTPInfo            := IncludePhoneMetadata AND displayAll;

      EXPORT BOOLEAN   IncludeRiskIndicators  := IncludePhoneMetadata AND displayAll;

      EXPORT BOOLEAN   IncludeOtherPhoneRiskIndicators := FALSE : STORED('IncludeOtherPhoneRiskIndicators');

      UserRules := DATASET([],iesp.phonefinder.t_PhoneFinderRiskIndicator) : STORED('RiskIndicators');
      AllRules  := IF(IncludeRiskIndicators AND EXISTS(UserRules), $.Constants.defaultRiskIndicatorRules + UserRules);
      EXPORT DATASET(iesp.phonefinder.t_PhoneFinderRiskIndicator) RiskIndicators := DEDUP(SORT(IF(TransactionType = $.Constants.TransType.PHONERISKASSESSMENT, UserRules, AllRules), riskid), riskid);

	  EXPORT BOOLEAN   IsGetPortedData                    := ReturnPortingInfo OR IncludePhoneMetadata;
	  EXPORT BOOLEAN   IsGetMetaData                      := IsGetPortedData OR ReturnSpoofingInfo OR ReturnOTPInfo OR IncludeRiskIndicators;
      BOOLEAN   UseDeltabase_internal                     := FALSE : STORED('UseDeltabase');
      BOOLEAN IncludeDeltabaseForRI          := IncludeRiskIndicators AND EXISTS(RiskIndicators(RiskId IN [6, 7, 8, 9, 15, 26, 27, 30]));
      BOOLEAN   RealtimeData 		                      := UseDeltabase_internal OR IncludeDeltabaseForRI; // To get same day OTPs and Inquiries
	  EXPORT BOOLEAN   UseDeltabase 		              := IF(IsGetMetaData,RealTimedata,FALSE);
      EXPORT BOOLEAN   UseTransUnionIQ411                 :=   UseQSent;
      EXPORT BOOLEAN   UseTransUnionPVS                   :=   UseQSent;
      EXPORT BOOLEAN   UseInhousePhones                   :=   displayAll OR TransactionType = $.Constants.TransType.BASIC;

      SHARED BOOLEAN full_consent   := LineIdentityConsentLevel = $.Constants.ConsentLevels.FullConsumer;
      SHARED BOOLEAN single_consent := LineIdentityConsentLevel = $.Constants.ConsentLevels.SingleConsumer;

      SHARED BOOLEAN ValidZumigoConsents          := (full_consent OR single_consent);

      BOOLEAN hasActiveDeviceRules                := EXISTS(RiskIndicators((RiskId = $.Constants.RiskRules.SimCardInfo OR RiskId = $.Constants.RiskRules.DeviceInfo) AND Active));

      SHARED BOOLEAN ValidDeviceConsentInquiry    := ValidZumigoConsents  AND hasActiveDeviceRules;
      EXPORT BOOLEAN IncludeAccountInfo           := ValidZumigoConsents AND (TransactionType = $.Constants.TransType.Ultimate);
      EXPORT BOOLEAN IncludeNameAddressValidation := ValidZumigoConsents AND (TransactionType = $.Constants.TransType.Ultimate);

      EXPORT BOOLEAN IncludeCallHandlingInfo      := full_consent AND TransactionType IN [$.Constants.TransType.Ultimate,$.Constants.TransType.PHONERISKASSESSMENT];

      EXPORT BOOLEAN IncludeDeviceHistory         := TransactionType = $.Constants.TransType.Ultimate AND ValidDeviceConsentInquiry;
      EXPORT BOOLEAN IncludeDeviceInfo            := TransactionType = $.Constants.TransType.Ultimate AND ValidDeviceConsentInquiry;
      EXPORT BOOLEAN IncludeDeviceChangeInfo      := TransactionType = $.Constants.TransType.Ultimate AND ValidDeviceConsentInquiry;
      EXPORT BOOLEAN IncludeZumigoOptions         :=  IncludeNameAddressValidation OR IncludeCallHandlingInfo OR IncludeDeviceHistory OR
                                                      IncludeDeviceInfo OR IncludeDeviceChangeInfo;
      EXPORT BOOLEAN UseZumigoIdentity	          := IncludeZumigoOptions AND BillingId <>'' AND doxie.compliance.use_ZumigoIdentity(dpm);
      EXPORT BOOLEAN IsGovsearch := mod_access.application_type in AutoStandardI.Constants.GOV_TYPES;
      EXPORT BOOLEAN SuppressRiskIndicatorWarnStatus :=  FALSE : STORED('SuppressRiskIndicatorWarnStatus');
      EXPORT BOOLEAN AllowPortingData := TRUE;
      // v--- Added the next line for the 2021-06-02 Phone Porting Data for LE project
      EXPORT UNSIGNED1 IconectivElepGwMaxHistories := PhoneFinder_Services.Constants.MaxIconectivElepGwHistBatch; //=2, the max value for the batch service
    END;

    RETURN input_Mod;
  END;

END;
