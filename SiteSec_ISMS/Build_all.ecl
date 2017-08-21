IMPORT versioncontrol, _control, ut;

EXPORT Build_All(STRING	pversion) := MODULE
		EXPORT spray_files	:= fSpray(pversion);
		
		EXPORT NewBase		  := Update_Base(files().input.using,files().base.qa,pversion);
				   
		VersionControl.macBuildNewLogicalFile( Filenames(pversion).base.new 
																					,NewBase
																					,Build_Base_File );		
																
		full_build 	:= SEQUENTIAL( nothor(APPLY(filenames().Base.dAll_filenames, APPLY(dSuperfiles, versioncontrol.mUtilities.createsuper(name))))
															,nothor(APPLY(filenames().Input.dAll_superfilenames, versioncontrol.mUtilities.createsuper(name)))
															,spray_files
															,Promote().Input.sprayed2using
															,Build_Base_File
															,Promote().Input.Using2Used
															,Promote(pversion).New2Built
															,Promote().Built2QA
															,out_STRATA_population_stats(pversion)
															,Proc_AutokeyBuild(pversion) /* Build AutoKeys */
															,send_email(pversion).buildsuccess

															)  : success(send_email(pversion).roxie.qa), 
																failure(send_email(pversion).buildfailure);
   
		EXPORT All 	:= IF(VersionControl.IsValidVersion(pversion)
												,full_build
												,OUTPUT('No Valid version parameter passed, skipping build') );
END;