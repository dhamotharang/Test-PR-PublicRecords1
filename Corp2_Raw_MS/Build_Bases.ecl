IMPORT tools, ut;

EXPORT Build_Bases(
	 STRING	 pfiledate
	,STRING	 pversion
	,BOOLEAN puseprod

	,DATASET(Corp2_Raw_MS.Layouts.ProfilesLayoutIn)	  pInProfiles   = Corp2_Raw_MS.Files(pfiledate,puseprod).Input.Profiles.logical
	,DATASET(Corp2_Raw_MS.Layouts.ProfilesLayoutBase) pBaseProfiles = IF(Corp2_Raw_MS._Flags.Base.Profiles
																																		  ,Corp2_Raw_MS.Files(,pUseOtherEnvironment := FALSE).Base.Profiles.qa
																																		  ,DATASET([],Corp2_Raw_MS.Layouts.ProfilesLayoutBase))
	
	,DATASET(Corp2_Raw_MS.Layouts.FormsLayoutIn)		  pInForms      = Corp2_Raw_MS.Files(pfiledate,puseprod).Input.Forms.logical
	,DATASET(Corp2_Raw_MS.Layouts.FormsLayoutBase)  	pBaseForms	  = IF(Corp2_Raw_MS._Flags.Base.Forms
																																		  ,Corp2_Raw_MS.Files(,pUseOtherEnvironment := FALSE).Base.Forms.qa
																																		  ,DATASET([],Corp2_Raw_MS.Layouts.FormsLayoutBase))
) := MODULE

	EXPORT full_build := sequential(	Corp2_Raw_MS.Build_Bases_Profiles(pfiledate,pversion,puseprod,pInProfiles,pBaseProfiles).ALL,
																		Corp2_Raw_MS.Build_Bases_Forms(pfiledate,pversion,puseprod,pInForms,pBaseForms).ALL,
																		Promote(pversion).buildfiles.New2Built,
																		Promote().BuildFiles.Built2QA
																	);
											

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											full_build,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_MS.Build_Bases attribute')
									 );

END;
