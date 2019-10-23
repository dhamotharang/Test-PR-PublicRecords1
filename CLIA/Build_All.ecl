IMPORT _Control, CLIA._Flags, RoxieKeyBuild, tools, Orbit3;

EXPORT Build_All(
  STRING								pversion,
  BOOLEAN               pUseAltLayout 					= FALSE,
	STRING								pDirectory							= '/data/data_build_4/CLIA/data',
	STRING								pServerIP								= _Control.IPAddress.bctlpedata11,
	BOOLEAN								pIsTesting							= FALSE,
	BOOLEAN								pOverwrite							= FALSE,
	BOOLEAN								pReplicate							=	FALSE,
	STRING	              pFilenameAll   					= '*all*clia*csv',
	STRING	              pFilenameAllFromCD			= '*clia*txt',
	STRING	              pFilenameAccreditation  = '*accred*csv',
	STRING	              pFilenameCompliance   	= '*compliance*csv',
	STRING	              pFilenameMicroscopy   	= '*microscopy*csv',
	STRING	              pFilenameWaiver   			= '*wa*csv',
	STRING								pGroupName							= _Dataset().groupname,
	DATASET(Layouts.Base)	pBaseFile								=	IF(_Flags.Update, Files().Base.Main.QA, DATASET([], Layouts.Base)),
	DATASET(Layouts.Base)	pBaseBuilt							= Files(pversion).Base.Main.Built) := MODULE

	EXPORT spray_files := SprayFiles(pServerIP,
		                               pDirectory,
		                               pFilenameAll,
		                               pFilenameAllFromCD,
		                               pFilenameAccreditation,
		                               pFilenameCompliance,
		                               pFilenameMicroscopy,
		                               pFilenameWaiver,
		                               pversion,
		                               pGroupName,
		                               pIsTesting,
		                               pOverwrite,
		                               pReplicate);
	
	EXPORT dops_update := RoxieKeyBuild.updateversion('CLIAKeys', pversion, _Control.MyInfo.EmailAddressNotify,,'N'); 															

EXPORT orbit_update := Orbit3.proc_Orbit3_CreateBuild_AddItem('CLIA',pversion,'N'); 

	EXPORT full_build :=
	   SEQUENTIAL(Create_Supers,
		            spray_files,
		            Build_Base(pversion,
			                     pBaseFile,
													 pUseAltLayout).All,
								Build_AutoKeys(pversion,
															 pBaseBuilt),
								Build_Roxie_Keys(pversion,
																 pBaseBuilt).All,
		            Promote().buildfiles.Built2QA,
		            Promote().Inputfiles.Using2Used,
								QA_Records(),
								Strata_Population_Stats(pversion,
																		    pIsTesting,
																		    pOverwrite,
																		    pBaseBuilt).All,
								dops_update,
								orbit_update
	             ) : SUCCESS(Send_Emails(pversion, , FALSE).Roxie), FAILURE(Send_Emails(pversion, , FALSE).BuildFailure);
	
	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
		               full_build,
		               OUTPUT('No Valid version parameter passed, skipping CLIA.Build_All'));

END;