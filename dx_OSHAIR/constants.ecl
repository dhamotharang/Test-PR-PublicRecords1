IMPORT tools;
EXPORT constants(

 BOOLEAN pUseOtherEnvironment = FALSE

) :=
tools.Constants(

  pDatasetName         := 'oshair'
 ,pUseOtherEnvironment := pUseOtherEnvironment
 ,pGroupname           := ''
 ,pMaxRecordSize       := 4096
 ,pIsTesting           := Tools._Constants.IsDataland
);
