IMPORT tools;

EXPORT _Constants(
	 STRING		state = 'state',
	 BOOLEAN	pUseOtherEnvironment	= FALSE
) :=
tools.Constants(
	 pDatasetName					:= state + '_deathm_raw',
	 pUseOtherEnvironment	:= pUseOtherEnvironment,
	 pGroupname						:= '',
	 pMaxRecordSize				:= 8192,
	 pIsTesting						:= Tools._Constants.IsDataland
);
