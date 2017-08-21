#workunit('name','Hygenics SexPred Pre-process: Move Hygenics Image Data');
IMPORT lib_stringlib, lib_fileservices, _control,lib_thorlib, digssoff;

EXPORT Move_Soff_Image_Files(string src_state, String filedate) := FUNCTION

	AddToSuperFile := digssoff.SuperFile_Functions.Fun_AddToSuperfile('~images::in::sexoffender_'+src_state+'_'+filedate, 
																		'~images::in::sexoffender_'+src_state+'_all');
   								    
	return sequential(FileServices.StartSuperFileTransaction(),								
						AddToSuperFile,
						FileServices.FinishSuperFileTransaction());
end;