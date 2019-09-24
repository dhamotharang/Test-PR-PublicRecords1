IMPORT Tools, STD;
EXPORT _Constants(

	BOOLEAN	pUseOtherEnvironment	= FALSE

) :=
Tools.Constants(

	 pDatasetName					:= 'Database_USA'
	,pUseOtherEnvironment	:= pUseOtherEnvironment
	,pGroupname						:= ''
	,pMaxRecordSize				:= 4096
	,pIsTesting						:= Tools._Constants.IsDataland
);