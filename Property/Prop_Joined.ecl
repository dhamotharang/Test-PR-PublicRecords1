import header;

asse_in := property.Assessor_as_Source(length(trim(fips_code)) = 5);
deed_in := property.Deed_as_Source;
sear_in := dataset('~thor_data400::BASE::PropSrchHeader_Building',Layout_Fares_Search,flat)(fares_id[1..2] in ['RA','RD']);

head_rec := header.Layout_New_Records;

//slim the assessor rec to id,phone, date
asse_slim_rec := record
	asse_in.fares_id;
	asse_in.owner_phone;
	asse_in.tax_year;
	asse_in.recording_date;
	asse_in.sale_date;
	asse_in.src;
	asse_in.uid;
end;

asse_slim := table(asse_in, asse_slim_rec);

//slim the deeds rec to id, date
deed_slim_rec := record
	deed_in.fares_id;
	deed_in.recording_date_yyyymmdd;
	deed_in.src;
	deed_in.uid;
end;

deed_slim := table(deed_in, deed_slim_rec);

//append the data and transform to a header type rec
sear_dist := distribute(sear_in, hash(fares_id));
asse_dist := distribute(asse_slim, hash(fares_id));
deed_dist := distribute(deed_slim, hash(fares_id));

head_rec add_asse(sear_dist l, asse_dist r) := transform
	self.rid := 0;
	self.pflag1 := '';		//for original pflag purposes
	self.pflag2 := '';		//for phone number related work
	self.pflag3 := '';		//for future purposes

		//same for seller and buyer
	self.dt_first_seen := map(l.source_code[2]='O' => (integer)(r.tax_year + '00'),
	 					 (integer)r.recording_date > 19000000 => (integer)(r.recording_date[1..6]), 
						      (integer)r.sale_date >      19000000 => (integer)(r.sale_date[1..6]),
							   (integer)(r.tax_year + '00'));
		//tax year for buyer
	self.dt_last_seen := if(l.source_code[1] = 'O',   
							 // when buyer
							 (integer)(r.tax_year + '00'),
							 // when seller
							 if((integer)r.recording_date > 19000000, (integer)(r.recording_date[1..6]), (integer)(r.sale_date[1..6])));
	self.dt_vendor_last_reported := self.dt_last_seen;
	self.dt_vendor_first_reported := self.dt_last_seen;
	self.dt_nonglb_last_seen := self.dt_last_seen;
	self.rec_type := if(l.source_code[1] = 'O', '1', '2');  //buying = 1, selling = 2
	self.vendor_id := l.fares_id + 'FA' + ((string)(hash(l.fname, l.lname, l.prim_name)))[1..4];
	self.phone := if((integer)r.owner_phone > 0 and l.source_code[1] = 'O', r.owner_phone, '');
	self.county := l.county[3..5];
	self.ssn := '';
	self.dob := 0;
	self.city_name := l.v_city_name;
	self.src := r.src;
	self.uid := r.uid;
	self.did := 0;
	self := l;
end;

two := join(sear_dist, asse_dist, left.fares_id = right.fares_id,
			add_asse(left, right), left outer, local);

head_rec add_deed(head_rec l, deed_dist r) := transform
	self.dt_first_seen := if(r.fares_id <> '', (integer)(r.recording_date_yyyymmdd[1..6]), l.dt_first_seen);
	self.dt_last_seen := if(r.fares_id <> '', (integer)(r.recording_date_yyyymmdd[1..6]), l.dt_last_seen);
	self.dt_vendor_last_reported := if(r.fares_id <> '', (integer)(r.recording_date_yyyymmdd[1..6]), l.dt_vendor_last_reported);
	self.dt_vendor_first_reported := if(r.fares_id <> '', (integer)(r.recording_date_yyyymmdd[1..6]), l.dt_vendor_first_reported);
	self.dt_nonglb_last_seen := if(r.fares_id <> '', (integer)(r.recording_date_yyyymmdd[1..6]), l.dt_nonglb_last_seen);
	self.src := if(r.fares_id<>'',r.src,l.src);
	self.uid := if(r.fares_id<>'',r.uid,l.uid);
	self := l;
end;

three := join(two, deed_dist, left.vendor_id[1..12] = right.fares_id,
			  add_deed(left, right), left outer, local);

head_rec easy_way(three l) := transform
	self.dt_vendor_first_reported := l.dt_first_seen;
	self.dt_last_seen := if(l.dt_last_seen < l.dt_first_seen, l.dt_first_seen, l.dt_last_seen);
	self.dt_vendor_last_reported := self.dt_last_seen;
	self.dt_nonglb_last_seen := self.dt_last_seen;
	self := l;
end;

final := project(three, easy_way(left));

export prop_joined := final : persist('Property_Prop_Joined');