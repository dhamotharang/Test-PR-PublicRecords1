IMPORT Business_Risk_BIP, LNSmallBusiness;

EXPORT iOptions := INTERFACE(Business_Risk_BIP.LIB_Business_Shell_LIBIN)
	EXPORT BusinessInstantID20_Services.Types.productTypeEnum BIID20_productType := BusinessInstantID20_Services.Types.productTypeEnum.BASE;
	EXPORT BOOLEAN DisableIntermediateShellLogging := FALSE;
	EXPORT BOOLEAN useSBFE := FALSE;
	EXPORT DATASET(LNSmallBusiness.Layouts.AttributeGroupRec) AttributesRequested := DATASET([], LNSmallBusiness.Layouts.AttributeGroupRec);
	EXPORT DATASET(LNSmallBusiness.Layouts.ModelNameRec) ModelsRequested := DATASET([], LNSmallBusiness.Layouts.ModelNameRec);
	EXPORT DATASET(LNSmallBusiness.Layouts.ModelOptionsRec) ModelOptions := DATASET([], LNSmallBusiness.Layouts.ModelOptionsRec);
END;