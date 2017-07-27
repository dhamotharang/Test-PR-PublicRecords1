//#workunit('name','Hygenics SexPred Pre-process: Move Hygenics Image Data');
IMPORT lib_stringlib, lib_fileservices, _control,lib_thorlib, digssoff;

EXPORT Move_Crim_Image_Files(string src_type, String filedate) := FUNCTION

	AddToSuperFile := digssoff.SuperFile_Functions.Fun_AddToSuperfile('~images::in::'+src_type+'_'+filedate, 
																		'~images::in::'+src_type);
   								    
	return sequential(FileServices.StartSuperFileTransaction(),								
						AddToSuperFile,
						FileServices.FinishSuperFileTransaction());
end;