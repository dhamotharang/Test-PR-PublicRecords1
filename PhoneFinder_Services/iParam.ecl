IMPORT AutoHeaderI,AutoStandardI,BatchServices,Doxie,iesp;

EXPORT iParam :=
MODULE
	
	EXPORT DIDParams :=
	INTERFACE(AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full)
  END;
		
	EXPORT ReportParams :=
	INTERFACE(AutoStandardI.PermissionI_Tools.params,AutoStandardI.DataPermissionI.params,AutoStandardI.DataRestrictionI.params)
		EXPORT UNSIGNED1 TransactionType     := 0;
		EXPORT BOOLEAN   AllowAll            := FALSE;
    EXPORT BOOLEAN   AllowGLB            := FALSE;
    EXPORT BOOLEAN   AllowDPPA           := FALSE;
    EXPORT UNSIGNED1 GLBPurpose          := 0;
    EXPORT UNSIGNED1 DPPAPurpose         := 0;
    EXPORT BOOLEAN   IncludeMinors       := FALSE;

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
		EXPORT BOOLEAN IncludeSpoofing := FALSE;
		EXPORT BOOLEAN IncludeOTP := FALSE;
		EXPORT BOOLEAN IncludeRiskIndicators := FALSE;
		EXPORT BOOLEAN IsGetMetaData := FALSE;
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
	   	STRING vTransactionType              := pfOptions._Type : STORED('TransactionType');
	   	EXPORT UNSIGNED1 TransactionType     := PhoneFinder_Services.Constants.MapTransType2Code(vTransactionType);
		   EXPORT BOOLEAN   StrictMatch        	:= AutoStandardI.InterfaceTranslator.StrictMatch_value.val(searchMod);
 		  EXPORT BOOLEAN   PhoneticMatch      	:= AutoStandardI.InterfaceTranslator.phonetics.val(searchMod);
   		EXPORT STRING32  ApplicationType   		 := AutoStandardI.InterfaceTranslator.application_type_val.val(searchMod);
   		EXPORT STRING5   IndustryClass      		:= AutoStandardI.InterfaceTranslator.industry_class_val.val(PROJECT(globalMod,AutoStandardI.InterfaceTranslator.industry_class_val.params));
   		EXPORT UNSIGNED1 GLBPurpose         		:= AutoStandardI.InterfaceTranslator.glb_purpose.val(searchMod);
   		EXPORT UNSIGNED1 DPPAPurpose        		:= AutoStandardI.InterfaceTranslator.dppa_purpose.val(searchMod);
   		EXPORT UNSIGNED  ScoreThreshold     		:= AutoStandardI.InterfaceTranslator.score_threshold_value.val(searchMod);
   		EXPORT UNSIGNED  PenaltyThreshold    	:= AutoStandardI.InterfaceTranslator.penalt_threshold_value.val(PROJECT(globalMod,AutoStandardI.InterfaceTranslator.penalt_threshold_value.params));
   		EXPORT STRING    DataRestrictionMask		:= globalMod.DataRestrictionMask;
   		EXPORT STRING    DataPermissionMask 		:= globalMod.DataPermissionMask;
   		EXPORT STRING6   DOBMask             	:= AutoStandardI.InterfaceTranslator.dob_mask_val.val(PROJECT(globalMod,AutoStandardI.InterfaceTranslator.dob_mask_val.params));
   		EXPORT STRING6   SSNMask            		:= AutoStandardI.InterfaceTranslator.ssn_mask_val.val(PROJECT(globalMod,AutoStandardI.InterfaceTranslator.ssn_mask_val.params));
   		EXPORT BOOLEAN   UseLastResort      		:= doxie.DataPermission.use_LastResort AND TransactionType <> PhoneFinder_Services.Constants.TransType.PHONERISKASSESSMENT;
   		EXPORT BOOLEAN   UseInHouseQSent    		:= doxie.DataPermission.use_QSent AND TransactionType <> PhoneFinder_Services.Constants.TransType.PHONERISKASSESSMENT;
   		EXPORT BOOLEAN   UseQSent           		:= ~doxie.DataRestriction.QSent AND TransactionType in [PhoneFinder_Services.Constants.TransType.Premium,PhoneFinder_Services.Constants.TransType.Ultimate];
   		EXPORT BOOLEAN   UseAccuData_OCN     := pfOptions.IncludePhoneMetadata AND ~Doxie.DataRestriction.AccuData AND TransactionType IN [PhoneFinder_Services.Constants.TransType.Premium,
   		                                                                                                  PhoneFinder_Services.Constants.TransType.Ultimate,
   		                                                                                                  PhoneFinder_Services.Constants.TransType.PHONERISKASSESSMENT];
   		EXPORT BOOLEAN   UseTargus          		:= ~doxie.DataRestriction.PhoneFinderTargus AND TransactionType = PhoneFinder_Services.Constants.TransType.Ultimate;
   		EXPORT BOOLEAN   UseEquifax         		:= ~doxie.DataRestriction.EquifaxPhoneMart AND TransactionType = PhoneFinder_Services.Constants.TransType.Ultimate;
   		EXPORT BOOLEAN   useWaterfallv6					  := FALSE : STORED('useWaterfallv6');	// internal
   		EXPORT BOOLEAN   IncludePhoneMetadata		:= pfOptions.IncludePhoneMetadata : STORED('IncludePhoneMetadata');				 				 																			 
   		BOOLEAN          SubjectMetadata 		 		 := pfOptions.SubjectMetadataOnly : STORED('SubjectMetadataOnly');
   		EXPORT BOOLEAN   SubjectMetadataOnly  	:= IF(IncludePhoneMetadata,SubjectMetadata,FALSE);
   		
   		// Options for phone verification	  
   		EXPORT BOOLEAN   VerifyPhoneName				     := pfOptions.VerificationOptions.VerifyPhoneName 				: STORED('VerifyPhoneName');
   		EXPORT BOOLEAN   VerifyPhoneNameAddress  := pfOptions.VerificationOptions.VerifyPhoneNameAddress : STORED('VerifyPhoneNameAddress');
   		EXPORT BOOLEAN   VerifyPhoneIsActive     := pfOptions.VerificationOptions.VerifyPhoneIsActive    : STORED('VerifyPhoneIsActive');
     EXPORT INTEGER   DateFirstSeenThreshold := pfOptions.VerificationOptions.DateFirstSeenThreshold	: STORED('DateFirstSeenThreshold');
     EXPORT INTEGER   DateLastSeenThreshold  := pfOptions.VerificationOptions.DateLastSeenThreshold 	: STORED('DateLastSeenThreshold');
     EXPORT INTEGER   LengthOfTimeThreshold  := pfOptions.VerificationOptions.LengthOfTimeThreshold 	: STORED('LengthOfTimeThreshold');
   		EXPORT BOOLEAN   UseDateFirstSeenVerify := pfOptions.VerificationOptions.UseDateFirstSeenVerify	: STORED('UseDateFirstSeenVerify');
   		EXPORT BOOLEAN   UseDateLastSeenVerify  := pfOptions.VerificationOptions.UseDateLastSeenVerify  : STORED('UseDateLastSeenVerify');
   		EXPORT BOOLEAN   UseLengthOfTimeVerify  := pfOptions.VerificationOptions.UseLengthOfTimeVerify  : STORED('UseLengthOfTimeVerify');
   	// ZUMIGO	
  			EXPORT UNSIGNED1 LineIdentityConsentLevel           := pfOptions.LineIdentityConsentLevel : STORED('LineIdentityConsentLevel');                                                     
   		EXPORT STRING20  Usecase                            := pfOptions.LineIdentityUseCase: STORED('LineIdentityUseCase');
   		EXPORT STRING3 	 ProductCode                        := pfUser.ProductCode: STORED('ProductCode');
   		EXPORT STRING8	 BillingId                          	:= pfUser.BillingId: STORED('BillingId');
   			
   		EXPORT STRING16 _CompanyId     := '': STORED('_CompanyId');
   		EXPORT STRING16 CompanyId     := pfUser.CompanyId;
   		EXPORT STRING60 ReferenceCode := pfUser.ReferenceCode;
   		EXPORT STRING8  SourceCode    := pfUser.SourceCode;
   		EXPORT STRING60 _LoginId   := '': STORED('_LoginId');
   		EXPORT STRING60 BillingCode   := pfUser.BillingCode;
   		EXPORT STRING   TransactionId := '': STORED('_TransactionId'); 		
   		       BOOLEAN   ActiveDeviceRules     := EXISTS(RiskIndicators(RiskId IN [PhoneFinder_Services.Constants.RiskRules.SimCardInfo, PhoneFinder_Services.Constants.RiskRules.DeviceInfo] and active));
		
		          BOOLEAN   ValidConsentInquiry   := LineIdentityConsentLevel = PhoneFinder_Services.Constants.ConsentLevels.FullConsumer OR (LineIdentityConsentLevel = PhoneFinder_Services.Constants.ConsentLevels.SingleConsumer  
					                                                                                                                       AND ActiveDeviceRules);		
		
	   	EXPORT BOOLEAN   UseZumigoIdentity	 := doxie.DataPermission.use_ZumigoIdentity AND TransactionType IN [PhoneFinder_Services.Constants.TransType.Ultimate,
		                                                                                                       PhoneFinder_Services.Constants.TransType.PHONERISKASSESSMENT] 
														                                                                                           AND BillingId <>'' AND ValidConsentInquiry;
   		       INTEGER   input_MaxOtherPhones	 := pfOptions.MaxOtherPhones : STORED('MaxOtherPhones'); // TO RESTRICT OTHER PHONES
   		EXPORT INTEGER   MaxOtherPhones	 := IF(input_MaxOtherPhones <> 0, input_MaxOtherPhones, PhoneFinder_Services.Constants.MaxOtherPhones);
   		                 UseInHousePhoneMetadata_internal	 := pfOptions.UseInHousePhoneMetadata: STORED('UseInHousePhoneMetadata');
   		EXPORT BOOLEAN   UseInHousePhoneMetadata	 := UseQSent AND UseInHousePhoneMetadata_internal;
			  EXPORT BOOLEAN   UseAccuData_CNAM        := UseInHousePhoneMetadata AND ~Doxie.DataRestriction.AccuData AND TransactionType IN [PhoneFinder_Services.Constants.TransType.Premium,
	                                                                                                  PhoneFinder_Services.Constants.TransType.Ultimate]; 
//*****************************		RE-DESIGN data source options **************************
    
    SHARED displayAll :=     TransactionType in [PhoneFinder_Services.Constants.TransType.PREMIUM,
																						PhoneFinder_Services.Constants.TransType.ULTIMATE,
																						PhoneFinder_Services.Constants.TransType.PHONERISKASSESSMENT];	
                                            
			 IncludePorting_internal              := pfOptions.IncludePorting: STORED('IncludePorting');
			 EXPORT BOOLEAN IncludePorting        := (IncludePhoneMetadata AND displayAll) OR IncludePorting_internal;
       
			 IncludeSpoofing_internal             := pfOptions.IncludeSpoofing: STORED('IncludeSpoofing');
			 EXPORT BOOLEAN IncludeSpoofing       := (IncludePhoneMetadata AND TransactionType IN [PhoneFinder_Services.Constants.TransType.ULTIMATE,
																																					       PhoneFinder_Services.Constants.TransType.PHONERISKASSESSMENT]) OR IncludeSpoofing_internal;
       
			 IncludeOTP_internal                  := pfOptions.IncludeOTP: STORED('IncludeOTP');
			 EXPORT BOOLEAN IncludeOTP            := (IncludePhoneMetadata AND displayAll) OR IncludeOTP_internal;
       
    
    SHARED IncludeRiskIndicators_internal        := pfOptions.IncludeRiskIndicators: STORED('IncludeRiskIndicators');
			 EXPORT BOOLEAN   IncludeRiskIndicators := ((IncludePhoneMetadata AND displayAll) OR IncludeRiskIndicators_internal);
       
    EXPORT BOOLEAN   IncludeOtherPhoneRiskIndicators				:= IncludeRiskIndicators_internal OR pfOptions.IncludeOtherPhoneRiskIndicators : STORED('IncludeOtherPhoneRiskIndicators');	
	  
   	UserRules							:= pfOptions.RiskIndicators : STORED('RiskIndicators');	
   	allRules := IF(IncludeRiskIndicators AND EXISTS(UserRules), PhoneFinder_Services.Constants.defaultRules + UserRules,
   										                                                           DATASET([],iesp.phonefinder.t_PhoneFinderRiskIndicator));
   	EXPORT DATASET(iesp.phonefinder.t_PhoneFinderRiskIndicator) RiskIndicators	:= IF(TransactionType = PhoneFinder_Services.Constants.TransType.PHONERISKASSESSMENT, 
   		                                                                                  UserRules, allRules);
   	
		  EXPORT BOOLEAN   IsGetMetaData                      := IncludePorting OR IncludeSpoofing OR IncludeOTP OR IncludeRiskIndicators; 
			        BOOLEAN   RealTimedata 			 		                := pfOptions.UseDeltabase : STORED('UseDeltabase');						 	
			 EXPORT BOOLEAN   UseDeltabase 					                 := IF(IsGetMetaData
			                                                          ,RealTimedata
																							                                        ,FALSE);		
		END;
			
			RETURN in_params;
		END;
 
 EXPORT AKParams :=
	  INTERFACE(BatchServices.Interfaces.i_AK_Config,ReportParams)
	END;
	
	
	
END;