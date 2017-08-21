import doxie, Tools, VersionControl;

export Build_Keys(string pversion) :=
module

	tools.mac_WriteIndex('Keys(pversion).Bdid.New'	,BuildBdidKey	);
	tools.mac_WriteIndex('Keys(pversion).OTS.New'		,BuildOTSKey	);
	tools.mac_WriteIndex('Keys(pversion).Cert.New'	,BuildCertKey	);
	VersionControl.macBuildNewLogicalKeyWithName(FDIC_SOD_Annual.Key_FDIC_SOD_Annual_LinkIDS.key, FDIC_SOD_Annual.Keynames(pversion).LinkIDS.New, BuildLinkIDSKey);
																			  
	export full_build :=
	sequential(
		 parallel(
			 BuildBdidKey
			,BuildOTSKey
			,BuildCertKey
			,BuildLinkIDSKey
					 )
		,Promote(pversion).BuildFiles.New2Built
	);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping FDIC_sod_annual.Build_Keys atribute')
	);

end;