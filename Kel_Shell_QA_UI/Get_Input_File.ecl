EXPORT Get_Input_File(logical_file_name, Environment, Records_to_Run) := FUNCTIONMACRO

Base_Lay:=Kel_Shell_QA_UI.Layouts.Input_Lay;

Tag:= regexreplace('~',logical_file_name,'');
sample_size:=Records_to_Run;

input_file:=dataset(logical_file_name,Base_Lay,CSV(HEADING(single), QUOTE('"')));

File:= if(sample_size=0, choosen(input_file,all),choosen(input_file,sample_size) );

RETURN File;

ENDMACRO;

logical_file_name:='~jastad01::100k_current_business_ks-1008_w20191021-092827_masterlayout.csv';
Environment:=Kel_Shell_QA_UI.Constants.Public_Records_EW;
Records_to_Run:=10;

Get_Input_File(logical_file_name, Environment, Records_to_Run);												
																	