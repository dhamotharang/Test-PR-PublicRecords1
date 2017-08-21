ds_offender := doc.map_doc_ri_offender;
ds_offenses := doc.map_doc_ri_offenses;
ds_punishment := doc.map_doc_ri_punishment;

count(ds_offender);
count(ds_offenses);
count(ds_punishment);

rPopulationStats_offender
 :=
record
CountGroup                                  := count(group); 
offender_key_AveNonBlank := AVE(group,if(ds_offender.offender_key<>'',100,0));
vendor_AveNonBlank := AVE(group,if(ds_offender.vendor<>'',100,0));
source_file_AveNonBlank := AVE(group,if(ds_offender.source_file<>'',100,0));
id_num_AveNonBlank := AVE(group,if(ds_offender.id_num<>'',100,0));
pty_nm_AveNonBlank := AVE(group,if(ds_offender.pty_nm<>'',100,0));
pty_nm_fmt_AveNonBlank := AVE(group,if(ds_offender.pty_nm_fmt<>'',100,0));
orig_lname_AveNonBlank := AVE(group,if(ds_offender.orig_lname<>'',100,0));
orig_fname_AveNonBlank := AVE(group,if(ds_offender.orig_fname<>'',100,0));
orig_mname_AveNonBlank := AVE(group,if(ds_offender.orig_mname<>'',100,0));
orig_name_suffix_AveNonBlank := AVE(group,if(ds_offender.orig_name_suffix<>'',100,0));
pty_typ_AveNonBlank := AVE(group,if(ds_offender.pty_typ<>'',100,0));
orig_ssn_AveNonBlank := AVE(group,if(ds_offender.orig_ssn<>'',100,0));
dle_num_AveNonBlank := AVE(group,if(ds_offender.dle_num<>'',100,0));
fbi_num_AveNonBlank := AVE(group,if(ds_offender.fbi_num<>'',100,0));
doc_num_AveNonBlank := AVE(group,if(ds_offender.doc_num<>'',100,0));
ins_num_AveNonBlank := AVE(group,if(ds_offender.ins_num<>'',100,0));
citizenship_AveNonBlank := AVE(group,if(ds_offender.citizenship<>'',100,0));
dob_AveNonBlank := AVE(group,if(ds_offender.dob<>'',100,0));
place_of_birth_AveNonBlank := AVE(group,if(ds_offender.place_of_birth<>'',100,0));
street_address_1_AveNonBlank := AVE(group,if(ds_offender.street_address_1<>'',100,0));
street_address_2_AveNonBlank := AVE(group,if(ds_offender.street_address_2<>'',100,0));
street_address_3_AveNonBlank := AVE(group,if(ds_offender.street_address_3<>'',100,0));
street_address_4_AveNonBlank := AVE(group,if(ds_offender.street_address_4<>'',100,0));
street_address_5_AveNonBlank := AVE(group,if(ds_offender.street_address_5<>'',100,0));
race_AveNonBlank := AVE(group,if(ds_offender.race<>'',100,0));
race_desc_AveNonBlank := AVE(group,if(ds_offender.race_desc<>'',100,0));
sex_AveNonBlank := AVE(group,if(ds_offender.sex<>'',100,0));
hair_color_AveNonBlank := AVE(group,if(ds_offender.hair_color<>'',100,0));
hair_color_desc_AveNonBlank := AVE(group,if(ds_offender.hair_color_desc<>'',100,0));
eye_color_AveNonBlank := AVE(group,if(ds_offender.eye_color<>'',100,0));
eye_color_desc_AveNonBlank := AVE(group,if(ds_offender.eye_color_desc<>'',100,0));
skin_color_AveNonBlank := AVE(group,if(ds_offender.skin_color<>'',100,0));
skin_color_desc_AveNonBlank := AVE(group,if(ds_offender.skin_color_desc<>'',100,0));
height_AveNonBlank := AVE(group,if(ds_offender.height<>'',100,0));
weight_AveNonBlank := AVE(group,if(ds_offender.weight<>'',100,0));
party_status_AveNonBlank := AVE(group,if(ds_offender.party_status<>'',100,0));
party_status_desc_AveNonBlank := AVE(group,if(ds_offender.party_status_desc<>'',100,0));
data_type_AveNonBlank := AVE(group,if(ds_offender.data_type<>'',100,0));
end;
tStats_offender := table(ds_offender,rPopulationStats_offender,few);
output(tStats_offender);


rPopulationStats_offenses
 :=
  record
CountGroup                                       := count(group); 
offender_key_AveNonBlank := AVE(group,if(ds_offenses.offender_key<>'',100,0));
vendor_AveNonBlank := AVE(group,if(ds_offenses.vendor<>'',100,0));
source_file_AveNonBlank := AVE(group,if(ds_offenses.source_file<>'',100,0));
offense_key_AveNonBlank := AVE(group,if(ds_offenses.offense_key<>'',100,0));
off_date_AveNonBlank := AVE(group,if(ds_offenses.off_date<>'',100,0));
arr_date_AveNonBlank := AVE(group,if(ds_offenses.arr_date<>'',100,0));
case_num_AveNonBlank := AVE(group,if(ds_offenses.case_num<>'',100,0));
num_of_counts_AveNonBlank := AVE(group,if(ds_offenses.num_of_counts<>'',100,0));
off_code_AveNonBlank := AVE(group,if(ds_offenses.off_code<>'',100,0));
chg_AveNonBlank := AVE(group,if(ds_offenses.chg<>'',100,0));
chg_typ_flg_AveNonBlank := AVE(group,if(ds_offenses.chg_typ_flg<>'',100,0));
off_desc_1_AveNonBlank := AVE(group,if(ds_offenses.off_desc_1<>'',100,0));
off_desc_2_AveNonBlank := AVE(group,if(ds_offenses.off_desc_2<>'',100,0));
add_off_cd_AveNonBlank := AVE(group,if(ds_offenses.add_off_cd<>'',100,0));
add_off_desc_AveNonBlank := AVE(group,if(ds_offenses.add_off_desc<>'',100,0));
off_typ_AveNonBlank := AVE(group,if(ds_offenses.off_typ<>'',100,0));
off_lev_AveNonBlank := AVE(group,if(ds_offenses.off_lev<>'',100,0));
arr_disp_date_AveNonBlank := AVE(group,if(ds_offenses.arr_disp_date<>'',100,0));
arr_disp_cd_AveNonBlank := AVE(group,if(ds_offenses.arr_disp_cd<>'',100,0));
arr_disp_desc_1_AveNonBlank := AVE(group,if(ds_offenses.arr_disp_desc_1<>'',100,0));
arr_disp_desc_2_AveNonBlank := AVE(group,if(ds_offenses.arr_disp_desc_2<>'',100,0));
arr_disp_desc_3_AveNonBlank := AVE(group,if(ds_offenses.arr_disp_desc_3<>'',100,0));
court_cd_AveNonBlank := AVE(group,if(ds_offenses.court_cd<>'',100,0));
court_desc_AveNonBlank := AVE(group,if(ds_offenses.court_desc<>'',100,0));
ct_dist_AveNonBlank := AVE(group,if(ds_offenses.ct_dist<>'',100,0));
ct_fnl_plea_cd_AveNonBlank := AVE(group,if(ds_offenses.ct_fnl_plea_cd<>'',100,0));
ct_fnl_plea_AveNonBlank := AVE(group,if(ds_offenses.ct_fnl_plea<>'',100,0));
ct_off_code_AveNonBlank := AVE(group,if(ds_offenses.ct_off_code<>'',100,0));
ct_chg_AveNonBlank := AVE(group,if(ds_offenses.ct_chg<>'',100,0));
ct_chg_typ_flg_AveNonBlank := AVE(group,if(ds_offenses.ct_chg_typ_flg<>'',100,0));
ct_off_desc_1_AveNonBlank := AVE(group,if(ds_offenses.ct_off_desc_1<>'',100,0));
ct_off_desc_2_AveNonBlank := AVE(group,if(ds_offenses.ct_off_desc_2<>'',100,0));
ct_addl_desc_cd_AveNonBlank := AVE(group,if(ds_offenses.ct_addl_desc_cd<>'',100,0));
ct_off_lev_AveNonBlank := AVE(group,if(ds_offenses.ct_off_lev<>'',100,0));
ct_disp_dt_AveNonBlank := AVE(group,if(ds_offenses.ct_disp_dt<>'',100,0));
ct_disp_cd_AveNonBlank := AVE(group,if(ds_offenses.ct_disp_cd<>'',100,0));
ct_disp_desc_1_AveNonBlank := AVE(group,if(ds_offenses.ct_disp_desc_1<>'',100,0));
ct_disp_desc_2_AveNonBlank := AVE(group,if(ds_offenses.ct_disp_desc_2<>'',100,0));
cty_conv_cd_AveNonBlank := AVE(group,if(ds_offenses.cty_conv_cd<>'',100,0));
cty_conv_AveNonBlank := AVE(group,if(ds_offenses.cty_conv<>'',100,0));
adj_wthd_AveNonBlank := AVE(group,if(ds_offenses.adj_wthd<>'',100,0));
stc_dt_AveNonBlank := AVE(group,if(ds_offenses.stc_dt<>'',100,0));
stc_cd_AveNonBlank := AVE(group,if(ds_offenses.stc_cd<>'',100,0));
stc_comp_AveNonBlank := AVE(group,if(ds_offenses.stc_comp<>'',100,0));
stc_desc_1_AveNonBlank := AVE(group,if(ds_offenses.stc_desc_1<>'',100,0));
stc_desc_2_AveNonBlank := AVE(group,if(ds_offenses.stc_desc_2<>'',100,0));
stc_desc_3_AveNonBlank := AVE(group,if(ds_offenses.stc_desc_3<>'',100,0));
stc_desc_4_AveNonBlank := AVE(group,if(ds_offenses.stc_desc_4<>'',100,0));
stc_lgth_AveNonBlank := AVE(group,if(ds_offenses.stc_lgth<>'',100,0));
stc_lgth_desc_AveNonBlank := AVE(group,if(ds_offenses.stc_lgth_desc<>'',100,0));
inc_adm_dt_AveNonBlank := AVE(group,if(ds_offenses.inc_adm_dt<>'',100,0));
min_term_AveNonBlank := AVE(group,if(ds_offenses.min_term<>'',100,0));
min_term_desc_AveNonBlank := AVE(group,if(ds_offenses.min_term_desc<>'',100,0));
max_term_AveNonBlank := AVE(group,if(ds_offenses.max_term<>'',100,0));
max_term_desc_AveNonBlank := AVE(group,if(ds_offenses.max_term_desc<>'',100,0));
end;
tStats_offenses := table(ds_offenses,rPopulationStats_offenses,few);
output(tStats_offenses);


rPopulationStats_punishment
 :=
  record
CountGroup                                       := count(group); 
process_date_AveNonBlank := AVE(group,if(ds_punishment.process_date<>'',100,0));
offender_key_AveNonBlank := AVE(group,if(ds_punishment.offender_key<>'',100,0));
event_dt_AveNonBlank := AVE(group,if(ds_punishment.event_dt<>'',100,0));
vendor_AveNonBlank := AVE(group,if(ds_punishment.vendor<>'',100,0));
source_file_AveNonBlank := AVE(group,if(ds_punishment.source_file<>'',100,0));
offense_key_AveNonBlank := AVE(group,if(ds_punishment.offense_key<>'',100,0));
punishment_type_AveNonBlank := AVE(group,if(ds_punishment.punishment_type<>'',100,0));
sent_length_AveNonBlank := AVE(group,if(ds_punishment.sent_length<>'',100,0));
sent_length_desc_AveNonBlank := AVE(group,if(ds_punishment.sent_length_desc<>'',100,0));
cur_stat_inm_AveNonBlank := AVE(group,if(ds_punishment.cur_stat_inm<>'',100,0));
cur_stat_inm_desc_AveNonBlank := AVE(group,if(ds_punishment.cur_stat_inm_desc<>'',100,0));
cur_loc_inm_cd_AveNonBlank := AVE(group,if(ds_punishment.cur_loc_inm_cd<>'',100,0));
cur_loc_inm_AveNonBlank := AVE(group,if(ds_punishment.cur_loc_inm<>'',100,0));
inm_com_cty_cd_AveNonBlank := AVE(group,if(ds_punishment.inm_com_cty_cd<>'',100,0));
inm_com_cty_AveNonBlank := AVE(group,if(ds_punishment.inm_com_cty<>'',100,0));
cur_sec_class_dt_AveNonBlank := AVE(group,if(ds_punishment.cur_sec_class_dt<>'',100,0));
cur_loc_sec_AveNonBlank := AVE(group,if(ds_punishment.cur_loc_sec<>'',100,0));
gain_time_AveNonBlank := AVE(group,if(ds_punishment.gain_time<>'',100,0));
gain_time_eff_dt_AveNonBlank := AVE(group,if(ds_punishment.gain_time_eff_dt<>'',100,0));
latest_adm_dt_AveNonBlank := AVE(group,if(ds_punishment.latest_adm_dt<>'',100,0));
sch_rel_dt_AveNonBlank := AVE(group,if(ds_punishment.sch_rel_dt<>'',100,0));
act_rel_dt_AveNonBlank := AVE(group,if(ds_punishment.act_rel_dt<>'',100,0));
ctl_rel_dt_AveNonBlank := AVE(group,if(ds_punishment.ctl_rel_dt<>'',100,0));
presump_par_rel_dt_AveNonBlank := AVE(group,if(ds_punishment.presump_par_rel_dt<>'',100,0));
mutl_part_pgm_dt_AveNonBlank := AVE(group,if(ds_punishment.mutl_part_pgm_dt<>'',100,0));
par_cur_stat_AveNonBlank := AVE(group,if(ds_punishment.par_cur_stat<>'',100,0));
par_cur_stat_desc_AveNonBlank := AVE(group,if(ds_punishment.par_cur_stat_desc<>'',100,0));
par_st_dt_AveNonBlank := AVE(group,if(ds_punishment.par_st_dt<>'',100,0));
par_sch_end_dt_AveNonBlank := AVE(group,if(ds_punishment.par_sch_end_dt<>'',100,0));
par_act_end_dt_AveNonBlank := AVE(group,if(ds_punishment.par_act_end_dt<>'',100,0));
par_cty_cd_AveNonBlank := AVE(group,if(ds_punishment.par_cty_cd<>'',100,0));
par_cty_AveNonBlank := AVE(group,if(ds_punishment.par_cty<>'',100,0));
end;
tStats_punishment := table(ds_punishment,rPopulationStats_punishment,few);
output(tStats_punishment);
