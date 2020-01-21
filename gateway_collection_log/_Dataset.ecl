IMPORT tools;

EXPORT _Dataset(BOOLEAN	pUseOtherEnvironment = FALSE) :=
	tools.Constants(pDatasetName				 := 'GatewayCollectionLogs',
                  pUseOtherEnvironment := pUseOtherEnvironment,
		              pGroupname					 := '36',
		              pMaxRecordSize			 := 4096,
		              pIsTesting					 := Tools._Constants.IsDataland);