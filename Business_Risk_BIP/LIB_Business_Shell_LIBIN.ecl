﻿IMPORT Business_Risk_BIP, Gateway, iesp;

// NOTE: If you change this you MUST redeploy the Library as the interface has changed.
EXPORT LIB_Business_Shell_LIBIN := INTERFACE
	EXPORT UNSIGNED1	DPPA_Purpose 																		:= Business_Risk_BIP.Constants.Default_DPPA;
	EXPORT UNSIGNED1	GLBA_Purpose 																		:= Business_Risk_BIP.Constants.Default_GLBA;
	EXPORT STRING50		DataRestrictionMask															:= Business_Risk_BIP.Constants.Default_DataRestrictionMask;
	EXPORT STRING50		DataPermissionMask															:= Business_Risk_BIP.Constants.Default_DataPermissionMask;
	EXPORT STRING10		IndustryClass																		:= Business_Risk_BIP.Constants.Default_IndustryClass;
	EXPORT UNSIGNED1	LinkSearchLevel																	:= Business_Risk_BIP.Constants.LinkSearch.Default;
	EXPORT UNSIGNED1	BusShellVersion																	:= Business_Risk_BIP.Constants.Default_BusShellVersion;
	EXPORT UNSIGNED1	MarketingMode																		:= Business_Risk_BIP.Constants.Default_MarketingMode;
	EXPORT STRING50		AllowedSources																	:= Business_Risk_BIP.Constants.Default_AllowedSources;
	EXPORT UNSIGNED1	BIPBestAppend																		:= Business_Risk_BIP.Constants.BIPBestAppend.Default;
	EXPORT UNSIGNED1	OFAC_Version																		:= Business_Risk_BIP.Constants.Default_OFAC_Version;
	EXPORT UNSIGNED1	KeepLargeBusinesses 														:= Business_Risk_BIP.Constants.DefaultJoinType;
	EXPORT REAL				Global_Watchlist_Threshold 											:= Business_Risk_BIP.Constants.Default_Global_Watchlist_Threshold;
	EXPORT BOOLEAN    IncludeTargusGateway       											:= FALSE;
	EXPORT DATASET(Gateway.Layouts.Config) Gateways 									:= Business_Risk_BIP.Constants.Default_Gateways_Requested;
	EXPORT DATASET(iesp.Share.t_StringArrayItem) Watchlists_Requested := Business_Risk_BIP.Constants.Default_Watchlists_Requested;
	EXPORT BOOLEAN    RunTargusGatewayAnywayForTesting 								:= FALSE;
	EXPORT BOOLEAN		OverrideExperianRestriction 										:= FALSE;
	EXPORT BOOLEAN 		include_ofac 																		:= TRUE;
	EXPORT BOOLEAN 		include_additional_watchlists 									:= FALSE;
	EXPORT BOOLEAN    DoNotUseAuthRepInBIPAppend 											:= FALSE;
  EXPORT BOOLEAN    CorteraRetrotest                                := FALSE;
	EXPORT BOOLEAN		IsBIID20																				:= FALSE;	
	// CCPA parameters
	export unsigned1 bus_LexIdSourceOptout := 1;
	export string16 bus_TransactionID := '';
	export string16 bus_BatchUID := '';
	export unsigned6 bus_GlobalCompanyId := 0;
	EXPORT BOOLEAN    BIPAppend_AllowInvalidResults                   := FALSE;
  EXPORT UNSIGNED1  BIPAppend_ScoreThreshold                        := 75;
	EXPORT UNSIGNED1  BipAppend_WeightThreshold                       := 44;
	EXPORT BOOLEAN    BIPAppend_primForce                             := FALSE;

END;