import Crim_common, Address, Ut, lib_stringlib;
// Transforms
input := DOC.file_doc_nv.cmbndFiles;


crim_common.Layout_In_DOC_Offenses.previous tnv(input l) := transform

	self.process_date := Crim_Common.Version_In_DOC_Offender;
	self.offender_key := 'NV' +  l.offender_id; 
	self.vendor := 'NV';
	self.source_file := 'NV-DOC';
	self.offense_key := 'NV' +  l.offender_id;
	self.off_date := '';
	self.arr_date := '';
	self.case_num := '';
	self.num_of_counts := '';
	self.off_code := l.offense_code;
	self.chg := '';
	self.chg_typ_flg := '';
	self.off_desc_1 := l.offense_desc;
	self.off_desc_2 := '';
	self.add_off_cd := '';
	self.add_off_desc := '';
	self.off_typ := '';
	self.off_lev := '';
	self.arr_disp_date := '';
	self.arr_disp_cd := '';
	self.arr_disp_desc_1 := '';
	self.arr_disp_desc_2 := '';
	self.arr_disp_desc_3 := '';
	self.court_cd := '';
	self.court_desc := '';
	self.ct_dist := '';
	self.ct_fnl_plea_cd := '';
	self.ct_fnl_plea := '';
	self.ct_off_code := '';
	self.ct_chg := '';
	self.ct_chg_typ_flg := '';
	self.ct_off_desc_1 := l.offense_desc;
	self.ct_off_desc_2 := '';
	self.ct_addl_desc_cd := '';
	self.ct_off_lev := '';
	self.ct_disp_dt := '';
	self.ct_disp_cd := '';
	self.ct_disp_desc_1 := '';
	self.ct_disp_desc_2 := '';
	self.cty_conv_cd := '';
	self.cty_conv :=  '';
	self.adj_wthd := '';
	self.stc_dt := stringlib.stringfilter(l.sent_start_date,'0123456789');
	self.stc_cd := '';
	self.stc_comp := l.sent_seq;
	self.stc_desc_1 := '';
	self.stc_desc_2 := '';
	self.stc_desc_3 := '';
	self.stc_desc_4 := '';
	self.stc_lgth :='';
	self.stc_lgth_desc :='';
	self.inc_adm_dt := '';
	self.min_term := '';
	self.min_term_desc := if(l.sent_min_yrs = '', '', l.sent_min_yrs+' YEARS') 
						+ if(l.sent_min_mths = '', '', l.sent_min_mths+' MONTHS') 
						+ if(l.sent_min_days = '', '', l.sent_min_days+' DAYS');
	self.max_term := '';
	self.max_term_desc := if(l.sent_max_yrs = '', '', l.sent_max_yrs+' YEARS') 
						+ if(l.sent_max_mths = '', '', l.sent_max_mths+' MONTHS') 
						+ if(l.sent_max_days = '', '', l.sent_max_days+' DAYS');
end;

refFile := project(input(offense_desc <> ''), tnv(left));

outfile := dedup(sort(refFile, offender_key,off_date, off_desc_1, stc_dt, local)
							 , offender_key,off_date, off_desc_1, right,local): PERSIST('~thor_data400::persist::doc::map_nv_offenses');

export map_doc_nv_offenses := outfile;