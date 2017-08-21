//****************Function to rollup records with the same phone7_rec_key********************
import ut;
export Fn_Rollup_as_Phonesplus(dataset(recordof(Layout_In_Phonesplus.layout_in_common)) phplus_in) := function

phplus_in_s := sort(distribute(phplus_in, hash(phone7_rec_key)),phone7_rec_key, append_npa_effective_dt, append_npa_last_change_dt, local);

recordof(phplus_in) t_rollup(phplus_in_s le, phplus_in ri) := transform
	glb_priority(string1 flag)			:= map(flag = 'U' => 1,
											   flag = ''=> 2,
											   flag = 'G'=> 3,
											   flag = 'B'=> 4,
											   flag = 'D'=> 5,
											   1);
	prior_area_code						:= if(stringlib.stringContains(le.append_prior_area_code, ri.append_prior_area_code	, true),
											   le.append_prior_area_code	, 
											   le.append_prior_area_code	 + ', ' + ri.append_prior_area_code	);
	
	self.dt_first_seen					:= ut.EarliestDate(le.dt_first_seen, ri.dt_first_seen);
	self.dt_last_seen					:= ut.LatestDate(le.dt_last_seen, ri.dt_last_seen);
	self.dt_vendor_last_reported		:= ut.LatestDate(le.dt_vendor_last_reported, ri.dt_vendor_last_reported);
	self.dt_vendor_first_reported		:= ut.EarliestDate(le.dt_vendor_first_reported, ri.dt_vendor_first_reported);
	self.dt_nonglb_last_seen			:= ut.LatestDate(le.dt_nonglb_last_seen, ri.dt_nonglb_last_seen);
	//glb_dppa_flag     G=GLB, D=DPPA, B=Both, ''=Neither, 'U'=Utility	
	self.glb_dppa_flag					:= if(glb_priority(le.glb_dppa_flag) < glb_priority(ri.glb_dppa_flag), le.glb_dppa_flag,ri.glb_dppa_flag);
	self.glb_dppa_all					:= if(stringlib.stringContains(le.glb_dppa_all, ri.glb_dppa_flag, true),le.glb_dppa_all, le.glb_dppa_all + ri.glb_dppa_flag);
	self.src							:= le.src | ri.src;
	//If the source is different add 1 to the counter
	self.src_cnt						:= if(le.src | ri.src  = le.src, le.src_cnt, le.src_cnt + ri.src_cnt);
	self.append_total_source_conf       := if(le.src | ri.src  = le.src, le.append_total_source_conf, le.append_total_source_conf+ ri.append_total_source_conf);
	self.append_npa_effective_dt		:= ut.LatestDate(le.append_npa_effective_dt, ri.append_npa_effective_dt);
	self.npa							:= if(self.append_npa_effective_dt = le.append_npa_effective_dt, le.npa, ri.npa);
	self.append_npa_last_change_dt		:= if(self.npa = le.npa, le.append_npa_last_change_dt, ri.append_npa_last_change_dt);
	self.append_dialable_ind			:= if(self.npa = le.npa, le.append_dialable_ind, ri.append_dialable_ind);
	self.append_place_name				:= if(self.npa = le.npa, le.append_place_name, ri.append_place_name);
	self.append_portability_indicator	:= if(self.npa = le.npa, le.append_portability_indicator, ri.append_portability_indicator);
	self.append_ocn	  			        := if(self.npa = le.npa, le.append_ocn, ri.append_ocn);
	self.append_time_zone		        := if(self.npa = le.npa, le.append_time_zone, ri.append_time_zone);
	self.append_nxx_type		        := if(self.npa = le.npa, le.append_nxx_type, ri.append_nxx_type);
	self.append_COCType			        := if(self.npa = le.npa, le.append_COCType, ri.append_COCType);
	self.append_SCC	    		        := if(self.npa = le.npa, le.append_SCC, ri.append_SCC);
	self.append_company_type   		    := if(self.npa = le.npa, le.append_company_type, ri.append_company_type);
	self.append_prior_area_code			:= if(prior_area_code[..1] = ',', prior_area_code[3..], prior_area_code);
	self.append_phone_type				:= if(self.npa = le.npa, le.append_phone_type, ri.append_phone_type);
	self.orig_publish_code				:= if(stringlib.stringContains(le.orig_publish_code, ri.orig_publish_code, true),le.orig_publish_code, le.orig_publish_code + ri.orig_publish_code);
	self.orig_listing_type 			    := if(stringlib.stringContains(le.orig_listing_type, ri.orig_listing_type, true),le.orig_listing_type, le.orig_listing_type + ri.orig_listing_type);
	self.orig_phone_type				:= if(stringlib.stringContains(le.orig_phone_type, ri.orig_phone_type, true),le.orig_phone_type, le.orig_phone_type + ri.orig_phone_type);
	self.orig_phone_usage				:= if(stringlib.stringContains(le.orig_phone_usage, ri.orig_phone_usage, true),le.orig_phone_usage, le.orig_phone_usage + ri.orig_phone_usage);
	self.orig_conf_score				:= if(stringlib.stringContains(le.orig_conf_score, ri.orig_conf_score, true),le.orig_conf_score, le.orig_conf_score + ri.orig_conf_score);	
	self.min_orig_conf_score 			:= ut.Min2(le.min_orig_conf_score, ri.min_orig_conf_score);
	self.max_orig_conf_score 			:= ut.Max2(le.max_orig_conf_score, ri.max_orig_conf_score);
	self.cur_orig_conf_score			:= ut.Max2(le.cur_orig_conf_score, ri.cur_orig_conf_score);
	self.append_min_source_conf			:= ut.Min2(le.append_avg_source_conf, ri.append_avg_source_conf);
	self.append_max_source_conf 		:= ut.Max2(le.append_avg_source_conf, ri.append_avg_source_conf);
	self := le;
end;

pplus_rollup := rollup(phplus_in_s,
					left.phone7_rec_key = right.phone7_rec_key,
					t_rollup(left, right));


//Calculate average source confidence and determine final phone type
pplus_rollup_t := project(pplus_rollup, transform(Layout_In_Phonesplus.layout_in_common, 
												  self.append_avg_source_conf  := (unsigned) round((real)left.append_total_source_conf / (real)left.src_cnt), 
												  self.append_phone_type   := map(DataLib.StringFind(left.orig_phone_type, 'W',1) > 0 and left.append_phone_type[..3] not in['CEL', 'LND', 'INV']  => 'CELL',
																		          DataLib.StringFind(left.orig_phone_type, 'L',1) > 0 and left.append_phone_type[..3] not in['POT', 'Pue', 'FRE']  => 'POTS',
																			      DataLib.StringFind(left.orig_phone_type, 'V',1) > 0 and left.append_phone_type[..3] not in['VOI']  => 'VOIP',
																			      DataLib.StringFind(left.orig_phone_type, 'P',1) > 0 and left.append_phone_type[..3] not in['PAG']  => 'PAGE',
																			      left.append_phone_type),
												  self.append_phone_use := map(StringLib.StringFindCount(left.orig_phone_usage, 'W') > 0  or
																						StringLib.StringFindCount(left.orig_phone_usage, 'O') > 0	 => 'W',
																						StringLib.StringFindCount(left.orig_phone_usage, 'F') > 0  => 'F',
																						StringLib.StringFindCount(left.orig_phone_usage, 'C') > 0  => 'C',
																						StringLib.StringFindCount(left.orig_phone_usage, 'D') > 0  => 'D',
																						StringLib.StringFindCount(left.orig_phone_usage, 'S') > 0  => 'S',
																						StringLib.StringFindCount(left.orig_listing_type, 'P') >  0 => 'P',
																						trim(left.orig_listing_type,all) in ['B', 'G'] => 'B',
																						StringLib.StringFindCount(left.orig_phone_usage, 'P') > 0 or 
																						StringLib.StringFindCount(left.orig_phone_usage, 'R') > 0 or
																						StringLib.StringFindCount(left.orig_phone_usage, 'H') > 0 or
																						StringLib.StringFindCount(left.orig_phone_usage, 'M') > 0 or
																						trim(left.orig_listing_type,all) ='R' => 'P',
																						trim(left.orig_listing_type,all) = 'BG' or trim(left.orig_listing_type,all) = 'GB' => 'B',
																						 StringLib.StringFindCount(left.orig_phone_usage, 'G') >  0=> 'O',
																						'');
													
													self := left));

					
return pplus_rollup_t;
end;