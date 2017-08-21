IMPORT _Control, Infogroup, VersionControl;

EXPORT Build_Base(STRING                          pversion,
                  BOOLEAN                         pUseProd  = FALSE,
                  DATASET(Infogroup.Layouts.Base) pBaseFile) := MODULE
   
	SHARED build_base := Infogroup.Update_Base(pversion,
	                                           pUseProd,
																			       pBaseFile);

	VersionControl.macBuildNewLogicalFile(Infogroup.Filenames(pversion, pUseProd).Base.new,
																				build_base,
																				Build_Base_File);

	EXPORT full_build := sequential(Build_Base_File,
																  Infogroup.Promote(pversion, pUseProd).buildfiles.New2Built
																 ) : SUCCESS(Send_Emails(pversion).BuildSuccess),
																		 FAILURE(Send_Emails(pversion).BuildFailure);

	EXPORT All := IF(VersionControl.IsValidVersion(pversion),
			             full_build,
			             OUTPUT('No Valid version parameter passed, skipping build'));

END;
