import tools;
export _Constants(
	boolean	pUseOtherEnvironment	= false
) :=
tools.Constants(
	 pDatasetName					:= 'INFUTOR_NARE'
	,pUseOtherEnvironment	:= pUseOtherEnvironment
	,pGroupname						:= ''
	,pMaxRecordSize				:= 8192
	,pIsTesting						:= Tools._Constants.IsBocaProd
);
