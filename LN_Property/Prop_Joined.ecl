//  Assemble the LN Property data for use in the Header file

import LN_Mortgage, header;

//  DeedMortgage := file_deed;
asse_in := LN_Property.Assessor_as_Source;
deed_in := LN_Property.Deed_as_Source;
sear_in := Dataset('~thor_data400::BASE::LN_PropSrchHeader_Building', LN_Property.Layout_Deed_Mortgage_Property_Search, flat)(source_code not in ['OS','SO']);

head_rec := header.Layout_New_Records;

//  slim the assessor rec to id, phone, date
asse_slim_rec := record
	asse_in.ln_fares_id;
	asse_in.assessee_phone_number;
	asse_in.tax_year;
	asse_in.recording_date;
	asse_in.sale_date;
	//asse_in.source;
  asse_in.src;	
	asse_in.uid;
end;

asse_slim := table(asse_in, asse_slim_rec);


//slim the deeds rec to id, date
deed_slim_rec := record
	deed_in.ln_fares_id;
	deed_in.recording_date;
	deed_in.src;
	deed_in.uid;
end;

deed_slim := table(deed_in, deed_slim_rec);

//  Append the data and transform to a header type rec
sear_dist := distribute(sear_in,   hash(ln_fares_id));
asse_dist := distribute(asse_slim, hash(ln_fares_id));
deed_dist := distribute(deed_slim, hash(ln_fares_id));


head_rec add_asse(sear_dist l, asse_dist r) := transform
	//same for seller and buyer
self.dt_first_seen := map(l.source_code[2]='O'            => (integer)(r.tax_year + '00'),
	 					           (integer)r.recording_date > 19000000 => (integer)(r.recording_date[1..6]), 
						           (integer)r.sale_date >      19000000 => (integer)(r.sale_date[1..6]),
							         (integer)(r.tax_year + '00'));
											 
	//tax year for buyer
	self.dt_last_seen := if(l.source_code[1] = 'O',   
							 // when buyer
							 (integer)(r.tax_year + '00'),
							 // when seller
							 if((integer)r.recording_date > 19000000, (integer)(r.recording_date[1..6]), (integer)(r.sale_date[1..6])));
							 
	self.dt_vendor_last_reported  := self.dt_last_seen;
	self.dt_vendor_first_reported := self.dt_last_seen;
	self.dt_nonglb_last_seen      := self.dt_last_seen;
	self.rec_type                 := if(l.source_code[1] = 'O', '1', '2');  //buying = 1, selling = 2
	self.vendor_id                := l.ln_fares_id + 'FA' + ((string)(hash(l.fname, l.lname, l.prim_name)))[1..4];
	self.phone                    := if((integer)r.assessee_phone_number > 0 and l.source_code[1] = 'O', r.assessee_phone_number, '');
	self.county                   := l.county[3..5];
	self.city_name                := l.v_city_name;
	self.src                      := r.src;
	self.uid                      := r.uid;
	self                          := l;
	self						:= [];
end;

d1 := join(sear_dist(ln_fares_id[2]='A'), asse_dist, left.ln_fares_id = right.ln_fares_id,
			      add_asse(left, right), local);

head_rec add_deed(sear_dist l, deed_dist r) := transform
	self.dt_first_seen            := (integer)(r.recording_date[1..6]);
	self.dt_last_seen             := (integer)(r.recording_date[1..6]);
	self.dt_vendor_last_reported  := (integer)(r.recording_date[1..6]);
	self.dt_vendor_first_reported := (integer)(r.recording_date[1..6]);
	self.dt_nonglb_last_seen      := (integer)(r.recording_date[1..6]);
	self.src                      := r.src;
	self.uid                      := r.uid;
	self                          := l;
	self						:= [];
end;

d2 := join(sear_dist(ln_fares_id[2]!='A'), deed_dist, left.ln_fares_id = right.ln_fares_id,
			     add_deed(left, right), local);


head_rec easy_way(head_rec l) := transform
	self.dt_vendor_first_reported := l.dt_first_seen;
	self.dt_last_seen             := if(l.dt_last_seen < l.dt_first_seen, l.dt_first_seen, l.dt_last_seen);
	self.dt_vendor_last_reported  := self.dt_last_seen;
	self.dt_nonglb_last_seen      := self.dt_last_seen;
	self                          := l;
end;

final := project(d1+d2, easy_way(left));


export Prop_Joined := final: persist('~thor_data400::persist::headerbuild_ln_property_as_header');