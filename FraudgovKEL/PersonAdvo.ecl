IMPORT FraudgovKEL, FraudGovPlatform,doxie,suppress;

/*
FileIn := If(RunKelDemo=false,FraudGovPlatform.files(,False).base.Advo.built
									,FraudGovPlatform.files(,False).base.Advo_Demo.built); 
*/
FileIn := FraudGovPlatform.files(,FraudgovKEL.Constants.useOtherEnvironmentDali).base.Advo.built; 
									
// Supress CCPA
mod_access := MODULE(doxie.IDataAccess) END; // default mod_access
Supress_CCPA := Suppress.MAC_SuppressSource(FileIn, mod_access, did, NULL,TRUE);										

EXPORT PersonAdvo := Supress_CCPA;