import versioncontrol, _control, ut, Roxiekeybuild, Orbit3,scrubs_LaborActions_EBSA,scrubs;

export Build_All(string	pversion) := module
		#workunit('name','Yogurt:LaborActions_EBSA Build - ' + pversion);
		
		export spray_files	:=	fSprayFiles(pversion);

		export NewBase			:=	Update_Base(files().input.using,files().base.qa,pversion);
		
		VersionControl.macBuildNewLogicalFile(
																						Filenames(pversion).base.new 
																						,NewBase
																						,Build_Base_File
																					);		
		run_scrubs := scrubs_LaborActions_EBSA.Fn_RunScrubs(pversion);																			
		dops_update := if(
							Scrubs.mac_ScrubsFailureTest('Scrubs_LaborActions_EBSA',pversion)
							,Roxiekeybuild.updateversion('LaborActionsEBSAKeys',pversion,'Randy.Reyes@lexisnexisrisk.com;Manuel.Tarectecan@lexisnexisrisk.com',,'N')
							,OUTPUT('Scrubs failed due to reject warning(s)',NAMED('Scrubs_Failure'))
						);
		orbit_update := Orbit3.proc_Orbit3_CreateBuild_AddItem('LaborActions_EBSA',pversion);
													
		full_build 	:= sequential(
																 nothor(apply(filenames().Base.dAll_filenames, apply(dSuperfiles, versioncontrol.mUtilities.createsuper(name))))
																,nothor(apply(filenames().Input.dAll_superfilenames, versioncontrol.mUtilities.createsuper(name)))
																,spray_files
																,Promote().Input.sprayed2using
																,run_scrubs
																,Build_Base_File
																,Promote().Input.Using2Used
																,Promote(pversion).New2Built
																,Promote().Built2QA
																,Proc_AutokeyBuild(pversion) /* Build AutoKeys */
																,out_STRATA_population_stats(pversion)
																,dops_update
																,orbit_update
															) : success(Sequential(send_email(pversion).buildsuccess,send_email(pversion).roxie.qa)), failure(send_email(pversion).buildfailure);
   
   	export All 	:= if(VersionControl.IsValidVersion(pversion)
											,full_build
											,output('No Valid version parameter passed, skipping build')
										);
end;