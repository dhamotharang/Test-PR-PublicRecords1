// Compare FL and CA between Experian NBD and EBR
ENBD_File := TM_Test.enbd_prep;

EBR_File := Business_Header.File_Business_Header(source = 'EB');

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
				 
EBR_list_init := project(EBR_File(state=match_state),
                         transform(Layout_BDID_List, self.group_id := 0, self := left));
				
// Append group id to EBR list
bg := Business_Header.File_Super_Group;

EBR_list := join(bg,
                 EBR_list_init,
			  left.bdid = right.bdid,
			  transform(Layout_BDID_List, self.bdid := right.bdid, self.group_id := left.group_id),
			  right outer,
			  hash);
			  
EBR_list_dedup := dedup(EBR_list, all);
count(EBR_list_dedup);

// Get ENBD matches to EBR
ENBD_match_EBR := join(ENBD_list_dedup,
                         EBR_list_dedup,
					left.bdid = right.bdid,
					transform(Layout_BDID_List, self := left),
					hash);
					
count(ENBD_match_EBR);

// Get sample of matched records
ENBD_match_full := join(ENBD_File,
                          ENBD_match_EBR,
					 left.bdid = right.bdid,
					 transform(TM_Test.Layout_ENBD_Base, self := left),
					 hash);

output(enth(ENBD_match_full, 1000),all);

// Get ENBD no matches to EBR
ENBD_nomatch_EBR := join(ENBD_list_dedup,
                         EBR_list_dedup,
					left.bdid = right.bdid,
					transform(Layout_BDID_List, self := left),
					left only,
					hash);
					
count(ENBD_nomatch_EBR);

// Get sample of non-matched records
ENBD_nomatch_full := join(ENBD_File,
                          ENBD_nomatch_EBR,
					 left.bdid = right.bdid,
					 transform(TM_Test.Layout_ENBD_Base, self := left),
					 hash);

output(enth(ENBD_nomatch_full, 1000),all);

// Get EBR no matches to ENDB
EBR_nomatch_ENDB := join(ENBD_list_dedup,
                         EBR_list_dedup,
					left.bdid = right.bdid,
					transform(Layout_BDID_List, self := right),
					right only,
					hash);
					
count(EBR_nomatch_ENDB);

EBR_nomatch_full := join(EBR_File,
                         EBR_nomatch_ENDB,
					left.bdid = right.bdid,
					transform(Business_Header.Layout_Business_Header_Base, self := left),
					hash);

output(enth(EBR_nomatch_full, 1000),all);

// Get ENBD Group matches to EBR
ENBD_group_match_EBR := join(dedup(ENBD_list_dedup, group_id, all),
                         dedup(EBR_list_dedup, group_id, all),
					left.group_id = right.group_id,
					transform(Layout_BDID_List, self := left),
					hash);
					
count(ENBD_group_match_EBR);

// Get ENBD no group matches to EBR
ENBD_group_nomatch_EBR := join(dedup(ENBD_list_dedup, group_id, all),
                         dedup(EBR_list_dedup, group_id, all),
					left.group_id = right.group_id,
					transform(Layout_BDID_List, self := left),
					left only,
					hash);
					
count(ENBD_group_nomatch_EBR);

// Get DNB no group matches to ENDB
EBR_group_nomatch_ENDB := join(dedup(ENBD_list_dedup, group_id, all),
                         dedup(EBR_list_dedup, group_id, all),
					left.group_id = right.group_id,
					transform(Layout_BDID_List, self := right),
					right only,
					hash);
					
count(EBR_group_nomatch_ENDB);

			  





