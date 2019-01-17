IMPORT FraudGovPlatform, Tools;
EXPORT Constants := MODULE
	EXPORT useProdData := TRUE;
	isProd := TRUE;	//~Tools._Constants.IsDataland; For some reason I can't get this to work in Dataland environment, so manually set this to FALSE in Dataland
	useOtherEnvironmentDali(BOOLEAN useProdData) := NOT((isProd AND useProdData) OR (~isProd AND ~useProdData));
	EXPORT fileLocation := FraudGovPlatform._Dataset(useOtherEnvironmentDali(useProdData)).thor_cluster_Files;
END;