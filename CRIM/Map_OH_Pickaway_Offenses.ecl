//Source: Alpharetta-Scrape

import Crim_Common, Crim;


ds_def := sort(CRIM.File_OH_Pickaway.File_OH_Pickaway_Defendant, def_id);
ds_chrg := sort(CRIM.File_OH_Pickaway.File_OH_Pickaway_Charge, def_id);

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
								, jdef_chrg(left,right), left outer); 
  
d := distribute(ds_def_chrg, hash32(def_id));
 
 string8     fSlashedMDYtoCYMD(string pDateIn) 
			:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
			+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
			+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);
			
string       fees_owed(string pFeesOwed) := 
if(trim(pFeesOwed,all) = '.00','','FeesOwed: '+'$'+trim(pFeesOwed,all));
	
string       fees_paid(string pFeesPaid) := 
if(trim(pFeesPaid,all) = '.00','', 'FeesPaid: '+'$'+trim(pFeesPaid, all));

Crim_Common.Layout_In_Court_Offenses tOHCrim(d input) := Transform

	clean_def_name				:= stringlib.stringfilter(stringlib.stringtouppercase(input.def_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
	self.process_date			:= Crim_Common.Version_Development;
	self.offender_key			:= '3J'+input.case_type[1]+hash(clean_def_name)+input.case_num+fSlashedMDYtoCYMD(input.file_dt);
	self.vendor 				:= '3J';
	self.state_origin 			:= 'OH';
	self.source_file 			:= '(CP)OH Pickaway Cnty';
	self.off_comp 				:= '';
	self.off_delete_flag 		:= '';
	self.off_date 				:= if(fSlashedMDYtoCYMD(input.offense_dt)between '19000101' and (string)((integer)Crim_Common.Version_Development),
									fSlashedMDYtoCYMD(input.offense_dt),''); 
	self.arr_date 				:= '';
	self.num_of_counts 			:= input.count_nbr;
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
	self.pros_off_type_desc 	:= '';
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
	self.court_off_lev 			:= if(input.case_type[1]='T','T',if(regexfind('1st Degree Felony',trim(input.chg_degree,left,right),0)<>'','F1',
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
	self.court_statute 			:= trim(regexreplace('[-|\\]|`|/|"]',input.statute,''), left, right);
	self.court_additional_statutes:= '';
	self.court_statute_desc 		:= trim(regexreplace('-', input.statute_descr, ''), left, right);
	self.court_disp_date 		:= if(fSlashedMDYtoCYMD(input.disposition_dt)between '19000101' and (string)((integer)Crim_Common.Version_Development),
									fSlashedMDYtoCYMD(input.disposition_dt),''); 
	self.court_disp_code 		:= '';
	self.court_disp_desc_1	 	:= input.dispo_detail;
	self.court_disp_desc_2 		:= If(fees_owed(input.total_fees_owed) = '' and fees_paid(input.total_fees_paid) ='','',
									If(fees_owed(input.total_fees_owed) <> '' and fees_paid(input.total_fees_paid) ='', fees_owed(input.total_fees_owed), 
										if(fees_owed(input.total_fees_owed) = '' and fees_paid(input.total_fees_paid) <>'', fees_owed(input.total_fees_paid), 
											if(fees_owed(input.total_fees_owed) <> '' and fees_paid(input.total_fees_paid) <> '', fees_owed(input.total_fees_owed)+', '+fees_paid(input.total_fees_paid), ''))));
	self.sent_date 			:= '';
	self.sent_jail 			:= '';																			
	self.sent_susp_time 		:= '';
	self.sent_court_cost 		:= '';
	self.sent_court_fine 		:= '';
	self.sent_susp_court_fine 	:= '';
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

pOHCrim := project(d,tOHCrim(left));

fOHOffend:= dedup(sort(distribute(pOHCrim,hash(offender_key)),
				offender_key,off_comp,court_statute,court_statute_desc,court_off_code,court_off_desc_1, court_disp_desc_1,local),
					offender_key,off_comp,court_statute,court_statute_desc,court_off_code,court_off_desc_1,court_disp_desc_1,all,local,left)
							:PERSIST('~thor_data400::persist::Crim_OH_Pickaway_Offenses');

export Map_OH_Pickaway_Offenses := fOHOffend;