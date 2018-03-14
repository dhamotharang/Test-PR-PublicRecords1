Import Data_Services, doxie, ut;


export 	key_mar_div_id_search(boolean IsFCRA = false) := function

KeyName 		 := 'thor_data400::key::mar_div::';
KeyName_fcra := 'thor_data400::key::mar_div::fcra::';

ds      := marriage_divorce_v2.file_mar_div_search;

ds_dist := distribute(ds, hash(record_id));
ds_sort := sort(ds_dist,record_id,local);

// DF-21429 - Blank out fields in thor_data400::key::mar_div::fcra::qa::id_search
fields_to_clear  := 'age,birth_state,how_marriage_ended,last_marriage_end_dt,party_county,previous_marital_status,race,times_married,title';
ut.MAC_CLEAR_FIELDS(ds_sort, ds_sort_cleared, fields_to_clear);
ds_sort_new := if(isFCRA, ds_sort_cleared, ds_sort);

key_name := Data_services.Data_location.Prefix('marriage') +	if(isFCRA, KeyName_fcra, KeyName) + doxie.Version_SuperKey + '::id_search';										
return_file		:= INDEX(ds_sort_new,{record_id,which_party},{ds_sort_new},key_name);
													
return(return_file); 

end;		

