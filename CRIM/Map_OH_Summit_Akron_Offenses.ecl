
//Source: Alpharetta-Scrape

import crim_common, Crim, Address;

a :=crim.File_OH_Summit_Akron.Defendant(def_id<>'DefendantID');

b :=crim.File_OH_Summit_Akron.Charge(def_id<>'DefendantID');

c :=crim.File_OH_Summit_Akron.Sentence(def_id<>'DefendantID');

//Join Defendant and Charge files
layout_join_def_and_charge  := record
		CRIM.Layout_OH_Summit_Akron_Defendant;
		Crim.Layout_OH_Summit_Akron_Charge	  AND NOT [def_id, county, case_num, case_type, license_num];
end;

layout_join_def_and_charge   jdef_and_chrg(a L, b R) := TRANSFORM
		SELF := L;
		SELF := R;
end;
		
ds_def_and_chrg	:= JOIN(a,b
							    , LEFT.def_id  = RIGHT.def_id
								   , jdef_and_chrg(left,right)); 
								

//Join data set ds_def_and_chrg to Sentence								
layout_def_chrg_and_sent := RECORD
  layout_join_def_and_charge;
	CRIM.Layout_OH_Ross_Sentence  and not [def_id, charge_id];
END;

layout_def_chrg_and_sent jdef_chrg_and_sent(ds_def_and_chrg L, c R) := TRANSFORM
		SELF := L;
		SELF := R;
END;	
		
ds_def_chrg_sent :=JOIN(ds_def_and_chrg, c
							     , LEFT.def_id  = RIGHT.def_id 
								     and LEFT.charge_id = RIGHT.charge_id
									    , jdef_chrg_and_sent(left,right), left outer); 
  
dist := distribute(ds_def_chrg_sent, hash32(def_id));
 
 string8     fSlashedMDYtoCYMD(string pDateIn) 
			:=    intformat((integer2)regexreplace('.*/.*/([1-9]+)',pDateIn,'$1'),4,1) 
			+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
			+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

Crim_Common.Layout_In_Court_Offenses tOHCrim(dist input) := Transform

offense_dt := if(fSlashedMDYtoCYMD(input.offense_dt) between '19000101' and Crim_Common.Version_Development, fSlashedMDYtoCYMD(input.offense_dt),'');  
disposition_dt := if(fSlashedMDYtoCYMD(input.disposition_dt) between '19000101' and Crim_Common.Version_Development, fSlashedMDYtoCYMD(input.disposition_dt),'');  
clean_sentence_description := REGEXREPLACE('Satisfied',REGEXREPLACE('Condition',REGEXREPLACE('Effective',REGEXREPLACE('Date',REGEXREPLACE('Who / Where',REGEXREPLACE('Entry',REGEXREPLACE('days',REGEXREPLACE('Suspended',REGEXREPLACE('Minimum',input.sentence_description,'Min'),'Susp'),'dys',NOCASE),'Ent'),'Who/Where'),'Dt'),'Eff'),'Cond'),'Satisfd');


	clean_def_name				:= stringlib.stringfilter(stringlib.stringtouppercase(input.def_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
	self.process_date 			:= Crim_Common.Version_Development;
	self.offender_key 			:= '4G'+hash(input.def_name)+input.case_num+fSlashedMDYtoCYMD(input.file_dt);									 
	self.vendor 				:= '4G';
	self.state_origin 			:= 'OH';
	self.source_file 			:= '(CP)OH Summit Akron';
	self.off_comp 				:= '';
	self.off_delete_flag 		:= '';
	self.off_date 				:= offense_dt;
	self.arr_date 				:= '';
	self.num_of_counts 			:= input.count_nbr;
	self.le_agency_cd 			:= input.comments;
	self.le_agency_desc 		:= '';
	self.le_agency_case_number 	:= '';
	self.traffic_ticket_number 	:= input.ticket_num;
	self.traffic_dl_no 			:= input.license_num;
	self.traffic_dl_st 			:= input.lic_state_cd;
	self.arr_off_code 			:= '';
	self.arr_off_desc_1 		:= '';
	self.arr_off_desc_2 		:= '';
	self.arr_off_type_cd 		:= '';
	self.arr_off_type_desc 		:= '';
	self.arr_off_lev 			:= '';
	self.arr_statute 			:= '';
	self.arr_statute_desc 		:= '';
	self.arr_disp_date 			:= '';
	self.arr_disp_code 			:= '';
	self.arr_disp_desc_1 		:= '';
	self.arr_disp_desc_2 		:= '';
	self.pros_refer_cd 			:= '';
	self.pros_refer 			:= '';
	self.pros_assgn_cd 			:= '';
	self.pros_assgn 			:= '';
	self.pros_chg_rej 			:= '';
	self.pros_off_code 			:= '';
	self.pros_off_desc_1 		:= '';
	self.pros_off_desc_2 		:= '';
	self.pros_off_type_cd 		:= '';
	self.pros_off_type_desc 	:= '';
	self.pros_off_lev 			:= '';
	self.pros_act_filed 		:= '';
	self.court_case_number 		:= input.case_num;
	self.court_cd 				:= '';
	self.court_desc 			:= '';
	self.court_appeal_flag 		:= '';
	self.court_final_plea 		:= '';
	self.court_off_code 		:= '';
	self.court_off_desc_1 		:= if(regexfind('\\/', input.statute_descr[3], 0)<>'',
									input.statute_descr[4..],
									''); 
	self.court_off_desc_2		:= '';
	self.court_off_type_cd 		:= '';
	self.court_off_type_desc 	:= '';
	self.court_off_lev 			:= if(regexfind('\\/', input.statute_descr[3], 0)<>'',
									input.statute_descr[1..2],
									'');
	self.court_statute 			:= if(trim(input.statute,left,right)<>'000',
									input.statute,
									'');
 	self.court_additional_statutes:= '';
	self.court_statute_desc 		:= '';
	self.court_disp_date 		:= disposition_dt;
	self.court_disp_code 		:= '';
	self.court_disp_desc_1	 	:= '';
	self.court_disp_desc_2 		:= '';
	self.sent_date 			:= '';
	self.sent_jail 			:= '';
																						
	self.sent_susp_time 		:= '';
	self.sent_court_cost 		:= if(input.sentence_type = 'Costs Levied', 
										if(clean_sentence_description in ['0','0.00'],
											'',
											if(regexfind('\\.',clean_sentence_description,0)<>'',
												regexreplace('\\.',clean_sentence_description, ''),
												if(clean_sentence_description<>'',
													clean_sentence_description+'00',
													''))),''); 
															
	self.sent_court_fine 		:= if(input.sentence_type = 'Court Fine Levied', 
										if(clean_sentence_description in ['0','0.00'],
											'',
											if(regexfind('\\.',clean_sentence_description,0)<>'',
												regexreplace('\\.',clean_sentence_description, ''),
												if(clean_sentence_description<>'',
													clean_sentence_description+'00',
													''))),''); 
																		
	self.sent_susp_court_fine 	:= if(input.sentence_type = 'Court Fine Suspended', 
										if(clean_sentence_description in ['0','0.00'],
											'',
											if(regexfind('\\.',clean_sentence_description,0)<>'',
												regexreplace('\\.',clean_sentence_description, ''),
												if(clean_sentence_description<>'',
													clean_sentence_description+'00',
													''))),''); 
	self.sent_probation 		:= '';
	self.sent_addl_prov_code 	:= '';
	self.sent_addl_prov_desc_1 	:= '';
																		
	self.sent_addl_prov_desc_2 	:= '';
	self.sent_consec 			:= '';
	self.sent_agency_rec_cust_ori := '';
	self.sent_agency_rec_cust 	:= '';
	self.appeal_date 			:= '';
	self.appeal_off_disp 		:= '';
	self.appeal_final_decision 	:= '';

end;

pOHOffend := project(dist, tOHCrim(left));	

Crim_Common.Layout_In_Court_Offenses rollupOHCrim(pOHOffend L,pOHOffend R) := TRANSFORM
	self.sent_date  			:= if(l.sent_date  = '', r.sent_date , l.sent_date);
	self.sent_jail  			:= if(l.sent_jail  = '', r.sent_jail , l.sent_jail);
	self.sent_susp_time  		:= if(l.sent_susp_time  = '', r.sent_susp_time , l.sent_susp_time);
	self.sent_court_cost 		:= if(l.sent_court_cost = '', r.sent_court_cost, l.sent_court_cost);
	self.sent_court_fine  		:= if(l.sent_court_fine  = '', r.sent_court_fine , l.sent_court_fine);
	self.sent_susp_court_fine  	:= if(l.sent_susp_court_fine  = '', r.sent_susp_court_fine , l.sent_susp_court_fine);
	self.sent_probation  		:= if(l.sent_probation  = '', r.sent_probation , l.sent_probation);
	self.sent_consec			:= if(l.sent_consec  = '', r.sent_consec , l.sent_consec);
	self.sent_addl_prov_desc_1	:= if(l.sent_addl_prov_desc_1 = '', trim(r.sent_addl_prov_desc_1,all), trim(l.sent_addl_prov_desc_1, all));
	self.sent_addl_prov_desc_2	:= if(l.sent_addl_prov_desc_2 = '', trim(r.sent_addl_prov_desc_2,all), trim(l.sent_addl_prov_desc_2, all));
	self.sent_agency_rec_cust_ori	:= if(l.sent_agency_rec_cust_ori = '', trim(r.sent_agency_rec_cust_ori,all), trim(l.sent_agency_rec_cust_ori, all));
	SELF := R; 
END;

rOHCrim := ROLLUP(pOHOffend,
						LEFT.offender_key =RIGHT.offender_key and
						left.num_of_counts = right.num_of_counts, 
						rollupOHCrim(LEFT,RIGHT));																							 

fOHOffend:= dedup(sort(distribute(rOHCrim,hash(offender_key)),
				 offender_key,off_comp,num_of_counts,court_statute,court_statute_desc,court_off_code,court_off_desc_1, sent_addl_prov_desc_1,sent_addl_prov_desc_2, local),
					 offender_key,off_comp,num_of_counts,court_statute,court_statute_desc,court_off_code,court_off_desc_1,sent_date,
					  sent_jail,sent_susp_time,sent_court_cost,sent_court_fine, sent_susp_court_fine,sent_probation,
				      sent_consec, sent_addl_prov_desc_1, sent_addl_prov_desc_2,all,local,left)
								 :PERSIST('~thor_data400::persist::Crim_OH_Akron_Offenses');

export Map_OH_Summit_Akron_Offenses := fOHOffend;
