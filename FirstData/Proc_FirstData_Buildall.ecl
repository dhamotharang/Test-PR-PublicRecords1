﻿IMPORT FirstData, BuildLogger, VersionControl, STD, Orbit3, RoxieKeyBuild;

EXPORT Proc_FirstData_buildall(
	STRING  pVersion   = (STRING)STD.Date.Today(),
	STRING  pServerIP  = FirstData.Constants(pVersion).serverIP,
	STRING  pDirectory = FirstData.Constants(pVersion).Directory + pVersion + '/',
	STRING  pFilename  = '*csv',
	STRING  pContacts  = Email_Notification_Lists().BuildSuccess, 
	STRING  pGroupName = _Dataset().pGroupname,
	BOOLEAN pIsTesting = FALSE,
	BOOLEAN pOverwrite = FALSE
) := MODULE

	// Spray files.
	EXPORT SprayFiles := IF(pDirectory != '',FirstData.fSprayFiles(
			pVersion,
			pServerIP,
			pDirectory,
			pFilename,
			pGroupName,
			pIsTesting,
			pOverwrite
		)
	);

	// All filenames associated with this Dataset
	SHARED dAll_filenames := Filenames().dAll_filenames;

	// Full Build
	EXPORT full_build := SEQUENTIAL(
		BuildLogger.BuildStart(false),
		BuildLogger.PrepStart(false),
		versioncontrol.mUtilities.createsupers(dAll_filenames),
		SprayFiles,
		BuildLogger.PrepEnd(false),
		BuildLogger.BaseStart(False),
		FirstData.Build_BaseFile(pversion).ALL,
		BuildLogger.BaseEnd(False),
		BuildLogger.PostStart(False),
		FirstData.QA_Records(),
		// FirstData.Strata_Population_Stats(pversion,pIsTesting).All,
		BuildLogger.PostEnd(False),
		BuildLogger.BuildEnd(false)
	): 
	SUCCESS(
		Send_Emails(
			pversion,,,,
			pContacts,
			RoxieKeyBuild.Email_Notification_List + ';' + pContacts
		).BuildSuccess
	),
	FAILURE(
		Send_Emails(
			pversion,,,,
			pContacts,
			RoxieKeyBuild.Email_Notification_List + ';' + pContacts
		).BuildFailure
	);

	EXPORT All :=
	IF(VersionControl.IsValidVersion(pversion)
		,full_build
		,OUTPUT('No Valid version parameter passed, skipping FirstData.Proc_FirstData_Buildall().All')
	);
END;
