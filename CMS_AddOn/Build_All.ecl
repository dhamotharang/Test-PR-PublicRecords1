IMPORT _Control, CMS_AddOn, tools;

EXPORT Build_All(STRING  												 pversion,
								 BOOLEAN 												 pUseProd    		= FALSE,
								 BOOLEAN 												 pIsTesting  		= FALSE,
								 BOOLEAN 												 pOverwrite  		= TRUE,
								 STRING  												 pNameOutput 		= 'CMS_AddOn Info Spray',
								 STRING 												 pServerIP			= _Control.IPAddress.bctlpedata11,
								 STRING 												 pAddOnFilename	= '*Add*.csv',
								 STRING 												 pDirectory			= '/data/data_build_4/CMS_AddOn/data/' + pVersion,
								 DATASET(CMS_AddOn.Layouts.Base) pBaseFile 	 		= IF(CMS_AddOn._Flags(pUseProd).Update,
																																		 CMS_AddOn.Files().Base.QA,
																																		 DATASET([], CMS_AddOn.Layouts.Base)),
								 DATASET(CMS_AddOn.Layouts.Base) pBaseBuilt  		= Files(pversion).Base.Built) := MODULE

	EXPORT spray_ := tools.fun_Spray(CMS_AddOn.fSpray(pversion, pServerIP, pAddOnFilename, pDirectory),
	                                    pOverwrite := pOverwrite, pIsTesting := pIsTesting,
																			pOutputName := pNameOutput);

  // In the filename is the effective date, in YYYYMMDD format.
  dsFileList := NOTHOR(FileServices.RemoteDirectory(pServerIP,
							                                      pDirectory,
																										pAddOnFilename));
  DateFromFile := REGEXFIND('[0-9]{8}', dsFileList[1].Name, 0);
	EXPORT FileEffectiveDate := DateFromFile[5..8] + DateFromFile[1..4];

	EXPORT full_build := SEQUENTIAL(CMS_AddOn.Create_Supers.All,
																	spray_,
																	CMS_AddOn.Build_Base(pversion,
																	                     pUseProd,
																						           FileEffectiveDate,
																						           pBaseFile).All,
																	// There are no keys for this product
																	CMS_AddOn.Promote(pversion, pUseProd, pDelete := TRUE).buildfiles.Built2QA,
																	FileServices.StartSuperFileTransaction(),
																	FileServices.AddSuperFile(CMS_AddOn.Filenames(, pUseProd).lInputHistTemplate, CMS_AddOn.Filenames(pversion, pUseProd).lInputTemplate),
																	FileServices.ClearSuperFile(CMS_AddOn.Filenames(, pUseProd).lInputTemplate),
																	FileServices.FinishSuperFileTransaction(),
																	CMS_AddOn.Build_Compare(pversion).All,
																	CMS_AddOn.QA_Records(),
																	CMS_AddOn.Strata_Population_Stats(pversion,
																													          pIsTesting,
																													          pOverwrite,
																													          pBaseBuilt).All
																 ): SUCCESS(CMS_AddOn.Send_Emails(pversion, pUseProd).BuildSuccess),
																	  FAILURE(CMS_AddOn.Send_Emails(pversion, pUseProd).BuildFailure);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
	                 full_build,
									 OUTPUT('No Valid version parameter passed, skipping CMS_AddOn.Build_All'));

END;
