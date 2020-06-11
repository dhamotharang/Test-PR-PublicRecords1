import dx_header, census_data, dx_Gong, risk_indicators;

string5 zip_code_val := '' : stored('Zip');
string3 addr_type_val := '' : stored('ResidenceType');
integer4 dt_fr_val := 0 : stored('DateFrom');
integer4 dt_to_val := 999999 : stored('DateTo');

addr_rsch_key := dx_header.key_address_research();
census_key := census_data.Key_Smart_Jury;
gong_addr_key := dx_Gong.key_address_current();
areacode_change_key := risk_indicators.Key_AreaCode_Change_plus;

//get apt building address within input date range
addr_recs := limit(addr_rsch_key(keyed(zip=zip_code_val),
                                 keyed(addr_type=addr_type_val),
					        first_seen >= dt_fr_val,
					        last_seen <= dt_to_val), 400000, fail('Too many address found.'));

//get census info
layout_address_research get_census(addr_recs l, census_key r) := transform
	self := l;
	self := r;
	self.phone_info := [];
end;

with_census := join(addr_recs, census_key,
                    keyed(left.stusab = right.stusab) and
				keyed(left.county = right.county) and
				keyed(left.tract = right.tract) and
				keyed(left.blkgrp = right.blkgrp),
				get_census(left, right), left outer);

//get npa, nxx info
addr_phone_rec := record
     string10  prim_range,
	string2   predir,
	string28  prim_name,
	string4   suffix,
	string5   zip,
	layout_phone_info,
	string10 phone10,
end;

addr_phone_rec get_phone(addr_recs l, gong_addr_key r) := transform
     self.npa := r.phone10[1..3];
	self.nxx := r.phone10[4..6];
	self.phone10 := r.phone10;
	self := l;
	self := [];
end;

phone_raw_recs := join(addr_recs, gong_addr_key,
					 keyed(left.prim_name = right.prim_name) and
					 wild(right.st) and
					 keyed(left.zip = right.z5) and
					 keyed(left.prim_range = right.prim_range) and
					 left.predir = right.predir,
					 get_phone(left, right), LIMIT(1000,SKIP));

phone_recs := dedup(sort(phone_raw_recs(npa<>'', nxx<>''),
                         record, except phone10),
                    record, except phone10);

addr_phone_rec get_areacode_change(phone_recs l, areacode_change_key r) := transform
	self.old_npa := r.new_npa;
	self.old_nxx := r.new_nxx;
	self := r;
	self := l;
end;

phone_final := join(phone_recs, areacode_change_key,
			     keyed(left.npa=right.old_NPA) and
				keyed(left.nxx=right.old_NXX) and
				right.reverse_flag,
				get_areacode_change(left, right),
				left outer, keep(1));

//append npa, nxx to the output
layout_address_research get_phone_info(with_census l) := transform
	self.phone_info := project(phone_final(prim_name=l.prim_name,
	                                       zip=l.zip,
								    prim_range = l.prim_range,
								    predir = l.predir),
								    transform({layout_phone_info}, self := left));
	self := l;
end;

export Address_Research_Records := project(with_census, get_phone_info(left));
