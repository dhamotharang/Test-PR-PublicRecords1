old := dataset('~thor_data400::cemtemp::wbothseq', FidelityProp.layouts.from_prop_fid_2008, thor);
new := dataset('~thor_data400::cemtemp::wbothseq_withfares20090319', FidelityProp.layouts.from_prop_fid, thor);

// output(old, named('old'));
// output(new, named('new'));
output(count(old), named('count_old'));
output(count(new), named('count_new'));

set_prim_range := ['550','4204','1090'];
set_prim_name := ['WASHINGTON','BRADWOOD','LAFAYETTE'];
set_zip5 := ['80209','78722','80218'];

output(sort(old(prim_range in set_prim_range, prim_name in set_prim_name, zip5 in set_zip5), prim_range, prim_name, sec_range, zip5), named('old_me'));
output(sort(new(prim_range in set_prim_range, prim_name in set_prim_name, zip5 in set_zip5), prim_range, prim_name, sec_range, zip5), named('new_me'));

old_ran := enth(old, 10);

set_ran_prim_range 	:= set(old_ran, prim_range);
set_ran_prim_name 	:= set(old_ran, prim_name);
set_ran_zip5 				:= set(old_ran, zip5);

output(sort(old(prim_range in set_ran_prim_range, prim_name in set_ran_prim_name, zip5 in set_ran_zip5), prim_range, prim_name, sec_range, zip5), named('old_ran'));
output(sort(new(prim_range in set_ran_prim_range, prim_name in set_ran_prim_name, zip5 in set_ran_zip5), prim_range, prim_name, sec_range, zip5), named('new_ran'));

olddist := distribute(old, hash(prim_name, prim_range, zip5));
newdist := distribute(new, hash(prim_name, prim_range, zip5));

oldonly :=
join(
	old,
	new,
	left.prim_name = right.prim_name and
	left.prim_range = right.prim_range and
	left.zip5 = right.zip5 and
	left.sec_range = right.sec_range,
	transform(
		{old},
		self := left
	),
	left only,
	local
);

output(enth(oldonly, 20), named('oldonly_enth20'));

newonly :=
join(
	old,
	new,
	left.prim_name = right.prim_name and
	left.prim_range = right.prim_range and
	left.zip5 = right.zip5 and
	left.sec_range = right.sec_range,
	transform(
		{new},
		self := right
	),
	right only,
	local
);

output(enth(newonly, 20), named('newonly_enth20'));