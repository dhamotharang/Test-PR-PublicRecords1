import doxie, VersionControl;

export Build_Keys(string pversion) :=
module

	VersionControl.macBuildNewLogicalKey(Keys(pversion).Bdid.New	,BuildBdidKey	);
	VersionControl.macBuildNewLogicalKey(Keys(pversion).Did.New		,BuildDidKey	);																		  
	VersionControl.macBuildNewLogicalKeyWithName(One_Click_Data.Key_One_Click_Data_LinkIds.Key
										,	One_Click_Data.Keynames(pversion,false).LinkIds.New
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
	if(VersionControl.IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping One_Click_Data.Build_Keys atribute')
	);

end;