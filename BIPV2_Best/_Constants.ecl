import tools;
export _Constants(

	boolean	pUseOtherEnvironment	= false

) :=
tools.Constants(

	 pDatasetName					:= 'BIPV2_Best'
	,pUseOtherEnvironment	:= pUseOtherEnvironment
	,pGroupname						:= ''
	,pMaxRecordSize				:= 4096
	,pIsTesting						:= Tools._Constants.IsDataland OR Tools._Constants.IsAlpha_dev
);