import tools;
export Build_Output(
	 string									pversion
	,boolean								pIsTesting		= false
	,dataset(Layouts.Base	)	pBaseFile			= Files().base.built									
) :=
module

	tools.mac_WriteFile(Filenames(pversion).out.new	,pBaseFile	,Build_Out_File,pCsvout := true,pSeparator := '|');

	export full_build :=
		 sequential(
			 Build_Out_File
			,Promote(pversion).buildfiles.New2Built
		);
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build		
		,output('No Valid version parameter passed, skipping Judges.Build_Output atribute')
	);
		
end;
