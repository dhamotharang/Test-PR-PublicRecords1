import ut, doxie_build, corrections, hygenics_crim;

df2 := hygenics_crim.AllOffenses;

df2sd := dedup(sort(df2,
		process_date,
		offender_key,
		vendor,
		county_of_origin,
		source_file,
		record_type,
		orig_state,
		offense_key,
		off_date,
		arr_date,
		case_num,
		-num_of_counts,
		off_code,
		chg,
		chg_typ_flg,
		off_desc_1,
		off_desc_2,
		add_off_cd,
		add_off_desc,
		off_typ,
		off_lev,
		arr_disp_date,
		arr_disp_cd,
		arr_disp_desc_1,
		arr_disp_desc_2,
		arr_disp_desc_3,
		court_cd,
		court_desc,
		ct_dist,
		ct_fnl_plea_cd,
		ct_fnl_plea,
		ct_off_code,
		ct_chg,
		ct_chg_typ_flg,
		ct_off_desc_1,
		ct_off_desc_2,
		ct_addl_desc_cd,
		ct_off_lev,
		ct_disp_dt,
		ct_disp_cd,
		ct_disp_desc_1,
		ct_disp_desc_2,
		cty_conv_cd,
		cty_conv,
		adj_wthd,
		stc_dt,
		stc_cd,
		stc_desc_1,
		stc_desc_2,
		stc_desc_3,
		stc_desc_4,
		stc_lgth,
		stc_lgth_desc,
		inc_adm_dt,
		min_term,
		min_term_desc,
		max_term,
		max_term_desc,
		stc_comp),
	process_date,
	offender_key,
	vendor,
	county_of_origin,
	source_file,
	record_type,
	orig_state,
	offense_key,
	off_date,
	arr_date,
	case_num,
	num_of_counts,
	off_code,
	chg,
	chg_typ_flg,
	off_desc_1,
	off_desc_2,
	add_off_cd,
	add_off_desc,
	off_typ,
	off_lev,
	arr_disp_date,
	arr_disp_cd,
	arr_disp_desc_1,
	arr_disp_desc_2,
	arr_disp_desc_3,
	court_cd,
	court_desc,
	ct_dist,
	ct_fnl_plea_cd,
	ct_fnl_plea,
	ct_off_code,
	ct_chg,
	ct_chg_typ_flg,
	ct_off_desc_1,
	ct_off_desc_2,
	ct_addl_desc_cd,
	ct_off_lev,
	ct_disp_dt,
	ct_disp_cd,
	ct_disp_desc_1,
	ct_disp_desc_2,
	cty_conv_cd,
	cty_conv,
	adj_wthd,
	stc_dt,
	stc_cd,
	stc_desc_1,
	stc_desc_2,
	stc_desc_3,
	stc_desc_4,
	stc_lgth,
	stc_lgth_desc,
	inc_adm_dt,
	min_term,
	min_term_desc,
	max_term,
	max_term_desc,
	stc_comp);


ut.MAC_SF_BuildProcess(df2sd,'~thor_data400::base::corrections_offenses_' + doxie_build.buildstate,aout,2)

export proc_build_DOC_offenses := aout;