IMPORT doxie, tools, versioncontrol;

EXPORT Build_Roxie_Keys(STRING pversion = '',
	                      DATASET(Layouts.Base) pBase = Files(pversion).Base.Main.Built) := MODULE

	SHARED TheKeys := Keys(pversion, pBase);

	tools.mac_WriteIndex('TheKeys.CLIA_Number.New', BuildCliaNumberKey);
	tools.mac_WriteIndex('TheKeys.BDID.New', BuildBdidKey);
	tools.mac_WriteIndex('TheKeys.LNpid.New', BuildLNpidKey);
	VersionControl.macBuildNewLogicalKeyWithName(Key_LinkIds.Key,	keynames(pversion).LinkIds.New, BuildLinkIdKey);	

	EXPORT full_build := SEQUENTIAL(PARALLEL(BuildCliaNumberKey,
			                                     BuildBdidKey,
																					 BuildLNpidKey,
																					 BuildLinkIdKey),
		                               Promote(pversion).buildfiles.New2Built);
		
	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
		               full_build,
		               OUTPUT('No Valid version parameter passed, skipping CLIA.Build_Roxie_Keys atribute'));

END;