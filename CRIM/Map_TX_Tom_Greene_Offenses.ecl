//Source: Alpharetta-Scrape
import Crim_Common, Crim, lib_date;


ds_def := sort(CRIM.File_TX_Tom_Greene.Defendant, def_id);
ds_chrg := sort(CRIM.File_TX_Tom_Greene.Charge, def_id);
ds_sent := CRIM.File_TX_Tom_Greene.Sentence;

layout_chrg  := record
		crim.Layout_TX_Grayson_Defendant;
		crim.Layout_TX_Grayson_Charge   			AND NOT def_id;
end;

layout_chrg   jdef_chrg(ds_def L, ds_chrg R) := TRANSFORM
		SELF := L;
		SELF := R;
end;
		
ds_def_chrg				:=JOIN(ds_def, ds_chrg 
							, LEFT.def_id  = RIGHT.def_id 
								, jdef_chrg(left,right),left outer); 

layout_chrg_sent := RECORD
		ds_def_chrg;
		CRIM.Layout_TX_Grayson_Sentence  and not [def_id, charge_id];
END;
layout_chrg_sent  jdef_chrg_sent(ds_def_chrg L, ds_sent R) := TRANSFORM
		SELF := L;
		SELF := R;
END;	
		
d			:=JOIN(ds_def_chrg, ds_sent
							, LEFT.def_id  = RIGHT.def_id 
								// and LEFT.charge_id = RIGHT.charge_id
									, jdef_chrg_sent(left,right), left outer); 
  
// d := distribute(ds_def_chrg_sent, hash32(def_id));
 


Crim_Common.Layout_In_Court_Offenses tTXCrim(d input) := Transform

 string8     fSlashedMDYtoCYMD(string pDateIn) 
			:=    intformat((integer2)regexreplace('.*/.*/([1-9]+)',pDateIn,'$1'),4,1) 
			+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
			+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);
			

	clean_def_name				:= stringlib.stringfilter(stringlib.stringtouppercase(input.def_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
	self.process_date			:= Crim_Common.Version_Development;
	self.offender_key			:= '4H'+hash(clean_def_name)+input.case_num+fSlashedMDYtoCYMD(input.file_dt);
	self.vendor 				:= '4H';
	self.state_origin 			:= 'TX';
	self.source_file 			:= '(CP)TX Tom Greene Cnty';
	self.off_comp 				:= '';
	self.off_delete_flag 		:= '';
	self.off_date 				:= if(fSlashedMDYtoCYMD(input.offense_dt) between '19000101' and Crim_Common.Version_Development,
								fSlashedMDYtoCYMD(input.offense_dt),'');
	self.arr_date 				:= '';
	self.num_of_counts 			:= input.counts;
	self.le_agency_cd 			:= '';
	self.le_agency_desc 		:= '';
	self.le_agency_case_number 	:= '';
	self.traffic_ticket_number 	:= input.ticket_num;
	self.traffic_dl_no 			:= input.license_num;
	self.traffic_dl_st 			:= input.lic_state_cd;
	self.arr_off_code 			:= '';
	self.arr_off_desc_1 		:= '';
	self.arr_off_desc_2 		:= '';
	self.arr_off_type_cd 		:= '';
	self.arr_off_type_desc 		:= '';
	self.arr_off_lev 			:= '';
	self.arr_statute 			:= '';
	self.arr_statute_desc 		:= '';
	self.arr_disp_date 			:= '';
	self.arr_disp_code 			:= '';
	self.arr_disp_desc_1 		:= '';
	self.arr_disp_desc_2 		:= '';
	self.pros_refer_cd 			:= '';
	self.pros_refer 			:= '';
	self.pros_assgn_cd 			:= '';
	self.pros_assgn 			:= '';
	self.pros_chg_rej 			:= '';
	self.pros_off_code 			:= '';
	self.pros_off_desc_1 		:= '';
	self.pros_off_desc_2 		:= '';
	self.pros_off_type_cd 		:= '';
	self.pros_off_type_desc 	:= '';
	self.pros_off_lev 			:= '';
	self.pros_act_filed 		:= '';
	self.court_case_number 		:= input.case_num;
	self.court_cd 				:= '';
	self.court_desc 			:= '';
	self.court_appeal_flag 		:= '';
	self.court_final_plea 		:= '';
	self.court_off_code 		:= '';
	self.court_off_desc_1 		:= regexreplace('[\\\'|"|\\.]', trim(input.statute_descr, left, right), '');//input.amended_chg;
	self.court_off_desc_2		:= '';
	self.court_off_type_cd 		:= '';
	self.court_off_type_desc 	:= '';
	self.court_off_lev 			:= MAP(trim(input.chg_degree,left,right) = '1st Degree Felony'=>'F1',
								trim(input.chg_degree,left,right) = '2nd Degree Felony' =>'F2',
								trim(input.chg_degree,left,right) = '3rd Degree Felony' =>'F3',
								trim(input.chg_degree,left,right) = '4th Degree Felony' =>'F4',
								trim(input.chg_degree,left,right) = '5th Degree Felony' =>'F5',
								trim(input.chg_degree,left,right) = 'Capital Felony' =>'CF',
								trim(input.chg_degree,left,right) = 'Misdemeanor A' =>'M1',
								trim(input.chg_degree,left,right) = 'Misdemeanor B' =>'M2',
								trim(input.chg_degree,left,right) = 'Misdemeanor C' =>'M3',
								trim(input.chg_degree,left,right) = 'Minor Misdemeanor' =>'MM',
								trim(input.chg_degree,left,right) = 'Misdemeanor Class Appeal' =>'MCA',
								trim(input.chg_degree,left,right) = 'Misdemeanor Traffic' =>'MT',
								trim(input.chg_degree,left,right) = 'Misdemeanor Traffic Appeal' =>'MTA',
								trim(input.chg_degree,left,right) = 'Misdemeanor Class Appeal' =>'MCA',
								trim(input.chg_degree,left,right) = 'State Felony' =>'SF',
								trim(input.chg_degree,left,right) = 'Misdemeanor Unassigned' =>'M',
								trim(input.chg_degree,left,right) = 'Felony Unassigned' =>'F',
								trim(input.chg_degree,left,right) = '' =>'',
								trim(input.chg_degree,left,right) = ']' =>'',
								trim(input.chg_degree,left,right) = 'Either' =>'',
								trim(input.chg_degree,left,right) = 'Felony' =>'F',
								trim(input.chg_degree,left,right));
	self.court_statute 			:= input.statute;
	self.court_additional_statutes:= '';
	self.court_statute_desc 	:= '';
	self.court_disp_date 		:= if(fSlashedMDYtoCYMD(input.disposition_dt)between '19000101' and (string)((integer)Crim_Common.Version_Development),
										fSlashedMDYtoCYMD(input.disposition_dt),''); 
	self.court_disp_code 		:= '';
	self.court_disp_desc_1	 	:= input.dispo_detail;
	self.court_disp_desc_2 		:= '';
	self.sent_date 				:= '';
	self.sent_jail 				:= if(input.sentence_type = 'Confinement', 
								if(trim(input.sentence_amount, left, right)=''
								or trim(input.sentence_amount, left, right)='0', '',
								trim(regexreplace('County Jail|Deferred Adjudication|Tdc  Shock Probation|Confinement In Community Correctional Facility|No Jail Time Assessed|State Jail Facility|Texas Department Of Corrections|Community Supervision & Corrections Department|Texas Dept Criminal Justice|-|\\.', input.sentence_amount, ''), left, right))
								,'');																			
	self.sent_susp_time 		:= '';
	self.sent_court_cost 		:= if(input.sentence_type = 'Court Costs', 
								if(trim(input.sentence_amount, left, right) = '','',
									stringlib.stringfilter(input.sentence_amount,'0123456789')), '');
	self.sent_court_fine 		:= if(input.sentence_type = 'Fine', 
								if(trim(input.sentence_amount, left, right) = '','',
									stringlib.stringfilter(input.sentence_amount,'0123456789')), '');
	self.sent_susp_court_fine 	:= '';
	self.sent_probation 		:= if(input.sentence_type = 'Probation', 
									if(trim(input.sentence_amount, left, right)=''
									or trim(input.sentence_amount, left, right)='0', '',
									regexreplace('County Jail|State Jail Facility|Texas Dept Corrections|Texas Dept Criminal Justice|-|\\.', trim(input.sentence_amount, left, right),'')),'');
	self.sent_addl_prov_code 	:= '';
	self.sent_addl_prov_desc_1 	:= if(input.sentence_type = 'Community Service' ,
									if(input.sentence_amount = '','',
									'Community Service:'+regexreplace('\\.0', input.sentence_amount, '')), '');
	self.sent_addl_prov_desc_2 	:= if(input.sentence_type = 'Other Fees',
										if(trim(input.sentence_amount, left, right) = '','', 
										'Other Fees:'+input.sentence_amount), '');
	self.sent_consec 			:= '';
	self.sent_agency_rec_cust_ori := '';
	self.sent_agency_rec_cust 	:= '';
	self.appeal_date 			:= '';
	self.appeal_off_disp 		:= '';
	self.appeal_final_decision 	:= '';

end;

pTXCrim  := project(d,tTXCrim(left));
dpTXCrim := distribute(pTXCrim,hash(offender_key));
sorted_pTXCrim := sort(dpTXCrim,offender_key,off_date,court_Case_number,court_off_desc_1,court_disp_date,court_disp_desc_1,
                               sent_jail,sent_court_cost,sent_court_fine,sent_probation,sent_addl_prov_desc_1,local);

//output(choosen(sorted_pTXCrim(offender_key = '4H140158285203-0326720031223'),50));
//Fixed the rollup: Added more conditions so the charges won't be dropped - Vchikte.

dpTXCrim rlpTXCrim(dpTXCrim L,dpTXCrim R) := TRANSFORM
	self.sent_jail  			  := if(l.sent_jail  = '', r.sent_jail , l.sent_jail);
	self.court_off_lev      := if(l.court_off_lev ='', r.court_off_lev, l.court_off_lev);
	self.sent_court_cost 		:= if(l.sent_court_cost = '', r.sent_court_cost, l.sent_court_cost);
	self.sent_court_fine  	:= if(l.sent_court_fine  = '', r.sent_court_fine , l.sent_court_fine);
	self.sent_probation  		:= if(l.sent_probation  = '', r.sent_probation , l.sent_probation);
	self.court_disp_desc_1  		:= if(l.court_disp_desc_1  = '', r.court_disp_desc_1 , l.court_disp_desc_1);
	self.court_disp_date    		:= if(l.court_disp_date    = '', r.court_disp_date   , l.court_disp_date  );
	self.sent_addl_prov_desc_1	:= if(l.sent_addl_prov_desc_1 = '', trim(r.sent_addl_prov_desc_1), trim(l.sent_addl_prov_desc_1));
	self.sent_addl_prov_desc_2	:= if(l.sent_addl_prov_desc_2 = '', trim(r.sent_addl_prov_desc_2), trim(l.sent_addl_prov_desc_2));
	SELF := L; 
END;


rlppTXCrimOut := ROLLUP(sorted_pTXCrim,
                        left.offender_key            = right.offender_key and 
												trim(left.court_off_desc_1)  = trim(right.court_off_desc_1) and 
												trim(left.off_date)          = trim(Right.off_date) and 
												trim(left.court_Case_number) = trim(right.court_Case_number) and 
												(left.court_disp_date  = ''  or right.court_disp_date  = ''  or trim(left.court_disp_date)   = trim(right.court_disp_date)) and 
												(left.court_disp_desc_1 = '' or right.court_disp_desc_1 = '' or trim(left.court_disp_desc_1) = trim(right.court_disp_desc_1)) and
												(left.sent_court_fine = ''   or right.sent_court_fine = ''   or trim(left.sent_court_fine)   = trim(right.sent_court_fine)) and 
												(left.sent_court_cost = ''   or right.sent_court_cost = ''   or trim(left.sent_court_cost)   = trim(right.sent_court_cost)) and 
												(left.sent_jail       = ''   or right.sent_jail       = ''   or trim(left.sent_jail)         = trim(right.sent_jail)) and 
												(trim(left.sent_probation)  = ''   or trim(right.sent_probation)  = ''   or trim(left.sent_probation)    = trim(right.sent_probation)) and 												
												(left.court_off_lev   = ''   or right.court_off_lev   = ''   or trim(left.court_off_lev)     = trim(right.court_off_lev)) and 
												(left.sent_addl_prov_desc_1 = '' or right.sent_addl_prov_desc_1 = '' or trim(left.sent_addl_prov_desc_1) = trim(right.sent_addl_prov_desc_1))and 
												(left.sent_addl_prov_desc_2 = '' or right.sent_addl_prov_desc_2 = '' or trim(left.sent_addl_prov_desc_2) = trim(right.sent_addl_prov_desc_2)) , 
                        rlpTXCrim(LEFT,RIGHT),local);
//output(choosen(rlppTXCrimOut(offender_key = '4H140158285203-0326720031223'),50));
fTXOffense:= dedup(sort(rlppTXCrimOut,
				offender_key,court_statute_desc,court_off_desc_1,sent_date,sent_jail,sent_susp_time,sent_court_cost,sent_court_fine, sent_probation,
					sent_consec, sent_addl_prov_desc_1, source_file),
				offender_key,court_statute_desc,court_off_desc_1,sent_date,sent_jail,sent_susp_time,sent_court_cost,sent_court_fine, sent_probation,
					sent_consec, sent_addl_prov_desc_1, left)
									:PERSIST('~thor_data400::persist::Crim_TX_Tom_Greene_Offenses')
									;

export Map_TX_Tom_Greene_Offenses := fTXOffense;

