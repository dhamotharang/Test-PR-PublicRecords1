import tools;
export Superfile_Manipulation := 
module

//For input files
//copy sprayed superfiles to using superfile
//then clear the sprayed superfile
//then clear the used superfile
//after build completes, copy contents of using superfile to used superfile
//then clear the using superfile

/////////////////////////////////////////////////////////////////////////////////////////////
// -- Input Superfile Pre-Build Superfile manipulation
/////////////////////////////////////////////////////////////////////////////////////////////
Member_superfile_prebuild		:= tools.fSF_Input_Move_Standard(Filenames().Input.Member.Template,		'B');
NonMember_superfile_prebuild	:= tools.fSF_Input_Move_Standard(Filenames().Input.NonMember.Template,	'B');

/////////////////////////////////////////////////////////////////////////////////////////////
// -- Base Superfile Pre-Build Superfile manipulation
/////////////////////////////////////////////////////////////////////////////////////////////
//clear built superfile

export Prebuild := 
	sequential(

		 Member_superfile_prebuild
		,NonMember_superfile_prebuild

	);


//for base files
//first clear the built superfiles
//as build creates the new logical base files, it will add them to the appropriate built superfiles
//if built is not used, qa superfiles would be target

/////////////////////////////////////////////////////////////////////////////////////////////
// -- Post Build Superfile manipulation
/////////////////////////////////////////////////////////////////////////////////////////////
Member_superfile_postbuild		:= tools.fSF_Input_Move_Standard(Filenames().Input.Member.Template,		'E');
NonMember_superfile_postbuild	:= tools.fSF_Input_Move_Standard(Filenames().Input.NonMember.Template,	'E');

export Postbuild := 
	sequential(

		 Member_superfile_postbuild
		,NonMember_superfile_postbuild

	);

end;