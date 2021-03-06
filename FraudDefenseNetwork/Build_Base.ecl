import tools,FraudShared;

export Build_Base(

	 string																				pversion
	,boolean                                      PSkipSuspectIP                    = false 
	,boolean                                      PSkipGlb5Base                     = false 
	,boolean                                      pSkipTigerBase                    = false
	,boolean                                      pSkipCFNABase                     = false
	//,boolean                                      pSkipCrimBase                     = false
	,boolean                                      pSkipTextMinedCrimBase            = false
	,boolean                                      pSkipOIGBase                      = false
	,boolean                                      pSkipAInspection                  = false
	,dataset(FraudShared.Layouts.Base.Main)				pBaseMainFile										  =	FraudShared.Files().Base.Main.QA

  ,dataset(Layouts.Base.SuspectIP)						  pBaseSuspectIPFile							  =	Files().Base.SuspectIP.QA
	,dataset(Layouts.Input.SuspectIP)	            pUpdateSuspectIPFile	            =	Files().Input.SuspectIP.Sprayed
	,boolean                                      pUpdateSuspectIPflag              = _Flags.Update.SuspectIP

  ,dataset(Layouts.Base.Glb5)							      pBaseGlb5File							        =	Files().Base.Glb5.QA
	,dataset(Layouts.Input.Glb5)	                pUpdateGlb5File	                  =	Files().Input.Glb5.Sprayed
	,boolean                                      pUpdateGlb5flag                   = _Flags.Update.Glb5
	
	,dataset(Layouts.Base.Tiger)							    pBaseTigerFile							      =	Files().Base.Tiger.QA
	,dataset(Layouts.Input.Tiger)	                pUpdateTigerFile	                =	Files().Input.Tiger.Sprayed
	,boolean                                      pUpdateTigerflag                  = _Flags.Update.Tiger
	
	,dataset(Layouts.Base.cfna)							      pBasecfnaFile							        =	Files().Base.cfna.QA
	,dataset(Layouts.Input.cfna)	                pUpdatecfnaFile	                  =	Files().Input.cfna.Sprayed
	,boolean                                      pUpdatecfnaflag                   = _Flags.Update.cfna
  
	//,dataset(Layouts.Base.crim)							      pBasecrimFile							        =	Files().Base.crim.QA
	//,dataset(Layouts.Input.crim)	              pUpdatecrimFile	                  =	Files().Input.crim.Sprayed
	//,boolean                                      pUpdatecrimflag                   = _Flags.Update.crim
  
	,dataset(Layouts.Base.TextMinedCrim)					pBaseTextMinedCrimFile				    =	Files().Base.TextMinedCrim.QA
	,boolean                                      pUpdateTextMinedCrimflag          = _Flags.Update.TextMinedCrim
  
	,dataset(Layouts.Base.OIG)				          	pBaseOIGFile				              =	Files().Base.OIG.QA
	,boolean                                      pUpdateOIGflag                    = _Flags.Update.OIG
  
	,dataset(Layouts.Base.AInspection)						pBaseAInspectionFile							=	Files().Base.AInspection.QA
	,dataset(Layouts.Input.AInspection)	          pUpdateAInspectionFile	          =	Files().Input.AInspection.Sprayed
	,boolean                                      pUpdateAInspectionflag            = _Flags.Update.AInspection

) :=
module

	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,sequential(
			 parallel(
				  if(PSkipSuspectIP , output('SuspectIP base skipped')
					,Build_Base_SuspectIP(
					 pversion
					,pBaseSuspectIPFile
					,pUpdateSuspectIPFile
					,pUpdateSuspectIPflag
					).All)
				  ,if(PSkipGlb5Base , output('GLB5 base skipped')
					,Build_Base_Glb5(
					 pversion
					,pBaseGlb5File
					,pUpdateGlb5File
					,pUpdateGlb5flag
					).All)
				,if(pSkipTigerBase , output('Tiger base skipped')
				,Build_Base_Tiger(
				  pversion
					,pBaseTigerFile
					,pUpdateTigerFile
					,pUpdateTigerflag
					).All)
				,if(pSkipCFNABase , output('CFNA base skipped')
				,Build_Base_CFNA(
				  pversion
					,pBaseCFNAFile
					,pUpdateCFNAFile
					,pUpdateCFNAflag
					).All)
				//,if(pSkipCrimBase , output('Crim base skipped')	
				//,Build_Base_Crim(
				  //pversion
					//,pBaseCrimFile
					//,pUpdateCrimFile  // full replacement base files are fed in the build 
					//,pUpdateCrimflag
					//).All)
				,if(pSkipTextMinedCrimBase , output('TextMinedCrim base skipped')	
				,Build_Base_TextMinedCrim(
				  pversion
					,pBaseTextMinedCrimFile
					//,pUpdateTextMinedCrimFile  // full replacement base files are fed in the build 
					,pUpdateTextMinedCrimflag
					).All)
				,if(pSkipOIGBase , output('OIG base skipped')	
				,Build_Base_OIG(
				  pversion
					,pBaseOIGFile
					//,pUpdateOIGFile  
					,pUpdateOIGflag
					).All)
				,if(pSkipAInspection , output('AInspection base skipped')	
				,Build_Base_AInspection(
				  pversion
					,pBaseAInspectionFile
					,pUpdateAInspectionFile
				//	,pUpdateAInspectionflag  its static file no updates 
					).All)
			 )
			 ,MapToCommon(
					 pversion
			 ).Build_Base_Shared_Main.All
			//,Promote().Inputfiles.Sprayed2Using
		 )
		,output('No Valid version parameter passed, skipping FDN.Build_Base atribute')
	 );
		
end;

 