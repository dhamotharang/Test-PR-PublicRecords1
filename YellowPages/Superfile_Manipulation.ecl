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
shared InputSF_prebuild1 := FileServices.AddSuperFile(Filenames.Input.Using,		Filenames.Input.Sprayed,,true);
shared InputSF_prebuild2 := FileServices.ClearSuperFile(Filenames.Input.Sprayed);
shared InputSF_prebuild3 := FileServices.ClearSuperFile(Filenames.Input.Used);


export Prebuild := 
	sequential(
		 InputSF_prebuild1
		,InputSF_prebuild2
		,InputSF_prebuild3
	);


//for base files
//first clear the built superfiles
//as build creates the new logical base files, it will add them to the appropriate built superfiles
//if built is not used, qa superfiles would be target

/////////////////////////////////////////////////////////////////////////////////////////////
// -- Post Build Superfile manipulation
/////////////////////////////////////////////////////////////////////////////////////////////

shared InputSF_postbuild1	:= FileServices.AddSuperFile(Filenames.Input.Used,	Filenames.Input.Using,,	true);
shared InputSF_postbuild2	:= FileServices.ClearSuperFile(Filenames.Input.Using);

export Postbuild := 
	sequential(

		 InputSF_postbuild1
		,InputSF_postbuild2

	);

end;