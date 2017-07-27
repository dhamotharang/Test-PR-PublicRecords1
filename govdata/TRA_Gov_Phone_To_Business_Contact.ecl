IMPORT Business_Header, ut;

EXPORT 
	Business_Header.Layout_Business_Contact_Full 
	TRA_Gov_Phone_To_Business_Contact(Layout_Gov_Phones_Base l) := TRANSFORM
	SELF.source := 'ED';          // Source file type
	SELF.vendor_id := l.vendor + l.unique_id; // Synthetic id
	SELF.dt_first_seen := (UNSIGNED4) l.record_date;   // Date record first seen at Seisint
	SELF.dt_last_seen := (UNSIGNED4) l.record_date;    // Date record last (most recently seen) at Seisint
	SELF.county := l.fipscounty;
	SELF.city := l.p_city_name;
	SELF.state := l.st;
	SELF.zip := (unsigned3) l.zip;
	SELF.zip4 := (unsigned2) l.zip4;
	SELF.phone := l.phone;
	SELF.title := l.name_prefix;
	SELF.fname := l.name_first;
	SELF.mname := l.name_middle;
	SELF.lname := l.name_last;
	SELF.name_score := Business_Header.CleanName(SELF.fname, SELF.mname, SELF.lname, l.name_suffix)[142],
	SELF.email_address := l.email;
	SELF.company_title := l.job_title;
	SELF.company_department := stringlib.StringToUpperCase(l.department);
	SELF.company_source_group := ''; // Source group
     SELF.company_name := if(l.state_origin = '' or StringLib.StringFind(Stringlib.StringToUpperCase(l.agency), trim(ut.St2Name(l.state_origin)), 1) > 0, Stringlib.StringToUpperCase(l.agency),
	                        trim(ut.St2Name(l.state_origin)) + ' ' + Stringlib.StringToUpperCase(l.agency));
	SELF.company_prim_range := l.prim_range;
	SELF.company_predir := l.predir;
	SELF.company_prim_name := l.prim_name;
	SELF.company_addr_suffix := l.addr_suffix;
	SELF.company_postdir := l.postdir;
	SELF.company_unit_desig := l.unit_desig;
	SELF.company_sec_range := l.sec_range;
	SELF.company_city := l.p_city_name;
	SELF.company_state := l.st;
	SELF.company_zip := (unsigned3) l.zip;
	SELF.company_zip4 := (unsigned2) l.zip4;
	SELF.company_phone := l.phone;
	SELF.record_type := 'C';          // Current/Historical indicator
	SELF := l;
END;