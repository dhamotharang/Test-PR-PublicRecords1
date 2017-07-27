import versioncontrol, _control, ut;

export Build_All(string	pversion) := module
		export spray_files	:=	fSprayInputs(pversion);

		export NewBase			:=	Update_Base(filesIn().New, filesIn().Update, filesIn().Delete, filesBase.base, pversion);

		VersionControl.macBuildNewLogicalFile( Filenames(pversion).base.new, NewBase,Build_Base_File);																					
														
		full_build 	:= sequential(
																spray_files
																,Build_Base_File
																,Promote(pversion).New2Built
																,Promote().Built2QA
																,MXD_MXDocket.Proc_build_keys(pversion)
																,MXD_MXDocket.out_STRATAPopulation_Stats(pversion)
															) : success(send_email(pversion).buildsuccess), 
																	failure(send_email(pversion).buildfailure);
   
   	export All 	:= if(VersionControl.IsValidVersion(pversion)
											,full_build
											,output('No Valid version parameter passed, skipping build')
										);
end;