import header, doxie;
deeds     := ln_property.Deed_as_Source(fares_unformatted_apn != '');
assessors := ln_property.Assessor_as_Source(fares_unformatted_apn != '');
search    := ln_property.Prop_DID(rec_type = '1' and did != 0);

new_rec := record
  unsigned6  DID := 0;
  string12   ln_fares_id;
  string45   apn;
  unsigned3  dt_last_seen := 0;
  string10   prim_range;
  string28   prim_name;
  string5    zip;
	string182  clean_address;  //Remove this?
end;

new_rec small_d(deeds L) := transform
  self.apn           := l.fares_unformatted_apn;
	self.clean_address := doxie.cleanaddress182(l.property_full_street_address, l.property_address_citystatezip);
  self.prim_range    := self.clean_address[1..10]; //l.prop_prim_range;
  self.prim_name     := self.clean_address[13..40]; //l.prop_prim_name;
  self.zip           := self.clean_address[117..121]; //l.prop_ace_zip;
  self               := l;
end;

new_rec small_a(assessors L) := transform
  self.apn           := l.fares_unformatted_apn;
	self.clean_address := doxie.cleanaddress182(l.property_full_street_address, l.property_city_state_zip); 
  self.prim_range    := self.clean_address[1..10];
  self.prim_name     := self.clean_address[13..40];
  self.zip           := self.clean_address[117..121];
  self               := l;
end;

//  Slim down deeds and assessors files before join
sm_d := project(deeds    , small_d(left));
sm_a := project(assessors, small_a(left));

new_rec slim_d(new_rec L, header.Layout_New_Records R) := transform
 self.dt_last_seen := r.dt_last_seen;
 self.did          := r.did;
 self              := l;
end;

d_deed   := distribute(sm_d  , hash(ln_fares_id));
d_assess := distribute(sm_a  , hash(ln_fares_id));
d_search := distribute(search, hash((string)(vendor_id[1..12])));

//  Join deeds and assessors to Search file to get DID
deeds_name := join(d_deed, d_search, 
                   left.ln_fares_id = (string)right.vendor_id[1..12] and 
									 left.prim_range  = right.prim_range and
					         left.prim_name   = right.prim_name and 
									 left.zip         = right.zip,
					         slim_d(left, right), local);
					 
assess_name := join(d_assess, d_search, 
           left.ln_fares_id = (string)right.vendor_id[1..12] and 
					 left.prim_range  = right.prim_range and
					 left.prim_name   = right.prim_name and 
					 left.zip         = right.zip,
					 slim_d(left, right), local); /// : persist('~thor_data400::persist::ln_assess_name_join');  // This is slowest section


// assess_name := join(d_search, d_assess,
           // right.ln_fares_id = (string)left.vendor_id[1..12] and 
					 // right.prim_range  = left.prim_range and
					 // right.prim_name   = left.prim_name and 
					 // right.zip         = left.zip,
					 // slim_d(right, left), local) : persist('~thor_data400::persist::ln_assess_name_join');  // This is slowest section


//  Dedup taking the latest deeds
srt_deeds  := sort(distribute(deeds_name, hash(apn)), apn, -dt_last_seen, -ln_fares_id, did, local);
dup_deeds  := dedup(srt_deeds, apn, local);
dis_assess := distribute(assess_name, hash(apn));

two_IDs := record
 new_rec;
 string12  deeds_fares_id;
 qstring5  title := '';
 string20  fname := '';
 string20  mname := '';
 string20  lname := '';
 string5   name_suffix := '';
end;

two_IDs findAssessor(new_rec L, new_rec R) := transform
 self.deeds_fares_id := l.ln_fares_ID;
 self.ln_fares_ID    := r.ln_fares_ID;
 self                := l;
end;

//  Join to find assessor record for each deed
deeds_with_assess := join(dup_deeds, dis_assess,
                         left.apn        = right.apn and 
												 left.did        = right.did and 
												 left.prim_range = right.prim_range and
							           left.prim_name  = right.prim_name and 
												 left.zip        = right.zip, findAssessor(left,right), local);  // This results in zero matches

two_IDs getDID(two_IDs L, search R) := transform
 self.DID         := r.did;
 self.title       := r.title;
 self.fname       := r.fname;
 self.mname       := r.mname;
 self.lname       := r.lname;
 self.name_suffix := r.name_suffix;
 self             := l;
end;

//  Join result back to Search DID to find other DIDs for this same record.
deeds_w_dis := distribute(deeds_with_assess, hash(ln_fares_id));

add_DID := join(deeds_w_dis, d_search, 
                 left.ln_fares_id = (string)right.vendor_id[1..12] and 
                 left.did        != right.did and 
								 left.prim_range  = right.prim_range and
                 left.prim_name   = right.prim_name and 
								 left.zip         = right.zip, getDID(left, right), local);

//  join back with search file again to put deeds info into Header layout
header.Layout_New_Records changeLayout(two_IDs L, header.Layout_New_Records R) := transform
  self.did         := l.did;
	self.src         := 'FB';
	self.title       := l.title;
	self.fname       := l.fname;
	self.mname       := l.mname;
	self.lname       := l.lname;
	self.name_suffix := l.name_suffix;
	self             := r;
end;

Dis_by_deed := distribute(add_did, hash(deeds_fares_id));

j_final := join(Dis_by_deed, d_search, 
                left.deeds_fares_id = (string)right.vendor_id[1..12] and 
								left.prim_range     = right.prim_range and
			          left.prim_name      = right.prim_name and 
								left.zip            = right.zip, changeLayout(left, right), local);

export Assessors_as_Deeds := dedup(sort(j_final, vendor_id[1..12], -dt_last_seen, did, local), vendor_id[1..12], local) : persist('~thor_data400::persist::ln_assessors_as_deeds');