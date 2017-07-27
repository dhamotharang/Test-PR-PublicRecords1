import ut, Business_Header, did_add, DidVille, header_slimsort, Watchdog;

// Add principals to records with BDID and BDID_Score >= 33
abn_amro_prin := abn_amro_test_prep;

Layout_ABN_AMRO_Test_Prin_Append InitPrin(Layout_ABN_AMRO_Test_Base l) := transform
self.record_type := '1';  // Indicate record from ABN AMRO
self.company_title := '';
self.company_department := '';
self.company_name := '';
self.company_prim_range := '';
self.company_predir := '';
self.company_prim_name := '';
self.company_addr_suffix := '';
self.company_postdir := '';
self.company_unit_desig := '';
self.company_sec_range := '';
self.company_city := '';
self.company_state := '';
self.company_zip := 0;
self.company_zip4 := 0;
self.company_phone := 0;
self.company_fein := 0;
self.contact_phone := 0;
self.contact_email_address := '';
self.contact_ssn := 0;
self.ZIP4_ORIG := l.ZIP4;
self := l;
end;

abn_amro_prin_init := project(abn_amro_prin, InitPrin(left));

abn_amro_prin_bdid := abn_amro_prin_init(bdid <> 0);

// Extract BDIDs
Layout_BDID_List := record
abn_amro_prin_init.seq;
abn_amro_prin_init.bdid;
end;

bdid_list := table(abn_amro_prin_bdid, Layout_BDID_List);

// Extract business contacts from Business Header
bh_contacts_init := Business_Header.File_Business_Contacts(from_hdr = 'N');

Layout_ABN_AMRO_Test_Prin_Append SelectBusinessContacts(Business_Header.Layout_Business_Contact_Full l, Layout_BDID_List r) := transform
self.record_type := '2'; // '2' - Seisint
self.seq := r.seq;
self.bdid := r.bdid;
self.bdid_score := 0;
self.bdid_from_contact := 'N';
self.did := l.did;
self.score := 0;
// Blank ABN_AMRO fields
self.PROSPECT_HOUSEHOLD_KEY := '';
self.COMPNAME := '';
self.STREET := '';
self.CITY := '';
self.STATE := '';
self.ZIP := '';
self.ZIP4_ORIG := '';
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
                           bdid_list,
						   left.bdid = right.bdid,
						   SelectBusinessContacts(left, right),
						   hash);
						   
abn_amro_prin_all := abn_amro_prin_bdid + bh_contacts_select;

// Rollup the groups by contact name
prin_append_dist := distribute(abn_amro_prin_all, hash(seq));
prin_append_sort := sort(prin_append_dist, seq, local);
prin_append_grp := group(prin_append_sort, seq, local);
prin_append_grp_sort := sort(prin_append_grp, lname, datalib.PreferredFirst(fname), record_type, if(did <> 0, 0, 1), did, ut.TitleRank(company_title), mname);

Layout_ABN_AMRO_Test_Prin_Append RollupPrincipals(Layout_ABN_AMRO_Test_Prin_Append l, Layout_ABN_AMRO_Test_Prin_Append r) := transform
self := l;
end;

prin_append_grp_rollup := group(rollup(prin_append_grp_sort,
							    right.record_type <> '1' and
                                ((left.did <> 0 and right.did <> 0 and left.did = RIGHT.did)
							     OR
							     (
								  ut.NNEQ(left.name_suffix, right.name_suffix) and
								  ut.NameMatch(left.fname, left.mname, left.lname,
								  right.fname, right.mname, right.lname) < 2
							      )),
							  RollupPrincipals(left, right)));
							  
prin_append_all := prin_append_grp_rollup + abn_amro_prin_init(bdid = 0);

layout_prin_append_temp := record
prin_append_all;
ssn := (string9)if(prin_append_all.contact_ssn <> 0, intformat(prin_append_all.contact_ssn, 9, 1), '');
dob := '';
phone10 := (string10)if(prin_append_all.contact_phone <> 0, intformat(prin_append_all.contact_phone, 10, 1), '');
prim_range := prin_append_all.prin_prim_range;
predir := prin_append_all.prin_predir;
prim_name := prin_append_all.prin_prim_name;
addr_suffix := prin_append_all.prin_addr_suffix;
postdir := prin_append_all.prin_postdir;
unit_desig := prin_append_all.prin_unit_desig;
sec_range := prin_append_all.prin_sec_range;
p_city_name := prin_append_all.prin_p_city_name;
st := prin_append_all.prin_st;
z5 := prin_append_all.prin_zip;
zip4 := prin_append_all.prin_zip4;
end;

prin_append_all_temp := table(prin_append_all, layout_prin_append_temp);

// Append Best Person Data
didville.MAC_BestAppend(prin_append_all_temp,'BEST_ALL','',0,true,prin_append_best_temp)

// Format output
prin_append_best := project(prin_append_best_temp, transform(Layout_ABN_AMRO_Test_Prin_Append, self := left));

export ABN_AMRO_test_prin_append := prin_append_best  : persist('TMTEST::ABN_AMRO_principal_append');
