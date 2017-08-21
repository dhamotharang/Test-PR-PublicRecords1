import VersionControl, corp;

export mBuild_BaseFiles(string pversion) :=
module

	export Pre_Build_Input_manipulation :=
		Promote(pversion).Input.Sprayed2Using : success(output('Pre build input superfile manipulation complete'));

	VersionControl.macBuildNewLogicalFile(Filenames(pversion).base.corp.new		,Update_Corp	,Update_Corp_Base	);
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).base.cont.new		,Update_Cont	,Update_Cont_Base	);
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).base.events.new	,BDID_Event		,Update_Event_Base	);
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).base.stock.new	,Update_Stock	,Update_Stock_Base	);
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).base.ar.new			,Update_AR		,Update_AR_Base		);
                                                              
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
			 Promote(pversion).Input.Using2Used
			,if(flags.IsUsingV1Inputs and flags.UseV1CurrentSprayed and flags.ExistcorpV1CurrentSprayed, Corp.Clear_Input_Superfiles)
			,Promote(pversion,'base').New2Built
		
		) : success(output('Post build input superfile manipulation complete'));


	export Build_All :=
	sequential(
		
		 Pre_Build_Input_manipulation
		,Update_Base_Files
		,Post_Build_Input_manipulation

	);

end;