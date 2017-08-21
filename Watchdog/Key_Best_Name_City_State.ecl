import Data_Services, doxie;
best_f := watchdog.File_Best;

aggr_layout := record
	best_f.fname,
	typeof(best_f.fname) preferred_fname;
	best_f.lname,
	best_f.city_name,
	best_f.st,
	unsigned did_cnt_with_orig_nm := 0; //number of DIDs with the same combination of name, city, st
	unsigned did_cnt_with_pref_nm := 0; //number of DIDs with the same combination of preferred name, city, st
end;

append_preferred := project(best_f, transform(aggr_layout,
																			self.preferred_fname := datalib.preferredfirst(left.fname),
																			self := left));
																			
aggr_all := table(append_preferred, {fname, preferred_fname, lname, city_name, st}, fname, preferred_fname,lname, city_name, st); 
aggr_name_city_state := table(append_preferred, {fname, lname, city_name, st, unsigned did_cnt_with_orig_nm := count(group)}, fname, lname, city_name, st); 
aggr_preferred_name_city_state := table(append_preferred, {preferred_fname, lname, city_name, st, unsigned did_cnt_with_pref_nm := count(group)}, preferred_fname, lname, city_name, st); 

with_count1 := join(distribute(aggr_all, hash(fname, lname, city_name, st)),
										distribute(aggr_name_city_state, hash(fname, lname, city_name, st)),
										left.fname = right.fname and
										left.lname = right.lname and 
										left.city_name = right.city_name and
										left.st = right.st,
										transform(aggr_layout,
															self.did_cnt_with_orig_nm := right.did_cnt_with_orig_nm,
															self := left),
										left outer, local);
															
										
with_count2 := join(distribute(with_count1, hash(preferred_fname, lname, city_name, st)),
										distribute(aggr_preferred_name_city_state, hash(preferred_fname, lname, city_name, st)),
										left.preferred_fname  = right.preferred_fname  and
										left.lname = right.lname and 
										left.city_name = right.city_name and
										left.st = right.st,
										transform(aggr_layout,
															self.did_cnt_with_pref_nm := right.did_cnt_with_pref_nm,
															self := left),
										left outer, local);										



Best_Name_City_State := with_count2(st not in['', '00'] and city_name <> '' and lname <> '' and fname <> '');

EXPORT Key_Best_Name_City_State :=  INDEX(Best_Name_City_State,
																			{st, city_name, lname, preferred_fname}, 
																			{Best_Name_City_State},
																			Data_Services.Data_location.Prefix('Watchdog_Best')+'thor_data400::key::watchdog_best.name_city_st_'+doxie.Version_SuperKey);