import header;
deeds     := ln_propertyv2.ln_propertyv2_as_source(,true).ln_propertyv2_deed_as_source(ln_fares_id[1] ='R' and fares_unformatted_apn!='');
assessors := ln_propertyv2.ln_propertyv2_as_source(,true).ln_propertyv2_tax_as_source(ln_fares_id[1] ='R' and fares_unformatted_apn !='');
search    := ln_propertyv2.ln_propertyv2_as_source(,true).pwatchdog(rec_type='1' and did!=0);

new_rec := record
 unsigned6    DID := 0;
 string12     ln_fares_id;
 string45     apn;
 unsigned3 	  dt_last_seen := 0;
 qstring10    prim_range := '';
 qstring28    prim_name :='';
 qstring5	  zip :='';
end;


//  Pull clean address,DID from search file for deed records

deeds_dist     := distribute(deeds,hash(ln_fares_id)); 
assessors_dist := distribute(assessors,hash(ln_fares_id)); 
search_dist    := distribute(search,hash((string)(vendor_id[1..12])));

new_rec small_d(deeds_dist l, search_dist r ) := transform 

  self.apn          := l.fares_unformatted_apn;
  self.prim_range   := r.prim_range;
  self.prim_name    := r.prim_name;
  self.zip          := r.zip;
  self              := l;
end ; 

deeds_p := join(deeds_dist ,search_dist(source_code[2]='P'), left.ln_fares_id = right.vendor_id[1..12]
                                          ,small_d(left,right),left outer,local); 


// Pull clean address,did from search file for Tax record

new_rec small_a(assessors_dist l, search_dist r ) := transform 

  self.apn           := l.fares_unformatted_apn;
  self.prim_range    := r.prim_range;
  self.prim_name     := r.prim_name;
  self.zip           := r.zip;
  self               := l;
end ; 

assess_p := join(assessors_dist ,search_dist(source_code[2]='P'), left.ln_fares_id = right.vendor_id[1..12]
                                          ,small_a(left,right),left outer,local); 

// get DID from search file										  
new_rec get_did(new_rec l, search_dist r ) := transform 

 self.dt_last_seen := r.dt_last_seen;
 self.did          := r.did;
 self              := l;
end ; 
 
deeds_name := join(deeds_p ,search_dist, left.ln_fares_id = right.vendor_id[1..12]and left.prim_range=right.prim_range
					 and left.prim_name=right.prim_name and left.zip=right.zip,get_did(left,right),local); 

assess_name := join(assess_p ,search_dist, left.ln_fares_id = right.vendor_id[1..12]and left.prim_range=right.prim_range
					 and left.prim_name=right.prim_name and left.zip=right.zip,get_did(left,right),local); 


//Dedup taking the latest deeds

srt_deeds  := sort(distribute(deeds_name,hash(apn)),apn,-dt_last_seen,-ln_fares_id,did,local);
dup_deeds  := dedup(srt_deeds,apn,local);
dis_assess := distribute(assess_name,hash(apn));

two_IDs := record
 new_rec;
 string12     deeds_ln_fares_id;
 qstring5     title := '';
 qstring20    fname := '';
 qstring20    mname := '';
 qstring20    lname := '';
 qstring5     name_suffix := '';
end;

two_IDs findAssessor(new_rec L, new_rec R) := transform
 self.deeds_ln_fares_id := l.ln_fares_id;
 self.ln_fares_id       := r.ln_fares_id;
 self := l;
end;

//Join to find assessor record for each deed
deeds_with_assess := join(dup_deeds, dis_assess,left.apn=right.apn and left.did=right.did and left.prim_range=right.prim_range
							and left.prim_name=right.prim_name and left.zip=right.zip,findAssessor(left,right),local);

two_IDs getDID(two_IDs L, search_dist R) := transform
 self.DID   := r.did;
 self.title := r.title;
 self.fname := r.fname;
 self.mname := r.mname;
 self.lname := r.lname;
 self.name_suffix := r.name_suffix;
 self := l;
end;

//Join result back to Search DID to find other DIDs for this same record. 
deeds_w_dis := distribute(deeds_with_assess,hash(ln_fares_id));
add_DID := join(deeds_w_dis, search_dist,left.ln_fares_id=(string)right.vendor_id[1..12] and 
				left.did!=right.did and left.prim_range=right.prim_range
				and left.prim_name=right.prim_name and left.zip=right.zip,getDID(left,right),local);

//join back with search file again to put deeds info into Header layout
header.Layout_New_Records changeLayout(two_IDs L, search_dist R) := transform
    self.did   := l.did;
	self.src   := 'FB';
	self.title := l.title;
	self.fname := l.fname;
	self.mname := l.mname;
	self.lname := l.lname;
	self.name_suffix := l.name_suffix;
	self := r;
end;

Dis_by_deed := distribute(add_did,hash(deeds_ln_fares_id));

j_final := join(Dis_by_deed,search_dist,left.deeds_ln_fares_id=(string)right.vendor_id[1..12] and left.prim_range=right.prim_range
			and left.prim_name=right.prim_name and left.zip=right.zip,changeLayout(left,right),local);

export Assessors_as_Deeds := dedup(sort(j_final,vendor_id[1..12],-dt_last_seen,did,local),vendor_id[1..12],local) : persist('~thor_data400::persist::ln_propertyV2::assessors_as_deeds');

