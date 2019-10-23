//	Needed in file_liens_fcra_main
IMPORT tools;

EXPORT _Dataset(BOOLEAN	pUseOtherEnvironment = FALSE) :=
	tools.Constants(pDatasetName				 := 'liensv2',
                  pUseOtherEnvironment := pUseOtherEnvironment,
		              pGroupname					 := '60',
		              pMaxRecordSize			 := 4096,
		              pIsTesting					 := Tools._Constants.IsDataland);