import Crim_Common, Crim;


OHSU_Cuyahoga_def := sort(CRIM.File_OH_Summit_CuyahogaFalls.defendant(def_id<>'DefendantID'), def_id);
OHSU_Cuyahoga_chrg := sort(CRIM.File_OH_Summit_CuyahogaFalls.charge(def_id<>'DefendantID'), def_id);

layout_chrg  := record
		crim.Layout_OH_Ross_Defendant 			AND NOT [case_type, license_num];
		crim.Layout_OH_Ross_Charge   				AND NOT [def_id, county, case_num];
end;

layout_chrg   join_def_chrg(OHSU_Cuyahoga_def L, OHSU_Cuyahoga_chrg R) := TRANSFORM
		SELF := L;
		SELF := R;
end;

OHSU_Cuyahoga_def_chrg		:=  JOIN(OHSU_Cuyahoga_def, OHSU_Cuyahoga_chrg ,
                     LEFT.def_id  = RIGHT.def_id, 
										 join_def_chrg(left,right), left outer); 
  
d_OHSU_Cuyahoga := distribute(OHSU_Cuyahoga_def_chrg, hash32(def_id));

Crim_Common.Layout_In_Court_Offenses Map_offender(d_OHSU_Cuyahoga input) := Transform

	string statute_desc 			:= trim(regexreplace('(^[0-9a-z.A-Z]*)', input.statute_descr, ''),left,right);

	//clean_def_name				:= stringlib.stringfilter(stringlib.stringtouppercase(input.def_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
	self.process_date			    := Crim_Common.Version_Development;
	self.offender_key			    := Function_Offender_Key_Generator('4C',trim(input.case_num),trim(stringlib.stringfindreplace(input.file_dt,'/','')));
	self.vendor 				    := '4C';
	self.state_origin 		      	:= 'OH';
	self.source_file 			    := '(CP)OHSUMMITCUYAHOGA';
	self.off_comp 				    := '';
	self.off_delete_flag 	      	:= '';
	self.off_date 				    := IF(Function_ParseDate(input.OFFENSE_DT,'MM/DD/YYYY')between '19000101' and stringlib.GetDateYYYYMMDD(),
									                  Function_ParseDate(input.OFFENSE_DT,'MM/DD/YYYY'),'');
	self.arr_date 				    := '';
	self.num_of_counts 			    := IF (regexfind('([a-z.A-Z]*)',input.count_nbr,0) <> '','',input.count_nbr);
	self.le_agency_cd 			    := '';
	self.le_agency_desc 		    := '';
	self.le_agency_case_number 		:= '';
	self.traffic_ticket_number 		:= input.ticket_num;
	self.traffic_dl_no 			    := '';
	self.traffic_dl_st 			    := input.lic_state_cd;
	self.arr_off_code 			    := '';
	self.arr_off_desc_1 		    := '';
	self.arr_off_desc_2 		    := '';
	self.arr_off_type_cd 		    := '';
	self.arr_off_type_desc 		  	:= '';
	self.arr_off_lev 			    := '';
	self.arr_statute 			    := '';
	self.arr_statute_desc 		  	:= '';
	self.arr_disp_date 			    := '';
	self.arr_disp_code 			    := '';
	self.arr_disp_desc_1 		    := '';
	self.arr_disp_desc_2 		    := '';
	self.pros_refer_cd 			    := '';
	self.pros_refer 			    := '';
	self.pros_assgn_cd 			    := '';
	self.pros_assgn 			    := '';
	self.pros_chg_rej 			    := '';
	self.pros_off_code 			    := '';
	self.pros_off_desc_1 		    := '';
	self.pros_off_desc_2 		    := '';
	self.pros_off_type_cd 		  	:= '';
	self.pros_off_type_desc 		:= '';
	self.pros_off_lev 			    := '';
	self.pros_act_filed 		    := '';
	self.court_case_number 		  	:= input.case_num;
	self.court_cd 				    := '';
	self.court_desc 			    := '';
	self.court_appeal_flag 		  	:= '';
	self.court_final_plea 		  	:= '';
	self.court_off_code 		    := '';
	self.court_off_desc_1 		  	:= '';
	self.court_off_desc_2		    := '';
	self.court_off_type_cd 		  	:= '';
	self.court_off_type_desc 	  	:= '';
	self.court_off_lev 			    := IF(trim(input.chg_degree)='n/a','',trim(input.chg_degree))  ;								                 
	self.court_statute 			    := regexfind('(^[0-9a-z.A-Z]*)',input.statute_descr,0);
	self.court_additional_statutes	:= '';
	self.court_statute_desc 		:= IF(statute_desc[1..1] in ['-','/'], statute_desc[2..] ,statute_desc);
	self.court_disp_date 		    := IF(Function_ParseDate(input.disposition_dt,'MM/DD/YYYY')between '19000101' and stringlib.GetDateYYYYMMDD(),
									                Function_ParseDate(input.disposition_dt,'MM/DD/YYYY'),'');
	self.court_disp_code 		    := '';
	self.court_disp_desc_1	 	  	:= input.dispo_detail;
	self.court_disp_desc_2 		  	:= '';
	self.sent_date 			        := '';
	self.sent_jail 			        := '';																			
	self.sent_susp_time 		    := '';
	self.sent_court_cost 		    := '';
	self.sent_court_fine 		    := '';
	self.sent_susp_court_fine 		:= '';
	self.sent_probation 		    := '';
	self.sent_addl_prov_code 	  	:= '';
	self.sent_addl_prov_desc_1 		:= '';
	self.sent_addl_prov_desc_2 		:= '';
	self.sent_consec 			    := '';
	self.sent_agency_rec_cust_ori 	:= '';
	self.sent_agency_rec_cust 		:= '';
	self.appeal_date 			    := '';
	self.appeal_off_disp 		    := '';
	self.appeal_final_decision 		:= '';

end;

pOHCrim := project(d_OHSU_Cuyahoga,Map_offender(left));

fOHOffend:= dedup(sort(distribute(pOHCrim,hash(offender_key)),
				offender_key,off_comp,court_statute,court_statute_desc,court_off_code,court_off_desc_1, court_disp_desc_1,local),
					offender_key,off_comp,court_statute,court_statute_desc,court_off_code,court_off_desc_1,court_disp_desc_1,all,local,left)
									:PERSIST('~thor_dell400::persist::Crim_OH_Summit_CuyahogaFalls_Offenses');


export Map_OH_Summit_Cty_CuyahogaFalls_City_Offenses := fOHOffend;