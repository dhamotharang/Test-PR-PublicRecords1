// DF-23679
IMPORT BuildLogger, Scrubs_Dunndata_Consumer;
EXPORT proc_build_all(STRING pversion) := FUNCTION

		#WORKUNIT('name', 'Yogurt: DunnData Consumer ' + pVersion);
		#OPTION('multiplePersistInstances',FALSE);

		//load input files
		spray_new_update := Dunndata_Consumer.fSprayFiles(pversion,,Dunndata_Consumer.Constants().Directory+pversion);

		//scrub input files
		scrubs_new_update := Scrubs_Dunndata_Consumer.Scrubs_InputFiles(pversion,'cathy.tio@lexisnexisrisk.com');
	
		//build base
		build_base					:= proc_build_base(pversion);

		//Build keys
		// build_keys					:= 
		
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
									BuildLogger.BuildEnd(false)
									);


											
	END;