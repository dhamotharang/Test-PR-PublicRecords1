import Crim_Common, Address, Lib_date;

d	:= ArrestLogs.file_TX_Brazoria.old_f + file_reformat_TX_Brazoria;

//Added to accomodate new layout
ArrestLogs.Layout_TX_Brazoria.new_format pre_tBrazoria(d input) := Transform
self := input;
self.photo := '';
end;

pre_pBrazoria := project(d, pre_tBrazoria(left));

p_new 	:= ArrestLogs.file_TX_Brazoria.new_f;

p_all := pre_pBrazoria + p_new;

fBrazoria := p_all(trim(p_all.Name,left,right)<>'Name');

// new_layout := record 
// ArrestLogs.Layout_TX_Brazoria; 
// integer  counted := 0; 
// end;

// new_layout reformat(inBrazoria l):= transform
// self := l;
// end;

// rBrazoria := project(inBrazoria, reformat(left));

// new_layout T(new_layout L, new_layout R, integer c) := TRANSFORM
// SELF.counted := c;
// SELF := R;
// END;

// gBrazoria := ITERATE(group(sort(distribute(rBrazoria, hash(id)), id, dt_confined, -charge, -cause, local), id, dt_confined, local),T(LEFT,RIGHT, counter));

// fbrazoria := ungroup(gBrazoria);

Crim_Common.Layout_In_Court_Offenses tBrazoria(fBrazoria input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date 				:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key 				:= 'F4'+hash(trim(input.id,left,right)+fSlashedMDYtoCYMD(input.dt_confined[1..10]));
self.vendor 					:= 'F4';//NEED TO UPDATE
self.state_origin 				:= 'TX';
self.source_file 				:= '(CV)TX-BrazoriaCtyArr';
self.off_comp 					:= '';
self.off_delete_flag 			:= '';
self.off_date 					:= '';
self.arr_date 					:= if(fSlashedMDYtoCYMD(input.dt_confined[1..10])[1..2] between '19' and '20' 
									and fSlashedMDYtoCYMD(input.dt_confined[1..10])< Crim_Common.Version_In_Arrest_Offender,
									fSlashedMDYtoCYMD(input.dt_confined[1..10]),
									'');
self.num_of_counts 				:= '';
self.le_agency_cd 				:= '';
self.le_agency_desc 			:= if(regexfind('DEPT|'+'PD|'+'OFFICE',StringLib.StringToUpperCase(trim(input.arrest_agency,left,right)),0)<>'',
									StringLib.StringToUpperCase(trim(input.arrest_agency,left,right)),
									'');
self.le_agency_case_number 		:= '';
self.traffic_ticket_number 		:= '';
self.traffic_dl_no 				:= '';
self.traffic_dl_st 				:= '';
self.arr_off_code 				:= '';
self.arr_off_desc_1 			:= if(length(trim(input.charge,all))>4
									and regexfind('.00|'+'\\/|'+'JP',trim(input.charge,left,right),0)=''
									and regexfind('[A-Z]+',trim(input.charge,left,right),0)<>''
									and regexfind('[0-9][0-9][0-9][0-9]+',trim(input.charge,left,right),0)='',
									regexreplace('CT 1|CT 2|CT 3|CT 4|CT 5|CT 6|CT 7|CT 8|CT 9|CT.2|CT1|CT2|CPF-|-CPF|CPF'+'&amp;',
									trim(input.charge,left,right),
									''),'');
self.arr_off_desc_2 			:= '';
self.arr_off_type_cd 			:= '';
self.arr_off_type_desc 			:= '';
self.arr_off_lev 				:= '';
self.arr_statute 				:= '';
self.arr_statute_desc 			:= '';
self.arr_disp_date 				:= '';
self.arr_disp_code 				:= '';
self.arr_disp_desc_1 			:= if(regexfind('$',trim(input.bond,all),0)<>'',
									 'Bond Amt '+input.bond,
									 '');
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
self.sent_court_fine 			:= if(trim(input.fine,left,right)<>'$0.00' and regexfind('$',trim(input.fine,left,right),0)<>'',
									trim(input.fine,left,right),
									'');
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

pBrazoria := project(fBrazoria,tBrazoria(left));

////////////////////////////////////////////////////////////////

Crim_Common.Layout_In_Court_Offenses T(Crim_Common.Layout_In_Court_Offenses L, Crim_Common.Layout_In_Court_Offenses R, integer c) := TRANSFORM
SELF.off_comp := (string)c;
SELF := R;
END;

gBrazoria := ITERATE(group(sort(distribute(pBrazoria, hash(offender_key)), offender_key, arr_date, -arr_off_desc_1, local), offender_key, arr_date, local),T(LEFT,RIGHT, counter));

uBrazoria := ungroup(gBrazoria);

////////////////////////////////////////////////////////////////

filteredBrazoria := uBrazoria(~(arr_off_desc_1 = '' and off_comp > '1'));

Crim_Common.Layout_In_Court_Offenses off_compRM(Crim_Common.Layout_In_Court_Offenses l) := transform
self.off_comp := '';
self := l;
end;

lBrazoria := project(filteredBrazoria, off_compRM(left));

dd_arrOut:= dedup(sort(distribute(lBrazoria,hash(offender_key)),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,source_file,local),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,local,left)
									:PERSIST('~thor_dell400::persist::ArrestLogs_TX_Brazoria_Offenses')
									;

export Map_TX_BrazoriaOffenses := dd_arrOut;