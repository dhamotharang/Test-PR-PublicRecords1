IMPORT tools;

EXPORT _Dataset(BOOLEAN	pUseOtherEnvironment = FALSE) :=
	tools.Constants(pDatasetName				 := 'sbfe',
                  pUseOtherEnvironment := pUseOtherEnvironment,
		              pGroupname					 := '66',
		              pMaxRecordSize			 := 4096,
		              pIsTesting					 := Tools._Constants.IsDataland);