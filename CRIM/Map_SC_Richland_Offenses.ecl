//Source: Alpharetta-Scrape

import Crim_Common, Crim;


ds_def := sort(CRIM.File_SC_Richland.Defendant, def_id);
ds_chrg := sort(CRIM.File_SC_Richland.Charge, def_id);
ds_sent := CRIM.File_SC_Richland.Sentence;

layout_chrg  := record
		crim.Layout_OH_Ross_Defendant 			AND NOT [case_type, license_num];
		crim.Layout_OH_Ross_Charge   				AND NOT [def_id, county, case_num];
end;



layout_chrg   jdef_chrg(ds_def L, ds_chrg R) := TRANSFORM
		SELF := L;
		SELF := R;
end;

		
ds_def_chrg				:=JOIN(ds_def, ds_chrg 
							, LEFT.def_id  = RIGHT.def_id
								, jdef_chrg(left,right),left outer); 

layout_chrg_sent := RECORD
    ds_def_chrg;
		CRIM.Layout_OH_Ross_Sentence  and not [def_id, charge_id];
END;
layout_chrg_sent  jdef_chrg_sent(ds_def_chrg L, ds_sent R) := TRANSFORM
		SELF := L;
		SELF := R;
END;


		
		
ds_def_chrg_sent			:=JOIN(ds_def_chrg, ds_sent
							, LEFT.def_id  = RIGHT.def_id 
								and LEFT.charge_id = RIGHT.charge_id
									, jdef_chrg_sent(left,right), left outer); 
  
d := distribute(ds_def_chrg_sent, hash32(def_id));
 
 string8     fSlashedMDYtoCYMD(string pDateIn) 
			:=    intformat((integer2)regexreplace('.*/.*/([1-9]+)',pDateIn,'$1'),4,1) 
			+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
			+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

Crim_Common.Layout_In_Court_Offenses tOHCrim(d input) := Transform
integer indict_chgpart1  		:=  StringLib.StringFind(input.indict_chg,' ',1);

varstring statute      :=  IF (indict_chgpart1 >0 ,input.indict_chg[1..indict_chgpart1-1], '');
	clean_def_name				:= stringlib.stringfilter(stringlib.stringtouppercase(input.def_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
	self.process_date			:= Crim_Common.Version_Development;
	self.offender_key			:= '3Q'+input.case_type[1]+hash(clean_def_name)+input.case_num+fSlashedMDYtoCYMD(input.file_dt);
	self.vendor 				:= '3Q';
	self.state_origin 			:= 'SC';
	self.source_file 			:= '(CP)SC RICHLAND CNTY';
	self.off_comp 				:= '';
	self.off_delete_flag 		:= '';
	self.off_date 				:= if(fSlashedMDYtoCYMD(input.offense_dt)between '19000101' and (string)((integer)Crim_Common.Version_Development),
								fSlashedMDYtoCYMD(input.offense_dt),''); 
	self.arr_date 				:= '';
	self.num_of_counts 			:= input.counts;
	self.le_agency_cd 			:= '';
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
	self.pros_off_type_desc 		:= '';
	self.pros_off_lev 			:= '';
	self.pros_act_filed 		:= '';
	self.court_case_number 		:= input.case_num;
	self.court_cd 				:= '';
	self.court_desc 			:= '';
	self.court_appeal_flag 		:= '';
	self.court_final_plea 		:= '';
	self.court_off_code 		:= '';
	self.court_off_desc_1 		:= input.amended_chg;
	self.court_off_desc_2		:= '';
	self.court_off_type_cd 		:= '';
	self.court_off_type_desc 	:= '';
	self.court_off_lev 			:= if (input.case_type[1]='T', 'T', if(regexfind('1st Degree Felony',trim(input.chg_degree,left,right),0)<>'','F1',
								if(regexfind('2nd Degree Felony',trim(input.chg_degree,left,right),0)<>'','F2',
								if(regexfind('3rd Degree Felony',trim(input.chg_degree,left,right),0)<>'','F3',
								if(regexfind('4th Degree Felony',trim(input.chg_degree,left,right),0)<>'','F4',
								if(regexfind('5th Degree Felony',trim(input.chg_degree,left,right),0)<>'','F5',
								if(regexfind('1st Degree Misdemeanor',trim(input.chg_degree,left,right),0)<>'','M1',
								if(regexfind('2nd Degree Misdemeanor',trim(input.chg_degree,left,right),0)<>'','M2',
								if(regexfind('3rd Degree Misdemeanor',trim(input.chg_degree,left,right),0)<>'','M3',
								if(regexfind('4th Degree Misdemeanor',trim(input.chg_degree,left,right),0)<>'','M4',
								if(regexfind('Minor Misdemeanor',trim(input.chg_degree,left,right),0)<>'','MM',
								'')))))))))));
	self.court_statute 			:= trim(statute, left);
	self.court_additional_statutes:= '';
	self.court_statute_desc 		:= input.statute_descr;
	self.court_disp_date 		:= if(fSlashedMDYtoCYMD(input.disposition_dt)between '19000101' and (string)((integer)Crim_Common.Version_Development),
									fSlashedMDYtoCYMD(input.disposition_dt),''); 
	self.court_disp_code 		:= '';
	self.court_disp_desc_1	 	:= input.dispo_detail;
	self.court_disp_desc_2 		:= '';
	self.sent_date 			:= '';
	self.sent_jail 			:= if(input.sentence_type = 'Jail Time', 
								if(trim(input.sentence_description, left, right)=''
								or trim(input.sentence_description, left, right)='0', '',
								trim(input.sentence_description, left, right)+' DAY(S)'),'');																			
	self.sent_susp_time 		:= if(input.sentence_type = 'Jail Time Susp.', 
								if(trim(input.sentence_description, left, right)=''
								or trim(input.sentence_description, left, right)='0', '',
								trim(input.sentence_description, left, right)+' DAY(S)'),'');
	self.sent_court_cost 		:= if(input.sentence_type = 'Costs Amt.', 
								if(input.sentence_description = '.00','',
									stringlib.stringfilter(input.sentence_description,'0123456789')), '');
	self.sent_court_fine 		:= if(input.sentence_type = 'Fine Amt.', 
								if(input.sentence_description = '.00','',
									stringlib.stringfilter(input.sentence_description,'0123456789')), '');
	self.sent_susp_court_fine 	:= if(input.sentence_type = 'Fine Amt. Susp.', 
								if(input.sentence_description = '.00','',
									stringlib.stringfilter(input.sentence_description,'0123456789')), '');
	self.sent_probation 		:= '';
	self.sent_addl_prov_code 	:= '';
	self.sent_addl_prov_desc_1 	:= if(input.sentence_type = 'O.L. Susp. From' ,
								if(input.sentence_description = '','',
									'Lic Susp From:'+input.sentence_description), '');
	self.sent_addl_prov_desc_2 	:= if(input.sentence_type = 'O.L. Susp. To',
								if(input.sentence_description = '','', 
									'Lic Susp To:'+input.sentence_description), '');
	self.sent_consec 			:= '';
	self.sent_agency_rec_cust_ori := '';
	self.sent_agency_rec_cust 	:= '';
	self.appeal_date 			:= '';
	self.appeal_off_disp 		:= '';
	self.appeal_final_decision 	:= '';

end;

pOHCrim := project(d,tOHCrim(left));

pOHCrim rlpOHCrim(pOHCrim L,pOHCrim R) := TRANSFORM
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
	SELF := R; 
END;

rlppOHCrimOut := ROLLUP(pOHCrim,LEFT.offender_key =RIGHT.offender_key, rlpOHCrim(LEFT,RIGHT));
fOHOffend:= dedup(sort(distribute(rlppOHCrimOut,hash(offender_key)),
				offender_key,off_comp,court_statute,court_statute_desc,court_off_code,court_off_desc_1, sent_addl_prov_desc_1,sent_addl_prov_desc_2, local),
					offender_key,off_comp,court_statute,court_statute_desc,court_off_code,court_off_desc_1,sent_date,
					sent_jail,sent_susp_time,sent_court_cost,sent_court_fine, sent_susp_court_fine,sent_probation,
					sent_consec, sent_addl_prov_desc_1, sent_addl_prov_desc_2,all,local,left)
									:PERSIST('~thor_data400::persist::Crim_SC_Richland_Offenses');

export Map_SC_Richland_Offenses := fOHOffend;