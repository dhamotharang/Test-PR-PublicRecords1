//Defines full build process
import _control, tools;

export Build_Base(

	 string														pversion
	,boolean													pIsTesting					= false
	,dataset(Layouts.Input.Sprayed	)	pLiveSprayedFile		= Files().input.live.using
	,dataset(Layouts.Input.Sprayed	)	pDeadSprayedFile		= Files().input.dead.using
	,dataset(Layouts.Input.Sprayed	)	pLockedSprayedFile	= Files().input.deletedremove.using
	,dataset(Layouts.Base						)	pBaseFile						= Files().base.qa									
) :=
module
   
	export build_base		:= Update_Jigsaw(
									         pversion
									        ,pLiveSprayedFile
									        ,pDeadSprayedFile
									        ,pLockedSprayedFile
									        ,pBaseFile										
						              );

	export Build_Base_File := tools.macf_WriteFile(Filenames(pversion).base.new	,build_base);
																															
	export full_build :=
		sequential(
			 Promote().Inputfiles.Sprayed2Using
			,Build_Base_File
			,Promote().Inputfiles.Using2Used
			,Promote(pversion).buildfiles.New2Built
		) : success(send_email(pversion).buildsuccess), failure(send_email(pversion).buildfailure);

	export All :=
		if(tools.fun_IsValidVersion(pversion)
			,full_build
			,output('No Valid version parameter passed, skipping Jigsaw.Build_Base')
		);

end;
