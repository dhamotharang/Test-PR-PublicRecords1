//export BWR_Run_Watchdog_Marketing_stats := 'todo';
// Do not use this, un BRW_Watchdog_marketing_cron

import watchdog;

//do1 := output(topn(Member, 100, -(unsigned4)date_last_seen), named('BbbMemberSampleRecsForQA'));

/*
string_rec := record
    unsigned6    did := 0;
	string243	payload := '';
end;
*/

#workunit('name','Yogurt:Watchdog-marketing stats');
#workunit('priority','high');
#workunit('priority',13);

#stored ('watchtype', 'marketing'); 

string_rec := record
watchdog.Layout_Best;
end;

bb := Watchdog.file_best;
old := dataset('~thor_data400::base::watchdog_best_marketing_father',string_rec,flat);
new := dataset('~thor_data400::base::watchdog_best_marketing',string_rec,flat);

bbd  := distribute(dedup(sort(bb ,did),did),hash(did));
oldd := distribute(dedup(sort(old,did),did),hash(did));
newd := distribute(dedup(sort(new,did),did),hash(did));

string_rec to_join_keepL(oldd L,newd R) := transform
self := L;
end;

string_rec to_join_keepR(oldd L,newd R) := transform
self := R;
end;

output(count(newd), named('Current_marketing_DID_count1'));
output(count(oldd), named('Previous_marketing_DID_count1'));
/*
on_did_same := join(newd,oldd,
		(left.did=right.did),
		to_join_keepL(left,right),local);
output(count(on_did_same),named('DIDs_are_the_same1'));
on_phone_same := join(newd,oldd,
		(left.phone=right.phone and 
		left.did=right.did),
		to_join_keepL(left,right),local);
output(count(on_phone_same),named('Phones_are_the_same1'));
on_dob_same := join(newd,oldd,
		(left.dob=right.dob and 
		left.did=right.did),
		to_join_keepL(left,right),local);
output(count(on_dob_same),named('DOBs_are_the_same1'));
on_ssn_same := join(newd,oldd,
		(left.ssn=right.ssn 
		and left.did=right.did),
		to_join_keepL(left,right),local);
output(count(on_ssn_same),named('SSNs_are_the_same1'));
on_name_same := join(newd,oldd,
		((left.title=right.title and 
		left.fname=right.fname and 
		left.mname=right.mname and 
		left.lname=right.lname and
		left.name_suffix=right.name_suffix) and
		left.did=right.did),
		to_join_keepL(left,right),local);
output(count(on_name_same),named('Names_are_the_same1'));
on_addr_same := join(newd,oldd,
		((left.prim_range=right.prim_range and
		left.predir=right.predir and
		left.prim_name=right.prim_name and
		left.suffix=right.suffix and
		left.postdir=right.postdir and
		left.unit_desig=right.unit_desig and
		left.sec_range=right.sec_range and
		left.city_name=right.city_name and
		left.st=right.st and
		left.zip=right.zip and
		left.zip4=right.zip4) and
		left.did=right.did),
		to_join_keepL(left,right),local);
output(count(on_addr_same),named('Addresses_are_the_same1'));
*/

output(count(newd), named('Current_Marketing_DID_count2'));
output(count(bbd),  named('Current_BestBest_DID_count2'));

nb_did_same := join(newd,bbd,
		(left.did=right.did),
		to_join_keepL(left,right),local);
output(count(nb_did_same),named('DIDs_are_the_same2'));
nb_phone_same := join(newd,bbd,
		(left.phone=right.phone and 
		left.did=right.did),
		to_join_keepL(left,right),local);
output(count(nb_phone_same),named('Phones_are_the_same2'));
nb_dob_same := join(newd,bbd,
		(left.dob=right.dob and 
		left.did=right.did),
		to_join_keepL(left,right),local);
output(count(nb_dob_same),named('DOBs_are_the_same2'));
nb_ssn_same := join(newd,bbd,
		(left.ssn=right.ssn 
		and left.did=right.did),
		to_join_keepL(left,right),local);
output(count(nb_ssn_same),named('SSNs_are_the_same2'));
nb_name_same := join(newd,bbd,
		((left.title=right.title and 
		left.fname=right.fname and 
		left.mname=right.mname and 
		left.lname=right.lname and
		left.name_suffix=right.name_suffix) and
		left.did=right.did),
		to_join_keepL(left,right),local);
output(count(nb_name_same),named('Names_are_the_same2'));
nb_addr_same := join(newd,bbd,
		((left.prim_range=right.prim_range and
		left.predir=right.predir and
		left.prim_name=right.prim_name and
		left.suffix=right.suffix and
		left.postdir=right.postdir and
		left.unit_desig=right.unit_desig and
		left.sec_range=right.sec_range and
		left.city_name=right.city_name and
		left.st=right.st and
		left.zip=right.zip and
		left.zip4=right.zip4) and
		left.did=right.did),
		to_join_keepL(left,right),local);
output(count(nb_addr_same),named('Addresses_are_the_same2'));

on_did_diff := join(newd,oldd,
		(left.did=right.did),
		to_join_keepL(left,right),left only, local);
output(choosen(on_did_diff,100),named('New_DIDs'));
on_phone_diff := join(newd,oldd,
		(left.phone=right.phone and 
		left.did=right.did),
		to_join_keepL(left,right),left only, local);
output(choosen(on_phone_diff,100),named('Phone_changed'));
on_dob_diff := join(newd,oldd,
		(left.dob=right.dob and 
		left.did=right.did),
		to_join_keepL(left,right),left only, local);
output(choosen(on_dob_diff,100),named('DOB_changed'));
on_ssn_diff := join(newd,oldd,
		(left.ssn=right.ssn 
		and left.did=right.did),
		to_join_keepL(left,right),left only, local);
output(choosen(on_ssn_diff,100),named('SSN_changed'));
on_name_diff := join(newd,oldd,
		((left.title=right.title and 
		left.fname=right.fname and 
		left.mname=right.mname and 
		left.lname=right.lname and
		left.name_suffix=right.name_suffix) and
		left.did=right.did),
		to_join_keepL(left,right),left only, local);
output(choosen(on_name_diff,100),named('Name_changed'));
on_addr_diff := join(newd,oldd,
		((left.prim_range=right.prim_range and
		left.predir=right.predir and
		left.prim_name=right.prim_name and
		left.suffix=right.suffix and
		left.postdir=right.postdir and
		left.unit_desig=right.unit_desig and
		left.sec_range=right.sec_range and
		left.city_name=right.city_name and
		left.st=right.st and
		left.zip=right.zip and
		left.zip4=right.zip4) and
		left.did=right.did),
		to_join_keepL(left,right),left only, local);
output(choosen(on_addr_diff,100),named('Address_changed'));


export BWR_Run_Watchdog_Marketing_stats := fileservices.SendEmail('michael.gould@lexisnexisrisk.com,skasavajjala@seisint.com,rperez@seisint.com','Watchdog-marketing Stats FINISHED wu:'+thorlib.wuid(),'');

