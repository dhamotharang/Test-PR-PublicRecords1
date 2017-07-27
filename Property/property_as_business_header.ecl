import ut, business_header;

df := property.File_Fares_DID_Out(source_code = 'OO',
						    length(trim(_company)) >= 5,
						    ~((integer)zip = 0 and prim_name = ''),
						    stringlib.stringfind(_company,'00000',1) = 0,
						    stringlib.stringfilterout(_company,'1234567890-') != '',
						    stringlib.stringfilterout(_company,'1234567890- ') != 'TU',
					    	    (stringlib.stringfind(_company,'TRUST',1) = 0 or
							  stringlib.stringfind(_company,'BANK',1) != 0),
						    (stringlib.stringfind(_company,'FAMILY',1) = 0));


bh := business_header.File_Business_Header_Base;

slimrec := record
	string10	prim_Range;
	string28	prim_name;
	integer	zip;
end;

slimrec into_slim(bh L) := transform
	self.zip := (integer)L.zip;
	self := L;
end;

bh2 := project(bh,into_slim(LEFT));
bh3 := dedup(sort(distribute(bh2,hash(prim_name,zip)),prim_name,zip,prim_range,local),prim_name,zip,prim_range,local);

df filter_unknown_addresses(df L, bh3 R) := transform
	self := L;
end;

df2 := distribute(df,hash(prim_name,(integer)zip));
df3 := df2(prim_name[1..6] != 'PO BOX' and prim_name[1..8] != 'P.O. BOX');

df4 := join(df3,bh3, left.prim_range = right.prim_range and
						left.prim_name = right.prim_name and
						(integer)left.zip = right.zip,
					filter_unknown_addresses(LEFT,RIGHT),local);
					
df5 := df4 + df2(~(prim_name[1..6] != 'PO BOX' and prim_name[1..8] != 'P.O. BOX'));
					
business_header.Layout_Business_Header into_bh(df5 L) := transform
	self.zip := (integer)L.zip;
	self.zip4 := (integer)L.zip4;
	self.source := 'PR';
	self.dt_first_seen := (integer)L.process_date;
	self.dt_last_seen  := (integer)L.process_date;
	self.dt_vendor_first_reported := (integer)L.process_date;
	self.dt_vendor_last_reported := (integer)L.process_date;
	self.company_name := L._company;
	self.addr_suffix := L.suffix;
	self.city := L.p_city_name;
	self.state := l.st;
	self.county := L.county[3..5];
	self.phone := 0;
	self.current := true;
	self.vendor_id := L.source_code[1..2] + L.vendor[1..5] + L.fares_id[1..12];
	self.bdid := (integer)L.bdid;
	self := l;
end;

df6 := project(df5,into_bh(LEFT));
df7 := distribute(df6,hash(zip, trim(prim_name), trim(prim_range), trim(source_group), trim(company_name)));
df8 := sort(df7, zip, prim_range, prim_name, source_group, company_name,
                    if(sec_range <> '', 0, 1), sec_range,
                    if(phone <> 0, 0, 1), phone,
                    if(fein <> 0, 0, 1), fein,
                    dt_vendor_last_reported, dt_vendor_first_reported, dt_last_seen, local);

df8 roll_dups(df8 L, df8 R) := transform
	self.dt_first_seen := 
            ut.EarliestDate(ut.EarliestDate(L.dt_first_seen,R.dt_first_seen),
		    ut.EarliestDate(L.dt_last_seen,R.dt_last_seen));
	self.dt_last_seen := ut.LatestDate(L.dt_last_seen,R.dt_last_seen);
	self.dt_vendor_last_reported := ut.LatestDate(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
	self.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
	self.group1_id := if(L.group1_id = 0, R.group1_id, L.group1_id);
	self.vendor_id := if((L.group1_id = 0 and R.group1_id <> 0) or
					 L.vendor_id = '', R.vendor_id, L.vendor_id);
	self.source_group := if((L.group1_id = 0 and R.group1_id <> 0) or
					 L.source_group = '', R.source_group, L.source_group);
	self.phone := if(L.phone = 0, R.phone, L.phone);
	self.phone_score := if(L.phone = 0, R.phone_score, L.phone_score);
	self.fein := if(L.fein = 0, R.fein, L.fein);
	self.prim_range := if(l.prim_range = '' and l.zip4 = 0, r.prim_range, l.prim_range);
	self.predir := if(l.predir = '' and l.zip4 = 0, r.predir, l.predir);
	self.prim_name := if(l.prim_name = '' and l.zip4 = 0, r.prim_name, l.prim_name);
	self.addr_suffix := if(l.addr_suffix = '' and l.zip4 = 0, r.addr_suffix, l.addr_suffix);
	self.postdir := if(l.postdir = '' and l.zip4 = 0, r.postdir, l.postdir);
	self.unit_desig := if(l.unit_desig = ''and l.zip4 = 0, r.unit_desig, l.unit_desig);
	self.sec_range := if(l.sec_range = '' and l .zip4 = 0, r.sec_range, l.sec_range);
	self.city := if(l.city = '' and l.zip4 = 0, r.city, l.city);
	self.state := if(l.state = '' and l.zip4 = 0, r.state, l.state);
	self.zip := if(l.zip = 0 and l.zip4 = 0, r.zip, l.zip);
	self.zip4 := if(l.zip4 = 0, r.zip4, l.zip4);
	self.county := if(l.county = '' and l.zip4 = 0, r.county, l.county);
	self.msa := if(l.msa = '' and l.zip4 = 0, r.msa, l.msa);
	self.geo_lat := if(l.geo_lat = '' and l.zip4 = 0, r.geo_lat, l.geo_lat);
	self.geo_long := if(l.geo_long = '' and l.zip4 = 0, r.geo_long, l.geo_long);
	SELF := L;
END;

df9 := rollup(df8, left.zip = right.zip and
			          left.prim_name = right.prim_name and
			          left.prim_range = right.prim_range and
                      left.source_group = right.source_group and
			          left.company_name = right.company_name and
			          (right.sec_range = '' or left.sec_range = right.sec_range) and
                      (right.phone = 0 or left.phone = right.phone) and
			          (right.fein = 0 or left.fein = right.fein), 
		    roll_dups(LEFT,RIGHT),local);

export property_as_business_header := df9 : persist('persist::prop_as_bh');
