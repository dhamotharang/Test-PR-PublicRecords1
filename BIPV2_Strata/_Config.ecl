import tools,bipv2_build;
export _Config(
	 boolean	pUseOtherEnvironment	= false
	,string		pDatasetname					= 'strata::bipv2'
) := module(
	tools.Constants(
		 pDatasetName					:= pDatasetname
		,pUseOtherEnvironment	:= pUseOtherEnvironment
		,pGroupname						:= ''
		,pMaxRecordSize				:= 4096
		,pIsTesting						:= Tools._Constants.IsDataland
	))
	  
end;
