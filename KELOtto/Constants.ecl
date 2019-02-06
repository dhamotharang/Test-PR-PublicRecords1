IMPORT FraudGovPlatform, Tools;
EXPORT Constants := MODULE
	useProdData := TRUE;
	isProd := ~Tools._Constants.IsDataland; 
	EXPORT useOtherEnvironmentDali := NOT((isProd AND useProdData) OR (~isProd AND ~useProdData));
	EXPORT fileLocation := FraudGovPlatform._Dataset(useOtherEnvironmentDali).thor_cluster_Files;
END;