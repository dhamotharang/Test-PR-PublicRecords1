import doxie, Tools, VersionControl;
export Build_Keys(

	 string pversion
	,string	pDatasetName	= 'DNB'
	
) :=
module

	tools.mac_WriteIndex('Keys(pversion,,,pDatasetName).Bdid.New'	,BuildBdidKey	);
	tools.mac_WriteIndex('Keys(pversion,,,pDatasetName).Duns.New'	,BuildDunsKey	);

	VersionControl.macBuildNewLogicalKeyWithName(DNB_DMI.Key_LinkIds.Key,	DNB_DMI.keynames(pversion,false,pDatasetName).LinkIds.New, BuildLinkIdsKey);	
																		  
	export full_build :=
	sequential(
		 parallel(
			 BuildBdidKey
			,BuildDunsKey
			,BuildLinkIdsKey
		 )
		,Promote(pversion,'key',,,pDatasetName).BuildFiles.New2Built
	);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping DNB_DMI.Build_Keys atribute')
	);
end;
