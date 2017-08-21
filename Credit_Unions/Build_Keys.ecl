import doxie, Tools, versioncontrol;

export Build_Keys(string pversion) :=
module

	tools.mac_WriteIndex('Keys(pversion).Bdid.New'	,BuildBdidKey	);
	tools.mac_WriteIndex('Keys(pversion).Did.New'		,BuildDidKey	);
	VersionControl.macBuildNewLogicalKeyWithName(Credit_Unions.Key_LinkIds.Key
										,	Credit_Unions.keynames(pversion,false).LinkIds.New
										, BuildLINKIDKey);	
																			  
	export full_build :=
	sequential(
		 parallel(
			 BuildBdidKey
			,BuildDidKey
			,BuildLINKIDKey
		 )
		,Promote(pversion).BuildFiles.New2Built
	);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Credit_Unions.Build_Keys atribute')
	);

end;