import doxie, Tools, BIPV2, VersionControl;

export Build_Keys(string pversion) := module

	VersionControl.macBuildNewLogicalKeyWithName(Experian_FEIN.Key_LinkIds.Key
																		  ,Experian_FEIN.keynames(pversion,false).LinkIds.New
																			,BuildLinkIdsKey);
																				  
	export full_build :=
	 sequential(
		 BuildLinkIdsKey			
		,Promote(pversion).BuildFiles.New2Built );
		
	export All :=
	 if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Experian_FEIN.Build_Keys atribute')
	 );

end;