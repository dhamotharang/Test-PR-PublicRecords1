import doxie, VersionControl;

export Build_Keys(string pversion, boolean pUseProd = false) :=
module

	VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).Did.New		,BuildDidKey	);
																		  
	export full_build :=
	sequential(
		 
			BuildDidKey
		 
		,Promote(pversion,pUseProd).buildfiles.New2Built
	);
		
	export All :=
	if(VersionControl.IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping CD_Seed.Build_Keys atribute')
	);

end;