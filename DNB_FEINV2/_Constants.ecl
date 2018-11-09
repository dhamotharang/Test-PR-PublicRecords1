import tools;
export _Constants(

	 boolean	pUseOtherEnvironment	= false
	,string		pDatasetName					= 'DNB_FEIN'

) :=
tools.Constants(

	 pDatasetName					:= pDatasetName
	,pUseOtherEnvironment	:= pUseOtherEnvironment
	,pGroupname						:= ''
	,pMaxRecordSize		:= 4096
	,pIsTesting						:= Tools._Constants.IsDataland
);