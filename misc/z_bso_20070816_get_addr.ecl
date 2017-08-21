import watchdog,driversv2,crim_common;
//
best_addr_all := distribute(watchdog.File_Moxie,hash( (integer) did));
dl_all := distribute(driversv2.File_Dl,hash( (integer) did));
cr_all := distribute(crim_common.File_Crim_Offender2_Plus((integer) did<>0),hash((integer) did));

//
layout_did_address := record
	unsigned6   did:= 0 ;
	string10    prim_range;
	string2     predir;
	string28    prim_name;
	string4     suffix;
	string2     postdir;
	string10    unit_desig;
	string8     sec_range;
	string13    city_name;
	string2     st;
	string5     zip;
	string1		race;
	string1		sex;
	string1		cr_flag;
end;
//
layout_did_address tbest(best_addr_all l) := transform
self.did := (integer) l.did;
self.race:='';
self.sex:='';
self.cr_flag:='';
self := l;
end;
best_addr := project(best_addr_all(zip in ['33069', '33072', '33093']),tbest(left));
//
layout_did_address tdl(dl_all l) := transform
self.city_name :=  l.v_city_name;
self.zip := l.zip5;
self.sex := '';
self.race := '';
self.cr_flag:= '';
self := l;
end;
dl_addr:= project(dl_all(history in [' ','U'] and did<>0 and zip5 in ['33069', '33072', '33093']),tdl(left));
//
my_addr:= dedup(
				sort(
						distribute(dl_addr+best_addr,hash((integer) did)),
					did,prim_range,predir,prim_name,zip,local),
			did,prim_range,predir,prim_name,zip,local);
//
layout_did_address trans_add_cr(my_addr l,cr_all r) := transform
self.cr_flag := if(r.lname<>'','Y','N');
self := l;
end;
plus_cr := join(my_addr,cr_all,(integer) left.did= (integer) right.did, trans_add_cr(left,right),left outer,local);
//
layout_did_address trans_add_dl(plus_cr l,dl_all r) := transform
self.race := r.race;
self.sex := r.sex_flag;
self := l;
end;
plus_dl := join(plus_cr, dl_all, (integer) left.did= (integer) right.did, trans_add_dl(left,right),left outer,local);
//
output(plus_dl,,'~thor_data400::bvh::bso_20070817_addr',overwrite);

