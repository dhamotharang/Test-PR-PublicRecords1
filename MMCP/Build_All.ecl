IMPORT _Control, RoxieKeyBuild, tools;

EXPORT Build_All(
  STRING								pversion,
	STRING								pDirectory							= '/data/hds_4/MMCP/data',
	STRING								pServerIP								= _Control.IPAddress.bctlpedata10,
	BOOLEAN								pIsTesting							= FALSE,
	BOOLEAN								pOverwrite							= FALSE,
	BOOLEAN								pReplicate							=	FALSE,
	STRING								pFilenameLicenseStatus	= '4386*',
	STRING								pFilenameLicensee 			= '4385*',
	STRING								pFilenameILLicense 			= '5757*',
	STRING								pGroupName							= _Dataset().groupname,
	DATASET(Layouts.Base)	pBaseFile								=	IF(_Flags.Update, Files().Base.Main.QA, DATASET([], Layouts.Base)),
	DATASET(Layouts.Base)	pBaseBuilt							= Files(pversion).Base.Main.Built) := MODULE

	EXPORT spray_files := SprayFiles(pServerIP,
		                               pDirectory,
		                               pFilenameLicenseStatus,
		                               pFilenameLicensee,
		                               pFilenameILLicense,
		                               pversion,
		                               pGroupName,
		                               pIsTesting,
		                               pOverwrite,
		                               pReplicate);
	
	EXPORT dops_update := RoxieKeyBuild.updateversion('MMCPKeys', pversion, _Control.MyInfo.EmailAddressNotify,,'N'); 															

	EXPORT full_build := SEQUENTIAL(Create_Supers,
																	spray_files,
																	IF(MMCP._Flags.FileExists.Input.License_Status AND
																	      MMCP._Flags.FileExists.Input.Licensee OR
																				MMCP._Flags.FileExists.Input.IL_License,
																		 SEQUENTIAL(Build_Base(pversion,
																													 pBaseFile).All,
																								Build_AutoKeys(pversion,
																															 pBaseBuilt),
																								Build_Roxie_Keys(pversion,
																																 pBaseBuilt).All,
																								Promote(pDelete := TRUE).buildfiles.Built2QA,
																								Promote(pDelete := TRUE).Inputfiles.Using2Used,
																								QA_Records(),
																								Strata_Population_Stats(pversion,
																																				pIsTesting,
																																				pOverwrite,
																																				pBaseBuilt).All,
																								dops_update),
																		 FAIL('No files sprayed for MMCP'))
																 ) : SUCCESS(Send_Emails(pversion).Roxie),
																		 FAILURE(Send_Emails(pversion).BuildFailure);
	
	EXPORT All := IF(tools.fun_IsValidVersion(pversion) AND pversion <= thorlib.wuid()[2..9],
		               full_build,
		               OUTPUT('No Valid version parameter passed, skipping MMCP.Build_All'));

END;