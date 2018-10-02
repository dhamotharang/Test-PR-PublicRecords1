import LaborActions_MSHA, versioncontrol, _control, ut, Roxiekeybuild, Orbit3;

export Build_All(string	pversion) := module

		#workunit('name','Yogurt:LaborActions_MSHA Build - ' + pversion);
		
		//There are five base files: Mine, Operator, Events, Accident and Contractor. 
		//Note:  Mine is the primary file.
		export NewBase_Accident		:=	Update_Base_Accident( files().Mine_Input.using
																				,files().Accident_Input.using
																				,files().Base_Accident_Base.qa
																				,pversion);	
																				
		export NewBase_Contractor	:=	Update_Base_Contractor( files().Mine_Input.using
																				,files().Contractor_Input.using
																				,files().Contractor_CY_Employment_Input.using
																				,files().Contractor_QT_Employment_Input.using
																				,files().Base_Contractor_Base.qa
																				,pversion);					
	
		export NewBase_Events			:=	Update_Base_Events( files().Mine_Input.using
																				,files().Inspection_Input.using
																				,files().Violation_Input.using
																				,files().Base_Events_Base.qa
																				,pversion);																			

		export NewBase_Mine				:=	Update_Base_Mine( files().Mine_Input.using
																				,files().Controller_Hist_Input.using
																				,files().Operator_Hist_Input.using
																				,files().Base_Mine_Base.qa
																				,pversion);
																				
		export NewBase_Operator		:=	Update_Base_Operator( files().Mine_Input.using
																				,files().Operator_CY_Employment_Input.using
																				,files().Operator_QT_Employment_Input.using
																				,files().Base_Operator_Base.qa
																				,pversion);																				

		VersionControl.macBuildNewLogicalFile( Filenames('Base_Accident',pversion).base.new 
																					,NewBase_Accident
																					,Build_Base_File_Accident);			
		
		VersionControl.macBuildNewLogicalFile( Filenames('Base_Contractor',pversion).base.new 
																					,NewBase_Contractor
																					,Build_Base_File_Contractor);
		
		VersionControl.macBuildNewLogicalFile( Filenames('Base_Events',pversion).base.new 
																					,NewBase_Events
																					,Build_Base_File_Events);
		
		VersionControl.macBuildNewLogicalFile( Filenames('Base_Mine',pversion).base.new 
																					,NewBase_Mine
																					,Build_Base_File_Mine);
																					
		VersionControl.macBuildNewLogicalFile( Filenames('Base_Operator',pversion).base.new 
																					,NewBase_Operator
																					,Build_Base_File_Operator);						
																					
		dops_update := Roxiekeybuild.updateversion('LaborActionsMSHAKeys',pversion,'Randy.Reyes@lexisnexisrisk.com;Manuel.Tarectecan@lexisnexisrisk.com',,'N'); 
		orbit_update := Orbit3.proc_Orbit3_CreateBuild_AddItem('Labor Actions MSHA', pversion);
		
		full_build 	:= sequential( CreateSuperFileNames.fCreateInputBaseSuperfiles
															,SprayFiles.fSprayFiles(pversion)
															,PromoteFiles().fPromote_Sprayed2Using	
															,IF (fIs_MIneIds_Unique(files().Mine_Input.using)=FALSE,FAIL('LaborActions_MSHA.Build_All-Duplicate Mine_Ids exist in Mine file. Contact vendor.'))
															,Build_Base_File_Accident
															,Build_Base_File_Contractor
															,Build_Base_File_Events
															,Build_Base_File_Mine
															,Build_Base_File_Operator
															,PromoteFiles().fPromote_Using2Used 
															,PromoteFiles(pversion).fPromote_New2Built
															,PromoteFiles(pversion).fPromote_Built2QA
															,Proc_AutokeyBuild_Contractor(pversion,'base_contractor') 	// * Build AutoKeys *
															,Proc_AutokeyBuild_Controller(pversion,'base_mine')					// * Build AutoKeys *
															,Proc_AutokeyBuild_Mine(pversion,'base_mine') 							// * Build AutoKeys *
															,Proc_AutokeyBuild_Operator(pversion,'base_mine') 					// * Build AutoKeys *
															,Proc_Build_RoxieKeys(pversion)
															,out_STRATA_population_stats_Accident(pversion)
															,out_STRATA_population_stats_Contractor(pversion)
															,out_STRATA_population_stats_Events(pversion)
															,out_STRATA_population_stats_Mine(pversion)
															,out_STRATA_population_stats_Operator(pversion)
															,dops_update
															,orbit_update
															) : success(Sequential(send_email(pversion).buildsuccess,send_email(pversion).roxie.qa))
															  , failure(send_email(pversion).buildfailure);
   
   	export All 	:= if(VersionControl.IsValidVersion(pversion)
											,full_build
											,output('No Valid version parameter passed, skipping build')
										);
end;