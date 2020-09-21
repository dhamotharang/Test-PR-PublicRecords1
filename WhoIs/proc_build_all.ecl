IMPORT _control,ut,PromoteSupers, WhoIs, BuildLogger, SALT38, STD;

//Version = input filedate
EXPORT Proc_build_all(
	STRING  pVersion    = (STRING)STD.Date.Today(),
	BOOLEAN	pPromote	  = FALSE,
	STRING  pServerIP   = Constants(pVersion).serverIP,
	STRING  pDirectory  = Constants(pVersion).Directory + pVersion + '/',
	STRING  pFilename   = '*.csv',
	STRING  pGroupName  = _Dataset().pGroupname,
	BOOLEAN pIsTesting  = FALSE,
	BOOLEAN pOverwrite  = FALSE
) := MODULE

  #workunit('name', 'WhoIs email build');
	
	//Run Spray
		EXPORT SprayFiles := IF(pDirectory != '',WhoIs.SprayFiles(
			pVersion,
			pServerIP,
			pDirectory,
			pFilename,
			pGroupName,
			pIsTesting,
			pOverwrite,
		)
	);
	
	//Build basefile
	SHARED base_f := WhoIs.proc_build_base(pVersion);
	
  EXPORT All := SEQUENTIAL(
														BuildLogger.BuildStart(false),
														BuildLogger.PrepStart(false),
														SprayFiles,
														BuildLogger.PrepEnd(false),
														BuildLogger.BaseStart(False),
														base_f,
														BuildLogger.BaseEnd(False),	
														WhoIs.Strata_Population_Stats(pVersion).all,
														BuildLogger.PostEnd(False),
														BuildLogger.BuildEnd(false)
							            );
	
END;