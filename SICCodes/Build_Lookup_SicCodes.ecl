import tools;

export Build_Lookup_SicCodes(

	 string														pversion
	,boolean													pIsTesting		 = false																											
	,dataset(Layouts.Sprayed_Input	)		pSprayedFile		= Files().Input.using 
	,dataset(Layouts.SICLookup          ) pLookupFile    = Files().SICLookup.qa
	,dataset(Layouts.SICLookup         	)	pNewLookupFile = Update_SicLookup(pversion,pSprayedFile,pLookupFile)
	,boolean													pWriteFileOnly = false
	
) :=
function
	
	tools.mac_WriteFile(Filenames(pversion).SICLookup.new	,pNewLookupFile	,Build_Lookup_File	,pShouldExport := false);
	
	return
		if(tools.fun_IsValidVersion(pversion)
			,sequential(
				if(not pWriteFileOnly	,Promote().Inputfiles.Sprayed2Using			),
				Build_Lookup_File
				,if(not pWriteFileOnly, Promote(pversion).buildfiles.New2Built	)	
			)		
			,output('No Valid version parameter passed, skipping build SIC Code Lookup Table') 
		);
		
end;