
IMPORT Tools,VersionControl;
EXPORT _Dataset(BOOLEAN	pUseOtherEnvironment = FALSE) :=
	tools.Constants(pDatasetName				 := 'infutor_narc3',
									pUseOtherEnvironment := pUseOtherEnvironment,
									pGroupname					 := '02',
									pMaxRecordSize			 := 40000,
									pIsTesting					 := Tools._Constants.IsDataland,
									pAdd_Eclcc           := true);