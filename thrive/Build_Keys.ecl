import doxie, VersionControl;

export Build_Keys(string pversion, boolean pUseProd = false) :=
module

	VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).Bdid.New	,BuildBdidKey	);
	VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).Did.New		,BuildDidKey	);
	VersionControl.macBuildNewLogicalKey(Keys(pversion,pUseProd).Did_fcra.New		,BuildDidFcraKey	);	
	VersionControl.macBuildNewLogicalKeyWithName(Thrive.Key_LinkIds.Key,thrive.keynames(pversion,false).LinkIds.New,BuildLinkIDKey           );			
	
	export full_build :=
	sequential(
		 parallel(
			 BuildBdidKey
			,BuildDidKey
			,BuildDidFcraKey
			,BuildLinkIDKey
		 )
		,Promote(pversion,pUseProd).buildfiles.New2Built
	);
		
	export All :=
	if(VersionControl.IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Thrive.Build_Keys atribute')
	);

end;