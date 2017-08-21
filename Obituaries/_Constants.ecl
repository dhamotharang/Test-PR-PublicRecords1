import tools;
export _Constants(
	boolean	pUseOtherEnvironment	= false
) :=
tools.Constants(
	 pDatasetName					:= 'Tributes'
	,pUseOtherEnvironment	:= pUseOtherEnvironment
	,pGroupname						:= ''
	,pMaxRecordSize				:= 21000
	,pIsTesting						:= Tools._Constants.IsDataland
);
