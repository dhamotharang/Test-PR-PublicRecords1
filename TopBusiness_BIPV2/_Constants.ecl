import tools;

export _Constants(boolean	pUseOtherEnvironment	= false) :=

  tools.Constants(
	  pDatasetName					:= 'BIPV2'
	 ,pUseOtherEnvironment	:= pUseOtherEnvironment
	 ,pGroupname						:= ''
	 ,pMaxRecordSize				:= 4096
	 ,pIsTesting						:= Tools._Constants.IsDataland
  );