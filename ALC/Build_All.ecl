IMPORT _Control, ALC, lib_fileservices, RoxieKeyBuild, tools;

EXPORT Build_All(
  STRING										pversion,
	STRING										pDirectory	= '/data/hds_4/ALC/data/' + pversion,
	STRING										pServerIP		= ALC._Dataset().IPAddress,
	BOOLEAN 									pUseProd    = FALSE,
	BOOLEAN										pIsTesting	= FALSE,
	BOOLEAN										pOverwrite	= FALSE,
	STRING  									pNameOutput = 'ALC Info Spray',
	DATASET(ALC.Layouts.Base)	pBaseFile		=	IF(ALC._Flags(pUseProd).Update,
	                                           ALC.Files(pversion, pUseProd).Base.QA,
																						 DATASET([], ALC.Layouts.Base)),
	DATASET(ALC.Layouts.Base)	pBaseBuilt	= ALC.Files(pversion).Base.Built) := MODULE

	EXPORT spray_ := tools.fun_Spray(ALC.fSpray(pversion, pUseProd, pServerIP, pDirectory),
	                                    pOverwrite := pOverwrite, pIsTesting := pIsTesting,
																			pOutputName := pNameOutput);
	
	mailTarget := ALC.Email_Notification_Lists.BuildFailure;
	SHARED send_mail(STRING pSubject, STRING pBody) := lib_fileservices.FileServices.SendEmail(mailTarget, pSubject, pBody);

	EXPORT full_build :=
	  SEQUENTIAL(ALC.Create_Supers.All,
							 spray_,
							 // If all 12 input files weren't sprayed, we do not want to continue.
							 IF(ALC._Flags().FileExists.Input.Accountants AND
										 ALC._Flags().FileExists.Input.Dental_Professionals AND
										 ALC._Flags().FileExists.Input.Insurance_Agents AND
										 ALC._Flags().FileExists.Input.Lawyers AND
										 ALC._Flags().FileExists.Input.Nurses1 AND
										 ALC._Flags().FileExists.Input.Nurses2 AND
										 ALC._Flags().FileExists.Input.Nurses3 AND
										 ALC._Flags().FileExists.Input.Nurses4 AND
										 ALC._Flags().FileExists.Input.Pharmacists AND
										 ALC._Flags().FileExists.Input.Pilots AND
										 ALC._Flags().FileExists.Input.Professionals1 AND
										 ALC._Flags().FileExists.Input.Professionals2 AND
										 ALC._Flags().FileExists.Input.Professionals3,
								  SEQUENTIAL(
									  Scrub_ALC(pversion).All,
									  ALC.Build_Base(pversion,
										               pUseProd,
																	 pBaseFile).All,
									  // There are no keys for this product, currently
									  ALC.Promote(pDelete := TRUE).buildfiles.Built2QA,
									  ALC.Promote_Input_Files(pversion).All,
									  ALC.QA_Records(),
									  ALC.Strata_Stats(pversion,
																		 pIsTesting,
																		 pOverwrite,
																		 pBaseBuilt).All),
								  SEQUENTIAL(
									  send_mail('STOP IMMEDIATELY - ALC',
										  'There should be 13 input files for this product.  There were not 13 files ' +
												 'sprayed to the THOR.  Contact Data Receiving to see about the missing ' +
												 'file(s).  Workunit of failed build is ' + thorlib.wuid()),
									  FAIL('CONTACT DATA RECEIVING IMMEDIATELY')))
							) : SUCCESS(ALC.Send_Emails(pversion).BuildSuccess),
									FAILURE(ALC.Send_Emails(pversion).BuildFailure);
	
	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
		               full_build,
		               OUTPUT('No Valid version parameter passed, skipping ALC.Build_All'));

END;