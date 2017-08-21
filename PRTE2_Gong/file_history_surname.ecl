////////DS_gong_history_surnames//////////////////////////////////////////////////////////
		unsigned2 freq_thold := 5;
		unsigned2 keep_val := 500;
		boolean isBadName(string lname) := (TRIM(stringlib.stringfilter(lname,'0123456789()')) <> '');
		boolean isGoodName(string lname) := LENGTH(TRIM(lname)) > 0 AND TRIM(stringlib.stringfilter(lname,'@.0123456789()"')) = '';
		surnames_gong := Files.File_History_Full_Prepped_for_Keys(current_record_flag='Y',TRIM(name_last)<>'',TRIM(name_first)<>'',
												~isBadName(name_last), ~isBadName(name_first));
		surnames_l := TABLE(surnames_gong, {name_last, cnt := COUNT(GROUP)}, name_last);
		surnames_lf := TABLE(surnames_gong, {name_last,name_first, cnt := COUNT(GROUP)}, name_last, name_first);
		surnames_ls := TABLE(surnames_gong, {name_last,st, cnt := COUNT(GROUP)}, name_last, st);
		surnames_lfs := TABLE(surnames_gong, {name_last,name_first,st, cnt := COUNT(GROUP)}, name_last, name_first, st);
		surnames_l_f := surnames_l(cnt>freq_thold);
		surnames_lf_f := surnames_lf(cnt>freq_thold);
		surnames_ls_f := surnames_ls(cnt>freq_thold);
		surnames_lfs_f := surnames_lfs(cnt>freq_thold);
		surnames_l_j := JOIN(surnames_gong, surnames_l_f, LEFT.name_last = RIGHT.name_last, 
							TRANSFORM(Layouts.f_layout_num, SELF.k_name_last := RIGHT.name_last, SELF.cnt := RIGHT.cnt, 
								 SELF := LEFT, SELF := RIGHT), LIMIT(0));
		surnames_lf_j := JOIN(surnames_l_j,surnames_lf_f, LEFT.name_last = RIGHT.name_last and LEFT.name_first = RIGHT.name_first, 
						TRANSFORM(Layouts.f_layout_num, SELF.k_name_last := RIGHT.name_last, 
							SELF.k_name_first := RIGHT.name_first, SELF.cnt := RIGHT.cnt,
							SELF := LEFT, SELF := RIGHT), LIMIT(0));	
		surnames_ls_j := JOIN(surnames_l_j, surnames_ls_f, LEFT.name_last = RIGHT.name_last and LEFT.st = RIGHT.st, 
							TRANSFORM(Layouts.f_layout_num, SELF.k_name_last := RIGHT.name_last, SELF.k_st := RIGHT.st,
										SELF.cnt := RIGHT.cnt, SELF := LEFT, SELF := RIGHT), LIMIT(0));
		surnames_lfs_j := JOIN(surnames_lf_j, surnames_lfs_f, LEFT.name_last = RIGHT.name_last and LEFT.name_first = RIGHT.name_first and LEFT.st = RIGHT.st, 
			 TRANSFORM(Layouts.f_layout_num, SELF.k_name_last := RIGHT.name_last, SELF.k_name_first := RIGHT.name_first,
					 SELF.k_st := RIGHT.st, SELF.cnt := RIGHT.cnt, SELF := LEFT, SELF := RIGHT),LIMIT(0));
		surnames_l_d := surnames_l_j;
		surnames_l_s := SORT(surnames_l_d, name_last, hash(prim_name,v_city_name,phone10));
		Layouts.f_layout_num numberGroupsL(Layouts.f_layout_num l, Layouts.f_layout_num r) := TRANSFORM
			SELF.num := IF(l.name_last <> r.name_last, 1, l.num+1);
			SELF := r;
		END;
		surnames_l_i := ITERATE(surnames_l_s, numberGroupsL(LEFT, RIGHT));
		surnames_l_filt := surnames_l_i(num<=freq_thold);
		surnames_l_did := DEDUP(SORT(surnames_l_filt(did<>0), did), did) + surnames_l_filt(did=0);
		surnames_lf_d := surnames_lf_j;
		surnames_lf_s := SORT(surnames_lf_d, name_last, name_first, hash(prim_name,v_city_name,phone10));
		Layouts.f_layout_num numberGroupsLF(Layouts.f_layout_num l, Layouts.f_layout_num r) := TRANSFORM
			SELF.num := IF((l.name_last <> r.name_last or l.name_first <> r.name_first), 1, l.num+1);
			SELF := r;
		END;
		surnames_lf_i := ITERATE(surnames_lf_s, numberGroupsLF(LEFT, RIGHT));
		surnames_lf_filt := surnames_lf_i(num<=freq_thold);
		surnames_lf_did := DEDUP(SORT(surnames_lf_filt(did<>0), did), did) + surnames_lf_filt(did=0);

		surnames_ls_d := surnames_ls_j;
		surnames_ls_s := SORT(surnames_ls_d, name_last, st, hash(prim_name,v_city_name,phone10));

		Layouts.f_layout_num numberGroupsLS(Layouts.f_layout_num l, Layouts.f_layout_num r) := TRANSFORM
			SELF.num := IF((l.name_last <> r.name_last or l.st <> r.st), 1, l.num+1);
			SELF := r;
		END;
		surnames_ls_i := ITERATE(surnames_ls_s, numberGroupsLS(LEFT, RIGHT));
		surnames_ls_filt := surnames_ls_i(num<=freq_thold);
		surnames_ls_did := DEDUP(SORT(surnames_ls_filt(did<>0), did), did) + surnames_ls_filt(did=0);

		surnames_lfs_d := surnames_lfs_j;
		surnames_lfs_s := SORT(surnames_lfs_d, name_last, name_first, st, hash(prim_name,v_city_name,phone10));

		Layouts.f_layout_num numberGroupsLFS(Layouts.f_layout_num l, Layouts.f_layout_num r) := TRANSFORM
			SELF.num := IF((l.name_last <> r.name_last or l.name_first <> r.name_first or l.st <> r.st), 1, l.num+1);
			SELF := r;
		END;
		surnames_lfs_i := ITERATE(surnames_lfs_s, numberGroupsLFS(LEFT, RIGHT));
		surnames_lfs_filt := surnames_lfs_i(num<=freq_thold);
		surnames_lfs_did := DEDUP(SORT(surnames_lfs_filt(did<>0), did), did) + surnames_lfs_filt(did=0);
		surnames_l_dd := DEDUP(GROUP(SORT(surnames_l_did, name_last, name_first, prim_name, v_city_name, phone10[4..10], did), name_last),true, KEEP keep_val); 
		surnames_lf_dd := DEDUP(GROUP(SORT(surnames_lf_did, name_last, name_first, prim_name, v_city_name, phone10[4..10], did), name_last, name_first), true, KEEP keep_val); 
		surnames_ls_dd := DEDUP(GROUP(SORT(surnames_ls_did, name_last, st, name_first, prim_name, v_city_name, phone10[4..10], did), name_last, st), true, KEEP keep_val); 
		surnames_lfs_dd := DEDUP(GROUP(SORT(surnames_lfs_did, name_last, name_first, st, prim_name, v_city_name, phone10[4..10], did), name_last, name_first, st),true, KEEP keep_val); 
		surnames_l_final := PROJECT(surnames_l_dd, Layouts.f_layout_cnt);
		surnames_lf_final := PROJECT(surnames_lf_dd, Layouts.f_layout_cnt);
		surnames_ls_final := PROJECT(surnames_ls_dd, Layouts.f_layout_cnt);
		surnames_lfs_final := PROJECT(surnames_lfs_dd, Layouts.f_layout_cnt);
	EXPORT file_history_surname := surnames_l_final + surnames_lf_final + surnames_ls_final + surnames_lfs_final;