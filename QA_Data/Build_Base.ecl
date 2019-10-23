IMPORT tools;

EXPORT Build_Base(
	 STRING                                     pversion
	,BOOLEAN                                    pIsTesting          = FALSE
	,DATASET(QA_Data.Layouts.Input.Sprayed_Addresses)
	                                            pSprayedAddrFile    = QA_Data.Files().Input_Addr.sprayed
	,DATASET(QA_Data.Layouts.Input.Sprayed_Transactions)
	                                            pSprayedTransFile   = QA_Data.Files().Input_Trans.sprayed
	,DATASET(QA_Data.Layouts.Base)              pBaseFile           = QA_Data.Files().base.qa	
	,DATASET(QA_Data.Layouts.Base)              pNewBaseFile        = QA_Data.Update_Base(pversion,pSprayedAddrFile,pSprayedTransFile,pBaseFile)
	,BOOLEAN																		pWriteFileOnly	    = FALSE
) := FUNCTION

	tools.mac_WriteFile(Filenames(pversion).base.new, pNewBaseFile, Build_Base_File, pShouldExport := FALSE);

	RETURN
		IF(tools.fun_IsValidVersion(pversion)
			,SEQUENTIAL(
				 IF( NOT pWriteFileOnly, QA_Data.Promote().Inputfiles.Sprayed2Using )
				,Build_Base_File
				,IF( NOT pWriteFileOnly, QA_Data.Promote(pversion).buildfiles.New2Built	)
			)		
			,OUTPUT('No Valid version parameter passed, skipping QA_Data.Build_Base atribute') 
		);
		
END;