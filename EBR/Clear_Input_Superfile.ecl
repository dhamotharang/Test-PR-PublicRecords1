//////////////////////////////////////////////////////////////////////////////////////////////
// -- Clear_Input_Superfile() function
// -- Pass it the superfile name and it will return the superfile code to clear it out
//////////////////////////////////////////////////////////////////////////////////////////////
export Clear_Input_Superfile(string100 superfilename) := FUNCTION
	return sequential(
                 FileServices.StartSuperFileTransaction(),
			  FileServices.AddSuperFile(trim(superfilename) + '_delete', 
                                           trim(superfilename) + '_father',, true),
                 FileServices.ClearSuperFile(trim(superfilename) + '_father'),
                 FileServices.AddSuperFile(trim(superfilename) + '_father', 
                                           superfilename,, true),
                 FileServices.ClearSuperFile(superfilename),
			  FileServices.FinishSuperFileTransaction(),
                 FileServices.ClearSuperFile(trim(superfilename) + '_delete',true));

end;
