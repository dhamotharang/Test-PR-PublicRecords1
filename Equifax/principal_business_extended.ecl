import ut, Business_Header;

// Combine principals (people) with business file to get a business name

busname := dedup(File_Business, cid, pid, all);

Layout_Principal_Extended InitPrincipal(Layout_Principal_Clean l) := transform
self.record_type := '1';
self := l;
end;

principal_init := project(principal_prep((first_name + middle_initial + last_name) <> ''), InitPrincipal(left));

Layout_Principal_Extended AddBusName(Layout_Principal_Extended l, Layout_Business r) := transform
self.business_name := r.business_name;
self := l;
end;

principal_busname := join(principal_init,
                          busname,
						  left.cid = right.cid and
						    left.pid = right.pid,
						  AddBusName(left, right),
						  left outer,
						  hash);

// Extract list of CID, PID for these principals, and look up BDIDs from the Business file
Layout_CID_PID := record
principal_busname.CID;
principal_busname.PID;
end;

prinbus_cid_pid := table(principal_busname, Layout_Cid_Pid);
prinbus_cid_pid_dedup := dedup(prinbus_cid_pid, all);

busprep_init := business_prep(bdid <> 0);

Layout_BDID_List := record
string18 cid;
string20 pid;
unsigned6 bdid;
end;

Layout_BDID_List SelectBDIDs(Layout_Business_Clean l, Layout_CID_PID r) := transform
self := l;
end;

bdid_list_init := join(busprep_init,
                       prinbus_cid_pid_dedup,
					   left.cid = right.cid and
					     left.pid = right.pid,
					   SelectBDIDs(left, right),
					   lookup);
					   
bdid_list_dedup := dedup(bdid_list_init, all);

// Extract DIDs from Principals
Layout_DID_List := record
string18 cid;
string20 pid;
unsigned6 did;
end;

Layout_DID_List SelectDIDs(Layout_Principal_Extended l) := transform
self := l;
end;

did_list_init := project(principal_busname(did <> 0), SelectDIDs(left));
					   
did_list_dedup := dedup(did_list_init, all);

// Match Principals by DID to Business Header to extract additional businesses
bh_contacts_init := Business_Header.File_Business_Contacts(from_hdr = 'N', did <> 0);

Layout_Principal_Extended SelectBusinessContacts(Business_Header.Layout_Business_Contact_Full l, Layout_DID_List r) := transform
self.record_type := '2'; // '2' - Seisint
self.rid := 0;
self.did := l.did;
self.bdid := l.bdid;
self.cid := r.cid;
self.pid := r.pid;
// Blank Equifax fields
self.ssn_taxid := '';
self.ssn_type := '';
self.first_name := '';
self.middle_initial := '';
self.last_name := '';
self.business_name := '';
self.delivery_line := '';
self.city := '';
self.state := '';
self.zip_code := '';
//
self.name_score := '';
self.p_city_name := l.city;
self.v_city_name := l.city;
self.st := l.state;
self.zip := (string5)intformat(l.zip, 5, 1);
self.zip4 := (string4)intformat(l.zip4, 4, 1);
self.cart := '';
self.cr_sort_sz := '';
self.lot := '';
self.lot_order := '';
self.dbpc := '';
self.chk_digit := '';
self.rec_type := '';
self.fips_state := ut.st2FipsCode(l.state);
self.fips_county := l.county;
self.geo_blk := '';
self.geo_match := '';
self.err_stat := '';
self.contact_phone := l.phone;
self.contact_email_address := l.email_address;
self.contact_ssn := l.ssn;
self := l;
end;

bh_contacts_select := join(bh_contacts_init,
                           did_list_dedup,
						   left.did = right.did,
						   SelectBusinessContacts(left, right),
						   lookup);

// Exclude BDIDs that match original Principals businesses (looking for new businesses only)
Layout_Principal_Extended SelectNewBusinesses(Layout_Principal_Extended l, Layout_BDID_List r) := transform
self := l;
end;

principal_business_new := join(bh_contacts_select,
                               bdid_list_dedup,
							   left.bdid = right.bdid,
							   SelectNewBusinesses(left, right),
							   left only,
							   lookup);
							   
principal_business_new_all := principal_busname + principal_business_new : persist('TEMP::equifax_principal_business_new_all');

// Rollup the CID, PID groups by contact name
prin_new_dist := distribute(principal_business_new_all(record_type='2'), hash(cid, pid));
prin_new_sort := sort(prin_new_dist, cid, pid, bdid, local);
prin_new_grp := group(prin_new_sort, cid, pid, bdid, local);
prin_new_grp_sort := sort(prin_new_grp, lname, datalib.PreferredFirst(fname), record_type, if(did <> 0, 0, 1), did, ut.TitleRank(company_title), mname);

Layout_Principal_Extended RollupPrincipals(Layout_Principal_Extended l, Layout_Principal_Extended r) := transform
self := l;
end;

prin_new_grp_rollup := group(rollup(prin_new_grp_sort,
                              (left.did <> 0 and right.did <> 0 and left.did = RIGHT.did)
							   OR
							  (
								ut.NNEQ(left.name_suffix, right.name_suffix) and
								ut.NameMatch(left.fname, left.mname, left.lname,
								right.fname, right.mname, right.lname) < 2
							  ),
							  RollupPrincipals(left, right)));
							  
prin_new_combined := principal_business_new_all(record_type='1') + prin_new_grp_rollup;
							  
export principal_business_extended := prin_new_combined : persist('TEMP::equifax_principal_new');
