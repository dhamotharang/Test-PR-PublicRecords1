//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Crim.Moxie_DOC_Punishment_Dev_BWR_Hygiene - Hygiene & Stats - SALT V3.3.2');
IMPORT Scrubs_Crim,SALT33;
// First create an instantiated hygiene module
  infile := Scrubs_Crim.Moxie_DOC_Punishment_Dev_In_crim;
  ip := DISTRIBUTE(infile, SKEW(0.1));
  h := Scrubs_Crim.Moxie_DOC_Punishment_Dev_Hygiene(ip);
  p := h.AllProfiles; // Detailed profile of every field
  OUTPUT(h.Summary('SummaryReport'),ALL);
  OUTPUT(h.SourceCounts,ALL,NAMED('SourceCounts'));
  OUTPUT(h.CrossLinkingPotential,ALL,NAMED('CrossLinkingPotential'));
  OUTPUT(h.invSummary,NAMED('InvertedSummary'),ALL);
  OUTPUT(p,NAMED('AllProfiles'),ALL); // Detailed profile of every field
  OUTPUT(h.Correlations,NAMED('Correlations'),ALL); // Which fields are related to which other fields
  OUTPUT(h.ValidityErrors,NAMED('ValidityErrors'),ALL); // Violations of FieldType statements
  OUTPUT(SALT33.MAC_Character_Counts.EclRecord(p,'Layout_crim'),NAMED('OptimizedLayout'));// File layout suggested by data
  // Produces field types that match the most common 99.9% of your data. Change to 100 to match all your data
  OUTPUT(SALT33.MAC_Character_Counts.FieldTypes(p,99.9),NAMED('Types'));
  // ****** Cross Tabs *******
  // It is possible to create a cross table between any two fields, see documentation on SALT33.MAC_CrossTab
  // These commented out lines will create crosstabs from the sourcefield to each individual field
  // IF you find yourself using ALL of these a LOT - let me know, I can make the 'all' case faster
   Examples := 10;
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,process_date,Examples),NAMED('process_dateByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,offender_key,Examples),NAMED('offender_keyByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,event_dt,Examples),NAMED('event_dtByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,source_file,Examples),NAMED('source_fileByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,record_type,Examples),NAMED('record_typeByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,orig_state,Examples),NAMED('orig_stateByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,offense_key,Examples),NAMED('offense_keyByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,punishment_type,Examples),NAMED('punishment_typeByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,sent_date,Examples),NAMED('sent_dateByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,sent_length,Examples),NAMED('sent_lengthByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,sent_length_desc,Examples),NAMED('sent_length_descByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,cur_stat_inm,Examples),NAMED('cur_stat_inmByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,cur_stat_inm_desc,Examples),NAMED('cur_stat_inm_descByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,cur_loc_inm_cd,Examples),NAMED('cur_loc_inm_cdByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,cur_loc_inm,Examples),NAMED('cur_loc_inmByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,inm_com_cty_cd,Examples),NAMED('inm_com_cty_cdByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,inm_com_cty,Examples),NAMED('inm_com_ctyByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,cur_sec_class_dt,Examples),NAMED('cur_sec_class_dtByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,cur_loc_sec,Examples),NAMED('cur_loc_secByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,gain_time,Examples),NAMED('gain_timeByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,gain_time_eff_dt,Examples),NAMED('gain_time_eff_dtByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,latest_adm_dt,Examples),NAMED('latest_adm_dtByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,sch_rel_dt,Examples),NAMED('sch_rel_dtByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,act_rel_dt,Examples),NAMED('act_rel_dtByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,ctl_rel_dt,Examples),NAMED('ctl_rel_dtByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,presump_par_rel_dt,Examples),NAMED('presump_par_rel_dtByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,mutl_part_pgm_dt,Examples),NAMED('mutl_part_pgm_dtByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,release_type,Examples),NAMED('release_typeByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,office_region,Examples),NAMED('office_regionByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,par_cur_stat,Examples),NAMED('par_cur_statByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,par_cur_stat_desc,Examples),NAMED('par_cur_stat_descByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,par_status_dt,Examples),NAMED('par_status_dtByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,par_st_dt,Examples),NAMED('par_st_dtByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,par_sch_end_dt,Examples),NAMED('par_sch_end_dtByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,par_act_end_dt,Examples),NAMED('par_act_end_dtByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,par_cty_cd,Examples),NAMED('par_cty_cdByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,par_cty,Examples),NAMED('par_ctyByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,supv_office,Examples),NAMED('supv_officeByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,supv_officer,Examples),NAMED('supv_officerByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,office_phone,Examples),NAMED('office_phoneByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,tdcjid_unit_type,Examples),NAMED('tdcjid_unit_typeByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,tdcjid_unit_assigned,Examples),NAMED('tdcjid_unit_assignedByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,tdcjid_admit_date,Examples),NAMED('tdcjid_admit_dateByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,prison_status,Examples),NAMED('prison_statusByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,recv_dept_code,Examples),NAMED('recv_dept_codeByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,recv_dept_date,Examples),NAMED('recv_dept_dateByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,parole_active_flag,Examples),NAMED('parole_active_flagByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,casepull_date,Examples),NAMED('casepull_dateByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,pro_st_dt,Examples),NAMED('pro_st_dtByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,pro_end_dt,Examples),NAMED('pro_end_dtByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,pro_status,Examples),NAMED('pro_statusByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,conviction_override_date,Examples),NAMED('conviction_override_dateByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,conviction_override_date_type,Examples),NAMED('conviction_override_date_typeByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,punishment_persistent_id,Examples),NAMED('punishment_persistent_idByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,fcra_date,Examples),NAMED('fcra_dateByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,fcra_date_type,Examples),NAMED('fcra_date_typeByvendor'));
