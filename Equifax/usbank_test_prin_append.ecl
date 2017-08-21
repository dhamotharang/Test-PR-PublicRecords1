import ut, Business_Header, did_add, DidVille, header_slimsort, Watchdog, NID;

// Add principals to records with BDID and BDID_Score >= 33
usb_prin := Equifax.USBank_test_bdid_by_contact;

Layout_USBank_Test_Prin_Append InitPrin(Equifax.Layout_USBank_Test_Base l) := transform
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

usb_prin_init := project(usb_prin, InitPrin(left));

usb_prin_bdid := usb_prin_init(bdid <> 0, bdid_score >= 33);

// Extract BDIDs
Layout_BDID_List := record
usb_prin_init.seq;
usb_prin_init.bdid;
end;

bdid_list := table(usb_prin_bdid, Layout_BDID_List);

// Extract business contacts from Business Header
bh_contacts_init := Business_Header.File_Business_Contacts(from_hdr = 'N');

Layout_USBank_Test_Prin_Append SelectBusinessContacts(Business_Header.Layout_Business_Contact_Full l, Layout_BDID_List r) := transform
self.record_type := '2'; // '2' - Seisint
self.seq := r.seq;
self.bdid := r.bdid;
self.bdid_score := 0;
self.bdid_from_contact := 'N';
self.did := l.did;
self.score := 0;
// Blank USBank fields
self.ID := '';
self.Business_Name := '';
self.Address := '';
self.City := '';
self.State := '';
self.Zip := '';
self.Prin_Name := '';
self.Prin_Address := '';
self.Prin_City := '';
self.Prin_State := '';
self.Prin_Orig_Zip := '';
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
						   
usb_prin_all := usb_prin_bdid + bh_contacts_select;

// Rollup the CID, PID groups by contact name
prin_append_dist := distribute(usb_prin_all, hash(seq));
prin_append_sort := sort(prin_append_dist, seq, local);
prin_append_grp := group(prin_append_sort, seq, local);
prin_append_grp_sort := sort(prin_append_grp, lname, NID.PreferredFirstVersionedStr(fname, NID.version), record_type, if(did <> 0, 0, 1), did, ut.TitleRank(company_title), mname);

Layout_USBank_Test_Prin_Append RollupPrincipals(Layout_USBank_Test_Prin_Append l, Layout_USBank_Test_Prin_Append r) := transform
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
							  
prin_append_all := prin_append_grp_rollup + usb_prin_init(not(bdid <> 0 and bdid_score >= 33));

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
prin_append_best := project(prin_append_best_temp, transform(Equifax.Layout_USBank_Test_Prin_Append, self := left));

export USBank_test_prin_append := prin_append_best  : persist('TMTEST::equifax_USBank_principal_append');