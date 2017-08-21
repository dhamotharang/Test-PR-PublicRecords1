import doxie, VersionControl;

export Build_Keys(string pversion) :=
module

	VersionControl.macBuildNewLogicalKey(Keys(pversion).Bdid.New	,BuildBdidKey	);
	VersionControl.macBuildNewLogicalKey(Keys(pversion).Did.New		,BuildDidKey	);
	VersionControl.macBuildNewLogicalKeyWithName(Teletrack.Key_LinkIds.Key
										,	Teletrack.keynames(pversion).LinkIds.New
										, BuildLINKIDKey);
																			  
	export full_build :=
	sequential(
		 parallel(
			 BuildBdidKey
			,BuildDidKey
			,BuildLINKIDKey
	  )
		,Promote(pversion).buildfiles.New2Built
	);
		
	export All :=
	if(VersionControl.IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Teletrack.Build_Keys atribute')
	);

end;