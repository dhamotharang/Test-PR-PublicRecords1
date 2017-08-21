import tools,liensv2;

export Build_Base(

	 string																			pversion
	,boolean																		pIsTesting		= false
	,dataset(Layouts.Input.Layout_Liens_Hogan	)	pSprayedFile	= Files().Input.using
	,dataset(Layouts.Base											)	pBaseFile			= Files().base.qa									
) :=
module

	export create_base := Update_Base(pversion,pSprayedFile,pBaseFile);

	tools.mac_WriteFile(Filenames(pversion).base.new	,create_base	,Build_Base_File	);

	export full_build :=
		 sequential(
			 Promote().Inputfiles.Sprayed2Using
			,Build_Base_File
			,Promote().Inputfiles.Using2Used
			,Promote(pversion).buildfiles.New2Built

		);

	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build		
		,output('No Valid version parameter passed, skipping Garnishments.Build_Base atribute')
	);
		
end;