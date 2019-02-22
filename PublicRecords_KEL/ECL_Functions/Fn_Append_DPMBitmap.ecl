IMPORT $.^.^.Drivers, $.^.^.Header, $.^.^.MDR, $.^.^.PublicRecords_KEL, $.^.^.UT;

EXPORT Fn_Append_DPMBitmap(InputDataset, Source_Column = '\'\'', Is_A_FCRA_File = FALSE, GLBA_Restriction_Rules = 'FALSE', DPPA_Restriction_Rules = 'FALSE', KELPermissions = PublicRecords_KEL.CFG_Compile, Generic_Restriction_Rules = 'FALSE', Not_Restricted_Rules = 'FALSE', Insurance_Product_Restricted = 'FALSE') := FUNCTIONMACRO
	appended := PROJECT(InputDataset, TRANSFORM({RECORDOF(LEFT), UNSIGNED8 DPMBitmap},
		SELF.DPMBitmap := PublicRecords_KEL.ECL_Functions.Fn_KEL_DPMBitmap.SetValue(#EXPAND(Source_Column), Is_A_FCRA_File, #EXPAND(GLBA_Restriction_Rules), #EXPAND(DPPA_Restriction_Rules), #EXPAND(Generic_Restriction_Rules), #EXPAND(Not_Restricted_Rules), #EXPAND(Insurance_Product_Restricted), KELPermissions);
		SELF := LEFT));
	
	RETURN(appended);
ENDMACRO;