IMPORT $, dx_Gong, Phonesplus_v2;

// Threshold for overly frequent combinations is 5000 instances
// Any combination with less than 5000 instances will be excluded from the key (query will just search for these);
// Any combination with more than 5000 instances will have a selection of 500 records in the key,
// (sampled from a selection of 5000 records) along with the actual total count (query will report the count
// and provide these 500 matches as the sample result)
// Sample is expected to appear somewhat random (e.g., not all from the same state), so the sorting
// prior to selection will provide this behavior
unsigned2 freq_thold := 5000;
unsigned2 keep_val := 500;

boolean isBadName(string lname) := (TRIM(stringlib.stringfilter(lname,'0123456789()')) <> '');
surnames_gong := distribute(PROJECT($.File_Surnames(current_record_flag='Y',TRIM(name_last)<>'',TRIM(name_first)<>'',
										~isBadName(name_last), ~isBadName(name_first)), 
									recordof(File_History_Full_Prepped_for_Keys)),
									hash(name_last)) ;

surnames_pplus := distribute(PROJECT(Phonesplus_v2.File_Surnames(TRIM(name_last)<>'',TRIM(name_first)<>'',
										~isBadName(name_last), ~isBadName(name_first)), 
									recordof(File_History_Full_Prepped_for_Keys)),
									hash(name_last)) ;

surnames_all := surnames_gong + surnames_pplus : PERSIST('~thor_data400::persist::neustar::gong_surnames_all');

//get all of the permutations (lname is required; fname and state optional)
surnames_l := TABLE(surnames_all, {name_last, cnt := COUNT(GROUP)}, name_last,local);
// DF-26966: recent change made to Gong_Neustar/Key_History_Surname.ecl
surnames_lf := TABLE(surnames_all(name_first<>''), {name_last,name_first, cnt := COUNT(GROUP)}, name_last, name_first,local);
surnames_ls := TABLE(surnames_all(st<>''), {name_last,st, cnt := COUNT(GROUP)}, name_last, st,local);
surnames_lfs := TABLE(surnames_all(name_first<>'',st<>''), {name_last,name_first,st, cnt := COUNT(GROUP)}, name_last, name_first, st,local);

// only save the most frequent combinations (cnt > freq_thold)
surnames_l_f := surnames_l(cnt>freq_thold);
surnames_lf_f := surnames_lf(cnt>freq_thold);
surnames_ls_f := surnames_ls(cnt>freq_thold);
surnames_lfs_f := surnames_lfs(cnt>freq_thold);

f_layout := Layout_HistorySurname;
f_layout_cnt := RECORD(f_layout)
	string20 k_name_last := '';
	string20 k_name_first := '';
	string2 k_st := '';
	unsigned cnt;
END;
f_layout_num := RECORD(f_layout_cnt)
	unsigned num := 0;
END;

// join the most freq combinations back against the full records
// set the values for fields to be keyed (k_name_last, k_name_first, k_st) accordingly

surnames_l_j := JOIN(surnames_all, surnames_l_f, LEFT.name_last = RIGHT.name_last, 
										 TRANSFORM(f_layout_num, SELF.k_name_last := RIGHT.name_last, SELF.cnt := RIGHT.cnt, 
																						 SELF := LEFT, SELF := RIGHT), LIMIT(0), local);

// optimize by joining against the lname result above, since the list of frequent lnames must include 
// the list of frequent lname/fname combos
surnames_lf_j := JOIN(surnames_l_j,surnames_lf_f, LEFT.name_last = RIGHT.name_last and LEFT.name_first = RIGHT.name_first, 
											TRANSFORM(f_layout_num, SELF.k_name_last := RIGHT.name_last, 
																							SELF.k_name_first := RIGHT.name_first, SELF.cnt := RIGHT.cnt,
																						  SELF := LEFT, SELF := RIGHT), LIMIT(0), local);

// optimize by joining against the lname result above, since the list of frequent lnames must include 
// the list of frequent lname/state combos																							
surnames_ls_j := JOIN(surnames_l_j, surnames_ls_f, LEFT.name_last = RIGHT.name_last and LEFT.st = RIGHT.st, 
											TRANSFORM(f_layout_num, SELF.k_name_last := RIGHT.name_last, SELF.k_st := RIGHT.st,
																							SELF.cnt := RIGHT.cnt, SELF := LEFT, SELF := RIGHT), LIMIT(0), local);

// optimize by joining against the lname/fname result above, since the list of frequent lnames/fnames must include 
// the list of frequent lname/fname/state combos	
surnames_lfs_j := JOIN(surnames_lf_j, surnames_lfs_f, LEFT.name_last = RIGHT.name_last and LEFT.name_first = RIGHT.name_first and LEFT.st = RIGHT.st, 
											 TRANSFORM(f_layout_num, SELF.k_name_last := RIGHT.name_last, SELF.k_name_first := RIGHT.name_first,
																							 SELF.k_st := RIGHT.st, SELF.cnt := RIGHT.cnt, SELF := LEFT, SELF := RIGHT),LIMIT(0), local);

// Need to take a sample of 5000 records
//
// However, issues with skew in the JOIN for the most common names,
// rowarray too large when grouping the most common names for dedup, and
// coupled with the fact that KEEP option on JOIN only affects matches for left recset...
// So the sort, then iterate & number, then filter is an alternate way to get 5000 records per "group"

//
// Last name only
//
surnames_l_d := DISTRIBUTE(surnames_l_j, hash(name_last));
surnames_l_s := SORT(surnames_l_d, name_last, hash(prim_name,v_city_name,phone10),LOCAL);

f_layout_num numberGroupsL(f_layout_num l, f_layout_num r) := TRANSFORM
	// start renumbering at 1 everytime the last name changes
	SELF.num := IF(l.name_last <> r.name_last, 1, l.num+1);
	SELF := r;
END;

surnames_l_i := ITERATE(surnames_l_s, numberGroupsL(LEFT, RIGHT),LOCAL);
surnames_l_filt := surnames_l_i(num<=freq_thold);
surnames_l_did := DEDUP(SORT(surnames_l_filt(did<>0), did), did) + surnames_l_filt(did=0);

//
// Last name/First Name
//
surnames_lf_d := DISTRIBUTE(surnames_lf_j, hash(name_last, name_first));
surnames_lf_s := SORT(surnames_lf_d, name_last, name_first, hash(prim_name,v_city_name,phone10),LOCAL);

f_layout_num numberGroupsLF(f_layout_num l, f_layout_num r) := TRANSFORM
	// start renumbering at 1 everytime the last name or first name changes
	SELF.num := IF((l.name_last <> r.name_last or l.name_first <> r.name_first), 1, l.num+1);
	SELF := r;
END;

surnames_lf_i := ITERATE(surnames_lf_s, numberGroupsLF(LEFT, RIGHT), LOCAL);
surnames_lf_filt := surnames_lf_i(num<=freq_thold);
surnames_lf_did := DEDUP(SORT(surnames_lf_filt(did<>0), did), did) + surnames_lf_filt(did=0);


//
// Last name/State
//
surnames_ls_d := DISTRIBUTE(surnames_ls_j, hash(name_last, st));
surnames_ls_s := SORT(surnames_ls_d, name_last, st, hash(prim_name,v_city_name,phone10),LOCAL);

f_layout_num numberGroupsLS(f_layout_num l, f_layout_num r) := TRANSFORM
	// start renumbering at 1 everytime the last name or st changes
	SELF.num := IF((l.name_last <> r.name_last or l.st <> r.st), 1, l.num+1);
	SELF := r;
END;

surnames_ls_i := ITERATE(surnames_ls_s, numberGroupsLS(LEFT, RIGHT), LOCAL);
surnames_ls_filt := surnames_ls_i(num<=freq_thold);
surnames_ls_did := DEDUP(SORT(surnames_ls_filt(did<>0), did), did) + surnames_ls_filt(did=0);

//
// Last name/First Name/State
//
surnames_lfs_d := DISTRIBUTE(surnames_lfs_j, hash(name_last, name_first, st));
surnames_lfs_s := SORT(surnames_lfs_d, name_last, name_first, st, hash(prim_name,v_city_name,phone10),LOCAL);

f_layout_num numberGroupsLFS(f_layout_num l, f_layout_num r) := TRANSFORM
	// start renumbering at 1 everytime the last name or first name changes
	SELF.num := IF((l.name_last <> r.name_last or l.name_first <> r.name_first or l.st <> r.st), 1, l.num+1);
	SELF := r;
END;

surnames_lfs_i := ITERATE(surnames_lfs_s, numberGroupsLFS(LEFT, RIGHT), LOCAL);
surnames_lfs_filt := surnames_lfs_i(num<=freq_thold);
surnames_lfs_did := DEDUP(SORT(surnames_lfs_filt(did<>0), did), did) + surnames_lfs_filt(did=0);


// sort these, keep the first 500
surnames_l_dd := DEDUP(GROUP(SORT(surnames_l_did, name_last, name_first, prim_name, v_city_name, phone10[4..10], did), name_last),true, KEEP keep_val); 
surnames_lf_dd := DEDUP(GROUP(SORT(surnames_lf_did, name_last, name_first, prim_name, v_city_name, phone10[4..10], did), name_last, name_first), true, KEEP keep_val); 
surnames_ls_dd := DEDUP(GROUP(SORT(surnames_ls_did, name_last, st, name_first, prim_name, v_city_name, phone10[4..10], did), name_last, st), true, KEEP keep_val); 
surnames_lfs_dd := DEDUP(GROUP(SORT(surnames_lfs_did, name_last, name_first, st, prim_name, v_city_name, phone10[4..10], did), name_last, name_first, st),true, KEEP keep_val); 

// slim them back 
surnames_l_final := PROJECT(surnames_l_dd, f_layout_cnt);
surnames_lf_final := PROJECT(surnames_lf_dd, f_layout_cnt);
surnames_ls_final := PROJECT(surnames_ls_dd, f_layout_cnt);
surnames_lfs_final := PROJECT(surnames_lfs_dd, f_layout_cnt);

// combine them all and index 
surnames_final := surnames_l_final + surnames_lf_final + surnames_ls_final + surnames_lfs_final;

ds_ready := PROJECT (surnames_final, dx_Gong.layouts.i_history_surname);
EXPORT data_key_history_surname := ds_ready;