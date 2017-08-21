import doxie, VersionControl;

export Build_Keys(string pversion) :=
module

	VersionControl.macBuildNewLogicalKey(Keys(pversion).Bdid.New	,BuildBdidKey	);
	VersionControl.macBuildNewLogicalKey(Keys(pversion).Did.New		,BuildDidKey	);
	VersionControl.macBuildNewLogicalKeyWithName(POEsFromEmails.Key_POEsFromEmails_LinkIds.Key
										,	POEsFromEmails.Keynames(pversion,false).LinkIds.New
										, BuildLinkIdsKey);	
																		  
	export full_build :=
	sequential(
		 parallel(
			 BuildBdidKey
			,BuildDidKey
			,BuildLinkIdsKey
		 )
		,Promote(pversion).New2Built
	);
		
	export All :=
	if(VersionControl.IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping POEsFromEmails.Build_Keys atribute')
	);

end;