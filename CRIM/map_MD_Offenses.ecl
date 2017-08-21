import crim_common, Crim, Address, lib_stringlib,ut;

input1 := CRIM.File_MD_Statewide.Circuit;
input2 := CRIM.File_MD_Statewide.District;

cmbndLayout := record
input1;
string IssuedDate;
string DocumentType;
string DistrictCode;
string LocationCode;
string TrialType;
string Statute_Description;
string AmendedDate;
string MO_PLL;
string ProbableCause;
string VictimAge;
string Fine;
string Court_costs;
string CICF;
string Amt_Suspended_Fine;
string Amt_Suspended_Court_costs;
string Amt_Suspended_CICF;
string PBJ_EndDate;
string Probation_End_Date;
string Restitution_Amount;
string JailTerm;
string SuspendedTerm;
string CreditTimeServed;
end;

cmbndLayout t1(input1 L) := transform
self := L;
self := [];
end;

precs1 := project(input1,t1(left));

cmbndLayout t2(input2 L) := transform
self := L;
self := [];
end;

precs2 := project(input2,t2(left));

cmbndFile := precs1 + precs2;

//////////////////////////////////////////////////////////////////////////////////

Crim_Common.Layout_In_Court_Offenses tMD(cmbndFile l) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

string8     getReasonableRange(string newDateIn) 
:=    map((newDateIn[1..2] between '19' and '20') and 
			(newDateIn < ut.GetDate) => newDateIn,'');
			
self.process_date 				:= Crim_Common.Version_Development;

self.vendor 					:= '96';
self.state_origin 				:= 'MD';
self.source_file 				:= '(CV)MD-StatewideCrim';
self.off_comp 					:= l.chargeno;
self.off_delete_flag 			:= '';
self.off_date 					:= getReasonableRange(fSlashedMDYtoCYMD(l.offensedatefrom));
self.arr_date 					:= '';
self.num_of_counts 				:= '';
self.le_agency_cd 				:= '';
self.le_agency_desc 			:= '';
self.le_agency_case_number 		:= if(l.trackingnumber = '', stringlib.stringtouppercase(l.arresttrackingno),stringlib.stringtouppercase(l.trackingnumber));
self.traffic_ticket_number 		:= '';
self.traffic_dl_no 				:= '';
self.traffic_dl_st 				:= '';
self.arr_off_code 				:= '';
self.arr_off_desc_1 			:= '';
self.arr_off_desc_2 			:= '';
self.arr_off_type_cd 			:= '';
self.arr_off_type_desc 			:= '';
self.arr_off_lev 				:= '';
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
self.court_case_number 			:= stringlib.stringtouppercase(l.id);
self.court_cd 					:= l.districtcode + l.locationcode;
self.court_desc 				:= stringlib.stringtouppercase(l.courtsystem);
self.court_appeal_flag 			:= '';
self.court_final_plea 			:= l.plea + ' '+ l.pleadate;
self.court_off_code 			:= stringlib.stringtouppercase(l.cjiscode);
self.court_off_desc_1 			:= stringlib.stringtouppercase(l.charge_description);
self.court_off_desc_2 			:= '';
self.court_off_type_cd 			:= '';
self.court_off_type_desc 		:= '';
self.court_off_lev 				:= stringlib.stringtouppercase(l.charge_class);
self.court_statute 				:= stringlib.stringtouppercase(l.statutecode);
self.court_additional_statutes 	:= '';
self.court_statute_desc 		:= stringlib.stringtouppercase(l.statute_description);
self.court_disp_date 			:= if(l.case_dispositiondate = ''
										,getReasonableRange(fSlashedMDYtoCYMD(l.dispositiondate))
										,getReasonableRange(fSlashedMDYtoCYMD(l.case_dispositiondate)));
self.court_disp_code 			:= '';
self.court_disp_desc_1	 		:= if(l.case_disposition= '',stringlib.stringtouppercase(l.disposition),stringlib.stringtouppercase(l.case_disposition));
self.court_disp_desc_2 			:= '';
self.sent_date 					:= '';
self.sent_jail 					:= regexreplace('D',regexreplace('M',regexreplace('Y',stringlib.stringtouppercase(l.jailterm),'YEARS'),'MONTHS'),'DAYS');
self.sent_susp_time 			:= regexreplace('D',regexreplace('M',regexreplace('Y',stringlib.stringtouppercase(l.suspendedterm),'YEARS'),'MONTHS'),'DAYS');
self.sent_court_cost 			:= if(l.court_costs = '$0.00','',stringlib.stringfilter(l.court_costs,'0123456789'));
self.sent_court_fine 			:= if(l.fine = '$0.00','',stringlib.stringfilter(l.fine,'0123456789'));
self.sent_susp_court_fine 		:= if(l.amt_suspended_fine = '$0.00','',stringlib.stringfilter(l.amt_suspended_fine,'0123456789'));
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

self.offender_key               := self.vendor + stringlib.stringtouppercase(self.court_case_number);


end;

ROffenses := project(cmbndFile,tMD(left));

dd_MDout:= 
dedup(
	sort(ROffenses
									,offender_key,off_comp,court_statute,court_off_code,court_off_desc_1,court_disp_date,sent_date,local)
									,offender_key,off_comp,court_statute,court_off_code,court_off_desc_1,left,local)
									;

export map_MD_Offenses := dd_MDout
		:PERSIST('~thor_dell400::persist::Criminal_MD_Statewide_Offenses')
		;