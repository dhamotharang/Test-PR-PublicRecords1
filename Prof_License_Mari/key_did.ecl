import doxie, ut, Data_Services, Prof_License_Mari, fcra, vault, _control;

#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
export key_did(boolean IsFCRA = false) := vault.Prof_License_Mari.key_did(isFCRA);

#ELSE

export key_did(boolean IsFCRA = false) := function

base_file_ := Prof_License_Mari.file_mari_search((unsigned6)did != 0);
base_file := project(base_file_, {base_file_}-enh_did_src);

KeyName 			:= 'thor_data400::key::proflic_mari::';
KeyName_fcra 	:= 'thor_data400::key::proflic_mari::fcra::';


key_name := Data_services.Data_location.Prefix('mari') + if(isFCRA, KeyName_fcra, KeyName) + doxie.Version_SuperKey + '::did';


return_file		:= INDEX(dedup(base_file,all),{unsigned6 s_did := (unsigned6)base_file.did},{base_file},key_name);
													
return(return_file); 		

end;


#END;
		   
