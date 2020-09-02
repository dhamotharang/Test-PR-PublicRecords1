import versioncontrol, _control, ut, Roxiekeybuild,lib_stringlib,scrubs_diversity_certification,scrubs, Diversity_Certification;

export Build_All(string	pversion ,string fileDate) := module
		export spray_files 		:= fSprayFiles(fileDate);
							 
		//Note: following will filter out any header records from raw input
		shared dkeybuild 		  := Update_Base(	Files().input.using(lib_stringlib.StringLib.StringFind(stringlib.StringToUpperCase(dartid),'DARTID',1)=0 and trim(stringlib.StringToUpperCase(Website),left,right)<>'WEBSITE'),files().base.qa,pversion);
		
		VersionControl.macBuildNewLogicalFile( Filenames(pversion).keybuild.new 
																					 ,dkeybuild
																					 ,Build_KeyBuild_File
																				 );
																					
		NewBase								:=	project(Diversity_Certification.Files().KeyBuildSF,TRANSFORM(Layouts.Base,SELF := LEFT;));
   
		VersionControl.macBuildNewLogicalFile( Filenames(pversion).base.new 
																					 ,NewBase
																					 ,Build_Base_File
																					);
										
		shared Add_KeyBuildFile := sequential(FileServices.StartSuperFileTransaction()
																					//note: previous subfile is being deleted.
																					,FileServices.clearsuperfile(Diversity_Certification.Cluster+'keybuild::Diversity_Certification::qa::data',true)
																				  ,FileServices.AddSuperFile(Diversity_Certification.Cluster+'keybuild::Diversity_Certification::qa::data' 
																					,Diversity_Certification.Cluster+'temp::Diversity_Certification::'+pVersion+'::allstates') 
																					,FileServices.FinishSuperFileTransaction());


		shared KeyBuild_main 				:= if(FileServices.FindSuperFileSubName(Diversity_Certification.Cluster+'keybuild::Diversity_Certification::qa::data', Diversity_Certification.Cluster+'temp::Diversity_Certification::'+pVersion+'::allstates') = 0,Add_KeyBuildFile); 
		shared CreateSuper					:= FileServices.CreateSuperFile(Diversity_Certification.Cluster+'keybuild::Diversity_Certification::qa::data',false);
								
		shared CreateTempKeyBuildIfNotExist := if(NOT FileServices.SuperFileExists(Diversity_Certification.Cluster+'keybuild::Diversity_Certification::qa::data'),CreateSuper); 	
								  										   		
		shared InputSF_prebuild1 			:= FileServices.AddSuperFile(Filenames(pversion).Input.Using,		Filenames(pversion).Input.Sprayed,,true);
		shared InputSF_prebuild2 			:= FileServices.ClearSuperFile(Filenames(pversion).Input.Sprayed);
		shared InputSF_prebuild3 			:= FileServices.ClearSuperFile(Filenames(pversion).Input.Used);


		export Prebuild				:=	sequential(	InputSF_prebuild1
																					,InputSF_prebuild2
																					,InputSF_prebuild3
																				 );
		run_scrubs						:= scrubs_Diversity_Certification.fn_RunScrubs(pversion, Diversity_Certification.Email_Notification_Lists.BuildFailure);
		dops_update 					:= Roxiekeybuild.updateversion('DiversityCertKeys',pVersion,'saritha.myana@lexisnexis.com');														
									
		export full_build 	  := sequential( nothor(apply(filenames().Base.dAll_filenames, apply(dSuperfiles, versioncontrol.mUtilities.createsuper(name))))
																				,nothor(apply(filenames().Input.dAll_superfilenames, versioncontrol.mUtilities.createsuper(name)))
																				,CreateTempKeyBuildIfNotExist
																				,spray_files
																				,PreBuild
																				,run_scrubs
																				,if(scrubs.mac_ScrubsFailureTest('Scrubs_Diversity_Certification_Input',pversion),
																				sequential(Build_KeyBuild_File
																				,KeyBuild_main
																				,Build_Base_File
																				,Proc_Build_AutoKeys(pversion)
																				,proc_build_RoxieKeys(pversion)
																				,Promote().Input.Using2Used
																				,Promote(pversion).New2Built
																				,Promote(pversion).Built2Qa
																				,Out_Strata_Population_Stats(pversion)
																				,output(choosen(Files().keybuildSF(bdid<>0) , 1000), named ('keybuild_SampleRecords'))
																				,output(choosen(Files().Base.qa(bdid<>0) , 1000), named ('BaseFile_SampleRecords'))
																				,dops_update
																				),OUTPUT('Scrubs Failed due to reject warning(s)',NAMED('Scrubs_Failure')))
																				) : success(send_email(pversion).buildsuccess), failure(send_email(pversion).buildfailure);
   
		export All := if( VersionControl.IsValidVersion(pversion)
											,full_build
											,output('No Valid version parameter passed, skipping build')
									  );
end;