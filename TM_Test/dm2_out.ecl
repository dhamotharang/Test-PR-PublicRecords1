import DNB, Business_Header;

dm2_out_init := TM_Test.dm2_group_phone_best;

// Dedup to keep best business phone number
dm2_out_init_dist := distribute(dm2_out_init, hash(rid));
dm2_out_init_sort := sort(dm2_out_init_dist, rid, if(bdid <> 0, 0, 1), if(bus_best_phone <> '', 0, 1), if(Company_Address <> '', 0, 1), local);
dm2_out_init_dedup := dedup(dm2_out_init_sort, rid, local);

// Get list of bdids
layout_bdid_list := record
dm2_out_init_dedup.bdid;
end;

bdid_list := table(dm2_out_init_dedup(bdid <> 0), layout_bdid_list);
bdid_list_dedup := dedup(bdid_list, all);

dbf := DNB.File_DNB_Base;

layout_dnb_sic := record
dbf.bdid;
dbf.sic1;
end;

dbf_siccodes := table(dbf(bdid <> 0, sic1 <> ''), layout_dnb_sic);
dbf_siccodes_dedup := dedup(dbf_siccodes, bdid, all);

// Select the matching bdids
dbf_siccodes_match := join(dbf_siccodes_dedup,
                           bdid_list_dedup,
					  left.bdid = right.bdid,
					  transform(layout_dnb_sic, self := left),
					  hash);
					  
// Select the non-matching bdids
dbf_siccodes_nonmatch := join(dbf_siccodes_dedup,
                              bdid_list_dedup,
					     left.bdid = right.bdid,
					     transform(layout_bdid_list, self := right),
						right only,
					     hash);

// Match Business Header SIC codes
bh_siccodes := Business_Header.BH_BDID_SIC;

// Select the non-matched DM2 BDIDs codes from business header
bh_siccodes_match := join(bh_siccodes,
                          dbf_siccodes_nonmatch,
				      left.bdid = right.bdid,
				      transform(Business_Header.Layout_SIC_Code, self := left),
				      hash);
				 
// Select the best siccode
unsigned1 Map_Siccode_Hierarchy(STRING2 source) := MAP(
								source = 'D' => 1,
                                        source = 'C' => 2,
                                        source = 'IA' => 3,
                                        source = 'E' => 4,
                                        source = 'BR' => 5,
                                        source = 'Y' => 6,
                                        source = 'V' => 7,
                                        8);
						  
bh_siccodes_match_dist := distribute(bh_siccodes_match, hash(bdid));
bh_siccodes_match_sort := sort(bh_siccodes_match_dist, bdid, Map_Siccode_Hierarchy(source), local);
bh_siccodes_match_dedup := dedup(bh_siccodes_match_sort, bdid, local);

layout_bdid_sic := record
unsigned6 bdid;
string8 siccode;
end;

siccodes_match := project(dbf_siccodes_match,
                          transform(layout_bdid_sic, self.siccode := left.sic1, self := left)) +
			   project(bh_siccodes_match_dedup,
			           transform(layout_bdid_sic, self.siccode := left.sic_code, self := left));
					 
// Append SIC codes to DM2 data
layout_dm2_temp := record
TM_Test.Layout_DM2_Base;
string8 siccode;
end;

dm2_siccodes := join(dm2_out_init_dedup,
                     siccodes_match,
				 left.bdid = right.bdid,
				 transform(layout_dm2_temp, self.siccode := right.siccode, self := left),
				 left outer,
				 hash);
				 
// Project to output layout
export dm2_out := project(dm2_siccodes,
                          transform(Layout_DM2_Out, self.Location_Phone := left.bus_best_phone,
					                           self.SIC := left.siccode;
										  self := left)) : persist('TMTEST::dm2_out');
                     
