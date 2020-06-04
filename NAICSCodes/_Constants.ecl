IMPORT Tools;
EXPORT _Constants(

	BOOLEAN	pUseOtherEnvironment	= FALSE

) :=
Tools.Constants(

	 pDatasetName					:= 'NAICSCodes'
	,pUseOtherEnvironment	:= pUseOtherEnvironment
	,pGroupname						:= ''
	,pMaxRecordSize				:= 4096
	,pIsTesting						:= Tools._Constants.IsDataland
);
