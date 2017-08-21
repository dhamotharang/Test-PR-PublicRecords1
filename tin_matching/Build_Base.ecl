import tools;
export Build_Base(
	 string														pversion
	,boolean													pIsTesting						= _Constants().IsDataland
	,dataset(Layouts.Input.Sprayed	)	pSprayedFile					= Files().Input.prod_thor.using
	,dataset(Layouts.Base						)	pBaseFile							= files().base.prod_thor.qa							
	,dataset(Layouts.Base						)	pNewBaseFile					= Update_File(pversion,pSprayedFile,pBaseFile)
	,boolean													pWriteFileOnly				= false
) :=
function

	tools.mac_WriteFile(Filenames(pversion).base.prod_thor.new	,pNewBaseFile	,Build_Base_File	,pShouldExport := false);

	return
		if(tools.fun_IsValidVersion(pversion)
			,sequential(
				 if(not pWriteFileOnly	,Promote(,'prod_thor').Inputfiles.Sprayed2Using			)
				,Build_Base_File	
				,if(not pWriteFileOnly	,Promote(pversion,'prod_thor').buildfiles.New2Built)
			)		
			,output('No Valid version parameter passed, skipping tin_matching.Build_Base atribute')
		);
		
end;
