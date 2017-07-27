//////////////////////////////////////////////////////////////////////////////////////////////
// -- Initialize_Input_Superfiles() function
// -- Pass it the superfile name and it will return the superfile code to clear it out, and all it's brethern
//////////////////////////////////////////////////////////////////////////////////////////////
export Initialize_Input_Superfiles(string100 superfilename) := FUNCTION
	return sequential(
                 FileServices.StartSuperFileTransaction(),
			  FileServices.ClearSuperFile(trim(superfilename) + '_delete',true),
                 FileServices.ClearSuperFile(trim(superfilename) + '_father', true),
                 FileServices.ClearSuperFile(superfilename, true),
			  FileServices.FinishSuperFileTransaction());

end;