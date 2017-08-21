import doxie, Tools, BIPV2, VersionControl;

export Build_Keys(string pversion) :=
module

	VersionControl.macBuildNewLogicalKeyWithName(Key_LinkIds.Key,keynames(pversion,false).LinkIds.New, BuildLinkIdsKey);
																		  
	export full_build :=
	sequential(
			BuildLinkIdsKey
		 ,Promote(pversion).BuildFiles.New2Built
	);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping CrashCarrier.Build_Keys atribute')
	);

end;