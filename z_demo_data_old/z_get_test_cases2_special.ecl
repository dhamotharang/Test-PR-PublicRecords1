
import header,property,watchdog,bankruptcyv2,ln_propertyv2;

head 				:= dataset('~thor_data400::Base::HeaderKey_Building', header.Layout_Header, flat);
my_fc				:= pull(property.Key_Foreclosure_DID);
my_best 		:= pull(watchdog.Key_watchdog_glb);
my_bk				:= pull(bankruptcyv2.key_bankruptcy_did);
my_prop			:= pull(ln_propertyv2.key_Property_did);


// An individual or SSN that has no address or address history. 
head_address := 
							   head(prim_range<>'' or 
											predir<>'' or 
											prim_name<>'' or 
											suffix<>'' or 
											postdir<>'' or
											unit_desig<>'' or
											sec_range<>'' or
											city_name<>'' or
											st <>'' or
											zip<>'' or
											zip4<>'');
head_no_address := 
							   head(prim_range='' and 
											predir='' and 
											prim_name='' and 
											suffix='' and 
											postdir='' and
											unit_desig='' and
											sec_range='' and
											city_name='' and
											st ='' and
											zip='' and
											zip4='');

did_no_address := join(head_no_address, head_address, left.did=right.did, left only);
my_best j1(my_best l, header.layout_header r) := transform
self := l;
end;
res_no_address := join(my_best, did_no_address,left.did=right.did ,j1(left,right),lookup);
o1:=output(choosen(dedup(sort(res_no_address,record),all),10),named('No_address_in_header'));

// An individual or SSN that has no DOB at all.
head_dob := head(dob<>0);
head_no_dob := head(dob=0);
did_no_dob := join(head_no_dob, head_dob, left.did=right.did, left only);
res_no_dob := join(my_best, did_no_dob,left.did=right.did ,j1(left,right),lookup);
o2:=output(choosen(dedup(sort(res_no_dob,record),all),10),named('No_DOB_in_header'));

// An SSN where multiple names associated with it
did_ssn_tbl := dedup(sort(table(head(trim(ssn) not in['0','']),{did,ssn},few),record),all);
layout_did_ssn_count := record
unsigned6	did := did_ssn_tbl.did;
unsigned4	xcount := count(group);
end;
my_best j2(my_best l, layout_did_ssn_count r) := transform
self := l;
end;
did_ssn_count := table(did_ssn_tbl,layout_did_ssn_count,did,few);
did_multiple_ssn := join(my_best, did_ssn_count(xcount=2),left.did=right.did ,j2(left,right),lookup);
res_ssn:=dedup(sort(did_multiple_ssn,did,ssn),did,ssn);
o3:=output(choosen(res_ssn(ssn<>''),10),named('Multiple_SSNs_in_header'));

// An individual who CURRENTLY owns more than one property.
// An individual who has owned 5 or more properties in the past. 
layout_did_prop_count := record
unsigned6	did := my_prop.s_did;
unsigned4	xcount := count(group);
end;
my_best j5(my_best l, layout_did_prop_count r) := transform
self := l;
end;
my_prop2 := dedup(sort(my_prop(source_code='OO'),s_did,prim_range,prim_name,sec_range,p_city_name,st),s_did,prim_range,prim_name,sec_range,p_city_name,st,all);
did_prop_count := table(my_prop2,layout_did_prop_count,s_did,few);
did_multiple_prop := join(my_best, did_prop_count(xcount>=10),left.did=right.did ,j5(left,right),lookup);
res_prop_ge_5:=dedup(sort(did_multiple_prop,record),all);
o4_5:=output(choosen(res_prop_ge_5(did in [999925251886,999952697327]),10),named('Multiple_Property_incl_2_current'));

// An individual who has more than one foreclosure. (This is coming soon with the Foreclosure data, right?)
layout_did_fc_count := record
unsigned6	did := my_fc.did;
unsigned4	xcount := count(group);
end;
my_best j3(my_best l, layout_did_fc_count r) := transform
self := l;
end;
did_fc_count := table(my_fc,layout_did_fc_count,did,few);
did_multiple_fc := join(my_best, did_fc_count(xcount=2),left.did=right.did ,j3(left,right),lookup);
res_fc:=dedup(sort(did_multiple_fc,record),all);
o6:=output(choosen(res_fc,10),named('Multiple_Foreclosures'));

// An individual that has multiple Bankruptcy history in the past seven years.
layout_did_bk_count := record
unsigned6	did := my_bk.did;
unsigned4	xcount := count(group);
end;
my_best j4(my_best l, layout_did_bk_count r) := transform
self := l;
end;
did_bk_count := table(my_bk,layout_did_bk_count,did,few);
did_multiple_bk := join(my_best, did_bk_count(xcount>=2),left.did=right.did ,j4(left,right),lookup);
res_bk:=dedup(sort(did_multiple_bk,record),all);
o7:=output(choosen(res_bk(st='AK'),10),named('Multiple_Bankruptcy'));

sequential(o1,o2,o3,o4_5,o6,o7);