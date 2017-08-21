//#workunit('name', 'D&B Contacts Out Creation ' + DNB.version);
import ut;

// Format D&B Contacts for Output
DNB.Layout_DNB_Contacts_Out FormatDNBContactsOutput(DNB.Layout_DNB_Contacts_Base L) := transform
self.bdid := if(L.bdid <> 0, intformat(L.bdid, 12, 1), '');
self.did := if(L.did <> 0, intformat(L.did, 12, 1), '');
self := L;
end;

DNB_Contacts_Out_Init := project(DNB.File_DNB_Contacts_Base(company_name <> ''), FormatDNBContactsOutput(left));

// Rollup the Contacts based on designated fields
DNB_Contacts_Out_Dist := distribute(DNB_Contacts_Out_Init, hash(duns_number, bdid, did));
DNB_Contacts_Out_Sort := sort(DNB_Contacts_Out_Dist, duns_number, bdid, did, local);
DNB_Contacts_Out_Grp := group(DNB_Contacts_Out_Sort, duns_number, bdid, did, local);
DNB_Contacts_Out_Grp_Sort := sort(DNB_Contacts_Out_Grp, company_name,
                                  -exec_last_name, -exec_first_name, -exec_middle_initial,
                                  -exec_suffix, /* -exec_title_code,*/ -exec_vanity_title /*, -exec_title */);

DNB.Layout_DNB_Contacts_Out RollupContacts(DNB.Layout_DNB_Contacts_Out l, DNB.Layout_DNB_Contacts_Out r) := transform
self.date_first_seen := map(l.date_first_seen = ''
                           or (l.date_first_seen <> '' and r.date_first_seen <> '' and r.date_first_seen < l.date_first_seen) => r.date_first_seen,
                          l.date_first_seen);
self.date_last_seen := map(l.date_last_seen = ''
                           or (l.date_last_seen <> '' and r.date_last_seen <> '' and r.date_last_seen > l.date_last_seen) => r.date_last_seen,
                          l.date_last_seen);
self.record_type := if(l.record_type = 'C', l.record_type, r.record_type);
self := l;
end;

DNB_Contacts_Out_Grp_Rollup := GROUP(ROLLUP(DNB_Contacts_Out_Grp_Sort,
                                       (left.exec_last_name = right.exec_last_name or right.exec_last_name = '') and
                                       (left.exec_first_name = right.exec_first_name or right.exec_first_name = '') and
                                       (left.exec_middle_initial = right.exec_middle_initial or right.exec_middle_initial = '') and
                                       (left.exec_suffix = right.exec_suffix or right.exec_suffix = '') and
//                                       (left.exec_title_code = right.exec_title_code or right.exec_title_code = '') and
                                       (left.exec_vanity_title = right.exec_vanity_title or right.exec_vanity_title = ''), /* and
                                       (left.exec_title = right.exec_title or right.exec_title = ''), */
                                       RollupContacts(left, right)));

//output(DNB_Contacts_Out_Grp_Rollup,,'OUT::DNB_Contacts_' + DNB.version, overwrite);
ut.MAC_SF_BuildProcess(DNB_Contacts_Out_Grp_Rollup,'~thor_data400::out::dnb_contacts',do1,2);
export Make_DNB_Contacts_Out := do1;
