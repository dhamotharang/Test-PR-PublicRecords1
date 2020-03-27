IMPORT Drivers, Header, MDR, ProfileBooster.ProfileBoosterV2_KEL, UT;

EXPORT Fn_Append_DPMBitmap(InputDataset, Source_Column = '\'\'', Is_A_FCRA_File = FALSE, GLBA_Restriction_Rules = 'FALSE', Pre_GLB_Restriction_Rules = 'FALSE', DPPA_Restriction_Rules = 'FALSE', DPPA_State = '\'\'', KELPermissions = ProfileBoosterV2_KEL.CFG_Compile, Generic_Restriction_Rules = 'FALSE', Not_Restricted_Rules = 'FALSE', Insurance_Product_Restricted = 'FALSE', BIP_Bit_Mask = 0, watchdogPermissionsColumn = 0) := FUNCTIONMACRO
	appended := PROJECT(InputDataset, TRANSFORM({RECORDOF(LEFT), UNSIGNED8 DPMBitmap},
		SELF.DPMBitmap := ProfileBoosterV2_KEL.ECL_Functions.Fn_KEL_DPMBitmap.SetValue(#EXPAND(Source_Column), Is_A_FCRA_File, #EXPAND(GLBA_Restriction_Rules), #EXPAND(Pre_GLB_Restriction_Rules), #EXPAND(DPPA_Restriction_Rules), #EXPAND(DPPA_State), #EXPAND(Generic_Restriction_Rules), #EXPAND(Not_Restricted_Rules), #EXPAND(Insurance_Product_Restricted), #EXPAND(watchdogPermissionsColumn), KELPermissions, #EXPAND(BIP_Bit_Mask));
		SELF := LEFT));
	
	RETURN(appended);
ENDMACRO;