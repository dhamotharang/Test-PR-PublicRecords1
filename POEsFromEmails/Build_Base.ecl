//Defines full build process
import _control, versioncontrol;

export Build_Base(

	 string														pversion
	,boolean													pIsTesting					= false
) :=
module
   
	export build_base		:= POEsFromEmails.AttachBest_BDID_Ph_Addr_2Emails(
									         pversion
						             );

	VersionControl.macBuildNewLogicalFile( 
																				 Filenames(pversion).base.new	
																				,build_base
																				,Build_Base_File
																			 );
																																

	export full_build :=
		sequential(
			 Build_Base_File
			,Promote(pversion).New2Built
		) : success(send_email(pversion).buildsuccess), failure(send_email(pversion).buildfailure);

	export All :=
		if(VersionControl.IsValidVersion(pversion)
			,full_build
			,output('No Valid version parameter passed, skipping build')
		);

end;
