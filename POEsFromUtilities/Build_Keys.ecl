import doxie, Tools, VersionControl;

export Build_Keys(string pversion) :=
module

	tools.mac_WriteIndex('Keys(pversion).Bdid.New'	,BuildBdidKey	);
	tools.mac_WriteIndex('Keys(pversion).Did.New'		,BuildDidKey	);
	VersionControl.MacBuildNewLogicalKeyWithName(Key_LinkIDS.Key, Keynames(pversion).LinkIDs.New, BuildLinkIDsKey);
																		  
	export full_build :=
	sequential(
		 parallel(
			 BuildBdidKey
			,BuildDidKey
			,BuildLinkIDsKey			
		 )
		,Promote(pversion).New2Built
	);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping POEsFromUtilities.Build_Keys atribute')
	);

end;