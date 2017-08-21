import tools;
export _Constants(

	 boolean	pUseOtherEnvironment	= false
	,string		pDatasetname					= 'Business_Header'

) := module(
	tools.Constants(
		 pDatasetName					:= pDatasetname
		,pUseOtherEnvironment	:= pUseOtherEnvironment
		,pGroupname						:= ''
		,pMaxRecordSize				:= 4096 * 9
		,pIsTesting						:= Tools._Constants.IsDataland
		,pAutokey_Skipset			:= ['C','P','Q','F']
		,pAutokey_typestr			:= 'AK'
	))
end;