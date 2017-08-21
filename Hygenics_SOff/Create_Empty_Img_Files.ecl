export Create_Empty_Img_Files(string file_date):= function

//Creates placeholders for sprayed batch files

  filedate 	:= StringLib.StringFilter(file_date, '0123456789');

  export JPEG(INTEGER len) := TYPE
		EXPORT DATA LOAD(DATA Dd) := Dd[1..len];
		EXPORT DATA STORE(DATA Dd) := Dd[1..len];
		EXPORT INTEGER PHYSICALLENGTH(DATA Dd) := len;
	END;

	injpg := RECORD, MAXLENGTH(100000000)
		STRING   filename;
		UNSIGNED4 imgLength;
		JPEG(SELF.imgLength) photo;
	END;

	ds1 := dataset('~images::in::sexoffender_ak', injpg, flat);
	
return sequential(	
	output(ds1,, '~images::in::sexoffender_ak_'+filedate),
	output(ds1,, '~images::in::sexoffender_al_'+filedate),
	output(ds1,, '~images::in::sexoffender_ar_'+filedate),
	output(ds1,, '~images::in::sexoffender_az_'+filedate),
	output(ds1,, '~images::in::sexoffender_ca_'+filedate),
	output(ds1,, '~images::in::sexoffender_co_'+filedate),
	output(ds1,, '~images::in::sexoffender_ct_'+filedate),
	output(ds1,, '~images::in::sexoffender_dc_'+filedate),
	output(ds1,, '~images::in::sexoffender_de_'+filedate),
	output(ds1,, '~images::in::sexoffender_fl_'+filedate),
	output(ds1,, '~images::in::sexoffender_ga_'+filedate),
	output(ds1,, '~images::in::sexoffender_hi_'+filedate),
	output(ds1,, '~images::in::sexoffender_ia_'+filedate),
	output(ds1,, '~images::in::sexoffender_id_'+filedate),
	output(ds1,, '~images::in::sexoffender_il_'+filedate),
	output(ds1,, '~images::in::sexoffender_in_'+filedate),
	output(ds1,, '~images::in::sexoffender_ks_'+filedate),
	output(ds1,, '~images::in::sexoffender_ky_'+filedate),
	output(ds1,, '~images::in::sexoffender_la_'+filedate),
	output(ds1,, '~images::in::sexoffender_ma_'+filedate),
	output(ds1,, '~images::in::sexoffender_md_'+filedate),
	output(ds1,, '~images::in::sexoffender_me_'+filedate),
	output(ds1,, '~images::in::sexoffender_mi_'+filedate),
	output(ds1,, '~images::in::sexoffender_mn_'+filedate),
	output(ds1,, '~images::in::sexoffender_mo_'+filedate),
	output(ds1,, '~images::in::sexoffender_ms_'+filedate),
	output(ds1,, '~images::in::sexoffender_mt_'+filedate),
	output(ds1,, '~images::in::sexoffender_nc_'+filedate),
	output(ds1,, '~images::in::sexoffender_nd_'+filedate),
	output(ds1,, '~images::in::sexoffender_ne_'+filedate),
	output(ds1,, '~images::in::sexoffender_nh_'+filedate),
	output(ds1,, '~images::in::sexoffender_nj_'+filedate),
	output(ds1,, '~images::in::sexoffender_nm_'+filedate),
	output(ds1,, '~images::in::sexoffender_nv_'+filedate),
	output(ds1,, '~images::in::sexoffender_ny_'+filedate),
	output(ds1,, '~images::in::sexoffender_oh_'+filedate),
	output(ds1,, '~images::in::sexoffender_ok_'+filedate),
	output(ds1,, '~images::in::sexoffender_or_'+filedate),
	output(ds1,, '~images::in::sexoffender_pa_'+filedate),
	output(ds1,, '~images::in::sexoffender_ri_'+filedate),
	output(ds1,, '~images::in::sexoffender_sc_'+filedate),
	output(ds1,, '~images::in::sexoffender_sd_'+filedate),
	output(ds1,, '~images::in::sexoffender_tn_'+filedate),
	output(ds1,, '~images::in::sexoffender_tx_'+filedate),
	output(ds1,, '~images::in::sexoffender_ut_'+filedate),
	output(ds1,, '~images::in::sexoffender_va_'+filedate),
	output(ds1,, '~images::in::sexoffender_vt_'+filedate),
	output(ds1,, '~images::in::sexoffender_wa_'+filedate),
	output(ds1,, '~images::in::sexoffender_wi_'+filedate),
	output(ds1,, '~images::in::sexoffender_wv_'+filedate),
	output(ds1,, '~images::in::sexoffender_wy_'+filedate),
	output(ds1,, '~images::in::sexoffender_gu_'+filedate),
	output(ds1,, '~images::in::sexoffender_pr_'+filedate)
	);

end;