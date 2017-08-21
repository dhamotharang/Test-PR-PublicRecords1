export Proc_Buld_New_Suppression_All(STRING pVersion) := 
 SEQUENTIAL(Suppress.LN_Opt_Out_DID_SSN(pVersion),
            Suppress.Proc_Build_File_New_Suppression(pVersion),
            Suppress.Proc_Build_Key_New_Suppression(pVersion)
			);