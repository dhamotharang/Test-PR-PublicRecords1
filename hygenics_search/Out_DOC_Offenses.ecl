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
			Vstc_lgth       	:= filterField(l.stc_lgth);
			Vstc_lgth_desc 		:= filterField(l.stc_lgth_desc);
			Vnum_of_counts 		:= filterField(l.num_of_counts);
			Vchg 							:= filterField(l.chg);			
			Vcourt_desc 			:= filterField(l.court_desc);		
			Vadd_off_desc 			:= filterField(l.add_off_desc);				
	
			self.offense_persistent_id 				:= hash64(trim(l.offender_key, left, right) + 
                                           Voff_date + 
                                           trim(l.case_num, left, right) +
                                           Voff_code + 'X' +
                                           Voff_desc_1 + 
                                           Voff_desc_2 + 'X' + 
                                           Voff_typ + 
                                           Voff_lev + 
                                           Varr_date +
                                           Vstc_desc_1 + 'X' +
                                           Vstc_desc_2 +
                                           Vstc_desc_3 +
                                           Vstc_desc_4 +
                                           Vmin_term + 'X' +
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
                                           Vstc_lgth + //new
                                           Vstc_lgth_desc +
                                           Vnum_of_counts +
                                           Vchg+
                                           Vcourt_desc+ //new
                                           Vadd_off_desc); //new
                                           
    // self.offense_category               := MAP(  l.off_desc_1 = 'NOT SPECIFIED' =>hygenics_crim._functions.category_to_bitmap(hygenics_crim._functions.ctg_Other),
		                                             // hygenics_crim._fns_offense_category.set_offense_category(stringlib.stringtouppercase(l.off_desc_1))
																								 // );																									
		self := l;
	end;

DOC_offense := project(offns, addDOPID(left));

dist_doc_offense := TABLE(DOC_offense ,{off_desc_1, count_ := count(group)},off_desc_1,few );				

DOCLayoutWithOffenseCategory := record
dist_doc_offense;
unsigned8  offense_category;
end;	

DOCLayoutWithOffenseCategory addCatdoc(dist_DOC_offense l):= transform
    off_desc_1          := stringlib.stringtouppercase(l.off_desc_1);
    court_category      := hygenics_crim._fns_offense_category.set_offense_category(stringlib.stringtouppercase(off_desc_1));		
	  court_Global        := hygenics_crim._fns_offense_category.set_offense_category_Global(off_desc_1);
		court_traffic       := hygenics_crim._fns_offense_category.set_offense_category_traffic(off_desc_1);
		court_other         := hygenics_crim._fns_offense_category.set_offense_category_other(off_desc_1); 
		
		self.offense_category                   := MAP(l.off_desc_1 = 'NOT SPECIFIED'     => 0,
																									 Court_Global <> 0                        => Court_Global,
																									 court_category <> 0                      => court_category,
                                                   court_traffic <>0                        => court_traffic,
																								   court_other <>0                          => court_other,
																									 0 );																																		
		self := l;
	end;
	DOCWithCat  := project(dist_DOC_offense,  addCatdoc(left));

DOC_offense Joincopycategorydoc1(DOC_offense l , DOCWithCat r):= transform
self.offense_Category := r.offense_category;
self := l;
end;

all_files := join( distribute(DOC_offense,HASH32(off_desc_1)),DOCWithCat,
                         left.off_desc_1 = right.off_desc_1,Joincopycategorydoc1(left,right),lookup);

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

/*************************************Final Dedup and rollup to make persistent key unique******************************************/
result_sort 	:= sort(distribute(all_files3,HASH(offender_key,vendor,source_file,offense_persistent_id)),
                                     process_date,offender_key,offense_persistent_id,vendor, source_file, off_date, arr_date, case_num, 
 																		 StringLib.StringFilter(StringLib.StringToUpperCase(off_code),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
																		 chg, chg_typ_flg, 
																		 StringLib.StringFilter(StringLib.StringToUpperCase(off_desc_1+off_desc_2),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
																		 add_off_cd, add_off_desc, off_typ, off_lev,
                                     arr_disp_date, arr_disp_cd, arr_disp_desc_1, arr_disp_desc_2, arr_disp_desc_3, court_cd, 
																		 StringLib.StringFilter(StringLib.StringToUpperCase(court_desc),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
                                     ct_dist, ct_fnl_plea_cd, ct_fnl_plea, ct_off_code, ct_chg, ct_chg_typ_flg, ct_off_desc_1, ct_off_desc_2,
                                     ct_addl_desc_cd, ct_off_lev, ct_disp_dt, ct_disp_cd, 
                                     StringLib.StringFilter(StringLib.StringToUpperCase(ct_disp_desc_1+ct_disp_desc_2),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),																		 
																		 cty_conv_cd,
                                     cty_conv, adj_wthd,trim(stc_dt),stc_comp,
																		 StringLib.StringFilter(StringLib.StringToUpperCase(stc_desc_1),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
																		 StringLib.StringFilter(StringLib.StringToUpperCase(stc_desc_2),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
																		 StringLib.StringFilter(StringLib.StringToUpperCase(stc_desc_3),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
																		 StringLib.StringFilter(StringLib.StringToUpperCase(stc_desc_4),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
                                     stc_lgth, 
																		 StringLib.StringFilter(StringLib.StringToUpperCase(stc_lgth_desc),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
																		 inc_adm_dt, min_term, 
                                     StringLib.StringFilter(StringLib.StringToUpperCase(min_term_desc),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),																		 
																		 max_term, 
                                     StringLib.StringFilter(StringLib.StringToUpperCase(max_term_desc),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
																		 StringLib.StringFilter(StringLib.StringToUpperCase(parole),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
																		 StringLib.StringFilter(StringLib.StringToUpperCase(probation),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),																		 
																		 StringLib.StringFilter(StringLib.StringToUpperCase(offensetown),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),	
																		 StringLib.StringFilter(StringLib.StringToUpperCase(convict_dt),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),	
																		 StringLib.StringFilter(StringLib.StringToUpperCase(Court_County),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),	
																		 fcra_conviction_flag, fcra_traffic_flag, fcra_date, fcra_date_type, 
	                                   conviction_override_date, conviction_override_date_type, offense_score, offense_category,
																		 local); 
 
result_dedup 	:= dedup(result_sort,  process_date,offender_key,offense_persistent_id,vendor, source_file, off_date, arr_date, case_num, 
 																		 StringLib.StringFilter(StringLib.StringToUpperCase(off_code),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
																		 chg, chg_typ_flg, 
																		 StringLib.StringFilter(StringLib.StringToUpperCase(off_desc_1+off_desc_2),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
																		 add_off_cd, add_off_desc, off_typ, off_lev,
                                     arr_disp_date, arr_disp_cd, arr_disp_desc_1, arr_disp_desc_2, arr_disp_desc_3, court_cd, 
																		 StringLib.StringFilter(StringLib.StringToUpperCase(court_desc),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
                                     ct_dist, ct_fnl_plea_cd, ct_fnl_plea, ct_off_code, ct_chg, ct_chg_typ_flg, ct_off_desc_1, ct_off_desc_2,
                                     ct_addl_desc_cd, ct_off_lev, ct_disp_dt, ct_disp_cd, 
                                     StringLib.StringFilter(StringLib.StringToUpperCase(ct_disp_desc_1+ct_disp_desc_2),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),																		 
																		 cty_conv_cd,
                                     cty_conv, adj_wthd,trim(stc_dt),stc_comp,
																		 StringLib.StringFilter(StringLib.StringToUpperCase(stc_desc_1),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
																		 StringLib.StringFilter(StringLib.StringToUpperCase(stc_desc_2),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
																		 StringLib.StringFilter(StringLib.StringToUpperCase(stc_desc_3),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
																		 StringLib.StringFilter(StringLib.StringToUpperCase(stc_desc_4),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
                                     stc_lgth, 
																		 StringLib.StringFilter(StringLib.StringToUpperCase(stc_lgth_desc),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
																		 inc_adm_dt, min_term, 
                                     StringLib.StringFilter(StringLib.StringToUpperCase(min_term_desc),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),																		 
																		 max_term, 
                                     StringLib.StringFilter(StringLib.StringToUpperCase(max_term_desc),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
																		 StringLib.StringFilter(StringLib.StringToUpperCase(parole),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
																		 StringLib.StringFilter(StringLib.StringToUpperCase(probation),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),																		 
																		 StringLib.StringFilter(StringLib.StringToUpperCase(offensetown),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),	
																		 StringLib.StringFilter(StringLib.StringToUpperCase(convict_dt),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),	
																		 StringLib.StringFilter(StringLib.StringToUpperCase(Court_County),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),	
																		 fcra_conviction_flag, fcra_traffic_flag, fcra_date, fcra_date_type, 
	                                   conviction_override_date, conviction_override_date_type, offense_score, offense_category,
																		 local
																		 ) ;
																		 
result_sort2 	:= sort(result_dedup,  offender_key,offense_persistent_id, vendor, source_file, off_date, case_num,
																		 StringLib.StringFilter(StringLib.StringToUpperCase(off_desc_1+off_desc_2),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
							  										 arr_date, chg, add_off_desc, off_typ, off_lev,
                                     arr_disp_date, arr_disp_desc_1, arr_disp_desc_2, 
																		 StringLib.StringFilter(StringLib.StringToUpperCase(court_desc),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
                                     ct_fnl_plea, ct_disp_dt, ct_disp_cd, ct_disp_desc_1, ct_disp_desc_2, 
																		 cty_conv, adj_wthd, trim(stc_dt), stc_desc_1, stc_desc_2, stc_desc_3, stc_desc_4,
                                     stc_lgth, stc_lgth_desc, inc_adm_dt, min_term, min_term_desc, max_term, 
																		 StringLib.StringFilter(StringLib.StringToUpperCase(max_term_desc),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
																		 StringLib.StringFilter(StringLib.StringToUpperCase(parole),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
																		 StringLib.StringFilter(StringLib.StringToUpperCase(probation),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),																		 
																		 StringLib.StringFilter(StringLib.StringToUpperCase(offensetown),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),	
																		 StringLib.StringFilter(StringLib.StringToUpperCase(convict_dt),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),	
																		 StringLib.StringFilter(StringLib.StringToUpperCase(Court_County),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),	 
																		 fcra_conviction_flag, fcra_traffic_flag, fcra_date, fcra_date_type, 
	                                   conviction_override_date, conviction_override_date_type, offense_score, offense_category,local);																		 

result_sort2 rollupCrim(result_sort2 L, result_sort2 R) := TRANSFORM
                self.arr_date             := if(l.arr_date              = '', r.arr_date       ,l.arr_date);
                self.chg                  := if(l.chg                   = '', r.chg            ,l.chg);								
								self.add_off_desc         := if(l.add_off_desc          = '', r.add_off_desc   ,l.add_off_desc);
								self.off_typ              := if(l.off_typ               = '', r.off_typ        , l.off_typ);			
                self.off_lev              := if(l.off_lev               = '', r.off_lev        , l.off_lev);								
                self.arr_disp_date        := if(l.arr_disp_date         = '', r.arr_disp_date  , l.arr_disp_date); 
                self.arr_disp_desc_1      := if(l.arr_disp_desc_1       = '', r.arr_disp_desc_1, l.arr_disp_desc_1); 
                self.arr_disp_desc_2      := if(l.arr_disp_desc_2       = '', r.arr_disp_desc_2, l.arr_disp_desc_2); 								
								self.court_desc           := if(l.court_desc            = '', r.court_desc     , l.court_desc);								
                self.ct_fnl_plea          := if(l.ct_fnl_plea           = '', r.ct_fnl_plea    , l.ct_fnl_plea);
                self.ct_disp_dt           := if(l.ct_disp_dt            = '', r.ct_disp_dt     , l.ct_disp_dt);
                self.ct_disp_cd           := if(l.ct_disp_cd            = '', r.ct_disp_cd     , l.ct_disp_cd);
                self.ct_disp_desc_1       := if(l.ct_disp_desc_1        = '', r.ct_disp_desc_1 , l.ct_disp_desc_1);
                self.ct_disp_desc_2       := if(l.ct_disp_desc_2        = '', r.ct_disp_desc_2 , l.ct_disp_desc_2);
                self.cty_conv             := if(l.cty_conv              = '', r.cty_conv       , l.cty_conv);
								self.adj_wthd             := if(l.adj_wthd              = '', r.adj_wthd       , l.adj_wthd);                
                self.stc_dt               := if(l.stc_dt                = '', r.stc_dt         , l.stc_dt);
                self.stc_desc_1           := if(l.stc_desc_1            = '', r.stc_desc_1     , l.stc_desc_1);
								self.stc_desc_2           := if(l.stc_desc_2            = '', r.stc_desc_2     , l.stc_desc_2);
								self.stc_desc_3           := if(l.stc_desc_3            = '', r.stc_desc_3     , l.stc_desc_3);
								self.stc_desc_4           := if(l.stc_desc_4            = '', r.stc_desc_4     , l.stc_desc_4);								
								self.stc_lgth             := if(l.stc_lgth              = '', r.stc_lgth       , l.stc_lgth);
								self.stc_lgth_desc        := if(l.stc_lgth_desc         = '', r.stc_lgth_desc  , l.stc_lgth_desc);
								self.inc_adm_dt           := if(l.inc_adm_dt            = '', r.inc_adm_dt     , l.inc_adm_dt);
								self.min_term             := if(l.min_term              = '', r.min_term       , l.min_term);
								self.min_term_desc        := if(l.min_term_desc         = '', r.min_term_desc  , l.min_term_desc);
								self.max_term             := if(l.max_term              = '', r.max_term       , l.max_term);
								self.max_term_desc        := if(l.max_term_desc         = '', r.max_term_desc  , l.max_term_desc);																																																																
                self.parole               := if(l.parole                = '', r.parole         , l.parole);
								self.probation            := if(l.probation             = '', r.probation      , l.probation);
								self.offensetown          := if(l.offensetown           = '', r.offensetown    , l.offensetown);
								self.convict_dt           := if(l.convict_dt            = '', r.convict_dt     , l.convict_dt); 
								self.Court_County                  :=  if(l.Court_County                 = '', r.Court_County                 , l.Court_County                 );
								self.fcra_conviction_flag          :=  if(l.fcra_conviction_flag         = '', r.fcra_conviction_flag         , l.fcra_conviction_flag         );
								self.fcra_traffic_flag             :=  if(l.fcra_traffic_flag            = '', r.fcra_traffic_flag            , l.fcra_traffic_flag            );
								self.fcra_date                     :=  if(l.fcra_date                    = '', r.fcra_date                    , l.fcra_date                    );
								self.fcra_date_type                :=  if(l.fcra_date_type               = '', r.fcra_date_type               , l.fcra_date_type               );
								self.conviction_override_date      :=  if(l.conviction_override_date     = '', r.conviction_override_date     , l.conviction_override_date     );
								self.conviction_override_date_type :=  if(l.conviction_override_date_type= '', r.conviction_override_date_type, l.conviction_override_date_type);
								self.offense_score                 :=  if(l.offense_score                = '', r.offense_score                , l.offense_score                );
								self.offense_category              :=  if(l.offense_category             = 0 , r.offense_category             , l.offense_category             );
								       
								
                SELF   := L; 
END;														 

rollupoffenseOut := ROLLUP(result_sort2,  
              left.offender_key = right.offender_key and 
							left.offense_persistent_id = right.offense_persistent_id and
              trim(left.vendor)       = trim(right.vendor) and 
							trim(left.source_file)  = trim(right.source_file) and 
							StringLib.StringFilter(StringLib.StringToUpperCase(left.off_desc_1+left.off_desc_2),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ')   = StringLib.StringFilter(StringLib.StringToUpperCase(right.off_desc_1+right.off_desc_2),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ') and 
							trim(left.off_date)     = trim(Right.off_date) and 
							trim(left.case_num)     = trim(right.case_num) and 
							(left.arr_date          = right.arr_date       or   right.arr_date       ='' or left.arr_date       ='') and 
							(left.chg               = right.chg            or   right.chg            ='' or left.chg            ='') and
              (left.add_off_desc      = right.add_off_desc   or   right.add_off_desc   ='' or left.add_off_desc   ='') and 
							(left.off_typ           = right.off_typ        or   right.off_typ        ='' or left.off_typ        ='') and
							(left.off_lev           = right.off_lev        or   right.off_lev        ='' or left.off_lev        ='') and
							(left.arr_disp_date     = right.arr_disp_date   or   right.arr_disp_date   ='' or left.arr_disp_date        ='') and
							(left.arr_disp_desc_1   = right.arr_disp_desc_1 or   right.arr_disp_desc_1 ='' or left.arr_disp_desc_1        ='') and
							(left.arr_disp_desc_2   = right.arr_disp_desc_2 or   right.arr_disp_desc_2 ='' or left.arr_disp_desc_2        ='') and
							(StringLib.StringFilter(StringLib.StringToUpperCase(left.court_desc),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ') = StringLib.StringFilter(StringLib.StringToUpperCase(right.court_desc),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ') or   right.court_desc     ='' or left.court_desc     ='') and
							(left.ct_fnl_plea       = right.ct_fnl_plea     or   right.ct_fnl_plea    ='' or left.ct_fnl_plea    ='') and   
							(left.ct_disp_dt        = right.ct_disp_dt      or   right.ct_disp_dt     ='' or left.ct_disp_dt     ='') and
							(left.ct_disp_cd        = right.ct_disp_cd      or   right.ct_disp_cd     ='' or left.ct_disp_cd     ='') and
							(left.ct_disp_desc_1    = right.ct_disp_desc_1  or   right.ct_disp_desc_1 ='' or left.ct_disp_desc_1 ='') and
							(left.ct_disp_desc_2    = right.ct_disp_desc_2  or   right.ct_disp_desc_2 ='' or left.ct_disp_desc_2 ='') and    
							(left.cty_conv          = right.cty_conv        or   right.cty_conv       ='' or left.cty_conv       ='') and  
							(left.adj_wthd          = right.adj_wthd        or   right.adj_wthd       ='' or left.adj_wthd       ='') and  
							(left.stc_dt            = right.stc_dt          or   right.stc_dt         ='' or left.stc_dt         ='') and    
              (left.stc_desc_1        = right.stc_desc_1      or   right.stc_desc_1     ='' or left.stc_desc_1        ='') and
              (left.stc_desc_2        = right.stc_desc_2      or   right.stc_desc_2     ='' or left.stc_desc_2        ='') and
              (left.stc_desc_3        = right.stc_desc_3      or   right.stc_desc_3     ='' or left.stc_desc_3        ='') and
              (left.stc_desc_4        = right.stc_desc_4      or   right.stc_desc_4     ='' or left.stc_desc_4        ='') and        
              (left.stc_lgth          = right.stc_lgth        or   right.stc_lgth       ='' or left.stc_lgth          ='') and 
              (left.stc_lgth_desc     = right.stc_lgth_desc   or   right.stc_lgth_desc  ='' or left.stc_lgth_desc     ='') and 
              (left.inc_adm_dt        = right.inc_adm_dt      or   right.inc_adm_dt     ='' or left.inc_adm_dt        ='') and 
			        (left.min_term          = right.min_term        or   right.min_term       ='' or left.min_term          ='') and 
			        (left.min_term_desc     = right.min_term_desc   or   right.min_term_desc  ='' or left.min_term_desc     ='') and 
			        (left.max_term          = right.max_term        or   right.max_term       ='' or left.max_term          ='') and 
			        (StringLib.StringFilter(StringLib.StringToUpperCase(left.max_term_desc),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ')= StringLib.StringFilter(StringLib.StringToUpperCase(right.max_term_desc),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ')  or   right.max_term_desc  ='' or left.max_term_desc     ='') and 
		          (StringLib.StringFilter(StringLib.StringToUpperCase(left.parole),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ')       = StringLib.StringFilter(StringLib.StringToUpperCase(right.parole),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ')       or   right.parole         ='' or left.parole            ='') and  
              (StringLib.StringFilter(StringLib.StringToUpperCase(left.probation),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ')    = StringLib.StringFilter(StringLib.StringToUpperCase(right.probation),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ')    or   right.probation      ='' or left.probation    ='') and 
              (StringLib.StringFilter(StringLib.StringToUpperCase(left.offensetown),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ')  = StringLib.StringFilter(StringLib.StringToUpperCase(right.offensetown) ,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ') or   right.offensetown    ='' or left.offensetown  ='') and  
              (StringLib.StringFilter(StringLib.StringToUpperCase(left.convict_dt),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ')   = StringLib.StringFilter(StringLib.StringToUpperCase(right.convict_dt)  ,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ') or   right.convict_dt     ='' or left.convict_dt   ='') and 							
              (StringLib.StringFilter(StringLib.StringToUpperCase(left.Court_County),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ') = StringLib.StringFilter(StringLib.StringToUpperCase(right.Court_County),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ') or   right.Court_County   ='' or left.Court_County ='') and 
							(left.fcra_conviction_flag      = right.fcra_conviction_flag     or   right.fcra_conviction_flag     ='' or left.fcra_conviction_flag     ='') and 
							(left.fcra_traffic_flag         = right.fcra_traffic_flag        or   right.fcra_traffic_flag        ='' or left.fcra_traffic_flag        ='') and 
							(left.fcra_date                 = right.fcra_date                or   right.fcra_date                ='' or left.fcra_date                ='') and 
							(left.fcra_date_type            = right.fcra_date_type           or   right.fcra_date_type           ='' or left.fcra_date_type           ='') and 
							(left.conviction_override_date  = right.conviction_override_date or   right.conviction_override_date ='' or left.conviction_override_date ='') and 
							(left.conviction_override_date_type = right.conviction_override_date_type or   right.conviction_override_date_type ='' or left.conviction_override_date_type ='') and 
							(left.offense_score                 = right.offense_score                 or   right.offense_score                 ='' or left.offense_score                 ='') and 
							(left.offense_category              = right.offense_category              or   right.offense_category              =0  or left.offense_category              = 0), 
							rollupCrim(LEFT,RIGHT),local) : persist ('~thor200_144::persist::hygenics::RolledupDOCoffenses');							



/*************************************End******************************************/

	PromoteSupers.MAC_SF_BuildProcess(rollupoffenseOut,'~thor_data400::base::corrections_offenses_' + doxie_build.buildstate, aout, 2, ,true);
				 
export Out_DOC_Offenses := aout;