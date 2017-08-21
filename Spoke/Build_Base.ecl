import tools;

export Build_Base(

	 string														pversion
	,string														pDelimiter		= '\t'
 	,dataset(layouts.Input.Sprayed	)	pUpdateFile		= Files(pDelimiter := pDelimiter).Input.Using
	,dataset(Layouts.Base						)	pBaseFile     = Files().Base.QA			

) :=
module

	shared dUpdate := Update_Base(pUpdateFile,pBaseFile,pversion);

	export Build_Base_File := tools.macf_WriteFile(Filenames(pversion).base.new	,dUpdate	);
	
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
		,output('No Valid version parameter passed, skipping Spoke.Build_Base atribute')
	);
		
end;