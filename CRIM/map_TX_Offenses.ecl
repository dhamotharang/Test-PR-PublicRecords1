import Crim_Common,ut;

d := crim.File_TX_Statewide.cmbndFile;

Crim_Common.Layout_In_Court_Offenses tTXCrim(d input) := Transform

//---
string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);
//---
string8     getReasonableRange(string newDateIn) 
:=    map((newDateIn[1..2] between '19' and '20') and 
			(newDateIn < ut.GetDate) => newDateIn,'');
//---	
  string court_off_desc_1 		:=   if(input.col_txt = ''
									 ,input.con_cod[stringlib.stringfind(input.con_cod,'~',2)+1..75]
									 ,input.col_txt);
									 
  self.process_date 			:= Crim_Common.Version_In_Arrest_Offender;
 
  self.vendor 					:= '01';
  self.state_origin 			:= 'TX';
  self.source_file		   	 	:= 'TX DEPT OF PUB SFTY';
  self.off_comp 				:= if(stringlib.stringfilter(input.trs_cod,'[0-9]') = '00','',stringlib.stringfilter(input.trs_cod,'[0-9]'))+input.seq_cod;
  self.off_delete_flag 			:= '';
  self.off_date 				:= getReasonableRange(fSlashedMDYtoCYMD(input.doo_dte));
  self.arr_date 				:= getReasonableRange(fSlashedMDYtoCYMD(input.doa_dte));
  self.num_of_counts 			:= '';
  self.le_agency_cd 			:= '';
  self.le_agency_desc 			:= '';
  self.le_agency_case_number 	:= '';
  self.traffic_ticket_number 	:= '';
  self.traffic_dl_no 			:= '';
  self.traffic_dl_st 			:= '';
  self.arr_off_code 			:= '';
  self.arr_off_desc_1 			:= if(input.aol_txt = ''
									 ,input.aon_cod[stringlib.stringfind(input.aon_cod,'~',2)+1..75]
									 ,input.aol_txt);
  self.arr_off_desc_2			:= '';
  self.arr_off_type_cd 			:= '';
  self.arr_off_type_desc 		:= input.goc_cod;
  self.arr_off_lev 				:= input.lda_cod;
  self.arr_statute		 		:= '';
  self.arr_statute_desc 		:= input.aol_txt;
  self.arr_disp_date 			:= getReasonableRange(fSlashedMDYtoCYMD(input.ada_dte));
  self.arr_disp_code 			:= input.adn_cod;
  self.arr_disp_desc_1 			:= if(input.add_cod = '',input.adn_cod,input.add_cod);
  self.arr_disp_desc_2 			:= '';
  self.pros_refer_cd 			:= '';
  self.pros_refer 				:= input.ref_txt;
  self.pros_assgn_cd 			:= input.agy_txt[1..stringlib.stringfind(input.agy_txt,'~',1)-1];
  self.pros_assgn 				:= regexreplace('ONLY',regexreplace('FOR NCIC 2000 DATA CONVERSION PURPOSES',input.agy_txt[stringlib.stringfind(input.agy_txt,'~',1)+1..50],''),'');
  self.pros_chg_rej 			:= '';
  self.pros_off_code 			:= '';
  self.pros_off_desc_1 			:= if(input.pol_txt = ''
									 ,input.pon_cod[stringlib.stringfind(input.pon_cod,'~',2)+1..75]
									 ,input.pol_txt);
  self.pros_off_desc_2 			:= '';
  self.pros_off_type_cd 		:= '';
  self.pros_off_type_desc		:= input.goc_cod;
  self.pros_off_lev 			:= input.ldp_cod;
  self.pros_act_filed 			:= map(input.paf_cod = 'A' => 'PROSECUTOR ACCEPTS THE CHARGE'
									  ,input.paf_cod = 'B' => 'NO BILL'
									  ,input.paf_cod = 'C' => 'PROSECUTOR HAS CHANGED THE CHARGE'
									  ,input.paf_cod = 'D' => 'CHARGES DROPPED BY ARRESTING AGENCY'
									  ,input.paf_cod = 'F' => 'PRE-TRIAL DIVERSION WITH FILING'
									  ,input.paf_cod = 'J' => 'JUVENILE CHARGE ADDED BY THE PROSECUTOR'
									  ,input.paf_cod = 'N' => 'PROSECUTOR HAS REJECTED THE CHARGE WITHOUT A PRETRIAL DIVERSION'
									  ,input.paf_cod = 'O' => 'PROSECUTION ACTION UNDEFINED BY PAF CODE'
									  ,input.paf_cod = 'R' => 'REDUCED TO CLASS C'
									  ,input.paf_cod = 'T' => 'TAKEN INTO CONSIDERATION'
									  ,input.paf_cod = 'W' => 'WITHDRAWN BY COMPLAINANT'
									  ,input.paf_cod = 'Y' => 'PROSECUTOR HAS REJECTED THE CHARGE SUCCESSFULL PRETRIAL DIVERSION'
									  ,'');
  self.court_case_number 		:= input.cau_nbr;
  self.court_cd 				:= input.agy_txt[1..stringlib.stringfind(input.agy_txt,'~',1)-1];
  self.court_desc 				:= map(input.agy_txt[stringlib.stringfind(input.agy_txt,'~',1)+1..40] = 'FOR NCIC 2000 DATA CONVERSION PURPOSES' or
									input.agy_txt[stringlib.stringfind(input.agy_txt,'~',1)+1..40] = 'ONLY'
										=> ''
										,input.agy_txt[stringlib.stringfind(input.agy_txt,'~',1)+1..40]);
  self.court_appeal_flag 		:= '';
  self.court_final_plea 		:= input.fpo_cod;
  self.court_off_code 			:= '';
  self.court_off_desc_1 		:= map(court_off_desc_1 = '' and input.dmv_cod = 'Y' => 'DOMESTIC VIOLENCE',court_off_desc_1);
  
  self.court_off_desc_2 		:= '';
  self.court_off_type_cd 		:= '';
  self.court_off_type_desc 		:= input.goc_cod;
  self.court_off_lev 			:= input.ldc_cod;
  self.court_statute			:= '';
  self.court_additional_statutes:= '';
  self.court_statute_desc 		:= '';
  self.court_disp_date 			:= getReasonableRange(fSlashedMDYtoCYMD(input.cdd_dte));
  self.court_disp_code 			:= '';
  self.court_disp_desc_1 		:= input.cdn_cod;
  self.court_disp_desc_2 		:= '';
  self.sent_date 				:= getReasonableRange(fSlashedMDYtoCYMD(input.dos_dte));
  self.sent_jail 				:= if(regexfind('[0-9]',input.cmt_cod)
									  ,regexreplace('D',regexreplace('M',regexreplace('Y',input.cmt_cod,' YEARS '),' MONTHS '),' DAYS ')
									  ,input.cmt_cod);
  self.sent_susp_time 			:= if(regexfind('[0-9]',input.css_cod)
									,regexreplace('D',regexreplace('M',regexreplace('Y',input.css_cod,' YEARS '),' MONTHS '),' DAYS ')
									,input.css_cod);
  self.sent_court_cost 			:= map(input.cst_qty <>'' and input.cst_qty <>'0' => input.cst_qty + '00','');
  self.sent_court_fine 			:= map(input.cfn_qty <>'' and input.cfn_qty <>'0' => input.cfn_qty + '00','');
  self.sent_susp_court_fine 	:= map(input.csf_qty <>'' and input.csf_qty <>'0' => input.csf_qty + '00','');
  self.sent_probation 			:= if(regexfind('[0-9]',input.cpr_cod)
									,regexreplace('D',regexreplace('M',regexreplace('Y',input.cpr_cod,' YEARS '),' MONTHS '),' DAYS ')
									,input.cpr_cod);
  self.sent_addl_prov_code 		:= '';
  self.sent_addl_prov_desc_1 	:= input.cpn_nbr;
  self.sent_addl_prov_desc_2 	:= input.cpl_txt;
  self.sent_consec 				:= input.mcc_cod; // CC = Concurrently, CS = Consecutively
  self.sent_agency_rec_cust_ori := '';
  self.sent_agency_rec_cust 	:= map(input.arc_txt[stringlib.stringfind(input.arc_txt,'~',1)+1..40] = 'FOR NCIC 2000 DATA CONVERSION PURPOSES' or
									input.arc_txt[stringlib.stringfind(input.arc_txt,'~',1)+1..40] = 'ONLY'
										=> ''
										,input.arc_txt[stringlib.stringfind(input.arc_txt,'~',1)+1..40]);
  self.appeal_date 				:= getReasonableRange(fSlashedMDYtoCYMD(input.dca_dte));
  self.appeal_off_disp 			:= input.dda_cod;
  self.appeal_final_decision 	:= input.fcd_cod;


  self.offender_key 			:= self.vendor + if(input.dps_number='',input.per_idn,input.dps_number);
end;

pTXCrim := project(d,tTXCrim(left));

ddTXOffend:= dedup(sort(distribute(pTXCrim(arr_off_desc_1+arr_statute_desc+pros_act_filed+court_case_number+court_statute+court_statute_desc+court_off_code+court_off_desc_1+off_date+arr_date+court_disp_date+appeal_date <> ''),hash(offender_key)),
									offender_key,off_comp,arr_off_desc_1,arr_statute_desc,pros_act_filed,court_case_number,court_statute,court_statute_desc,court_off_code,court_off_desc_1,off_date,arr_date,court_disp_date,appeal_date,local),
									offender_key,off_comp,arr_off_desc_1,arr_statute_desc,pros_act_filed,court_case_number,court_statute,court_statute_desc,court_off_code,court_off_desc_1,off_date,arr_date,local,right):
									PERSIST('~thor_dell400::persist::Crim_TX_Statewide_Offenses_Clean');




export map_TX_Offenses := ddTXOffend;