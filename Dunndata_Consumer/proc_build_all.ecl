// DF-23679
IMPORT BuildLogger, Scrubs_Dunndata_Consumer, Orbit3;
#OPTION('multiplePersistInstances',FALSE);

EXPORT proc_build_all(
	STRING pHostname,
	STRING p20210506-105307	
	STRING pVersion
) := FUNCTION

	//load input files
	spray_new_update := Dunndata_Consumer.fSprayFiles(pVersion,,Dunndata_Consumer.Constants().Directory+pVersion);

	//scrub input files
	scrubs_new_update := Scrubs_Dunndata_Consumer.Scrubs_InputFiles(pVersion,'cathy.tio@lexisnexisrisk.com');

	//build base
	build_base := proc_build_base(pVersion);

	//Build keys
	// build_keys := 

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
