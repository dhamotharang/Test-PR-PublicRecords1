import ut, Business_Header, NID;

// Add businesses to records with DID
nh_prin := Equifax.nohit_test_bdid_by_contact(did <> 0);

Layout_NoHit_Test_Prin_Append InitPrin(Equifax.Layout_NoHit_Test_Base l) := transform
self.record_type := '1';  // Indicate record from Equifax
qstring35 company_title := '';
qstring35 company_department := '';
qstring120 company_name := '';
qstring10 company_prim_range := '';
string2   company_predir := '';
qstring28 company_prim_name := '';
qstring4  company_addr_suffix := '';
string2   company_postdir := '';
qstring5  company_unit_desig := '';
qstring8  company_sec_range := '';
qstring25 company_city := '';
string2   company_state := '';
unsigned3 company_zip := 0;
unsigned2 company_zip4 := 0;
unsigned6 company_phone := 0;
unsigned4 company_fein := 0;
unsigned6 contact_phone := 0;
string60  contact_email_address := '';
unsigned4 contact_ssn := 0;
self := l;
end;

nh_prin_init := project(nh_prin, InitPrin(left));

// Extract BDIDs
Layout_BDID_List := record
nh_prin_init.bdid;
end;

bdid_list := table(nh_prin_init, Layout_BDID_List);
bdid_list_dedup := dedup(bdid_list, bdid, all);


// Extract DIDs
Layout_DID_List := record
nh_prin_init.seq;
nh_prin_init.did;
end;

did_list := table(nh_prin_init, Layout_DID_List);

// Extract business contacts from Business Header
bh_contacts_init := Business_Header.File_Business_Contacts(from_hdr = 'N', did <> 0);

Layout_NoHit_Test_Prin_Append SelectBusinessContacts(Business_Header.Layout_Business_Contact_Full l, Layout_DID_List r) := transform
self.record_type := '2'; // '2' - Seisint
self.seq := r.seq;
self.bdid := l.bdid;
self.bdid_score := 0;
self.bdid_from_contact := 'Y';
self.did := r.did;
self.score := 0;
// Blank Equifax fields
self.INQR_BUS := '';
self.INQR_TAX := '';
self.INQR_STREET := '';
self.INQR_CITY := '';
self.INQR_STATE := '';
self.INQR_ZIP := '';
self.INQR_TEL := '';
self.INQR_PRIN_BUS := '';
self.INQR_PRIN_TAX := '';
self.INQR_PRIN_STREET := '';
self.INQR_PRIN_CITY := '';
self.INQR_PRIN_STATE := '';
self.INQR_PRIN_ZIP := '';
self.INQR_PRIN_NAME := '';
self.lf := '';
//
self.name_score := '';
self.prin_prim_range := l.prim_range;
self.prin_predir := l.predir;
self.prin_prim_name := l.prim_name;
self.prin_addr_suffix := l.addr_suffix;
self.prin_postdir := l.postdir;
self.prin_unit_desig := l.unit_desig;
self.prin_sec_range := l.sec_range;
self.prin_p_city_name := l.city;
self.prin_v_city_name := l.city;
self.prin_st := l.state;
self.prin_zip := (string5)intformat(l.zip, 5, 1);
self.prin_zip4 := (string4)intformat(l.zip4, 4, 1);
self.prin_cart := '';
self.prin_cr_sort_sz := '';
self.prin_lot := '';
self.prin_lot_order := '';
self.prin_dbpc := '';
self.prin_chk_digit := '';
self.prin_rec_type := '';
self.prin_fips_state := ut.st2FipsCode(l.state);
self.prin_fips_county := l.county;
self.prin_geo_lat := l.geo_lat;
self.prin_geo_long := l.geo_long;
self.prin_msa := l.msa;
self.prin_geo_blk := '';
self.prin_geo_match := '';
self.prin_err_stat := '';
self.contact_phone := l.phone;
self.contact_email_address := l.email_address;
self.contact_ssn := l.ssn;
self := l;
end;

bh_contacts_select := join(bh_contacts_init,
                           did_list,
						   left.did = right.did,
						   SelectBusinessContacts(left, right),
						   hash);

// Exclude BDIDs that match original Principals businesses (looking for new businesses only)
Layout_NoHit_Test_Prin_Append SelectNewBusinesses(Layout_NoHit_Test_Prin_Append l, Layout_BDID_List r) := transform
self := l;
end;

nh_prin_bus_new := join(bh_contacts_select,
                        bdid_list_dedup,
						left.bdid = right.bdid,
						SelectNewBusinesses(left, right),
						left only,
						lookup);
							   
nh_prin_bus_new_all := nh_prin_init + nh_prin_bus_new;

						   
nh_prin_bus_all := nh_prin_init + bh_contacts_select;

// Rollup the CID, PID groups by contact name
prin_bus_append_dist := distribute(nh_prin_bus_all, hash(seq));
prin_bus_append_sort := sort(prin_bus_append_dist, seq, local);
prin_bus_append_grp := group(prin_bus_append_sort, seq, local);
prin_bus_append_grp_sort := sort(prin_bus_append_grp, lname, NID.PreferredFirstVersionedStr(fname, NID.version), record_type, if(did <> 0, 0, 1), did, ut.TitleRank(company_title), mname);

Layout_NoHit_Test_Prin_Append RollupPrincipals(Layout_NoHit_Test_Prin_Append l, Layout_NoHit_Test_Prin_Append r) := transform
self := l;
end;

prin_bus_append_grp_rollup := group(rollup(prin_bus_append_grp_sort,
							    right.record_type <> '1' and
                                ((left.did <> 0 and right.did <> 0 and left.did = RIGHT.did)
							     OR
							     (
								  ut.NNEQ(left.name_suffix, right.name_suffix) and
								  ut.NameMatch(left.fname, left.mname, left.lname,
								  right.fname, right.mname, right.lname) < 2
							      )),
							  RollupPrincipals(left, right)));

export nohit_test_prin_bus_append := prin_bus_append_grp_rollup  : persist('TMTEST::equifax_nohit_principal_business_append');