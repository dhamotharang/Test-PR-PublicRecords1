import Crim_Common, Address;

p	:= ArrestLogs.file_FL_PalmBeach;
   
ArrestLogs.Layout_FL_PalmBeach_new2 sPalmBeach(p input) := Transform
self.Original_Bond := '';
self.Current_Bond := '';
self.Release_Dt := '';
self.Release_Time := '';
self.Other_Agency_Holds := '';
self.Warrant_Num := '';
self.Jacket_Num := '';
self := input;
end;

rPalmBeach := project(p, sPalmBeach(left));

p2 := ArrestLogs.File_FL_PalmBeach_new;

ArrestLogs.Layout_FL_PalmBeach_new2 sPalmBeach2(p2 input) := Transform
self.Release_Dt := '';
self.Release_Time := '';
self.Other_Agency_Holds := '';
self.Warrant_Num := '';
self.Jacket_Num := '';
self := input;
end;

r2PalmBeach := project(p2, sPalmBeach2(left));

p3	:= rPalmBeach+r2PalmBeach+ArrestLogs.file_FL_PalmBeach_new2;

fPalmBeach := p3(trim(p3.Name,left,right)<>'Name' and
			   trim(p3.Race,left,right)<>'Race' and
			   trim(p3.DOB,left,right)<>'DOB');     

Crim_Common.Layout_In_Court_Offenses tPalmBeach(fPalmBeach input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=     intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
 +     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
 +     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date 				:= Crim_Common.Version_In_Arrest_Offenses;
self.offender_key 				:= 'AM'+trim(input.book_num,left,right)+fSlashedMDYtoCYMD(input.Book_Dt)+input.ID;
self.vendor 					:= 'AM';
self.state_origin 				:= 'FL';
self.source_file 				:= '(CV)FL-PalmBeachArrest';
self.off_comp 					:= '';
self.off_delete_flag 			:= '';
self.off_date 					:= '';
self.arr_date 					:= if(fSlashedMDYtoCYMD(input.book_dt) < Crim_Common.Version_In_Arrest_Offenses and
									  fSlashedMDYtoCYMD(input.book_dt) <>'00000000',
									  fSlashedMDYtoCYMD(input.book_dt),
									  '');
self.num_of_counts 				:= '';
self.le_agency_cd 				:= trim(input.arresting_agency,left,right)[1..2];
self.le_agency_desc 			:= trim(regexreplace('[0-9]|'+'-', input.arresting_agency,''),left,right);
self.le_agency_case_number 		:= '';
self.traffic_ticket_number 		:= '';
self.traffic_dl_no 				:= '';
self.traffic_dl_st 				:= '';
self.arr_off_code 				:= if(input.charge_num<>'*',input.charge_num,'');
self.arr_off_desc_1 			:= regexreplace('&quot;', trim(input.charge,left,right),''),
//self.arr_off_desc_1 			:= if(length(trim(input.charge,left,right))>4 and 
//									regexfind('CASE#|CASE #|CA SE #|JUDGE|JDUGE|JDG|JG.',trim(input.charge,left,right),0)='',
//									regexreplace('[0-9]|\\.|\\$|CT I II|CAS#|,|\\(|\\)|1ST|2ND|3RD|RE-COMMIT|RECOMMIT|-COMMIT|&quot;|WEEKENDER|:|CS#|DEGREE|[0-9].|CT [0-9]|[0-9]\\)|\\(3F\\)|-',
//									trim(input.charge,left,right),' '),
//									'');
self.arr_off_desc_2 			:= '';
self.arr_off_type_cd 			:= '';
self.arr_off_type_desc 			:= '';
self.arr_off_lev 				:= '';
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

pPalmBeach := project(fPalmBeach,tPalmBeach(left));

arrOut:= pPalmBeach(arr_off_code<>''and arr_off_desc_1<>'');
// + ArrestLogs.FileAbinitioOffenses(vendor='AI'); NOT KEEPING HISTORY

dd_arrOut := dedup(sort(distribute(arrOut,hash(offender_key)),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,source_file,local),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,local,right):
									PERSIST('~thor_dell400::persist::ArrestLogs_FL_PalmBeach_Offenses');

export map_FL_PalmBeachOffenses	:= dd_arrOut;