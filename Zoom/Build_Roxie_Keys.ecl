import doxie, tools, VersionControl;

export Build_Roxie_Keys(string pversion) :=
module

	tools.mac_WriteIndex('Keys(pversion).Bdid.New'			,BuildBdidKey				);
	tools.mac_WriteIndex('Keys(pversion).Did.New'				,BuildDidKey				);
	tools.mac_WriteIndex('Keys(pversion).ZoomId.New'		,BuildZoomIdKey			);
	tools.mac_WriteIndex('Keys(pversion).XMLZoomId.New'	,BuildXMLZoomIdKey	);
	VersionControl.macBuildNewLogicalKeyWithName(Zoom.Key_LinkIds.Key,	Zoom.keynames(pversion,false).XLinkIds.New, BuildLinkIdsKey);
																		  
	export full_build :=
	sequential(
		 parallel(
			 BuildBdidKey
			,BuildDidKey
			,BuildZoomIdKey
			,BuildXMLZoomIdKey
			,BuildLinkIdsKey
		 )
		,Promote(pversion).buildfiles.New2Built
	);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping zoom.build_roxie_keys atribute')
	);

end;