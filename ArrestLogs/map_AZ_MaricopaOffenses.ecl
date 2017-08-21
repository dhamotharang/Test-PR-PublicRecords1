/*Now (jtao)
Text In Open Window
*/
import Crim_Common, Address, Gong;

p	:= Arrestlogs.file_AZ_Maricopa+Arrestlogs.Reformat_AZ_Maricopa_archive;

fMaricopa := p(trim(p.Name,left,right)<>'Name' and
			   trim(p.Name,left,right)<>'MALE' and
			   trim(p.Name,left,right)<>'FEMALE' and
			   trim(p.ID,left,right)<>'ID' and
			   trim(p.Race,left,right)<>'Race' and
			   trim(p.Hair,left,right)<>'Hair' and
			   trim(p.Eye,left,right)<>'Eye' and
			   trim(p.Weight,left,right)<>'Weight');

Crim_Common.Layout_In_Court_Offenses tMaricopa(fMaricopa input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=     intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
 +     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
 +     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date 				:= Crim_Common.Version_In_Arrest_Offenses;
self.offender_key 				:= (string)'AQ'+(integer)hash(trim(input.Name,all)+input.Sex[1]+fSlashedMDYtoCYMD(input.DOB)+input.Race[1..30]+fSlashedMDYtoCYMD(input.Date_Booked));
self.vendor 					:= 'AQ';
self.state_origin 				:= 'AZ';
self.source_file 				:= '(CV)AZ-MaricopaArrest';
self.off_comp 					:= input.cnt[1..3];
self.off_delete_flag 			:= '';
self.off_date 					:= '';
self.arr_date 					:= if((integer)length(regexreplace('\\/|\\-',input.Date_Booked,''))=8 and regexfind('[A-Z]',input.Date_Booked,0)='',
									regexreplace('\\/|\\-',input.Date_Booked,'')[5..8]+''+regexreplace('\\/|\\-',input.Date_Booked,'')[1..2]+''+regexreplace('\\/|\\-',input.Date_Booked,'')[3..4],
									'');
self.num_of_counts 				:= '';//need offense field 
self.le_agency_cd 				:= '';
self.le_agency_desc 			:= '';
self.le_agency_case_number 		:= '';
self.traffic_ticket_number 		:= '';
self.traffic_dl_no 				:= '';
self.traffic_dl_st 				:= '';
self.arr_off_code 				:= '';
self.arr_off_desc_1 			:= if(length(trim(regexreplace('MISDEMEANOR COUNT OF|'+'MISDEMEANORCOUNT OF|'+'FELONYCOUNT OF|'+'FELONY COUNT OF|'+'1ST DEG|'+'2ND DEG|'+'3RD DEG|'+'1ST DEGREE|'+'2ND DEGREE|'+'3RD DEGREE',input.cnt[4..60],''),left,right))>5,
									trim(regexreplace('MISDEMEANOR COUNT OF|'+'MISDEMEANORCOUNT OF|'+'FELONYCOUNT OF|'+'FELONY COUNT OF|'+'1ST DEG|'+'2ND DEG|'+'3RD DEG|'+'1ST DEGREE|'+'2ND DEGREE|'+'3RD DEGREE',trim(input.cnt,left,right)[4..60],''),left,right),
									'');
self.arr_off_desc_2 			:= '';
self.arr_off_type_cd 			:= '';
self.arr_off_type_desc 			:= '';
self.arr_off_lev 				:= if(regexfind('FELONY',input.cnt,0)<>'',
									'F',
									if(regexfind('MISDEMEAN',input.cnt,0)<>'',
									'M',''));
self.arr_statute 				:= '';
self.arr_statute_desc 			:= '';
self.arr_disp_date 				:= '';
self.arr_disp_code 				:= '';
self.arr_disp_desc_1 			:= 'BOOKED';
self.arr_disp_desc_2 			:= '';
self.pros_refer_cd 				:= '';
self.pros_refer 				:= '';
self.pros_assgn_cd 				:= '';
self.pros_assgn 				:= '';
self.pros_chg_rej 				:= '';
self.pros_off_code 				:= '';
self.pros_off_desc_1 			:= '';
self.pros_off_desc_2 			:= '';
self.pros_off_type_cd 			:= '';
self.pros_off_type_desc 		:= '';
self.pros_off_lev 				:= '';
self.pros_act_filed 			:= '';
self.court_case_number 			:= '';
self.court_cd 					:= '';
self.court_desc 				:= '';
self.court_appeal_flag 			:= '';
self.court_final_plea 			:= '';
self.court_off_code 			:= '';
self.court_off_desc_1 			:= '';
self.court_off_desc_2 			:= '';
self.court_off_type_cd 			:= '';
self.court_off_type_desc 		:= '';
self.court_off_lev 				:= '';
self.court_statute 				:= '';
self.court_additional_statutes 	:= '';
self.court_statute_desc 		:= '';
self.court_disp_date 			:= '';
self.court_disp_code 			:= '';
self.court_disp_desc_1	 		:= '';
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

pMaricopa 	:= project(fMaricopa,tMaricopa(left));
					
arrOut:= pMaricopa + ArrestLogs.FileAbinitioOffenses(vendor='AQ');

dd_arrOut := dedup(sort(distribute(arrOut,hash(offender_key)),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,source_file,local),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,local,left):
									PERSIST('~thor_dell400::persist::ArrestLogs_AZ_Maricopa_Offenses');

export map_AZ_MaricopaOffenses	:= dd_arrOut;