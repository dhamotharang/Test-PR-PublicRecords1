IMPORT _Control, RoxieKeyBuild, tools;

EXPORT Build_All(
  STRING								pversion,
	STRING								pDirectory							= '/data/data_build_4/Death_MI/data',
	STRING								pServerIP								= _Control.IPAddress.bctlpedata10,
	BOOLEAN								pIsTesting							= FALSE,
	BOOLEAN								pOverwrite							= FALSE,
	BOOLEAN								pReplicate							=	FALSE,
	STRING								pFilenameDeath					= '5655*',
	STRING								pFilenameDeathIL				= '5758*',
	STRING								pGroupName							= _Dataset().groupname,
	DATASET(Layouts.Base)	pBaseFile								=	IF(_Flags.Update, Files().Base.Main.QA, DATASET([], Layouts.Base)),
	DATASET(Layouts.Base)	pBaseBuilt							= Files(pversion).Base.Main.Built) := MODULE

	EXPORT spray_files := SprayFiles(pServerIP,
		                               pDirectory,
		                               pFilenameDeath,
		                               pFilenameDeathIL,
		                               pversion,
		                               pGroupName,
		                               pIsTesting,
		                               pOverwrite,
		                               pReplicate);
	
	EXPORT dops_update := RoxieKeyBuild.updateversion('Death_MIKeys', pversion, _Control.MyInfo.EmailAddressNotify, , 'N'); 															

	EXPORT full_build := SEQUENTIAL(Create_Supers,
																	spray_files,
																	IF(Death_MI._Flags.FileExists.Input.Death OR
																	      Death_MI._Flags.FileExists.Input.Death_IL,
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
																		 FAIL('No files sprayed for Death MI'))
																 ) : SUCCESS(Send_Emails(pversion).Roxie),
																		 FAILURE(Send_Emails(pversion).BuildFailure);
	
	EXPORT All := IF(tools.fun_IsValidVersion(pversion) AND pversion <= thorlib.wuid()[2..9],
		               full_build,
		               OUTPUT('No Valid version parameter passed, skipping Death_MI.Build_All'));

END;