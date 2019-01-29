IMPORT FraudGovPlatform;
EXPORT Constants := MODULE
	EXPORT useProdData := TRUE;
	EXPORT fileLocation := FraudGovPlatform._Dataset(useProdData).thor_cluster_Files;
END;