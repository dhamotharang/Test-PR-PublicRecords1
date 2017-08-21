import tools;
export Build_Base(
	 string														pversion
	,boolean													pIsTesting						= _Constants().IsDataland
	,dataset(Layouts.Input.Sprayed	)	pSprayedFile					= Files().Input.using
	,dataset(Layouts.Base						)	pNewBaseFile					= Update_File(pversion,pSprayedFile)
	,boolean													pWriteFileOnly				= false
) :=
function

	tools.mac_WriteFile(Filenames(pversion).base.new	,pNewBaseFile	,Build_Base_File	,pShouldExport := false);

	return
		if(tools.fun_IsValidVersion(pversion)
			,sequential(
				 if(not pWriteFileOnly	,Promote().Inputfiles.Sprayed2Using			)
				,Build_Base_File	
				,if(not pWriteFileOnly	,Promote(pversion,'base').buildfiles.New2Built)
			)		
			,output('No Valid version parameter passed, skipping bell_thrive.Build_Base atribute')
		);
		
end;
