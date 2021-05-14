import tools;

export Build_Base(

	 string														        pversion
	,boolean													        pIsTesting		        = false
	,dataset(Layouts.Sprayed_Input	        )	pSprayedFile 	        = Files().Input.Companies.using																									
	,dataset(Layouts.Sprayed_Input_Contacts	)	pSprayedContactsFile  = Files().Input.Contacts.using  
	,dataset(Layouts.Base                   ) pBaseFile             = Files().base.Companies.qa										
	,dataset(Layouts.Base_contacts					)	pBaseContactsFile			= Files().base.contacts.qa	
	,boolean													        pWriteFileOnly        = false
	
) :=
function

	return
		if(tools.fun_IsValidVersion(pversion)
			,
			sequential(
				 if(not pWriteFileOnly	,Promote().Inputfiles.Sprayed2Using			)
		  		,Update_Base_Files(pversion,pSprayedFile,pBaseFile,pSprayedContactsFile,pBaseContactsFile)
				,if(not pWriteFileOnly, Promote(pversion).buildfiles.New2Built	)	
			)		
			,output('No Valid version parameter passed, skipping Equifax_Business_Data.Build_Base atribute') 
		)
		;
		
end;