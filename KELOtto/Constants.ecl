IMPORT FraudGovPlatform, Tools;
EXPORT Constants := MODULE
	EXPORT useProdData := TRUE;
	isProd := ~Tools._Constants.IsDataland; 
	useOtherEnvironmentDali(BOOLEAN useProdData) := NOT((isProd AND useProdData) OR (~isProd AND ~useProdData));
	EXPORT fileLocation := FraudGovPlatform._Dataset(useOtherEnvironmentDali(useProdData)).thor_cluster_Files;
END;