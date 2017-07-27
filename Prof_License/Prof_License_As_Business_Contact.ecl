import Business_Header, ut;

f := File_Prof_License(business_flag = 'Y', company_name <> '', lname <> '');

Business_Header.Layout_Business_Contact_Full Translate_Proflic_To_BCF(Layout_proLic_in l) := transform
self.source := 'PL';          // Source file type
self.vendor_id := if(l.source_st<> '', l.source_st, l.st) + if(l.license_number <> '', l.license_number, l.orig_license_number);
self.dt_first_seen := (unsigned4)map(l.date_first_seen <> '' => l.date_first_seen,
                          l.issue_date <> '' => l.issue_date,
						  l.last_renewal_date <> '' => l.last_renewal_date,
						  version);
self.dt_last_seen := (unsigned4)map(l.date_last_seen <> '' => l.date_last_seen,
						  l.last_renewal_date <> '' => l.last_renewal_date,
                          l.issue_date <> '' => l.issue_date,
						  version);
self.name_score := Business_Header.CleanName(l.fname, l.mname, l.lname, l.name_suffix)[142],
self.city := l.p_city_name;
self.state := l.st;
self.zip := (unsigned3)l.zip;
self.zip4 := (unsigned2)l.zip4;
self.phone := (unsigned6)l.phone;
self.email_address := '';
self.company_title := l.profession_or_board;
self.company_source_group := '';
self.company_name := Stringlib.StringToUpperCase(l.company_name);
self.company_prim_range := l.prim_range;
self.company_predir := l.predir;
self.company_prim_name := l.prim_name;
self.company_addr_suffix := l.suffix;
self.company_postdir := l.postdir;
self.company_unit_desig := l.unit_desig;
self.company_sec_range := l.sec_range;
self.company_city := l.p_city_name;
self.company_state := l.st;
self.company_zip := (unsigned3)l.zip;
self.company_zip4 := (unsigned2)l.zip4;
self.company_phone := (unsigned6)l.phone;
self.record_type := 'C';          // Current/Historical indicator
self.addr_suffix := l.suffix;
self := l;
end;

Proflic_Contacts := project(f, Translate_Proflic_To_BCF(left));

export Prof_License_As_Business_Contact := Proflic_Contacts((INTEGER)name_score < 3, Business_Header.CheckPersonName(fname, mname, lname, name_suffix))
	: persist('TEMP::Prof_License_As_BC');