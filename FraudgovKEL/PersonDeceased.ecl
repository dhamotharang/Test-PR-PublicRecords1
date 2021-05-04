IMPORT FraudgovKEL, FraudGovPlatform,doxie,Suppress;

PersonDeceasedFile := FraudGovPlatform.files(,FraudgovKEL.Constants.useOtherEnvironmentDali).base.Death.built;
								
// Supress CCPA
mod_access := MODULE(doxie.IDataAccess) END; // default mod_access
Supress_CCPA := Suppress.MAC_SuppressSource(PersonDeceasedFile, mod_access, did_orig, NULL,TRUE);			
						
EXPORT PersonDeceased := Supress_CCPA;


