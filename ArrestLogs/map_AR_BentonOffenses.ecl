import Crim_Common, Address;

d:= ArrestLogs.file_AR_Benton((ID) <> 'ID' and (charge)<>'CHARGE');

//HFilter  := ArrestLogs.file_AR_Benton(regexfind(' FirstName ', FirstName)<>(boolean)'TRUE');

fBenton := d(trim(d.LastName,left,right)<>'Last Name' and
			   trim(d.FirstName,left,right)<>'First Name' and
			   trim(d.MiddleName,left,right)<>'Middle Name');

tempLayout := record
fBenton.ID;
fBenton.LastName;
fBenton.FirstName;
fBenton.MiddleName;
fBenton.Admit_Date;
fBenton.Charge;
fBenton.Court_Type;
fBenton.Arresting_Agency;
fBenton.Bond;
fBenton.Bond_type;
fBenton.Offense_Date;

num_ofcounts := count(group);
end;

tblBenton := table(fBenton,tempLayout,id, LastName,FirstName,MiddleName,Admit_Date,Charge,few);

Crim_Common.Layout_In_Court_Offenses tBenton(tblBenton input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=     intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
 +     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
 +     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date 				:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key 				:= 'AU'+input.ID+input.Offense_Date;
self.vendor 					:= 'AU';
self.state_origin 				:= 'AR';
self.source_file 				:= 'AR-Benton_CO';
self.off_comp 					:= '';
self.off_delete_flag 			:= '';
self.off_date 					:= if(fSlashedMDYtoCYMD(input.Offense_Date) between '19010101' and Crim_Common.Version_Development,
										fSlashedMDYtoCYMD(input.Offense_Date) , '');
										
self.arr_date 					:= if(fSlashedMDYtoCYMD(input.Admit_Date) < Crim_Common.Version_In_Arrest_Offender
									and fSlashedMDYtoCYMD(input.Admit_Date)[1..2] in ['19','20'],
									fSlashedMDYtoCYMD(input.Admit_Date),
									if(fSlashedMDYtoCYMD(input.MiddleName)[1..2] in ['19','20'],
									fSlashedMDYtoCYMD(input.MiddleName),''));
self.num_of_counts 				:= '';//(string)input.num_ofcounts;
self.le_agency_cd 				:= '';
self.le_agency_desc 			:= if(length(trim(input.Arresting_Agency,left,right))>=4,
									StringLib.StringToUpperCase(trim(input.Arresting_Agency,left,right)),
									'');
self.le_agency_case_number 		:= '';
self.traffic_ticket_number 		:= '';
self.traffic_dl_no 				:= '';
self.traffic_dl_st 				:= '';
self.arr_off_code 				:= '';
self.arr_off_desc_1 			:= if(length(trim(input.charge,left,right))>=4 and regexfind('[A-Z]+',trim(input.charge,left,right),0)<>'' and regexfind('- Held',trim(input.charge,left,right),0)='',
									trim(input.charge,left,right),
									'');
self.arr_off_desc_2 			:= '';
self.arr_off_type_cd 			:= '';
self.arr_off_type_desc 			:= '';
self.arr_off_lev 				:= '';
self.arr_statute 				:= '';
self.arr_statute_desc 			:= '';
self.arr_disp_date 				:= if(fSlashedMDYtoCYMD(input.Admit_Date) < Crim_Common.Version_In_Arrest_Offender
									and fSlashedMDYtoCYMD(input.Admit_Date)[1..2] in ['19','20'],
									fSlashedMDYtoCYMD(input.Admit_Date),
									if(fSlashedMDYtoCYMD(input.MiddleName)[1..2] in ['19','20'],
									fSlashedMDYtoCYMD(input.MiddleName),''));
self.arr_disp_code 				:= '';
self.arr_disp_desc_1 			:= 'BOOKED';
self.arr_disp_desc_2 			:=  if(trim(input.bond,left,right) <> '0' and
trim(input.bond,left,right) <> '' and trim(input.bond,left,right) <> '$',
                                     ('BOND AMT/TYPE '+trim(input.bond,left,right)+' '+trim(input.bond_type,left,right)),
                                     '');
								   
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
self.court_desc 				:= stringlib.stringtouppercase(input.Court_Type); 
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

pBenton := project(tblBenton,tBenton(left));

arrOut:= pBenton + ArrestLogs.FileAbinitioOffenses(vendor='AU');

dd_arrOut:= dedup(sort(distribute(arrOut,hash(offender_key)),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_desc_1,arr_disp_date,local),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_desc_1,local,right):
									PERSIST('~thor_dell400::persist::ArrestLogs_AR_Benton_Offenses');

export map_AR_BentonOffenses:= dd_arrOut;