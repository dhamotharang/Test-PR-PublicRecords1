//Defines full build process
import _control, versioncontrol;

export Build_PAW(

	 string		pversion				// Process Date for State
	,boolean	pIsTesting = false
) :=
module
   
	export preprocess		:= Promote().Input.Sprayed2Using;

	export build_base		:= Update_Jigsaw(
									         Files().input.live.using
									        ,Files().input.dead.using
									        ,Files().input.locked.using
									        ,Files().base.qa
									        ,pversion
						              );

	VersionControl.macBuildNewLogicalFile( 
															 Filenames(pversion).base.new	
															,build_base
															,Build_Base_File
																													);
																															
	export postprocess :=
		sequential(
			 Promote().Input.Using2Used
			,Promote(pversion).New2Built
			,Promote(pversion).Built2QA
			,if(not pIsTesting	,Strata_Population_Stats(pversion).Business_headers.all)
			,if(not pIsTesting	,Strata_Population_Stats(pversion).Business_Contacts.all)
			,QA_Records
		);

	export full_build :=
		sequential(
			 versioncontrol.mUtilities.createsupers(filenames().dAll_filenames)
			,nothor(apply(Filenames().input.dall_filenames	,apply(dSuperfiles, versioncontrol.mUtilities.createsuper(name))	))
			,preprocess
			,Build_Base_File
			,postprocess
		) : success(send_email(pversion).buildsuccess), failure(send_email(pversion).buildfailure);

	export All :=
		if(VersionControl.IsValidVersion(pversion)
			,full_build
			,output('No Valid version parameter passed, skipping build')
		);

end;
