IMPORT ut, Business_Header;

//*************************************************************************
// Translate Banruptcy to Common Business Header Format
//*************************************************************************

bs := File_BK_Search(court_code <> '', case_number <> '');
bm := File_BK_Main(court_code <> '', case_number <> '');

layout_court_case_list := record
bs.court_code;
bs.case_number;
end;

court_case_list := table(bs(debtor_lname = '', debtor_company <> ''), layout_court_case_list);
court_case_list_dedup := dedup(court_case_list, court_code, case_number, all);

// Join business bankruptcy list to search file to get contacts
Layout_BK_Search_v8 SelectContacts(Layout_BK_Search_v8 l, layout_court_case_list r) := transform
self := l;
end;

bc_init := join(bs(debtor_lname <> '', debtor_company = ''),
                court_case_list_dedup,
				left.court_code = right.court_code and
				  left.case_number = right.case_number,
				SelectContacts(left, right),
				hash);

bc_dist := distribute(bc_init, hash(court_code, case_number));

// Join Contacts to Businesses to get Company Information
Business_Header.Layout_Business_Contact_Full  Translate_Bankruptcy_to_BCF(Business_Header.Layout_Business_Header l, Layout_BK_Search_v8 r) := transform
SELF.did := (unsigned6)r.debtor_did;
SELF.company_name := l.company_name;
SELF.company_source_group := l.source_group;
SELF.company_prim_range := l.prim_range;
SELF.company_predir := l.predir;
SELF.company_prim_name := l.prim_name;
SELF.company_addr_suffix := l.addr_suffix;
SELF.company_postdir := l.postdir;
SELF.company_unit_desig := l.unit_desig;
SELF.company_sec_range := l.sec_range;
SELF.company_city := l.city;
SELF.company_state := l.state;
SELF.company_zip := l.zip;
SELF.company_zip4 := l.zip4;
SELF.company_phone := l.phone;
SELF.company_fein := l.fein;
self.company_title := '';
SELF.vendor_id := (qstring34)(r.court_code + r.case_number + r.debtor_type);
SELF.title := '';
SELF.fname := r.debtor_fname;
SELF.mname := r.debtor_mname;
SELF.lname := r.debtor_lname;
SELF.name_suffix := r.debtor_name_suffix;
SELF.name_score := Business_Header.CleanName(r.debtor_fname, r.debtor_mname, r.debtor_lname, r.debtor_name_suffix)[142];
SELF.prim_range := r.prim_range;
SELF.predir := r.predir;
SELF.prim_name := r.prim_name;
SELF.addr_suffix := r.suffix;
SELF.postdir := r.postdir;
SELF.unit_desig := r.unit_desig;
SELF.sec_range := r.sec_range;
SELF.city := r.p_city_name;
SELF.state := r.st;
SELF.zip := (UNSIGNED3)r.z5;
SELF.zip4 := (UNSIGNED2)r.zip4;
SELF.county := r.county[3..5];
SELF.msa := r.msa;
SELF.geo_lat := r.geo_lat;
SELF.geo_long := r.geo_long;
SELF.source := 'B';
SELF.dt_first_seen := l.dt_first_seen;
SELF.dt_last_seen := l.dt_last_seen;
SELF.record_type := 'C';
SELF.phone := 0;
SELF.email_address := '';
SELF.ssn := (unsigned4)r.debtor_ssn;
SELF := L;
end;

Business_Bankruptcies_Dist := distribute(Bankrupt_As_Business_Header, hash((string5)vendor_id[1..5], (string7)(vendor_id[6..12])));

Bankruptcy_Contacts := join(Business_Bankruptcies_Dist,
                            bc_dist,
                            left.vendor_id[1..5] = right.court_code and
                              left.vendor_id[6..12] = right.case_number,
                            Translate_Bankruptcy_to_BCF(left, right),
                            local);

export Bankrupt_As_Business_Contact := Bankruptcy_Contacts((integer)name_score < 3, Business_Header.CheckPersonName(fname, mname, lname, name_suffix)) : persist('TEMP::Bankruptcy_Contacts_As_BC');