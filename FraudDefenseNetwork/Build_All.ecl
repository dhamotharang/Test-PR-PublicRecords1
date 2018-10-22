import RoxieKeyBuild, tools, _control, Orbit3, FraudShared;

export Build_All(

	 string																				pversion
	// All sources are not updated each build if no updates to particular source skip that source base 
  ,boolean                                      PSkipSuspectIP                  = false 
  ,boolean                                      PSkipGlb5Base                   = false 
	,boolean                                      pSkipTigerBase                  = false
	,boolean                                      pSkipCFNABase                   = false
	,boolean                                      pskipTextMinedCrimBase          = false 
  ,boolean                                      pskipOIGBase                    = false 
	,boolean                                      pSkipAInspection                = false       
	,boolean                                      pSkipErieBase                   = false       
	,boolean                                      pSkipErieWatchListBase          = false       
	,string																				pDirectory											= '/data/super_credit/fdn/in'
	,string																				pServerIP												= IF (_control.ThisEnvironment.Name <> 'Prod_Thor', _control.IPAddress.bctlpedata12, _control.IPAddress.bctlpedata10)
	,boolean																			pIsTesting											= false
	,boolean																			pOverwrite											= false																															
	,boolean																			pReplicate											=	false
	,string		                                    pFilenameSuspectIP              = '*suspicious_ip*'
	,string		                                    pFilenameTiger                  = '*Tiger*txt'
	,string		                                    pFilenameCFNA                   = '*CFNA*txt'
	,string		                                    pFilenameErie                   = 'FDN_ERIE_CF*txt' //FDN_ERIE_CF_YYYYMMDD.txt
	,string		                                    pFilenameErieWatchList          = 'FDN_ERIE_WL*txt' //FDN_ERIE_WL_YYYYMMDD.txt 
	,string																				pGroupName											= _dataset().groupname																		
	,dataset(FraudShared.Layouts.Base.Main)				pBaseMainFile										=	IF(_Flags.Update.Main, FraudShared.Files().Base.Main.QA, DATASET([], FraudShared.Layouts.Base.Main))
	,dataset(Layouts.Base.SuspectIP)			        pBaseSuspectIPFile					    =	IF(_Flags.Update.SuspectIP, Files().Base.SuspectIP.QA, DATASET([], Layouts.Base.SuspectIP))
	,dataset(Layouts.Base.GLB5)							      pBaseGLB5File							      =	IF(_Flags.Update.GLB5, Files().Base.GLB5.QA, DATASET([], Layouts.Base.GLB5))
	,dataset(Layouts.Base.Tiger)							    pBaseTigerFile							    =	IF(_Flags.Update.Tiger, Files().Base.Tiger.QA, DATASET([], Layouts.Base.Tiger))
	,dataset(Layouts.Base.CFNA)							      pBaseCFNAFile							      =	IF(_Flags.Update.CFNA, Files().Base.CFNA.QA, DATASET([], Layouts.Base.CFNA))
	,dataset(Layouts.Base.TextMinedCrim)          pBaseTextMinedCrimFile		      =	IF(_Flags.Update.TextMinedCrim, Files().Base.TextMinedCrim.QA, DATASET([], Layouts.Base.TextMinedCrim))
	,dataset(Layouts.Base.OIG)                    pBaseOIGFile							      =	IF(_Flags.Update.OIG, Files().Base.OIG.QA, DATASET([], Layouts.Base.OIG))
	,dataset(Layouts.Base.Ainspection)						pBaseAinspectionFile						=	IF(_Flags.Update.Ainspection, Files().Base.Ainspection.QA, DATASET([], Layouts.Base.Ainspection))
	,dataset(Layouts.Base.Erie)						        pBaseErieFile						       =	IF(_Flags.Update.Erie, Files().Base.Erie.QA, DATASET([], Layouts.Base.Erie))
	,dataset(Layouts.Base.ErieWatchList)						pBaseErieWatchListFile	       =	IF(_Flags.Update.ErieWatchList, Files().Base.ErieWatchList.QA, DATASET([], Layouts.Base.ErieWatchList))
	,dataset(Layouts.Input.SuspectIP)	            pUpdateSuspectIPFile	          =	Files().Input.SuspectIP.Sprayed
	,dataset(Layouts.Input.GLB5)	                pUpdateGLB5File	                =	Files().Input.GLB5.Sprayed
	,dataset(Layouts.Input.Tiger)	                pUpdateTigerFile	              =	Files().Input.Tiger.Sprayed
	,dataset(Layouts.Input.CFNA)	                pUpdateCFNAFile	                =	Files().Input.CFNA.Sprayed
	,dataset(Layouts.Input.Ainspection)	          pUpdateAinspectionFile	        =	Files().Input.Ainspection.Sprayed
	,dataset(Layouts.Input.Erie)	                pUpdateErieFile	                =	Files().Input.Erie.Sprayed
	,dataset(Layouts.Input.ErieWatchList)         pUpdateErieWatchListFile	      = Files().Input.ErieWatchList.Sprayed
	,dataset(FraudShared.Layouts.Base.Main)				pBaseMainBuilt									= File_keybuild(FraudShared.Files(pversion).Base.Main.Built)
	// This below flag is to run full file or update append if pUpdateGLB5flag = false full file run and true runs update append of the base file
	,boolean                                      pUpdateSuspectIPflag            = FraudDefenseNetwork._Flags.Update.SuspectIP
	,boolean                                      pUpdateGLB5flag                 = FraudDefenseNetwork._Flags.Update.GLB5
  ,boolean                                      pUpdateTigerflag                = FraudDefenseNetwork._Flags.Update.Tiger
	,boolean                                      pUpdateCFNAflag                 = FraudDefenseNetwork._Flags.Update.CFNA
	,boolean                                      pUpdateTextMinedCrimflag        = FraudDefenseNetwork._Flags.Update.TextMinedCrim
	,boolean                                      pUpdateOIGflag                  = FraudDefenseNetwork._Flags.Update.OIG
	,boolean                                      pUpdateAInspectionflag          = FraudDefenseNetwork._Flags.Update.AInspection
	,boolean                                      pUpdateErieflag                 = FraudDefenseNetwork._Flags.Update.Erie
	,boolean                                      pUpdateErieWatchListflag        = FraudDefenseNetwork._Flags.Update.ErieWatchList
         
) :=
module

	export spray_files := SprayFiles(
		 pServerIP
		,pDirectory 
		,pFilenameSuspectIP
		,pFilenameTiger
		,pFilenameCFNA
		,pFilenameErie
		,pFilenameErieWatchList
		,pversion
		,pGroupName
		,pIsTesting
		,pOverwrite
		,pReplicate
	);
	
//	export dops_update := RoxieKeyBuild.updateversion('FDNKeys', pversion, _Control.MyInfo.EmailAddressNotify,,'N'); 															

	export sprayMBS_files := FraudShared.SprayMBSFiles(
		pServerIP,
		pDirectory, 
		pversion := pversion
	);

  export spray_fdn_files := parallel(sprayMBS_files, spray_files);
 
 
	shared base_portion := sequential(
		   Create_Supers
		  ,spray_files
			,sprayMBS_files
		  ,Build_Base(
			 pversion
			,PSkipSuspectIP
			,PSkipGlb5Base
			,pSkipTigerBase
			,pSkipCFNABase
			,pSkipTextMinedCrimBase
			,pSkipOIGBase
			,pSkipAInspection
			,pSkipErieBase
			,pSkipErieWatchListBase
			,pBaseMainFile	
			,pBaseSuspectIPFile
			,pUpdateSuspectIPFile	
			,pUpdateSuspectIPflag	
			,pBaseGLB5File
			,pUpdateGLB5File	
			,pUpdateGLB5flag
			,pBaseTigerFile
			,pUpdateTigerFile	
			,pUpdateTigerflag
			,pBaseCfnaFile
			,pUpdateCFNAFile	
			,pUpdateCFNAflag
			,pBaseTextMinedCrimFile
			,pUpdateTextMinedCrimflag
			,pBaseOIGFile
			,pUpdateOIGflag
			,pBaseAinspectionFile
			,pUpdateAinspectionFile	
			,pUpdateAinspectionflag
			,pBaseErieFile
			,pUpdateErieFile	
			,pUpdateErieflag
			,pBaseErieWatchListFile
			,pUpdateErieWatchListFile	
			,pUpdateErieWatchListflag
		
		).All
			,notify('FDN BASE FILES COMPLETE','*');
			
	) : success(Send_Emails(pversion).Roxie), failure(Send_Emails(pversion).BuildFailure);
	
//Create build automation	-- 02/14/2017
export	create_build := Orbit3.proc_Orbit3_CreateBuild_AddItem ( 'FDN',pversion);
	
	
	shared keys_portion := sequential(
		   FraudShared.Build_Keys(
			 pversion
			,pBaseMainBuilt
			).All
		  ,FraudShared.Build_AutoKeys(
			 pversion
			,pBaseMainBuilt)
		  ,Promote().Inputfiles.Sprayed2Using
		  ,Promote().buildfiles.Built2QA
		  ,Promote().Inputfiles.Using2Used
		  ,Promote().Used2In
			,Promote().buildfiles.cleanup
			// Promote Shared Files
			,FraudShared.Promote().Inputfiles.Sprayed2Using
			,FraudShared.Promote().buildfiles.Built2QA			
			,FraudShared.Promote().Inputfiles.Using2Used
			,FraudShared.Promote().buildfiles.cleanup					
		,QA_Records()
		,Strata_Population_Stats(
			 pversion
			,pIsTesting
			,pOverwrite
			,pBaseMainBuilt
			).All
	  ,create_build
	) : success(Send_Emails(pversion).Roxie), failure(Send_Emails(pversion).BuildFailure);

	export full_build := sequential(
		  Create_Supers
		  ,spray_files
			,sprayMBS_files
      ,Build_Base(
			 pversion
			,PSkipSuspectIP
			,PSkipGlb5Base
			,pSkipTigerBase
			,pSkipCFNABase
			,pSkipTextMinedCrimBase
			,pSkipOIGBase
			,pSkipAInspection
			,pSkipErieBase
			,pSkipErieWatchListBase
			,pBaseMainFile	
			,pBaseSuspectIPFile
			,pUpdateSuspectIPFile	
			,pUpdateSuspectIPflag	
			,pBaseGLB5File
			,pUpdateGLB5File	
			,pUpdateGLB5flag
			,pBaseTigerFile
			,pUpdateTigerFile	
			,pUpdateTigerflag
			,pBaseCfnaFile
			,pUpdateCFNAFile	
			,pUpdateCFNAflag
			,pBaseTextMinedCrimFile	
			,pUpdateTextMinedCrimflag
			,pBaseOIGFile
			,pUpdateOIGflag
			,pBaseAinspectionFile
			,pUpdateAinspectionFile	
			,pUpdateAinspectionflag
			,pBaseErieFile
			,pUpdateErieFile	
			,pUpdateErieflag
			,pBaseErieWatchListFile
			,pUpdateErieWatchListFile	
			,pUpdateErieWatchListflag
		
		).All
		  ,FraudShared.Build_Keys(
			 pversion
			,pBaseMainBuilt
			).All
		,FraudShared.Build_AutoKeys(
			 pversion
			,pBaseMainBuilt)
		  ,Promote().Inputfiles.Sprayed2Using
		  ,Promote().buildfiles.Built2QA
		  ,Promote().Inputfiles.Using2Used
		  ,Promote().Used2In
		  ,Promote().buildfiles.cleanup
			// Promote Shared Files
			,FraudShared.Promote().Inputfiles.Sprayed2Using
			,FraudShared.Promote().buildfiles.Built2QA			
			,FraudShared.Promote().Inputfiles.Using2Used
			,FraudShared.Promote().buildfiles.cleanup				
		,QA_Records()
		,Strata_Population_Stats(
			 pversion
			,pIsTesting
			,pOverwrite
			,pBaseMainBuilt
			).All
	//	,dops_update

	) : success(Send_Emails(pversion).Roxie), failure(Send_Emails(pversion).BuildFailure);
	
	export Build_Base_Files :=
	if(tools.fun_IsValidVersion(pversion)
		,base_portion
		,output('No Valid version parameter passed, skipping FDN.Build_All')
	);

	export Build_Key_Files :=
	if(tools.fun_IsValidVersion(pversion)
		,keys_portion
		,output('No Valid version parameter passed, skipping FDN.Build_All')
	);

	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping FDN.Build_All')
	);

end;