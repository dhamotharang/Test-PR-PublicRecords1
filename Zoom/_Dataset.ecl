import tools;
export _Dataset(

	boolean	pUseOtherEnvironment	= false

) :=  INLINE MODULE (
tools.Constants(

	 pDatasetName					:= 'Zoom'
	,pUseOtherEnvironment	:= pUseOtherEnvironment
	,pGroupname						:= ''
	,pMaxRecordSize				:= 4096
	,pIsTesting						:= Tools._Constants.IsDataland
))

END;