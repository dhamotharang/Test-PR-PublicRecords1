//Defines full build process
import _control, versioncontrol;

export Build_Base(

	 string														pversion
	,boolean													pUseProd					= false
	,dataset(Layouts.Base						)	pBaseFile					= Files().base.qa									
) :=
module
   
	export build_base		:= Update_Base(pversion,pUseProd);

	VersionControl.macBuildNewLogicalFile( 
																				 Filenames(pversion,pUseProd).base.new	
																				,build_base
																				,Build_Base_File
																			 );
																																

	export full_build :=
		sequential(
			Build_Base_File
			,Promote(pversion,pUseProd).buildfiles.New2Built
		) : success(send_email(pversion).buildsuccess), failure(send_email(pversion).buildfailure);

	export All :=
		if(VersionControl.IsValidVersion(pversion)
			,full_build
			,output('No Valid version parameter passed, skipping build')
		);

end;
