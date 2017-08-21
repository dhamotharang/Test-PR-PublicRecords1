import Crim_Common, ArrestLogs;

infile := crimSrch.File_UT_Orem_ForFCRAOnly(trim(state,left,right)<>'AL');

Crim_Common.Layout_Moxie_Court_Offenses tFCRA_Offenses(infile input) := Transform

	string8 fSlashedMDYtoCYMD(string pDateIn) 
		:= 	intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
			+ intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
			+ intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);
	
	/*string8 fAmountFormat(string d) 
		:=  if(stringlib.stringfind(input.additional_info,'0 ',1)>0 
				and stringlib.stringfind(input.additional_info,'.50',1)=0
				and stringlib.stringfind(input.additional_info,'.00',1)=0,
				input.additional_info[stringlib.stringfind(input.additional_info,'$',1)..stringlib.stringfind(input.additional_info,'0 ',1)]+'.00',
			if(stringlib.stringfind(input.additional_info,'0;',1)>0
				and stringlib.stringfind(input.additional_info,'.50;',1)=0
				and stringlib.stringfind(input.additional_info,'.00;',1)=0,
				input.additional_info[stringlib.stringfind(input.additional_info,'$',1)..stringlib.stringfind(input.additional_info,'0;',1)]+'.00',
			if(stringlib.stringfind(input.additional_info,'0 ',1)>0,
				input.additional_info[stringlib.stringfind(input.additional_info,'$',1)..stringlib.stringfind(input.additional_info,'0 ',1)],
			if(stringlib.stringfind(input.additional_info,'0;',1)>0,
				input.additional_info[stringlib.stringfind(input.additional_info,'$',1)..stringlib.stringfind(input.additional_info,'0;',1)],''))));*/

			searchPattern1 := '([0-9]+) DAYS JAIL|' 	+ '([0-9]+) DAYS PRISON|' 	+ '([0-9]+) DAYS PROBATION';
			searchPattern2 := '([0-9]+) MONTHS JAIL|' 	+ '([0-9]+) MONTHS PRISON|' + '([0-9]+) MONTHS PROBATION';
			searchPattern3 := '([0-9]+) YEARS JAIL|' 	+ '([0-9]+) YEARS PRISON|' 	+ '([0-9]+) YEARS PROBATION';
			searchPattern4 := 'JAIL ([0-9]+) DAYS|' 	+ 'PRISON ([0-9]+) DAYS|' 	+ 'PROBATION ([0-9]+) DAYS';
			searchPattern5 := 'JAIL ([0-9]+) MONTHS|' 	+ 'PRISON ([0-9]+) MONTHS|' + 'PROBATION ([0-9]+) MONTHS';
			searchPattern6 := 'JAIL ([0-9]+) YEARS|' 	+ 'PRISON ([0-9]+) YEARS|' 	+ 'PROBATION ([0-9]+) YEARS';
	
			searchPattern7 := 'ACQUITTAL, NOT GUILTY |'	+'ADJUDICATION WITHHELD |'	+'CLEMENCY |'				+'PARDON |'				+'AMNESTY COMMUTATION |'+'REDUCED SENTENCE |'+
								'REPRIEVE |'			+'CONDITIONAL RELEASE |'	+'DISCHARGE|'				+'DISMISSAL |'			+'DIVERSION|'			+'INCOMPETENT TO STAND TRIAL |'	+'NOT GUILTY BY REASON OF INSANITY |'+
								'NOLO CONTENDERE |'		+'GUILTY |'					+'TRANSFER TO ADULT COURT |'+'TREAT AS AN ADULT |'	+'ACQUITTAL|'			+'APPEAL |'+
								'CAREER CRIMINAL |'		+'PROFESSIONAL CRIMINAL |'	+'CIVIL COMMITMENT |'		+'FULL PARDON |'		+'CONDITIONAL PARDON |'	+'AMNESTY |'+					
								'COMMUTATION |'			+'REPRIEVE|'				+'HABITUAL OFFENDER |'		+'HABITUAL CRIMINAL |' 	+'MISDEMEANOR |'		+'NOLLE PROSEQUI|'+			
								'PLEA|'					+'INITIAL PLEA |'			+'FINAL PLEA |'				+'GUILTY PLEA'			+'PLED';
						
			self.process_date 				:= CrimSrch.Version.Development;
			self.offender_key 				:= '99'+input.report_id+fSlashedMDYtoCYMD(input.filed_date); 
			self.vendor 					:= '99';
			self.state_origin 				:= input.state;
			self.source_file 				:= 'FCRA_UT_Orem';
			self.off_comp 					:= '';
			self.off_delete_flag 			:= '';
			self.off_date 					:= '';
			self.arr_date 					:= '';
			self.num_of_counts 				:= '';
			self.le_agency_cd 				:= '';
			self.le_agency_desc 			:= '';
			self.le_agency_case_number 		:= '';
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
			self.court_case_number 			:= trim(input.case_number,left,right); 
			self.court_cd 					:= '';
			self.court_desc 				:= '';
			self.court_appeal_flag 			:= '';
			self.court_final_plea 			:= '';
			self.court_off_code 			:= '';
			self.court_off_desc_1 			:= input.charges[stringlib.stringfind(input.charges,'.',1)+1..75];
												/*regexreplace('[0-9]TH|'+'[0-9]|'+'CHARGE [0-9].|'+'CAHRGE [0-9].|'+'DEGREE |'+'1ST |'+'2ND |'+'3RD |'+'SEE ADDITIONAL INFO|'+'ACTIVE CASE UNKNOWN|'+
												'NO INFORMATION FILED/ DROPPED|'+'OTHER DEFERRAL|'+'STICKEN OFF WITH LEAVE TO REINSTATE|'+'ACTIVE CASE|'+'WARRANT ISSUEinput.additional_info, ACTIVE|'+'"'+
												'CASE |'+'BAIL FORFEITURE|'+'NO ACTION TAKEN|'+'Warrant Issued|'+'OVER $. VALUE|'+'$|'+'OR LESS|'+'<|'+'>|'+'% |'+'COUNTS OF: |'+'/|'+'.|'+'--',
												input.charges,'');THIS CODE REMOVES ALL OFFENSE DESCRIPTIONS :-( */
			self.court_off_desc_2 			:= '';
			self.court_off_type_cd 			:= '';
			self.court_off_type_desc 		:= '';
			self.court_off_lev 				:= if(input.charge_level[1] in ['F','M','I','T','V'], input.charge_level[1], '');
			self.court_statute 				:= '';
			self.court_additional_statutes 	:= '';
			self.court_statute_desc 		:= '';
			self.court_disp_date 			:= if(fSlashedMDYtoCYMD(regexreplace('12:00:00 AM',input.disposition,''))[1..8] < Crim_Common.Version_Development
											and fSlashedMDYtoCYMD(input.disposition)[1..2] in ['19','20'],
											fSlashedMDYtoCYMD(regexreplace('12:00:00 AM',input.disposition,'')),
											'');
			self.court_disp_code 			:= '';
			self.court_disp_desc_1	 		:= if(regexfind('/',input.disposition[1..10]),input.disposition[stringlib.stringfind(input.disposition,'-',1)+1..40],'');
			
												/*if(regexfind(searchPattern7,input.charges) = (boolean) 'true', 
												regexreplace('[(0-9]+|'+'#|'+'([0-9]+)/([0-9]+)/([0-9]+)|'+'-|'+'/|'+':|'+';|'+
												'DNUGUILTY |'+'SEE ADDITONAL|'+'CT MA|'+'SEE CHARGE|'+'SEE ADDITIONAL|'+'INFO.|'+'INFO|'+'INFORMATION|'+'PENDING|'+'PRAYER FOR JUDGMENT|'+
												'PRAYER FOR JUDGEMENT|'+'ODER DISMISSING APPEAL|'+'NOT FOUND|'+'NOL PROS|'+'NO BILLED|'+'NO CONTEST|'+'NO MATION FILED DROPPED|'+
												'ORDER TO QUASH|'+'MATION|'+'NONSUIT|'+'UNSERVED|'+'ACTIVE CASE|'+'NEXT COURT DATE|'+'UNKNOWN|'+'DEAD DOCKET|'+'COVERED BY THE|'+'DISM BY COURT|'+
												'BOUND OVER|'+'NO ORDER|'+'MOTION TO QUASH|'+'BAIL FORFEITURE|'+'VOLUNTARY LEAVE|'+'REMANDED|'+'NO REFILE|'+'WARRANT ISSUED|'+'WAIVED TO GRAND JURY|'+
												'FAILURE TO APPEAR|'+'SUBJECT GIVEN PAYABLE PENALTY|'+'NO DISPOSITION INDICATED IN FILE CASE',
												input.disposition,''),''); THIS CODE REMOVES ALL DISPOSITIONS :-( */
												
			self.court_disp_desc_2 			:= '';
			self.sent_date 					:= '';
			self.sent_jail 					:= if(regexfind(searchpattern1,input.additional_info)= (boolean)'true' and regexfind('JAIL',input.additional_info) = (boolean)'true',
												
												if((regexfind(searchPattern1,input.additional_info,1)+' DAYS')<>' DAYS',
												regexfind(searchPattern1,input.additional_info,1)+' DAYS',''),
												if(regexfind(searchpattern4,input.additional_info)= (boolean)'true' and regexfind('JAIL',input.additional_info) = (boolean)'true',
												
												if((regexfind(searchPattern4,input.additional_info,1)+' DAYS')<>' DAYS',
												regexfind(searchPattern4,input.additional_info,1)+' DAYS',''),
												if(regexfind(searchpattern2,input.additional_info)= (boolean)'true' and regexfind('JAIL',input.additional_info) = (boolean)'true',
												
												if((regexfind(searchPattern2,input.additional_info,1)+' MONTHS')<>' MONTHS',
												regexfind(searchPattern2,input.additional_info,1)+' MONTHS',''),
												if(regexfind(searchpattern5,input.additional_info)= (boolean)'true' and regexfind('JAIL',input.additional_info) = (boolean)'true',
												
												if((regexfind(searchPattern5,input.additional_info,1)+' MONTHS')<>' MONTHS ',
												regexfind(searchPattern5,input.additional_info,1)+' MONTHS',''),
												if(regexfind(searchpattern3,input.additional_info)= (boolean)'true' and regexfind('JAIL',input.additional_info) = (boolean)'true',
												
												if((regexfind(searchPattern3,input.additional_info,1)+' YEARS')<>' YEARS',
												regexfind(searchPattern3,input.additional_info,1)+' YEARS',''),
												if(regexfind(searchpattern6,input.additional_info)= (boolean)'true' and regexfind('JAIL',input.additional_info) = (boolean)'true',
												
												if((regexfind(searchPattern6,input.additional_info,1)+' YEARS')<>' YEARS',
												regexfind(searchPattern6,input.additional_info,1)+' YEARS',''),
												if(regexfind(searchpattern1,input.additional_info)= (boolean)'true' and regexfind('PRISON',input.additional_info) = (boolean)'true',
												
												if((regexfind(searchPattern1,input.additional_info,2)+' DAYS')<>' DAYS',
												regexfind(searchPattern1,input.additional_info,2)+' DAYS',''),
												if(regexfind(searchpattern4,input.additional_info)= (boolean)'true' and regexfind('PRISON',input.additional_info) = (boolean)'true',
												
												if((regexfind(searchPattern4,input.additional_info,2)+' DAYS')<>' DAYS',
												regexfind(searchPattern4,input.additional_info,2)+' DAYS',''),
												if(regexfind(searchpattern2,input.additional_info)= (boolean)'true' and regexfind('PRISON',input.additional_info) = (boolean)'true',
												
												if((regexfind(searchPattern2,input.additional_info,2)+' MONTHS')<>' MONTHS',
												regexfind(searchPattern2,input.additional_info,2)+' MONTHS',''),
												if(regexfind(searchpattern5,input.additional_info)= (boolean)'true' and regexfind('PRISON',input.additional_info) = (boolean)'true',
												
												if((regexfind(searchPattern5,input.additional_info,2)+' MONTHS')<>' MONTHS',
												regexfind(searchPattern5,input.additional_info,2)+' MONTHS',''),
												if(regexfind(searchpattern3,input.additional_info)= (boolean)'true' and regexfind('PRISON',input.additional_info) = (boolean)'true',
												
												if((regexfind(searchPattern3,input.additional_info,2)+' YEARS')<>' YEARS',
												regexfind(searchPattern3,input.additional_info,2)+' YEARS',''),
												if(regexfind(searchpattern6,input.additional_info)= (boolean)'true' and regexfind('PRISON',input.additional_info) = (boolean)'true',
												
												if((regexfind(searchPattern6,input.additional_info,2)+' YEARS')<>' YEARS',
												regexfind(searchPattern6,input.additional_info,2)+' YEARS',''),''))))))))))));
			self.sent_susp_time 			:= '';			
			self.sent_court_cost 			:= '';/*regexreplace('\\$',regexreplace(';',if((stringlib.stringfind(input.additional_info,'COST',1)>0 
													or stringlib.stringfind(input.additional_info,'COSTS',1)>0) 
													and (stringlib.stringfind(input.additional_info,'FINE',1)=0 
													and stringlib.stringfind(input.additional_info,'FINES',1)=0
													and stringlib.stringfind(input.additional_info,'$',1)>0),
													fAmountFormat(input.additional_info),''),''),'');*/
			self.sent_court_fine 			:= '';/*regexreplace('\\$',regexreplace(';',if((stringlib.stringfind(input.additional_info,'FINE',1)>0 
													or stringlib.stringfind(input.additional_info,'FINES',1)>0) 
													and (stringlib.stringfind(input.additional_info,'COST',1)=0 
													and stringlib.stringfind(input.additional_info,'COSTS',1)=0
													and stringlib.stringfind(input.additional_info,'$',1)>0),
													fAmountFormat(input.additional_info),''),''),'');*/
			self.sent_susp_court_fine 		:= '';
			self.sent_probation 			:= if(regexfind(searchpattern1,input.additional_info)= (boolean)'true' and regexfind('PROBATION',input.additional_info) = (boolean)'true',
												
												if((regexfind(searchPattern1,input.additional_info,3)+' DAYS')<>' DAYS',
												regexfind(searchPattern1,input.additional_info,3)+' DAYS',''),
												if(regexfind(searchpattern4,input.additional_info)= (boolean)'true' and regexfind('PROBATION',input.additional_info) = (boolean)'true',
												
												if((regexfind(searchPattern4,input.additional_info,3)+' DAYS')<>' DAYS',
												regexfind(searchPattern4,input.additional_info,3)+' DAYS',''),
												if(regexfind(searchpattern2,input.additional_info)= (boolean)'true' and regexfind('PROBATION',input.additional_info) = (boolean)'true',
												
												if((regexfind(searchPattern2,input.additional_info,3)+' MONTHS')<>' MONTHS',
												regexfind(searchPattern2,input.additional_info,3)+' MONTHS',''),
												if(regexfind(searchpattern5,input.additional_info)= (boolean)'true' and regexfind('PROBATION',input.additional_info) = (boolean)'true',

												if((regexfind(searchPattern5,input.additional_info,3)+' MONTHS')<>' MONTHS',
												regexfind(searchPattern5,input.additional_info,3)+' MONTHS',''),
												if(regexfind(searchpattern3,input.additional_info)= (boolean)'true' and regexfind('PROBATION',input.additional_info) = (boolean)'true',
												
												if((regexfind(searchPattern3,input.additional_info,3)+' YEARS')<>' YEARS',
												regexfind(searchPattern3,input.additional_info,3)+' YEARS',''),
												if(regexfind(searchpattern6,input.additional_info)= (boolean)'true' and regexfind('PROBATION',input.additional_info) = (boolean)'true',
												
												if((regexfind(searchPattern6,input.additional_info,3)+' YEARS')<>' YEARS',
												regexfind(searchPattern6,input.additional_info,3)+' YEARS',''),''))))));
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

pInFile := project(infile, tFCRA_Offenses(left));

dd_arrOut := dedup(sort(distribute(pInFile,hash(offender_key)),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,local),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,local,right):
									PERSIST('~thor_dell400::persist::Crim_Court_FCRA_UT_Orem_Offenses');

export Crim_Court_FCRA_UT_Orem_Offenses := dd_arrOut;
