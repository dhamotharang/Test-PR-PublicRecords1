import bipv2,tools,versioncontrol;

export Proc_Build_Keys(

	string pversion

) :=
function

	tools.mac_WriteIndex('key_yellowpages_bdid	,keynames(pversion).bdid.new'	,BuildBdidKey		);
	tools.mac_WriteIndex('Key_YellowPages_Addr	,keynames(pversion).addr.new'	,BuildAddrKey		);
	tools.mac_WriteIndex('key_yellowpages_phone	,keynames(pversion).phone.new',BuildPhoneKey	);
	VersionControl.MacBuildNewLogicalKeyWithName(YellowPages.Key_YellowPages_LinkIDS.Key,	keynames(pversion).linkids.new, BuildLinkIDKey);

	return
	if(tools.fun_IsValidVersion(pversion)
		,sequential(
			parallel(
				 BuildBdidKey	
				,BuildAddrKey	
				,BuildPhoneKey
				,BuildLinkIDKey
			)
			,Promote(pversion).buildfiles.New2Built
		)
		,output('No Valid version parameter passed, skipping YellowPages.Proc_Build_Keys atribute')
	);

end;
