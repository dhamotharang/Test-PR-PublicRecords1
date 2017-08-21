import header,property;

Layout_Fares2_Search_in :=  record
string5		    vendor;
string12        fares_id;
string8         process_date;
string2         source_code;
string1         conjunctive_name_seq;
string5         title;
string20        fname;
string20        mname;
string20        lname;
string5         name_suffix;
string50        _company;
string30        nameasis;
string10        prim_range;
string2         predir;
string28        prim_name;
string4         suffix;
string2         postdir;
string10        unit_desig;
string8         sec_range;
string25        p_city_name;
string25        v_city_name;
string2         st;
string5         zip;
string4         zip4;
string4         cart;
string1         cr_sort_sz;
string4         lot;
string1         lot_order;
string2         dbpc;
string1         chk_digit;
string2         rec_type;
string5         county;
string10        geo_lat;
string11        geo_long;
string4         msa;
string7         geo_blk;
string1         geo_match;
string4         err_stat;
string8         dt_first_seen; 
string8         dt_last_seen; 
string8         dt_vendor_first_reported; 
string8         dt_vendor_last_reported;
string10        phone_number;
string2         lf;
end;

asse_in := property.Assessor_as_Source(length(trim(fips_code)) = 5);
deed_in := property.Deed_as_Source;
sear_in := dataset('~thor_data400::BASE::PropSrchHeader_Building',property.Layout_Fares_Search,flat)(fares_id[1..2] in ['RA','RD']);

//head_rec := header.Layout_New_Records;

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
count(sear_dist); 
asse_dist := distribute(asse_slim, hash(fares_id));
deed_dist := distribute(deed_slim, hash(fares_id));

Layout_Fares2_Search_in add_asse(sear_dist l, asse_dist r) := transform
	
	//same for seller and buyer
	self.dt_first_seen := map(l.source_code[2]='O' => (r.tax_year + '00'),
	 					 (integer)r.recording_date > 19000000 => (r.recording_date[1..6]), 
						      (integer)r.sale_date >      19000000 => (r.sale_date[1..6]),
							  (r.tax_year + '00'));
	//tax year for buyer
	self.dt_last_seen := if(l.source_code[1] = 'O',   
							 // when buyer
							 (r.tax_year + '00'),
							 // when seller
							 if((integer)r.recording_date > 19000000, (r.recording_date[1..6]), (r.sale_date[1..6])));
	self.dt_vendor_last_reported := self.dt_last_seen;
	self.dt_vendor_first_reported := self.dt_last_seen;
	//self.dt_nonglb_last_seen := self.dt_last_seen;
	//self.rec_type := if(l.source_code[1] = 'O', '1', '2');  //buying = 1, selling = 2
	self.phone_number := if((integer)r.owner_phone > 0 and l.source_code[1] = 'O', r.owner_phone, '');
	self.conjunctive_name_seq := '' ;
	self := l;
end;

two := join(sear_dist, asse_dist, left.fares_id = right.fares_id,
			add_asse(left, right), left outer, local);

count(two); 			
output(two(dt_last_seen <> ''));
count(two(dt_last_seen <> ''));			

Layout_Fares2_Search_in add_deed(two l, deed_dist r) := transform
	self.dt_first_seen := if(r.fares_id <> '', (r.recording_date_yyyymmdd[1..6]), l.dt_first_seen);
	self.dt_last_seen := if(r.fares_id <> '', (r.recording_date_yyyymmdd[1..6]), l.dt_last_seen);
	self.dt_vendor_last_reported := if(r.fares_id <> '', (r.recording_date_yyyymmdd[1..6]), l.dt_vendor_last_reported);
	self.dt_vendor_first_reported := if(r.fares_id <> '', (r.recording_date_yyyymmdd[1..6]), l.dt_vendor_first_reported);
	//self.dt_nonglb_last_seen := if(r.fares_id <> '', (integer)(r.recording_date_yyyymmdd[1..6]), l.dt_nonglb_last_seen);
	self := l;
end;

three := join(two, deed_dist, left.fares_id = right.fares_id,
			  add_deed(left, right), left outer, local);
			  
output(three(dt_last_seen <> ''));
count(three(dt_last_seen <> ''));
count(three);					  

Layout_Fares2_Search_in easy_way(three l) := transform
	self.dt_vendor_first_reported := l.dt_first_seen;
	self.dt_last_seen := if(l.dt_last_seen < l.dt_first_seen, l.dt_first_seen, l.dt_last_seen);
	self.dt_vendor_last_reported := self.dt_last_seen;
	//self.dt_nonglb_last_seen := self.dt_last_seen;
	self := l;
end;

final := project(three, easy_way(left));
count(final) ;
output(final) ;
output(final,,'~thor_data400::in::LN_propertyv2::fares::searchV1_V2_thru_20070803',__compressed__);
