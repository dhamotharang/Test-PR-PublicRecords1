import doxie, tools, versioncontrol;

export Build_Keys(string pversion) :=
module

	tools.mac_WriteIndex('Keys(pversion).Bdid.New'	,BuildBdidKey	);
	tools.mac_WriteIndex('Keys(pversion).Did.New'		,BuildDidKey	);
	VersionControl.macBuildNewLogicalKeyWithName(Garnishments.Key_LinkIds.Key,	Garnishments.keynames(pversion,false).LinkIds.New, BuildLinkIdsKey);
																		  
	export full_build :=
	sequential(
		 parallel(
			 BuildBdidKey
			,BuildDidKey
			,BuildLinkIdsKey			
		 )
		,Promote(pversion).buildfiles.New2Built
	);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Garnishments.Build_Keys atribute')
	);

end;