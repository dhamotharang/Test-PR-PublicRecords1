IMPORT tools;

EXPORT Build_Base(STRING								pversion,
	                DATASET(Layouts.Base) pBaseFile  = Files().Base.Main.QA) := MODULE

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
		               SEQUENTIAL(Build_Base_Main(pversion,
										                          pBaseFile).All,
								              Promote().Inputfiles.Sprayed2Using),
							     OUTPUT('No Valid version parameter passed, skipping Death_MI.Build_Base atribute'));

END;