dnb_contacts_update := DNB.File_DNB_Contacts_Update(lname <> '', (integer)name_score >= 85, delete_record_indicator = '');

// Format update
DNB.Layout_DNB_Contacts_Base FormatUpdate(DNB.Layout_DNB_Names_In l) := transform
self.company_name := l.business_name;
self := l;
end;

dnb_contacts_update_init := project(dnb_contacts_update, FormatUpdate(left));

// Append current base and update
dnb_contacts_append := DNB.File_DNB_Contacts_Base + dnb_contacts_update_init;

// Determine if contact date range overlaps company date range
BOOLEAN ValidDateRange(STRING8 contact_dt_first_seen,
                       STRING8 contact_dt_last_seen,
                       STRING8 company_dt_first_seen,
                       STRING8 company_dt_last_seen) :=
    (contact_dt_first_seen >= company_dt_first_seen AND
        contact_dt_first_seen <= company_dt_last_seen) OR
    (contact_dt_last_seen >= company_dt_first_seen AND
        contact_dt_last_seen <= company_dt_last_seen) OR
    (company_dt_first_seen >= contact_dt_first_seen AND
        company_dt_last_seen <= contact_dt_last_seen);

// Rollup contacts
dnb_contacts_dist := distribute(dnb_contacts_append, hash(duns_number));

DNB.Layout_DNB_Contacts_Base RollupContacts(DNB.Layout_DNB_Contacts_Base l, DNB.Layout_DNB_Contacts_Base r) := transform
self.date_first_seen := map(l.date_first_seen = ''
                           or (l.date_first_seen <> '' and r.date_first_seen <> '' and r.date_first_seen < l.date_first_seen) => r.date_first_seen,
                          l.date_first_seen);
self.date_last_seen := map(l.date_last_seen = ''
                           or (l.date_last_seen <> '' and r.date_last_seen <> '' AND r.date_last_seen > l.date_last_seen) => r.date_last_seen,
                          l.date_last_seen);
self := l;
end;


dnb_contacts_sort := sort(dnb_contacts_dist, duns_number,
company_name,
exec_first_name,
exec_middle_initial,
exec_last_name,
exec_suffix,
exec_title_code,
exec_title,
exec_vanity_title,
title,
local);

dnb_contacts_rollup := rollup(dnb_contacts_sort,
left.duns_number = right.duns_number and
left.company_name = right.company_name and
left.exec_first_name = right.exec_first_name and
left.exec_middle_initial = right.exec_middle_initial and
left.exec_last_name = right.exec_last_name and
left.exec_suffix = right.exec_suffix and
left.exec_title_code = right.exec_title_code and
left.exec_title = right.exec_title and
left.exec_vanity_title = right.exec_vanity_title and
left.title = right.title,
RollupContacts(left, right),
local);


// Join DNB COntacts to Companies to add company information
dnb_companies := DNB.DNB_Updated_Companies;
dnb_companies_dist := distribute(dnb_companies, hash(duns_number));

DNB.Layout_DNB_Contacts_Base AddCompanyInfo(DNB.Layout_DNB_Contacts_Base l, DNB.Layout_DNB_Base r) := transform
self.did := 0;
self.bdid := r.bdid;
self.company_name := if(r.trade_style = '' or (r.trade_style <> '' and r.parent_duns_number = '' and r.ultimate_duns_number = ''),
                                r.business_name,
                                r.trade_style);
self.company_prim_range := r.prim_range;
self.company_predir := r.predir;
self.company_prim_name := r.prim_name;
self.company_addr_suffix := r.addr_suffix;
self.company_postdir := r.postdir;
self.company_unit_desig := r.unit_desig;
self.company_sec_range := r.sec_range;
self.company_p_city_name := r.p_city_name;
self.company_v_city_name := r.v_city_name;
self.company_st := r.st;
self.company_zip := r.zip;
self.company_zip4 := r.zip4;
self.company_county := r.county;
self.company_geo_lat := r.geo_lat;
self.company_geo_long := r.geo_long;
self.company_msa := r.msa;
self.company_phone10 := r.telephone_number;
self.record_type := r.record_type;
self.active_duns_number := r.active_duns_number;
self := l;
end;

dnb_contacts_init := join(dnb_contacts_rollup,
                          dnb_companies_dist,
                          left.duns_number = right.duns_number and
                          left.company_name = right.business_name and
                            ValidDateRange(left.date_first_seen,
                                           left.date_last_seen,
                                           right.date_first_seen,
                                           right.date_last_seen),
                          AddCompanyInfo(left,right),
                          left outer,
                          local);

// dedup contacts
dnb_contacts_init_sort := sort(dnb_contacts_init,
did,
bdid,
date_first_seen,
date_last_seen,
duns_number,
exec_first_name,
exec_middle_initial,
exec_last_name,
exec_suffix,
exec_title_code,
exec_title,
exec_vanity_title,
title,
fname,
mname,
lname,
name_suffix,
name_score,
company_name,
company_prim_range,
company_predir,
company_prim_name,
company_addr_suffix,
company_postdir,
company_unit_desig,
company_sec_range,
company_p_city_name,
company_v_city_name,
company_st,
company_zip,
company_zip4,
company_county,
company_geo_lat,
company_geo_long,
company_msa,
company_phone10,
active_duns_number,
record_type, local);

// dedup by all fields except record_type
dnb_contacts_init_dedup := dedup(dnb_contacts_init_sort,
did,
bdid,
date_first_seen,
date_last_seen,
duns_number,
exec_first_name,
exec_middle_initial,
exec_last_name,
exec_suffix,
exec_title_code,
exec_title,
exec_vanity_title,
title,
fname,
mname,
lname,
name_suffix,
name_score,
company_name,
company_prim_range,
company_predir,
company_prim_name,
company_addr_suffix,
company_postdir,
company_unit_desig,
company_sec_range,
company_p_city_name,
company_v_city_name,
company_st,
company_zip,
company_zip4,
company_county,
company_geo_lat,
company_geo_long,
company_msa,
active_duns_number, local);

export DNB_Updated_Contacts := dnb_contacts_init_dedup : persist('TEMP::DNB_Updated_Contacts');