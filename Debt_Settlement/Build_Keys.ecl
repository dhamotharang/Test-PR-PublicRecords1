import doxie, Tools, versioncontrol;

export Build_Keys(string pversion) :=
module

	tools.mac_WriteIndex('Keys(pversion).Bdid.New'	,BuildBdidKey	);
	//tools.mac_WriteIndex('Keys(pversion).Did.New'		,BuildDidKey	);
	VersionControl.macBuildNewLogicalKeyWithName(	Key_LinkIds.Key
																						   ,Keynames(pversion).LinkIds.New
																							 ,BuildLinkIdsKey);
																		  
	export full_build :=
	sequential(
		 parallel(
			 BuildBdidKey
			 //,BuildDidKey
			 ,BuildLinkIdsKey
		 )
		,Promote(pversion).BuildFiles.New2Built
	);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Debt_Settlement.Build_Keys atribute')
	);

end;