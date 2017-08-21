IMPORT _Control, ALC, VersionControl;

EXPORT Build_Base(STRING                    pversion,
                  BOOLEAN                   pUseProd  = FALSE,
                  DATASET(ALC.Layouts.Base) pBaseFile) := MODULE
   
	SHARED build_base := ALC.Update_Base(pversion,
	                                     pUseProd,
																			 pBaseFile);

	VersionControl.macBuildNewLogicalFile(ALC.Filenames(pversion, pUseProd).Base.new,
																				build_base,
																				Build_Base_File);

	EXPORT full_build := sequential(Build_Base_File,
																  ALC.Promote(pversion, pUseProd).buildfiles.New2Built
																 ) : SUCCESS(Send_Emails(pversion).BuildSuccess),
																		 FAILURE(Send_Emails(pversion).BuildFailure);

	EXPORT All := IF(VersionControl.IsValidVersion(pversion),
			             full_build,
			             OUTPUT('No Valid version parameter passed, skipping build'));

END;
