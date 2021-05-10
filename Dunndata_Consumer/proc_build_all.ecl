// DF-23679
IMPORT BuildLogger, Scrubs_Dunndata_Consumer, Orbit3, STD;
#OPTION('multiplePersistInstances',FALSE);

EXPORT proc_build_all(
	STRING pHostname,
	STRING pDirectory,
	STRING pFileMask = 'MS_CPI_*.TXT',
	STRING pVersion,
	STRING pContacts,
	STRING pGroup = STD.System.Thorlib.Group()
) := FUNCTION

	//load input files
	spray_new_update := Dunndata_Consumer.fSprayFiles(
		pVersion,
		pHostname,
		pDirectory,
		pFileMask,
		pGroup
	);

	//scrub input files
	scrubs_new_update := Scrubs_Dunndata_Consumer.Scrubs_InputFiles(pVersion, pContacts);

	//build base
	build_base := proc_build_base(pVersion);

	//Build keys
	//build_keys :=

	// DF-28467 Create Orbit entry
	create_build := Orbit3.proc_Orbit3_CreateBuild('DunnData Consumer',pVersion,'N');

	RETURN SEQUENTIAL(
		BuildLogger.BuildStart(false),
		BuildLogger.PrepStart(false),
		spray_new_update,
		scrubs_new_update,
		BuildLogger.PrepEnd(false),
		BuildLogger.BaseStart(False),
		build_base,
		BuildLogger.BaseEnd(False),
		BuildLogger.KeyStart(false),
		BuildLogger.KeyEnd(false),
		BuildLogger.PostStart(False),
		BuildLogger.PostEnd(False),
		BuildLogger.BuildEnd(false),
		create_build
	);

END;
