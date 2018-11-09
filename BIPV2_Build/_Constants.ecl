import tools;
export _Constants(

	 boolean	pUseOtherEnvironment	= false
	,string		pDatasetname					= 'BIPV2_Build'

) := module(
	tools.Constants(
		 pDatasetName					:= pDatasetname
		,pUseOtherEnvironment	:= pUseOtherEnvironment
		,pGroupname						:= '36' //use thor400_36 by default for the BIP build
		,pMaxRecordSize				:= 4096
		,pIsTesting						:= Tools._Constants.IsDataland
    ,pAdd_Eclcc           := true
	))
	
end;
