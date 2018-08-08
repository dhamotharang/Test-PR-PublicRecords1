import doxie, Tools, BIPV2, VersionControl;

export Build_Keys(string pversion) :=
module

	VersionControl.macBuildNewLogicalKeyWithName(Equifax_Business_Data.Key_LinkIds.Key,	Equifax_Business_Data.keynames(pversion,false).LinkIds.New, BuildLinkIdsKey);

	export full_build :=
	
	sequential(
			BuildLinkIdsKey
		 ,Promote(pversion).BuildFiles.New2Built
	);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Equifax_Business_Data.Build_Keys atribute')
	);

end;