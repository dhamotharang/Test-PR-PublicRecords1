import header;

header.Layout_New_Records header_trans(boat_as_source L, integer c) := transform
	self.did := 0;
	self.rid := 0;
	self.pflag1 := '';
	self.pflag2 := '';
	self.pflag3 := '';
	self.dt_first_seen := (unsigned3)(l.date_first_seen[1..6]);
	self.dt_last_seen := (unsigned3)(l.date_last_seen[1..6]);
	self.dt_vendor_first_reported := (unsigned3)(l.date_vendor_first_reported[1..6]);
	self.dt_vendor_last_reported := (unsigned3)(l.date_vendor_last_reported[1..6]);
	self.dt_nonglb_last_seen := self.dt_last_seen;
	self.rec_type := '2';

	self.vendor_id :=  if(l.emid_number != '', trim(l.source) + ',' + trim(l.emid_number),
					  (trim(l.state) + ',' + trim(l.last_name) + ',' + trim(l.first_name) + 
						',' + l.date_vendor_first_reported));
	self.phone := choose(c, l.phone_one[1..10], l.phone_two[1..10], l.phone_one[1..10], l.phone_two[1..10]);
	self.ssn := '';
	self.dob := (integer)(l.birth_one);
	self.tnt := '';
	self.valid_ssn := '';
	self.jflag1 := '';
	self.jflag2 := '';
	self.jflag3 := '';
	self.prim_range := choose(c, l.prim_range, l.mail_prim_range, l.prim_range, l.mail_prim_range);
	self.predir := choose(c, l.predir, l.mail_predir, l.predir, l.mail_predir);
	self.prim_name := choose(c, l.prim_name, l.mail_prim_name, l.prim_name, l.mail_prim_name);
	self.suffix := choose(c, l.addr_suffix, l.mail_addr_suffix, l.addr_suffix, l.mail_addr_suffix);
	self.postdir := choose(c, l.postdir, l.mail_postdir, l.postdir, l.mail_postdir);
	self.unit_desig := choose(c, l.unit_desig, l.mail_unit_desig, l.unit_desig, l.mail_unit_desig);
	self.sec_range := choose(c, l.sec_range, l.mail_sec_range, l.sec_range, l.mail_sec_range);
	self.city_name := choose(c, l.city_name, l.mail_v_city_name, l.city_name, l.mail_v_city_name);
	self.st := choose(c, l.st, l.mail_st, l.st, l.mail_st);
	self.zip := choose(c, l.zip, l.mail_zip, l.zip, l.mail_zip);
	self.zip4 := choose(c, l.zip4, l.mail_zip4, l.zip4, l.mail_zip4);
	self.county := choose(c, l.county, l.mail_county, l.county, l.mail_county);
	self.geo_blk := choose(c, l.geo_blk, l.mail_geo_blk, l.geo_blk, l.mail_geo_blk);
	self.cbsa := choose(c, if(l.msa!='',l.msa + '0',''), if(l.mail_msa!='',l.mail_msa + '0',''), if(l.msa!='',l.msa + '0',''), if(l.mail_msa!='',l.mail_msa + '0',''));

	self := L;
end;
boat_file := boat_as_source;

Boat_norm := NORMALIZE(boat_file, 8, header_trans(LEFT, COUNTER));

export boat_as_header := 
	Boat_norm(lname != '' and prim_name != '' and zip != '' and length(trim(fname)) > 1);