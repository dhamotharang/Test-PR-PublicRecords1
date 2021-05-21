IMPORT Drivers, $.^.^.Header, $.^.^.MDR, $.^.^.PublicRecords_KEL, $.^.^.UT;

EXPORT Fn_Append_DPMBitmap(
							InputDataset, 
							Source_Column = '\'\'', 
							Is_A_FCRA_File = FALSE, 
							GLBA_Restriction_Rules = 'FALSE', 
							Pre_GLB_Restriction_Rules = 'FALSE', 
							DPPA_Restriction_Rules = 'FALSE', 
							DPPA_State = '\'\'', 
							KELPermissions = PublicRecords_KEL.KEL_Queries_MAS_Shared.C_Compile, 
							Generic_Restriction_Rules = 'FALSE', 
							Is_Business_Header_Rules = 'FALSE', 
							Marketing_State = '\'\'', 
							Not_Restricted_Rules = 'FALSE', 
							Insurance_Product_Restricted = 'FALSE', 
							BIP_Bit_Mask = 'x\'\'', 
							watchdogPermissionsColumn = 0,
							Is_Consumer_Header_Rules = 'FALSE') := FUNCTIONMACRO
							
	appended := PROJECT(InputDataset, TRANSFORM({RECORDOF(LEFT), DATA57 DPMBitmap},
		SELF.DPMBitmap := PublicRecords_KEL.ECL_Functions.Fn_KEL_DPMBitmap.SetValue(
																													#EXPAND(Source_Column), 
																													Is_A_FCRA_File, 
																													#EXPAND(GLBA_Restriction_Rules), 
																													#EXPAND(Pre_GLB_Restriction_Rules), 
																													#EXPAND(DPPA_Restriction_Rules), 
																													#EXPAND(DPPA_State), 
																													#EXPAND(Generic_Restriction_Rules), 
																													#EXPAND(Is_Business_Header_Rules), 
																													#EXPAND(Marketing_State), 
																													#EXPAND(Not_Restricted_Rules), 
																													#EXPAND(Insurance_Product_Restricted), 
																													#EXPAND(watchdogPermissionsColumn), 
																													KELPermissions, 
																													#EXPAND(BIP_Bit_Mask),
																													#EXPAND(Is_Consumer_Header_Rules));
		SELF := LEFT));
	
	RETURN(appended);
ENDMACRO;