
//export watchdog_marketing_enhanced := 'todo';

import watchdog,gong;

#stored ('watchtype', 'marketing'); 

my_best := distribute(Watchdog.file_best,hash(did));
my_best_marketing := distribute(Watchdog.file_best_marketing,hash(did));
my_marketing_header := distribute(watchdog.file_header_filtered,hash(did));
my_gong := distribute( Gong.File_Gong_DID(phone10<>''and did!=0),hash(did));

watchdog.layout_Best  to_exists(my_best l,my_marketing_header r) := transform
self := l;
end;

Layout_phone_only := record
unsigned6    did := 0;
qstring10    phone := '';
end;

layout_phone_only  to_exists_phone_gong(my_best l,my_gong r) := transform
self.phone := if(r.cr_sort_sz <> 'Y', l.phone, '');
self := l;
end;

layout_phone_only  to_exists_phone_header(my_best l,my_marketing_header r) := transform
self := l;
end;

my_marketing_header_phones := dedup(sort(my_marketing_header((unsigned8)phone<>0 AND pflag3 not in ['W','X']),did,phone,local),did,phone,local);
my_best_plus_phone1j := join(my_best(phone<>''), my_marketing_header_phones, 
								left.did=right.did and left.phone=right.phone, 
										to_exists_phone_header(left,right),local);
										
my_marketing_gong_phones := dedup(sort(my_gong(did<>0),did,phone10,local),did,phone10,local);
my_best_plus_phone2j := join(my_best(phone<>''), my_marketing_gong_phones, 
								left.did=right.did and left.phone=right.phone10, 
										to_exists_phone_gong(left,right),local);

my_marketing_ssns := dedup(sort(my_marketing_header(ssn<>'' and pflag3=''),did,ssn,local),did,ssn,local);
my_best_plus_ssnj := join(my_best(ssn<>''), my_marketing_ssns, 
								left.did=right.did and left.ssn=right.ssn, 
										to_exists(left,right),local);

my_marketing_dobs := dedup(sort(my_marketing_header(dob<>0),did,dob,local),did,dob,local);
my_best_plus_dobj := join(my_best(dob<>0), my_marketing_dobs, 
								left.did=right.did and left.dob=right.dob, 
										to_exists(left,right),local);

my_marketing_addresses := dedup(sort(my_marketing_header(zip4<>''),did,prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,city_name,st,zip,zip4,local),did,prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,city_name,st,zip,zip4,local);
my_best_plus_addressj := join(my_best, my_marketing_addresses, 
								left.did=right.did and 
								left.prim_range=right.prim_range and
								left.predir=right.predir and
								left.prim_name=right.prim_name and
								left.suffix=right.suffix and
								left.postdir=right.postdir and
								left.unit_desig=right.unit_desig and
								left.sec_range=right.sec_range and
								left.city_name=right.city_name and
								left.st=right.st and
								left.zip=right.zip and
								left.zip4=right.zip4, 
							to_exists(left,right),local);

my_marketing_titles := dedup(sort(my_marketing_header(title<>''),did,title,local),did,title,local);
my_best_plus_titlej := join(my_best(title<>''), my_marketing_titles, 
								left.did=right.did and 
								left.title=right.title,
								to_exists(left,right),local);
								
my_marketing_fnames := dedup(sort(my_marketing_header(fname<>''),did,fname,local),did,fname,local);
my_best_plus_fnamej := join(my_best(fname<>''), my_marketing_fnames, 
								left.did=right.did and 
								left.fname=right.fname,
								to_exists(left,right),local);


my_marketing_mnames := dedup(sort(my_marketing_header(mname<>''),did,mname,local),did,mname,local);
my_best_plus_mnamej := join(my_best(mname<>''), my_marketing_mnames, 
								left.did=right.did and 
								left.mname=right.mname,
								to_exists(left,right),local);

my_marketing_lnames := dedup(sort(my_marketing_header(lname<>''),did,lname,local),did,lname,local);
my_best_plus_lnamej := join(my_best(lname<>''), my_marketing_lnames, 
								left.did=right.did and 
								left.lname=right.lname,
								to_exists(left,right),local);

my_marketing_name_suffixs := dedup(sort(my_marketing_header(name_suffix<>''),did,name_suffix,local),did,name_suffix,local);
my_best_plus_name_suffixj := join(my_best(name_suffix<>''), my_marketing_name_suffixs, 
								left.did=right.did and 
								left.name_suffix=right.name_suffix,
								to_exists(left,right),local);
//
my_best_plus_phonej := dedup(sort((my_best_plus_phone1j+my_best_plus_phone2j), did,phone,local),did,phone,local);
//
watchdog.layout_best with_phone(my_best_marketing l, my_best_plus_phonej r) := transform
self.phone := map(r.did<>0 => r.phone, l.phone);
self := l;
end;
my_best_marketing_with_phone := join(my_best_marketing,my_best_plus_phonej,
									left.did=right.did,
									with_phone(left,right), local, left outer);
//									
watchdog.layout_best with_ssn(my_best_marketing_with_phone l, my_best_plus_ssnj r) := transform
self.ssn := map(r.did<>0 => r.ssn, l.ssn);
self := l;
end;
my_best_marketing_with_ssn := join(my_best_marketing_with_phone,my_best_plus_ssnj,
									left.did=right.did,
									with_ssn(left,right), local, left outer);

//
watchdog.layout_best with_dob(my_best_marketing_with_ssn l, my_best_plus_dobj r) := transform
self.dob := map(r.did<>0 => r.dob, l.dob);
self := l;
end;
my_best_marketing_with_dob := join(my_best_marketing_with_ssn,my_best_plus_dobj,
									left.did=right.did,
									with_dob(left,right), local, left outer);
//
watchdog.layout_best with_address(my_best_marketing_with_dob l, my_best_plus_addressj r) := transform
self.addr_dt_last_seen := map(r.did<>0 => r.addr_dt_last_seen, l.addr_dt_last_seen);
self.prim_range := map(r.did<>0 => r.prim_range, l.prim_range);
self.predir:= map(r.did<>0 =>r.predir, l.predir);
self.prim_name:= map(r.did<>0 =>r.prim_name, l.prim_name);
self.suffix:= map(r.did<>0 =>r.suffix, l.suffix);
self.postdir:= map(r.did<>0 =>r.postdir, l.postdir);
self.unit_desig:= map(r.did<>0 =>r.unit_desig, l.unit_desig);
self.sec_range:= map(r.did<>0 =>r.sec_range, l.sec_range);
self.city_name:= map(r.did<>0 =>r.city_name, l.city_name);
self.st:= map(r.did<>0 =>r.st, l.st);
self.zip:=map(r.did<>0 => r.zip, l.zip);
self.zip4:=map(r.did<>0 => r.zip4, l.zip4); 
self := l;
end;
my_best_marketing_with_address := join(my_best_marketing_with_dob,my_best_plus_addressj,
									left.did=right.did,
									with_address(left,right), local,left outer);
//
watchdog.layout_best with_title(my_best_marketing_with_address l, my_best_plus_titlej r) := transform
self.title := map(r.did<>0 => r.title, l.title);
self := l;
end;
my_best_marketing_with_title := join(my_best_marketing_with_address,my_best_plus_titlej,
									left.did=right.did,
									with_title(left,right), local,left outer);
//
watchdog.layout_best with_fname(my_best_marketing_with_title l, my_best_plus_fnamej r) := transform
self.fname := map(r.did<>0 => r.fname, l.fname);
self := l;
end;
my_best_marketing_with_fname := join(my_best_marketing_with_title,my_best_plus_fnamej,
									left.did=right.did,
									with_fname(left,right), local,left outer);
//
watchdog.layout_best with_mname(my_best_marketing_with_fname l, my_best_plus_mnamej r) := transform
self.mname := map(r.did<>0 => r.mname, l.mname);
self := l;
end;
my_best_marketing_with_mname := join(my_best_marketing_with_fname,my_best_plus_mnamej,
									left.did=right.did,
									with_mname(left,right), local,left outer);
//
watchdog.layout_best with_lname(my_best_marketing_with_mname l, my_best_plus_lnamej r) := transform
self.lname := map(r.did<>0 => r.lname, l.lname);
self := l;
end;
my_best_marketing_with_lname := join(my_best_marketing_with_mname,my_best_plus_lnamej,
									left.did=right.did,
									with_lname(left,right), local,left outer);
//
watchdog.layout_best with_name_suffix(my_best_marketing_with_lname l, my_best_plus_name_suffixj r) := transform
self.name_suffix := map(r.did<>0 => r.name_suffix, l.name_suffix);
self := l;
end;
my_best_marketing_with_name_suffix := join(my_best_marketing_with_lname,my_best_plus_name_suffixj,
									left.did=right.did,
									with_name_suffix(left,right), local,left outer);
//
export BestMarketingEnhanced := my_best_marketing_with_name_suffix : persist('~thor_data400::persist::BestMarketingEnhanced');





