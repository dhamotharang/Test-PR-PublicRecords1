import tools;

export Build_Base(

	 string																				pversion
	,boolean																			pIsTesting			= false
	,dataset(layouts.Input.Sprayed							)	pSprayedFile 		= Files().input.sprayed
	,dataset(Layouts.Base												)	pNewBaseFile		= Update_Base(pversion,pSprayedFile)
	,boolean																			pWriteFileOnly	= false
	
) :=
function

	tools.mac_WriteFile(Filenames(pversion).base.new	,pNewBaseFile	,Build_Base_File	,pShouldExport := false);

	return
		if(tools.fun_IsValidVersion(pversion)
			,sequential(
				 if(not pWriteFileOnly	,Promote().Inputfiles.Sprayed2Using			)
				,Build_Base_File
				,if(not pWriteFileOnly	,Promote(pversion).buildfiles.New2Built	)
			)		
			,output('No Valid version parameter passed, skipping CClue.Build_Base atribute') 
		);
		
end;