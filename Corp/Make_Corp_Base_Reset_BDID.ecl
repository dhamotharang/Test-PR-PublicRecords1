import ut, Business_Header, Business_Header_SS, did_add;

#workunit('name', 'Corporate Base BDID Reset ' + corp.Corp_Build_Date);

// BDID Corporate records
corp_to_bdid := Corp.File_Corp_Base;

Business_Header.MAC_Source_Match(corp_to_bdid, corp_bdid_init,
                        FALSE, bdid,
                        FALSE, 'C',
                        TRUE, corp_key,
//                        FALSE, corp_key,
                        corp_legal_name,
                        corp_addr1_prim_range, corp_addr1_prim_name, corp_addr1_sec_range, corp_addr1_zip5,
                        TRUE, corp_phone10,
                        TRUE, corp_fed_tax_id,
						TRUE, corp_key);
//                        FALSE, corp_key);

// Then do a standard BDID match for the records which did not BDID,
// since the Corporate file may be newer than the Business Headers
BDID_Matchset := ['A'];

corp_bdid_match := corp_bdid_init(bdid <> 0);

corp_bdid_nomatch := corp_bdid_init(bdid = 0);

Business_Header_SS.MAC_Add_BDID_Flex(corp_bdid_nomatch,
                                  BDID_Matchset,
                                  corp_legal_name,
                                  corp_addr1_prim_range, corp_addr1_prim_name, corp_addr1_zip5,
                                  corp_addr1_sec_range, corp_addr1_state,
                                  corp_phone10, corp_fed_tax_id,
                                  bdid, Corp.Layout_Corp_Base,
                                  FALSE, BDID_score_field,
                                  corp_bdid_rematch)

corp_bdid_all := corp_bdid_match + corp_bdid_rematch;

							  
//output(corp_bdid_all,,'BASE::Corp_Base_' + Corp.Corp_Reset_Date, overwrite);
ut.mac_sf_buildprocess(corp_bdid_all,'~thor_data400::base::corp_base',do1,2);

// BDID Corporate Supplemental records
supp_to_bdid := Corp.File_Corp_Supp_Base;

Business_Header.MAC_Source_Match(supp_to_bdid, supp_bdid_init,
                        FALSE, bdid,
                        FALSE, 'C',
                        TRUE, corp_key,
//                        FALSE, corp_key,
                        corp_legal_name,
                        corp_addr1_prim_range, corp_addr1_prim_name, corp_addr1_sec_range, corp_addr1_zip5,
                        TRUE, corp_phone10,
                        FALSE, corp_fed_tax_id,
						TRUE, corp_key);
//                        FALSE, corp_key);

supp_bdid_match := supp_bdid_init(bdid <> 0);

supp_bdid_nomatch := supp_bdid_init(bdid = 0);

Business_Header_SS.MAC_Add_BDID_Flex(supp_bdid_nomatch,
                                  BDID_Matchset,
                                  corp_legal_name,
                                  corp_addr1_prim_range, corp_addr1_prim_name, corp_addr1_zip5,
                                  corp_addr1_sec_range, corp_addr1_state,
                                  corp_phone10, corp_fed_tax_id,
                                  bdid, Corp.Layout_Corp_Supp_Base,
                                  FALSE, BDID_score_field,
                                  supp_bdid_rematch)

supp_bdid_all := supp_bdid_match + supp_bdid_rematch;

//output(supp_bdid_all,,'BASE::Corp_Supp_Base_' + Corp.Corp_Reset_Date, overwrite);
ut.MAC_SF_BuildProcess(supp_bdid_all,'~thor_Data400::base::corp_supp_base',do2,2);

// BDID Corporate Contact records
cont_to_bdid := Corp.File_Corp_Cont_Base;

Business_Header.MAC_Source_Match(cont_to_bdid, cont_bdid_init,
                        FALSE, bdid,
                        FALSE, 'C',
                        TRUE, corp_key,
//                        FALSE, corp_key,
                        corp_legal_name,
                        corp_addr1_prim_range, corp_addr1_prim_name, corp_addr1_sec_range, corp_addr1_zip5,
                        TRUE, corp_phone10,
                        FALSE, corp_fed_tax_id,
						TRUE, corp_key);
//                        FALSE, corp_key);

cont_bdid_match := cont_bdid_init(bdid <> 0);

cont_bdid_nomatch := cont_bdid_init(bdid = 0);

Business_Header_SS.MAC_Add_BDID_Flex(cont_bdid_nomatch,
                                  BDID_Matchset,
                                  corp_legal_name,
                                  corp_addr1_prim_range, corp_addr1_prim_name, corp_addr1_zip5,
                                  corp_addr1_sec_range, corp_addr1_state,
                                  corp_phone10, corp_fed_tax_id,
                                  bdid, Corp.Layout_Corp_Cont_Base,
                                  FALSE, BDID_score_field,
                                  cont_bdid_rematch)

cont_bdid_all := cont_bdid_match + cont_bdid_rematch;

//output(cont_bdid_all,,'BASE::Corp_Cont_Base_' + Corp.Corp_Reset_Date, overwrite);
ut.mac_sf_buildprocess(cont_bdid_all,'~thor_Data400::base::corp_cont_base',do3,2);

// Join events to corp base to assign bdids
Layout_Corp_BDID_List := record
unsigned6 bdid;
string30  corp_key;
end;

Layout_Corp_BDID_List InitCorpBDID(Corp.Layout_Corp_Base l) := transform
self := l;
end;

Corp_Event_BDID_Init := project(corp_bdid_all, InitCorpBDID(left));
Corp_Event_BDID_Dedup := dedup(Corp_Event_BDID_Init, bdid, corp_key, all);
Corp_Event_BDID_Dedup_Dist := distribute(Corp_Event_BDID_Dedup, hash(corp_key));

Corp_Event_Dist := distribute(Corp.File_Corp_Event_Base, hash(corp_key));
Corp_Event_Dist_Sort := sort(Corp_Event_Dist, except bdid, local);
Corp_Event_Dist_Dedup := dedup(Corp_Event_Dist, except bdid, local);


// Join events to corp base to assign bdids
Corp.Layout_Corp_Event_Base AssignEventBDID(Corp.Layout_Corp_Event_Base l, Layout_Corp_BDID_List r) := transform
self.bdid := r.bdid;
self := l;
end;


Corp_Event_Base := join(Corp_Event_Dist_Dedup,
                        Corp_Event_BDID_Dedup_Dist,
						left.corp_key = right.corp_key,
						AssignEventBDID(left, right),
						left outer,
						local);
						
//output(Corp_Event_Base,,'BASE::Corp_Event_Base_'  + Corp.Corp_Reset_Date, overwrite);
ut.mac_sf_buildprocess(Corp_Event_Base,'~thor_data400::base::corp_event_base',do4,2)

sequential(do1,do2,do3,do4);
