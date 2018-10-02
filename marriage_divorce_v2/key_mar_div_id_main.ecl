Import Data_Services, doxie, ut;

export 	key_mar_div_id_main(boolean IsFCRA = false) := function


KeyName 		 := 'thor_data400::key::mar_div::';
KeyName_fcra := 'thor_data400::key::mar_div::fcra::';

ds      := marriage_divorce_v2.file_mar_div_base;

ds_dist := distribute(ds, hash(record_id));
ds_sort := sort(ds_dist,record_id,local);

// main layout now includes extra fields; only want license information
slim_mar_div := project(ds_sort,TRANSFORM(marriage_divorce_v2.layout_mar_div_base_slim,SELF := LEFT));

// DF-21428 - Blank out fields in thor_data400::key::mar_div::fcra::qa::id_main
// Note that fields to clear is not defined in constants atribute b/c it caused a recursive dependency during compilation
ut.MAC_CLEAR_FIELDS(slim_mar_div, slim_mar_div_cleared, marriage_divorce_v2.fn_FCRA_Field_Deprecation.fields_to_clear_id_main);

slim_mar_div_new := if(isFCRA, slim_mar_div_cleared, slim_mar_div);
key_name := Data_services.Data_location.Prefix('marriage') + if(isFCRA, KeyName_fcra, KeyName) + doxie.Version_SuperKey + '::id_main';
										
return_file		:= INDEX(slim_mar_div_new,{record_id},{slim_mar_div_new},key_name);
														
return(return_file); 

end;				   
