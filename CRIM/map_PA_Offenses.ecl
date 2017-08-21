import Crim_Common, Address;

f1PAOffend	:= Crim.File_PA_CROTN;
f2PAOffend	:= Crim.File_PA_CRFILEB;
f3PALookup	:= crim.File_Crim_Statute_Lookup;

outRec := RECORD	
string20 LAST_NAME;
string15 FIRST_NAME;
string25 ADDRESS;
string6  STREET_NUMBER;
string15 STREET_NAME;
string4  APARTMENT_NUMBER;
string20 CITY;
string2  STATE;
string5  ZIP;
string4  EVENT_TYPE;
string4  SCHEDULED_YEAR;
string3  SCHEDULED_MONTH;
string3  SCHEDULED_DAY;
string5  SCHEDULED_TIME;
string1  AM_PM;
string10 OFFENSE_TRACKING_NUMBER;
Crim.Layout_PA_CRFILEB;
END;

outRec req_Output(f1PAOffend l, f2PAOffend r) := TRANSFORM
string20 LAST_NAME 					:= '';
string15 FIRST_NAME	 				:= '';
string25 ADDRESS 					:= '';
string6  STREET_NUMBER 				:= '';
string15 STREET_NAME 				:= '';
string4  APARTMENT_NUMBER 			:= '';
string20 CITY 						:= '';
string2  STATE 						:= '';
string5  ZIP 						:= '';
string4  EVENT_TYPE 				:= '';
string4  SCHEDULED_YEAR 			:= '';
string3  SCHEDULED_MONTH 			:= '';
string3  SCHEDULED_DAY 				:= '';
string5  SCHEDULED_TIME 			:= '';
string1  AM_PM 						:= '';
string10 OFFENSE_TRACKING_NUMBER	:= '';
self := l;
self := r;
self := [];
END;

crim_Offend := JOIN(f1PAOffend,f2PAOffend,
					LEFT.DISTRICT_NUMBER=RIGHT.DISTRICT_NUMBER and
					LEFT.DOCKET_NUMBER=RIGHT.DOCKET_NUMBER,
					req_Output(LEFT,RIGHT));


Crim_Common.Layout_In_Court_Offenses tPACrim(crim_Offend input) := Transform

self.process_date 				:= Crim_Common.Version_In_Arrest_Offenses;
self.offender_key 				:= '46'+trim(input.DISTRICT_NUMBER,left,right)+trim(input.DOCKET_NUMBER,left,right);
self.vendor 					:= '46';
self.state_origin 				:= 'PA';
self.source_file 				:= '(CV)PA STATEWIDE CRI';
self.off_comp 					:= input.SEQUENCE_NUMBER;
self.off_delete_flag 			:= '';
self.off_date 					:= if(trim(input.offense_date,left,right)<>'',								
									if(trim(input.offense_date,left,right)[1]='1','19'+trim(input.offense_date,left,right)[2..3]+trim(input.offense_date,left,right)[4..8],
									if(trim(input.offense_date,left,right)[1]='2','20'+trim(input.offense_date,left,right)[2..3]+trim(input.offense_date,left,right)[4..8],
									'')),'');
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
self.court_case_number 			:= input.DOCKET_NUMBER;
self.court_cd 					:= '';
self.court_desc 				:= '';
self.court_appeal_flag 			:= '';
self.court_final_plea 			:= '';
self.court_off_code 			:= '';
self.court_off_desc_1 			:= input.CHARGE_DESC;
self.court_off_desc_2			:= 'Offense Tracking Number ' + input.OFFENSE_TRACKING_NUMBER;
self.court_off_type_cd 			:= '';
self.court_off_type_desc 		:= '';
self.court_off_lev 				:= '';
self.court_statute 				:= trim(input.FINAL_CHARGE,left,right)+' '+
									//trim(input.FINAL_SECTION,left,right)+' '+
									trim(input.SUB_SECTION,left,right)+' '+
									trim(input.PARAGRAPH,left,right);
self.court_additional_statutes 	:= '';
self.court_statute_desc 		:= '';
self.court_disp_date 			:= if(trim(input.disposition_date,left,right)<>'',								
									if(trim(input.disposition_date,left,right)[1]='1','19'+trim(input.disposition_date,left,right)[2..3]+trim(input.disposition_date,left,right)[4..8],
									if(trim(input.disposition_date,left,right)[1]='2','20'+trim(input.disposition_date,left,right)[2..3]+trim(input.disposition_date,left,right)[4..8],
									'')),'');
self.court_disp_code 			:= if(input.DISPOSITION in['CHG','DIS','FUG','GP','GT','HDCT','MVNT','MVTR','NEI','NLPR','OTHR','SNCP',
															'STTD','WAV','WD'],
															input.disposition,
															'');
self.court_disp_desc_1	 		:= if(input.DISPOSITION = 'CHG ', 'CHARGE CHANGED         ',                         
									if(input.DISPOSITION = 'DIS ', 'DISMISSAL              ',                         
									if(input.DISPOSITION = 'FUG ', 'FUGITIVE - SENT TO CP  ',                         
									if(input.DISPOSITION = 'GP  ', 'GUILTY PLEA            ',                         
									if(input.DISPOSITION = 'GT  ', 'TRIAL: GUILTY          ',                         
									if(input.DISPOSITION = 'HDCT', 'HELD FOR COURT         ',                         
									if(input.DISPOSITION = 'MVNT', 'MOVED TO NON-TRAFFIC   ',                         
									if(input.DISPOSITION = 'MVTR', 'MOVED TO TRAFFIC       ',                         
									if(input.DISPOSITION = 'NEI ', 'N.E.I.                 ',                         
									if(input.DISPOSITION = 'NLPR', 'NOL PROS               ',                         
									if(input.DISPOSITION = 'OTHR', 'OTHER                  ',                         
									if(input.DISPOSITION = 'SNCP', 'SENT TO COMMON PLEAS   ',                         
									if(input.DISPOSITION = 'STTD', 'SETTLED                ',                         
									if(input.DISPOSITION = 'WAV ', 'WAIVE OF PRELIM HEARING',                         
									if(input.DISPOSITION = 'WD  ', 'PROSECUTION WITHDRAWN  ','')))))))))))))));
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

pPACrim := project(crim_Offend,tPACrim(left));

no_struct_join := pPACrim(court_statute='');

//ADD Court Offense Level
Crim_Common.Layout_In_Court_Offenses lStructCrim(pPACrim L, f3PALookup R) := transform
self.court_off_lev := R.level;
self := L;
end;

struct_join   := JOIN(pPACrim(court_statute<>''), 
					f3PALookup, 
					left.court_statute = right.statute, 
					lStructCrim(left, right),
					LEFT OUTER, lookup);

concat_all  := no_struct_join+struct_join;

//arrOut:= pMarin + ArrestLogs.FileAbinitioOffenses(vendor='A1');

// Remove Expunge Records //
dPA_Exp := dedup(Crim.File_PA_Expunge.File_PA_Updating_Expunge,Docket_Number);

fPAOffenses_exp := join(concat_all, dPA_Exp, left.offender_key[3..] = right.Docket_number, left only);

Crim_Common.Layout_In_Court_Offenses Exp_remove(fPAOffenses_exp input) := transform
self := input;
END;

concat := project(fPAOffenses_exp, Exp_remove(left));
// End Of Remove Expunge Records //

dd_PAOut:= dedup(sort(distribute(concat,hash(offender_key)),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,source_file,local),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,local,left):
									PERSIST('~thor_dell400::persist::Crim_PA_Offenses_Clean');

export map_PA_Offenses	:= dd_PAOut;