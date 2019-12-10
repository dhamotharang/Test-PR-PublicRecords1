IMPORT KELOtto, FraudGovPlatform,doxie,Suppress;

RunKelDemo :=false:stored('RunKelDemo');

PersonFraudPointPrep := If(RunKelDemo=false,PULL(FraudGovPlatform.files(,KELOtto.Constants.useOtherEnvironmentDali).base.FraudPoint.built)
													,FraudGovPlatform.files(,KELOtto.Constants.useOtherEnvironmentDali).base.FraudPoint_Demo.built);

// Supress CCPA
mod_access := MODULE(doxie.IDataAccess) END; // default mod_access
Supress_CCPA := Suppress.MAC_SuppressSource(PersonFraudPointPrep, mod_access, did, NULL,TRUE);	

EXPORT PersonFraudPoint := Supress_CCPA;
