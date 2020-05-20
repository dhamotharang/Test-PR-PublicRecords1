import tools;

export Build_Lookup_NAICSCodes(

	 string														pversion
	,boolean													pIsTesting		 = false																											
	,dataset(Layouts.Sprayed_Input	)		pSprayedFile		= Files().Input.using 
	,dataset(Layouts.NAICSLookup          ) pLookupFile    = Files().NAICSLookup.qa
	,dataset(Layouts.NAICSLookup         	)	pNewLookupFile = Update_NAICSLookup(pversion,pSprayedFile,pLookupFile)
	,boolean													pWriteFileOnly = false
	
) :=
function
	
	tools.mac_WriteFile(Filenames(pversion).NAICSLookup.new	,pNewLookupFile	,Build_Lookup_File	,pShouldExport := false);
	
	return
		if(tools.fun_IsValidVersion(pversion)
			,sequential(
				if(not pWriteFileOnly	,Promote().Inputfiles.Sprayed2Using			),
				Build_Lookup_File
				,if(not pWriteFileOnly, Promote(pversion).buildfiles.New2Built	)	
			)		
			,output('No Valid version parameter passed, skipping build NAICS Code Lookup Table') 
		);
		
end;