EXPORT Get_Input_File(logical_file_name,DALI, File_Type, Records_to_Run) := FUNCTIONMACRO

Base_Lay:=Kel_Shell_QA_UI.Layouts.Input_Lay;

Tag:= regexreplace('~',logical_file_name,'');
sample_size:=Records_to_Run;

input_file:=IF(File_Type='THOR',DATASET('~foreign::' + DALI + logical_file_name,Base_Lay,THOR),
																DATASET('~foreign::' + DALI + logical_file_name,Base_Lay,CSV(HEADING(single), QUOTE('"')))
							 );
																 
File:= if(sample_size=0, choosen(input_file,all),choosen(input_file,sample_size) );

RETURN File;

ENDMACRO;