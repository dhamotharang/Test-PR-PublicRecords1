import versioncontrol, _control, ut;

export Build_All(string	pversion) := module
		//Spray the data for the batch of data being processed
		export spray_files	:=	fSprayFiles(pversion);
		
		//Update_Base returns a file in the KeyBuild format
		export dKeyBuild		:=	Update_Base(files().input.using,files().base.qa,pversion);
    
		VersionControl.macBuildNewLogicalFile(Filenames(pversion).keybuild.new 
																				 ,dKeyBuild
																				 ,Build_KeyBuild_File
																				 );	

	  //Transform the dKeyBuild dataset from the KeyBuild format
		//to the Base format																				
		NewBase			:=	project(files(pversion).keybuild.logical,TRANSFORM(Layouts.Base,SELF := LEFT;));
	  
		VersionControl.macBuildNewLogicalFile( Filenames(pversion).base.new 
		 																			,NewBase
																					,Build_Base_File );	
		
		full_build 	:= sequential(
														  nothor(apply(filenames().Base.dAll_filenames, apply(dSuperfiles, versioncontrol.mUtilities.createsuper(name))))
														 ,nothor(apply(filenames().Input.dAll_superfilenames, versioncontrol.mUtilities.createsuper(name)))
														 ,spray_files
														 ,Promote().Input.sprayed2using
														 ,Build_KeyBuild_File
														 ,Build_Base_File
														 ,FileServices.ClearSuperfile(filenames().keybuild.built)
														 ,FileServices.AddSuperFile(filenames().keybuild.built,filenames(pversion).keybuild.logical)
														 ,Promote().Input.Using2Used
														 ,Promote(pversion).New2Built
														 ,Promote().Built2QA
														 ,Promote(pversion).KeyBuild2BH
														 ,Proc_BDID_AutokeyBuild(pversion) 		/* Build BDID AutoKeys 	*/
														 ,Proc_Build_Keys(pversion)			  		/* Build RoxieKeys */
														 ,out_STRATA_population_stats(pversion)
														 ,send_email(pversion).buildsuccess
														) : success(send_email(pversion).roxie.qa), failure(send_email(pversion).buildfailure);

   	export All 	:= if(VersionControl.IsValidVersion(pversion)
											,full_build
											,output('No Valid version parameter passed, skipping build')
										);

end;
																					