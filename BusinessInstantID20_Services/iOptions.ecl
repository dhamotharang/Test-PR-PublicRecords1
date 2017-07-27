IMPORT Business_Risk_BIP;

EXPORT iOptions := INTERFACE(Business_Risk_BIP.LIB_Business_Shell_LIBIN)
	EXPORT BusinessInstantID20_Services.Types.productTypeEnum BIID20_productType := BusinessInstantID20_Services.Types.productTypeEnum.BASE;
	EXPORT BOOLEAN DisableIntermediateShellLogging := FALSE;
	EXPORT BOOLEAN useSBFE := FALSE;
END;