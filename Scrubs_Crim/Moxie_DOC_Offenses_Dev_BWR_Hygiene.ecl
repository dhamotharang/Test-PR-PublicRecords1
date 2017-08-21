//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Crim.Moxie_DOC_Offenses_Dev_BWR_Hygiene - Hygiene & Stats - SALT V3.3.2');
IMPORT Scrubs_Crim,SALT33;
// First create an instantiated hygiene module
  infile := Scrubs_Crim.Moxie_DOC_Offenses_Dev_In_crim;
  ip := DISTRIBUTE(infile, SKEW(0.1));
  h := Scrubs_Crim.Moxie_DOC_Offenses_Dev_Hygiene(ip);
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
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,county_of_origin,Examples),NAMED('county_of_originByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,source_file,Examples),NAMED('source_fileByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,data_type,Examples),NAMED('data_typeByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,record_type,Examples),NAMED('record_typeByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,orig_state,Examples),NAMED('orig_stateByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,offense_key,Examples),NAMED('offense_keyByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,off_date,Examples),NAMED('off_dateByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,arr_date,Examples),NAMED('arr_dateByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,case_num,Examples),NAMED('case_numByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,total_num_of_offenses,Examples),NAMED('total_num_of_offensesByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,num_of_counts,Examples),NAMED('num_of_countsByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,off_code,Examples),NAMED('off_codeByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,chg,Examples),NAMED('chgByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,chg_typ_flg,Examples),NAMED('chg_typ_flgByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,off_of_record,Examples),NAMED('off_of_recordByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,off_desc_1,Examples),NAMED('off_desc_1Byvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,off_desc_2,Examples),NAMED('off_desc_2Byvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,add_off_cd,Examples),NAMED('add_off_cdByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,add_off_desc,Examples),NAMED('add_off_descByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,off_typ,Examples),NAMED('off_typByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,off_lev,Examples),NAMED('off_levByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,arr_disp_date,Examples),NAMED('arr_disp_dateByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,arr_disp_cd,Examples),NAMED('arr_disp_cdByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,arr_disp_desc_1,Examples),NAMED('arr_disp_desc_1Byvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,arr_disp_desc_2,Examples),NAMED('arr_disp_desc_2Byvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,arr_disp_desc_3,Examples),NAMED('arr_disp_desc_3Byvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,court_cd,Examples),NAMED('court_cdByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,court_desc,Examples),NAMED('court_descByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,ct_dist,Examples),NAMED('ct_distByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,ct_fnl_plea_cd,Examples),NAMED('ct_fnl_plea_cdByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,ct_fnl_plea,Examples),NAMED('ct_fnl_pleaByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,ct_off_code,Examples),NAMED('ct_off_codeByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,ct_chg,Examples),NAMED('ct_chgByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,ct_chg_typ_flg,Examples),NAMED('ct_chg_typ_flgByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,ct_off_desc_1,Examples),NAMED('ct_off_desc_1Byvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,ct_off_desc_2,Examples),NAMED('ct_off_desc_2Byvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,ct_addl_desc_cd,Examples),NAMED('ct_addl_desc_cdByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,ct_off_lev,Examples),NAMED('ct_off_levByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,ct_disp_dt,Examples),NAMED('ct_disp_dtByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,ct_disp_cd,Examples),NAMED('ct_disp_cdByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,ct_disp_desc_1,Examples),NAMED('ct_disp_desc_1Byvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,ct_disp_desc_2,Examples),NAMED('ct_disp_desc_2Byvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,cty_conv_cd,Examples),NAMED('cty_conv_cdByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,cty_conv,Examples),NAMED('cty_convByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,adj_wthd,Examples),NAMED('adj_wthdByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,stc_dt,Examples),NAMED('stc_dtByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,stc_cd,Examples),NAMED('stc_cdByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,stc_comp,Examples),NAMED('stc_compByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,stc_desc_1,Examples),NAMED('stc_desc_1Byvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,stc_desc_2,Examples),NAMED('stc_desc_2Byvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,stc_desc_3,Examples),NAMED('stc_desc_3Byvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,stc_desc_4,Examples),NAMED('stc_desc_4Byvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,stc_lgth,Examples),NAMED('stc_lgthByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,stc_lgth_desc,Examples),NAMED('stc_lgth_descByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,inc_adm_dt,Examples),NAMED('inc_adm_dtByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,min_term,Examples),NAMED('min_termByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,min_term_desc,Examples),NAMED('min_term_descByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,max_term,Examples),NAMED('max_termByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,max_term_desc,Examples),NAMED('max_term_descByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,parole,Examples),NAMED('paroleByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,probation,Examples),NAMED('probationByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,offensetown,Examples),NAMED('offensetownByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,convict_dt,Examples),NAMED('convict_dtByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,court_county,Examples),NAMED('court_countyByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,fcra_offense_key,Examples),NAMED('fcra_offense_keyByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,fcra_conviction_flag,Examples),NAMED('fcra_conviction_flagByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,fcra_traffic_flag,Examples),NAMED('fcra_traffic_flagByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,fcra_date,Examples),NAMED('fcra_dateByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,fcra_date_type,Examples),NAMED('fcra_date_typeByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,conviction_override_date,Examples),NAMED('conviction_override_dateByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,conviction_override_date_type,Examples),NAMED('conviction_override_date_typeByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,offense_score,Examples),NAMED('offense_scoreByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,offense_persistent_id,Examples),NAMED('offense_persistent_idByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,offense_category,Examples),NAMED('offense_categoryByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,hyg_classification_code,Examples),NAMED('hyg_classification_codeByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,old_ln_offense_score,Examples),NAMED('old_ln_offense_scoreByvendor'));
