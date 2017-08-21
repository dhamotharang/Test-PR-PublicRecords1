IMPORT Business_Header, ut,mdr;

export fDNB_As_Business_Contact(dataset(Layout_DNB_Contacts_Base) pInput) :=
function

//*************************************************************************
// Translate Contact from DNB to Business Contact Format
//*************************************************************************

dnb_contacts := pInput;

Business_Header.Layout_Business_Contact_Full_New Translate_Busfile_to_BCF(Layout_DNB_Contacts_Base l) := TRANSFORM
self.vl_id 	 := L.duns_number;
self.company_title := stringlib.stringtouppercase(l.exec_vanity_title);
self.vendor_id := IF(L.active_duns_number = 'Y', L.duns_number, 'D' + L.duns_number + '-' + stringlib.stringtouppercase(L.company_name));
self.source := MDR.sourceTools.src_Dunn_Bradstreet;
self.name_score := Business_Header.CleanName(l.fname,l.mname,l.lname, l.name_suffix)[142];
self.prim_range := l.company_prim_range;
self.predir := l.company_predir;
self.prim_name := l.company_prim_name;
self.addr_suffix := l.company_addr_suffix;
self.postdir := l.company_postdir;
self.unit_desig := l.company_unit_desig;
self.sec_range := l.company_sec_range;
self.city := l.company_v_city_name;
self.state := l.company_st;
self.zip := (unsigned3)l.company_zip;
self.zip4 := (unsigned2)l.company_zip4;
self.county := l.company_county[3..5];
self.msa := l.company_msa;
self.geo_lat := l.company_geo_lat;
self.geo_long := l.company_geo_long;
self.company_name := l.company_name;
self.company_source_group := IF(L.active_duns_number = 'Y', L.duns_number, 'D' + L.duns_number + '-' + stringlib.stringtouppercase(L.company_name));
self.company_prim_range := l.company_prim_range;
self.company_predir := l.company_predir;
self.company_prim_name := l.company_prim_name;
self.company_addr_suffix := l.company_addr_suffix;
self.company_postdir := l.company_postdir;
self.company_unit_desig := l.company_unit_desig;
self.company_sec_range := l.company_sec_range;
self.company_city := l.company_v_city_name;
self.company_state := l.company_st;
self.company_zip := (unsigned3)l.company_zip;
self.company_zip4 := (unsigned2)l.company_zip4;
self.company_phone := (unsigned6)((unsigned8)l.company_phone10);
self.company_fein := 0;
self.phone := (unsigned6)((unsigned8)l.company_phone10);
self.email_address := '';
self.dt_first_seen := (unsigned4)l.date_first_seen;
self.dt_last_seen := (unsigned4)l.date_last_seen;
self.record_type := 'C';
self := l;
end;

dnb_contacts_init := project(dnb_contacts, Translate_Busfile_to_BCF(left));

return dnb_contacts_init((integer)name_score < 3, Business_Header.CheckPersonName(fname, mname, lname, name_suffix));

end;