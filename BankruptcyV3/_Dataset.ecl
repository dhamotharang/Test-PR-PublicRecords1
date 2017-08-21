IMPORT tools;

EXPORT _Dataset(BOOLEAN	pUseOtherEnvironment = FALSE) :=
	tools.Constants(pDatasetName				 := 'bankruptcyv3',
                  pUseOtherEnvironment := pUseOtherEnvironment,
		              pGroupname					 := '44',
		              pMaxRecordSize			 := 4096,
		              pIsTesting					 := Tools._Constants.IsDataland);