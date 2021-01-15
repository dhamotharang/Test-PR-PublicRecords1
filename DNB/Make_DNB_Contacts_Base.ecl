import ut, did_add;

#workunit('name', 'D&B Contacts Base Creation ' + DNB.version);

// Determine if contact date range overlaps company date range
BOOLEAN ValidDateRange(STRING8 contact_dt_first_seen,
                       STRING8 contact_dt_last_seen,
                       STRING8 company_dt_first_seen,
                       STRING8 company_dt_last_seen) :=
    (contact_dt_first_seen >= company_dt_first_seen AND
        contact_dt_first_seen <= company_dt_last_seen) OR
    (contact_dt_last_seen >= company_dt_first_seen AND
        contact_dt_last_seen <= company_dt_last_seen);

// Join DNB COntacts to Companies to add company information
dnb_contacts := DNB.File_DNB_Names_In(lname <> '', (integer)name_score >= 85, delete_record_indicator = '');
dnb_companies := DNB.File_DNB_Base;

dnb_contacts_dist := distribute(dnb_contacts, hash(duns_number));
dnb_companies_dist := distribute(dnb_companies, hash(duns_number));

DNB.Layout_DNB_Contacts_Base AddCompanyInfo(DNB.Layout_DNB_Names_In l, DNB.Layout_DNB_Base r) := transform
self.bdid := r.bdid;
self.company_name := r.business_name;
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

dnb_contacts_init := join(dnb_contacts_dist,
                          dnb_companies_dist,
                          left.duns_number = right.duns_number and
                          left.business_name = right.business_name and
                            ValidDateRange(left.date_first_seen,
                                           left.date_last_seen,
                                           right.date_first_seen,
                                           right.date_last_seen),
                          AddCompanyInfo(left,right),
                          left outer,
                          local);

// Contacts in were already rolled up so we have to
// straighten out the record type in order to dedup properly
// We want to keep the 'C' current indicator
// This can be changed to use the new 'RECORD EXCEPT' syntax when
// available on the production system

// sort by all fields
dnb_contacts_sort := sort(dnb_contacts_init,
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
dnb_contacts_dedup := dedup(dnb_contacts_sort,
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

dnb_matchset := ['A','P'];

// did the contacts
did_add.MAC_Match_Flex(dnb_contacts_dedup, dnb_matchset,						//see above
	 ssn_field, dob_field, fname, mname,lname, name_suffix,
	 company_prim_range, company_prim_name, company_sec_range, company_zip, company_st, company_phone10, //year_of_residence_field, not ready for release yet
	 did,
	 DNB.Layout_DNB_Contacts_Base,
	 false, DID_Score_field,	//these should default to zero in definition
	 75,	//dids with a score below here will be dropped
	 dnb_contacts_did)

//output(dnb_contacts_did,,'BASE::DNB_Contacts_' + DNB.version,overwrite);
ut.MAC_SF_BuildProcess(dnb_contacts_did,'~thor_Data400::base::dnb_contacts',do1,2)
do1;
