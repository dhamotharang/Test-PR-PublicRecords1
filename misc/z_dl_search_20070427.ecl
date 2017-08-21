my_ds:= 
distribute(drivers.File_Dl
	(history not in ['E','H'] and 
	orig_state='FL' and 
	race in ['B',' '] and 
	fname='WALLACE' and 
	dob[1..4]>='1977')
,hash(dl_number));

my_ds_deduped := 
	dedup(sort(my_ds,st,zip5,p_city_name,prim_name,prim_range,dl_number,-history,local),
		             st,zip5,p_city_name,prim_name,prim_range,dl_number,local);
	
output(choosen(my_ds_deduped,1000));
	