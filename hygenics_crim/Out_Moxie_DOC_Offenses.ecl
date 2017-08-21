import corrections, ut, hygenics_search, lib_stringlib;

	string8 fFixDate(string8 pDateIn) 	:= if(lib_stringlib.stringlib.StringFilter(pDateIn,'0123456789') <> pDateIn or (integer8)pDateIn = 0,
																						'',
																						pDateIn);
																						
//Combine LN DOC + Hygenics////////////////////////////////
  
	ln_doc  := hygenics_crim.File_In_DOC_Offenses;
		
	layout_common_doc_offenses_new := record
			hygenics_crim.Layout_Common_DOC_Offenses_orig;
			string2 orig_state;
	end;
	
	Layout_Common_DOC_Offenses_new newTran(ln_doc l):= transform
		  self.orig_state							:= l.vendor;
			self.parole 								:= '';
			self.probation 							:= '';
			self.offensetown 						:= '';
			self.convict_dt							:= '';
			self.court_county 					:= '';
			self.Hyg_classification_code:= '';
			
			self                        := l;
		end;
	
	ln_doc_rec 	:= project(ln_doc, newTran(left))(vendor in ['WA']);	
	
	hyg_doc			:= hygenics_crim.proc_build_DOC_offenses(vendor not in ['EP']);
	
	Layout_Common_DOC_Offenses_new newTran2(hyg_doc l):= transform
			self.orig_state							:= l.source_file[1..2];
			self := l;
	end;
	
	hyg_doc_rec := project(hyg_doc, newTran2(left));

	doc_concat_offense := ln_doc_rec + hyg_doc_rec;
	
	//Reformat to New DOC Offenses Layout 
	hygenics_crim.Layout_Base_Offenses_with_OffenseCategory tDOCOffensesInToOut(doc_concat_offense pInput):= transform
      self.data_type										:= '1';			
			self.record_type									:= '';
			self.orig_state										:= pInput.orig_state;
			self.total_num_of_offenses 				:= '';
			self.off_of_record 								:= '';
			self.fcra_offense_key 						:= '';
			self.fcra_conviction_flag 				:= '';
			self.fcra_traffic_flag 						:= '';
			self.fcra_date 										:= '';
			self.fcra_date_type 							:= '';
			self.conviction_override_date 		:= '';
			self.conviction_override_date_type := '';
			self.offense_score 								:= '';
			self.county_of_origin							:= pInput.cty_conv;
			self.off_date											:= fFixDate(pInput.off_date);
			self.arr_date											:= fFixDate(pInput.arr_date);
			self.arr_disp_date								:= fFixDate(pInput.arr_disp_date);
			self.ct_disp_dt										:= fFixDate(pInput.ct_disp_dt);
			self.stc_dt												:= fFixDate(pInput.stc_dt);
			self.offense_persistent_id 				:= 0;	
			self.offense_category             := 0;
			self.Old_LN_Offense_score         := '';
			self 															:= pInput;
	end;

	dDOCOffensesOut 		:= project(doc_concat_offense,tDOCOffensesInToOut(left));

	df_dedup := dedup(sort(dDOCOffensesOut, 
												process_date,
												offender_key,
												vendor,
												cty_conv,
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
												cty_conv,
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
												stc_comp):persist('~thor400_20::persist::doc_offenses2');
												
export Out_Moxie_DOC_Offenses := df_dedup;