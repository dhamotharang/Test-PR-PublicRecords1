import tools;
export _Constants(
	 boolean	pUseOtherEnvironment	= false
) :=
tools.Constants(
	 pDatasetName					:= 'tin_matching'
	,pUseOtherEnvironment	:= pUseOtherEnvironment
	,pGroupname						:= ''
	,pMaxRecordSize				:= 4096
	,pIsTesting						:= Tools._Constants.IsDataland
	,pAutokey_Skipset			:= ['P', 'S','C', 'F']
	,pAutokey_typestr			:= 'BC'
);
