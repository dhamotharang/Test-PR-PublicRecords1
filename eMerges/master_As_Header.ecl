import header;

header.Layout_New_Records header_trans(Master_as_Source L, integer c) := transform
	self.did := 0;
	self.rid := 0;
	self.vendor_id := trim(l.source) + trim(l.vendor_id);
	self.rec_type := '2'; 
	self.pflag1 := '';
	self.pflag2 := '';
	self.pflag3 := '';
	self.ssn := '';
	self.dob := if((integer)l.dob_str in [19000101,19010101],0,(integer)l.dob_str);
	self.tnt := '';
	self.dt_first_seen := (integer)(l.date_first_seen[1..6]);
	self.dt_last_seen := (integer)(l.date_last_seen[1..6]);
	self.dt_vendor_last_reported := (integer)(l.date_last_seen[1..6]);
	self.dt_vendor_first_reported := (integer)(l.date_first_seen[1..6]);
	self.dt_nonglb_last_seen := 0;
	self.prim_range := choose(c,l.prim_range,l.mail_prim_range);
	self.predir := choose(c,l.predir,l.mail_predir);
	self.prim_name := choose(c,l.prim_name,l.mail_prim_name);
	self.suffix := choose(c,l.suffix,l.mail_addr_suffix);
	self.postdir := choose(c,l.postdir,l.mail_postdir);
	self.unit_desig := choose(c,l.unit_desig,l.mail_unit_desig);
	self.sec_range := choose(c,l.sec_range,l.mail_sec_range);
	self.city_name := choose(c,l.city_name,l.mail_v_city_name);
	self.st := choose(c,l.st,l.mail_st);
	self.zip := choose(c,l.zip,l.mail_zip);
	self.zip4 := choose(c,l.zip4,l.mail_zip4);
	self.county := choose(c,l.county,l.mail_county);
	self.cbsa := choose(c,l.msa + '0',l.mail_msa + '0');
	self.geo_blk := choose(c,l.geo_blk,l.mail_geo_blk);
	self := L;
end;

pre_master_as_Header := normalize(Master_as_Source((prim_name != '' or mail_prim_name!='')and lname != ''),2,header_trans(LEFT,counter));

export master_as_header := 
	pre_master_as_Header(prim_name <> '', 
		lname <> '',
		length(trim(fname)) > 1,
		zip4 <> '');