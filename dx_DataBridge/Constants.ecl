﻿IMPORT Tools;
EXPORT Constants(
 
	BOOLEAN	pUseOtherEnvironment	= FALSE

) :=
Tools.Constants(

	 pDatasetName					:= 'DataBridge'
	,pUseOtherEnvironment	:= pUseOtherEnvironment
	,pGroupname						:= ''
	,pMaxRecordSize       := 4096
	,pIsTesting						:= Tools._Constants.IsDataland
);