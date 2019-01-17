IMPORT AutoStandardI, BIPV2, Business_Risk_BIP, Gateway, iesp, LNSmallBusiness, Suppress;

// The variables defined below match AutoStandardI.GlobalModule default values 
//   -- because iesp.ECL2ESP.SetInputBaseRequest is called at the service level
//      and all variables availble are referenced from the global_mod.  Any
//      variable defaulted with a different value here would never be used because 
//      the defaults from the global_mod will always take precedence.
EXPORT IParam := 
  MODULE
    EXPORT LNSmallBiz_BIP_CombinedReport_IParams := 
      INTERFACE
        EXPORT DATASET(LNSmallBusiness.BIP_Layouts.Input) ds_SBA_Input;
        EXPORT STRING	   DataPermissionMask	 := Business_Risk_BIP.Constants.Default_DataPermissionMask;
        EXPORT STRING	   DataRestrictionMask := Business_Risk_BIP.Constants.Default_DataRestrictionMask;
        EXPORT STRING6   DOBMask             := Suppress.Constants.DATE_MASK_TYPE.NONE;
        EXPORT STRING6   SSNMask             := Suppress.Constants.SSN_MASK_TYPE.NONE;
        EXPORT UNSIGNED1 DPPAPurpose				 := Business_Risk_BIP.Constants.Default_DPPA;
        EXPORT UNSIGNED1 GLBAPurpose				 := AutoStandardI.Constants.GLBPurpose_default;
        EXPORT BOOLEAN   allowall            := FALSE;
        EXPORT BOOLEAN   allowdppa           := FALSE;
        EXPORT BOOLEAN   allowglb            := FALSE;
        EXPORT UNSIGNED1 glbpurpose          := AutoStandardI.Constants.GLBPurpose_default;
        EXPORT BOOLEAN   ignorefares         := FALSE;
        EXPORT BOOLEAN   ignorefidelity      := FALSE;
        EXPORT BOOLEAN   includeminors       := FALSE;
        EXPORT BOOLEAN   lnbranded           := FALSE;
       
        EXPORT STRING32  ApplicationType     := Suppress.Constants.ApplicationTypes.DEFAULT;
        EXPORT STRING5	 IndustryClass			 := Business_Risk_BIP.Constants.Default_IndustryClass;
        EXPORT UNSIGNED1 LinkSearchLevel		 := Business_Risk_BIP.Constants.LinkSearch.DEFAULT;
        EXPORT UNSIGNED1 MarketingMode			 := Business_Risk_BIP.Constants.Default_MarketingMode;
        EXPORT STRING50	 AllowedSources			 := Business_Risk_BIP.Constants.Default_AllowedSources;
        EXPORT UNSIGNED1 OFAC_Version				 := Business_Risk_BIP.Constants.Default_OFAC_Version;
        EXPORT REAL			 Global_Watchlist_Threshold := Business_Risk_BIP.Constants.Default_Global_Watchlist_Threshold;
        EXPORT DATASET(iesp.Share.t_StringArrayItem) Watchlists_Requested := Business_Risk_BIP.Constants.Default_Watchlists_Requested;
        EXPORT DATASET(Gateway.Layouts.Config) Gateways := Business_Risk_BIP.Constants.Default_Gateways_Requested;
        EXPORT DATASET(LNSmallBusiness.Layouts.AttributeGroupRec) AttributesRequested := DATASET([], LNSmallBusiness.Layouts.AttributeGroupRec);
        EXPORT DATASET(LNSmallBusiness.Layouts.ModelNameRec) ModelsRequested := DATASET([], LNSmallBusiness.Layouts.ModelNameRec);
        EXPORT DATASET(LNSmallBusiness.Layouts.ModelOptionsRec) ModelOptions := DATASET([], LNSmallBusiness.Layouts.ModelOptionsRec);
        EXPORT BOOLEAN  DisableIntermediateShellLogging := FALSE;
        EXPORT BOOLEAN  IncludeTargusGateway            := FALSE;
        EXPORT BOOLEAN  RunTargusGateway                := FALSE;
        EXPORT BOOLEAN  TestDataEnabled			            := FALSE;
	      EXPORT STRING   TestDataTableName	              := '';
        EXPORT STRING1  FetchLevel 						          := BIPV2.IDconstants.Fetch_Level_SELEID;
        EXPORT BOOLEAN  IncludeCreditReport             := FALSE; 
	   EXPORT BOOLEAN  LimitPaymentHistory24Months                   := FALSE; 
	  EXPORT STRING       SBFEContributorIds         :=  ''; 
        EXPORT BOOLEAN  MinInputMetForAuthRepPopulated  := FALSE; 
				EXPORT BOOLEAN UseInputDataAsIs                 := FALSE;
	    END;

  END;