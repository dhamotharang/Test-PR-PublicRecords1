import domains, Address;

 unsigned1 region := address.Components.Country.US;

temp_layout_searchFileInternetDomain := RECORD
	 recordof (domains.layout_whois_base);
	 unsigned6 internetservices_id := 0;
	 unsigned1 zero:=0;
	 string1 blank:= '';
	 string46 compname := '';
END; 

temp_layout_searchFileInternetDomain xform(searchFileDomains l,
                                           unsigned1 C) := transform
 
	self.fname := if (c=1, l.Admin_fname, if (c=2, l.tech_fname, l.registrant_fname)), 
	self.mname := if (c=1, l.Admin_mname, if (c=2, l.tech_mname, l.registrant_mname)),
	self.lname := if (c=1, l.Admin_lname, if (c=2, l.tech_lname, l.registrant_lname)),
	self.prim_name := if (c=1, l.prim_name, if (c=2, l.tech_prim_name, l.registrant_prim_name)),
	self.prim_range := if (c=1, l.prim_range, if (c=2,  l.tech_prim_range, l.registrant_prim_range)),
	self.predir := if (c=1, l.predir, if (c=2, l.tech_predir, l.registrant_predir)),
	self.postdir := if (c=1, l.postdir, if (c=2, l.tech_postdir, l.registrant_postdir)),
	self.unit_desig := if (c=1, l.unit_desig, if (c=2, l.tech_unit_desig, l.registrant_unit_desig)),
	self.sec_range := if (c=1, l.sec_range, if (c=2, l.tech_sec_range, l.registrant_sec_range)),
	self.suffix := if (c=1, l.suffix, if (c=2, l.tech_suffix, l.registrant_suffix)),
	self.state := if (c=1, l.state, if (c=2, l.tech_state, l.registrant_state)),
	self.v_city_name := if (c=1, l.v_city_name, if (c=2, l.tech_v_city_name, l.registrant_v_city_name)),
	self.Zip := if (c=1, l.zip, if (c=2, l.tech_zip, l.registrant_zip)),
	self.Compname := if (c=1, Stringlib.StringToUpperCase(l.admin_name),Stringlib.StringToUpperCase(l.registrant_name)),
	self.internetservices_id := l.internetservices_id;
	self := l;
END;


 temp_file_whois_autokey := normalize(searchFileDomains, 3, xform(left, counter));
 
export file_whois_autokey := temp_file_whois_autokey;