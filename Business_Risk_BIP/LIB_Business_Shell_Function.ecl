﻿IMPORT _Control, Business_Risk_BIP, Cortera, Gateway, iesp, STD, LNSmallBusiness;


Use_Business_Shell_Library := NOT _Control.LibraryUse.ForceOff_Business_Risk_BIP__LIB_Business_Shell;

EXPORT LIB_Business_Shell_Function (
                                    DATASET(Business_Risk_BIP.Layouts.Input) Input,
                                    UNSIGNED1	DPPA_Purpose_In	= Business_Risk_BIP.Constants.Default_DPPA,
                                    UNSIGNED1	GLBA_Purpose_In	= Business_Risk_BIP.Constants.Default_GLBA,
                                    STRING50	DataRestrictionMask_In = Business_Risk_BIP.Constants.Default_DataRestrictionMask,
                                    STRING50	DataPermissionMask_In = Business_Risk_BIP.Constants.Default_DataPermissionMask,
                                    STRING10	IndustryClass_In = Business_Risk_BIP.Constants.Default_IndustryClass,
                                    UNSIGNED1	LinkSearchLevel_In = Business_Risk_BIP.Constants.LinkSearch.Default,
                                    UNSIGNED1	BusShellVersion_In = Business_Risk_BIP.Constants.Default_BusShellVersion,
                                    UNSIGNED1	MarketingMode_In = Business_Risk_BIP.Constants.Default_MarketingMode,
                                    STRING50	AllowedSources_In = Business_Risk_BIP.Constants.Default_AllowedSources,
                                    UNSIGNED1   BIPBestAppend_In = Business_Risk_BIP.Constants.BIPBestAppend.Default,
                                    UNSIGNED1	OFAC_Version_In	= Business_Risk_BIP.Constants.Default_OFAC_Version,
                                    REAL		Global_Watchlist_Threshold_In = Business_Risk_BIP.Constants.Default_Global_Watchlist_Threshold,
                                    DATASET(iesp.Share.t_StringArrayItem) Watchlists_Requested_In = Business_Risk_BIP.Constants.Default_Watchlists_Requested,
                                    UNSIGNED1 KeepLargeBusinesses_In = Business_Risk_BIP.Constants.DefaultJoinType,
                                    BOOLEAN IncludeTargusGateway_In = FALSE,
                                    DATASET(Gateway.Layouts.Config) Gateways_in = Business_Risk_BIP.Constants.Default_Gateways_Requested,
                                    BOOLEAN RunTargusGateway  = FALSE,
                                    BOOLEAN OverrideExperianRestriction_In = FALSE,
                                    BOOLEAN IncludeAuthRepInBIPAppend = FALSE,
                                    BOOLEAN IsBIID20_In	= FALSE,
                                    BOOLEAN CorteraRetrotest_In = FALSE,
                                    DATASET(Cortera.layout_Retrotest_raw) ds_CorteraRetrotestRecsRaw = DATASET([],Cortera.layout_Retrotest_raw),
                                    UNSIGNED1 LexIdSourceOptout = 1,
                                    STRING TransactionID = '',
                                    STRING BatchUID = '',
                                    UNSIGNED6 GlobalCompanyId = 0,
                                    BOOLEAN in_useUpdatedBipAppend = TRUE,
                                    UNSIGNED1 in_BIPAppend_ScoreThreshold = Business_Risk_BIP.Constants.Default_BIPAppend_ScoreThreshold,
                                    UNSIGNED1 in_BipAppend_WeightThreshold = Business_Risk_BIP.Constants.Default_BipAppend_WeightThreshold,
                                    DATASET(LNSmallBusiness.Layouts.ModelNameRec) ds_ModelsRequested = Dataset([],LNSmallBusiness.Layouts.ModelNameRec)
                                    ) := FUNCTION

options := MODULE(Business_Risk_BIP.LIB_Business_Shell_LIBIN)
	// Clean up the Options and make sure that defaults are enforced
	EXPORT UNSIGNED1	dppa 				:= DPPA_Purpose_In;
	EXPORT UNSIGNED1	glb 				:= GLBA_Purpose_In;
	EXPORT STRING			DataRestrictionMask	:= IF(DataRestrictionMask_In = '',
																							Business_Risk_BIP.Constants.Default_DataRestrictionMask,
																							DataRestrictionMask_In);
	EXPORT STRING			DataPermissionMask	:= IF(DataPermissionMask_In = '',
																							Business_Risk_BIP.Constants.Default_DataPermissionMask,
																							DataPermissionMask_In);
	EXPORT STRING5		industry_class			:= IndustryClass_In;

	EXPORT UNSIGNED1	LinkSearchLevel			:= IF(LinkSearchLevel_In BETWEEN Business_Risk_BIP.Constants.LinkSearch.Default AND Business_Risk_BIP.Constants.LinkSearch.UltID,
																							LinkSearchLevel_In,
																							Business_Risk_BIP.Constants.LinkSearch.Default);
	EXPORT UNSIGNED1	BusShellVersion			:= IF(BusShellVersion_In > 0,
																							BusShellVersion_In,
																							Business_Risk_BIP.Constants.Default_BusShellVersion);
	EXPORT UNSIGNED1	MarketingMode				:= MAX(MIN(MarketingMode_In, 1), 0);
	EXPORT STRING50		AllowedSources			:= STD.Str.ToUpperCase(AllowedSources_In);
	EXPORT UNSIGNED1	BIPBestAppend				:= IF(BIPBestAppend_In BETWEEN Business_Risk_BIP.Constants.BIPBestAppend.Default AND Business_Risk_BIP.Constants.BIPBestAppend.OverwriteWithBest,
																							BIPBestAppend_In,
																							Business_Risk_BIP.Constants.BIPBestAppend.Default);
	EXPORT UNSIGNED1	OFAC_Version				:= MAX(MIN(OFAC_Version_In, Business_Risk_BIP.Constants.MAX_OFAC_VERSION), 0);
	EXPORT REAL				Global_Watchlist_Threshold	:= MAX(MIN(Global_Watchlist_Threshold_In, 1), 0);
	EXPORT UNSIGNED1	KeepLargeBusinesses	:= MAX(MIN(KeepLargeBusinesses_In, 1), 0);
	EXPORT BOOLEAN    IncludeTargusGateway := IncludeTargusGateway_In;
	EXPORT DATASET(iesp.Share.t_StringArrayItem) Watchlists_Requested := Watchlists_Requested_In;
	EXPORT DATASET(Gateway.Layouts.Config) Gateways := Gateways_in;
	EXPORT BOOLEAN    RunTargusGatewayAnywayForTesting := RunTargusGateway;
	EXPORT BOOLEAN    OverrideExperianRestriction := OverrideExperianRestriction_In;
	EXPORT BOOLEAN    DoNotUseAuthRepInBIPAppend  := NOT IncludeAuthRepInBIPAppend;
	EXPORT BOOLEAN		IsBIID20										:= IsBIID20_In;
	EXPORT BOOLEAN    CorteraRetrotest            := CorteraRetrotest_In;
	EXPORT BOOLEAN    UseUpdatedBipAppend := in_useUpdatedBipAppend;
	EXPORT unsigned1  lexid_source_optout := LexIdSourceOptout;
	EXPORT string     transaction_id := IF(TransactionID <> '', TransactionID, BatchUID);
	EXPORT unsigned6  global_company_id := GlobalCompanyId;
	EXPORT UNSIGNED1  BIPAppend_ScoreThreshold := in_BIPAppend_ScoreThreshold;
	EXPORT UNSIGNED1  BipAppend_WeightThreshold := in_BipAppend_WeightThreshold;
  EXPORT DATASET(LNSmallBusiness.Layouts.ModelNameRec) ModelsRequested := ds_ModelsRequested;
END;

#if(Use_Business_Shell_Library)
	Business_Shell_Results := LIBRARY('Business_Risk_BIP.LIB_Business_Shell', Business_Risk_BIP.LIB_Business_Shell_Interface(Input, options)).Results;
#else
	Business_Shell_Results := Business_Risk_BIP.Business_Shell_Function(Input, options, ds_CorteraRetrotestRecsRaw);
#end

	RETURN(Business_Shell_Results);
END;
