IMPORT tools, STD;
EXPORT _Constants(
	BOOLEAN	pUseOtherEnvironment	= FALSE
) :=
tools.Constants(
	 pDatasetName					:= 'Anchor'
	,pUseOtherEnvironment	:= pUseOtherEnvironment
	,pGroupname						:= STD.System.Thorlib.Group ( )
	,pMaxRecordSize				:= 8192
	,pIsTesting						:= Tools._Constants.IsDataland
);