import versioncontrol, _control, ut;

export Build_All(string	pversion) := module
		export spray_files	:=	fSprayFiles(pversion);

		export NewBase			:=	Update_Base(files().input.using,files().base.qa,pversion);
		
		VersionControl.macBuildNewLogicalFile(
																						Filenames(pversion).base.new 
																						,NewBase
																						,Build_Base_File
																					);			
														
		full_build 	:= sequential(
																 nothor(apply(filenames().Base.dAll_filenames, apply(dSuperfiles, versioncontrol.mUtilities.createsuper(name))))
																,nothor(apply(filenames().Input.dAll_superfilenames, versioncontrol.mUtilities.createsuper(name)))
																,spray_files
																,Promote().Input.sprayed2using
																,Build_Base_File
																,Promote().Input.Using2Used
																,Promote(pversion).New2Built
																,Promote().Built2QA
																,Proc_AutokeyBuild(pversion) /* Build AutoKeys */
																,out_STRATA_population_stats(pversion)
															) : success(Sequential(send_email(pversion).buildsuccess,send_email(pversion).roxie.qa)), failure(send_email(pversion).buildfailure);
   
   	export All 	:= if(VersionControl.IsValidVersion(pversion)
											,full_build
											,output('No Valid version parameter passed, skipping build')
										);
end;