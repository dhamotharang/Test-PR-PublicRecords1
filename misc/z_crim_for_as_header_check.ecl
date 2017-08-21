my_ds := sort(distribute(crim_common.File_Crim_Offender2_Plus,hash(offender_key)),offender_key,local);

all_unique_offender_key_ds := dedup(sort(distribute(my_ds,hash(offender_key)),offender_key,local),offender_key,local);
dided_unique_offender_key_ds := dedup(sort(distribute(my_ds(did<>''),hash(offender_key)),offender_key,local),offender_key,local);

output(count(all_unique_offender_key_ds),named('count_all_unique_offender_keys'));
output(count(dided_unique_offender_key_ds),named('count_dided_unique_offender_keys'));


crim_common.layout_moxie_crim_Offender2 get_no_dided(my_ds l,dided_unique_offender_key_ds r) := transform 
self := l;
end;

no_dided_offender_key_ds := 
 join(my_ds,dided_unique_offender_key_ds,left.offender_key=right.offender_key,get_no_dided(left,right),local,left only );

//output(count(no_dided_offender_key_ds),named('count_no_dided_records'));
//output((no_dided_offender_key_ds),named('examples_no_dided_records'));

good_no_dided_offender_key_ds := 
no_dided_offender_key_ds
(
	(pty_typ<>'2' and pty_typ<>'1') 
and	(lname<>'' and fname<>'' and (integer) cleaning_score > 90)
and (zip5<>'' or (integer) orig_ssn >= 100000000 or (integer) dob >= 19010101)
//and ((integer) orig_ssn >= 100000000 or (integer) dob >= 19010101)
);

//output(count(good_no_dided_offender_key_ds),named('count_good_no_did_records'));
//output((good_no_dided_offender_key_ds),named('examples_good_no_did_records'));
unique_good_no_dided_offender_key_ds := dedup(sort(distribute(good_no_dided_offender_key_ds,hash(offender_key)),offender_key,local),offender_key,local);
output(count(unique_good_no_dided_offender_key_ds),named('count_unique_good_offender_keys'));


//export crim_for_as_header_check := 'todo';