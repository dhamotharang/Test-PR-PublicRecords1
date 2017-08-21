IMPORT Infogroup, lib_fileservices, RoxieKeyBuild, tools;

EXPORT Build_All(
  STRING													pversion,
	STRING													pDirectory	= '/data/data_build_5_2/prolic/Infogroup/data/' + pversion,
	STRING													pServerIP		= Infogroup._Dataset().IPAddress,
	BOOLEAN 												pUseProd    = FALSE,
	BOOLEAN													pIsTesting	= FALSE,
	BOOLEAN													pOverwrite	= FALSE,
	STRING  												pNameOutput = 'Infogroup Info Spray',
	DATASET(Infogroup.Layouts.Base)	pBaseFile		=	IF(Infogroup._Flags(pUseProd).Update,
	                                                 Infogroup.Files(pversion, pUseProd).Base.QA,
																						       DATASET([], Infogroup.Layouts.Base)),
	DATASET(Infogroup.Layouts.Base)	pBaseBuilt	= Infogroup.Files(pversion).Base.Built) := MODULE

	EXPORT spray_ := tools.fun_Spray(Infogroup.fSpray(pversion, pUseProd, pServerIP, pDirectory),
	                                    pOverwrite := pOverwrite, pIsTesting := pIsTesting,
																			pOutputName := pNameOutput);
	
	mailTarget := Infogroup.Email_Notification_Lists.BuildFailure;
	SHARED send_mail(STRING pSubject, STRING pBody) := lib_fileservices.FileServices.SendEmail(mailTarget, pSubject, pBody);

	EXPORT full_build :=
	  SEQUENTIAL(Infogroup.Create_Supers.All,
							 spray_,
							 // If the input file wasn't sprayed, we do not want to continue.
							 IF(Infogroup._Flags().FileExists.Input,
								  SEQUENTIAL(
							      Scrub_Infogroup(pversion).All,
									  Infogroup.Build_Base(pversion,
										                     pUseProd,
																	       pBaseFile).All,
									  // There are no keys for this product, currently
									  Infogroup.Promote(pDelete := TRUE).buildfiles.Built2QA,
									  Infogroup.Promote_Input_Files(pversion).All,
									  Infogroup.QA_Records(),
									  Infogroup.Strata_Stats(pversion,
																		       pIsTesting,
																		       pOverwrite,
																		       pBaseBuilt).All),
								  SEQUENTIAL(
									  send_mail('STOP IMMEDIATELY - Infogroup',
										  'The input file was not sprayed to the THOR.  Look into why the file is ' +
											   'missing.  Workunit of failed build is ' + thorlib.wuid()),
									  FAIL('MISSING INPUT FILE')))
							) : SUCCESS(Infogroup.Send_Emails(pversion).BuildSuccess),
									FAILURE(Infogroup.Send_Emails(pversion).BuildFailure);
	
	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
		               full_build,
		               OUTPUT('No Valid version parameter passed, skipping Infogroup.Build_All'));

END;