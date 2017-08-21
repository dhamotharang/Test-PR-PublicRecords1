import Crim_Common, Address, Lib_date, Crim;

d	:= distribute(CRIM.File_MO_Statewide, hash(caseno));

fMO := d(d.CaseNo <> '' and trim(d.Name,left,right)<>'' and ~regexfind('[0-9]', d.name) and ~regexfind('[a-z]', d.DateFiled));

checkOFF(string r):=if(regexfind('(FEL[A-Y]+ +[A-F] +)', StringLib.StringToUPPERCase(r)), 'F',
						if(regexfind('(MISD[A-R]+ +[A-F] +)', StringLib.StringToUPPERCase(r)), 'M',
							if(regexfind('(ORDINANCE)', StringLib.StringToUPPERCase(r)), 'O', '')));

checkLEV(string r):= if(regexfind('FEL[A-Y]+ +A ',stringlib.StringToUpperCase(r)), '1',
						if(regexfind('FEL[A-Y]+ +B ',stringlib.StringToUpperCase(r)), '2',
							if(regexfind('FEL[A-Y]+ +C ',stringlib.StringToUpperCase(r)), '3',
								if(regexfind('FEL[A-Y]+ +D ',stringlib.StringToUpperCase(r)), '4',
									if(regexfind('FEL[A-Y]+ +E ',stringlib.StringToUpperCase(r)), '5',
										if(regexfind('FEL[A-Y]+ +F ',stringlib.StringToUpperCase(r)), '6',
						if(regexfind('MISD[A-R]+ +A ',stringlib.StringToUpperCase(r)), 'A',
							if(regexfind('MISD[A-R]+ +B ',stringlib.StringToUpperCase(r)), 'B',
								if(regexfind('MISD[A-R]+ +C ',stringlib.StringToUpperCase(r)), 'C',
									if(regexfind('MISD[A-R]+ +D ',stringlib.StringToUpperCase(r)), 'D',
										if(regexfind('MISD[A-R]+ +E ',stringlib.StringToUpperCase(r)), 'E',
											if(regexfind('MISD[A-R]+ +F ',stringlib.StringToUpperCase(r)), 'F', 
											''))))))))))));
											

searchpattern0 := '^(.*)/(.*)/(.*)$';
arrdt(string chargedate) := REGEXFIND(searchpattern0, trim(chargedate, left, right), 3) + REGEXFIND(searchpattern0, trim(chargedate, left, right), 1) + REGEXFIND(searchpattern0, trim(chargedate, left, right), 2);

Crim_Common.Layout_In_Court_Offenses tMO(fMO l) := Transform

self.process_date 				:= Crim_Common.Version_Development;
self.offender_key 				:= '1Y' + trim(l.caseno) + hash(trim(l.location) + ' ' + trim(l.court));
self.vendor 					:= '1Y';//NEED TO UPDATE
self.state_origin 				:= 'MO';
self.source_file 				:= '(CV)MO-StatewideCrim';
self.off_comp 					:= '';
self.off_delete_flag 			:= '';
self.off_date 					:= '';
self.arr_date 					:= if(~regexfind('[a-zA-Z]', arrdt(l.chargedate)) and arrdt(l.chargedate) > '19360101' and arrdt(l.chargedate) < Crim_Common.Version_Development, arrdt(l.chargedate), '');
self.num_of_counts 				:= regexreplace('[^0-9]', l.charge[StringLib.StringFind(l.charge, '}', 1)..length(l.charge)], '');
self.le_agency_cd 				:= '';
self.le_agency_desc 			:= trim(l.arrestingagency);
self.le_agency_case_number 		:= '';
self.traffic_ticket_number 		:= if(~regexfind('^(0+)$|^(1+)$|^(2+)$|^(3+)$|^(4+)$|^(5+)$|^(6+)$|^(7+)$|^(8+)$|^(9+)$', l.ticketnumber) and length(trim(l.ticketnumber)) > 1, l.ticketnumber, '');
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
self.court_case_number 			:= trim(l.caseno);
self.court_cd 					:= '';
self.court_desc 				:= trim(l.location) + ' ' + trim(l.court);
self.court_appeal_flag 			:= '';
self.court_final_plea 			:= '';
self.court_off_code 			:= trim(l.chargecode);
self.court_off_desc_1 			:= regexreplace('&#39;', regexreplace('\\([0-9]+\\)', trim(StringLib.StringFilterOut(regexreplace('(FIRST +DEGREE)|(SECOND +DEGREE)|(THIRD +DEGREE)|(FOURTH +DEGREE)|(FIFTH +DEGREE)|(SIXTH +DEGREE)|(1ST +DEGREE)|(2ND +DEGREE)|(3RD +DEGREE)|(4TH +DEGREE)|(5TH +DEGREE)|(6TH +DEGREE)|(DEGREE)' ,StringLib.StringToUPPERCase(l.charge)[1..StringLib.StringFind(l.charge, '{', 1)-1], ''), '*\\,'), left, right), ''), '');
self.court_off_desc_2 			:= '';
self.court_off_type_cd 			:= '';
self.court_off_type_desc 		:= '';
self.court_off_lev 				:= checkOFF(l.charge) + checkLEV(l.charge);
self.court_statute 				:= regexreplace('NOTAVAILABLE', stringlib.stringtouppercase(trim(l.charge[stringlib.stringfind(l.charge, 'RSMo:', 1)+5..stringlib.stringfind(l.charge, '}', 1)-1], all)), '');
self.court_additional_statutes 	:= '';
self.court_statute_desc 		:= '';
self.court_disp_date 			:= if(~regexfind('[a-zA-Z]', arrdt(l.dispositiondate)) and arrdt(l.dispositiondate) > '19360101' and arrdt(l.dispositiondate) < Crim_Common.Version_Development, arrdt(l.dispositiondate), '');
self.court_disp_code 			:= '';
self.court_disp_desc_1	 		:= if(~regexfind('Not', l.disposition), 
										if(regexfind('\\-', trim(l.disposition)), trim(l.disposition)[1..stringlib.stringfind(trim(l.disposition), '-', 1)-1],trim(l.disposition))
									, '');
self.court_disp_desc_2 			:= '';
self.sent_date 					:= if(~regexfind('[a-zA-Z]', arrdt(l.sentencedate)) and arrdt(l.sentencedate) > '19360101' and arrdt(l.sentencedate) < Crim_Common.Version_Development, arrdt(l.sentencedate), '');
self.sent_jail 					:= regexreplace('99+ +Years', if(~regexfind('NOT', StringLib.StringToUPPERCase(l.SentenceLength)) and regexfind('INCARCER', StringLib.StringToUPPERCase(l.sentence)), l.SentenceLength, ''), 'LIFE');
self.sent_susp_time 			:= '';
self.sent_court_cost 			:= '';
self.sent_court_fine 			:= '';
self.sent_susp_court_fine 		:= '';
self.sent_probation 			:= if(~regexfind('NOT', StringLib.StringToUPPERCase(l.SentenceLength)) and ~regexfind('INCARCER', StringLib.StringToUPPERCase(l.sentence)) and regexfind('IMPOSIT', StringLib.StringToUPPERCase(l.sentence)) , l.SentenceLength, '');
self.sent_addl_prov_code 		:= '';
self.sent_addl_prov_desc_1 		:= '';
self.sent_addl_prov_desc_2 		:= '';
self.sent_consec 				:= '';
self.sent_agency_rec_cust_ori 	:= '';
self.sent_agency_rec_cust 		:= '';
self.appeal_date 				:= '';
self.appeal_off_disp 			:= '';
self.appeal_final_decision 		:= '';
self := [];

end;

ROffenses := project(fMO,tMO(left));

dd_MOout:= 
dedup(
	sort(ROffenses
									,offender_key,off_comp,court_statute,court_off_code,court_off_desc_1,court_disp_date,sent_date,local)
									,offender_key,off_comp,court_statute,court_off_code,court_off_desc_1,left,local)
									;

export Map_MO_StatewideOffenses := dd_MOout
		:PERSIST('~thor_dell400::persist::Criminal_MO_Statewide_Offenses')
		;