import tools;
export _Constants(
	boolean	pUseOtherEnvironment	= false
) :=
tools.Constants(
	 pDatasetName					:= 'Infutor'
	,pUseOtherEnvironment	:= pUseOtherEnvironment
	,pGroupname						:= ''
	,pMaxRecordSize				:= 8192
	,pIsTesting						:= Tools._Constants.IsDataland
);