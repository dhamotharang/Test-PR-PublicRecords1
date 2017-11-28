IMPORT AutoHeaderI,AutoStandardI,BatchServices,iesp;

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
	END;

	EXPORT AKParams :=
	INTERFACE(BatchServices.Interfaces.i_AK_Config,ReportParams)
	END;
	
	
END;