///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////// INSTRUCTIONS
////// Change OFFENDER, OFFENSES, DATA SOURCE USED, and UPDATE SCHEDULE
////// CHANGE last action in code (around line 676) to either send stats as an attachment or in body of email
//////		noatt sends email w/ stats in body 
//////		wiatt sends email w/ stats in attachment
//////		despray sends file to edata12. no email unless specified with noatt or wiatt
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#workunit('name', 'arrestlogs Output File Stats for Release')

import crim_common, arrestlogs, _Control;

offender := arrestlogs.Map_ID_AdaOffender;
offenses := arrestlogs.Map_ID_AdaOffenses;
data_source_used := 'COURT VENTURES';
update_schedule := 'MONTHLY UPDATES';

output('If necessary - distribute file before passing through BWR');


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



/////////////////////////////////////////////////////////////////
////// CODES V3
/////////////////////////////////////////////////////////////////

tblCodesV3 := table(offenses, {vendor, arr_off_lev, court_off_lev});

OutRec := RECORD, maxlength(4096)
string codesv3_type;
string off_lev_field;
string vendor;
string off_lev;
string off_lev_desc;
END;

findOffDesc(string input) := function
offtype := if(trim(input, all)[1..1] = 'M', 'MISDEMEANOR', if(trim(input, all)[1..1] = 'F', 'FELONY', if(trim(input, all)[1..1] = 'C', 'CITATION', if(trim(input, all)[1..1] = 'T', 'TRAFFIC',  if(trim(input, all)[1..1] = 'O', 'ORDINANCE', if(trim(input, all)[1..1] = 'V', 'VIOLATION', ''))))));
level := if(trim(input, all)[2..2] in ['1', 'A'], 'FIRST DEGREE ', if(trim(input, all)[2..2] in ['2', 'B'], 'SECOND DEGREE ', if(trim(input, all)[2..2] in ['3', 'C'], 'THIRD DEGREE ', if(trim(input, all)[2..2] in ['4', 'D'], 'FOURTH DEGREE ', if(trim(input, all)[2..2] in ['5', 'E'], 'FIFTH DEGREE ', if(trim(input, all)[2..2] in ['6', 'F'], 'SIXTH DEGREE ', ''))))));
desc := level + offtype;
return desc;
end;

OutRec NormIt(tblCodesV3 L, INTEGER C) := TRANSFORM
SELF := L;
SELF.codesv3_type := 'COURT_OFFENSES';
SELF.off_lev_field := CHOOSE(C, 'ARR_OFF_LEV', 'COURT_OFF_LEV');
SELF.off_lev := CHOOSE(C, L.arr_off_lev, L.court_off_lev);
SELF.off_lev_desc := CHOOSE(C,  findOffDesc(L.arr_off_lev), findOffDesc(L.court_off_lev));
END;

CodesV3 := dedup(sort(NORMALIZE(tblCodesV3,2,NormIt(LEFT,COUNTER))(off_lev <> ''), record), record);

output(CodesV3, named('CODES_V3'));

/////////////////////////////////////////////////////////////////
////// VENDOR NUMBER
/////////////////////////////////////////////////////////////////
vendor := table(Offender, {vendor, count(group)}, vendor);
output(vendor, named('VENDOR_NUMBER'));

/////////////////////////////////////////////////////////////////
////// SOURCE FILE
/////////////////////////////////////////////////////////////////
source_file := table(Offender, {source_file, count(group)}, source_file);
output(source_file, named('SOURCE_FILE'));

/////////////////////////////////////////////////////////////////
////// FIELD POPULATIONS
/////////////////////////////////////////////////////////////////

layout_popOFFENDER :=  record
	string50 has_offender_key := 'offender_key: ' + (string)AVE(group,IF(stringlib.stringfilterout(offender.offender_key,'0')<>'',100,0)) + '%';
	string50 has_vendor := 'vendor: ' + (string)AVE(group,IF(stringlib.stringfilterout(offender.vendor,'0')<>'',100,0)) + '%';
	string50 has_state_origin := 'state_origin: ' + (string)AVE(group,IF(stringlib.stringfilterout(offender.state_origin,'0')<>'',100,0)) + '%';
	string50 has_data_type := 'data_type: ' + (string)AVE(group,IF(stringlib.stringfilterout(offender.data_type,'0')<>'',100,0)) + '%';
	string50 has_source_file := 'source_file: ' + (string)AVE(group,IF(stringlib.stringfilterout(offender.source_file,'0')<>'',100,0)) + '%';
	string50 has_case_number := 'case_number: ' + (string)AVE(group,IF(stringlib.stringfilterout(offender.case_number,'0')<>'',100,0)) + '%';
	string50 has_case_court := 'case_court: ' + (string)AVE(group,IF(stringlib.stringfilterout(offender.case_court,'0')<>'',100,0)) + '%';
	string50 has_case_name := 'case_name: ' + (string)AVE(group,IF(stringlib.stringfilterout(offender.case_name,'0')<>'',100,0)) + '%';
	string50 has_case_type := 'case_type: ' + (string)AVE(group,IF(stringlib.stringfilterout(offender.case_type,'0')<>'',100,0)) + '%';
	string50 has_case_type_desc := 'case_type_desc: ' + (string)AVE(group,IF(stringlib.stringfilterout(offender.case_type_desc,'0')<>'',100,0)) + '%';
	string50 has_case_filing_dt := 'case_filing_dt: ' + (string)AVE(group,IF(stringlib.stringfilterout(offender.case_filing_dt,'0')<>'',100,0)) + '%';
	string50 has_pty_nm := 'pty_nm: ' + (string)AVE(group,IF(stringlib.stringfilterout(offender.pty_nm,'0')<>'',100,0)) + '%';
	string50 has_pty_nm_fmt := 'pty_nm_fmt: ' + (string)AVE(group,IF(stringlib.stringfilterout(offender.pty_nm_fmt,'0')<>'',100,0)) + '%';
	string50 has_orig_lname := 'orig_lname: ' + (string)AVE(group,IF(stringlib.stringfilterout(offender.orig_lname,'0')<>'',100,0)) + '%';
	string50 has_orig_fname := 'orig_fname: ' + (string)AVE(group,IF(stringlib.stringfilterout(offender.orig_fname,'0')<>'',100,0)) + '%';
	string50 has_orig_mname := 'orig_mname: ' + (string)AVE(group,IF(stringlib.stringfilterout(offender.orig_mname,'0')<>'',100,0)) + '%';
	string50 has_orig_name_suffix := 'orig_name_suffix: ' + (string)AVE(group,IF(stringlib.stringfilterout(offender.orig_name_suffix,'0')<>'',100,0)) + '%';
	string50 has_pty_typ := 'pty_typ: ' + (string)AVE(group,IF(stringlib.stringfilterout(offender.pty_typ,'0')<>'',100,0)) + '%';
	string50 has_nitro_flag := 'nitro_flag: ' + (string)AVE(group,IF(stringlib.stringfilterout(offender.nitro_flag,'0')<>'',100,0)) + '%';
	string50 has_orig_ssn := 'orig_ssn: ' + (string)AVE(group,IF(stringlib.stringfilterout(offender.orig_ssn,'0')<>'',100,0)) + '%';
	string50 has_dle_num := 'dle_num: ' + (string)AVE(group,IF(stringlib.stringfilterout(offender.dle_num,'0')<>'',100,0)) + '%';
	string50 has_fbi_num := 'fbi_num: ' + (string)AVE(group,IF(stringlib.stringfilterout(offender.fbi_num,'0')<>'',100,0)) + '%';
	string50 has_doc_num := 'doc_num: ' + (string)AVE(group,IF(stringlib.stringfilterout(offender.doc_num,'0')<>'',100,0)) + '%';
	string50 has_ins_num := 'ins_num: ' + (string)AVE(group,IF(stringlib.stringfilterout(offender.ins_num,'0')<>'',100,0)) + '%';
	string50 has_id_num := 'id_num: ' + (string)AVE(group,IF(stringlib.stringfilterout(offender.id_num,'0')<>'',100,0)) + '%';
	string50 has_dl_num := 'dl_num: ' + (string)AVE(group,IF(stringlib.stringfilterout(offender.dl_num,'0')<>'',100,0)) + '%';
	string50 has_dl_state := 'dl_state: ' + (string)AVE(group,IF(stringlib.stringfilterout(offender.dl_state,'0')<>'',100,0)) + '%';
	string50 has_citizenship := 'citizenship: ' + (string)AVE(group,IF(stringlib.stringfilterout(offender.citizenship,'0')<>'',100,0)) + '%';
	string50 has_dob := 'dob: ' + (string)AVE(group,IF(stringlib.stringfilterout(offender.dob,'0')<>'',100,0)) + '%';
	string50 has_dob_alias := 'dob_alias: ' + (string)AVE(group,IF(stringlib.stringfilterout(offender.dob_alias,'0')<>'',100,0)) + '%';
	string50 has_place_of_birth := 'place_of_birth: ' + (string)AVE(group,IF(stringlib.stringfilterout(offender.place_of_birth,'0')<>'',100,0)) + '%';
	string50 has_street_address_1 := 'street_address_1: ' + (string)AVE(group,IF(stringlib.stringfilterout(offender.street_address_1,'0')<>'',100,0)) + '%';
	string50 has_street_address_2 := 'street_address_2: ' + (string)AVE(group,IF(stringlib.stringfilterout(offender.street_address_2,'0')<>'',100,0)) + '%';
	string50 has_street_address_3 := 'street_address_3: ' + (string)AVE(group,IF(stringlib.stringfilterout(offender.street_address_3,'0')<>'',100,0)) + '%';
	string50 has_street_address_4 := 'street_address_4: ' + (string)AVE(group,IF(stringlib.stringfilterout(offender.street_address_4,'0')<>'',100,0)) + '%';
	string50 has_street_address_5 := 'street_address_5: ' + (string)AVE(group,IF(stringlib.stringfilterout(offender.street_address_5,'0')<>'',100,0)) + '%';
	string50 has_race := 'race: ' + (string)AVE(group,IF(stringlib.stringfilterout(offender.race,'0')<>'',100,0)) + '%';
	string50 has_race_desc := 'race_desc: ' + (string)AVE(group,IF(stringlib.stringfilterout(offender.race_desc,'0')<>'',100,0)) + '%';
	string50 has_sex := 'sex: ' + (string)AVE(group,IF(stringlib.stringfilterout(offender.sex,'0')<>'',100,0)) + '%';
	string50 has_hair_color := 'hair_color: ' + (string)AVE(group,IF(stringlib.stringfilterout(offender.hair_color,'0')<>'',100,0)) + '%';
	string50 has_hair_color_desc := 'hair_color_desc: ' + (string)AVE(group,IF(stringlib.stringfilterout(offender.hair_color_desc,'0')<>'',100,0)) + '%';
	string50 has_eye_color := 'eye_color: ' + (string)AVE(group,IF(stringlib.stringfilterout(offender.eye_color,'0')<>'',100,0)) + '%';
	string50 has_eye_color_desc := 'eye_color_desc: ' + (string)AVE(group,IF(stringlib.stringfilterout(offender.eye_color_desc,'0')<>'',100,0)) + '%';
	string50 has_skin_color := 'skin_color: ' + (string)AVE(group,IF(stringlib.stringfilterout(offender.skin_color,'0')<>'',100,0)) + '%';
	string50 has_skin_color_desc := 'skin_color_desc: ' + (string)AVE(group,IF(stringlib.stringfilterout(offender.skin_color_desc,'0')<>'',100,0)) + '%';
	string50 has_height := 'height: ' + (string)AVE(group,IF(stringlib.stringfilterout(offender.height,'0')<>'',100,0)) + '%';
	string50 has_weight := 'weight: ' + (string)AVE(group,IF(stringlib.stringfilterout(offender.weight,'0')<>'',100,0)) + '%';
	string50 has_party_status := 'party_status: ' + (string)AVE(group,IF(stringlib.stringfilterout(offender.party_status,'0')<>'',100,0)) + '%';
	string50 has_party_status_desc := 'party_status_desc: ' + (string)AVE(group,IF(stringlib.stringfilterout(offender.party_status_desc,'0')<>'',100,0)) + '%';
end;

PopStatsOffender := table(offender, layout_popOFFENDER, few);

output(PopStatsOffender, named('Offender_Population_Stats'));

layout_popOFFENSES :=  record
	string50 has_process_date := 'process_date: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.process_date,'0')<>'',100,0)) + '%';
	string50 has_offender_key := 'offender_key: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.offender_key,'0')<>'',100,0)) + '%';
	string50 has_vendor := 'vendor: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.vendor,'0')<>'',100,0)) + '%';
	string50 has_state_origin := 'state_origin: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.state_origin,'0')<>'',100,0)) + '%';
	string50 has_source_file := 'source_file: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.source_file,'0')<>'',100,0)) + '%';
	string50 has_off_comp := 'off_comp: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.off_comp,'0')<>'',100,0)) + '%';
	string50 has_off_delete_flag := 'off_delete_flag: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.off_delete_flag,'0')<>'',100,0)) + '%';
	string50 has_off_date := 'off_date: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.off_date,'0')<>'',100,0)) + '%';
	string50 has_arr_date := 'arr_date: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.arr_date,'0')<>'',100,0)) + '%';
	string50 has_num_of_counts := 'num_of_counts: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.num_of_counts,'0')<>'',100,0)) + '%';
	string50 has_le_agency_cd := 'le_agency_cd: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.le_agency_cd,'0')<>'',100,0)) + '%';
	string50 has_le_agency_desc := 'le_agency_desc: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.le_agency_desc,'0')<>'',100,0)) + '%';
	string50 has_le_agency_case_number := 'le_agency_case_number: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.le_agency_case_number,'0')<>'',100,0)) + '%';
	string50 has_traffic_ticket_number := 'traffic_ticket_number: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.traffic_ticket_number,'0')<>'',100,0)) + '%';
	string50 has_traffic_dl_no := 'traffic_dl_no: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.traffic_dl_no,'0')<>'',100,0)) + '%';
	string50 has_traffic_dl_st := 'traffic_dl_st: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.traffic_dl_st,'0')<>'',100,0)) + '%';
	string50 has_arr_off_code := 'arr_off_code: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.arr_off_code,'0')<>'',100,0)) + '%';
	string50 has_arr_off_desc_1 := 'arr_off_desc_1: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.arr_off_desc_1,'0')<>'',100,0)) + '%';
	string50 has_arr_off_desc_2 := 'arr_off_desc_2: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.arr_off_desc_2,'0')<>'',100,0)) + '%';
	string50 has_arr_off_type_cd := 'arr_off_type_cd: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.arr_off_type_cd,'0')<>'',100,0)) + '%';
	string50 has_arr_off_type_desc := 'arr_off_type_desc: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.arr_off_type_desc,'0')<>'',100,0)) + '%';
	string50 has_arr_off_lev := 'arr_off_lev: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.arr_off_lev,'0')<>'',100,0)) + '%';
	string50 has_arr_statute := 'arr_statute: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.arr_statute,'0')<>'',100,0)) + '%';
	string50 has_arr_statute_desc := 'arr_statute_desc: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.arr_statute_desc,'0')<>'',100,0)) + '%';
	string50 has_arr_disp_date := 'arr_disp_date: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.arr_disp_date,'0')<>'',100,0)) + '%';
	string50 has_arr_disp_code := 'arr_disp_code: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.arr_disp_code,'0')<>'',100,0)) + '%';
	string50 has_arr_disp_desc_1 := 'arr_disp_desc_1: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.arr_disp_desc_1,'0')<>'',100,0)) + '%';
	string50 has_arr_disp_desc_2 := 'arr_disp_desc_2: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.arr_disp_desc_2,'0')<>'',100,0)) + '%';
	string50 has_pros_refer_cd := 'pros_refer_cd: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.pros_refer_cd,'0')<>'',100,0)) + '%';
	string50 has_pros_refer := 'pros_refer: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.pros_refer,'0')<>'',100,0)) + '%';
	string50 has_pros_assgn_cd := 'pros_assgn_cd: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.pros_assgn_cd,'0')<>'',100,0)) + '%';
	string50 has_pros_assgn := 'pros_assgn: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.pros_assgn,'0')<>'',100,0)) + '%';
	string50 has_pros_chg_rej := 'pros_chg_rej: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.pros_chg_rej,'0')<>'',100,0)) + '%';
	string50 has_pros_off_code := 'pros_off_code: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.pros_off_code,'0')<>'',100,0)) + '%';
	string50 has_pros_off_desc_1 := 'pros_off_desc_1: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.pros_off_desc_1,'0')<>'',100,0)) + '%';
	string50 has_pros_off_desc_2 := 'pros_off_desc_2: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.pros_off_desc_2,'0')<>'',100,0)) + '%';
	string50 has_pros_off_type_cd := 'pros_off_type_cd: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.pros_off_type_cd,'0')<>'',100,0)) + '%';
	string50 has_pros_off_type_desc := 'pros_off_type_desc: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.pros_off_type_desc,'0')<>'',100,0)) + '%';
	string50 has_pros_off_lev := 'pros_off_lev: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.pros_off_lev,'0')<>'',100,0)) + '%';
	string50 has_pros_act_filed := 'pros_act_filed: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.pros_act_filed,'0')<>'',100,0)) + '%';
	string50 has_court_case_number := 'court_case_number: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.court_case_number,'0')<>'',100,0)) + '%';
	string50 has_court_cd := 'court_cd: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.court_cd,'0')<>'',100,0)) + '%';
	string50 has_court_desc := 'court_desc: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.court_desc,'0')<>'',100,0)) + '%';
	string50 has_court_appeal_flag := 'court_appeal_flag: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.court_appeal_flag,'0')<>'',100,0)) + '%';
	string50 has_court_final_plea := 'court_final_plea: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.court_final_plea,'0')<>'',100,0)) + '%';
	string50 has_court_off_code := 'court_off_code: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.court_off_code,'0')<>'',100,0)) + '%';
	string50 has_court_off_desc_1 := 'court_off_desc_1: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.court_off_desc_1,'0')<>'',100,0)) + '%';
	string50 has_court_off_desc_2 := 'court_off_desc_2: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.court_off_desc_2,'0')<>'',100,0)) + '%';
	string50 has_court_off_type_cd := 'court_off_type_cd: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.court_off_type_cd,'0')<>'',100,0)) + '%';
	string50 has_court_off_type_desc := 'court_off_type_desc: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.court_off_type_desc,'0')<>'',100,0)) + '%';
	string50 has_court_off_lev := 'court_off_lev: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.court_off_lev,'0')<>'',100,0)) + '%';
	string50 has_court_statute := 'court_statute: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.court_statute,'0')<>'',100,0)) + '%';
	string50 has_court_additional_statutes := 'court_additional_statutes: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.court_additional_statutes,'0')<>'',100,0)) + '%';
	string50 has_court_statute_desc := 'court_statute_desc: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.court_statute_desc,'0')<>'',100,0)) + '%';
	string50 has_court_disp_date := 'court_disp_date: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.court_disp_date,'0')<>'',100,0)) + '%';
	string50 has_court_disp_code := 'court_disp_code: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.court_disp_code,'0')<>'',100,0)) + '%';
	string50 has_court_disp_desc_1 := 'court_disp_desc_1: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.court_disp_desc_1,'0')<>'',100,0)) + '%';
	string50 has_court_disp_desc_2 := 'court_disp_desc_2: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.court_disp_desc_2,'0')<>'',100,0)) + '%';
	string50 has_sent_date := 'sent_date: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.sent_date,'0')<>'',100,0)) + '%';
	string50 has_sent_jail := 'sent_jail: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.sent_jail,'0')<>'',100,0)) + '%';
	string50 has_sent_susp_time := 'sent_susp_time: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.sent_susp_time,'0')<>'',100,0)) + '%';
	string50 has_sent_court_cost := 'sent_court_cost: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.sent_court_cost,'0')<>'',100,0)) + '%';
	string50 has_sent_court_fine := 'sent_court_fine: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.sent_court_fine,'0')<>'',100,0)) + '%';
	string50 has_sent_susp_court_fine := 'sent_susp_court_fine: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.sent_susp_court_fine,'0')<>'',100,0)) + '%';
	string50 has_sent_probation := 'sent_probation: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.sent_probation,'0')<>'',100,0)) + '%';
	string50 has_sent_addl_prov_code := 'sent_addl_prov_code: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.sent_addl_prov_code,'0')<>'',100,0)) + '%';
	string50 has_sent_addl_prov_desc_1 := 'sent_addl_prov_desc_1: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.sent_addl_prov_desc_1,'0')<>'',100,0)) + '%';
	string50 has_sent_addl_prov_desc_2 := 'sent_addl_prov_desc_2: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.sent_addl_prov_desc_2,'0')<>'',100,0)) + '%';
	string50 has_sent_consec := 'sent_consec: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.sent_consec,'0')<>'',100,0)) + '%';
	string50 has_sent_agency_rec_cust_ori := 'sent_agency_rec_cust_ori: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.sent_agency_rec_cust_ori,'0')<>'',100,0)) + '%';
	string50 has_sent_agency_rec_cust := 'sent_agency_rec_cust: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.sent_agency_rec_cust,'0')<>'',100,0)) + '%';
	string50 has_appeal_date := 'appeal_date: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.appeal_date,'0')<>'',100,0)) + '%';
	string50 has_appeal_off_disp := 'appeal_off_disp: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.appeal_off_disp,'0')<>'',100,0)) + '%';
	string50 has_appeal_final_decision := 'appeal_final_decision: ' + (string)AVE(group,IF(stringlib.stringfilterout(offenses.appeal_final_decision,'0')<>'',100,0)) + '%';
END;

PopStatsOffenses := table(offenses, layout_popOFFENSES, few);

output(PopStatsOffenses, named('Offenses_Population_Stats'));

/////////////////////////////////////////////////////////////////
////// RECORD COUNTS
/////////////////////////////////////////////////////////////////

output(count(offender), named('HOW_MANY_OFFENDER_RECORDS'));

output(count(offenses), named('HOW_MANY_OFFENSE_RECORDS'));

///////////////////////////////////////////////////////////////
//// INDIVIDUAL TABLES with COUNTS
///////////////////////////////////////////////////////////////

///// CASE TYPES
case_types := sort(table(offender, {string80 case_type := case_type, amount := count(group)}, case_type, few), record);
output( case_types,named('CASE_TYPES'), all);

///// FILING DATES
filing_dt := sort(table(offender, {string80 case_filing_dt := case_filing_dt, amount := count(group)}, case_filing_dt, few), record);
filing_dt_d := 'FILING DATES:' + min(filing_dt(case_filing_dt <> ''), case_filing_dt[1..6]) + ' - ' + max(filing_dt, case_filing_dt[1..6]);
output( filing_dt,named('CASE_FILING_DATES'), all);

///// OFFENSE DATES
off_dt := sort(table(offenses, {string80 off_date := off_date, amount := count(group)}, off_date, few), record);
off_dt_d:= 'OFFENSE DATES:' + min(off_dt(off_date<>''), off_date[1..6]) + ' - ' + max(off_dt, off_date[1..6]);
output( off_dt ,named('OFFENSE_DATES'), all);

///// ARREST DATES
arr_dt := sort(table(offenses, {string80 arr_date := arr_date, amount := count(group)}, arr_date, few), record);
arr_dt_d:='ARREST DATES:' + min(arr_dt(arr_date<>''), arr_date[1..6]) + ' - ' + max(arr_dt, arr_date[1..6]);
output( arr_dt ,named('ARREST_DATES'), all);

///// ARREST DISPOSITION DATES
arr_disp_dt := sort(table(offenses, {string80 arr_disp_date := arr_disp_date, amount := count(group)}, arr_disp_date, few), record);
arr_disp_dt_d := 'ARREST DISPOSITION DATES:' + min(arr_disp_dt(arr_disp_date<>''), arr_disp_date[1..6]) + ' - ' + max(arr_disp_dt, arr_disp_date[1..6]);
output( arr_disp_dt,named('ARREST_DISP_DATES'), all);

///// COURT DISPOSITION DATES
court_disp_dt := sort(table(offenses, {string80 court_disp_date := court_disp_date, amount := count(group)}, court_disp_date, few), record);
court_disp_dt_d := 'COURT DISPOSITION DATES:' + min(court_disp_dt(court_disp_date<>''), court_disp_date[1..6]) + ' - ' + max(court_disp_dt, court_disp_date[1..6]);
output( court_disp_dt ,named('COURT_DISPOSITION_DATES'), all);

///// SENT DATES
sent_dt := sort(table(offenses, {string80 sent_date := sent_date, amount := count(group)}, sent_date, few), record);
sent_dt_d := 'SENTENCE DATES:' + min(sent_dt(sent_date<>''), sent_date[1..6]) + ' - ' + max(sent_dt, sent_date[1..6]);
output( sent_dt ,named('SENTENCE_DATES'), all);

///// APPEAL DATES
app_dt := sort(table(offenses, {string80 appeal_date := appeal_date, amount := count(group)}, appeal_date, few), record);
app_dt_d := 'APPEAL DATES:' + min(app_dt(appeal_date<>''), appeal_date[1..6]) + ' - ' + max(app_dt, appeal_date[1..6]);
output( app_dt ,named('APPEAL_DATES'), all);

///// OFFENSE LEVELS
arr_off_levs := sort(table(offenses, {string80 arr_off_lev := arr_off_lev, amount := count(group)}, arr_off_lev, few), record);
court_off_levs := sort(table(offenses, {string80 court_off_lev := court_off_lev, amount := count(group)}, court_off_lev, few), record);
output(arr_off_levs ,named('ARREST_OFFENSE_LEVELS'));
output(court_off_levs ,named('COURT_OFFENSE_LEVELS'));

///// COURT DISPOSITION DESCRIPTIONS
disps := sort(table(offenses, {string80 court_disp_desc_1 := court_disp_desc_1, amount := count(group)}, court_disp_desc_1, few), record);
output( disps ,named('DISPOSITION_DESCRIPTION'), all);

///// OFFENSE DESCRIPTIONS

courtoff := table(offenses, {string80 off_desc:=court_off_desc_1, amount := count(group)}, court_off_desc_1);
arrestoff := table(offenses, {string80 off_desc:=arr_off_desc_1, amount := count(group)}, arr_off_desc_1);
courtoff1 := table(offenses, {string80 off_desc:=court_off_desc_1}, court_off_desc_1);
arrestoff1 := table(offenses, {string80 off_desc:=arr_off_desc_1}, arr_off_desc_1);

output( dedup(table(courtoff1 + arrestoff1, {off_desc, amount := count(group)}, off_desc), all),named('ALL_OFFENSE_DESCRIPTIONS'), all);

///// STATUTE DESCRIPTIONS

courtsta := table(offenses, {string80 statute_desc:= arr_statute_desc, amount := count(group)}, arr_statute_desc);
arreststa := table(offenses, {string80 statute_desc:= court_statute_desc, amount := count(group)}, court_statute_desc);
courtsta1 := table(offenses, {string80 statute_desc:= arr_statute_desc}, arr_statute_desc);
arreststa1 := table(offenses, {string80 statute_desc:= court_statute_desc}, court_statute_desc);

output( dedup(table(courtsta1 + arreststa1, {statute_desc, amount := count(group)}, statute_desc), all),named('ALL_STATUTE_DESCRIPTIONS'), all);

///// SECURINT OUTPUT FIND TRAFFIC

inputFile := offenses;

traffic_in_lkup := '(BICYCLE)|(BOATING)|(BRAKES)|(BYPASSING)|(CITATION)|(CURVE)|(DEER)|(DRIVER)|(EXHAUST)|(FAILURE)|(HEADGEAR)|(HEADLIGHTS)|(HUNTING)|(INSURANCE)|(JAY)|(JOYRIDING)|(LANE)|(LANGUAGE)|(LEFT)|(LICENSE)|(LIGHT)|(LITTER)|(MPH)|(MUFFLER)|(N/A)|(NOISE)|(OUTRAGGING)|(OUTRAGING)|(PASSING)|(PLATE)|(POSTPONEMENT)|(PUBLIC)|(RED)|(RIGHT)|(SAFETY)|(SEAT BELT)|(SEATBELT)|(SIDEWALK)|(SIGN)|(SPEED)|(SPEEDING)|(STOP)|(TRAFFIC)|(TRAILER)|(TRIAL DE NOVO)|(WALKING)|(WHITETAIL)|(WILDLIFE)|(WRONG)|(WRONG WAY)|(YEILD)|(ZONE)|(ZONING)';
traffic_out_lkup := '(IMPERSONATING)|(EMBEZZ)|(ESCAPE)|(DESTRUCTION)|(METH)|(ECSTASY)|(RAPE)|(WEAPON)|(REVOKE)|(CANCEL)|(SUSPEND)|(DRIVING WHILE IMPAIRED)|(TRESPASS)|(UNDER 21)|(FICTITIOUS)|(POSS)|(GUN)|(FIREARM)|(FELON)|(EMENOR)|(MARIJUANA)|(ALCOHOLIC)|(FRAUD)|(POSSESS)|(ASSAULT)|(BATTERY)|(MALICIOUS)|(PETIT)|(DUI)|(LARCENY)|(TAMPER)|(SEX)|(REFUSE)|(REFUSING)|(TRESPASS)|(TRASPASS)|(TRAFFICKING)|(MANUFACTUR)|(BOGUS)|(MINOR)|(MURDER)|(CREDIT)|(UTTERING)|(FALSE)|(UNAUTHOR)|(DISCHARGING FIREARMS)|(UNLAWFUL)|(DRUG)';

filterin := inputFile(regexfind(traffic_in_lkup, regexreplace(' +', stringlib.stringtouppercase(court_off_desc_1), ' ')));
filterout := filterin(~regexfind(traffic_out_lkup,regexreplace(' +', stringlib.stringtouppercase(court_off_desc_1), ' ')));

tFiltered := group(table(filterout, {court_off_desc_1}, court_off_desc_1), all);

output('This output is only to narrow down your search - Sift through traffic violations and keep the ones that meet the criteria', named('___'));
output(tFiltered, all, named('POTENTIAL_TRAFFIC_VIOLATIONS'));

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// REFORMAT FOR OUTPUT - REFORMAT FOR OUTPUT - REFORMAT FOR OUTPUT - REFORMAT FOR OUTPUT - REFORMAT FOR OUTPUT
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

oneline := record string100 line; DECIMAL11_2 order; string2 eor := '\r\n'; end;

LINE1 := dataset([{'CODES V3', 1}], oneline);

oneline refCODESV3(CodesV3 l) := transform
	self.line := trim(l.codesv3_type, left, right) + ',' + trim(l.off_lev_field, left, right) + ',' + trim(l.vendor, left, right) + ',' + trim(l.off_lev, left, right) + ',' + trim(l.off_lev_desc, left, right);
	self.order := 2;
end;

LINE2 := project(CodesV3, refCODESV3(left));

oneline refvendor(vendor l) := transform
	self.line := 'VENDOR NUMBER: ' + l.vendor;
	self.order := 3;
end;

LINE3 := project(vendor, refvendor(left))[1];

LINE4 := dataset([{'DATA SOURCE USED: ' + data_source_used, 4}], oneline);

oneline refsource(source_file l) := transform
	self.line := 'SOURCE FILE: ' + l.source_file;
	self.order := 5;
end;

LINE5 := project(source_file, refsource(left))[1];

oneline offendernorm(PopStatsOffender L, INTEGER C) := TRANSFORM
	self.order := 6;
SELF.line := CHOOSE(C,'OFFENDER POPULATION STATS: ' , l.has_offender_key ,
		l.has_vendor ,
		l.has_state_origin ,
		l.has_data_type ,
		l.has_source_file ,
		l.has_case_number ,
		l.has_case_court ,
		l.has_case_name ,
		l.has_case_type ,
		l.has_case_type_desc ,
		l.has_case_filing_dt ,
		l.has_pty_nm ,
		l.has_pty_nm_fmt ,
		l.has_orig_lname ,
		l.has_orig_fname ,
		l.has_orig_mname ,
		l.has_orig_name_suffix ,
		l.has_pty_typ ,
		l.has_nitro_flag ,
		l.has_orig_ssn ,
		l.has_dle_num ,
		l.has_fbi_num ,
		l.has_doc_num ,
		l.has_ins_num ,
		l.has_id_num ,
		l.has_dl_num ,
		l.has_dl_state ,
		l.has_citizenship ,
		l.has_dob ,
		l.has_dob_alias ,
		l.has_place_of_birth ,
		l.has_street_address_1 ,
		l.has_street_address_2 ,
		l.has_street_address_3 ,
		l.has_street_address_4 ,
		l.has_street_address_5 ,
		l.has_race ,
		l.has_race_desc ,
		l.has_sex ,
		l.has_hair_color ,
		l.has_hair_color_desc ,
		l.has_eye_color ,
		l.has_eye_color_desc ,
		l.has_skin_color ,
		l.has_skin_color_desc ,
		l.has_height ,
		l.has_weight ,
		l.has_party_status ,
		l.has_party_status_desc);
END;

LINE6 := NORMALIZE(PopStatsOffender,50,offendernorm(LEFT,COUNTER));

oneline offensesnorm(PopStatsOffenses L, INTEGER C) := TRANSFORM
	self.order := 7;
SELF.line := CHOOSE(C,'OFFENSES POPULATION STATS: ', l.has_process_date , 
		l.has_offender_key , 
		l.has_vendor , 
		l.has_state_origin , 
		l.has_source_file , 
		l.has_off_comp , 
		l.has_off_delete_flag , 
		l.has_off_date , 
		l.has_arr_date , 
		l.has_num_of_counts , 
		l.has_le_agency_cd , 
		l.has_le_agency_desc , 
		l.has_le_agency_case_number , 
		l.has_traffic_ticket_number , 
		l.has_traffic_dl_no , 
		l.has_traffic_dl_st , 
		l.has_arr_off_code , 
		l.has_arr_off_desc_1 , 
		l.has_arr_off_desc_2 , 
		l.has_arr_off_type_cd , 
		l.has_arr_off_type_desc , 
		l.has_arr_off_lev , 
		l.has_arr_statute , 
		l.has_arr_statute_desc , 
		l.has_arr_disp_date , 
		l.has_arr_disp_code , 
		l.has_arr_disp_desc_1 , 
		l.has_arr_disp_desc_2 , 
		l.has_pros_refer_cd , 
		l.has_pros_refer , 
		l.has_pros_assgn_cd , 
		l.has_pros_assgn , 
		l.has_pros_chg_rej , 
		l.has_pros_off_code , 
		l.has_pros_off_desc_1 , 
		l.has_pros_off_desc_2 , 
		l.has_pros_off_type_cd , 
		l.has_pros_off_type_desc , 
		l.has_pros_off_lev , 
		l.has_pros_act_filed , 
		l.has_court_case_number , 
		l.has_court_cd , 
		l.has_court_desc , 
		l.has_court_appeal_flag , 
		l.has_court_final_plea , 
		l.has_court_off_code , 
		l.has_court_off_desc_1 , 
		l.has_court_off_desc_2 , 
		l.has_court_off_type_cd , 
		l.has_court_off_type_desc , 
		l.has_court_off_lev , 
		l.has_court_statute , 
		l.has_court_additional_statutes , 
		l.has_court_statute_desc , 
		l.has_court_disp_date , 
		l.has_court_disp_code , 
		l.has_court_disp_desc_1 , 
		l.has_court_disp_desc_2 , 
		l.has_sent_date , 
		l.has_sent_jail , 
		l.has_sent_susp_time , 
		l.has_sent_court_cost , 
		l.has_sent_court_fine , 
		l.has_sent_susp_court_fine , 
		l.has_sent_probation , 
		l.has_sent_addl_prov_code , 
		l.has_sent_addl_prov_desc_1 , 
		l.has_sent_addl_prov_desc_2 , 
		l.has_sent_consec , 
		l.has_sent_agency_rec_cust_ori , 
		l.has_sent_agency_rec_cust , 
		l.has_appeal_date , 
		l.has_appeal_off_disp , 
		l.has_appeal_final_decision);
END;

LINE7 := NORMALIZE(PopStatsOffenses,75,offensesnorm(LEFT,COUNTER));

LINE8 := dataset([{update_schedule, 8}], oneline);

oneline refcase_types(case_types l) := transform
	self.order :=9;
	self.line := if(l.case_type = '', '(BLANK) ', l.case_type) + trim((string)l.amount, all) + ' times';
end;

LINE9 := project(case_types, refcase_types(left));

LINE10 := dataset([{filing_dt_d, 10}], oneline);

oneline refdates1(filing_dt l) := transform
	self.order := 11;
	self.line := if(l.case_filing_dt = '', '(BLANK) ', l.case_filing_dt) + trim((string)l.amount, all) + ' times';
end;

LINE11 := project(filing_dt, refdates1(left));

oneline refdates2(arr_dt l) := transform
	self.line := if(l.arr_date = '', '(BLANK) ', l.arr_date) + trim((string)l.amount, all) + ' times';
	self.order := 12.5;
end;

LINE12 := project(arr_dt, refdates2(left));

oneline refdates3(off_dt l) := transform
	self.line := if(l.off_date = '', '(BLANK) ', l.off_date) + trim((string)l.amount, all) + ' times';
	self.order := 13.5;
end;

LINE13 := project(off_dt, refdates3(left));

oneline refdates4(arr_disp_dt l) := transform
	self.line := if(l.arr_disp_date = '', '(BLANK) ', l.arr_disp_date) + trim((string)l.amount, all) + ' times';
	self.order := 14.5;
end;

LINE14 := project(arr_disp_dt, refdates4(left));

oneline refdates5(court_disp_dt l) := transform
	self.line := if(l.court_disp_date = '', '(BLANK) ', l.court_disp_date) + trim((string)l.amount, all) + ' times';
	self.order := 15.5;
end;

LINE15 := project(court_disp_dt, refdates5(left));

oneline refdates6(sent_dt l) := transform
	self.line := if(l.sent_date = '', '(BLANK) ', l.sent_date) + trim((string)l.amount, all) + ' times';
	self.order := 16.5;
end;

LINE16 := project(sent_dt, refdates6(left));

oneline refdates7(app_dt l) := transform
	self.line := if(l.appeal_date = '', '(BLANK) ', l.appeal_date) + trim((string)l.amount, all) + ' times';
	self.order := 17.5;
end;

LINE17 := project(app_dt, refdates7(left));

oneline refaol(arr_off_levs l) := transform
	self.line := if(l.arr_off_lev = '', '(BLANK) ', l.arr_off_lev) + trim((string)l.amount, all) + ' times';
	self.order := 18.5;
end;

LINE18 := project(arr_off_levs, refaol(left));

oneline refcol(court_off_levs l) := transform
	self.line := if(l.court_off_lev = '', '(BLANK) ', l.court_off_lev) + trim((string)l.amount, all) + ' times';
	self.order := 19.5;
end;

LINE19 := project(court_off_levs, refcol(left));

oneline refdisp(disps l) := transform
	self.line := if(l.court_disp_desc_1 = '', '(BLANK) ', l.court_disp_desc_1 ) + trim((string)l.amount, all) + ' times';
	self.order := 20.5;
end;

LINE20 := sort(project(disps, refdisp(left)), record);

// courtoff1:=table(courtoff, {off_desc, amount := count(group)}, off_desc);

oneline refcoff(courtoff l) := transform
	self.line := if(l.off_desc = '', '(BLANK) ', l.off_desc) + trim((string)l.amount, all) + ' times';
	self.order := 21.5;
end;

LINE21 := sort(project(courtoff, refcoff(left)), record);

// arroff1:=table(arrestoff, {off_desc, amount := count(group)}, off_desc);

oneline refaoff(arrestoff l) := transform
	self.line := if(l.off_desc = '', '(BLANK) ', l.off_desc) + trim((string)l.amount, all) + ' times';
	self.order := 22.5;
end;

LINE22 := sort(project(arrestoff, refaoff(left)), record);

// courtsta1:=table(courtsta, {statute_desc, amount := count(group)}, statute_desc);

oneline refcstat(courtsta l) := transform
	self.line := if(l.statute_desc = '', '(BLANK) ', l.statute_desc) + trim((string)l.amount, all) + ' times';
	self.order := 23.5;
end;

LINE23 := sort(project(courtsta, refcstat(left)), record);

// arreststa1:=table(arreststa, {statute_desc, amount := count(group)}, statute_desc);

oneline refastat(arreststa l) := transform
	self.line := if(l.statute_desc = '', '(BLANK) ' , l.statute_desc) + trim((string)l.amount, all) + ' times';
	self.order := 24.5;
end;

LINE24 := sort(project(arreststa, refastat(left)), record);

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// OUTPUTS          OUTPUTS          OUTPUTS          OUTPUTS          OUTPUTS          OUTPUTS          OUTPUTS          
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

srtoutfile := 	sort((line1 + dataset([{' ', 1.9}], oneline) + line2 + dataset([{' ', 2.9}], oneline) + line3 + dataset([{' ', 3.9}], oneline) + 
			line4 + dataset([{' ', 4.9}], oneline) + line5 + dataset([{' ', 5.9}], oneline) + LINE6 + dataset([{' ', 6.9}], oneline) + LINE7 + 
			dataset([{' ', 7.6}], oneline) + LINE8 + dataset([{' ', 8.6}], oneline) + 
			dataset([{'CASE TYPES:', 8.8}], oneline) + LINE9 + dataset([{' ', 9.9}], oneline) + //LINE10 + 
			dataset([{' ', 10.9}], oneline) + dataset([{filing_dt_d, 11}], oneline) + sort(LINE11, line) + 
			dataset([{' ', 11.9}], oneline) + dataset([{arr_dt_d, 12}], oneline) + sort(LINE12, line) + 
			dataset([{' ', 12.9}], oneline) + dataset([{off_dt_d, 13}], oneline) + sort(LINE13, line) + 
			dataset([{' ', 13.9}], oneline) + dataset([{arr_disp_dt_d, 14}], oneline) + sort(LINE14, line) + 
			dataset([{' ', 14.9}], oneline) + dataset([{court_disp_dt_d, 15}], oneline) + sort(LINE15, line) + 
			dataset([{' ', 15.9}], oneline) + dataset([{sent_dt_d, 16}], oneline) + sort(LINE16, line) + 
			dataset([{' ', 16.9}], oneline) + dataset([{app_dt_d, 17}], oneline) + sort(LINE17, line) +
			dataset([{' ', 17.6}], oneline) + dataset([{'ARREST OFFENSE LEVELS:', 17.8}], oneline) + LINE18 + 
			dataset([{' ', 18.6}], oneline) + dataset([{'COURT OFFENSE LEVELS:', 18.8}], oneline) + LINE19 +
			dataset([{' ', 19.6}], oneline) + dataset([{'COURT DISPOSITION DESCRIPTIONS:', 19.8}], oneline) + LINE20 + 
			dataset([{' ', 20.6}], oneline) + dataset([{'COURT OFFENSE DESCRIPTIONS:', 20.8}], oneline) + LINE21 + 
			dataset([{' ', 21.6}], oneline) + dataset([{'ARREST OFFENSE DESCRIPTIONS:', 21.8}], oneline) + LINE22 + 
			dataset([{' ', 22.6}], oneline) + dataset([{'COURT STATUTE DESCRIPTIONS:', 22.8}], oneline) + LINE23 + 
			dataset([{' ', 23.6}], oneline) + dataset([{'ARREST STATUTE DESCRIPTIONS:', 23.8}], oneline) + LINE24)(~regexfind(' 0%', line)), order)
;

outfile_layout := record string115 line; string2 eor := '\r\n'; end;

outfile_layout cleanit(oneline l) := transform
	self.line := regexreplace('\t',stringlib.stringfindreplace(l.line, '  -  ', ''), '');
	self := l;
end;

outfile := project(srtoutfile, cleanit(left));


////////////////////////////////////////////////////////////////////////////////////////////////////////////


myrec := record, maxlength(9999999) 
unsigned code0; 
unsigned code1; 
string line; end;

myrec ref(outfile l, integer c) := transform 
self.code0 := c; 
self.code1 := c + 1; 
self := l; end;

inputs := project(outfile, ref(left, counter));

MyRec Xform(myrec L,myrec R) := TRANSFORM
SELF.line := trim(L.line, left, right) + '\n' + trim(R.line, left, right); 
self := l;
END;

XtabOut := ROLLUP(inputs,Xform(LEFT,RIGHT), left.code1 = right.code0);

///////////////////// SEND EMAIL WITHOUT ATTACTMENT	
noatt :=	FileServices.SendEmail( 'cguyton@seisint.com, jtao@seisint.com, kHumayun@seisint.com, cpettola@seisint.com, tgibson@seisint.com',
	'New Arrestlogs Alert Email '+Thorlib.WUID(), 
	XtabOut[1].line);
///////////////////// SEND EMAIL WITH ATTACTMENT
wiatt :=	FileServices.SendEmailAttachText( 'cguyton@seisint.com, jtao@seisint.com, kHumayun@seisint.com, cpettola@seisint.com, tgibson@seisint.com',
	'New Arrestlogs Alert Email '+Thorlib.WUID(), 
	XtabOut[1].line,
	'Stats Complete - Please view attachment\n**File on thor expires in 7 days',
	// XtabOut[1].line,
	'text/xml',
	'attachment.txt') ;
///////////////////// DESPRAY RESULTS
despray:=fileservices.Despray('~thor_dell400::out::stats::arrestlogs_new_ds_'+Thorlib.WUID(), _Control.IPAddress.edata12, '/stub_cleaning/court/work/arrestlogs_new_ds_'+Thorlib.WUID(),,,,true);

///////////////////////////////////////////////////////////////////////////////////////////////////////////
///// OPTIONS:
///// 	noatt - send email with stats in body
///// 	wiatt - send email with stats as attachment
///// 	despray - no email, despray file
///////////////////////////////////////////////////////////////////////////////////////////////////////////

sequential(
	output(outfile,,'~thor_dell400::out::stats::arrestlogs_new_ds_'+Thorlib.WUID(), overwrite, expire (7)),
	noatt
);
