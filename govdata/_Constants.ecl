IMPORT Tools, STD;
EXPORT _Constants(

	BOOLEAN	pUseOtherEnvironment	= FALSE

) :=
Tools.Constants(

	 pDatasetName					:= 'IRS_Nonprofit'
	,pUseOtherEnvironment	:= pUseOtherEnvironment
	,pGroupname						:= ''
	,pMaxRecordSize				:= 4096
	,pIsTesting						:= Tools._Constants.IsDataland
);