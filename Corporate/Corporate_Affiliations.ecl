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
Corp_Contacts_Dist := distribute(File_Corp4_Contacts_Base_DID(state_origin <> '', sos_ter_nbr<>''), hash(state_origin, trim(sos_ter_nbr)));
Corp_Companies_Dist := distribute(File_Corp4_Base(state_origin <> '', sos_ter_nbr<>''), hash(state_origin, trim(sos_ter_nbr)));

Layout_Corporate_Affiliation InitCorpAffiliations(Layout_Corp_Contacts_DID l, Layout_Corporate_Base r) := transform
self.charter_number := l.sos_ter_nbr;
self.corporation_name := r.abbrev_legal_name;
self.corporation_status := case(r.status,
						      'A' => 'ACTIVE',
							  'I' => 'INACTIVE',
							  'U' => 'UNKNOWN',
							  'F' => 'FORFEITED',
							  'D' => 'DISSOLVED',
							  'R' => 'REVOKED',
							  'T' => 'TERMINATED',
							  '');
self.filing_date := map(r.rcnt_filing <> '' => r.rcnt_filing,
                        r.date_orig_filing <> '' => r.date_orig_filing,
						r.date_incorp);
self.contact_name := l.officer_name;
self.affiliation := if(l.officer_title = 'HA', 'REGISTERED AGENT',
                                               getCorpTitle((unsigned1)l.officer_title));
self.address_type := case(r.orig_address_ind,
                                          'A' => 'AGENT ADDRESS',
										  'B' => 'BUSINESS OFFICE',
										  'C' => 'CORPORATE ADDRESS',
										  'E' => 'BUSINESS ENTITY',
										  'F' => 'FOREIGN ADDRESS',
										  'H' => 'HOME ADDRESS',
										  'M' => 'MAILING ADDRESS',
										  'P' => 'PARENT ADDRESS',
										  'O' => 'OWNER ADDRESS',
										  'R' => 'REGISTERED AGENT ADDRESS',
										  'CORPORATE ADDRESS');
self.prim_range := r.prim_range;
self.predir := r.predir;
self.prim_name := r.prim_name;
self.suffix := r.addr_suffix;
self.postdir := r.postdir;
self.unit_desig := r.unit_desig;
self.sec_range := r.sec_range;
self.city_name := r.p_city_name;
self.st := r.state;
self.zip := r.zip5;
self.zip4 := r.zip4;
self := l;
end;

/*
Corp_Affiliations_Init := JOIN(Corp_Contacts_Dist,
                               Corp_Companies_Dist,
                               left.state_origin = right.state_origin and
                               left.sos_ter_nbr = right.sos_ter_nbr and
                               ValidDateRange((unsigned4)left.dt_first_seen, (unsigned4)left.dt_last_seen,
					                          (unsigned4)right.dt_first_seen, (unsigned4)right.dt_last_seen),
                               InitCorpAffiliations(left, right),
                               local);
*/
Corp_Affiliations_Init := JOIN(Corp_Contacts_Dist,
                               Corp_Companies_Dist,
                               left.state_origin = right.state_origin and
                               left.sos_ter_nbr = right.sos_ter_nbr,
                               InitCorpAffiliations(left, right),
                               local);
							   
Corp_Affiliations_Sort := sort(Corp_Affiliations_Init, state_origin, charter_number, lname, NID.PreferredFirstVersionedStr(fname, NID.version), corporation_name, zip, prim_name, prim_range, if(affiliation <> '', 0, 1), ut.TitleRank(affiliation),  -filing_date, local);
Corp_Affiliations_Dedup := dedup(Corp_Affiliations_Sort, state_origin, charter_number, lname, NID.PreferredFirstVersionedStr(fname, NID.version), corporation_name, zip, prim_name, prim_range, local);

export Corporate_Affiliations := Corp_Affiliations_Dedup : persist('TEMP::Corporate_Affiliations');