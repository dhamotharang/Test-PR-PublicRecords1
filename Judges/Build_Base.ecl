import tools;
export Build_Base(

	 string																			pversion
	,boolean																		pIsTesting		= false
	,dataset(Layouts.Input.Sprayed						)	pSprayedFile	= Files().Input.using
	,dataset(Layouts.Base											)	pBaseFile			= Files().base.qa									
	,dataset(Layouts.Base											)	pUpdateBase		= Update_Base(pversion,pSprayedFile,pBaseFile)								

) :=
module

	tools.mac_WriteFile(Filenames(pversion).base.new	,pUpdateBase	,Build_Base_File	);

	export full_build :=
		 sequential(
			 Promote().Inputfiles.Sprayed2Using
			,Build_Base_File
			,Promote(pversion).buildfiles.New2Built
		);
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build		
		,output('No Valid version parameter passed, skipping Judges.Build_Base atribute')
	);
		
end;
