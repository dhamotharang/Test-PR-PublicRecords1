import doxie, Tools, BIPV2, VersionControl;

export Build_Keys(string pversion) :=
module

	//tools.mac_WriteIndex('Keys(pversion).Bdid.New'	,BuildBdidKey	);
	
	VersionControl.macBuildNewLogicalKeyWithName(CClue.Key_LinkIds.Key,	CClue.keynames(pversion,false).LinkIds.New, BuildLinkIdsKey);

	
	export full_build :=
	sequential(
		 /*parallel(*/
			// BuildBdidKey
			/*,*/BuildLinkIdsKey			
		/* )*/
		,Promote(pversion).BuildFiles.New2Built
	);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping CClue.Build_Keys atribute')
	);

end;