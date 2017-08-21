import doxie, tools, VersionControl;

export Build_Keys(string pversion) :=
module

	export BuildBdidKey	      := tools.macf_WriteIndex('Keys(pversion).Bdid.New'	  );
	export BuildDidKey	      := tools.macf_WriteIndex('Keys(pversion).Did.New'		  );
  VersionControl.macBuildNewLogicalKeyWithName(Jigsaw.Key_Jigsaw_LinkIds.Key
										,	Jigsaw.Keynames(pversion,false).LinkIds.New
										, BuildLinkIdsKey);	
																		  
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
		,output('No Valid version parameter passed, skipping Jigsaw.Build_Keys atribute')
	);

end;