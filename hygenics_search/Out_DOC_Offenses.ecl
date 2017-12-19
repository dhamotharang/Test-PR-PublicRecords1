import hygenics_crim, PromoteSupers, hygenics_crim,doxie_build,STD;

fcra_v1 				:= Offenses_DOC_Joined;

fcra_filtered		:= fcra_v1(vendor in hygenics_search.sCourt_Vendors_To_Omit);
fcra_all				:= fcra_v1(vendor not in hygenics_search.sCourt_Vendors_To_Omit);

//Remove FCRA related information from non-updating sources
hygenics_crim.Layout_Base_Offenses_with_OffenseCategory removeInfo(fcra_filtered l):= transform
	  self.fcra_offense_key 							:= '';
		self.fcra_conviction_flag						:= '';
		self.fcra_traffic_flag							:= '';
		self.fcra_date											:= '';
		self.fcra_date_type									:= '';
		self.conviction_override_date				:= '';
		self.conviction_override_date_type	:= '';
		self.offense_score									:= '';
		self 																:= l;
	end;
	
ds_fcra_filtered := project(fcra_filtered, removeInfo(left));
ds_fcra_all			 := fcra_all;

offns				 		:= ds_fcra_filtered + ds_fcra_all;

hygenics_crim.Layout_Base_Offenses_with_OffenseCategory addDOPID(offns l):= transform

	filterField(String s) := FUNCTION
		return StringLib.StringFilter(StringLib.StringToUpperCase(s),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ');
	END;
	
			Voff_date 				:= filterField(l.off_date );
			//Vcase_num 				:= filterField(l.case_num);
			Voff_code 				:= filterField(l.off_code );
			Voff_desc_1 			:= filterField(l.off_desc_1 );
			Voff_desc_2 			:= filterField(l.off_desc_2 );
			Voff_typ 					:= filterField(l.off_typ );
			Voff_lev 					:= filterField(l.off_lev );
			Varr_date 				:= filterField(l.arr_date);
			Vstc_desc_1 			:= filterField(l.stc_desc_1);
			Vstc_desc_2 			:= filterField(l.stc_desc_2);
			Vstc_desc_3 			:= filterField(l.stc_desc_3);
			Vstc_desc_4 			:= filterField(l.stc_desc_4);
			Vmin_term 				:= filterField(l.min_term);
			Vmin_term_desc 		:= filterField(l.min_term_desc);
			Vmax_term 				:= filterField(l.max_term);
			Vmax_term_desc 		:= filterField(l.max_term_desc);
			Vparole 					:= filterField(l.parole);
			Voffensetown 			:= filterField(l.offensetown);
			Vstc_dt 					:= filterField(l.stc_dt);
			Vprobation 				:= filterField(l.probation);
			Vinc_adm_dt 			:= filterField(l.inc_adm_dt);
			//Vcounty_of_origin := filterField(l.county_of_origin);
			Vct_disp_dt				:= filterField(l.ct_disp_dt);
			Vct_disp_desc_1		:= filterField(l.ct_disp_desc_1);
			Vcty_conv 				:= filterField(l.cty_conv);
			Vconvict_dt 			:= filterField(l.convict_dt);
			Vstc_comp 				:= filterField(l.stc_comp);
			Vstc_lgth_desc 		:= filterField(l.stc_lgth_desc);
			Vnum_of_counts 		:= filterField(l.num_of_counts);
			Vchg 							:= filterField(l.chg);			
	
			self.offense_persistent_id 				:= hash64(trim(l.offender_key, left, right) + 
																									Voff_date + 
																									trim(l.case_num, left, right) +
																									Voff_code + 
																									Voff_desc_1 + 
																									Voff_desc_2 + 
																									Voff_typ + 
																									Voff_lev + 
																									Varr_date +
																									Vstc_desc_1 +
																									Vstc_desc_2 +
																									Vstc_desc_3 +
																									Vstc_desc_4 +
																									Vmin_term +
																									Vmin_term_desc +
																									Vmax_term +
																									Vmax_term_desc +
																									Vparole +
																									Voffensetown +
																									Vstc_dt +
																									Vprobation +
																									Vinc_adm_dt +
																									//Vcounty_of_origin +
																									Vct_disp_dt +
																									Vct_disp_desc_1 +
																									Vcty_conv +
																									Vconvict_dt +
																									Vstc_comp +
																									Vstc_lgth_desc +
																									Vnum_of_counts +
																									Vchg);	
    self.offense_category               := MAP(  l.off_desc_1 = 'NOT SPECIFIED' =>hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Other),
		                                             hygenics_crim._fns_offense_category.set_offense_category(stringlib.stringtouppercase(l.off_desc_1))
																								 );																									
		self := l;
	end;

all_files := project(offns, addDOPID(left));

all_files tJoinForOffensecategory(all_files L, hygenics_search.Offense_Category.Layout_Lookup R) := transform
    self.offense_category   := MAP(//R.Category = 'GLOBAL' => hygenics_crim._fn_Multiple_categoryToBitmapj('OTHER'),
		                               R.Category <> ''      => hygenics_crim._fn_Multiple_categoryToBitmap(STD.Str.Filter(R.Category, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ_')),
																	 L.offense_category
																	 );  
		self										:=	L;
end;
	
all_files2	:= join(all_files(offense_category =0 or offense_category = 2199023255552),
                      hygenics_search.Offense_Category.File_Lookup,
																					trim(left.off_desc_1) = trim(right.Offese_desc),
																					tJoinForOffensecategory(left,right),
																					left outer, lookup);
																					
all_files3 := all_files2 + all_files(offense_category <>0 and offense_category <> 2199023255552);

	PromoteSupers.MAC_SF_BuildProcess(all_files3,'~thor_data400::base::corrections_offenses_' + doxie_build.buildstate, aout, 2, ,true);
				 
export Out_DOC_Offenses := aout;