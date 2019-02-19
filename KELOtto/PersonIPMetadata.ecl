IMPORT KELOtto, FraudGovPlatform;

PersonIPMetadataPrep1 := FraudGovPlatform.files(,KELOtto.Constants.useOtherEnvironmentDali).base.IPMetaData.built;

//Set_ip_address_:=['171.2.75.6','195.92.48.70','9.105.72.130','11.186.75.150','143.60.137.122','170.141.177.75','48.128.243.249','23.227.207.19','251.110.91.211','23.105.131.251','174.127.99.171'];
//PersonIPMetadataPrep := PROJECT(PersonIPMetadataPrep1, TRANSFORM(RECORDOF(LEFT), SELF.edgecity := 'MIAMI', SELf.proxydescription := CHOOSE(LEFT.did % 3 + 1, 'TOR EXIT','TOR RELAY','VPN'), SELF.proxytype := 'HOSTING', SELF := LEFT));

EXPORT PersonIPMetadata := PersonIPMetadataPrep1;


 
