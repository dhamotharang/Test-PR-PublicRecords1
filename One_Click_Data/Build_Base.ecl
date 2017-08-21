//Defines full build process
import _control, versioncontrol;

export Build_Base(

	 string														pversion
	,boolean													pIsTesting			= false
	,dataset(Layouts.Input.Sprayed	)	pSprayedFile		= Files().input.Sprayed
	,dataset(Layouts.Base						)	pBaseFile				= Files().base.qa									
) :=
module
   
	export build_base		:= Update_Base(
									         pversion
									        ,pSprayedFile
									        ,pBaseFile										
						              );

	VersionControl.macBuildNewLogicalFile( 
															 Filenames(pversion).base.new	
															,build_base
															,Build_Base_File
	);
																															

	export full_build :=
		sequential(
			 Promote().Inputfiles.Sprayed2Using
			,Build_Base_File
			,Promote().Inputfiles.Using2Used
			,Promote(pversion).buildfiles.New2Built
		) : success(send_email(pversion).buildsuccess), failure(send_email(pversion).buildfailure);

	export All :=
		if(VersionControl.IsValidVersion(pversion)
			,full_build
			,output('No Valid version parameter passed, skipping One_Click_Data.Build_Base')
		);

end;
