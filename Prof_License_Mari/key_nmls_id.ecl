import doxie_files, doxie, ut, Data_Services, fcra;


base_file_ := Prof_License_Mari.file_mari_search;
base_file := project(base_file_, {base_file_}-enh_did_src);

KeyName 			:= 'thor_data400::key::proflic_mari::';

export key_nmls_id := 	index(base_file
																	,{nmls_id}
																	,{base_file}
																	,Data_Services.Data_location.Prefix('mari')+ KeyName+ doxie.Version_SuperKey+'::nmls_id');