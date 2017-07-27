import tools;
export _Constants(

	 boolean	pUseOtherEnvironment	= false
	,string		pDatasetname					= 'Sheila_Greco'

) := module(
	tools.Constants(
		 pDatasetName					:= pDatasetname
		,pUseOtherEnvironment	:= pUseOtherEnvironment
		,pGroupname						:= '20'
		,pMaxRecordSize				:= 80000
		,pIsTesting						:= Tools._Constants.IsDataland
	))
	
end;
