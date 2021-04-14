IMPORT RoxieKeyBuild, tools, _control, Orbit3, standard, dops;

EXPORT Build_All(
                  STRING                           pversion,
                //All sources are not updated each build if no updates to particular source skip that source base
                  BOOLEAN PSkipSuspectIP           = FALSE,
                  BOOLEAN PSkipGlb5Base            = FALSE,
                  BOOLEAN pSkipTigerBase           = FALSE,
                  BOOLEAN pSkipCFNABase            = FALSE,
                  BOOLEAN pskipTextMinedCrimBase   = FALSE,
                  BOOLEAN pskipOIGBase             = FALSE,
                  BOOLEAN pSkipAInspection         = FALSE,
                  BOOLEAN pSkipErieBase            = FALSE,
                  BOOLEAN pSkipErieWatchListBase   = FALSE,
                  STRING  pDirectory               = '/data/super_credit/fdn/in',
                  STRING  pServerIP                = IF (_control.ThisEnvironment.Name <> 'Prod_Thor', _control.IPAddress.bctlpedata12, _control.IPAddress.bctlpedata10),
                  BOOLEAN pIsTesting               = FALSE,
                  BOOLEAN pOverwrite               = FALSE,
                  BOOLEAN pReplicate               = FALSE,
                  STRING  pFilenameSuspectIP       = '*suspicious_ip*',
                  STRING  pFilenameTiger           = '*Tiger*txt',
                  STRING  pFilenameCFNA            = '*CFNA*txt',
                  STRING  pFilenameErie            = 'FDN_ERIE_CF*txt', //FDN_ERIE_CF_YYYYMMDD.txt
                  STRING  pFilenameErieWatchList   = 'FDN_ERIE_WL*txt', //FDN_ERIE_WL_YYYYMMDD.txt
                  STRING  pGroupName               = _dataset().groupname,
                  DATASET(Layouts.Base.Main) pBaseMainFile            = IF(_Flags.Update.Main, Files().Base.Main.QA, DATASET([], Layouts.Base.Main)),
                  DATASET(Layouts.Base.SuspectIP)        pBaseSuspectIPFile       = IF(_Flags.Update.SuspectIP, Files().Base.SuspectIP.QA, DATASET([], Layouts.Base.SuspectIP)),
                  DATASET(Layouts.Base.GLB5)             pBaseGLB5File            = IF(_Flags.Update.GLB5, Files().Base.GLB5.QA, DATASET([], Layouts.Base.GLB5)),
                  DATASET(Layouts.Base.Tiger)            pBaseTigerFile           = IF(_Flags.Update.Tiger, Files().Base.Tiger.QA, DATASET([], Layouts.Base.Tiger)),
                  DATASET(Layouts.Base.CFNA)             pBaseCFNAFile            = IF(_Flags.Update.CFNA, Files().Base.CFNA.QA, DATASET([], Layouts.Base.CFNA)),
                  DATASET(Layouts.Base.TextMinedCrim)    pBaseTextMinedCrimFile   = IF(_Flags.Update.TextMinedCrim, Files().Base.TextMinedCrim.QA, DATASET([], Layouts.Base.TextMinedCrim)),
                  DATASET(Layouts.Base.OIG)              pBaseOIGFile             = IF(_Flags.Update.OIG, Files().Base.OIG.QA, DATASET([], Layouts.Base.OIG)),
                  DATASET(Layouts.Base.Ainspection)      pBaseAinspectionFile     = IF(_Flags.Update.Ainspection, Files().Base.Ainspection.QA, DATASET([], Layouts.Base.Ainspection)),
                  DATASET(Layouts.Base.Erie)             pBaseErieFile            = IF(_Flags.Update.Erie, Files().Base.Erie.QA, DATASET([], Layouts.Base.Erie)),
                  DATASET(Layouts.Base.ErieWatchList)    pBaseErieWatchListFile   = IF(_Flags.Update.ErieWatchList, Files().Base.ErieWatchList.QA, DATASET([], Layouts.Base.ErieWatchList)),
                  DATASET(Layouts.Input.SuspectIP)       pUpdateSuspectIPFile     = Files().Input.SuspectIP.Sprayed,
                  DATASET(Layouts.Input.GLB5)            pUpdateGLB5File          = Files().Input.GLB5.Sprayed,
                  DATASET(Layouts.Input.Tiger)           pUpdateTigerFile         = Files().Input.Tiger.Sprayed,
                  DATASET(Layouts.Input.CFNA)            pUpdateCFNAFile          = Files().Input.CFNA.Sprayed,
                  DATASET(Layouts.Input.Ainspection)     pUpdateAinspectionFile   = Files().Input.Ainspection.Sprayed,
                  DATASET(Layouts.Input.Erie)            pUpdateErieFile          = Files().Input.Erie.Sprayed,
                  DATASET(Layouts.Input.ErieWatchList)   pUpdateErieWatchListFile = Files().Input.ErieWatchList.Sprayed,
                  DATASET(Layouts.Base.Main) pBaseMainBuilt           = File_keybuild(Files(pversion).Base.Main.Built),
                   
                //This below flag is to run full file or update append if pUpdateGLB5flag = FALSE full file run and true runs update append of the base file
                  BOOLEAN pUpdateSuspectIPflag     = FraudDefenseNetwork._Flags.Update.SuspectIP,
                  BOOLEAN pUpdateGLB5flag          = FraudDefenseNetwork._Flags.Update.GLB5,
                  BOOLEAN pUpdateTigerflag         = FraudDefenseNetwork._Flags.Update.Tiger,
                  BOOLEAN pUpdateCFNAflag          = FraudDefenseNetwork._Flags.Update.CFNA,
                  BOOLEAN pUpdateTextMinedCrimflag = FraudDefenseNetwork._Flags.Update.TextMinedCrim,
                  BOOLEAN pUpdateOIGflag           = FraudDefenseNetwork._Flags.Update.OIG,
                  BOOLEAN pUpdateAInspectionflag   = FraudDefenseNetwork._Flags.Update.AInspection,
                  BOOLEAN pUpdateErieflag          = FraudDefenseNetwork._Flags.Update.Erie,
                  BOOLEAN pUpdateErieWatchListflag = FraudDefenseNetwork._Flags.Update.ErieWatchList
                ) := MODULE

  SHARED modSendEmail := Mod_SendEmail(Constants().BuildName, pversion);
	
	EXPORT spray_files := SprayFiles(
                                    pServerIP,
                                    pDirectory,
                                    pFilenameSuspectIP,
                                    pFilenameTiger,
                                    pFilenameCFNA,
                                    pFilenameErie,
                                    pFilenameErieWatchList,
                                    pversion,
                                    pGroupName,
                                    pIsTesting,
                                    pOverwrite,
                                    pReplicate
                                  );

  EXPORT sprayMBS_files := SprayMBSFiles(pServerIP, pDirectory, pversion := pversion);
  EXPORT spray_fdn_files := parallel(sprayMBS_files, spray_files);

  SHARED base_portion := sequential(
                                    fn_CreateSuperFiles(), spray_files, sprayMBS_files,
                                      Build_Base(
                                                  pversion,
                                                  PSkipSuspectIP,
                                                  PSkipGlb5Base,
                                                  pSkipTigerBase,
                                                  pSkipCFNABase,
                                                  pSkipTextMinedCrimBase,
                                                  pSkipOIGBase,
                                                  pSkipAInspection,
                                                  pSkipErieBase,
                                                  pSkipErieWatchListBase,
                                                  pBaseMainFile,
                                                  pBaseSuspectIPFile,
                                                  pUpdateSuspectIPFile,
                                                  pUpdateSuspectIPflag,
                                                  pBaseGLB5File,
                                                  pUpdateGLB5File,
                                                  pUpdateGLB5flag,
                                                  pBaseTigerFile,
                                                  pUpdateTigerFile,
                                                  pUpdateTigerflag,
                                                  pBaseCfnaFile,
                                                  pUpdateCFNAFile,
                                                  pUpdateCFNAflag,
                                                  pBaseTextMinedCrimFile,
                                                  pUpdateTextMinedCrimflag,
                                                  pBaseOIGFile,
                                                  pUpdateOIGflag,
                                                  pBaseAinspectionFile,
                                                  pUpdateAinspectionFile,
                                                  pUpdateAinspectionflag,
                                                  pBaseErieFile,
                                                  pUpdateErieFile,
                                                  pUpdateErieflag,
                                                  pBaseErieWatchListFile,
                                                  pUpdateErieWatchListFile,
                                                  pUpdateErieWatchListflag
                                                ).All, notify('FDN BASE FILES COMPLETE', '*');
                                 ) : SUCCESS(modSendEmail.BuildSuccessEmail), FAILURE(modSendEmail.BuildFailureEmail);

  //Create build automation -- 02/14/2017
  EXPORT create_build := Orbit3.proc_Orbit3_CreateBuild ('FDN', pversion);

  EXPORT dops_update := dops.updateversion('FDNKeys',pversion, Email_Notification_Lists().Roxie,,'N');

  SHARED keys_portion := SEQUENTIAL(
                                     fn_CreateSuperFiles(),
																		 Build_Keys(pversion, pBaseMainBuilt).All,
                                     Build_AutoKeys(pversion, pBaseMainBuilt),
                                     Promote().Inputfiles.Sprayed2Using,
                                     Promote().buildfiles.Built2QA,
                                     Promote().Inputfiles.Using2Used,
                                     Promote().Used2In,
                                     Promote().buildfiles.cleanup,
                                   //Promote Shared Files
                                     Promote().Inputfiles.Sprayed2Using,
                                     Promote().buildfiles.Built2QA,
                                     Promote().Inputfiles.Using2Used,
                                     Promote().buildfiles.cleanup,
                                     QA_Records(),
                                     Strata_Population_Stats(pversion, pIsTesting, pOverwrite, pBaseMainBuilt).All,
                                     create_build,
							         dops_update) : SUCCESS(modSendEmail.BuildSuccessEmail), FAILURE(modSendEmail.BuildFailureEmail);

  EXPORT full_build := sequential(
                                  fn_CreateSuperFiles(), spray_files, sprayMBS_files,
                                     Build_Base(
                                                 pversion,
                                                 PSkipSuspectIP,
                                                 PSkipGlb5Base,
                                                 pSkipTigerBase,
                                                 pSkipCFNABase,
                                                 pSkipTextMinedCrimBase,
                                                 pSkipOIGBase,
                                                 pSkipAInspection,
                                                 pSkipErieBase,
                                                 pSkipErieWatchListBase,
                                                 pBaseMainFile,
                                                 pBaseSuspectIPFile,
                                                 pUpdateSuspectIPFile,
                                                 pUpdateSuspectIPflag,
                                                 pBaseGLB5File,
                                                 pUpdateGLB5File,
                                                 pUpdateGLB5flag,
                                                 pBaseTigerFile,
                                                 pUpdateTigerFile,
                                                 pUpdateTigerflag,
                                                 pBaseCfnaFile,
                                                 pUpdateCFNAFile,
                                                 pUpdateCFNAflag,
                                                 pBaseTextMinedCrimFile,
                                                 pUpdateTextMinedCrimflag,
                                                 pBaseOIGFile,
                                                 pUpdateOIGflag,
                                                 pBaseAinspectionFile,
                                                 pUpdateAinspectionFile,
                                                 pUpdateAinspectionflag,
                                                 pBaseErieFile,
                                                 pUpdateErieFile,
                                                 pUpdateErieflag,
                                                 pBaseErieWatchListFile,
                                                 pUpdateErieWatchListFile,
                                                 pUpdateErieWatchListflag).All,
                                                 Build_Keys(pversion, pBaseMainBuilt).All,
                                                 Build_AutoKeys(pversion, pBaseMainBuilt),
                                                 Promote().Inputfiles.Sprayed2Using,
                                                 Promote().buildfiles.Built2QA,
                                                 Promote().Inputfiles.Using2Used,
                                                 Promote().Used2In,
                                                 Promote().buildfiles.cleanup,
                                               //Promote Shared Files
                                                 Promote().Inputfiles.Sprayed2Using,
                                                 Promote().buildfiles.Built2QA,
                                                 Promote().Inputfiles.Using2Used,
                                                 Promote().buildfiles.cleanup,
                                                 QA_Records(),
                                                 Strata_Population_Stats(pversion, pIsTesting, pOverwrite, pBaseMainBuilt
                                               ).All
                                               //,dops_update
                                ) : SUCCESS(modSendEmail.BuildSuccessEmail), FAILURE(modSendEmail.BuildFailureEmail);

  EXPORT Build_Base_Files := IF(tools.fun_IsValidVersion(pversion), base_portion, OUTPUT('No Valid version parameter passed, skipping FDN.Build_All'));
  EXPORT Build_Key_Files := IF(tools.fun_IsValidVersion(pversion), keys_portion, OUTPUT('No Valid version parameter passed, skipping FDN.Build_All'));
  EXPORT All := IF(tools.fun_IsValidVersion(pversion), full_build, OUTPUT('No Valid version parameter passed, skipping FDN.Build_All'));

END;

