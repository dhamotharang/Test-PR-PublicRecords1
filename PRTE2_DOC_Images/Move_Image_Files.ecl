IMPORT std;

EXPORT Move_Image_Files(string filedate) := FUNCTION
	
	return sequential(STD.File.StartSuperFileTransaction(),
																			STD.File.ClearSuperFile(Constants.in_prefix_name	+'varying_sources'),
																			STD.File.AddSuperFile(Constants.in_prefix_name	+'varying_sources',Constants.in_prefix_name+ 'arr_doc_'+ filedate);
																		 STD.File.FinishSuperFileTransaction());
end;
