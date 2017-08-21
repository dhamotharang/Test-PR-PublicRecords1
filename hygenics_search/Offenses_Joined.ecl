import CrimSrch,hygenics_crim;

set_off := ['V',/*'I',*/'C','T'];

//Fit DOC Offense File to current Court Offense File format
doc_offenses := DOC_Offenses_as_crimsrch_offenses;

	hygenics_crim.Layout_Base_CourtOffenses_with_OffenseCategory ct_off(doc_offenses pDOCOffenses):= transform
		self.state_origin					:= pDOCOffenses.source_file[1..2] ;  
		self.source_file					:= pDOCOffenses.source_file;
		self.off_date							:= pDOCOffenses.off_date;
		self.off_comp							:= '';
		self.off_delete_flag			:= '';
		self.arr_off_code					:= '';
		self.arr_off_desc_1				:= '';
		self.arr_off_desc_2				:= '';
		self.arr_off_type_cd			:= '';
		self.arr_off_type_desc		:= '';
		self.arr_off_lev					:= '';
		self.arr_statute					:= '';
		self.arr_statute_desc			:= '';
		self.arr_disp_code				:= pDOCOffenses.arr_disp_cd;
		self.le_agency_cd					:= '';
		self.le_agency_desc				:= '';
		self.le_agency_case_number:= '';
		self.traffic_ticket_number:= '';
		self.traffic_dl_no				:= '';
		self.traffic_dl_st				:= '';
		self.court_case_number		:= pDOCOffenses.case_num;
		self.court_appeal_flag		:= '';
		self.court_off_desc_1			:= pDOCOffenses.ct_off_desc_1;
		self.court_off_desc_2			:= pDOCOffenses.ct_off_desc_2;
		self.court_off_type_cd		:= '';
		self.court_off_type_desc	:= '';
		self.court_additional_statutes := '';
		self.court_final_plea			:= pDOCOffenses.ct_fnl_plea;
		self.court_off_code				:= pDOCOffenses.ct_off_code;
		self.court_off_lev				:= pDOCOffenses.ct_off_lev;
		self.court_statute				:= '';
		self.court_statute_desc		:= '';
		self.court_disp_date			:= pDOCOffenses.ct_disp_dt;
		self.court_disp_code			:= pDOCOffenses.ct_disp_cd;
		self.court_disp_desc_1		:= pDOCOffenses.ct_disp_desc_1;
		self.court_disp_desc_2		:= pDOCOffenses.ct_disp_desc_2;
		self.sent_date						:= pDOCOffenses.stc_dt;
		self.sent_jail						:= '';
		self.sent_susp_time				:= '';
		self.sent_court_cost			:= '';
		self.sent_court_fine			:= '';
		self.sent_susp_court_fine := '';
		self.sent_probation				:= '';
		self.sent_addl_prov_code	:= '';
		self.sent_addl_prov_desc_1 := '';
		self.sent_addl_prov_desc_2 := '';
		self.sent_consec					:= '';
		self.sent_agency_rec_cust_ori	:= '';
		self.sent_agency_rec_cust	:= '';
		self.appeal_date 					:= '';
		self.appeal_off_disp 			:= '';
		self.offense_town 				:= '';
		self.restitution 					:= '';
		self.community_service 		:= '';
		self.addl_sent_dates 			:= '';
		self.probation_desc2 			:= '';
		self.appeal_final_decision := '';
		self.pros_refer_cd				:= '';
		self.pros_refer						:= '';
		self.pros_assgn_cd				:= '';
		self.pros_assgn						:= '';
		self.pros_chg_rej					:= '';
		self.pros_off_code				:= '';
		self.pros_off_desc_1			:= '';
		self.pros_off_desc_2			:= '';
		self.pros_off_type_cd			:= '';
		self.pros_off_type_desc		:= '';
		self.pros_off_lev					:= '';
		self.pros_act_filed				:= '';
		self.court_dt							:= '';
		self.arr_off_lev_mapped		:= '';
		self.court_off_lev_mapped	:= '';
		//self.offense_category     := 0;
		self := pDOCOffenses;
	end;

	doc_off 		:= project(doc_offenses, ct_off(left));
	court_off  	:= Court_Offenses_Step3_Offense_Score;

//Concat DOC Offense and Court Offense Files
Offenses_Joined_temp := court_off + doc_off;

	Offenses_Joined_temp trecs(Offenses_Joined_temp L) := transform
		self.fcra_traffic_flag 	:= if(L.offense_score in set_Off,
										'Y',
										L.fcra_traffic_flag );
		self 					:= L;
	end;

all_offenses := project(Offenses_Joined_temp,trecs(left)):persist('~thor_data400::persist::CrimSrch_Offenses_Joined');

export Offenses_Joined := all_offenses;