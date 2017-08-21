import tools;

export Build_Base(

	 string																			pversion
	,boolean																		pIsTesting						= _Constants().IsDataland
	,dataset(Layouts.Input.sprayed						)	pSprayedintFile				= files().input.int.using
	,dataset(Layouts.Input.sprayed						)	pSprayedprvFile				= files().input.prv.using
	,dataset(Layouts.Input.sprayed						)	pSprayedpubFile				= files().input.pub.using
	,dataset(Layouts.Input.sprayed						)	pSprayedPrivcoFile		= files().input.privco.using
	,dataset(Layouts.Base.companies						)	pBaseCompaniesFile		= Files(,pIsTesting).base.companies.qa									
	,dataset(Layouts.Base.contacts						)	pBaseContactsFile			= Files(,pIsTesting).base.contacts.qa								
	,dataset(layouts.temporary.big						)	pPrepFile							= Prep_Input(pversion,pSprayedintFile,pSprayedprvFile,pSprayedpubFile,pSprayedPrivcoFile)
	,dataset(Layouts.Base.contacts						)	pNewBaseContactsFile	= Update_Contacts	(pversion,pPrepFile,pBaseContactsFile		)
	,dataset(Layouts.Base.companies						)	pNewBaseCompaniesFile	= Update_Companies(pversion,pPrepFile,pBaseCompaniesFile, pNewBaseContactsFile)
	,boolean																		pWriteFileOnly				= false
) :=
module

  export uniqueridbase        := count(pBaseCompaniesFile) = count(table(pBaseCompaniesFile,{rid},rid));
  export uniqueridContacts    := count(pBaseContactsFile ) = count(table(pBaseContactsFile ,{rid},rid));
  
  export uniqueridNewbase     := count(pNewBaseCompaniesFile) = count(table(pNewBaseCompaniesFile,{rid},rid));
  export uniqueridNewContacts := count(pNewBaseContactsFile ) = count(table(pNewBaseContactsFile ,{rid},rid));

	export Build_Contacts_File	:= tools.macf_WriteFile(Filenames(pversion).base.Contacts.new		,pNewBaseContactsFile		);
  export Build_Companies_File	:= tools.macf_WriteFile(Filenames(pversion).base.Companies.new	,pNewBaseCompaniesFile	);
	
  export condition := tools.fun_IsValidVersion(pversion) and uniqueridbase and uniqueridContacts /*and uniqueridNewbase and uniqueridNewContacts*/;
  
	export doall := 
		map(condition =>
			sequential(
         output('starting promotion of input files to using supers')
				,Promote().Inputfiles.Sprayed2Using			
        ,output('finished promotion of input files to using supers')
				,Build_Companies_File	
				,Promote(pversion,'base').buildfiles.New2Built
				,Build_Contacts_File	
				,Promote(pversion,'base').buildfiles.New2Built
			)		
			,not tools.fun_IsValidVersion(pversion)   => fail('No Valid version parameter passed, skipping DCAV2.Build_Base atribute')
      ,                                            fail('The DCAV2 Base file and/or the DCAV2 Contacts file do not have a unique rid field.')
		);
		
end;