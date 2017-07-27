import ut, NID;

// Determine if contact date range overlaps company date range
BOOLEAN ValidDateRange(UNSIGNED4 contact_dt_first_seen,
                       UNSIGNED4 contact_dt_last_seen,
                       UNSIGNED4 company_dt_first_seen,
                       UNSIGNED4 company_dt_last_seen) :=
    (contact_dt_first_seen >= company_dt_first_seen AND
        contact_dt_first_seen <= company_dt_last_seen) OR
    (contact_dt_last_seen >= company_dt_first_seen AND
        contact_dt_last_seen <= company_dt_last_seen) OR
    (company_dt_first_seen >= contact_dt_first_seen AND
        company_dt_last_seen <= contact_dt_last_seen);

// Join Corporations and Corresponding Contacts
Corp_Contacts_Dist := distribute(Corp_Cont_Out(corp_key <> ''), hash(corp_key));
Corp_Companies_Dist := distribute(Corp_Out(corp_key <> ''), hash(corp_key));

Layout_Corporate_Affiliation InitCorpAffiliations(Layout_Corp_Cont_Out l, Layout_Corp_Out r) := transform
self.did := (unsigned6)l.did;
self.bdid := (unsigned6)l.bdid;
self.state_origin := l.corp_state_origin;
self.charter_number := l.corp_sos_charter_nbr;
self.corporation_name := r.corp_legal_name;
self.corporation_status := r.corp_status_desc;
self.filing_date := map(r.corp_status_date <> '' => r.corp_status_date,
                        r.corp_filing_date <> '' => r.corp_filing_date,
						r.corp_inc_date);
self.contact_name := l.cont_name;
self.affiliation := l.cont_type_desc;
self.title := l.cont_title;
self.fname := l.cont_fname;
self.mname := l.cont_mname;
self.lname := l.cont_lname;
self.name_suffix := l.cont_name_suffix;
self.address_type := r.corp_address1_type_desc;
self.prim_range := r.corp_addr1_prim_range;
self.predir := r.corp_addr1_predir;
self.prim_name := r.corp_addr1_prim_name;
self.suffix := r.corp_addr1_addr_suffix;
self.postdir := r.corp_addr1_postdir;
self.unit_desig := r.corp_addr1_unit_desig;
self.sec_range := r.corp_addr1_sec_range;
self.city_name := r.corp_addr1_p_city_name;
self.st := r.corp_addr1_state;
self.zip := r.corp_addr1_zip5;
self.zip4 := r.corp_addr1_zip4;
end;

/*
Corp_Affiliations_Init := JOIN(Corp_Contacts_Dist,
                               Corp_Companies_Dist,
                               left.corp_key = right.corp_key,
                               ValidDateRange((unsigned4)left.dt_first_seen, (unsigned4)left.dt_last_seen,
					                          (unsigned4)right.dt_first_seen, (unsigned4)right.dt_last_seen),
                               InitCorpAffiliations(left, right),
                               local);
*/
Corp_Affiliations_Init := JOIN(Corp_Contacts_Dist,
                               Corp_Companies_Dist,
                               left.corp_key = right.corp_key,
                               InitCorpAffiliations(left, right),
                               local);
							   
Corp_Affiliations_Sort := sort(Corp_Affiliations_Init, state_origin, charter_number, lname, NID.PreferredFirstVersionedStr(fname, NID.version), corporation_name, zip, prim_name, prim_range, if(affiliation <> '', 0, 1), ut.TitleRank(affiliation),  -filing_date, if (did != 0, did,(unsigned6)-1), local);
Corp_Affiliations_Dedup := dedup(Corp_Affiliations_Sort, state_origin, charter_number, lname, NID.PreferredFirstVersionedStr(fname, NID.version), corporation_name, zip, prim_name, prim_range, local);

export Corporate_Affiliations := Corp_Affiliations_Dedup : persist('TEMP::Corporate_Affiliations');