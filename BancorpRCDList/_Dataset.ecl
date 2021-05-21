IMPORT tools;

EXPORT _Dataset(BOOLEAN	pUseOtherEnvironment = FALSE) :=
	tools.Constants(pDatasetName				 := 'BancorpRCDList',
                  pUseOtherEnvironment := pUseOtherEnvironment,
		              pGroupname					 := thorlib.group(),
		              pMaxRecordSize			 := 4096,
		              pIsTesting					 := Tools._Constants.IsDataland);