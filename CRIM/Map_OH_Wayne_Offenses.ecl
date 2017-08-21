import lib_stringlib, Crim_Common;

d := crim.File_OH_Wayne(Charge_Decision <> 'Charge_Decision');

Crim_Common.Layout_In_Court_Offenses tOHCrim(d l) := Transform

searchpattern := '(.*)/(.*)/(.*) (.*) (.*)$';

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date		:= Crim_Common.Version_Development;
self.offender_key 		:= '2L'+l.casenumber;
self.vendor				:= '2L';
self.state_origin		:= 'OH';
self.source_file		:= '(CV)OH Wayne CRIM';
self.off_comp 					:= l.charge_number;
self.off_delete_flag 			:= '';
self.off_date 					:= if(fSlashedMDYtoCYMD(l.offensedate) between '19010101' and Crim_Common.Version_Development,
										fSlashedMDYtoCYMD(l.offensedate) , '');
self.arr_date 					:= if(fSlashedMDYtoCYMD(l.arrestdate) between '19010101' and Crim_Common.Version_Development,
										fSlashedMDYtoCYMD(l.arrestdate) , '');
self.num_of_counts 				:= if(l.charge_counts > '0', l.charge_counts, '');
self.le_agency_cd 				:= '';
self.le_agency_desc 			:= '';
self.le_agency_case_number 		:= l.charge_misc_track;
self.traffic_ticket_number 		:= '';
self.traffic_dl_no 				:= '';
self.traffic_dl_st 				:= '';
self.arr_off_code 				:= '';
self.arr_off_desc_1 			:= '';//regexreplace('(\\(.*\\))|(UNKNOWN)', if(l.charge_offensedescription <> 'Converted action code', l.charge_offensedescription, ''), '');
self.arr_off_desc_2 			:= '';
self.arr_off_type_cd 			:= '';
self.arr_off_type_desc 			:= '';
self.arr_off_lev 				:= '';//regexreplace('[^MF1-6]', l.degreeofoffense[1..1] + regexreplace('[^1-6]', l.degreeofoffense, '')[1..1], '');
self.arr_statute 				:= '';
self.arr_statute_desc 			:= '';
self.arr_disp_date 				:= '';
self.arr_disp_code 				:= '';
self.arr_disp_desc_1 			:= '';
self.arr_disp_desc_2 			:= '';
self.pros_refer_cd 				:= '';
self.pros_refer 				:= '';
self.pros_assgn_cd 				:= '';
self.pros_assgn 				:= '';//if(stringlib.stringfind(l.prosecutor, 'P.A.', 1) = 0, l.prosecutor, '');
self.pros_chg_rej 				:= '';
self.pros_off_code 				:= '';
self.pros_off_desc_1 			:= '';
self.pros_off_desc_2 			:= '';
self.pros_off_type_cd 			:= '';
self.pros_off_type_desc 		:= '';
self.pros_off_lev 				:= '';
self.pros_act_filed 			:= '';
self.court_case_number 			:= l.casenumber;
self.court_cd 					:= '';
self.court_desc 				:= '';
self.court_appeal_flag 			:= '';
self.court_final_plea 			:= l.charge_pleacode;
self.court_off_code 			:= '';
self.court_off_desc_1 			:= '';//regexreplace('(\\(.*\\))|(UNKNOWN)', if(l.charge_amd_charge = '' or l.charge_amd_charge <> 'Converted action code', if(l.charge_offensedescription <> 'Converted action code', l.charge_offensedescription, ''), l.charge_amd_charge), '');
self.court_off_desc_2			:= '';
self.court_off_type_cd 			:= '';
self.court_off_type_desc 		:= '';
self.court_off_lev 				:= '';//regexreplace('[^MF1-6]', if(l.charge_amd_charge = '',
									// l.charge_degreeofoffense[1..1] + regexreplace('[^1-6]', l.charge_degreeofoffense, '')[1..1],
									// l.charge_amd_charge_dgof[1..1] + regexreplace('[^1-6]', l.charge_amd_charge_dgof, '')[1..1]), '');
self.court_statute 				:= '';//l.charge_actioncode;
self.court_additional_statutes 	:= '';
self.court_statute_desc 		:= '';
self.court_disp_date 			:= if(fSlashedMDYtoCYMD(l.dispositiondate) between '19010101' and Crim_Common.Version_Development, fSlashedMDYtoCYMD(l.dispositiondate), '');
self.court_disp_code 			:= '';
self.court_disp_desc_1	 		:= '';//regexreplace('^J', regexreplace( '(\\([A-Z]+\\))',l.charge_decision, ''), '');
self.court_disp_desc_2 			:= '';
self.sent_date 					:= '';
self.sent_jail 					:= '';
self.sent_susp_time 			:= '';
self.sent_court_cost 			:= '';
self.sent_court_fine 			:= '';
self.sent_susp_court_fine 		:= '';
self.sent_probation 			:= '';
self.sent_addl_prov_code 		:= '';
self.sent_addl_prov_desc_1 		:= '';
self.sent_addl_prov_desc_2 		:= '';
self.sent_consec 				:= '';
self.sent_agency_rec_cust_ori 	:= '';
self.sent_agency_rec_cust 		:= '';
self.appeal_date 				:= '';
self.appeal_off_disp 			:= '';
self.appeal_final_decision 		:= '';

end;

pOHCrimtemp := project(d,tOHCrim(left));

Crim_Common.Layout_In_Court_Offenses tOHCrim2(Crim_Common.Layout_In_Court_Offenses l) := Transform
self.court_off_lev := if(l.court_off_lev[1..1] = 'F', l.court_off_lev, if(trim(l.court_off_lev,left)[1..1] = 'M', 
						'M' + regexreplace('1' , regexreplace('2' , regexreplace('3' , regexreplace('4' , regexreplace('5' , regexreplace('6' , trim(l.court_off_lev,left)[2..2], 'F'), 'E'), 'D'), 'C'), 'B'), 'A'), l.court_off_lev[1..1]));
self.arr_off_lev := if(l.arr_off_lev[1..1] = 'F', l.arr_off_lev, if(trim(l.arr_off_lev,left)[1..1] = 'M', 
						'M' + regexreplace('1' , regexreplace('2' , regexreplace('3' , regexreplace('4' , regexreplace('5' , regexreplace('6' , trim(l.arr_off_lev, left)[2..2], 'F'), 'E'), 'D'), 'C'), 'B'), 'A'), l.arr_off_lev[1..1]));
self := l;
end;

pOHCrim := project(pOHCrimtemp,tOHCrim2(left));

fOHOffend:= dedup(sort(distribute(pOHCrim(off_date + le_agency_case_number + court_disp_date <> '' and court_case_number <> ''),hash(offender_key)),
									offender_key,off_comp,court_statute,court_statute_desc,court_off_code,court_off_desc_1,source_file,local),
									offender_key,off_comp,court_statute,court_statute_desc,court_off_code,court_off_desc_1,local,left):
									PERSIST('~thor_dell400::persist::Crim_OH_Wayne_Offenses');

export map_OH_Wayne_Offenses	:= fOHOffend;
