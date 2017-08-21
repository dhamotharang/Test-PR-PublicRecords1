import Crim_Common, Address, lib_date;

p1	:= ArrestLogs.file_CO_Pitkin;
p2  := ArrestLogs.file_CO_Pitkin_new;

newLayout := record
string ID;
string Name;
string DOB;
string Sex;
string Offense;
string book_dt;
string Bonds;
string Class;
end;

newLayout rPitkin1(p1 input) := transform
self.class 		:= '';
self.book_dt 	:= (string)LIB_Date.Date_MMDDYY_I2(regexreplace('/',input.book_dt,''));
self.dob		:= (string)LIB_Date.Date_MMDDYY_I2(regexreplace('/',input.dob,''));
self := input;
end;

pOld := project(p1,rPitkin1(left));

newLayout rPitkin2(p2 input) := transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.name 		:= if(trim(input.lastname,left,right)<>'' and trim(input.firstname,left,right)<>'' and trim(input.middlename)<>'',
					StringLib.StringToUpperCase(trim(input.lastname,left,right)+', '+trim(input.firstname,left,right)+' '+trim(input.middlename)),
					if(trim(input.lastname,left,right)<>'' and trim(input.firstname,left,right)<>'' and trim(input.middlename)='',
					StringLib.StringToUpperCase(trim(input.lastname,left,right)+', '+trim(input.firstname,left,right)),''));
self.book_dt 	:= if(StringLib.StringFind(input.arrest_date,'/',1)=2 and StringLib.StringFind(input.arrest_date,'/',2)=4,
					fSlashedMDYtoCYMD('0'+input.arrest_date[1..2]+'0'+input.arrest_date[3..8]),
					if(StringLib.StringFind(input.arrest_date,'/',1)=3 and StringLib.StringFind(input.arrest_date,'/',2)=5,
					fSlashedMDYtoCYMD(input.arrest_date[1..3]+'0'+input.arrest_date[4..9]),
					if(StringLib.StringFind(input.arrest_date,'/',1)=2 and StringLib.StringFind(input.arrest_date,'/',2)=5,
					fSlashedMDYtoCYMD('0'+input.arrest_date[1..9]),
					if(StringLib.StringFind(input.arrest_date,'/',1)=3 and StringLib.StringFind(input.arrest_date,'/',2)=6,
					fSlashedMDYtoCYMD(input.arrest_date[1..10]),
					''))));
self.dob 		:= if(StringLib.StringFind(input.dob,'/',1)=2 and StringLib.StringFind(input.dob,'/',2)=4,
					fSlashedMDYtoCYMD('0'+input.dob[1..2]+'0'+input.dob[3..8]),
					if(StringLib.StringFind(input.dob,'/',1)=3 and StringLib.StringFind(input.dob,'/',2)=5,
					fSlashedMDYtoCYMD(input.dob[1..3]+'0'+input.dob[4..9]),
					if(StringLib.StringFind(input.dob,'/',1)=2 and StringLib.StringFind(input.dob,'/',2)=5,
					fSlashedMDYtoCYMD('0'+input.dob[1..9]),
					if(StringLib.StringFind(input.dob,'/',1)=3 and StringLib.StringFind(input.dob,'/',2)=6,
					fSlashedMDYtoCYMD(input.dob),
					''))));
self := input;
end;

pNew := project(p2,rPitkin2(left));

p	:= pOld+pNew;

fPitkin := p(trim(p.Name,left,right) ~in ['Name','LASTNAME, FIRSTNAME MIDDLENAME']);

Crim_Common.Layout_In_Court_Offenses tPitkin(fPitkin input) := Transform

self.process_date 				:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key 				:= (string)'D8'+(integer)hash(trim(input.name,all))+lib_date.Date_MMDDYY_I2(regexreplace('/',input.Book_Dt,''));
self.vendor 					:= 'D8';//NEED TO UPDATE
self.state_origin 				:= 'CO';
self.source_file 				:= '(CV)CO-PitkinCtyArr';
self.off_comp 					:= '';
self.off_delete_flag 			:= '';
self.off_date 					:= '';
self.arr_date 					:= trim(input.book_dt,left,right);
self.num_of_counts 				:= '';
self.le_agency_cd 				:= '';
self.le_agency_desc 			:= '';
self.le_agency_case_number 		:= '';
self.traffic_ticket_number 		:= '';
self.traffic_dl_no 				:= '';
self.traffic_dl_st 				:= '';
self.arr_off_code 				:= '';
self.arr_off_desc_1 			:= regexreplace('\\( \\)',
									regexreplace(':|1ST|2ND|3RD|DEGREE|MISDEMEANOR|(MISDEMEANOR)',StringLib.StringToUpperCase(input.offense),' '),
									'');
self.arr_off_desc_2 			:= '';
self.arr_off_type_cd 			:= '';
self.arr_off_type_desc 			:= '';
self.arr_off_lev 				:= '';
self.arr_statute 				:= '';
self.arr_statute_desc 			:= '';
self.arr_disp_date 				:= '';
self.arr_disp_code 				:= '';
self.arr_disp_desc_1 			:= '';
self.arr_disp_desc_2 			:= if(regexfind('0.00|NO BOND|00000|Bond|\\$',input.bonds,0)='' and trim(input.bonds,left,right) ~in ['0',''],
									'BOND AMT $'+Arrestlogs.FormatMoney((integer)input.bonds),
								    if(regexfind('\\$',input.bonds,0)<>'' and trim(input.bonds,left,right)~in ['0','','$0.00','$ 0.00'],
									'BOND AMT '+regexreplace('\\$0.00;|\\$0.00|\\$ 0.00',input.bonds,''),
									''));
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

pPitkin := project(fPitkin,tPitkin(left));

//arrOut:= pPitkin + ArrestLogs.FileAbinitioOffenses(vendor='');

dd_arrOut:= dedup(sort(distribute(pPitkin,hash(offender_key)),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,source_file,local),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,local,left):
									PERSIST('~thor_dell400::persist::ArrestLogs_CO_Pitkin_Offenses');

export Map_CO_PitkinOffenses := dd_arrOut;