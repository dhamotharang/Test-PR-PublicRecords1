//Source: Alpharetta-Scrape

import crim_common, Crim, Address;

//Append Municipal and Common Pleas Defendant files

c :=crim.File_OH_Ross.Common_Pleas_Defendant;

Layout_OH_Ross_Defendant_append := record
Crim.Layout_OH_Ross_Defendant;
string case_court;
end;

Layout_OH_Ross_Defendant_append pOHDef(c input) := Transform
self := input;
self.case_court := 'CommonPleas';
end;

preOHDef1 := project(c, pOHDef(left));

d := crim.File_OH_Ross.Municipal_Defendant;

Layout_OH_Ross_Defendant_append mOHDef(d input) := Transform
self := input;
self.case_court := 'Municipal';
end;

preOHDef2 := project(d, mOHDef(left));
preConcatDef := preOHDef1+preOHDef2;

//Append Municipal and Common Pleas Charge files

e :=crim.File_OH_Ross.Common_Pleas_Charge;

Layout_OH_Ross_Charge_append := record
Crim.Layout_OH_Ross_Charge;
string case_court;
end;

Layout_OH_Ross_Charge_append pOHChg(e input) := Transform
self := input;
self.case_court := 'CommonPleas';
end;

preOHChg1 := project(e, pOHChg(left));

f := crim.File_OH_Ross.Municipal_Charge;

Layout_OH_Ross_Charge_append mOHChg(f input) := Transform
self := input;
self.case_court := 'Municipal';
end;

preOHChg2 := project(f, mOHChg(left));
preConcatChg := preOHChg1+preOHChg2;

//Join Defendant and Charge files
layout_chrg  := record
		preConcatDef;
		Layout_OH_Ross_Charge_append	  AND NOT [def_id, county, case_num, case_type, license_num, case_court];
end;



layout_chrg   jdef_chrg(preConcatDef L, preConcatChg R) := TRANSFORM
		SELF := L;
		SELF := R;
end;

		
ds_def_chrg				:=JOIN(preConcatDef, preConcatChg
							, LEFT.def_id  = RIGHT.def_id
								, jdef_chrg(left,right)); 
								
//Append Municipal and Common Pleas Sentence files

g :=crim.File_OH_Ross.Common_Pleas_Sentence;

Layout_OH_Ross_Sentence_append := record
Crim.Layout_OH_Ross_Sentence;
string case_court;
end;

Layout_OH_Ross_Sentence_append pOHSent(g input) := Transform
self := input;
self.case_court := 'CommonPleas';
end;

preOHSent1 := project(g, pOHSent(left));

h := crim.File_OH_Ross.Municipal_Sentence;

Layout_OH_Ross_Sentence_append mOHSent(h input) := Transform
self := input;
self.case_court := 'Municipal';
end;

preOHSent2 := project(h, mOHSent(left));
preConcatSent := preOHSent1+preOHSent2;				

//Join prejoined Defendant and Charge to Sentence
								
layout_chrg_sent := RECORD
    ds_def_chrg;
	CRIM.Layout_OH_Ross_Sentence  and not [def_id, charge_id];
END;
layout_chrg_sent  jdef_chrg_sent(ds_def_chrg L, preConcatSent R) := TRANSFORM
		SELF := L;
		SELF := R;
END;


		
		
ds_def_chrg_sent			:=JOIN(ds_def_chrg, preConcatSent
							, LEFT.def_id  = RIGHT.def_id 
								and LEFT.charge_id = RIGHT.charge_id
									, jdef_chrg_sent(left,right), left outer); 
  
dist := distribute(ds_def_chrg_sent, hash32(def_id));
 
 string8     fSlashedMDYtoCYMD(string pDateIn) 
			:=    intformat((integer2)regexreplace('.*/.*/([1-9]+)',pDateIn,'$1'),4,1) 
			+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
			+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

Crim_Common.Layout_In_Court_Offenses tOHCrim(dist input) := Transform

integer brace1  			:=  StringLib.StringFind(input.statute_descr,'(',1);
integer brace2				:=  StringLib.StringFind(input.statute_descr,')',1);

varstring cntnum      :=  IF (brace1 >0, regexreplace('TWENTY-FOUR', regexreplace('TWO', regexreplace('THREE', regexreplace('FOUR',regexreplace('FIVE',regexreplace('SIX',regexreplace('SEVEN',
regexreplace('EIGHT', regexreplace('NINE',regexreplace('TEN', stringlib.stringtouppercase(input.statute_descr)[brace1+1..brace2-1],'10'), '9'), '8'), '7'), '6'),'5'),'4'), '3'), '2'), '24'), '');

integer pSlash  			:=  StringLib.StringFind(input.statute,'/',2);
	clean_def_name				:= stringlib.stringfilter(stringlib.stringtouppercase(input.def_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
	self.process_date 			:= Crim_Common.Version_Development;
	self.offender_key 			:= if(input.case_court = 'Municipal','3E', '3X')+if(input.case_court = 'Municipal', 'M', 'S')
									   +input.case_type[1]+hash(clean_def_name)+input.case_num+fSlashedMDYtoCYMD(input.file_dt);										 
	self.vendor 				:= if(input.case_court = 'Municipal','3E', '3X');
	self.state_origin 			:= 'OH';
	self.source_file 			:= if(input.case_court = 'Municipal','(CP)OH Ross Muni', '(CP)OH Ross CPleas');
	self.off_comp 				:= '';
	self.off_delete_flag 		:= '';
	self.off_date 				:= if(fSlashedMDYtoCYMD(input.offense_dt)between '19000101' and (string)((integer)Crim_Common.Version_Development),
								fSlashedMDYtoCYMD(input.offense_dt),''); 
	self.arr_date 				:= '';
	self.num_of_counts 			:= if (regexfind('CTS|COUNTS', trim(cntnum, left, right)), regexreplace('[A-Za-z]', trim(cntnum, left, right), ''), '');
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
	self.pros_off_type_desc 		:= '';
	self.pros_off_lev 			:= '';
	self.pros_act_filed 		:= '';
	self.court_case_number 		:= input.case_num;
	self.court_cd 				:= '';
	self.court_desc 			:= '';
	self.court_appeal_flag 		:= '';
	self.court_final_plea 		:= '';
	self.court_off_code 		:= '';
	self.court_off_desc_1 		:= input.amended_chg;
	self.court_off_desc_2		:= '';
	self.court_off_type_cd 		:= '';
	self.court_off_type_desc 	:= '';
	self.court_off_lev 			:= if(regexfind('1st Degree Felony',trim(input.chg_degree,left,right),0)<>'','F1',
								if(regexfind('2nd Degree Felony',trim(input.chg_degree,left,right),0)<>'','F2',
								if(regexfind('3rd Degree Felony',trim(input.chg_degree,left,right),0)<>'','F3',
								if(regexfind('4th Degree Felony',trim(input.chg_degree,left,right),0)<>'','F4',
								if(regexfind('5th Degree Felony',trim(input.chg_degree,left,right),0)<>'','F5',
								if(regexfind('1st Degree Misdemeanor',trim(input.chg_degree,left,right),0)<>'','M1',
								if(regexfind('2nd Degree Misdemeanor',trim(input.chg_degree,left,right),0)<>'','M2',
								if(regexfind('3rd Degree Misdemeanor',trim(input.chg_degree,left,right),0)<>'','M3',
								if(regexfind('4th Degree Misdemeanor',trim(input.chg_degree,left,right),0)<>'','M4',
								if(regexfind('Minor Misdemeanor',trim(input.chg_degree,left,right),0)<>'','MM',
								''))))))))));
	self.court_statute 			:= if(pSlash>0, '',
								if(length(input.statute)>1, regexreplace('[\\]|\\[|"|0000000000|000]', input.statute, ''),''));
 	self.court_additional_statutes:= '';
	self.court_statute_desc 		:= if(length(input.statute_descr)>1, input.statute_descr, '');
	self.court_disp_date 		:= if(fSlashedMDYtoCYMD(input.disposition_dt)between '19000101' and (string)((integer)Crim_Common.Version_Development),
									fSlashedMDYtoCYMD(input.disposition_dt),''); 
	self.court_disp_code 		:= if(length(input.dispo_detail)>1, input.dispo_detail, '');
	self.court_disp_desc_1	 	:= if(length(input.comments)>1, input.comments, '');
	self.court_disp_desc_2 		:= '';
	self.sent_date 			:= '';
	self.sent_jail 			:= if(input.sentence_type = 'Jail Time', 
								if(trim(regexreplace('[\\*|/|"|.\\\\]', input.sentence_description,''))=''
								or trim(regexreplace('[\\*|/|"|.\\\\]', input.sentence_description,''))='0', '',
								trim(regexreplace('[\\*|/|"|.\\\\]', input.sentence_description,''), left, right)+' DAY(S)'),'');																			
	self.sent_susp_time 		:= if(input.sentence_type = 'Jail Time Susp.', 
								if(trim(regexreplace('[\\*|/|"|.\\\\]', input.sentence_description,''))=''
								or trim(regexreplace('[\\*|/|"|.\\\\]', input.sentence_description,''))='0', '',
								trim(regexreplace('[\\*|/|"|.\\\\]', input.sentence_description,''), left, right)+' DAY(S)'),'');
	self.sent_court_cost 		:= if(input.sentence_type = 'Costs Amt.', 
								if(input.sentence_description = '.00','',
									stringlib.stringfilter(input.sentence_description,'0123456789')), '');
	self.sent_court_fine 		:= if(input.sentence_type = 'Fine Amt.', 
								if(input.sentence_description = '.00','',
									stringlib.stringfilter(input.sentence_description,'0123456789')), '');
	self.sent_susp_court_fine 	:= if(input.sentence_type = 'Fine Amt. Susp.', 
								if(input.sentence_description = '.00','',
									stringlib.stringfilter(input.sentence_description,'0123456789')), '');
	self.sent_probation 		:= '';
	self.sent_addl_prov_code 	:= '';
	self.sent_addl_prov_desc_1 	:= if(input.sentence_type = 'O.L. Susp. From' ,
								if(input.sentence_description = '','',
									'Lic Susp From:'+input.sentence_description), '');
	self.sent_addl_prov_desc_2 	:= if(input.sentence_type = 'O.L. Susp. To',
								if(input.sentence_description = '','', 
									'Lic Susp To:'+input.sentence_description), '');
	self.sent_consec 			:= '';
	self.sent_agency_rec_cust_ori := '';
	self.sent_agency_rec_cust 	:= '';
	self.appeal_date 			:= '';
	self.appeal_off_disp 		:= '';
	self.appeal_final_decision 	:= '';

end;

pOHCrim := project(dist,tOHCrim(left));

pOHCrim rlpOHCrim(pOHCrim L,pOHCrim R) := TRANSFORM
	self.sent_date  			:= if(l.sent_date  = '', r.sent_date , l.sent_date);
	self.sent_jail  			:= if(l.sent_jail  = '', r.sent_jail , l.sent_jail);
	self.sent_susp_time  		:= if(l.sent_susp_time  = '', r.sent_susp_time , l.sent_susp_time);
	self.sent_court_cost 		:= if(l.sent_court_cost = '', r.sent_court_cost, l.sent_court_cost);
	self.sent_court_fine  		:= if(l.sent_court_fine  = '', r.sent_court_fine , l.sent_court_fine);
	self.sent_susp_court_fine  	:= if(l.sent_susp_court_fine  = '', r.sent_susp_court_fine , l.sent_susp_court_fine);
	self.sent_probation  		:= if(l.sent_probation  = '', r.sent_probation , l.sent_probation);
	self.sent_consec			:= if(l.sent_consec  = '', r.sent_consec , l.sent_consec);
	self.sent_addl_prov_desc_1	:= if(l.sent_addl_prov_desc_1 = '', trim(r.sent_addl_prov_desc_1,all), trim(l.sent_addl_prov_desc_1, all));
	self.sent_addl_prov_desc_2	:= if(l.sent_addl_prov_desc_2 = '', trim(r.sent_addl_prov_desc_2,all), trim(l.sent_addl_prov_desc_2, all));
	SELF := R; 
END;

rlppOHCrimOut := ROLLUP(pOHCrim,LEFT.offender_key =RIGHT.offender_key, rlpOHCrim(LEFT,RIGHT));
fOHOffend:= dedup(sort(distribute(rlppOHCrimOut,hash(offender_key)),
				offender_key,off_comp,court_statute,court_statute_desc,court_off_code,court_off_desc_1, sent_addl_prov_desc_1,sent_addl_prov_desc_2, local),
					offender_key,off_comp,court_statute,court_statute_desc,court_off_code,court_off_desc_1,sent_date,
					sent_jail,sent_susp_time,sent_court_cost,sent_court_fine, sent_susp_court_fine,sent_probation,
					sent_consec, sent_addl_prov_desc_1, sent_addl_prov_desc_2,all,local,left)
									:PERSIST('~thor_data400::persist::Crim_OH_Ross_Offenses');

export Map_OH_Ross_Offenses := fOHOffend;