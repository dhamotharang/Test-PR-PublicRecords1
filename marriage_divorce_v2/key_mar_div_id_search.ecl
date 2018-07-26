Import Data_Services, doxie;


export 	key_mar_div_id_search(boolean IsFCRA = false) := function

KeyName 		 := 'thor_data400::key::mar_div::';
KeyName_fcra := 'thor_data400::key::mar_div::fcra::';

ds      := marriage_divorce_v2.file_mar_div_search;

ds_dist := distribute(ds, hash(record_id));
ds_sort := sort(ds_dist,record_id,local);

key_name := Data_services.Data_location.Prefix('marriage') +	if(isFCRA, KeyName_fcra, KeyName) + doxie.Version_SuperKey + '::id_search';
										
return_file		:= INDEX(ds_sort,{record_id,which_party},{ds_sort},key_name);
														
return(return_file); 

end;		

