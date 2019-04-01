IMPORT KELOtto, FraudGovPlatform;

PersonFraudPointPrep := PULL(FraudGovPlatform.files(,KELOtto.Constants.useOtherEnvironmentDali).base.FraudPoint.built);

EXPORT PersonFraudPoint := PersonFraudPointPrep;
