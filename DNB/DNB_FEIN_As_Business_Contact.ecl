IMPORT Business_Header, ut;

//*************************************************************************
// Translate Contact from DNB to Business Contact Format
//*************************************************************************

dnb_fein_contacts := dnb.File_DNB_FEIN_In(DB_CHIEF_EXECUTIVE_TITLE <> '', zip <> '');

Business_Header.Layout_Business_Contact_Full Translate_DNB_to_BCF(Layout_DNB_FEIN_In l, unsigned1 ntyp) := TRANSFORM
self.company_title := stringlib.stringtouppercase(L.cleaned_contact_title); 
self.vendor_id := L.CASE_DUNS_NUMBER;
self.source := 'D';
self.name_score := Business_Header.CleanName(l.fname,l.mname,l.lname, l.name_suffix)[142];
self.city := l.p_city_name;
self.state := l.st;
self.zip := (unsigned3)l.zip;
self.zip4 := (unsigned2)l.zip4;
self.county := l.county[3..5];
SELF.company_name := CHOOSE(ntyp, stringlib.stringtouppercase(L.BUSINESS_NAME), 
	stringlib.stringtouppercase(L.DB_COMPANY_NAME), stringlib.stringtouppercase(L.DB_TRADESTYLE));
self.company_source_group := L.CASE_DUNS_NUMBER;
self.company_prim_range := l.prim_range;
self.company_predir := l.predir;
self.company_prim_name := l.prim_name;
self.company_addr_suffix := l.addr_suffix;
self.company_postdir := l.postdir;
self.company_unit_desig := l.unit_desig;
self.company_sec_range := l.sec_range;
self.company_city := l.p_city_name;
self.company_state := l.st;
self.company_zip := (unsigned3)l.zip;
self.company_zip4 := (unsigned2)l.zip4;
self.company_phone := (unsigned6)((unsigned8)L.DB_TELEPHONE_NUMBER);
self.company_fein := if(Business_header.ValidFEIN((UNSIGNED4)L.TAX_ID_NUMBER), (UNSIGNED4)L.TAX_ID_NUMBER, 0);
self.phone := (unsigned6)((unsigned8)L.DB_TELEPHONE_NUMBER);
self.email_address := '';
self.dt_first_seen := if(L.DATE_OF_INPUT_DATA <> '', (UNSIGNED4)L.DATE_OF_INPUT_DATA, (UNSIGNED4)L.process_date);
self.dt_last_seen := if(L.DATE_OF_INPUT_DATA <> '', (UNSIGNED4)L.DATE_OF_INPUT_DATA, (UNSIGNED4)L.process_date);
self.record_type := 'C';
self := l;
end;

//--------------------------------------------
// Normalize names
//--------------------------------------------

dnb_bus_names  := project(dnb_fein_contacts(BUSINESS_NAME <> ''), Translate_DNB_To_BCF(LEFT, 1));
dnb_comp_names := project(dnb_fein_contacts(DB_COMPANY_NAME <> ''), Translate_DNB_To_BCF(LEFT, 2));
dnb_trad_names := project(dnb_fein_contacts(DB_TRADESTYLE <> ''), Translate_DNB_To_BCF(LEFT, 3));

dnb_contacts_combined := dnb_bus_names + dnb_comp_names + dnb_trad_names;

// Group by company name and address and propagate duns numbers(vendor_id, and source_group)
dnb_contacts_combined_dist := distribute(dnb_contacts_combined, hash(ut.CleanCompany(company_name), company_zip, company_prim_name, company_prim_range));
dnb_contacts_combined_sort := sort(dnb_contacts_combined_dist, ut.CleanCompany(company_name), company_zip, company_prim_name, company_prim_range, local);
dnb_contacts_combined_grp := group(dnb_contacts_combined_sort, ut.CleanCompany(company_name), company_zip, company_prim_name, company_prim_range, local);
dnb_contacts_combined_grp_sort := sort(dnb_contacts_combined_grp, -company_source_group);

Business_Header.Layout_Business_Contact_Full PropagateDunsNumber(Business_Header.Layout_Business_Contact_Full l, Business_Header.Layout_Business_Contact_Full r) := transform
self.vendor_id := if(r.vendor_id <> '' and r.vendor_id <> '000000000' , r.vendor_id, l.vendor_id);
self.company_source_group := if(r.company_source_group <> '' and r.company_source_group <> '000000000' , r.company_source_group, l.company_source_group);
self := r;
end;

dnb_contacts_combined_grp_iter := group(iterate(dnb_contacts_combined_grp_sort, PropagateDunsNumber(left, right)));

// Join records with blank Duns Numbers to DNB_As_Business_Header
dnb_bh := DNB.DNB_As_Business_Header(vendor_id[1] <> 'D', zip <> 0, prim_name <> '');

layout_dnb_slim := record
string81 clean_company_name := ut.CleanCompany(dnb_bh.company_name);
dnb_bh.zip;
dnb_bh.prim_name;
dnb_bh.prim_range;
string9 duns_number := (string)dnb_bh.source_group;
end;

dnb_bh_slim := table(dnb_bh, layout_dnb_slim);
dnb_bh_slim_dedup := dedup(dnb_bh_slim, clean_company_name, zip, prim_name, prim_range, all);
dnb_bh_slim_dist := distribute(dnb_bh_slim_dedup, hash(clean_company_name, zip, prim_name, prim_range));

Business_Header.Layout_Business_Contact_Full AppendDunsNumber(Business_Header.Layout_Business_Contact_Full l, layout_dnb_slim r) := transform
self.vendor_id := r.duns_number;
self.company_source_group := r.duns_number;
self := l;
end;

dnb_contacts_combined_append := join(dnb_contacts_combined_grp_iter(company_source_group = '' or 
								company_source_group = '000000000'),
                            dnb_bh_slim_dist,
					   ut.CleanCompany(left.company_name) = right.clean_company_name and
					     left.zip = right.zip and
						left.prim_name = right.prim_name and
						left.prim_range = right.prim_range,
					   AppendDunsNumber(left, right),
					   left outer,
					   local);
					   
dnb_contacts_combined_all := (dnb_contacts_combined_grp_iter(company_source_group <> '' and 
		company_source_group <> '000000000') + dnb_contacts_combined_append)(vendor_id <> '' and company_source_group <> '000000000');

export DNB_FEIN_As_Business_Contact := dnb_contacts_combined_all((integer)name_score < 3, Business_Header.CheckPersonName(fname, mname, lname, name_suffix)) : persist('TEMP::DNB_FEIN_Contacts_As_BC');