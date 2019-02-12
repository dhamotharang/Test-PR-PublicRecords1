IMPORT KELOtto, FraudGovPlatform;

EXPORT PersonFraudPointPrep := PULL(FraudGovPlatform.files(,KELOtto.Constants.useOtherEnvironmentDali).base.FraudPoint.built);

EXPORT PersonFraudPoint := JOIN(KELOtto.CustomerLexId, PersonFraudPointPrep, LEFT.did=(INTEGER)RIGHT.did, TRANSFORM({LEFT.AssociatedCustomerFileInfo, RECORDOF(RIGHT)}, SELF := RIGHT, SELF := LEFT), HASH, KEEP(1));
