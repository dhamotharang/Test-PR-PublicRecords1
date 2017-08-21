IMPORT tools;

EXPORT Build_Base(STRING								 pversion,
	                DATASET(Layouts.Base)	 pBaseFile	   = Files().Base.Main.QA,
	                BOOLEAN								 pUseAltLayout = FALSE) := MODULE

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
		               SEQUENTIAL(Build_Base_Main(pversion,
										                          pBaseFile,
										                          pUseAltLayout).All,
								              Promote().Inputfiles.Sprayed2Using),
							     OUTPUT('No Valid version parameter passed, skipping CLIA.Build_Base atribute'));

END;