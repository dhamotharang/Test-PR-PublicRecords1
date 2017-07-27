// Rollup the bdid relative matches


BH_Relative_Matches := BH_Relative_Match_ID +
                       BH_Relative_Match_FBN +
                       BH_Relative_Match_FEIN +
                       BH_Relative_Match_Gong +
                       BH_Relative_Match_NameAddr +
                       BH_Relative_Match_Name_Phone +
                       BH_Relative_Match_Phone +
                       BH_Relative_Match_UCC +
                       BH_Relative_Match_Name +
                       BH_Relative_Match_Addr +
                       BH_Relative_Match_Mail_Addr +
				   BH_Relative_Match_DUNS_Tree +
				   BH_Relative_Match_DCA_Hierarchy /*+
				   BH_Relative_Match_ABI_Hierarchy*/;/*+
											 BH_Relative_Match_Shared_Contacts*/;

/*
BH_Relative_Matches := dataset('TMTEMP::BH_Relative_Match_ID',Layout_Relative_Match, flat) +
                       dataset('TMTEMP::BH_Relative_Match_FBN',Layout_Relative_Match, flat) +
                       dataset('TMTEMP::BH_Relative_Match_FEIN',Layout_Relative_Match, flat) +
                       dataset('TMTEMP::BH_Relative_Match_Gong',Layout_Relative_Match, flat) +
                       dataset('TMTEMP::BH_Relative_Match_NameAddr',Layout_Relative_Match, flat) +
                       dataset('TMTEMP::BH_Relative_Match_Name_Phone',Layout_Relative_Match, flat) +
                       dataset('TMTEMP::BH_Relative_Match_Phone',Layout_Relative_Match, flat) +
                       dataset('TMTEMP::BH_Relative_Match_UCC',Layout_Relative_Match, flat) +
                       dataset('TMTEMP::BH_Relative_Match_Name',Layout_Relative_Match, flat) +
                       dataset('TMTEMP::BH_Relative_Match_Addr',Layout_Relative_Match, flat) +
                       dataset('TMTEMP::BH_Relative_Match_Mail_Addr',Layout_Relative_Match, flat) +
                       dataset('TEMP::BH_Relative_Match_DUNS_Tree',Layout_Relative_Match, flat);
                       dataset('TEMP::BH_Relative_Match_DCA_Hierarchy',Layout_Relative_Match, flat);
*/

// Reverse BDIDs
Layout_Relative_Match Reverse_BDIDs(Layout_Relative_Match L) := transform
self.bdid1 := L.bdid2;
self.bdid2 := L.bdid1;
self := L;
end;

BH_Relative_Matches_Reverse := project(BH_Relative_Matches, Reverse_BDIDs(left));

BH_Relative_Matches_Combined := BH_Relative_Matches + BH_Relative_Matches_Reverse;
//BH_Relative_Matches_Dedup := dedup(BH_Relative_Matches_Combined, bdid1, bdid2, match_type, all);

Layout_Business_Relative InitRollup(Layout_Relative_Match L) := transform
self.corp_charter_number := L.match_type = 'C';
self.bankruptcy_filing := L.match_type = 'B';
self.business_registration := L.match_type = 'BR';
self.duns_number := L.match_type = 'D';
self.edgar_cik := L.match_type = 'E';
self.name := L.match_type = 'NM';
self.name_address := L.match_type = 'NA';
self.name_phone := L.match_type = 'NP';
self.phone := L.match_type = 'PH';
self.addr := L.match_type = 'AD';
self.mail_addr := L.match_type = 'MA';
self.gong_group := L.match_type in ['GB','GG'];
self.ucc_filing := L.match_type = 'U';
self.fbn_filing := L.match_type = 'F';
self.fein := L.match_type = 'FE';
self.duns_tree := L.match_type = 'DT';
self.dca_company_number := L.match_type = 'DC';
self.dca_hierarchy := L.match_type = 'DH';
self.abi_number := L.match_type in ['IA', 'ID'];
self.abi_hierarchy := L.match_type in ['IH'];
//self.shared_contacts := L.match_type = 'SC';
self := L;
end;

Match_Rollup_Init := project(BH_Relative_Matches_Combined, InitRollup(left));
Match_Rollup_Init_Dist := distribute(Match_Rollup_Init, hash(bdid1, bdid2));
Match_Rollup_Init_Sort := sort(Match_Rollup_Init_Dist, bdid1, bdid2, local);

Layout_Business_Relative RollupMatches(Layout_Business_Relative L, Layout_Business_Relative R) := transform
self.corp_charter_number := if(R.corp_charter_number, R.corp_charter_number, L.corp_charter_number);
self.bankruptcy_filing := if(R.bankruptcy_filing, R.bankruptcy_filing, L.bankruptcy_filing);
self.duns_number := if(R.duns_number, R.duns_number, L.duns_number);
self.edgar_cik := if(R.edgar_cik, R.edgar_cik, L.edgar_cik);
self.name := if(R.name, R.name, L.name);
self.name_address := if(R.name_address, R.name_address, L.name_address);
self.name_phone := if(R.name_phone, R.name_phone, L.name_phone);
self.phone := if(R.phone, R.phone, L.phone);
self.addr := if(R.addr, R.addr, L.addr);
self.mail_addr := if(R.mail_addr, R.mail_addr, L.mail_addr);
self.gong_group := if(R.gong_group, R.gong_group, L.gong_group);
self.ucc_filing := if(R.ucc_filing, R.ucc_filing, L.ucc_filing);
self.fbn_filing := if(R.fbn_filing, R.fbn_filing, L.fbn_filing);
self.fein := if(R.fein, R.fein, L.fein);
self.business_registration := if(R.business_registration, R.business_registration, L.business_registration);
self.duns_tree := if (R.duns_tree, R.duns_tree, L.duns_tree);
self.dca_company_number := if (R.dca_company_number, R.dca_company_number, L.dca_company_number);
self.dca_hierarchy := if (R.dca_hierarchy, R.dca_hierarchy, L.dca_hierarchy);
self.abi_number := if (R.abi_number, R.abi_number, L.abi_number);
self.abi_hierarchy := if (R.abi_hierarchy, R.abi_hierarchy, L.abi_hierarchy);
//self.shared_contacts := if (R.shared_contacts, R.shared_contacts, L.shared_contacts);
self := L;
end;

Match_Rollup := rollup(Match_Rollup_Init_Sort,
                       left.bdid1 = right.bdid1 and
                       left.bdid2 = right.bdid2,
                       RollupMatches(left, right),
                       local);

// Add group records to Match Rollup
Layout_Business_Relative FormatGroups(Layout_Business_Relative_Group l) := transform
self.bdid1 := l.bdid;
self.bdid2 := l.group_id;
self.name := l.group_type = 'NM';
self.duns_tree := l.group_type = 'DT';
self.addr := l.group_type = 'AD';
self.rel_group := true;
end;

Group_Rollup := project(BH_Relative_Group_Rollup, FormatGroups(left));

Match_Rollup_Combined := Match_Rollup + Group_Rollup;

export BH_Relative_Match_Rollup := business_header.fun_RemoveBizRegAgents(Match_Rollup_Combined);