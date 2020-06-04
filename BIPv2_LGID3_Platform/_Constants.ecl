import tools;
export _Constants(
	 boolean	pUseOtherEnvironment	= false
	,string		pDatasetname					= 'BIPV2_LGID3_PlatForm'
) := module(
	tools.Constants(
		 pDatasetName					:= pDatasetname
		,pUseOtherEnvironment	:= pUseOtherEnvironment
		,pGroupname						:= ''
		,pMaxRecordSize				:= 4096
		,pIsTesting						:= Tools._Constants.IsDataland
	))
	
end;
