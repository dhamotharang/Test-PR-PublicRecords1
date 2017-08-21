//Source: Alpharetta-Scrape
import Crim_Common, Crim;

ds_def := sort(CRIM.File_LA_Jefferson.Defendant(DEF_ID != 'DefendantID'), def_id);
ds_chrg := sort(CRIM.File_LA_Jefferson.Charge(DEF_ID != 'DefendantID'), def_id);
ds_sent := CRIM.File_LA_Jefferson.Sentence(DEF_ID != 'DefendantID');

layout_chrg  := record
		crim.Layout_LA_Jefferson.Defendant;
		crim.Layout_LA_Jefferson.Charge 				AND NOT [def_id, county];
end;

layout_chrg   jdef_chrg(ds_def L, ds_chrg R) := TRANSFORM
		SELF := L;
		SELF := R;
end;
		
ds_def_chrg				:=JOIN(ds_def, ds_chrg 
							, LEFT.def_id  = RIGHT.def_id
								, jdef_chrg(left,right)); 

layout_chrg_sent := RECORD
    ds_def_chrg;
		CRIM.Layout_LA_Jefferson.Sentence  and not [def_id, charge_id];
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

Crim_Common.Layout_In_Court_Offenses tLACrim(d input) := Transform
	clean_def_name				:= stringlib.stringfilter(stringlib.stringtouppercase(input.def_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
	self.process_date			:= Crim_Common.Version_Development;
	self.offender_key			:= '3O'+hash(clean_def_name)+input.case_num+fSlashedMDYtoCYMD(input.file_dt);
	self.vendor 				:= '3O';
	self.state_origin 			:= 'LA';
	self.source_file 			:= '(CP)LA JEFFERSON CRIM CT';
	self.off_comp 				:= input.counts;
	self.off_delete_flag 		:= '';
	self.off_date 				:= if(fSlashedMDYtoCYMD(input.offense_dt)between '19000101' and (string)((integer)Crim_Common.Version_Development),
										fSlashedMDYtoCYMD(input.offense_dt),''); 
	self.arr_date 				:= '';
	self.num_of_counts 			:= '';
	self.le_agency_cd 			:= '';
	self.le_agency_desc 		:= '';
	self.le_agency_case_number 	:= '';
	self.traffic_ticket_number 	:= input.ticket_num;
	self.traffic_dl_no 			:= trim(input.license_num[3..], left, right);
	self.traffic_dl_st 			:= trim(input.license_num, left, right)[1..2];
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
	self.court_off_lev 			:= input.c_case_type;
  self.court_statute	:= if(regexfind('^[0-9]', input.statute), input.statute[1..stringlib.StringFind(input.statute, ' ', 1)], ' ');													 
	self.court_additional_statutes:= '';
	self.court_statute_desc 		:= input.statute_descr;
	self.court_disp_date 		:= if(fSlashedMDYtoCYMD(input.disposition_dt)between '19000101' and (string)((integer)Crim_Common.Version_Development),
									fSlashedMDYtoCYMD(input.disposition_dt),''); 
	self.court_disp_code 		:= '';
	self.court_disp_desc_1	 	:= input.dispo_detail;
	self.court_disp_desc_2 		:= '';
	self.sent_date 				:= '';
	self.sent_jail 				:= '';																			
	self.sent_susp_time 		:= '';
	self.sent_court_cost 		:= '';
	self.sent_court_fine 		:= '';
	self.sent_susp_court_fine 	:= '';
	self.sent_probation 		:= '';
	self.sent_addl_prov_code 	:= '';
	self.sent_addl_prov_desc_1 	:= if(input.sentence_type='', '', input.sentence_type+':'+trim(regexreplace('Sentenced', regexreplace('Suspended', regexreplace('Active Probation', input.sentence_description, 'ActvProb'),'Suspd'),''), left, right));
	self.sent_addl_prov_desc_2 	:= '';
	self.sent_consec 			:= '';
	self.sent_agency_rec_cust_ori := '';
	self.sent_agency_rec_cust 	:= '';
	self.appeal_date 			:= '';
	self.appeal_off_disp 		:= '';
	self.appeal_final_decision 	:= '';

end;

pLACrim := project(d,tLACrim(left));

fLAOffend:= dedup(sort(distribute(pLACrim,hash(offender_key)),
				offender_key,off_comp,court_statute,court_statute_desc,court_off_code,court_off_desc_1, sent_addl_prov_desc_1,sent_addl_prov_desc_2, local),
					offender_key,off_comp,court_statute,court_statute_desc,court_off_code,court_off_desc_1,sent_date,
					sent_jail,sent_susp_time,sent_court_cost,sent_court_fine, sent_susp_court_fine,sent_probation,
					sent_consec, sent_addl_prov_desc_1, sent_addl_prov_desc_2,all,local,left)
									:PERSIST('~thor_data400::persist::Crim_LA_Jefferson_Offenses');

export Map_LA_Jefferson_Offenses := fLAOffend;
