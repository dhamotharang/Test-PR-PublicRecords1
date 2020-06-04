IMPORT KELOtto, FraudGovPlatform,doxie,Suppress;
RunKelDemo :=false:stored('RunKelDemo');

PersonDeceasedFile := If(RunKelDemo=false,FraudGovPlatform.files(,KELOtto.Constants.useOtherEnvironmentDali).base.Death.built
												,FraudGovPlatform.files(,KELOtto.Constants.useOtherEnvironmentDali).base.Death_Demo.built);
								
// Supress CCPA
mod_access := MODULE(doxie.IDataAccess) END; // default mod_access
Supress_CCPA := Suppress.MAC_SuppressSource(PersonDeceasedFile, mod_access, did_orig, NULL,TRUE);			
						
EXPORT PersonDeceased := Supress_CCPA;


