import Crim_Common, Address, ut;

p	:= ArrestLogs.file_GA_Dawson;

/*p	:=	dataset(ut.foreign_prod + '~thor_data400::in::Dawson.ga.individuals.06072007.txt',
	ArrestLogs.layout_GA_Dawson,csv(heading(1),terminator('\n'), separator('|')));*/

fDawson := p(trim(p.book_num,left,right)<>'book num' and trim(p.total_bond,left,right)<>'Total Bond');

Crim_Common.Layout_In_Court_Offenses tDawson(fDawson input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=     intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
 +     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
 +     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date 				:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key 				:= (string)'D7'+(integer)hash(trim(input.name,all)+fSlashedMDYtoCYMD(input.DOB)+input.book_num);
self.vendor 					:= 'D7';//REMEMBER TO UPDATE
self.state_origin 				:= 'GA';
self.source_file 				:= '(CV)GA-DawsonCtyArr';
self.off_comp 					:= '';
self.off_delete_flag 			:= '';
self.off_date 					:= '';
self.arr_date 					:= if(fSlashedMDYtoCYMD(input.arrest_date)<>'00000000',
									fSlashedMDYtoCYMD(input.arrest_date),'');
self.num_of_counts 				:= '';
self.le_agency_cd 				:= '';
self.le_agency_desc 			:= '';
self.le_agency_case_number 		:= input.book_num;
self.traffic_ticket_number 		:= '';
self.traffic_dl_no 				:= '';
self.traffic_dl_st 				:= '';
self.arr_off_code 				:= '';
self.arr_off_desc_1 			:= MAP((stringlib.stringfind(input.offense2,'AGGRAVATED ASSAULT',1)>0) =>'AGGRAVATED ASSAULT',
									(stringlib.stringfind(input.offense2,'AGGRAVATED BATTERY',1)>0) =>'AGGRAVATED BATTERY',
									(stringlib.stringfind(input.offense2,'AGGRAVATED STALKING',1)>0) =>'AGGRAVATED STALKING',
									(stringlib.stringfind(input.offense2,'AWAITING SENTENCING',1)>0) =>'AWAITING SENTENCING',
									(stringlib.stringfind(input.offense2,'BATTERY',1)>0) =>'BATTERY',
									(stringlib.stringfind(input.offense2,'BENCH WARRANT',1)>0) =>'BENCH WARRANT',
									(stringlib.stringfind(input.offense2,'BOARDING FOR ANOTHER AGENCY',1)>0) =>'BOARDING FOR ANOTHER AGENCY',
									(stringlib.stringfind(input.offense2,'BOARDING',1)>0) =>'BOARDING',
									(stringlib.stringfind(input.offense2,'BURGLARY',1)>0) =>'BURGLARY',
									(stringlib.stringfind(input.offense2,'CHARGES PENDING',1)>0) =>'CHARGES PENDING',
									(stringlib.stringfind(input.offense2,'CHILD MOLESTATION',1)>0) =>'CHILD MOLESTATION',
									(stringlib.stringfind(input.offense2,'CONTEMPT OF COURT',1)>0) =>'CONTEMPT OF COURT',
									(stringlib.stringfind(input.offense2,'FRAUD',1)>0) =>'FRAUD',
									(stringlib.stringfind(input.offense2,'DAMAGE TO PROPERTY',1)>0) =>'DAMAGE TO PROPERTY',
									(stringlib.stringfind(input.offense2,'CRIMINAL TRESPASS',1)>0) =>'CRIMINAL TRESPASS',
									(stringlib.stringfind(input.offense2,'DRINKING UNDER AGE',1)>0) =>'DRINKING UNDER AGE',
									(stringlib.stringfind(input.offense2,'DRIVING WITH SUSPEND',1)>0) =>'DRIVING WITH SUSPEND LICENSE',
									(stringlib.stringfind(input.offense2,'DRIVING WITH REVOKE',1)>0) =>'DRIVING WITH REVOKE LICENSE',
									(stringlib.stringfind(input.offense2,'DUI',1)>0) =>'DUI',
									(stringlib.stringfind(input.offense2,'ESCAPE',1)>0) =>'ESCAPE',
									(stringlib.stringfind(input.offense2,'FAIL TO DIM HEADLIGHTS',1)>0) =>'FAIL TO DIM HEADLIGHTS',
									(stringlib.stringfind(input.offense2,'FAILURE TO PAY CHILD SUPPORT',1)>0) =>'FAILURE TO PAY CHILD SUPPORT',
									(stringlib.stringfind(input.offense2,'FALSE IMPRISONMENT',1)>0) =>'FALSE IMPRISONMENT',
									(stringlib.stringfind(input.offense2,'FALSE STATMENTS & WRITINGS',1)>0) =>'FALSE STATMENTS & WRITINGS',
									(stringlib.stringfind(input.offense2,'THEFT',1)>0) =>'THEFT',
									(stringlib.stringfind(input.offense2,'FORGERY',1)>0) =>'FORGERY',
									(stringlib.stringfind(input.offense2,'IMPROPER LANE USAGE',1)>0) =>'IMPROPER LANE USAGE',
									(stringlib.stringfind(input.offense2,'INTERFERENCE W/ A 911 CALL',1)>0) =>'INTERFERENCE W/ A 911 CALL',
									(stringlib.stringfind(input.offense2,'KIDNAPPING',1)>0) =>'KIDNAPPING',
									(stringlib.stringfind(input.offense2,'LEAVING ACCIDENT',1)>0) =>'LEAVING ACCIDENT',
									(stringlib.stringfind(input.offense2,'DRUG VIO',1)>0) =>'DRUG VIOLATION',
									(stringlib.stringfind(input.offense2,'DRUG REL',1)>0) =>'DRUG VIOLATION',
									(stringlib.stringfind(input.offense2,'HEROIN',1)>0) =>'DRUG VIOLATION',
									(stringlib.stringfind(input.offense2,'COCAI',1)>0) =>'DRUG VIOLATION',
									(stringlib.stringfind(input.offense2,'CRACK',1)>0) =>'DRUG VIOLATION',
									(stringlib.stringfind(input.offense2,'MARIJUANA PLANTS',1)>0) =>'DRUG EQUIPMENT VIOLATION',
									(stringlib.stringfind(input.offense2,'MARIJ',1)>0) =>'DRUG VIOLATION',
									(stringlib.stringfind(input.offense2,'XANAX',1)>0) =>'DRUG VIOLATION',
									(stringlib.stringfind(input.offense2,'MDMA',1)>0) =>'DRUG VIOLATION',
									(stringlib.stringfind(input.offense2,'ECSTAC',1)>0) =>'DRUG VIOLATION',
									(stringlib.stringfind(input.offense2,'VALIUM',1)>0) =>'DRUG VIOLATION',
									(stringlib.stringfind(input.offense2,'OXYCOD',1)>0) =>'DRUG VIOLATION',
									(stringlib.stringfind(input.offense2,'CANNIBAS',1)>0) =>'DRUG VIOLATION',
									(stringlib.stringfind(input.offense2,' METH ',1)>0) =>'DRUG VIOLATION',
									(stringlib.stringfind(input.offense2,'AMPHETA',1)>0) =>'DRUG VIOLATION',
									(stringlib.stringfind(input.offense2,'MORPH',1)>0) =>'DRUG VIOLATION',
									(stringlib.stringfind(input.offense2,'PHENETHYL',1)>0) =>'DRUG VIOLATION',
									(stringlib.stringfind(input.offense2,'VICODIN',1)>0) =>'DRUG VIOLATION',
									(stringlib.stringfind(input.offense2,'NARCOT',1)>0) =>'DRUG VIOLATION',
									(stringlib.stringfind(input.offense2,'ALPRAZALO',1)>0) =>'DRUG VIOLATION',
									(stringlib.stringfind(input.offense2,'PARAPHER',1)>0) =>'DRUG EQUIPMENT VIOLATION',
									(stringlib.stringfind(input.offense2,'OPEN CONTAINER',1)>0) =>'OPEN CONTAINER VIOLATION',
									(stringlib.stringfind(input.offense2,'PROBATION VIOLATION',1)>0) =>'PROBATION VIOLATION',
									(stringlib.stringfind(input.offense2,'NO PROOF OF INSURANCE',1)>0) =>'NO PROOF OF INSURANCE',
									(stringlib.stringfind(input.offense2,'PAROLE VIOLATION',1)>0) =>'PAROLE VIOLATION',
									(stringlib.stringfind(input.offense2,'PUBLIC DRUNK',1)>0) =>'PUBLIC DRUNKENNESS',
									(stringlib.stringfind(input.offense2,'RECKLESS DRIVING',1)>0) =>'RECKLESS DRIVING',
									(stringlib.stringfind(input.offense2,'SERVING COUNTY SENT',1)>0) =>'SERVING COUNTY SENTENCE',
									(stringlib.stringfind(input.offense2,'SERVING STATE SENT',1)>0) =>'SERVING STATE SENTENCE',
									(stringlib.stringfind(input.offense2,'UNREGISTERED VEH',1)>0) =>'UNREGISTERED VEHICLE','');
self.arr_off_desc_2 			:= '';
self.arr_off_type_cd 			:= '';
self.arr_off_type_desc 			:= '';
self.arr_off_lev 				:= '';
self.arr_statute 				:= '';
self.arr_statute_desc 			:= '';
self.arr_disp_date 				:= '';
self.arr_disp_code 				:= '';
self.arr_disp_desc_1 			:= '';
self.arr_disp_desc_2 			:= if(input.total_bond <> '' and input.total_bond<>'0.00',
								     ('BOND AMT '+'$'+input.total_bond),
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

pDawson := project(fDawson,tDawson(left));

dd_arrOut := dedup(sort(distribute(pDawson,hash(offender_key)),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,source_file,local),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,local,left):
									PERSIST('~thor_dell400::persist::ArrestLogs_GA_Dawson_Offenses');

export map_GA_DawsonOffenses	:= dd_arrOut;