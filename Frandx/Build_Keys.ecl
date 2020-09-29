import doxie, Tools, BIPV2, VersionControl;

export Build_Keys(string pversion) :=
module

	tools.mac_WriteIndex('Keys(pversion).Bdid.New'	,BuildBdidKey	);
	
	VersionControl.macBuildNewLogicalKeyWithName(Frandx.Key_LinkIds.Key,	frandx.keynames(pversion,false).LinkIds.New, BuildLinkIdsKey);

	//Depriciated Key
	//VersionControl.macBuildNewLogicalKeyWithName(Frandx.Key_SourceRecId,	frandx.keynames(pversion,false).Source_Rec_ID.New, BuildSourceRecIdKey);
	
	export full_build :=
	sequential(
		 parallel(
			 BuildBdidKey
			,BuildLinkIdsKey
		 )
		,Promote(pversion).BuildFiles.New2Built
	);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Frandx.Build_Keys atribute')
	);

end;