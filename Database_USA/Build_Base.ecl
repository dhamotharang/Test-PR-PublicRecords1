import tools;

export Build_Base(

	 string																				pversion
	,boolean																			pIsTesting		 = false
	,dataset(Database_USA.Layouts.Sprayed_Input)	pSprayedFile 	 = Database_USA.Files().Input.Sprayed
	,dataset(Database_USA.Layouts.Base         )	pBaseFile      = Database_USA.Files().base.qa
	,dataset(Database_USA.Layouts.Base         )	pNewBaseFile	 = Database_USA.Update_Base(pversion,pSprayedFile,pBaseFile)
	,boolean																			pWriteFileOnly = false
	
) :=
function
	
	tools.mac_WriteFile(Database_USA.Filenames(pversion).base.new	,pNewBaseFile	,Build_Base_File	,pShouldExport := false);
	
	RETURN
		IF(tools.fun_IsValidVersion(pversion)
			,SEQUENTIAL(
				 IF( NOT pWriteFileOnly, Database_USA.Promote().Inputfiles.Sprayed2Using )
				,Build_Base_File
				,IF( NOT pWriteFileOnly, Database_USA.Promote(pversion).buildfiles.New2Built	)
			)		
			,OUTPUT('No Valid version parameter passed, skipping Database_USA.Build_Base atribute') 
		);
		
end;