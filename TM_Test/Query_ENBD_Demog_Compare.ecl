// Compare FL and CA between Experian NBD and Demographic Data Files
ENBD_File := TM_Test.enbd_prep;

DNB_File := DNB.File_DNB_Base;

BH_File := Business_Header.File_Business_Header;

DEMOG_File := BH_File(source in ['DC','EB','IA']);


// Define match state
match_state := 'CA';

Layout_BDID_List := record
unsigned6 bdid;
unsigned6 group_id;
end;

ENBD_list := project(ENBD_File(bdid <> 0, bus_st=match_state),
                     transform(Layout_BDID_List, self := left));
				 
ENBD_list_dedup := dedup(ENBD_list, all);
count(ENBD_list_dedup);
				 
DEMOG_list_init := project(DNB_File(bdid <> 0, state=match_state),
                         transform(Layout_BDID_List, self.group_id := 0, self := left)) +
		       project(DEMOG_File(state=match_state),
                         transform(Layout_BDID_List, self.group_id := 0, self := left));
					
// Append group id to D&B list
bg := Business_Header.File_Super_Group;

DEMOG_list := join(bg,
                 DEMOG_list_init,
			  left.bdid = right.bdid,
			  transform(Layout_BDID_List, self.bdid := right.bdid, self.group_id := left.group_id),
			  right outer,
			  hash);
			  
DEMOG_list_dedup := dedup(DEMOG_list, all);
count(DEMOG_list_dedup);

// Get ENBD matches to DEMOG
ENBD_match_DEMOG := join(ENBD_list_dedup,
                         DEMOG_list_dedup,
					left.bdid = right.bdid,
					transform(Layout_BDID_List, self := left),
					hash);
					
count(ENBD_match_DEMOG);

// Get sample of matched records
ENBD_match_full := join(ENBD_File,
                          ENBD_match_DEMOG,
					 left.bdid = right.bdid,
					 transform(TM_Test.Layout_ENBD_Base, self := left),
					 hash);

output(enth(ENBD_match_full, 1000),all);

// Get ENBD no matches to DEMOG
ENBD_nomatch_DEMOG := join(ENBD_list_dedup,
                         DEMOG_list_dedup,
					left.bdid = right.bdid,
					transform(Layout_BDID_List, self := left),
					left only,
					hash);
					
count(ENBD_nomatch_DEMOG);

// Get sample of non-matched records
ENBD_nomatch_full := join(ENBD_File,
                          ENBD_nomatch_DEMOG,
					 left.bdid = right.bdid,
					 transform(TM_Test.Layout_ENBD_Base, self := left),
					 hash);

output(enth(ENBD_nomatch_full, 1000),all);


// Get DEMOG no matches to ENDB
DEMOG_nomatch_ENDB := join(ENBD_list_dedup,
                         DEMOG_list_dedup,
					left.bdid = right.bdid,
					transform(Layout_BDID_List, self := right),
					right only,
					hash);
					
count(DEMOG_nomatch_ENDB);

DEMOG_nomatch_full := join((DEMOG_File + BH_FILE(source = 'D')),
                         DEMOG_nomatch_ENDB,
					left.bdid = right.bdid,
					transform(Business_Header.Layout_Business_Header_Base, self := left),
					hash);

output(enth(DEMOG_nomatch_full, 1000),all);

// Get ENBD Group matches to DEMOG
ENBD_group_match_DEMOG := join(dedup(ENBD_list_dedup, group_id, all),
                         dedup(DEMOG_list_dedup, group_id, all),
					left.group_id = right.group_id,
					transform(Layout_BDID_List, self := left),
					hash);
					
count(ENBD_group_match_DEMOG);

// Get ENBD no group matches to DEMOG
ENBD_group_nomatch_DEMOG := join(dedup(ENBD_list_dedup, group_id, all),
                         dedup(DEMOG_list_dedup, group_id, all),
					left.group_id = right.group_id,
					transform(Layout_BDID_List, self := left),
					left only,
					hash);
					
count(ENBD_group_nomatch_DEMOG);

// Get DEMOG no group matches to ENDB
DEMOG_group_nomatch_ENDB := join(dedup(ENBD_list_dedup, group_id, all),
                         dedup(DEMOG_list_dedup, group_id, all),
					left.group_id = right.group_id,
					transform(Layout_BDID_List, self := right),
					right only,
					hash);
					
count(DEMOG_group_nomatch_ENDB);

			  





