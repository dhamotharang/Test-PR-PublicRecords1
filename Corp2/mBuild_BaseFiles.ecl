import VersionControl;

export mBuild_BaseFiles :=
module

	export Pre_Build_Input_manipulation :=
		nothor(Promote.Input.Sprayed2Using) : success(output('Pre build input superfile manipulation complete'));

	VersionControl.macBuildNewLogicalFile(Filenames.base.corp	,Update_Corp	,Update_Corp_Base	);
	VersionControl.macBuildNewLogicalFile(Filenames.base.cont	,Update_Cont	,Update_Cont_Base	);
	VersionControl.macBuildNewLogicalFile(Filenames.base.events	,BDID_Event		,Update_Event_Base	);
	VersionControl.macBuildNewLogicalFile(Filenames.base.stock	,Update_Stock	,Update_Stock_Base	);
	VersionControl.macBuildNewLogicalFile(Filenames.base.ar		,Update_AR		,Update_AR_Base		);
                                                              
	export Update_Base_Files :=
	parallel(

		 Update_Corp_Base
		,Update_Cont_Base
		,Update_Event_Base
		,Update_Stock_Base
		,Update_AR_Base
		
	) : success(output('Base File creation complete'));

	export Post_Build_Input_manipulation :=
		sequential(
			 nothor(Promote.Input.Using2Used)
			,Promote.Base.New2Built
		
		) : success(output('Post build input superfile manipulation complete'));


	export Build_All :=
	sequential(
		
		 Pre_Build_Input_manipulation
		,Update_Base_Files
		,Post_Build_Input_manipulation

	);

end;