// Compare FL and CA between Experian NBD and InfoUSA
ENBD_File := TM_Test.enbd_prep;

IUSA_File := Business_Header.File_Business_Header(source in ['IA','ID','IF','II']);

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
				 
IUSA_list_init := project(IUSA_File(state=match_state),
                         transform(Layout_BDID_List, self.group_id := 0, self := left));
				
// Append group id to EBR list
bg := Business_Header.File_Super_Group;

IUSA_list := join(bg,
                 IUSA_list_init,
			  left.bdid = right.bdid,
			  transform(Layout_BDID_List, self.bdid := right.bdid, self.group_id := left.group_id),
			  right outer,
			  hash);
			  
IUSA_list_dedup := dedup(IUSA_list, all);
count(IUSA_list_dedup);

// Get ENBD matches to IUSA
ENBD_match_IUSA := join(ENBD_list_dedup,
                         IUSA_list_dedup,
					left.bdid = right.bdid,
					transform(Layout_BDID_List, self := left),
					hash);
					
count(ENBD_match_IUSA);

// Get sample of matched records
ENBD_match_full := join(ENBD_File,
                          ENBD_match_IUSA,
					 left.bdid = right.bdid,
					 transform(TM_Test.Layout_ENBD_Base, self := left),
					 hash);

output(enth(ENBD_match_full, 1000),all);

// Get ENBD no matches to EBR
ENBD_nomatch_IUSA := join(ENBD_list_dedup,
                         IUSA_list_dedup,
					left.bdid = right.bdid,
					transform(Layout_BDID_List, self := left),
					left only,
					hash);
					
count(ENBD_nomatch_IUSA);

// Get sample of non-matched records
ENBD_nomatch_full := join(ENBD_File,
                          ENBD_nomatch_IUSA,
					 left.bdid = right.bdid,
					 transform(TM_Test.Layout_ENBD_Base, self := left),
					 hash);

output(enth(ENBD_nomatch_full, 1000),all);

// Get EBR no matches to ENDB
IUSA_nomatch_ENDB := join(ENBD_list_dedup,
                         IUSA_list_dedup,
					left.bdid = right.bdid,
					transform(Layout_BDID_List, self := right),
					right only,
					hash);
					
count(IUSA_nomatch_ENDB);

IUSA_nomatch_full := join(IUSA_File,
                         IUSA_nomatch_ENDB,
					left.bdid = right.bdid,
					transform(Business_Header.Layout_Business_Header_Base, self := left),
					hash);

output(enth(IUSA_nomatch_full, 1000),all);

// Get ENBD Group matches to IUSA
ENBD_group_match_IUSA := join(dedup(ENBD_list_dedup, group_id, all),
                         dedup(IUSA_list_dedup, group_id, all),
					left.group_id = right.group_id,
					transform(Layout_BDID_List, self := left),
					hash);
					
count(ENBD_group_match_IUSA);

// Get ENBD no group matches to IUSA
ENBD_group_nomatch_IUSA := join(dedup(ENBD_list_dedup, group_id, all),
                         dedup(IUSA_list_dedup, group_id, all),
					left.group_id = right.group_id,
					transform(Layout_BDID_List, self := left),
					left only,
					hash);
					
count(ENBD_group_nomatch_IUSA);

// Get IUSA no group matches to ENDB
IUSA_group_nomatch_ENDB := join(dedup(ENBD_list_dedup, group_id, all),
                         dedup(IUSA_list_dedup, group_id, all),
					left.group_id = right.group_id,
					transform(Layout_BDID_List, self := right),
					right only,
					hash);
					
count(IUSA_group_nomatch_ENDB);
