IMPORT KELOtto, FraudGovPlatform;

RunKelDemo :=false:stored('RunKelDemo');

PersonFraudPointPrep := If(RunKelDemo=false,PULL(FraudGovPlatform.files(,KELOtto.Constants.useOtherEnvironmentDali).base.FraudPoint.built)
													,FraudGovPlatform.files(,KELOtto.Constants.useOtherEnvironmentDali).base.FraudPoint_Demo.built);

EXPORT PersonFraudPoint := PersonFraudPointPrep;
