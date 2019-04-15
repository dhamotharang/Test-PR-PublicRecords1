IMPORT AutoHeaderI, AutoStandardI, BatchServices, Doxie, iesp, STD;

EXPORT iParam :=
MODULE
	
	EXPORT DIDParams :=
	INTERFACE(AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full)
  END;
		
	EXPORT ReportParams :=
	INTERFACE(AutoStandardI.PermissionI_Tools.params,AutoStandardI.DataPermissionI.params,AutoStandardI.DataRestrictionI.params)
		EXPORT UNSIGNED1 TransactionType     := 255;
		EXPORT BOOLEAN   AllowAll            := FALSE;
		EXPORT BOOLEAN   AllowGLB            := FALSE;
		EXPORT BOOLEAN   AllowDPPA           := FALSE;
		EXPORT UNSIGNED1 GLBPurpose          := 0;
		EXPORT UNSIGNED1 DPPAPurpose         := 0;
		EXPORT BOOLEAN   IncludeMinors       := FALSE;
    EXPORT STRING6   PrimarySearch       := '';
		EXPORT BOOLEAN   IsPrimarySearchPII  := FALSE;
		EXPORT STRING    DataRestrictionMask := '00000000000000';
		EXPORT BOOLEAN   ignoreFares         := FALSE;
		EXPORT BOOLEAN   ignoreFidelity      := FALSE;
		EXPORT STRING6   SSNMask             := '';
		EXPORT STRING6   DOBMask             := '';
		EXPORT STRING5   IndustryClass       := '';
		EXPORT STRING32  ApplicationType     := '';
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
		EXPORT BOOLEAN   UseZumigoIdentity		 := FALSE; // zumigo gateway call
    EXPORT BOOLEAN   IncludePhoneMetadata:= FALSE;
		EXPORT BOOLEAN   UseDeltabase 			 := FALSE;
    EXPORT BOOLEAN   SubjectMetadataOnly := FALSE;	
		EXPORT BOOLEAN 	 DetailedRoyalties 	 := FALSE;	
		// Options for phone verification
		EXPORT BOOLEAN   VerifyPhoneName      	:= FALSE;
		EXPORT BOOLEAN	 VerifyPhoneNameAddress	:= FALSE;
		EXPORT BOOLEAN	 VerifyPhoneIsActive		:= FALSE;  
    EXPORT INTEGER   DateFirstSeenThreshold := 180;
    EXPORT INTEGER   DateLastSeenThreshold  := 30;
    EXPORT INTEGER   LengthOfTimeThreshold  := 90;
		EXPORT BOOLEAN	 UseDateFirstSeenVerify := FALSE;
	  EXPORT BOOLEAN   UseDateLastSeenVerify  := FALSE;
	  EXPORT BOOLEAN   UseLengthOfTimeVerify  := FALSE;
		EXPORT BOOLEAN   IsPhone7Search         := FALSE;
		
		//Deltabase
		EXPORT STRING 	    TransactionID := '';
		EXPORT STRING16 	CompanyId := '';
		EXPORT STRING60 	ReferenceCode := '';
		EXPORT STRING8 		SourceCode := '';
		EXPORT STRING60 	BillingCode := '';
		EXPORT STRING60 _LoginId := '';
		EXPORT STRING16 _CompanyId := '';
			
		// Risk evaluation requests
		EXPORT DATASET(iesp.phonefinder.t_PhoneFinderRiskIndicator) RiskIndicators	:= DATASET([],iesp.phonefinder.t_PhoneFinderRiskIndicator);
		EXPORT BOOLEAN   IncludeOtherPhoneRiskIndicators  := FALSE;
		
		//Zumigo Options
		EXPORT UNSIGNED1 LineIdentityConsentLevel     := 0;
		EXPORT STRING20  Usecase := '';
		EXPORT STRING3 	ProductCode := '';
		EXPORT STRING8	BillingId := '';
		// batch only options.
		EXPORT BOOLEAN   DirectMarketingSourcesOnly        := FALSE;
		EXPORT INTEGER   MaxOtherPhones := 0;
		EXPORT BOOLEAN   UseInHousePhoneMetadata	           := FALSE;
		EXPORT BOOLEAN   UseAccuData_CNAM		 := FALSE; // accudata cnam gateway call	
		
		//***************** RE-DESIGN data source options **************
		EXPORT BOOLEAN IncludePorting := FALSE;
		EXPORT BOOLEAN ReturnPortingInfo := FALSE;
		EXPORT BOOLEAN IncludeSpoofing := FALSE;
		EXPORT BOOLEAN ReturnSpoofingInfo := FALSE;
		EXPORT BOOLEAN IncludeOTP := FALSE;
		EXPORT BOOLEAN ReturnOTPInfo := FALSE;
		EXPORT BOOLEAN IncludeRiskIndicators := FALSE;
		EXPORT BOOLEAN IsGetMetaData := FALSE;
		EXPORT BOOLEAN IsGetPortedData := FALSE;
		EXPORT BOOLEAN IncludeAccudataOCN := FALSE;
		EXPORT BOOLEAN IncludeTargus := FALSE;
		EXPORT BOOLEAN IncludeEquifax := FALSE;
		EXPORT BOOLEAN IncludeTransUnionIQ411 := FALSE;
		EXPORT BOOLEAN UseTransUnionIQ411 := FALSE;
		EXPORT BOOLEAN IncludeTransUnionPVS := FALSE;
		EXPORT BOOLEAN UseTransUnionPVS := FALSE;
		EXPORT BOOLEAN IncludeInhousePhones := FALSE;
		EXPORT BOOLEAN UseInhousePhones := FALSE;
		
  //zumigo options
 
  EXPORT BOOLEAN NameAddressValidation        := FALSE;
  EXPORT BOOLEAN IncludeNameAddressValidation := FALSE;
  EXPORT BOOLEAN NameAddressInfo              := FALSE;
  EXPORT BOOLEAN IncludeNameAddressInfo              := FALSE;
  EXPORT BOOLEAN AccountInfo                  := FALSE;
  EXPORT BOOLEAN CallHandlingInfo             := FALSE;
  EXPORT BOOLEAN IncludeCallHandlingInfo      := FALSE;
  EXPORT BOOLEAN DeviceInfo                   := FALSE;
  EXPORT BOOLEAN IncludeDeviceInfo            := FALSE;
  EXPORT BOOLEAN DeviceChangeInfo             := FALSE;
  EXPORT BOOLEAN IncludeDeviceChangeInfo      := FALSE;
  EXPORT BOOLEAN DeviceHistory                := FALSE;
  EXPORT BOOLEAN IncludeDeviceHistory         := FALSE;
  EXPORT BOOLEAN IncludeZumigoOptions         := FALSE;
  EXPORT BOOLEAN InputZumigoOptions         := FALSE;
  
    
 
	END;
    
		EXPORT PhoneVerificationParams := 
		INTERFACE
		  EXPORT BOOLEAN PhoneticMatch;
		  EXPORT BOOLEAN VerifyPhoneName;
		  EXPORT BOOLEAN VerifyPhoneNameAddress;
		  EXPORT BOOLEAN VerifyPhoneIsActive;  
		  EXPORT INTEGER DateFirstSeenThreshold;
		  EXPORT INTEGER DateLastSeenThreshold;
		  EXPORT INTEGER LengthOfTimeThreshold;
		  EXPORT BOOLEAN UseDateFirstSeenVerify;
		  EXPORT BOOLEAN UseDateLastSeenVerify;
		  EXPORT BOOLEAN UseLengthOfTimeVerify;
		  EXPORT BOOLEAN IsPhone7Search;
  END;

 
 EXPORT GetSearchParams(iesp.phonefinder.t_PhoneFinderSearchOption pfOptions,
                     iesp.share.t_User  pfUser) := FUNCTION
		// Global module
	 globalMod := AutoStandardI.GlobalModule();
	
	// Search module
	 searchMod := PROJECT(globalMod,DIDParams,OPT);
			
		in_params := MODULE(ReportParams)			
	    STRING vTransactionType            := pfOptions._Type : STORED('TransactionType');
	   	EXPORT UNSIGNED1 TransactionType   := IF(vTransactionType <> '',PhoneFinder_Services.Constants.MapTransType2Code(vTransactionType), PhoneFinder_Services.Constants.TransType.Blank); // BASIC cannot be default  
      STRING6 PrimarySearchCriteria      := STD.Str.ToUpperCase(pfOptions.PrimarySearchCriteria);
      // RDP will be doing a PII search with phone input and primary search criteria as 'PII'
      EXPORT STRING6   PrimarySearch        := PrimarySearchCriteria;
      EXPORT BOOLEAN   IsPrimarySearchPII   := PrimarySearch = PhoneFinder_Services.Constants.PrimarySearchCriteria;  
      EXPORT BOOLEAN   StrictMatch          := AutoStandardI.InterfaceTranslator.StrictMatch_value.val(searchMod);
      EXPORT BOOLEAN   PhoneticMatch        := AutoStandardI.InterfaceTranslator.phonetics.val(searchMod);
   		EXPORT STRING32  ApplicationType      := AutoStandardI.InterfaceTranslator.application_type_val.val(searchMod);
   		EXPORT STRING5   IndustryClass        := AutoStandardI.InterfaceTranslator.industry_class_val.val(PROJECT(globalMod,AutoStandardI.InterfaceTranslator.industry_class_val.params));
   		EXPORT UNSIGNED1 GLBPurpose           := AutoStandardI.InterfaceTranslator.glb_purpose.val(searchMod);
   		EXPORT UNSIGNED1 DPPAPurpose          := AutoStandardI.InterfaceTranslator.dppa_purpose.val(searchMod);
   		EXPORT UNSIGNED  ScoreThreshold       := AutoStandardI.InterfaceTranslator.score_threshold_value.val(searchMod);
   		EXPORT UNSIGNED  PenaltyThreshold     := AutoStandardI.InterfaceTranslator.penalt_threshold_value.val(PROJECT(globalMod,AutoStandardI.InterfaceTranslator.penalt_threshold_value.params));
   		EXPORT STRING    DataRestrictionMask  := globalMod.DataRestrictionMask;
   		EXPORT STRING    DataPermissionMask   := globalMod.DataPermissionMask;
   		EXPORT STRING6   DOBMask              := AutoStandardI.InterfaceTranslator.dob_mask_val.val(PROJECT(globalMod,AutoStandardI.InterfaceTranslator.dob_mask_val.params));
   		EXPORT STRING6   SSNMask              := AutoStandardI.InterfaceTranslator.ssn_mask_val.val(PROJECT(globalMod,AutoStandardI.InterfaceTranslator.ssn_mask_val.params));
   		EXPORT BOOLEAN   useWaterfallv6	      := FALSE : STORED('useWaterfallv6');	// internal
   		EXPORT BOOLEAN   IncludePhoneMetadata := pfOptions.IncludePhoneMetadata : STORED('IncludePhoneMetadata');				 				 																			 
   		BOOLEAN          SubjectMetadata      := pfOptions.SubjectMetadataOnly : STORED('SubjectMetadataOnly');
   		EXPORT BOOLEAN   SubjectMetadataOnly  := IF(IncludePhoneMetadata,SubjectMetadata,FALSE);
   		
   		// Options for phone verification	  
   		EXPORT BOOLEAN   VerifyPhoneName				:= pfOptions.VerificationOptions.VerifyPhoneName 				: STORED('VerifyPhoneName');
   		EXPORT BOOLEAN   VerifyPhoneNameAddress := pfOptions.VerificationOptions.VerifyPhoneNameAddress : STORED('VerifyPhoneNameAddress');
   		EXPORT BOOLEAN   VerifyPhoneIsActive    := pfOptions.VerificationOptions.VerifyPhoneIsActive    : STORED('VerifyPhoneIsActive');
      EXPORT INTEGER   DateFirstSeenThreshold := pfOptions.VerificationOptions.DateFirstSeenThreshold	: STORED('DateFirstSeenThreshold');
      EXPORT INTEGER   DateLastSeenThreshold  := pfOptions.VerificationOptions.DateLastSeenThreshold 	: STORED('DateLastSeenThreshold');
      EXPORT INTEGER   LengthOfTimeThreshold  := pfOptions.VerificationOptions.LengthOfTimeThreshold 	: STORED('LengthOfTimeThreshold');
   		EXPORT BOOLEAN   UseDateFirstSeenVerify := pfOptions.VerificationOptions.UseDateFirstSeenVerify	: STORED('UseDateFirstSeenVerify');
   		EXPORT BOOLEAN   UseDateLastSeenVerify  := pfOptions.VerificationOptions.UseDateLastSeenVerify  : STORED('UseDateLastSeenVerify');
   		EXPORT BOOLEAN   UseLengthOfTimeVerify  := pfOptions.VerificationOptions.UseLengthOfTimeVerify  : STORED('UseLengthOfTimeVerify');
      // ZUMIGO	
  		EXPORT UNSIGNED1 LineIdentityConsentLevel := pfOptions.LineIdentityConsentLevel : STORED('LineIdentityConsentLevel');                                                     
   		EXPORT STRING20  Usecase                  := pfOptions.LineIdentityUseCase: STORED('LineIdentityUseCase');
   		EXPORT STRING3 	 ProductCode              := pfUser.ProductCode: STORED('ProductCode');
   		EXPORT STRING8	 BillingId                := pfUser.BillingId: STORED('BillingId');
   			
   		EXPORT STRING16 _CompanyId    := '': STORED('_CompanyId');
   		EXPORT STRING16 CompanyId     := pfUser.CompanyId;
   		EXPORT STRING60 ReferenceCode := pfUser.ReferenceCode;
   		EXPORT STRING8  SourceCode    := pfUser.SourceCode;
   		EXPORT STRING60 _LoginId      := '': STORED('_LoginId');
   		EXPORT STRING60 BillingCode   := pfUser.BillingCode;
   		EXPORT STRING   TransactionId := '': STORED('_TransactionId'); 									                                                                                          
   		       INTEGER   input_MaxOtherPhones	 := pfOptions.MaxOtherPhones : STORED('MaxOtherPhones'); // TO RESTRICT OTHER PHONES
   		EXPORT INTEGER   MaxOtherPhones	 := IF(input_MaxOtherPhones <> 0, input_MaxOtherPhones, PhoneFinder_Services.Constants.MaxOtherPhones);
   		                
//*****************************		RE-DESIGN data source options **************************
    
    SHARED displayAll := TransactionType in [PhoneFinder_Services.Constants.TransType.PREMIUM,
																						PhoneFinder_Services.Constants.TransType.ULTIMATE,
																						PhoneFinder_Services.Constants.TransType.PHONERISKASSESSMENT];	
                                            
			 EXPORT BOOLEAN IncludePorting           := pfOptions.IncludePorting: STORED('IncludePorting');
			 EXPORT BOOLEAN ReturnPortingInfo        := (IncludePhoneMetadata AND displayAll) OR IncludePorting;
       
			 EXPORT BOOLEAN IncludeSpoofing          := pfOptions.IncludeSpoofing: STORED('IncludeSpoofing');
			 EXPORT BOOLEAN ReturnSpoofingInfo       := (IncludePhoneMetadata AND TransactionType IN [PhoneFinder_Services.Constants.TransType.ULTIMATE,
																																					       PhoneFinder_Services.Constants.TransType.PHONERISKASSESSMENT]) OR IncludeSpoofing;
       
			 EXPORT BOOLEAN IncludeOTP               := pfOptions.IncludeOTP: STORED('IncludeOTP');
			 EXPORT BOOLEAN ReturnOTPInfo            := (IncludePhoneMetadata AND displayAll) OR IncludeOTP;
       
    
    SHARED IncludeRiskIndicators_internal        := pfOptions.IncludeRiskIndicators: STORED('IncludeRiskIndicators');
			 EXPORT BOOLEAN   IncludeRiskIndicators       := ((IncludePhoneMetadata AND displayAll) OR IncludeRiskIndicators_internal);
       
    EXPORT BOOLEAN   IncludeOtherPhoneRiskIndicators				:= IncludeRiskIndicators_internal OR pfOptions.IncludeOtherPhoneRiskIndicators : STORED('IncludeOtherPhoneRiskIndicators');	
	  
   	UserRules							:= pfOptions.RiskIndicators : STORED('RiskIndicators');	
   	allRules := IF(IncludeRiskIndicators AND EXISTS(UserRules), PhoneFinder_Services.Constants.defaultRules + UserRules,
   										                                                           DATASET([],iesp.phonefinder.t_PhoneFinderRiskIndicator));
   	EXPORT DATASET(iesp.phonefinder.t_PhoneFinderRiskIndicator) RiskIndicators	:= IF(TransactionType = PhoneFinder_Services.Constants.TransType.PHONERISKASSESSMENT, 
   		                                                                                  UserRules, allRules);
   	EXPORT BOOLEAN   IsGetPortedData                    := ReturnPortingInfo OR IncludePhoneMetadata; 
		  EXPORT BOOLEAN   IsGetMetaData                      := IsGetPortedData OR ReturnSpoofingInfo OR ReturnOTPInfo OR IncludeRiskIndicators; 
			        BOOLEAN   RealTimedata 			 		                := pfOptions.UseDeltabase : STORED('UseDeltabase');						 	
			 EXPORT BOOLEAN   UseDeltabase 					                 := IF(IsGetMetaData
			                                                          ,RealTimedata
																							                                        ,FALSE);		
    
    EXPORT BOOLEAN IncludeAccudataOCN                   := pfOptions.IncludeAccudataOCN: STORED('IncludeAccudataOCN');
    EXPORT BOOLEAN   UseAccuData_OCN                    := ((IncludePhoneMetadata AND displayAll) OR IncludeAccudataOCN) AND 
                                                           ~Doxie.DataRestriction.AccuData; 
                                                           
    EXPORT BOOLEAN IncludeTargus                        := pfOptions.IncludeTargus: STORED('IncludeTargus');    
    EXPORT BOOLEAN   UseTargus          		              := (TransactionType = PhoneFinder_Services.Constants.TransType.Ultimate OR IncludeTargus) AND 
                                                           ~doxie.DataRestriction.PhoneFinderTargus;   
    
    EXPORT BOOLEAN IncludeEquifax                        := pfOptions.IncludeEquifax: STORED('IncludeEquifax');    
    EXPORT BOOLEAN   UseEquifax         		               := (TransactionType = PhoneFinder_Services.Constants.TransType.Ultimate OR IncludeEquifax) AND
                                                            ~doxie.DataRestriction.EquifaxPhoneMart;
    
    EXPORT BOOLEAN IncludeTransUnionIQ411                := pfOptions.IncludeTransUnionIQ411: STORED('IncludeTransUnionIQ411');   
    EXPORT BOOLEAN IncludeTransUnionPVS                  := pfOptions.IncludeTransUnionPVS: STORED('IncludeTransUnionPVS'); 
    
    EXPORT BOOLEAN UseTransUnionIQ411                    := (TransactionType IN [PhoneFinder_Services.Constants.TransType.Premium,PhoneFinder_Services.Constants.TransType.Ultimate] OR 
                                                             IncludeTransUnionIQ411) AND
                                                            ~doxie.DataRestriction.QSent;  
    EXPORT BOOLEAN UseTransUnionPVS                      :=  (TransactionType IN [PhoneFinder_Services.Constants.TransType.Premium,PhoneFinder_Services.Constants.TransType.Ultimate] OR 
                                                             IncludeTransUnionPVS) AND
                                                            ~doxie.DataRestriction.QSent;
                                                            
    EXPORT BOOLEAN   UseQSent           		               := UseTransUnionIQ411 OR UseTransUnionPVS;  
                                                            
   	EXPORT BOOLEAN   UseInHousePhoneMetadata	 := pfOptions.UseInHousePhoneMetadata: STORED('UseInHousePhoneMetadata');
    EXPORT BOOLEAN   UseAccuData_CNAM         := UseInHousePhoneMetadata AND ~Doxie.DataRestriction.AccuData; 
      
    EXPORT BOOLEAN IncludeInhousePhones      := pfOptions.IncludeInhousePhones: STORED('IncludeInhousePhones');
    EXPORT BOOLEAN   UseInhousePhones        := IncludeInhousePhones OR 
                                                 (displayAll OR TransactionType = PhoneFinder_Services.Constants.TransType.BASIC);
    EXPORT BOOLEAN   UseLastResort      		   := (IncludeInhousePhones OR TransactionType <> PhoneFinder_Services.Constants.TransType.PHONERISKASSESSMENT) AND 
                                                  doxie.DataPermission.use_LastResort;
   	EXPORT BOOLEAN   UseInHouseQSent    	   	:= (IncludeInhousePhones OR TransactionType <> PhoneFinder_Services.Constants.TransType.PHONERISKASSESSMENT)  AND 
                                                  doxie.DataPermission.use_QSent;	  	  
   
    SHARED BOOLEAN full_consent   := LineIdentityConsentLevel = PhoneFinder_Services.Constants.ConsentLevels.FullConsumer;
    SHARED BOOLEAN single_consent := LineIdentityConsentLevel = PhoneFinder_Services.Constants.ConsentLevels.SingleConsumer;
    
    SHARED BOOLEAN ValidZumigoConsents             := (full_consent OR single_consent);
    
    BOOLEAN hasActiveDeviceRules              := EXISTS(RiskIndicators((RiskId = PhoneFinder_Services.Constants.RiskRules.SimCardInfo OR 
                                                                         RiskId = PhoneFinder_Services.Constants.RiskRules.DeviceInfo) AND active));
                                    
    SHARED BOOLEAN ValidDeviceConsentInquiry   := ValidZumigoConsents AND hasActiveDeviceRules;	
    
    EXPORT BOOLEAN NameAddressInfo                   := pfOptions.IncludeZumigoOptions.NameAddressInfo: STORED('NameAddressInfo');   
    EXPORT BOOLEAN IncludeNameAddressInfo            := ValidZumigoConsents AND 
                                                        (TransactionType = PhoneFinder_Services.Constants.TransType.Ultimate OR NameAddressInfo);   
    
    EXPORT BOOLEAN NameAddressValidation             := pfOptions.IncludeZumigoOptions.NameAddressValidation: STORED('NameAddressValidation');
    EXPORT BOOLEAN IncludeNameAddressValidation      := IncludeNameAddressInfo OR (full_consent AND 
                                                        (TransactionType = PhoneFinder_Services.Constants.TransType.Ultimate OR 
                                                        NameAddressValidation));   // when NameAddressInfo is requested, NameAddressValidation should also be selected
                                                        
    EXPORT BOOLEAN AccountInfo                       := pfOptions.IncludeZumigoOptions.AccountInfo: STORED('AccountInfo');  
    
    EXPORT BOOLEAN CallHandlingInfo                  := pfOptions.IncludeZumigoOptions.CallHandlingInfo: STORED('CallHandlingInfo');
    EXPORT BOOLEAN IncludeCallHandlingInfo           := full_consent AND
                                                        (TransactionType IN [PhoneFinder_Services.Constants.TransType.Ultimate,
		                                                             PhoneFinder_Services.Constants.TransType.PHONERISKASSESSMENT] OR CallHandlingInfo);    
                                                                                                                                        
    // zumigo gateway is configured to turn deviceinfo to true when devicehistory is true
    EXPORT BOOLEAN DeviceHistory              := pfOptions.IncludeZumigoOptions.DeviceHistory: STORED('DeviceHistory');     
    EXPORT BOOLEAN IncludeDeviceHistory       :=(TransactionType = PhoneFinder_Services.Constants.TransType.Ultimate OR DeviceHistory) AND
                                                 ValidDeviceConsentInquiry; 
    
    EXPORT BOOLEAN DeviceInfo                 := pfOptions.IncludeZumigoOptions.DeviceInfo: STORED('DeviceInfo');   
    EXPORT BOOLEAN IncludeDeviceInfo          :=(TransactionType = PhoneFinder_Services.Constants.TransType.Ultimate OR DeviceHistory OR DeviceInfo) AND
                                                 ValidDeviceConsentInquiry;    
    
    EXPORT BOOLEAN DeviceChangeInfo           := pfOptions.IncludeZumigoOptions.DeviceChangeInfo: STORED('DeviceChangeInfo');   
    EXPORT BOOLEAN IncludeDeviceChangeInfo    :=(TransactionType = PhoneFinder_Services.Constants.TransType.Ultimate OR DeviceChangeInfo) AND
                                                 ValidDeviceConsentInquiry;   
		
    EXPORT BOOLEAN IncludeZumigoOptions       := IncludeNameAddressValidation OR IncludeNameAddressInfo OR
                                                 IncludeCallHandlingInfo OR IncludeDeviceHistory OR 
                                                 IncludeDeviceInfo OR IncludeDeviceHistory;                                        	
		
	   EXPORT BOOLEAN   UseZumigoIdentity	       := IncludeZumigoOptions AND BillingId <>'' AND doxie.DataPermission.use_ZumigoIdentity; 
     
    EXPORT BOOLEAN InputZumigoOptions         := NameAddressValidation OR NameAddressInfo OR
                                                 CallHandlingInfo OR DeviceInfo OR 
                                                 DeviceChangeInfo OR DeviceHistory;
   
		END;
			
			RETURN in_params;
		END;
    
   
 
 EXPORT AKParams :=
	  INTERFACE(BatchServices.Interfaces.i_AK_Config,ReportParams)
	END;
	
	EXPORT GetBatchParams() := FUNCTION
  
 // Global module
	globalMod := AutoStandardI.GlobalModule();
	
	// Search module
	searchMod := PROJECT(globalMod,DIDParams,OPT);
	
	// Report module
	input_Mod := MODULE(ReportParams)
		EXPORT UNSIGNED1 TransactionType     := PhoneFinder_Services.Constants.TransType.Blank : STORED('TransactionType'); // BASIC cannot be default
		EXPORT BOOLEAN   StrictMatch         := AutoStandardI.InterfaceTranslator.StrictMatch_value.val(searchMod);
		EXPORT BOOLEAN   PhoneticMatch       := AutoStandardI.InterfaceTranslator.phonetics.val(searchMod);
		EXPORT STRING32  ApplicationType     := AutoStandardI.InterfaceTranslator.application_type_val.val(searchMod);
		EXPORT STRING5   IndustryClass       := AutoStandardI.InterfaceTranslator.industry_class_val.val(PROJECT(globalMod,AutoStandardI.InterfaceTranslator.industry_class_val.params));
		EXPORT UNSIGNED1 GLBPurpose          := AutoStandardI.InterfaceTranslator.glb_purpose.val(searchMod);
		EXPORT UNSIGNED1 DPPAPurpose         := AutoStandardI.InterfaceTranslator.dppa_purpose.val(searchMod);
		EXPORT UNSIGNED  ScoreThreshold      := AutoStandardI.InterfaceTranslator.score_threshold_value.val(searchMod);
		EXPORT UNSIGNED  PenaltyThreshold    := AutoStandardI.InterfaceTranslator.penalt_threshold_value.val(PROJECT(globalMod,AutoStandardI.InterfaceTranslator.penalt_threshold_value.params));
		EXPORT STRING    DataRestrictionMask := globalMod.DataRestrictionMask;
		EXPORT STRING    DataPermissionMask  := globalMod.DataPermissionMask;
		EXPORT STRING6   DOBMask             := AutoStandardI.InterfaceTranslator.dob_mask_val.val(PROJECT(globalMod,AutoStandardI.InterfaceTranslator.dob_mask_val.params));
		EXPORT STRING6   SSNMask             := AutoStandardI.InterfaceTranslator.ssn_mask_val.val(PROJECT(globalMod,AutoStandardI.InterfaceTranslator.ssn_mask_val.params));
		EXPORT BOOLEAN   UseLastResort       := doxie.DataPermission.use_LastResort AND TransactionType <> PhoneFinder_Services.Constants.TransType.PHONERISKASSESSMENT;
		EXPORT BOOLEAN   UseInHouseQSent     := doxie.DataPermission.use_QSent AND TransactionType <> PhoneFinder_Services.Constants.TransType.PHONERISKASSESSMENT;
		EXPORT BOOLEAN   UseQSent            := ~doxie.DataRestriction.QSent AND TransactionType IN [PhoneFinder_Services.Constants.TransType.Premium,PhoneFinder_Services.Constants.TransType.Ultimate];
		EXPORT BOOLEAN   UseTargus           := ~doxie.DataRestriction.PhoneFinderTargus AND TransactionType = PhoneFinder_Services.Constants.TransType.Ultimate;
		EXPORT BOOLEAN   UseEquifax          := ~doxie.DataRestriction.EquifaxPhoneMart AND TransactionType = PhoneFinder_Services.Constants.TransType.Ultimate;
		EXPORT BOOLEAN   useWaterfallv6			 := FALSE : STORED('useWaterfallv6');//internal
		EXPORT BOOLEAN   IncludePhoneMetadata := FALSE : STORED('IncludePhoneMetadata');  
    
		EXPORT BOOLEAN   UseAccudata_ocn     := IncludePhoneMetadata AND ~Doxie.DataRestriction.AccuData AND TransactionType IN [PhoneFinder_Services.Constants.TransType.Premium,
		                                                                                     PhoneFinder_Services.Constants.TransType.Ultimate,
																																												 PhoneFinder_Services.Constants.TransType.PHONERISKASSESSMENT]; // accudata_ocn gateway call
					    BOOLEAN   SubjectMetadata 		 := FALSE : STORED('SubjectMetadataOnly');
		EXPORT BOOLEAN   SubjectMetadataOnly := IF(IncludePhoneMetadata,SubjectMetadata,FALSE);
									
		EXPORT BOOLEAN 	 DetailedRoyalties 	            := FALSE : STORED('ReturnDetailedRoyalties');
		EXPORT UNSIGNED1 LineIdentityConsentLevel       := 0 : STORED('LineIdentityConsentLevel');	
		EXPORT STRING20  Usecase                        := '': STORED('LineIdentityUseCase');
		EXPORT STRING3 	 ProductCode                    := '': STORED('ProductCode');
		EXPORT STRING8	 BillingId                      := '': STORED('BillingId');
				     BOOLEAN   DirectMarketing := FALSE : STORED('DirectMarketingSourcesOnly');
		EXPORT BOOLEAN   DirectMarketingSourcesOnly := DirectMarketing AND TransactionType = PhoneFinder_Services.Constants.TransType.BASIC;
		EXPORT INTEGER   MaxOtherPhones		 := iesp.Constants.Phone_Finder.MaxOtherPhones;// TO LIMIT OTHER PHONES
		                 
		EXPORT BOOLEAN   UseInHousePhoneMetadata	 := FALSE : STORED('UseInHousePhoneMetadata');
  EXPORT BOOLEAN   UseAccuData_CNAM         := UseInHousePhoneMetadata AND ~Doxie.DataRestriction.AccuData;
    
        
		EXPORT BOOLEAN   VerifyPhoneName        :=  FALSE : STORED('VerifyPhoneName');
		EXPORT BOOLEAN   VerifyPhoneNameAddress :=  FALSE : STORED('VerifyPhoneNameAddress');
    
  //*****************************		RE-DESIGN data source options **************************
  
   SHARED displayAll :=     TransactionType in [PhoneFinder_Services.Constants.TransType.PREMIUM,
																						PhoneFinder_Services.Constants.TransType.ULTIMATE,
																						PhoneFinder_Services.Constants.TransType.PHONERISKASSESSMENT];	
                                            
			 EXPORT BOOLEAN ReturnPortingInfo        := IncludePhoneMetadata AND displayAll;
       		 
			 EXPORT BOOLEAN ReturnSpoofingInfo       := IncludePhoneMetadata AND TransactionType IN [PhoneFinder_Services.Constants.TransType.ULTIMATE,
																																					       PhoneFinder_Services.Constants.TransType.PHONERISKASSESSMENT];
       
			 EXPORT BOOLEAN ReturnOTPInfo            := IncludePhoneMetadata AND displayAll;
       
			 EXPORT BOOLEAN   IncludeRiskIndicators := IncludePhoneMetadata AND displayAll;
       
    EXPORT BOOLEAN   IncludeOtherPhoneRiskIndicators:= FALSE : STORED('IncludeOtherPhoneRiskIndicators');
	  
   	UserRules  				 := DATASET([],iesp.phonefinder.t_PhoneFinderRiskIndicator) : STORED('RiskIndicators');
   	allRules := IF(IncludeRiskIndicators AND EXISTS(UserRules), PhoneFinder_Services.Constants.defaultRules + UserRules,
   										                                                           DATASET([],iesp.phonefinder.t_PhoneFinderRiskIndicator));
   	EXPORT DATASET(iesp.phonefinder.t_PhoneFinderRiskIndicator) RiskIndicators	:= IF(TransactionType = PhoneFinder_Services.Constants.TransType.PHONERISKASSESSMENT, 
   		                                                                                  UserRules, allRules);	
	
		  EXPORT BOOLEAN   IsGetPortedData                    := ReturnPortingInfo OR IncludePhoneMetadata; 
		  EXPORT BOOLEAN   IsGetMetaData                      := IsGetPortedData OR ReturnSpoofingInfo OR ReturnOTPInfo OR IncludeRiskIndicators; 
			        BOOLEAN   RealtimeData 			                   := FALSE : STORED('UseDeltabase');					 	
			 EXPORT BOOLEAN   UseDeltabase 					                 := IF(IsGetMetaData
			                                                          ,RealTimedata
																							                                        ,FALSE);		
    EXPORT BOOLEAN   UseTransUnionIQ411                 :=   UseQSent;                                                                               
    EXPORT BOOLEAN   UseTransUnionPVS                   :=   UseQSent;                                                                               
    EXPORT BOOLEAN   UseInhousePhones                   :=   displayAll OR TransactionType = PhoneFinder_Services.Constants.TransType.BASIC;
   
    SHARED BOOLEAN full_consent   := LineIdentityConsentLevel = PhoneFinder_Services.Constants.ConsentLevels.FullConsumer;
    SHARED BOOLEAN single_consent := LineIdentityConsentLevel = PhoneFinder_Services.Constants.ConsentLevels.SingleConsumer;
    
    SHARED BOOLEAN ValidZumigoConsents               := (full_consent OR single_consent);
    BOOLEAN hasActiveDeviceRules                     := EXISTS(RiskIndicators((RiskId = PhoneFinder_Services.Constants.RiskRules.SimCardInfo OR 
                                                                         RiskId = PhoneFinder_Services.Constants.RiskRules.DeviceInfo) AND active));
                                    
    SHARED BOOLEAN ValidDeviceConsentInquiry         := ValidZumigoConsents  AND hasActiveDeviceRules;	
    
    EXPORT BOOLEAN IncludeNameAddressInfo            := ValidZumigoConsents AND 
                                                        (TransactionType = PhoneFinder_Services.Constants.TransType.Ultimate);  
    
    EXPORT BOOLEAN IncludeNameAddressValidation      := ValidZumigoConsents AND 
                                                        (TransactionType = PhoneFinder_Services.Constants.TransType.Ultimate);  
                                                         
    EXPORT BOOLEAN IncludeCallHandlingInfo           := full_consent AND TransactionType IN [PhoneFinder_Services.Constants.TransType.Ultimate,
		                                                                                           PhoneFinder_Services.Constants.TransType.PHONERISKASSESSMENT];  
    
    EXPORT BOOLEAN IncludeDeviceHistory       := TransactionType = PhoneFinder_Services.Constants.TransType.Ultimate AND
                                                 ValidDeviceConsentInquiry; 
    
    EXPORT BOOLEAN IncludeDeviceInfo          := TransactionType = PhoneFinder_Services.Constants.TransType.Ultimate AND
                                                 ValidDeviceConsentInquiry;    
 
    EXPORT BOOLEAN IncludeDeviceChangeInfo    := TransactionType = PhoneFinder_Services.Constants.TransType.Ultimate AND
                                                 ValidDeviceConsentInquiry;                                                                          
    
    EXPORT BOOLEAN IncludeZumigoOptions       := IncludeNameAddressValidation OR IncludeNameAddressInfo OR
                                                 IncludeCallHandlingInfo OR IncludeDeviceHistory OR 
                                                 IncludeDeviceInfo OR IncludeDeviceHistory; 
                                                 
    EXPORT BOOLEAN   UseZumigoIdentity	       := IncludeZumigoOptions AND BillingId <>'' AND doxie.DataPermission.use_ZumigoIdentity; 

                                                        
 END; 
	 RETURN input_Mod;
 END;
 
END;