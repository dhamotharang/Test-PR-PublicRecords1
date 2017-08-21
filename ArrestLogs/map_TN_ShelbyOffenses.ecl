import Crim_Common, Address;

p	:= ArrestLogs.file_TN_Shelby;

bShelby := p(regexfind('Warning</B>|'+'Warning :', p.Name)<>(boolean)'true');

fShelby := bShelby(trim(p.ID,left,right)<>'ID' and
			   trim(p.Name,left,right)<>'Name' and 
			   trim(p.Name,left,right)<>'LAST FIRST' and
			   trim(p.Booked,left,right)<>'Booked');

Crim_Common.Layout_In_Court_Offenses tShelby(fShelby input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=     intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
 +     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
 +     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date 				:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key 				:= (string)'A6'+(integer)hash(input.booked+input.RNI_Num);
								   /*An RNI number is supposed to be a unique number that has been linked via fingerprints to the individual*/
self.vendor 					:= 'A6';
self.state_origin 				:= 'TN';
self.source_file 				:= '(CV)TN-ShelbyCtyArr';
self.off_comp 					:= '';
self.off_delete_flag 			:= '';
self.off_date 					:= '';
self.arr_date 					:= if(fSlashedMDYtoCYMD(if(trim(input.booked,left,right)<>'' and trim(input.booked,left,right)<>'0',
								if(trim(input.booked[1..3],left,right) = 'Jan', '01/'+regexreplace(' 2',trim(input.booked[5..11],left,right),'/2'),
								if(trim(input.booked[1..3],left,right) = 'Feb', '02/'+regexreplace(' 2',trim(input.booked[5..11],left,right),'/2'),
								if(trim(input.booked[1..3],left,right) = 'Mar', '03/'+regexreplace(' 2',trim(input.booked[5..11],left,right),'/2'),
								if(trim(input.booked[1..3],left,right) = 'Apr', '04/'+regexreplace(' 2',trim(input.booked[5..11],left,right),'/2'),
								if(trim(input.booked[1..3],left,right) = 'May', '05/'+regexreplace(' 2',trim(input.booked[5..11],left,right),'/2'),
								if(trim(input.booked[1..3],left,right) = 'Jun', '06/'+regexreplace(' 2',trim(input.booked[5..11],left,right),'/2'),
								if(trim(input.booked[1..3],left,right) = 'Jul', '07/'+regexreplace(' 2',trim(input.booked[5..11],left,right),'/2'),
								if(trim(input.booked[1..3],left,right) = 'Aug', '08/'+regexreplace(' 2',trim(input.booked[5..11],left,right),'/2'),
								if(trim(input.booked[1..3],left,right) = 'Sep', '09/'+regexreplace(' 2',trim(input.booked[5..11],left,right),'/2'),
								if(trim(input.booked[1..3],left,right) = 'Oct', '10/'+regexreplace(' 2',trim(input.booked[5..11],left,right),'/2'),
								if(trim(input.booked[1..3],left,right) = 'Nov', '11/'+regexreplace(' 2',trim(input.booked[5..11],left,right),'/2'),
								if(trim(input.booked[1..3],left,right) = 'Dec', '12/'+regexreplace(' 2',trim(input.booked[5..11],left,right),'/2'), '')))))))))))),''))[1..3] <> '000',						
								fSlashedMDYtoCYMD(if(trim(input.booked,left,right)<>'' and trim(input.booked,left,right)<>'0',
								if(trim(input.booked[1..3],left,right) = 'Jan', '01/'+regexreplace(' 2',trim(input.booked[5..11],left,right),'/2'),
								if(trim(input.booked[1..3],left,right) = 'Feb', '02/'+regexreplace(' 2',trim(input.booked[5..11],left,right),'/2'),
								if(trim(input.booked[1..3],left,right) = 'Mar', '03/'+regexreplace(' 2',trim(input.booked[5..11],left,right),'/2'),
								if(trim(input.booked[1..3],left,right) = 'Apr', '04/'+regexreplace(' 2',trim(input.booked[5..11],left,right),'/2'),
								if(trim(input.booked[1..3],left,right) = 'May', '05/'+regexreplace(' 2',trim(input.booked[5..11],left,right),'/2'),
								if(trim(input.booked[1..3],left,right) = 'Jun', '06/'+regexreplace(' 2',trim(input.booked[5..11],left,right),'/2'),
								if(trim(input.booked[1..3],left,right) = 'Jul', '07/'+regexreplace(' 2',trim(input.booked[5..11],left,right),'/2'),
								if(trim(input.booked[1..3],left,right) = 'Aug', '08/'+regexreplace(' 2',trim(input.booked[5..11],left,right),'/2'),
								if(trim(input.booked[1..3],left,right) = 'Sep', '09/'+regexreplace(' 2',trim(input.booked[5..11],left,right),'/2'),
								if(trim(input.booked[1..3],left,right) = 'Oct', '10/'+regexreplace(' 2',trim(input.booked[5..11],left,right),'/2'),
								if(trim(input.booked[1..3],left,right) = 'Nov', '11/'+regexreplace(' 2',trim(input.booked[5..11],left,right),'/2'),
								if(trim(input.booked[1..3],left,right) = 'Dec', '12/'+regexreplace(' 2',trim(input.booked[5..11],left,right),'/2'), '')))))))))))),'')),
								'');
self.num_of_counts 				:= '';
self.le_agency_cd 				:= '';
self.le_agency_desc 			:= '';
self.le_agency_case_number 		:= '';
self.traffic_ticket_number 		:= '';
self.traffic_dl_no 				:= '';
self.traffic_dl_st 				:= '';
self.arr_off_code 				:= '';
self.arr_off_desc_1 			:= if(input.Crim_Bond_Descr <> '', 
									  regexreplace('  M  ',input.Crim_Bond_Descr,''),
								   if(input.Gen_Bond_Descr <> '',
									  regexreplace('FIRST DEGREE |'+'SECOND DEGREE |'+'THIRD DEGREE',input.Gen_Bond_Descr,''),
								     ''));
self.arr_off_desc_2 			:= if(trim(input.crim_bail_amt,left,right) <> '0' and trim(input.crim_bail_amt,left,right) <> '' and trim(input.crim_bail_amt,left,right) <> '0.00',
								      'CRIM BAIL AMT $ '+Arrestlogs.FormatMoney((integer)input.crim_bail_amt),
								   if(trim(input.gen_bail_amt,left,right) <> '0' and trim(input.gen_bail_amt,left,right) <> '' and trim(input.gen_bail_amt,left,right) <> '0.00',
									 'GEN BAIL AMT '+'$'+Arrestlogs.FormatMoney((integer)input.gen_bail_amt),
								     ''));
self.arr_off_type_cd 			:= '';
self.arr_off_type_desc 			:= '';
self.arr_off_lev 				:= if(regexfind('FIRST DEGREE',input.Gen_Bond_Descr) = (boolean)'true', 
									  '1ST',
								   if(regexfind('SECOND DEGREE',input.Gen_Bond_Descr) = (boolean)'true',
									  '2ND',
								   if(regexfind('THIRD DEGREE',input.Gen_Bond_Descr) = (boolean)'true',
									  '3RD',
									  '')));
self.arr_statute 				:= '';
self.arr_statute_desc 			:= '';
self.arr_disp_date 				:= '';
self.arr_disp_code 				:= '';
self.arr_disp_desc_1 			:= '';
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

pShelby := project(fShelby,tShelby(left));

arrOut:= pShelby + ArrestLogs.FileAbinitioOffenses(vendor='A6');

dd_arrOut:= dedup(sort(distribute(arrOut(arr_off_desc_1 <> ''),hash(offender_key)),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,source_file,local),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,local,left)
									:PERSIST('~thor_dell400::persist::ArrestLogs_TN_Shelby_Offenses');

export map_TN_ShelbyOffenses	:= dd_arrOut;
									
						