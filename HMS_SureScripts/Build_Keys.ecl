import doxie, VersionControl;

export Build_Keys(string pversion, boolean pUseProd = false) :=
module

	//VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).Did.New		,BuildDidKey);
	VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).lnpid.New	,BuildLnpidKey	);

	export full_build :=
	sequential(		 
		 //BuildDidKey,
		 BuildLnpidKey,
		Promote(pversion,pUseProd).buildfiles.New2Built
	);
	
	
	export All :=
	if(VersionControl.IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping SureScripts.Build_Keys atribute')
	);

end;