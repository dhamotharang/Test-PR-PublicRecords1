IMPORT tools;
EXPORT _Dataset(BOOLEAN	pUseOtherEnvironment = FALSE) :=
	tools.Constants(pDatasetName				 := 'corp2',
                  pUseOtherEnvironment := pUseOtherEnvironment,
		              pGroupname					 := '',
		              pMaxRecordSize			 := 4096,
		              pIsTesting					 := Tools._Constants.IsDataland);