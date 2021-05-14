export Proc_Buld_New_Suppression_All(STRING pVersion) := 
 SEQUENTIAL(Suppress.LN_Opt_Out_DID_SSN(pVersion),
            Suppress.Proc_Build_File_New_Suppression(pVersion),
            Suppress.Proc_Build_Key_New_Suppression(pVersion)
            //Suppress.Proc_Build_File_New_Suppression_Opt_Out(pVersion[1..8]),
            //Suppress.Proc_Build_Key_New_Suppression_Opt_Out(pVersion[1..8]),
            //Suppress.fDesprayRBIFile(pVersion[1..8]),               //CCPA-1058
            //Suppress.Proc_Build_Key_OptOut_Test(pVersion[1..8]+'t') //This will be deleted when test key is moved to PRTE
			);