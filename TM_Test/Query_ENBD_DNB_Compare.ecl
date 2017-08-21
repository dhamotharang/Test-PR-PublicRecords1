// Compare FL and CA between Experian NBD and D&B
ENBD_File := TM_Test.enbd_prep;

DNB_File := DNB.File_DNB_Base;

// Define match state
match_state := 'FL';

Layout_BDID_List := record
unsigned6 bdid;
unsigned6 group_id;
end;

ENBD_list := project(ENBD_File(bdid <> 0, bus_st=match_state),
                     transform(Layout_BDID_List, self := left));
				 
ENBD_list_dedup := dedup(ENBD_list, all);
count(ENBD_list_dedup);
				 
DNB_list_init := project(DNB_File(bdid <> 0, state=match_state),
                         transform(Layout_BDID_List, self.group_id := 0, self := left));
				
// Append group id to D&B list
bg := Business_Header.File_Super_Group;

DNB_list := join(bg,
                 DNB_list_init,
			  left.bdid = right.bdid,
			  transform(Layout_BDID_List, self.bdid := right.bdid, self.group_id := left.group_id),
			  right outer,
			  hash);
			  
DNB_list_dedup := dedup(DNB_list, all);
count(DNB_list_dedup);

// Get ENBD matches to DNB
ENBD_match_DNB := join(ENBD_list_dedup,
                         DNB_list_dedup,
					left.bdid = right.bdid,
					transform(Layout_BDID_List, self := left),
					hash);
					
count(ENBD_match_DNB);

// Get sample of matched records
ENBD_match_full := join(ENBD_File,
                          ENBD_match_DNB,
					 left.bdid = right.bdid,
					 transform(TM_Test.Layout_ENBD_Base, self := left),
					 hash);

output(enth(ENBD_match_full, 1000),all);

// Get ENBD no matches to DNB
ENBD_nomatch_DNB := join(ENBD_list_dedup,
                         DNB_list_dedup,
					left.bdid = right.bdid,
					transform(Layout_BDID_List, self := left),
					left only,
					hash);
					
count(ENBD_nomatch_DNB);

// Get sample of non-matched records
ENBD_nomatch_full := join(ENBD_File,
                          ENBD_nomatch_DNB,
					 left.bdid = right.bdid,
					 transform(TM_Test.Layout_ENBD_Base, self := left),
					 hash);

output(enth(ENBD_nomatch_full, 1000),all);


// Get DNB no matches to ENDB
DNB_nomatch_ENDB := join(ENBD_list_dedup,
                         DNB_list_dedup,
					left.bdid = right.bdid,
					transform(Layout_BDID_List, self := right),
					right only,
					hash);
					
count(DNB_nomatch_ENDB);

DNB_nomatch_full := join(DNB_File,
                         DNB_nomatch_ENDB,
					left.bdid = right.bdid,
					transform(DNB.Layout_DNB_Base, self := left),
					hash);

output(enth(DNB_nomatch_full, 1000),all);

// Get ENBD Group matches to DNB
ENBD_group_match_DNB := join(dedup(ENBD_list_dedup, group_id, all),
                         dedup(DNB_list_dedup, group_id, all),
					left.group_id = right.group_id,
					transform(Layout_BDID_List, self := left),
					hash);
					
count(ENBD_group_match_DNB);

// Get ENBD no group matches to DNB
ENBD_group_nomatch_DNB := join(dedup(ENBD_list_dedup, group_id, all),
                         dedup(DNB_list_dedup, group_id, all),
					left.group_id = right.group_id,
					transform(Layout_BDID_List, self := left),
					left only,
					hash);
					
count(ENBD_group_nomatch_DNB);

// Get DNB no group matches to ENDB
DNB_group_nomatch_ENDB := join(dedup(ENBD_list_dedup, group_id, all),
                         dedup(DNB_list_dedup, group_id, all),
					left.group_id = right.group_id,
					transform(Layout_BDID_List, self := right),
					right only,
					hash);
					
count(DNB_group_nomatch_ENDB);

			  





