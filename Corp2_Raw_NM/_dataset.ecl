IMPORT tools;

EXPORT _Dataset(BOOLEAN	pUseOtherEnvironment = TRUE) :=
	tools.Constants(pDatasetName				 := 'corp2',
                  pUseOtherEnvironment := pUseOtherEnvironment,
		              pGroupname					 := '',
		              pMaxRecordSize			 := 4096,
		              pIsTesting					 := Tools._Constants.IsDataland);