//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Crim.Moxie_Court_Offenses_Dev_BWR_Hygiene - Hygiene & Stats - SALT V3.11.9');
IMPORT Scrubs_Crim,SALT311;
// First create an instantiated hygiene module
  infile := Scrubs_Crim.Moxie_Court_Offenses_Dev_In_crim;
  ip := DISTRIBUTE(infile, SKEW(0.1));
  h := Scrubs_Crim.Moxie_Court_Offenses_Dev_hygiene(ip);
  p := h.AllProfiles; // Detailed profile of every field
  OUTPUT(h.Summary('SummaryReport'),ALL,NAMED('Summary'));
  OUTPUT(h.SourceCounts,ALL,NAMED('SourceCounts'));
  OUTPUT(h.CrossLinkingPotential,ALL,NAMED('CrossLinkingPotential'));
  OUTPUT(h.invSummary,NAMED('InvertedSummary'),ALL);
  OUTPUT(p,NAMED('AllProfiles'),ALL); // Detailed profile of every field
  OUTPUT(h.Correlations,NAMED('Correlations'),ALL); // Which fields are related to which other fields
  OUTPUT(h.ValidityErrors,NAMED('ValidityErrors'),ALL); // Violations of FieldType statements
  OUTPUT(SALT311.MAC_Character_Counts.EclRecord(p,'Moxie_Court_Offenses_Dev_Layout_crim'),NAMED('OptimizedLayout'));// File layout suggested by data
  // Produces field types that match the most common 99.9% of your data. Change to 100 to match all your data
  OUTPUT(SALT311.MAC_Character_Counts.FieldTypes(p,99.9),NAMED('Types'));
  // ****** Cross Tabs *******
  // It is possible to create a cross table between any two fields, see documentation on SALT311.MAC_CrossTab
  // These commented out lines will create crosstabs from the sourcefield to each individual field
  // IF you find yourself using ALL of these a LOT - let me know, I can make the 'all' case faster
   Examples := 10;
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,process_date,Examples),NAMED('process_dateByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,offender_key,Examples),NAMED('offender_keyByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,state_origin,Examples),NAMED('state_originByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,source_file,Examples),NAMED('source_fileByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,data_type,Examples),NAMED('data_typeByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,off_comp,Examples),NAMED('off_compByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,off_delete_flag,Examples),NAMED('off_delete_flagByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,off_date,Examples),NAMED('off_dateByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,arr_date,Examples),NAMED('arr_dateByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,num_of_counts,Examples),NAMED('num_of_countsByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,le_agency_cd,Examples),NAMED('le_agency_cdByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,le_agency_desc,Examples),NAMED('le_agency_descByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,le_agency_case_number,Examples),NAMED('le_agency_case_numberByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,traffic_ticket_number,Examples),NAMED('traffic_ticket_numberByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,traffic_dl_no,Examples),NAMED('traffic_dl_noByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,traffic_dl_st,Examples),NAMED('traffic_dl_stByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,arr_off_code,Examples),NAMED('arr_off_codeByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,arr_off_desc_1,Examples),NAMED('arr_off_desc_1Byvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,arr_off_desc_2,Examples),NAMED('arr_off_desc_2Byvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,arr_off_type_cd,Examples),NAMED('arr_off_type_cdByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,arr_off_type_desc,Examples),NAMED('arr_off_type_descByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,arr_off_lev,Examples),NAMED('arr_off_levByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,arr_statute,Examples),NAMED('arr_statuteByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,arr_statute_desc,Examples),NAMED('arr_statute_descByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,arr_disp_date,Examples),NAMED('arr_disp_dateByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,arr_disp_code,Examples),NAMED('arr_disp_codeByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,arr_disp_desc_1,Examples),NAMED('arr_disp_desc_1Byvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,arr_disp_desc_2,Examples),NAMED('arr_disp_desc_2Byvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,pros_refer_cd,Examples),NAMED('pros_refer_cdByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,pros_refer,Examples),NAMED('pros_referByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,pros_assgn_cd,Examples),NAMED('pros_assgn_cdByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,pros_assgn,Examples),NAMED('pros_assgnByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,pros_chg_rej,Examples),NAMED('pros_chg_rejByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,pros_off_code,Examples),NAMED('pros_off_codeByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,pros_off_desc_1,Examples),NAMED('pros_off_desc_1Byvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,pros_off_desc_2,Examples),NAMED('pros_off_desc_2Byvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,pros_off_type_cd,Examples),NAMED('pros_off_type_cdByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,pros_off_type_desc,Examples),NAMED('pros_off_type_descByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,pros_off_lev,Examples),NAMED('pros_off_levByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,pros_act_filed,Examples),NAMED('pros_act_filedByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,court_case_number,Examples),NAMED('court_case_numberByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,court_cd,Examples),NAMED('court_cdByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,court_desc,Examples),NAMED('court_descByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,court_appeal_flag,Examples),NAMED('court_appeal_flagByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,court_final_plea,Examples),NAMED('court_final_pleaByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,court_off_code,Examples),NAMED('court_off_codeByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,court_off_desc_1,Examples),NAMED('court_off_desc_1Byvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,court_off_desc_2,Examples),NAMED('court_off_desc_2Byvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,court_off_type_cd,Examples),NAMED('court_off_type_cdByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,court_off_type_desc,Examples),NAMED('court_off_type_descByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,court_off_lev,Examples),NAMED('court_off_levByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,court_statute,Examples),NAMED('court_statuteByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,court_additional_statutes,Examples),NAMED('court_additional_statutesByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,court_statute_desc,Examples),NAMED('court_statute_descByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,court_disp_date,Examples),NAMED('court_disp_dateByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,court_disp_code,Examples),NAMED('court_disp_codeByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,court_disp_desc_1,Examples),NAMED('court_disp_desc_1Byvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,court_disp_desc_2,Examples),NAMED('court_disp_desc_2Byvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,sent_date,Examples),NAMED('sent_dateByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,sent_jail,Examples),NAMED('sent_jailByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,sent_susp_time,Examples),NAMED('sent_susp_timeByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,sent_court_cost,Examples),NAMED('sent_court_costByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,sent_court_fine,Examples),NAMED('sent_court_fineByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,sent_susp_court_fine,Examples),NAMED('sent_susp_court_fineByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,sent_probation,Examples),NAMED('sent_probationByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,sent_addl_prov_code,Examples),NAMED('sent_addl_prov_codeByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,sent_addl_prov_desc_1,Examples),NAMED('sent_addl_prov_desc_1Byvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,sent_addl_prov_desc_2,Examples),NAMED('sent_addl_prov_desc_2Byvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,sent_consec,Examples),NAMED('sent_consecByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,sent_agency_rec_cust_ori,Examples),NAMED('sent_agency_rec_cust_oriByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,sent_agency_rec_cust,Examples),NAMED('sent_agency_rec_custByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,appeal_date,Examples),NAMED('appeal_dateByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,appeal_off_disp,Examples),NAMED('appeal_off_dispByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,appeal_final_decision,Examples),NAMED('appeal_final_decisionByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,convict_dt,Examples),NAMED('convict_dtByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,offense_town,Examples),NAMED('offense_townByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,cty_conv,Examples),NAMED('cty_convByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,restitution,Examples),NAMED('restitutionByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,community_service,Examples),NAMED('community_serviceByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,parole,Examples),NAMED('paroleByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,addl_sent_dates,Examples),NAMED('addl_sent_datesByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,probation_desc2,Examples),NAMED('probation_desc2Byvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,court_dt,Examples),NAMED('court_dtByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,court_county,Examples),NAMED('court_countyByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,arr_off_lev_mapped,Examples),NAMED('arr_off_lev_mappedByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,court_off_lev_mapped,Examples),NAMED('court_off_lev_mappedByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,fcra_offense_key,Examples),NAMED('fcra_offense_keyByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,fcra_conviction_flag,Examples),NAMED('fcra_conviction_flagByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,fcra_traffic_flag,Examples),NAMED('fcra_traffic_flagByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,fcra_date,Examples),NAMED('fcra_dateByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,fcra_date_type,Examples),NAMED('fcra_date_typeByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,conviction_override_date,Examples),NAMED('conviction_override_dateByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,conviction_override_date_type,Examples),NAMED('conviction_override_date_typeByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,offense_score,Examples),NAMED('offense_scoreByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,offense_persistent_id,Examples),NAMED('offense_persistent_idByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,offense_category,Examples),NAMED('offense_categoryByvendor'));
