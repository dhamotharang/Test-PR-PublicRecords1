import doxie, Tools, VersionControl,scrubs;

export Build_Keys(string pversion) :=
module

	tools.mac_WriteIndex('Keys(pversion).Bdid.New'		,BuildBdidKey	);
	tools.mac_WriteIndex('Keys(pversion).Did.New'		,BuildDidKey	);
	VersionControl.MacBuildNewLogicalKeyWithName(Key_LinkIDS.Key, Keynames(pversion).LinkIDs.New, BuildLinkIDsKey);
																		  
	export full_build :=
	sequential(
		 parallel(
			 BuildBdidKey
			,BuildDidKey
			,BuildLinkIDsKey
		 )
		,Promote(pversion).buildfiles.New2Built
	);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,if(scrubs.mac_ScrubsFailureTest('Scrubs_saleschannel',pversion),
			full_build,
			OUTPUT('Scrubs has failed!',NAMED('Scrubs_Failure'))
		)
		,output('No Valid version parameter passed, skipping SalesChannel.Build_Keys atribute')
	);

end;