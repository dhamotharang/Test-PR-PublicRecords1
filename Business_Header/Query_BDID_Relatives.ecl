// Enter BDID of Company to process
query_bdid := 18039411;

// output best information associated with this BDID
output(Business_Header.File_Business_Header_Best(bdid = query_bdid), named('Best_Company_Information'));

// output all base records associated with this BDID
output(choosen(Business_Header.File_Business_Header(bdid = query_bdid),all), named('Base_Company_Records'));

// Get Relative list for this bdid
query_relatives := Business_Header.File_Business_Relatives(bdid1 = query_bdid, not rel_group);
query_relatives_group := Business_Header.File_Business_Relatives(bdid1 = query_bdid, rel_group);
query_relatives_name_group := query_relatives_group(name);
query_relatives_name_group_count := count(query_relatives_name_group);
query_relatives_addr_group := query_relatives_group(addr);
query_relatives_addr_group_count := count(query_relatives_addr_group);
query_relatives_duns_tree_group := query_relatives_group(duns_tree);
query_relatives_duns_tree_group_count := count(query_relatives_duns_tree_group);

// Get all related Best Records
Business_Header.Layout_BH_Best SelectBest(Business_Header.Layout_BH_Best L, Business_Header.Layout_Business_Relative R) := transform
self := L;
end;

relatives_best := join(Business_Header.File_Business_Header_Best,
                       query_relatives,
                       left.bdid = right.bdid2,
                       SelectBest(left, right),
                       lookup);

// Join with best to get list of relatives by corporate charter number
Relatives_By_Corp_Charter_Number := join(relatives_best,
                                         query_relatives(corp_charter_number),
                                         left.bdid = right.bdid2,
                                         SelectBest(left, right),
                                         lookup);

output(choosen(Relatives_By_Corp_Charter_Number,all), named('Relatives_By_Corp_Charter_Number'));

// Join with best to get list of relatives by business registration
Relatives_By_Business_Registration := join(relatives_best,
                                           query_relatives(business_registration),
                                           left.bdid = right.bdid2,
                                           SelectBest(left, right),
                                           lookup);

output(choosen(Relatives_By_Business_Registration,all), named('Relatives_By_Business_Registration'));

// Join with best to get list of relatives by bankruptcy filing
Relatives_By_Bankruptcy_Filing := join(relatives_best,
                                       query_relatives(bankruptcy_filing),
                                       left.bdid = right.bdid2,
                                       SelectBest(left, right),
                                       lookup);

output(choosen(Relatives_By_Bankruptcy_Filing,all), named('Relatives_By_Bankruptcy_Filing'));

// Join with best to get list of relatives by duns number
Relatives_By_Duns_Number := join(relatives_best,
                                 query_relatives(duns_number),
                                 left.bdid = right.bdid2,
                                 SelectBest(left, right),
                                 lookup);

output(choosen(Relatives_By_Duns_Number,all), named('Relatives_By_Duns_Number'));

// Join with best to get list of relatives by duns tree
Relatives_By_Duns_Tree_Relative := join(relatives_best,
                                        query_relatives(duns_tree),
                                        left.bdid = right.bdid2,
                                        SelectBest(left, right),
                                        lookup);

Business_Header.Layout_Business_Relative_Group SelectGroup(Business_Header.Layout_Business_Relative_Group l, Business_Header.Layout_Business_Relative r) := transform
self := l;
end;								 

Relatives_Duns_Tree_Group_List := join(Business_Header.File_Business_Relatives_Group,
                                  query_relatives_duns_tree_group,
                                  left.group_id = right.bdid2,
                                  SelectGroup(left, right),
                                  lookup);

Business_Header.Layout_BH_Best SelectBestGroup(Business_Header.Layout_BH_Best L, Business_Header.Layout_Business_Relative_Group R) := transform
self := L;
end;								  

Relatives_By_Duns_Tree_Group := join(Business_Header.File_Business_Header_Best,
                          Relatives_Duns_Tree_Group_List,
                          left.bdid = right.bdid,
                          SelectBestGroup(left, right),
                          lookup);

Relatives_By_Duns_Tree := if(query_relatives_duns_tree_group_count <> 0, Relatives_By_Duns_Tree_Relative + Relatives_By_Duns_Tree_Group, Relatives_By_Duns_Tree_Relative);

output(choosen(Relatives_By_Duns_Tree,all), named('Relatives_By_Duns_Tree'));

// Join with best to get list of relatives by edgar cik
Relatives_By_Edgar_CIK := join(relatives_best,
                               query_relatives(edgar_cik),
                               left.bdid = right.bdid2,
                               SelectBest(left, right),
                               lookup);

output(choosen(Relatives_By_Edgar_CIK,all), named('Relatives_By_Edgar_CIK'));

// Join with best to get list of relatives by similar name
Relatives_By_Name_Relative := join(relatives_best,
                                   query_relatives(name),
                                   left.bdid = right.bdid2,
                                   SelectBest(left, right),
                                   lookup);

Relatives_Name_Group_List := join(Business_Header.File_Business_Relatives_Group,
                                  query_relatives_name_group,
                                  left.group_id = right.bdid2,
                                  SelectGroup(left, right),
                                  lookup);

Relatives_By_Name_Group := join(Business_Header.File_Business_Header_Best,
                          Relatives_Name_Group_List,
                          left.bdid = right.bdid,
                          SelectBestGroup(left, right),
                          lookup);

Relatives_By_Name := if(query_relatives_name_group_count <> 0, Relatives_By_Name_Relative + Relatives_By_Name_Group, Relatives_By_Name_Relative);

output(choosen(Relatives_By_Name,all), named('Relatives_By_Name'));


// Join with best to get list of relatives by similar name and address
Relatives_By_Similar_Name_Address := join(relatives_best,
                                          query_relatives(name_address),
                                          left.bdid = right.bdid2,
                                          SelectBest(left, right),
                                          lookup);

output(choosen(Relatives_By_Similar_Name_Address,all), named('Relatives_By_Similar_Name_Address'));

// Join with best to get list of relatives by mail address
Relatives_By_Mail_Address := join(relatives_best,
                                         query_relatives(mail_addr),
                                         left.bdid = right.bdid2,
                                         SelectBest(left, right),
                                         lookup);

output(choosen(Relatives_By_Mail_Address,all), named('Relatives_By_Mail_Address'));

// Join with best to get list of relatives by address
Relatives_By_Addr_Relative := join(relatives_best,
                                   query_relatives(addr),
                                   left.bdid = right.bdid2,
                                   SelectBest(left, right),
                                   lookup);

Relatives_Addr_Group_List := join(Business_Header.File_Business_Relatives_Group,
                                  query_relatives_addr_group,
                                  left.group_id = right.bdid2,
                                  SelectGroup(left, right),
                                  lookup);

Relatives_By_Addr_Group := join(Business_Header.File_Business_Header_Best,
                                Relatives_Addr_Group_List,
                                left.bdid = right.bdid,
                                SelectBestGroup(left, right),
                                lookup);

Relatives_By_Addr := if(query_relatives_addr_group_count <> 0, Relatives_By_Addr_Relative + Relatives_By_Addr_Group, Relatives_By_Addr_Relative);

output(choosen(Relatives_By_Addr,all), named('Relatives_By_Address'));

// Join with best to get list of relatives by similar name and phone
Relatives_By_Similar_Name_Phone := join(relatives_best,
                                        query_relatives(name_phone),
                                        left.bdid = right.bdid2,
                                        SelectBest(left, right),
                                        lookup);

output(choosen(Relatives_By_Similar_Name_Phone,all), named('Relatives_By_Similar_Name_Phone'));

// Join with best to get list of relatives by phone
Relatives_By_Phone := join(relatives_best,
                                         query_relatives(phone),
                                         left.bdid = right.bdid2,
                                         SelectBest(left, right),
                                         lookup);

output(choosen(Relatives_By_Phone,all), named('Relatives_By_Phone'));

// Join with best to get list of relatives by Telephone Listing Group
Relatives_By_Telephone_Listing_Group := join(relatives_best,
                                             query_relatives(gong_group),
                                             left.bdid = right.bdid2,
                                             SelectBest(left, right),
                                             lookup);

output(choosen(Relatives_By_Telephone_Listing_Group,all), named('Relatives_By_Telephone_Listing_Group'));

// Join with best to get list of relatives by UCC Filing
Relatives_By_UCC_Filing := join(relatives_best,
                                query_relatives(ucc_filing),
                                left.bdid = right.bdid2,
                                SelectBest(left, right),
                                lookup);

output(choosen(Relatives_By_UCC_Filing ,all), named('Relatives_By_UCC_Filing'));

// Join with best to get list of relatives by FBN filing
Relatives_By_FBN_Filing := join(relatives_best,
                                query_relatives(fbn_filing),
                                left.bdid = right.bdid2,
                                SelectBest(left, right),
                                lookup);

output(choosen(Relatives_By_FBN_Filing,all), named('Relatives_By_FBN_Filing'));

// Join with best to get list of relatives by FEIN
Relatives_By_FEIN := join(relatives_best,
                          query_relatives(fein),
                          left.bdid = right.bdid2,
                          SelectBest(left, right),
                          lookup);

output(choosen(Relatives_By_FEIN,all), named('Relatives_By_FEIN'));