import tools;
export Constants(
  boolean pUseOtherEnvironment  = false
) :=
tools.Constants(
  pDatasetName          := 'Cortera'
  ,pUseOtherEnvironment := pUseOtherEnvironment
  ,pGroupname           := ''
  ,pMaxRecordSize       := 4096
  ,pIsTesting           := tools._Constants.IsDataland
);
