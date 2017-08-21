import header;
deeds := property.Deed_as_Source(apn_parcel_number_unformatted!='');
assessors := property.Assessor_as_Source(unformatted_apn!='');
search := property.Prop_DID(rec_type='1' and did!=0);

new_rec := record
 unsigned6    DID := 0;
 string12     fares_id;
 string45     apn;
 unsigned3 	  dt_last_seen := 0;
 qstring10    prim_range;
 qstring28    prim_name;
 qstring5	  zip;
end;

new_rec small_d(deeds L) := transform
 self.apn := l.apn_parcel_number_unformatted;
 self.prim_range := l.prop_prim_range;
 self.prim_name := l.prop_prim_name;
 self.zip := l.prop_ace_zip;
 self := l;
end;

new_rec small_a(assessors L) := transform
 self.apn := l.unformatted_apn;
 self.prim_range := l.prop_prim_range;
 self.prim_name := l.prop_prim_name;
 self.zip := l.prop_zip;
 self := l;
end;

//Slim down deeds and assessors files before join
sm_d := project(deeds,small_d(left));
sm_a := project(assessors,small_a(left));

new_rec slim_d(new_rec L, header.Layout_New_Records R) := transform
 self.dt_last_seen := r.dt_last_seen;
 self.did := r.did;
 self := l;
end;

d_deed := distribute(sm_d,hash(fares_id));
d_assess := distribute(sm_a,hash(fares_id));
d_search := distribute(search,hash((string)(vendor_id[1..12])));

//Join deeds and assessors to Search file to get DID
deeds_name := join(d_deed,d_search,left.fares_id=(string)right.vendor_id[1..12] and left.prim_range=right.prim_range
					 and left.prim_name=right.prim_name and left.zip=right.zip,
					 slim_d(left,right),local);
assess_name := join(d_assess,d_search,left.fares_id=(string)right.vendor_id[1..12] and left.prim_range=right.prim_range
					 and left.prim_name=right.prim_name and left.zip=right.zip,
					 slim_d(left,right),local);

//Dedup taking the latest deeds
srt_deeds := sort(distribute(deeds_name,hash(apn)),apn,-dt_last_seen,-fares_id,did,local);
dup_deeds := dedup(srt_deeds,apn,local);
dis_assess := distribute(assess_name,hash(apn));

two_IDs := record
 new_rec;
 string12     deeds_fares_id;
 qstring5     title := '';
 qstring20    fname := '';
 qstring20    mname := '';
 qstring20    lname := '';
 qstring5     name_suffix := '';
end;

two_IDs findAssessor(new_rec L, new_rec R) := transform
 self.deeds_fares_id := l.fares_ID;
 self.fares_ID := r.fares_ID;
 self := l;
end;

//Join to find assessor record for each deed
deeds_with_assess := join(dup_deeds, dis_assess,left.apn=right.apn and left.did=right.did and left.prim_range=right.prim_range
							and left.prim_name=right.prim_name and left.zip=right.zip,findAssessor(left,right),local);

two_IDs getDID(two_IDs L, search R) := transform
 self.DID := r.did;
 self.title := r.title;
 self.fname := r.fname;
 self.mname := r.mname;
 self.lname := r.lname;
 self.name_suffix := r.name_suffix;
 self := l;
end;

//Join result back to Search DID to find other DIDs for this same record.
deeds_w_dis := distribute(deeds_with_assess,hash(fares_id));
add_DID := join(deeds_w_dis, d_search,left.fares_id=(string)right.vendor_id[1..12] and 
				left.did!=right.did and left.prim_range=right.prim_range
				and left.prim_name=right.prim_name and left.zip=right.zip,getDID(left,right),local);

//join back with search file again to put deeds info into Header layout
header.Layout_New_Records changeLayout(two_IDs L, header.Layout_New_Records R) := transform
    self.did := l.did;
	self.src := 'FB';
	self.title := l.title;
	self.fname := l.fname;
	self.mname := l.mname;
	self.lname := l.lname;
	self.name_suffix := l.name_suffix;
	self := r;
end;

Dis_by_deed := distribute(add_did,hash(deeds_fares_id));

j_final := join(Dis_by_deed,d_search,left.deeds_fares_id=(string)right.vendor_id[1..12] and left.prim_range=right.prim_range
			and left.prim_name=right.prim_name and left.zip=right.zip,changeLayout(left,right),local);

export Assessors_as_Deeds := dedup(sort(j_final,vendor_id[1..12],-dt_last_seen,did,local),vendor_id[1..12],local) : persist('~thor_data400::persist::assessors_as_deeds','thor_dell400_2');