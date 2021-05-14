IMPORT Tools;
EXPORT _Constants(BOOLEAN	pUseOtherEnvironment	= FALSE) :=
  tools.Constants(pDatasetName           := 'OneKey'
                 ,pUseOtherEnvironment   := pUseOtherEnvironment
                 ,pGroupname             := ''
                 ,pMaxRecordSize         := 4096
                 ,pIsTesting             := Tools._Constants.IsDataland
                 ,pAutokey_Skipset       := []
                 ,pAutokey_typestr       := ''
                 ,pAdd_Eclcc             := TRUE);