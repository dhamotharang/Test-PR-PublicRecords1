import doxie, tools;

export Build_Keys(string pversion) :=
module

	export BuildBdidKey	  := tools.macf_WriteIndex('Keys(pversion).Bdid.New');
	export BuildDidKey	  := tools.macf_WriteIndex('Keys(pversion).Did.New');
	export BuildLinkIDKey := Keys(pversion).LinkIDS;

	export full_build :=
	sequential(
		 parallel(
			 BuildBdidKey
			,BuildDidKey
			,BuildLinkIDKey
		 )
		,Promote(pversion).buildfiles.New2Built
	);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Spoke.Build_Keys atribute')
	);

end;