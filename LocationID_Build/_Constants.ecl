import tools;
export _Constants(

	 boolean	pUseOtherEnvironment	= false
	,string		pDatasetname					= 'LocationID_Build'

) := module(
	tools.Constants(
		 pDatasetName					    := pDatasetname
		,pUseOtherEnvironment	:= pUseOtherEnvironment
		,pGroupname						     := '44' //use thor400_60 by default for the BIP build
		,pMaxRecordSize				   := 4096
		,pIsTesting						     := Tools._Constants.IsDataland
	))
	
end;
