IMPORT versioncontrol, _control, ut, Orbit3, Roxiekeybuild;

EXPORT Build_All(STRING	pversion) := MODULE

		#workunit('name','Yogurt:LaborActions_WHD Build - ' + pversion);
		
		EXPORT spray_files	:= fSpray(pversion);
		
		EXPORT dkeybuild		:=	Update_Base(files().input.using,files().base.qa,pversion);
		VersionControl.macBuildNewLogicalFile( Filenames(pversion).keybuild.new 
																						,dkeybuild
																						,Build_KeyBuild_File );
																					
		NewBase			:=	project(files(pversion).keybuild.logical,TRANSFORM(Layouts.Base,SELF := LEFT;));
   	VersionControl.macBuildNewLogicalFile( Filenames(pversion).base.new 
																						,NewBase
																						,Build_Base_File );
																						
		dops_update := Roxiekeybuild.updateversion('LaborActionsWHDKeys',pversion,'Randy.Reyes@lexisnexisrisk.com;Manuel.Tarectecan@lexisnexisrisk.com',,'N'); 
		orbit_update := Orbit3.proc_Orbit3_CreateBuild_AddItem('Labor Actions WHD', pversion);
				
		full_build 	:= SEQUENTIAL( 
				 				   nothor(APPLY(filenames().Base.dAll_filenames, APPLY(dSuperfiles, versioncontrol.mUtilities.createsuper(name))))
					    		,nothor(APPLY(filenames().Input.dAll_superfilenames, versioncontrol.mUtilities.createsuper(name)))
									,spray_files
									,Promote().Input.sprayed2using
									,Build_KeyBuild_File
									,Build_Base_File
									,FileServices.ClearSuperFile(filenames(pversion).keybuild.built,true)
									,FileServices.AddSuperFile(filenames(pversion).keybuild.built,filenames(pversion).keybuild.logical)
									,Promote().Input.Using2Used
									,Promote(pversion).New2Built
									,Promote().Built2QA
									,Proc_AutokeyBuild(pversion)     /* Build BDID AutoKeys */
									,proc_build_bdid_key(pversion)   /* Build BDID Roxie Keys */
									,proc_build_linkid_key(pversion) /* Build LINKID Roxie Keys */								
									,out_STRATApopulation_stats(pversion)
									,send_email(pversion).buildsuccess
									,dops_update
									,orbit_update
														) : success(Sequential(send_email(pversion).buildsuccess,send_email(pversion).roxie.qa)), 
																failure(send_email(pversion).buildfailure);
   
		EXPORT All 	:= IF(VersionControl.IsValidVersion(pversion)
												,full_build
												,OUTPUT('No Valid version parameter passed, skipping build') );
END;

		