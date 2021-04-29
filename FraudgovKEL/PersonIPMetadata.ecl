IMPORT FraudgovKEL, FraudGovPlatform,doxie,Suppress;

PersonIPMetadataPrep1 :=  FraudGovPlatform.files(,FraudgovKEL.Constants.useOtherEnvironmentDali).base.IPMetaData.built;

PersonIPMetadataPrep2 := PROJECT(PersonIPMetadataPrep1, TRANSFORM(RECORDOF(LEFT), SELF.edgecountry := MAP(LEFT.edgecountry = '' => '0', LEFT.edgecountry), SELF := LEFT));

//Set_ip_address_:=['171.2.75.6','195.92.48.70','9.105.72.130','11.186.75.150','143.60.137.122','170.141.177.75','48.128.243.249','23.227.207.19','251.110.91.211','23.105.131.251','174.127.99.171'];
//PersonIPMetadataPrep := PROJECT(PersonIPMetadataPrep1, TRANSFORM(RECORDOF(LEFT), SELF.edgecity := 'MIAMI', SELf.proxydescription := CHOOSE(LEFT.did % 3 + 1, 'TOR EXIT','TOR RELAY','VPN'), SELF.proxytype := 'HOSTING', SELF := LEFT));

// Supress CCPA
mod_access := MODULE(doxie.IDataAccess) END; // default mod_access
Supress_CCPA := Suppress.MAC_SuppressSource(PersonIPMetadataPrep2, mod_access, did, NULL,TRUE);	

EXPORT PersonIPMetadata := Supress_CCPA;



 
