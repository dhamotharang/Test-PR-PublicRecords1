import doxie, ut, Data_Services, Prof_License_Mari, fcra;


export key_did(boolean IsFCRA = false) := function

// base_file := Prof_License_Mari.file_mari_search((unsigned6)did != 0);
base_file_ := if(IsFCRA,Prof_License_Mari.file_mari_search((unsigned6)did != 0 and std_source_upd != 'S0903'),
												Prof_License_Mari.file_mari_search((unsigned6)did != 0)
												);
base_file := project(base_file_, {base_file_}-enh_did_src);

// DF-21891 Blank out fields specified in constants.fields_to_clear in thor_data400::key::proflic_mari::fcra::qa::did 
ut.MAC_CLEAR_FIELDS(base_file, base_file_cleared, Prof_License_Mari.constants.fields_to_clear);

base_file_final := if (IsFCRA,base_file_cleared, base_file);   

KeyName 			:= 'thor_data400::key::proflic_mari::';
KeyName_fcra 	:= 'thor_data400::key::proflic_mari::fcra::';

key_name := Data_services.Data_location.Prefix('mari') + if(isFCRA, KeyName_fcra, KeyName) + doxie.Version_SuperKey + '::did';


return_file		:= INDEX(dedup(base_file_final,all),{unsigned6 s_did := (unsigned6)base_file_final.did},{base_file_final},key_name);
													
return(return_file); 		

end;


		   
