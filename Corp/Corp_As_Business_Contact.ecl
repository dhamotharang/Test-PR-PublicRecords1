IMPORT Business_Header, ut;

//*************************************************************************
// Translate Contact from Corporate to Business Contact Format
//*************************************************************************

// Referential integrity - Contacts must have corresponding corporate record
corp_base := Corp.File_Corp_Base;

layout_corpkeys := record
corp_base.corp_key;
end;

corpkeys_list := table(corp_base, layout_corpkeys);
corpkeys_list_dedup := dedup(corpkeys_list, all);
corpkeys_list_dist := distribute(corpkeys_list_dedup, hash(corp_key));

cont_base := Corp.File_Corp_Cont_Base(cont_name not in Corp.Set_Bad_Contact_Names);
cont_base_dist := distribute(cont_base, hash(corp_key));

Corp.Layout_Corp_Cont_Base SelectContacts(Corp.Layout_Corp_Cont_Base l, corpkeys_list_dedup r) := transform
self := l;
end;

cont_base_select := join(cont_base_dist,
                         corpkeys_list_dist,
						 left.corp_key = right.corp_key,
						 SelectContacts(left, right),
						 local);

Business_Header.Layout_Business_Contact_Full Translate_Corp_To_BCF(Layout_Corp_Cont_Base l) := transform
self.source := 'C';
self.vendor_id := l.corp_key;
self.dt_first_seen := l.dt_first_seen;
self.dt_last_seen := l.dt_last_seen;
self.title := l.cont_title;
self.fname := l.cont_fname;
self.mname := l.cont_mname;
self.lname := l.cont_lname;
self.name_suffix := l.cont_name_suffix;
self.name_score := Business_Header.CleanName(l.cont_fname, l.cont_mname, l.cont_lname, l.cont_name_suffix)[142];
self.email_address := l.cont_email_address;
self.prim_range := l.cont_prim_range;
self.predir := l.cont_predir;
self.prim_name := l.cont_prim_name;
self.addr_suffix := l.cont_addr_suffix;
self.postdir := l.cont_postdir;
self.unit_desig := l.cont_unit_desig;
self.sec_range := l.cont_sec_range;
self.city := l.cont_p_city_name;
self.state := l.cont_state;
self.zip := (unsigned3)l.cont_zip5;
self.zip4 := (unsigned2)l.cont_zip4;
self.county := l.cont_county;
self.msa := l.cont_msa;
self.geo_lat := l.cont_geo_lat;
self.geo_long := l.cont_geo_long;
self.phone := (unsigned6)l.cont_phone10;
self.ssn := (unsigned4)l.cont_ssn;
self.company_title := Stringlib.StringToUpperCase(l.cont_title_desc);
self.company_name := Stringlib.StringToUpperCase(l.corp_legal_name);
self.company_source_group := l.corp_key;
self.company_prim_range := l.corp_addr1_prim_range;
self.company_predir := l.corp_addr1_predir;
self.company_prim_name := l.corp_addr1_prim_name;
self.company_addr_suffix := l.corp_addr1_addr_suffix;
self.company_postdir := l.corp_addr1_postdir;
self.company_unit_desig := l.corp_addr1_unit_desig;
self.company_sec_range := l.corp_addr1_sec_range;
self.company_city := l.corp_addr1_p_city_name;
self.company_state := l.corp_addr1_state;
self.company_zip := (unsigned3)l.corp_addr1_zip5;
self.company_zip4 := (unsigned2)l.corp_addr1_zip4;
self.company_phone := (unsigned6)l.corp_phone10;
self.record_type := l.record_type;
self := l;
end;

corp_contact_init := project(cont_base_select, Translate_Corp_To_BCF(left));

layout_corp_base_slim := record
corp_base.corp_key;
qstring120 company_name := Stringlib.StringToUpperCase(corp_base.corp_legal_name);
corp_base.dt_last_seen;
corp_base.corp_fed_tax_id;
end;

corp_base_slim := table(corp_base(corp_fed_tax_id <> ''), layout_corp_base_slim);
corp_base_slim_dist := distribute(corp_base_slim, hash(corp_key));
corp_base_slim_sort := sort(corp_base_slim_dist, corp_key, company_name, if(Business_Header.ValidFEIN((unsigned4)corp_fed_tax_id), 0, 1), -dt_last_seen, local);
corp_base_slim_dedup := dedup(corp_base_slim_sort, corp_key, company_name, local);

corp_contact_init_dist := distribute(corp_contact_init, hash((string30)vendor_id));

Business_Header.Layout_Business_Contact_Full AddFEINToContact(Business_Header.Layout_Business_Contact_Full l, layout_corp_base_slim r) := transform
self.company_fein := if(Business_Header.ValidFEIN((unsigned4)r.corp_fed_tax_id), (unsigned4)r.corp_fed_tax_id, 0);
self := l;
end;

corp_contact_init_fein := join(corp_contact_init_dist,
                               corp_base_slim_dedup,
							   (string30)left.vendor_id = right.corp_key and
							   left.company_name = right.company_name,
							   AddFEINToContact(left, right),
							   left outer,
							   local);

export Corp_As_Business_Contact := corp_contact_init_fein((INTEGER)name_score < 3, Business_Header.CheckPersonName(fname, mname, lname, name_suffix))
                 : persist('TEMP::Corp_Contacts_As_BC');