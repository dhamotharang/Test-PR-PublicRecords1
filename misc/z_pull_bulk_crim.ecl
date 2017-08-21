//
import demo_data;
//
wuid := '20090321_sample';		
//
my_bdids := dedup(sort(demo_data.base_files.file_demo_data_bdids(bdid<>0),record),all);
my_dids  := dedup(sort(demo_data.base_files.file_demo_data_dids(did<>0),record),all);
//
//
file_offenders_keybuilding 		:= 	demo_data.base_files.file_offenders_keybuilding; //done
file_offenses_keybuilding 		:= 	demo_data.base_files.file_offenses_keybuilding; //done
file_courtoffenses_keybuilding 	:= 	demo_data.base_files.file_courtoffenses_keybuilding; //done
file_activity_keybuilding 		:= 	demo_data.base_files.file_activity_keybuilding; //done
file_punishment_keybuilding 	:= 	demo_data.base_files.file_punishment_keybuilding; //done
//
file_offenders_keybuilding 		to_get_file_offenders_keybuilding(file_offenders_keybuilding l, my_dids r) := transform
self := l;
end;
my_offenders_keybuilding := join(file_offenders_keybuilding, my_dids,(unsigned) left.did=right.did,to_get_file_offenders_keybuilding(left,right), lookup);
output(my_offenders_keybuilding ,,'~thor_200::base::bulk_crim_offenders2_did_'+wuid,overwrite);
//
file_offenses_keybuilding 		to_get_file_offenses_keybuilding(file_offenses_keybuilding l, my_offenders_keybuilding r) := transform
self := l;
end;
my_offenses_keybuilding := join(file_offenses_keybuilding, my_offenders_keybuilding,left.offender_key=right.offender_key,to_get_file_offenses_keybuilding(left,right), lookup);
output(my_offenses_keybuilding ,,'~thor_200::base::bulk_crim_offenses_'+wuid,overwrite);
//
file_courtoffenses_keybuilding 		to_get_file_courtoffenses_keybuilding(file_courtoffenses_keybuilding l, my_offenders_keybuilding r) := transform
self := l;
end;
my_courtoffenses_keybuilding := join(file_courtoffenses_keybuilding, my_offenders_keybuilding,left.offender_key=right.offender_key,to_get_file_courtoffenses_keybuilding(left,right), lookup);
output(my_courtoffenses_keybuilding ,,'~thor_200::base::bulk_court_offenses_'+wuid,overwrite);//
//
file_activity_keybuilding 		to_get_file_activity_keybuilding(file_activity_keybuilding l, my_offenders_keybuilding r) := transform
self := l;
end;
my_activity_keybuilding := join(file_activity_keybuilding, my_offenders_keybuilding,left.offender_key=right.offender_key,to_get_file_activity_keybuilding(left,right), lookup);
output(my_activity_keybuilding ,,'~thor_200::base::bulk_court_crim_activity_'+wuid,overwrite);
//
file_punishment_keybuilding 		to_get_file_punishment_keybuilding(file_punishment_keybuilding l, my_offenders_keybuilding r) := transform
self := l;
end;
my_punishment_keybuilding := join(file_punishment_keybuilding, my_offenders_keybuilding,left.offender_key=right.offender_key,to_get_file_punishment_keybuilding(left,right), lookup);
output(my_punishment_keybuilding ,,'~thor_200::base::bulk_crim_punishment_'+wuid,overwrite);
//


