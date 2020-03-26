IMPORT SALT311,STD;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE

// The module to handle the case where no scrubs exist
  EXPORT NumRules := 660;
  EXPORT NumRulesFromFieldType := 660;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 633;
  EXPORT NumFieldsWithPossibleEdits := 23;
  EXPORT NumRulesWithPossibleEdits := 44;
  EXPORT Expanded_Layout := RECORD(Layout_Dunndata_Consumer)
    UNSIGNED1 dtmatch_Invalid;
    BOOLEAN dtmatch_wouldClean;
    UNSIGNED1 msname_Invalid;
    BOOLEAN msname_wouldClean;
    UNSIGNED1 msaddr1_Invalid;
    BOOLEAN msaddr1_wouldClean;
    UNSIGNED1 msaddr2_Invalid;
    BOOLEAN msaddr2_wouldClean;
    UNSIGNED1 mscity_Invalid;
    BOOLEAN mscity_wouldClean;
    UNSIGNED1 msstate_Invalid;
    BOOLEAN msstate_wouldClean;
    UNSIGNED1 mszip5_Invalid;
    BOOLEAN mszip5_wouldClean;
    UNSIGNED1 mszip4_Invalid;
    BOOLEAN mszip4_wouldClean;
    UNSIGNED1 dthh_Invalid;
    BOOLEAN dthh_wouldClean;
    UNSIGNED1 mscrrt_Invalid;
    BOOLEAN mscrrt_wouldClean;
    UNSIGNED1 msdpbc_Invalid;
    BOOLEAN msdpbc_wouldClean;
    UNSIGNED1 msdpv_Invalid;
    BOOLEAN msdpv_wouldClean;
    UNSIGNED1 ms_addrtype_Invalid;
    BOOLEAN ms_addrtype_wouldClean;
    UNSIGNED1 ctysize_Invalid;
    BOOLEAN ctysize_wouldClean;
    UNSIGNED1 lmos_Invalid;
    UNSIGNED1 omos_Invalid;
    UNSIGNED1 pmos_Invalid;
    UNSIGNED1 gen_Invalid;
    UNSIGNED1 dob_Invalid;
    UNSIGNED1 age_Invalid;
    UNSIGNED1 inc_Invalid;
    UNSIGNED1 marital_status_Invalid;
    UNSIGNED1 poc_Invalid;
    UNSIGNED1 noc_Invalid;
    BOOLEAN noc_wouldClean;
    UNSIGNED1 ocp_Invalid;
    UNSIGNED1 edu_Invalid;
    UNSIGNED1 lang_Invalid;
    BOOLEAN lang_wouldClean;
    UNSIGNED1 relig_Invalid;
    UNSIGNED1 dwell_Invalid;
    UNSIGNED1 ownr_Invalid;
    UNSIGNED1 eth1_Invalid;
    BOOLEAN eth1_wouldClean;
    UNSIGNED1 eth2_Invalid;
    BOOLEAN eth2_wouldClean;
    UNSIGNED1 lor_Invalid;
    BOOLEAN lor_wouldClean;
    UNSIGNED1 pool_Invalid;
    BOOLEAN pool_wouldClean;
    UNSIGNED1 speak_span_Invalid;
    BOOLEAN speak_span_wouldClean;
    UNSIGNED1 soho_Invalid;
    BOOLEAN soho_wouldClean;
    UNSIGNED1 vet_in_hh_Invalid;
    BOOLEAN vet_in_hh_wouldClean;
    UNSIGNED1 ms_mags_Invalid;
    UNSIGNED1 ms_books_Invalid;
    UNSIGNED1 ms_publish_Invalid;
    UNSIGNED1 ms_pub_status_active_Invalid;
    UNSIGNED1 ms_pub_status_expire_Invalid;
    UNSIGNED1 ms_pub_premsold_Invalid;
    UNSIGNED1 ms_pub_autornwl_Invalid;
    UNSIGNED1 ms_pub_avgterm_Invalid;
    UNSIGNED1 ms_pub_lmos_Invalid;
    UNSIGNED1 ms_pub_omos_Invalid;
    UNSIGNED1 ms_pub_pmos_Invalid;
    UNSIGNED1 ms_pub_cemos_Invalid;
    UNSIGNED1 ms_pub_femos_Invalid;
    UNSIGNED1 ms_pub_totords_Invalid;
    UNSIGNED1 ms_pub_totdlrs_Invalid;
    UNSIGNED1 ms_pub_avgdlrs_Invalid;
    UNSIGNED1 ms_pub_lastdlrs_Invalid;
    UNSIGNED1 ms_pub_paystat_paid_Invalid;
    UNSIGNED1 ms_pub_paystat_ub_Invalid;
    UNSIGNED1 ms_pub_paymeth_cc_Invalid;
    UNSIGNED1 ms_pub_paymeth_cash_Invalid;
    UNSIGNED1 ms_pub_payspeed_Invalid;
    UNSIGNED1 ms_pub_osrc_dm_Invalid;
    UNSIGNED1 ms_pub_lsrc_dm_Invalid;
    UNSIGNED1 ms_pub_osrc_agt_cashf_Invalid;
    UNSIGNED1 ms_pub_lsrc_agt_cashf_Invalid;
    UNSIGNED1 ms_pub_osrc_agt_pds_Invalid;
    UNSIGNED1 ms_pub_lsrc_agt_pds_Invalid;
    UNSIGNED1 ms_pub_osrc_agt_schplan_Invalid;
    UNSIGNED1 ms_pub_lsrc_agt_schplan_Invalid;
    UNSIGNED1 ms_pub_osrc_agt_sponsor_Invalid;
    UNSIGNED1 ms_pub_lsrc_agt_sponsor_Invalid;
    UNSIGNED1 ms_pub_osrc_agt_tm_Invalid;
    UNSIGNED1 ms_pub_lsrc_agt_tm_Invalid;
    UNSIGNED1 ms_pub_osrc_agt_Invalid;
    UNSIGNED1 ms_pub_lsrc_agt_Invalid;
    UNSIGNED1 ms_pub_osrc_tm_Invalid;
    UNSIGNED1 ms_pub_lsrc_tm_Invalid;
    UNSIGNED1 ms_pub_osrc_ins_Invalid;
    UNSIGNED1 ms_pub_lsrc_ins_Invalid;
    UNSIGNED1 ms_pub_osrc_net_Invalid;
    UNSIGNED1 ms_pub_lsrc_net_Invalid;
    UNSIGNED1 ms_pub_osrc_print_Invalid;
    UNSIGNED1 ms_pub_lsrc_print_Invalid;
    UNSIGNED1 ms_pub_osrc_trans_Invalid;
    UNSIGNED1 ms_pub_lsrc_trans_Invalid;
    UNSIGNED1 ms_pub_osrc_tv_Invalid;
    UNSIGNED1 ms_pub_lsrc_tv_Invalid;
    UNSIGNED1 ms_pub_osrc_dtp_Invalid;
    UNSIGNED1 ms_pub_lsrc_dtp_Invalid;
    UNSIGNED1 ms_pub_giftgivr_Invalid;
    UNSIGNED1 ms_pub_giftee_Invalid;
    UNSIGNED1 ms_catalog_Invalid;
    UNSIGNED1 ms_cat_lmos_Invalid;
    UNSIGNED1 ms_cat_omos_Invalid;
    UNSIGNED1 ms_cat_pmos_Invalid;
    UNSIGNED1 ms_cat_totords_Invalid;
    UNSIGNED1 ms_cat_totitems_Invalid;
    UNSIGNED1 ms_cat_totdlrs_Invalid;
    UNSIGNED1 ms_cat_avgdlrs_Invalid;
    UNSIGNED1 ms_cat_lastdlrs_Invalid;
    UNSIGNED1 ms_cat_paystat_paid_Invalid;
    UNSIGNED1 ms_cat_paymeth_cc_Invalid;
    UNSIGNED1 ms_cat_paymeth_cash_Invalid;
    UNSIGNED1 ms_cat_osrc_dm_Invalid;
    UNSIGNED1 ms_cat_lsrc_dm_Invalid;
    UNSIGNED1 ms_cat_osrc_net_Invalid;
    UNSIGNED1 ms_cat_lsrc_net_Invalid;
    UNSIGNED1 ms_cat_giftgivr_Invalid;
    UNSIGNED1 pkpubs_corrected_Invalid;
    UNSIGNED1 pkcatg_corrected_Invalid;
    UNSIGNED1 ms_fundraising_Invalid;
    UNSIGNED1 ms_fund_lmos_Invalid;
    UNSIGNED1 ms_fund_omos_Invalid;
    UNSIGNED1 ms_fund_pmos_Invalid;
    UNSIGNED1 ms_fund_totords_Invalid;
    UNSIGNED1 ms_fund_totdlrs_Invalid;
    UNSIGNED1 ms_fund_avgdlrs_Invalid;
    UNSIGNED1 ms_fund_lastdlrs_Invalid;
    UNSIGNED1 ms_fund_paystat_paid_Invalid;
    UNSIGNED1 ms_other_Invalid;
    UNSIGNED1 ms_continuity_Invalid;
    UNSIGNED1 ms_cont_status_active_Invalid;
    UNSIGNED1 ms_cont_status_cancel_Invalid;
    UNSIGNED1 ms_cont_omos_Invalid;
    UNSIGNED1 ms_cont_lmos_Invalid;
    UNSIGNED1 ms_cont_pmos_Invalid;
    UNSIGNED1 ms_cont_totords_Invalid;
    UNSIGNED1 ms_cont_totdlrs_Invalid;
    UNSIGNED1 ms_cont_avgdlrs_Invalid;
    UNSIGNED1 ms_cont_lastdlrs_Invalid;
    UNSIGNED1 ms_cont_paystat_paid_Invalid;
    UNSIGNED1 ms_cont_paymeth_cc_Invalid;
    UNSIGNED1 ms_cont_paymeth_cash_Invalid;
    UNSIGNED1 ms_totords_Invalid;
    UNSIGNED1 ms_totitems_Invalid;
    UNSIGNED1 ms_totdlrs_Invalid;
    UNSIGNED1 ms_avgdlrs_Invalid;
    UNSIGNED1 ms_lastdlrs_Invalid;
    UNSIGNED1 ms_paystat_paid_Invalid;
    UNSIGNED1 ms_paymeth_cc_Invalid;
    UNSIGNED1 ms_paymeth_cash_Invalid;
    UNSIGNED1 ms_osrc_dm_Invalid;
    UNSIGNED1 ms_lsrc_dm_Invalid;
    UNSIGNED1 ms_osrc_tm_Invalid;
    UNSIGNED1 ms_lsrc_tm_Invalid;
    UNSIGNED1 ms_osrc_ins_Invalid;
    UNSIGNED1 ms_lsrc_ins_Invalid;
    UNSIGNED1 ms_osrc_net_Invalid;
    UNSIGNED1 ms_lsrc_net_Invalid;
    UNSIGNED1 ms_osrc_tv_Invalid;
    UNSIGNED1 ms_lsrc_tv_Invalid;
    UNSIGNED1 ms_osrc_retail_Invalid;
    UNSIGNED1 ms_lsrc_retail_Invalid;
    UNSIGNED1 ms_giftgivr_Invalid;
    UNSIGNED1 ms_giftee_Invalid;
    UNSIGNED1 ms_adult_Invalid;
    UNSIGNED1 ms_womapp_Invalid;
    UNSIGNED1 ms_menapp_Invalid;
    UNSIGNED1 ms_kidapp_Invalid;
    UNSIGNED1 ms_accessory_Invalid;
    UNSIGNED1 ms_apparel_Invalid;
    UNSIGNED1 ms_app_lmos_Invalid;
    UNSIGNED1 ms_app_omos_Invalid;
    UNSIGNED1 ms_app_pmos_Invalid;
    UNSIGNED1 ms_app_totords_Invalid;
    UNSIGNED1 ms_app_totitems_Invalid;
    UNSIGNED1 ms_app_totdlrs_Invalid;
    UNSIGNED1 ms_app_avgdlrs_Invalid;
    UNSIGNED1 ms_app_lastdlrs_Invalid;
    UNSIGNED1 ms_app_paystat_paid_Invalid;
    UNSIGNED1 ms_app_paymeth_cc_Invalid;
    UNSIGNED1 ms_app_paymeth_cash_Invalid;
    UNSIGNED1 ms_menfash_Invalid;
    UNSIGNED1 ms_womfash_Invalid;
    UNSIGNED1 ms_wfsh_lmos_Invalid;
    UNSIGNED1 ms_wfsh_omos_Invalid;
    UNSIGNED1 ms_wfsh_pmos_Invalid;
    UNSIGNED1 ms_wfsh_totords_Invalid;
    UNSIGNED1 ms_wfsh_totdlrs_Invalid;
    UNSIGNED1 ms_wfsh_avgdlrs_Invalid;
    UNSIGNED1 ms_wfsh_lastdlrs_Invalid;
    UNSIGNED1 ms_wfsh_paystat_paid_Invalid;
    UNSIGNED1 ms_wfsh_osrc_dm_Invalid;
    UNSIGNED1 ms_wfsh_lsrc_dm_Invalid;
    UNSIGNED1 ms_wfsh_osrc_agt_Invalid;
    UNSIGNED1 ms_wfsh_lsrc_agt_Invalid;
    UNSIGNED1 ms_audio_Invalid;
    UNSIGNED1 ms_auto_Invalid;
    UNSIGNED1 ms_aviation_Invalid;
    UNSIGNED1 ms_bargains_Invalid;
    UNSIGNED1 ms_beauty_Invalid;
    UNSIGNED1 ms_bible_Invalid;
    UNSIGNED1 ms_bible_lmos_Invalid;
    UNSIGNED1 ms_bible_omos_Invalid;
    UNSIGNED1 ms_bible_pmos_Invalid;
    UNSIGNED1 ms_bible_totords_Invalid;
    UNSIGNED1 ms_bible_totitems_Invalid;
    UNSIGNED1 ms_bible_totdlrs_Invalid;
    UNSIGNED1 ms_bible_avgdlrs_Invalid;
    UNSIGNED1 ms_bible_lastdlrs_Invalid;
    UNSIGNED1 ms_bible_paystat_paid_Invalid;
    UNSIGNED1 ms_bible_paymeth_cc_Invalid;
    UNSIGNED1 ms_bible_paymeth_cash_Invalid;
    UNSIGNED1 ms_business_Invalid;
    UNSIGNED1 ms_collectibles_Invalid;
    UNSIGNED1 ms_computers_Invalid;
    UNSIGNED1 ms_crafts_Invalid;
    UNSIGNED1 ms_culturearts_Invalid;
    UNSIGNED1 ms_currevent_Invalid;
    UNSIGNED1 ms_diy_Invalid;
    UNSIGNED1 ms_electronics_Invalid;
    UNSIGNED1 ms_equestrian_Invalid;
    UNSIGNED1 ms_pub_family_Invalid;
    UNSIGNED1 ms_cat_family_Invalid;
    UNSIGNED1 ms_family_Invalid;
    UNSIGNED1 ms_family_lmos_Invalid;
    UNSIGNED1 ms_family_omos_Invalid;
    UNSIGNED1 ms_family_pmos_Invalid;
    UNSIGNED1 ms_family_totords_Invalid;
    UNSIGNED1 ms_family_totitems_Invalid;
    UNSIGNED1 ms_family_totdlrs_Invalid;
    UNSIGNED1 ms_family_avgdlrs_Invalid;
    UNSIGNED1 ms_family_lastdlrs_Invalid;
    UNSIGNED1 ms_family_paystat_paid_Invalid;
    UNSIGNED1 ms_family_paymeth_cc_Invalid;
    UNSIGNED1 ms_family_paymeth_cash_Invalid;
    UNSIGNED1 ms_family_osrc_dm_Invalid;
    UNSIGNED1 ms_family_lsrc_dm_Invalid;
    UNSIGNED1 ms_fiction_Invalid;
    UNSIGNED1 ms_food_Invalid;
    UNSIGNED1 ms_games_Invalid;
    UNSIGNED1 ms_gifts_Invalid;
    UNSIGNED1 ms_gourmet_Invalid;
    UNSIGNED1 ms_fitness_Invalid;
    UNSIGNED1 ms_health_Invalid;
    UNSIGNED1 ms_hlth_lmos_Invalid;
    UNSIGNED1 ms_hlth_omos_Invalid;
    UNSIGNED1 ms_hlth_pmos_Invalid;
    UNSIGNED1 ms_hlth_totords_Invalid;
    UNSIGNED1 ms_hlth_totdlrs_Invalid;
    UNSIGNED1 ms_hlth_avgdlrs_Invalid;
    UNSIGNED1 ms_hlth_lastdlrs_Invalid;
    UNSIGNED1 ms_hlth_paystat_paid_Invalid;
    UNSIGNED1 ms_hlth_paymeth_cc_Invalid;
    UNSIGNED1 ms_hlth_osrc_dm_Invalid;
    UNSIGNED1 ms_hlth_lsrc_dm_Invalid;
    UNSIGNED1 ms_hlth_osrc_agt_Invalid;
    UNSIGNED1 ms_hlth_lsrc_agt_Invalid;
    UNSIGNED1 ms_hlth_osrc_tv_Invalid;
    UNSIGNED1 ms_hlth_lsrc_tv_Invalid;
    UNSIGNED1 ms_holiday_Invalid;
    UNSIGNED1 ms_history_Invalid;
    UNSIGNED1 ms_pub_cooking_Invalid;
    UNSIGNED1 ms_cooking_Invalid;
    UNSIGNED1 ms_pub_homedecr_Invalid;
    UNSIGNED1 ms_cat_homedecr_Invalid;
    UNSIGNED1 ms_homedecr_Invalid;
    UNSIGNED1 ms_housewares_Invalid;
    UNSIGNED1 ms_pub_garden_Invalid;
    UNSIGNED1 ms_cat_garden_Invalid;
    UNSIGNED1 ms_garden_Invalid;
    UNSIGNED1 ms_pub_homeliv_Invalid;
    UNSIGNED1 ms_cat_homeliv_Invalid;
    UNSIGNED1 ms_homeliv_Invalid;
    UNSIGNED1 ms_pub_home_status_active_Invalid;
    UNSIGNED1 ms_home_lmos_Invalid;
    UNSIGNED1 ms_home_omos_Invalid;
    UNSIGNED1 ms_home_pmos_Invalid;
    UNSIGNED1 ms_home_totords_Invalid;
    UNSIGNED1 ms_home_totitems_Invalid;
    UNSIGNED1 ms_home_totdlrs_Invalid;
    UNSIGNED1 ms_home_avgdlrs_Invalid;
    UNSIGNED1 ms_home_lastdlrs_Invalid;
    UNSIGNED1 ms_home_paystat_paid_Invalid;
    UNSIGNED1 ms_home_paymeth_cc_Invalid;
    UNSIGNED1 ms_home_paymeth_cash_Invalid;
    UNSIGNED1 ms_home_osrc_dm_Invalid;
    UNSIGNED1 ms_home_lsrc_dm_Invalid;
    UNSIGNED1 ms_home_osrc_agt_Invalid;
    UNSIGNED1 ms_home_lsrc_agt_Invalid;
    UNSIGNED1 ms_home_osrc_net_Invalid;
    UNSIGNED1 ms_home_lsrc_net_Invalid;
    UNSIGNED1 ms_home_osrc_tv_Invalid;
    UNSIGNED1 ms_home_lsrc_tv_Invalid;
    UNSIGNED1 ms_humor_Invalid;
    UNSIGNED1 ms_inspiration_Invalid;
    UNSIGNED1 ms_merchandise_Invalid;
    UNSIGNED1 ms_moneymaking_Invalid;
    UNSIGNED1 ms_moneymaking_lmos_Invalid;
    UNSIGNED1 ms_motorcycles_Invalid;
    UNSIGNED1 ms_music_Invalid;
    UNSIGNED1 ms_fishing_Invalid;
    UNSIGNED1 ms_hunting_Invalid;
    UNSIGNED1 ms_boatsail_Invalid;
    UNSIGNED1 ms_camp_Invalid;
    UNSIGNED1 ms_pub_outdoors_Invalid;
    UNSIGNED1 ms_cat_outdoors_Invalid;
    UNSIGNED1 ms_outdoors_Invalid;
    UNSIGNED1 ms_pub_out_status_active_Invalid;
    UNSIGNED1 ms_out_lmos_Invalid;
    UNSIGNED1 ms_out_omos_Invalid;
    UNSIGNED1 ms_out_pmos_Invalid;
    UNSIGNED1 ms_out_totords_Invalid;
    UNSIGNED1 ms_out_totitems_Invalid;
    UNSIGNED1 ms_out_totdlrs_Invalid;
    UNSIGNED1 ms_out_avgdlrs_Invalid;
    UNSIGNED1 ms_out_lastdlrs_Invalid;
    UNSIGNED1 ms_out_paystat_paid_Invalid;
    UNSIGNED1 ms_out_paymeth_cc_Invalid;
    UNSIGNED1 ms_out_paymeth_cash_Invalid;
    UNSIGNED1 ms_out_osrc_dm_Invalid;
    UNSIGNED1 ms_out_lsrc_dm_Invalid;
    UNSIGNED1 ms_out_osrc_agt_Invalid;
    UNSIGNED1 ms_out_lsrc_agt_Invalid;
    UNSIGNED1 ms_pets_Invalid;
    UNSIGNED1 ms_pfin_Invalid;
    UNSIGNED1 ms_photo_Invalid;
    UNSIGNED1 ms_photoproc_Invalid;
    UNSIGNED1 ms_rural_Invalid;
    UNSIGNED1 ms_science_Invalid;
    UNSIGNED1 ms_sports_Invalid;
    UNSIGNED1 ms_sports_lmos_Invalid;
    UNSIGNED1 ms_travel_Invalid;
    UNSIGNED1 ms_tvmovies_Invalid;
    UNSIGNED1 ms_wildlife_Invalid;
    UNSIGNED1 ms_woman_Invalid;
    UNSIGNED1 ms_woman_lmos_Invalid;
    UNSIGNED1 ms_ringtones_apps_Invalid;
    UNSIGNED1 cpi_mobile_apps_index_Invalid;
    UNSIGNED1 cpi_credit_repair_index_Invalid;
    UNSIGNED1 cpi_credit_report_index_Invalid;
    UNSIGNED1 cpi_education_seekers_index_Invalid;
    UNSIGNED1 cpi_insurance_index_Invalid;
    UNSIGNED1 cpi_insurance_health_index_Invalid;
    UNSIGNED1 cpi_insurance_auto_index_Invalid;
    UNSIGNED1 cpi_job_seekers_index_Invalid;
    UNSIGNED1 cpi_social_networking_index_Invalid;
    UNSIGNED1 cpi_adult_index_Invalid;
    UNSIGNED1 cpi_africanamerican_index_Invalid;
    UNSIGNED1 cpi_apparel_index_Invalid;
    UNSIGNED1 cpi_apparel_accessory_index_Invalid;
    UNSIGNED1 cpi_apparel_kids_index_Invalid;
    UNSIGNED1 cpi_apparel_men_index_Invalid;
    UNSIGNED1 cpi_apparel_menfash_index_Invalid;
    UNSIGNED1 cpi_apparel_women_index_Invalid;
    UNSIGNED1 cpi_apparel_womfash_index_Invalid;
    UNSIGNED1 cpi_asian_index_Invalid;
    UNSIGNED1 cpi_auto_index_Invalid;
    UNSIGNED1 cpi_auto_racing_index_Invalid;
    UNSIGNED1 cpi_auto_trucks_index_Invalid;
    UNSIGNED1 cpi_aviation_index_Invalid;
    UNSIGNED1 cpi_bargains_index_Invalid;
    UNSIGNED1 cpi_beauty_index_Invalid;
    UNSIGNED1 cpi_bible_index_Invalid;
    UNSIGNED1 cpi_birds_index_Invalid;
    UNSIGNED1 cpi_business_index_Invalid;
    UNSIGNED1 cpi_business_homeoffice_index_Invalid;
    UNSIGNED1 cpi_catalog_index_Invalid;
    UNSIGNED1 cpi_cc_index_Invalid;
    UNSIGNED1 cpi_collectibles_index_Invalid;
    UNSIGNED1 cpi_college_index_Invalid;
    UNSIGNED1 cpi_computers_index_Invalid;
    UNSIGNED1 cpi_conservative_index_Invalid;
    UNSIGNED1 cpi_continuity_index_Invalid;
    UNSIGNED1 cpi_cooking_index_Invalid;
    UNSIGNED1 cpi_crafts_index_Invalid;
    UNSIGNED1 cpi_crafts_crochet_index_Invalid;
    UNSIGNED1 cpi_crafts_knit_index_Invalid;
    UNSIGNED1 cpi_crafts_needlepoint_index_Invalid;
    UNSIGNED1 cpi_crafts_quilt_index_Invalid;
    UNSIGNED1 cpi_crafts_sew_index_Invalid;
    UNSIGNED1 cpi_culturearts_index_Invalid;
    UNSIGNED1 cpi_currevent_index_Invalid;
    UNSIGNED1 cpi_diy_index_Invalid;
    UNSIGNED1 cpi_donor_index_Invalid;
    UNSIGNED1 cpi_ego_index_Invalid;
    UNSIGNED1 cpi_electronics_index_Invalid;
    UNSIGNED1 cpi_equestrian_index_Invalid;
    UNSIGNED1 cpi_family_index_Invalid;
    UNSIGNED1 cpi_family_teen_index_Invalid;
    UNSIGNED1 cpi_family_young_index_Invalid;
    UNSIGNED1 cpi_fiction_index_Invalid;
    UNSIGNED1 cpi_gambling_index_Invalid;
    UNSIGNED1 cpi_games_index_Invalid;
    UNSIGNED1 cpi_gardening_index_Invalid;
    UNSIGNED1 cpi_gay_index_Invalid;
    UNSIGNED1 cpi_giftgivr_index_Invalid;
    UNSIGNED1 cpi_gourmet_index_Invalid;
    UNSIGNED1 cpi_grandparents_index_Invalid;
    UNSIGNED1 cpi_health_index_Invalid;
    UNSIGNED1 cpi_health_diet_index_Invalid;
    UNSIGNED1 cpi_health_fitness_index_Invalid;
    UNSIGNED1 cpi_hightech_index_Invalid;
    UNSIGNED1 cpi_hispanic_index_Invalid;
    UNSIGNED1 cpi_history_index_Invalid;
    UNSIGNED1 cpi_history_american_index_Invalid;
    UNSIGNED1 cpi_hobbies_index_Invalid;
    UNSIGNED1 cpi_homedecr_index_Invalid;
    UNSIGNED1 cpi_homeliv_index_Invalid;
    UNSIGNED1 cpi_humor_index_Invalid;
    UNSIGNED1 cpi_inspiration_index_Invalid;
    UNSIGNED1 cpi_internet_index_Invalid;
    UNSIGNED1 cpi_internet_access_index_Invalid;
    UNSIGNED1 cpi_internet_buy_index_Invalid;
    UNSIGNED1 cpi_liberal_index_Invalid;
    UNSIGNED1 cpi_moneymaking_index_Invalid;
    UNSIGNED1 cpi_motorcycles_index_Invalid;
    UNSIGNED1 cpi_music_index_Invalid;
    UNSIGNED1 cpi_nonfiction_index_Invalid;
    UNSIGNED1 cpi_ocean_index_Invalid;
    UNSIGNED1 cpi_outdoors_index_Invalid;
    UNSIGNED1 cpi_outdoors_boatsail_index_Invalid;
    UNSIGNED1 cpi_outdoors_camp_index_Invalid;
    UNSIGNED1 cpi_outdoors_fishing_index_Invalid;
    UNSIGNED1 cpi_outdoors_huntfish_index_Invalid;
    UNSIGNED1 cpi_outdoors_hunting_index_Invalid;
    UNSIGNED1 cpi_pets_index_Invalid;
    UNSIGNED1 cpi_pets_cats_index_Invalid;
    UNSIGNED1 cpi_pets_dogs_index_Invalid;
    UNSIGNED1 cpi_pfin_index_Invalid;
    UNSIGNED1 cpi_photog_index_Invalid;
    UNSIGNED1 cpi_photoproc_index_Invalid;
    UNSIGNED1 cpi_publish_index_Invalid;
    UNSIGNED1 cpi_publish_books_index_Invalid;
    UNSIGNED1 cpi_publish_mags_index_Invalid;
    UNSIGNED1 cpi_rural_index_Invalid;
    UNSIGNED1 cpi_science_index_Invalid;
    UNSIGNED1 cpi_scifi_index_Invalid;
    UNSIGNED1 cpi_seniors_index_Invalid;
    UNSIGNED1 cpi_sports_index_Invalid;
    UNSIGNED1 cpi_sports_baseball_index_Invalid;
    UNSIGNED1 cpi_sports_basketball_index_Invalid;
    UNSIGNED1 cpi_sports_biking_index_Invalid;
    UNSIGNED1 cpi_sports_football_index_Invalid;
    UNSIGNED1 cpi_sports_golf_index_Invalid;
    UNSIGNED1 cpi_sports_hockey_index_Invalid;
    UNSIGNED1 cpi_sports_running_index_Invalid;
    UNSIGNED1 cpi_sports_ski_index_Invalid;
    UNSIGNED1 cpi_sports_soccer_index_Invalid;
    UNSIGNED1 cpi_sports_swimming_index_Invalid;
    UNSIGNED1 cpi_sports_tennis_index_Invalid;
    UNSIGNED1 cpi_stationery_index_Invalid;
    UNSIGNED1 cpi_sweeps_index_Invalid;
    UNSIGNED1 cpi_tobacco_index_Invalid;
    UNSIGNED1 cpi_travel_index_Invalid;
    UNSIGNED1 cpi_travel_cruise_index_Invalid;
    UNSIGNED1 cpi_travel_rv_index_Invalid;
    UNSIGNED1 cpi_travel_us_index_Invalid;
    UNSIGNED1 cpi_tvmovies_index_Invalid;
    UNSIGNED1 cpi_wildlife_index_Invalid;
    UNSIGNED1 cpi_woman_index_Invalid;
    UNSIGNED1 totdlr_index_Invalid;
    UNSIGNED1 cpi_totdlr_Invalid;
    UNSIGNED1 cpi_totords_Invalid;
    UNSIGNED1 cpi_lastdlr_Invalid;
    UNSIGNED1 pkcatg_Invalid;
    UNSIGNED1 pkpubs_Invalid;
    UNSIGNED1 pkcont_Invalid;
    UNSIGNED1 pkca01_Invalid;
    UNSIGNED1 pkca03_Invalid;
    UNSIGNED1 pkca04_Invalid;
    UNSIGNED1 pkca05_Invalid;
    UNSIGNED1 pkca06_Invalid;
    UNSIGNED1 pkca07_Invalid;
    UNSIGNED1 pkca08_Invalid;
    UNSIGNED1 pkca09_Invalid;
    UNSIGNED1 pkca10_Invalid;
    UNSIGNED1 pkca11_Invalid;
    UNSIGNED1 pkca12_Invalid;
    UNSIGNED1 pkca13_Invalid;
    UNSIGNED1 pkca14_Invalid;
    UNSIGNED1 pkca15_Invalid;
    UNSIGNED1 pkca16_Invalid;
    UNSIGNED1 pkca17_Invalid;
    UNSIGNED1 pkca18_Invalid;
    UNSIGNED1 pkca20_Invalid;
    UNSIGNED1 pkca21_Invalid;
    UNSIGNED1 pkca22_Invalid;
    UNSIGNED1 pkca23_Invalid;
    UNSIGNED1 pkca24_Invalid;
    UNSIGNED1 pkca25_Invalid;
    UNSIGNED1 pkca26_Invalid;
    UNSIGNED1 pkca28_Invalid;
    UNSIGNED1 pkca29_Invalid;
    UNSIGNED1 pkca30_Invalid;
    UNSIGNED1 pkca31_Invalid;
    UNSIGNED1 pkca32_Invalid;
    UNSIGNED1 pkca33_Invalid;
    UNSIGNED1 pkca34_Invalid;
    UNSIGNED1 pkca35_Invalid;
    UNSIGNED1 pkca36_Invalid;
    UNSIGNED1 pkca37_Invalid;
    UNSIGNED1 pkca39_Invalid;
    UNSIGNED1 pkca40_Invalid;
    UNSIGNED1 pkca41_Invalid;
    UNSIGNED1 pkca42_Invalid;
    UNSIGNED1 pkca54_Invalid;
    UNSIGNED1 pkca61_Invalid;
    UNSIGNED1 pkca62_Invalid;
    UNSIGNED1 pkca64_Invalid;
    UNSIGNED1 pkpu01_Invalid;
    UNSIGNED1 pkpu02_Invalid;
    UNSIGNED1 pkpu03_Invalid;
    UNSIGNED1 pkpu04_Invalid;
    UNSIGNED1 pkpu05_Invalid;
    UNSIGNED1 pkpu06_Invalid;
    UNSIGNED1 pkpu07_Invalid;
    UNSIGNED1 pkpu08_Invalid;
    UNSIGNED1 pkpu09_Invalid;
    UNSIGNED1 pkpu10_Invalid;
    UNSIGNED1 pkpu11_Invalid;
    UNSIGNED1 pkpu12_Invalid;
    UNSIGNED1 pkpu13_Invalid;
    UNSIGNED1 pkpu14_Invalid;
    UNSIGNED1 pkpu15_Invalid;
    UNSIGNED1 pkpu16_Invalid;
    UNSIGNED1 pkpu17_Invalid;
    UNSIGNED1 pkpu18_Invalid;
    UNSIGNED1 pkpu19_Invalid;
    UNSIGNED1 pkpu20_Invalid;
    UNSIGNED1 pkpu23_Invalid;
    UNSIGNED1 pkpu25_Invalid;
    UNSIGNED1 pkpu27_Invalid;
    UNSIGNED1 pkpu28_Invalid;
    UNSIGNED1 pkpu29_Invalid;
    UNSIGNED1 pkpu30_Invalid;
    UNSIGNED1 pkpu31_Invalid;
    UNSIGNED1 pkpu32_Invalid;
    UNSIGNED1 pkpu33_Invalid;
    UNSIGNED1 pkpu34_Invalid;
    UNSIGNED1 pkpu35_Invalid;
    UNSIGNED1 pkpu38_Invalid;
    UNSIGNED1 pkpu41_Invalid;
    UNSIGNED1 pkpu42_Invalid;
    UNSIGNED1 pkpu45_Invalid;
    UNSIGNED1 pkpu46_Invalid;
    UNSIGNED1 pkpu47_Invalid;
    UNSIGNED1 pkpu48_Invalid;
    UNSIGNED1 pkpu49_Invalid;
    UNSIGNED1 pkpu50_Invalid;
    UNSIGNED1 pkpu51_Invalid;
    UNSIGNED1 pkpu52_Invalid;
    UNSIGNED1 pkpu53_Invalid;
    UNSIGNED1 pkpu54_Invalid;
    UNSIGNED1 pkpu55_Invalid;
    UNSIGNED1 pkpu56_Invalid;
    UNSIGNED1 pkpu57_Invalid;
    UNSIGNED1 pkpu60_Invalid;
    UNSIGNED1 pkpu61_Invalid;
    UNSIGNED1 pkpu62_Invalid;
    UNSIGNED1 pkpu63_Invalid;
    UNSIGNED1 pkpu64_Invalid;
    UNSIGNED1 pkpu65_Invalid;
    UNSIGNED1 pkpu66_Invalid;
    UNSIGNED1 pkpu67_Invalid;
    UNSIGNED1 pkpu68_Invalid;
    UNSIGNED1 pkpu69_Invalid;
    UNSIGNED1 pkpu70_Invalid;
    UNSIGNED1 censpct_water_Invalid;
    UNSIGNED1 cens_pop_density_Invalid;
    UNSIGNED1 cens_hu_density_Invalid;
    UNSIGNED1 censpct_pop_white_Invalid;
    UNSIGNED1 censpct_pop_black_Invalid;
    UNSIGNED1 censpct_pop_amerind_Invalid;
    UNSIGNED1 censpct_pop_asian_Invalid;
    UNSIGNED1 censpct_pop_pacisl_Invalid;
    UNSIGNED1 censpct_pop_othrace_Invalid;
    UNSIGNED1 censpct_pop_multirace_Invalid;
    UNSIGNED1 censpct_pop_hispanic_Invalid;
    UNSIGNED1 censpct_pop_agelt18_Invalid;
    UNSIGNED1 censpct_pop_males_Invalid;
    UNSIGNED1 censpct_adult_age1824_Invalid;
    UNSIGNED1 censpct_adult_age2534_Invalid;
    UNSIGNED1 censpct_adult_age3544_Invalid;
    UNSIGNED1 censpct_adult_age4554_Invalid;
    UNSIGNED1 censpct_adult_age5564_Invalid;
    UNSIGNED1 censpct_adult_agege65_Invalid;
    UNSIGNED1 cens_pop_medage_Invalid;
    UNSIGNED1 cens_hh_avgsize_Invalid;
    UNSIGNED1 censpct_hh_family_Invalid;
    UNSIGNED1 censpct_hh_family_husbwife_Invalid;
    UNSIGNED1 censpct_hu_occupied_Invalid;
    UNSIGNED1 censpct_hu_owned_Invalid;
    UNSIGNED1 censpct_hu_rented_Invalid;
    UNSIGNED1 censpct_hu_vacantseasonal_Invalid;
    UNSIGNED1 zip_medinc_Invalid;
    UNSIGNED1 zip_apparel_Invalid;
    UNSIGNED1 zip_apparel_women_Invalid;
    UNSIGNED1 zip_apparel_womfash_Invalid;
    UNSIGNED1 zip_auto_Invalid;
    UNSIGNED1 zip_beauty_Invalid;
    UNSIGNED1 zip_booksmusicmovies_Invalid;
    UNSIGNED1 zip_business_Invalid;
    UNSIGNED1 zip_catalog_Invalid;
    UNSIGNED1 zip_cc_Invalid;
    UNSIGNED1 zip_collectibles_Invalid;
    UNSIGNED1 zip_computers_Invalid;
    UNSIGNED1 zip_continuity_Invalid;
    UNSIGNED1 zip_cooking_Invalid;
    UNSIGNED1 zip_crafts_Invalid;
    UNSIGNED1 zip_culturearts_Invalid;
    UNSIGNED1 zip_dm_sold_Invalid;
    UNSIGNED1 zip_donor_Invalid;
    UNSIGNED1 zip_family_Invalid;
    UNSIGNED1 zip_gardening_Invalid;
    UNSIGNED1 zip_giftgivr_Invalid;
    UNSIGNED1 zip_gourmet_Invalid;
    UNSIGNED1 zip_health_Invalid;
    UNSIGNED1 zip_health_diet_Invalid;
    UNSIGNED1 zip_health_fitness_Invalid;
    UNSIGNED1 zip_hobbies_Invalid;
    UNSIGNED1 zip_homedecr_Invalid;
    UNSIGNED1 zip_homeliv_Invalid;
    UNSIGNED1 zip_internet_Invalid;
    UNSIGNED1 zip_internet_access_Invalid;
    UNSIGNED1 zip_internet_buy_Invalid;
    UNSIGNED1 zip_music_Invalid;
    UNSIGNED1 zip_outdoors_Invalid;
    UNSIGNED1 zip_pets_Invalid;
    UNSIGNED1 zip_pfin_Invalid;
    UNSIGNED1 zip_publish_Invalid;
    UNSIGNED1 zip_publish_books_Invalid;
    UNSIGNED1 zip_publish_mags_Invalid;
    UNSIGNED1 zip_sports_Invalid;
    UNSIGNED1 zip_sports_biking_Invalid;
    UNSIGNED1 zip_sports_golf_Invalid;
    UNSIGNED1 zip_travel_Invalid;
    UNSIGNED1 zip_travel_us_Invalid;
    UNSIGNED1 zip_tvmovies_Invalid;
    UNSIGNED1 zip_woman_Invalid;
    UNSIGNED1 zip_proftech_Invalid;
    UNSIGNED1 zip_retired_Invalid;
    UNSIGNED1 zip_inc100_Invalid;
    UNSIGNED1 zip_inc75_Invalid;
    UNSIGNED1 zip_inc50_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_Dunndata_Consumer)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
    UNSIGNED8 ScrubsBits3;
    UNSIGNED8 ScrubsBits4;
    UNSIGNED8 ScrubsBits5;
    UNSIGNED8 ScrubsBits6;
    UNSIGNED8 ScrubsBits7;
    UNSIGNED8 ScrubsBits8;
    UNSIGNED8 ScrubsBits9;
    UNSIGNED8 ScrubsBits10;
    UNSIGNED8 ScrubsBits11;
    UNSIGNED8 ScrubsCleanBits1;
  END;
EXPORT FromNone(DATASET(Layout_Dunndata_Consumer) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.dtmatch_Invalid := Fields.InValid_dtmatch((SALT311.StrType)le.dtmatch);
    clean_dtmatch := (TYPEOF(le.dtmatch))Fields.Make_dtmatch((SALT311.StrType)le.dtmatch);
    clean_dtmatch_Invalid := Fields.InValid_dtmatch((SALT311.StrType)clean_dtmatch);
    SELF.dtmatch := IF(withOnfail, clean_dtmatch, le.dtmatch); // ONFAIL(CLEAN)
    SELF.dtmatch_wouldClean := TRIM((SALT311.StrType)le.dtmatch) <> TRIM((SALT311.StrType)clean_dtmatch);
    SELF.msname_Invalid := Fields.InValid_msname((SALT311.StrType)le.msname);
    clean_msname := (TYPEOF(le.msname))Fields.Make_msname((SALT311.StrType)le.msname);
    clean_msname_Invalid := Fields.InValid_msname((SALT311.StrType)clean_msname);
    SELF.msname := IF(withOnfail, clean_msname, le.msname); // ONFAIL(CLEAN)
    SELF.msname_wouldClean := TRIM((SALT311.StrType)le.msname) <> TRIM((SALT311.StrType)clean_msname);
    SELF.msaddr1_Invalid := Fields.InValid_msaddr1((SALT311.StrType)le.msaddr1);
    clean_msaddr1 := (TYPEOF(le.msaddr1))Fields.Make_msaddr1((SALT311.StrType)le.msaddr1);
    clean_msaddr1_Invalid := Fields.InValid_msaddr1((SALT311.StrType)clean_msaddr1);
    SELF.msaddr1 := IF(withOnfail, clean_msaddr1, le.msaddr1); // ONFAIL(CLEAN)
    SELF.msaddr1_wouldClean := TRIM((SALT311.StrType)le.msaddr1) <> TRIM((SALT311.StrType)clean_msaddr1);
    SELF.msaddr2_Invalid := Fields.InValid_msaddr2((SALT311.StrType)le.msaddr2);
    clean_msaddr2 := (TYPEOF(le.msaddr2))Fields.Make_msaddr2((SALT311.StrType)le.msaddr2);
    clean_msaddr2_Invalid := Fields.InValid_msaddr2((SALT311.StrType)clean_msaddr2);
    SELF.msaddr2 := IF(withOnfail, clean_msaddr2, le.msaddr2); // ONFAIL(CLEAN)
    SELF.msaddr2_wouldClean := TRIM((SALT311.StrType)le.msaddr2) <> TRIM((SALT311.StrType)clean_msaddr2);
    SELF.mscity_Invalid := Fields.InValid_mscity((SALT311.StrType)le.mscity);
    clean_mscity := (TYPEOF(le.mscity))Fields.Make_mscity((SALT311.StrType)le.mscity);
    clean_mscity_Invalid := Fields.InValid_mscity((SALT311.StrType)clean_mscity);
    SELF.mscity := IF(withOnfail, clean_mscity, le.mscity); // ONFAIL(CLEAN)
    SELF.mscity_wouldClean := TRIM((SALT311.StrType)le.mscity) <> TRIM((SALT311.StrType)clean_mscity);
    SELF.msstate_Invalid := Fields.InValid_msstate((SALT311.StrType)le.msstate);
    clean_msstate := (TYPEOF(le.msstate))Fields.Make_msstate((SALT311.StrType)le.msstate);
    clean_msstate_Invalid := Fields.InValid_msstate((SALT311.StrType)clean_msstate);
    SELF.msstate := IF(withOnfail, clean_msstate, le.msstate); // ONFAIL(CLEAN)
    SELF.msstate_wouldClean := TRIM((SALT311.StrType)le.msstate) <> TRIM((SALT311.StrType)clean_msstate);
    SELF.mszip5_Invalid := Fields.InValid_mszip5((SALT311.StrType)le.mszip5);
    clean_mszip5 := (TYPEOF(le.mszip5))Fields.Make_mszip5((SALT311.StrType)le.mszip5);
    clean_mszip5_Invalid := Fields.InValid_mszip5((SALT311.StrType)clean_mszip5);
    SELF.mszip5 := IF(withOnfail, clean_mszip5, le.mszip5); // ONFAIL(CLEAN)
    SELF.mszip5_wouldClean := TRIM((SALT311.StrType)le.mszip5) <> TRIM((SALT311.StrType)clean_mszip5);
    SELF.mszip4_Invalid := Fields.InValid_mszip4((SALT311.StrType)le.mszip4);
    clean_mszip4 := (TYPEOF(le.mszip4))Fields.Make_mszip4((SALT311.StrType)le.mszip4);
    clean_mszip4_Invalid := Fields.InValid_mszip4((SALT311.StrType)clean_mszip4);
    SELF.mszip4 := IF(withOnfail, clean_mszip4, le.mszip4); // ONFAIL(CLEAN)
    SELF.mszip4_wouldClean := TRIM((SALT311.StrType)le.mszip4) <> TRIM((SALT311.StrType)clean_mszip4);
    SELF.dthh_Invalid := Fields.InValid_dthh((SALT311.StrType)le.dthh);
    clean_dthh := (TYPEOF(le.dthh))Fields.Make_dthh((SALT311.StrType)le.dthh);
    clean_dthh_Invalid := Fields.InValid_dthh((SALT311.StrType)clean_dthh);
    SELF.dthh := IF(withOnfail, clean_dthh, le.dthh); // ONFAIL(CLEAN)
    SELF.dthh_wouldClean := TRIM((SALT311.StrType)le.dthh) <> TRIM((SALT311.StrType)clean_dthh);
    SELF.mscrrt_Invalid := Fields.InValid_mscrrt((SALT311.StrType)le.mscrrt);
    clean_mscrrt := (TYPEOF(le.mscrrt))Fields.Make_mscrrt((SALT311.StrType)le.mscrrt);
    clean_mscrrt_Invalid := Fields.InValid_mscrrt((SALT311.StrType)clean_mscrrt);
    SELF.mscrrt := IF(withOnfail, clean_mscrrt, le.mscrrt); // ONFAIL(CLEAN)
    SELF.mscrrt_wouldClean := TRIM((SALT311.StrType)le.mscrrt) <> TRIM((SALT311.StrType)clean_mscrrt);
    SELF.msdpbc_Invalid := Fields.InValid_msdpbc((SALT311.StrType)le.msdpbc);
    clean_msdpbc := (TYPEOF(le.msdpbc))Fields.Make_msdpbc((SALT311.StrType)le.msdpbc);
    clean_msdpbc_Invalid := Fields.InValid_msdpbc((SALT311.StrType)clean_msdpbc);
    SELF.msdpbc := IF(withOnfail, clean_msdpbc, le.msdpbc); // ONFAIL(CLEAN)
    SELF.msdpbc_wouldClean := TRIM((SALT311.StrType)le.msdpbc) <> TRIM((SALT311.StrType)clean_msdpbc);
    SELF.msdpv_Invalid := Fields.InValid_msdpv((SALT311.StrType)le.msdpv);
    clean_msdpv := (TYPEOF(le.msdpv))Fields.Make_msdpv((SALT311.StrType)le.msdpv);
    clean_msdpv_Invalid := Fields.InValid_msdpv((SALT311.StrType)clean_msdpv);
    SELF.msdpv := IF(withOnfail, clean_msdpv, le.msdpv); // ONFAIL(CLEAN)
    SELF.msdpv_wouldClean := TRIM((SALT311.StrType)le.msdpv) <> TRIM((SALT311.StrType)clean_msdpv);
    SELF.ms_addrtype_Invalid := Fields.InValid_ms_addrtype((SALT311.StrType)le.ms_addrtype);
    clean_ms_addrtype := (TYPEOF(le.ms_addrtype))Fields.Make_ms_addrtype((SALT311.StrType)le.ms_addrtype);
    clean_ms_addrtype_Invalid := Fields.InValid_ms_addrtype((SALT311.StrType)clean_ms_addrtype);
    SELF.ms_addrtype := IF(withOnfail, clean_ms_addrtype, le.ms_addrtype); // ONFAIL(CLEAN)
    SELF.ms_addrtype_wouldClean := TRIM((SALT311.StrType)le.ms_addrtype) <> TRIM((SALT311.StrType)clean_ms_addrtype);
    SELF.ctysize_Invalid := Fields.InValid_ctysize((SALT311.StrType)le.ctysize);
    clean_ctysize := (TYPEOF(le.ctysize))Fields.Make_ctysize((SALT311.StrType)le.ctysize);
    clean_ctysize_Invalid := Fields.InValid_ctysize((SALT311.StrType)clean_ctysize);
    SELF.ctysize := IF(withOnfail, clean_ctysize, le.ctysize); // ONFAIL(CLEAN)
    SELF.ctysize_wouldClean := TRIM((SALT311.StrType)le.ctysize) <> TRIM((SALT311.StrType)clean_ctysize);
    SELF.lmos_Invalid := Fields.InValid_lmos((SALT311.StrType)le.lmos);
    SELF.omos_Invalid := Fields.InValid_omos((SALT311.StrType)le.omos);
    SELF.pmos_Invalid := Fields.InValid_pmos((SALT311.StrType)le.pmos);
    SELF.gen_Invalid := Fields.InValid_gen((SALT311.StrType)le.gen);
    clean_gen := (TYPEOF(le.gen))Fields.Make_gen((SALT311.StrType)le.gen);
    clean_gen_Invalid := Fields.InValid_gen((SALT311.StrType)clean_gen);
    SELF.gen := IF(withOnfail, clean_gen, le.gen); // ONFAIL(CLEAN)
    SELF.dob_Invalid := Fields.InValid_dob((SALT311.StrType)le.dob);
    SELF.age_Invalid := Fields.InValid_age((SALT311.StrType)le.age);
    SELF.inc_Invalid := Fields.InValid_inc((SALT311.StrType)le.inc);
    clean_inc := (TYPEOF(le.inc))Fields.Make_inc((SALT311.StrType)le.inc);
    clean_inc_Invalid := Fields.InValid_inc((SALT311.StrType)clean_inc);
    SELF.inc := IF(withOnfail, clean_inc, le.inc); // ONFAIL(CLEAN)
    SELF.marital_status_Invalid := Fields.InValid_marital_status((SALT311.StrType)le.marital_status);
    SELF.poc_Invalid := Fields.InValid_poc((SALT311.StrType)le.poc);
    SELF.noc_Invalid := Fields.InValid_noc((SALT311.StrType)le.noc);
    clean_noc := (TYPEOF(le.noc))Fields.Make_noc((SALT311.StrType)le.noc);
    clean_noc_Invalid := Fields.InValid_noc((SALT311.StrType)clean_noc);
    SELF.noc := IF(withOnfail, clean_noc, le.noc); // ONFAIL(CLEAN)
    SELF.noc_wouldClean := TRIM((SALT311.StrType)le.noc) <> TRIM((SALT311.StrType)clean_noc);
    SELF.ocp_Invalid := Fields.InValid_ocp((SALT311.StrType)le.ocp);
    clean_ocp := (TYPEOF(le.ocp))Fields.Make_ocp((SALT311.StrType)le.ocp);
    clean_ocp_Invalid := Fields.InValid_ocp((SALT311.StrType)clean_ocp);
    SELF.ocp := IF(withOnfail, clean_ocp, le.ocp); // ONFAIL(CLEAN)
    SELF.edu_Invalid := Fields.InValid_edu((SALT311.StrType)le.edu);
    clean_edu := (TYPEOF(le.edu))Fields.Make_edu((SALT311.StrType)le.edu);
    clean_edu_Invalid := Fields.InValid_edu((SALT311.StrType)clean_edu);
    SELF.edu := IF(withOnfail, clean_edu, le.edu); // ONFAIL(CLEAN)
    SELF.lang_Invalid := Fields.InValid_lang((SALT311.StrType)le.lang);
    clean_lang := (TYPEOF(le.lang))Fields.Make_lang((SALT311.StrType)le.lang);
    clean_lang_Invalid := Fields.InValid_lang((SALT311.StrType)clean_lang);
    SELF.lang := IF(withOnfail, clean_lang, le.lang); // ONFAIL(CLEAN)
    SELF.lang_wouldClean := TRIM((SALT311.StrType)le.lang) <> TRIM((SALT311.StrType)clean_lang);
    SELF.relig_Invalid := Fields.InValid_relig((SALT311.StrType)le.relig);
    clean_relig := (TYPEOF(le.relig))Fields.Make_relig((SALT311.StrType)le.relig);
    clean_relig_Invalid := Fields.InValid_relig((SALT311.StrType)clean_relig);
    SELF.relig := IF(withOnfail, clean_relig, le.relig); // ONFAIL(CLEAN)
    SELF.dwell_Invalid := Fields.InValid_dwell((SALT311.StrType)le.dwell);
    clean_dwell := (TYPEOF(le.dwell))Fields.Make_dwell((SALT311.StrType)le.dwell);
    clean_dwell_Invalid := Fields.InValid_dwell((SALT311.StrType)clean_dwell);
    SELF.dwell := IF(withOnfail, clean_dwell, le.dwell); // ONFAIL(CLEAN)
    SELF.ownr_Invalid := Fields.InValid_ownr((SALT311.StrType)le.ownr);
    SELF.eth1_Invalid := Fields.InValid_eth1((SALT311.StrType)le.eth1);
    clean_eth1 := (TYPEOF(le.eth1))Fields.Make_eth1((SALT311.StrType)le.eth1);
    clean_eth1_Invalid := Fields.InValid_eth1((SALT311.StrType)clean_eth1);
    SELF.eth1 := IF(withOnfail, clean_eth1, le.eth1); // ONFAIL(CLEAN)
    SELF.eth1_wouldClean := TRIM((SALT311.StrType)le.eth1) <> TRIM((SALT311.StrType)clean_eth1);
    SELF.eth2_Invalid := Fields.InValid_eth2((SALT311.StrType)le.eth2);
    clean_eth2 := (TYPEOF(le.eth2))Fields.Make_eth2((SALT311.StrType)le.eth2);
    clean_eth2_Invalid := Fields.InValid_eth2((SALT311.StrType)clean_eth2);
    SELF.eth2 := IF(withOnfail, clean_eth2, le.eth2); // ONFAIL(CLEAN)
    SELF.eth2_wouldClean := TRIM((SALT311.StrType)le.eth2) <> TRIM((SALT311.StrType)clean_eth2);
    SELF.lor_Invalid := Fields.InValid_lor((SALT311.StrType)le.lor);
    clean_lor := (TYPEOF(le.lor))Fields.Make_lor((SALT311.StrType)le.lor);
    clean_lor_Invalid := Fields.InValid_lor((SALT311.StrType)clean_lor);
    SELF.lor := IF(withOnfail, clean_lor, le.lor); // ONFAIL(CLEAN)
    SELF.lor_wouldClean := TRIM((SALT311.StrType)le.lor) <> TRIM((SALT311.StrType)clean_lor);
    SELF.pool_Invalid := Fields.InValid_pool((SALT311.StrType)le.pool);
    clean_pool := (TYPEOF(le.pool))Fields.Make_pool((SALT311.StrType)le.pool);
    clean_pool_Invalid := Fields.InValid_pool((SALT311.StrType)clean_pool);
    SELF.pool := IF(withOnfail, clean_pool, le.pool); // ONFAIL(CLEAN)
    SELF.pool_wouldClean := TRIM((SALT311.StrType)le.pool) <> TRIM((SALT311.StrType)clean_pool);
    SELF.speak_span_Invalid := Fields.InValid_speak_span((SALT311.StrType)le.speak_span);
    clean_speak_span := (TYPEOF(le.speak_span))Fields.Make_speak_span((SALT311.StrType)le.speak_span);
    clean_speak_span_Invalid := Fields.InValid_speak_span((SALT311.StrType)clean_speak_span);
    SELF.speak_span := IF(withOnfail, clean_speak_span, le.speak_span); // ONFAIL(CLEAN)
    SELF.speak_span_wouldClean := TRIM((SALT311.StrType)le.speak_span) <> TRIM((SALT311.StrType)clean_speak_span);
    SELF.soho_Invalid := Fields.InValid_soho((SALT311.StrType)le.soho);
    clean_soho := (TYPEOF(le.soho))Fields.Make_soho((SALT311.StrType)le.soho);
    clean_soho_Invalid := Fields.InValid_soho((SALT311.StrType)clean_soho);
    SELF.soho := IF(withOnfail, clean_soho, le.soho); // ONFAIL(CLEAN)
    SELF.soho_wouldClean := TRIM((SALT311.StrType)le.soho) <> TRIM((SALT311.StrType)clean_soho);
    SELF.vet_in_hh_Invalid := Fields.InValid_vet_in_hh((SALT311.StrType)le.vet_in_hh);
    clean_vet_in_hh := (TYPEOF(le.vet_in_hh))Fields.Make_vet_in_hh((SALT311.StrType)le.vet_in_hh);
    clean_vet_in_hh_Invalid := Fields.InValid_vet_in_hh((SALT311.StrType)clean_vet_in_hh);
    SELF.vet_in_hh := IF(withOnfail, clean_vet_in_hh, le.vet_in_hh); // ONFAIL(CLEAN)
    SELF.vet_in_hh_wouldClean := TRIM((SALT311.StrType)le.vet_in_hh) <> TRIM((SALT311.StrType)clean_vet_in_hh);
    SELF.ms_mags_Invalid := Fields.InValid_ms_mags((SALT311.StrType)le.ms_mags);
    SELF.ms_books_Invalid := Fields.InValid_ms_books((SALT311.StrType)le.ms_books);
    SELF.ms_publish_Invalid := Fields.InValid_ms_publish((SALT311.StrType)le.ms_publish);
    SELF.ms_pub_status_active_Invalid := Fields.InValid_ms_pub_status_active((SALT311.StrType)le.ms_pub_status_active);
    SELF.ms_pub_status_expire_Invalid := Fields.InValid_ms_pub_status_expire((SALT311.StrType)le.ms_pub_status_expire);
    SELF.ms_pub_premsold_Invalid := Fields.InValid_ms_pub_premsold((SALT311.StrType)le.ms_pub_premsold);
    SELF.ms_pub_autornwl_Invalid := Fields.InValid_ms_pub_autornwl((SALT311.StrType)le.ms_pub_autornwl);
    SELF.ms_pub_avgterm_Invalid := Fields.InValid_ms_pub_avgterm((SALT311.StrType)le.ms_pub_avgterm);
    SELF.ms_pub_lmos_Invalid := Fields.InValid_ms_pub_lmos((SALT311.StrType)le.ms_pub_lmos);
    SELF.ms_pub_omos_Invalid := Fields.InValid_ms_pub_omos((SALT311.StrType)le.ms_pub_omos);
    SELF.ms_pub_pmos_Invalid := Fields.InValid_ms_pub_pmos((SALT311.StrType)le.ms_pub_pmos);
    SELF.ms_pub_cemos_Invalid := Fields.InValid_ms_pub_cemos((SALT311.StrType)le.ms_pub_cemos);
    SELF.ms_pub_femos_Invalid := Fields.InValid_ms_pub_femos((SALT311.StrType)le.ms_pub_femos);
    SELF.ms_pub_totords_Invalid := Fields.InValid_ms_pub_totords((SALT311.StrType)le.ms_pub_totords);
    SELF.ms_pub_totdlrs_Invalid := Fields.InValid_ms_pub_totdlrs((SALT311.StrType)le.ms_pub_totdlrs);
    SELF.ms_pub_avgdlrs_Invalid := Fields.InValid_ms_pub_avgdlrs((SALT311.StrType)le.ms_pub_avgdlrs);
    SELF.ms_pub_lastdlrs_Invalid := Fields.InValid_ms_pub_lastdlrs((SALT311.StrType)le.ms_pub_lastdlrs);
    SELF.ms_pub_paystat_paid_Invalid := Fields.InValid_ms_pub_paystat_paid((SALT311.StrType)le.ms_pub_paystat_paid);
    SELF.ms_pub_paystat_ub_Invalid := Fields.InValid_ms_pub_paystat_ub((SALT311.StrType)le.ms_pub_paystat_ub);
    SELF.ms_pub_paymeth_cc_Invalid := Fields.InValid_ms_pub_paymeth_cc((SALT311.StrType)le.ms_pub_paymeth_cc);
    SELF.ms_pub_paymeth_cash_Invalid := Fields.InValid_ms_pub_paymeth_cash((SALT311.StrType)le.ms_pub_paymeth_cash);
    SELF.ms_pub_payspeed_Invalid := Fields.InValid_ms_pub_payspeed((SALT311.StrType)le.ms_pub_payspeed);
    SELF.ms_pub_osrc_dm_Invalid := Fields.InValid_ms_pub_osrc_dm((SALT311.StrType)le.ms_pub_osrc_dm);
    SELF.ms_pub_lsrc_dm_Invalid := Fields.InValid_ms_pub_lsrc_dm((SALT311.StrType)le.ms_pub_lsrc_dm);
    SELF.ms_pub_osrc_agt_cashf_Invalid := Fields.InValid_ms_pub_osrc_agt_cashf((SALT311.StrType)le.ms_pub_osrc_agt_cashf);
    SELF.ms_pub_lsrc_agt_cashf_Invalid := Fields.InValid_ms_pub_lsrc_agt_cashf((SALT311.StrType)le.ms_pub_lsrc_agt_cashf);
    SELF.ms_pub_osrc_agt_pds_Invalid := Fields.InValid_ms_pub_osrc_agt_pds((SALT311.StrType)le.ms_pub_osrc_agt_pds);
    SELF.ms_pub_lsrc_agt_pds_Invalid := Fields.InValid_ms_pub_lsrc_agt_pds((SALT311.StrType)le.ms_pub_lsrc_agt_pds);
    SELF.ms_pub_osrc_agt_schplan_Invalid := Fields.InValid_ms_pub_osrc_agt_schplan((SALT311.StrType)le.ms_pub_osrc_agt_schplan);
    SELF.ms_pub_lsrc_agt_schplan_Invalid := Fields.InValid_ms_pub_lsrc_agt_schplan((SALT311.StrType)le.ms_pub_lsrc_agt_schplan);
    SELF.ms_pub_osrc_agt_sponsor_Invalid := Fields.InValid_ms_pub_osrc_agt_sponsor((SALT311.StrType)le.ms_pub_osrc_agt_sponsor);
    SELF.ms_pub_lsrc_agt_sponsor_Invalid := Fields.InValid_ms_pub_lsrc_agt_sponsor((SALT311.StrType)le.ms_pub_lsrc_agt_sponsor);
    SELF.ms_pub_osrc_agt_tm_Invalid := Fields.InValid_ms_pub_osrc_agt_tm((SALT311.StrType)le.ms_pub_osrc_agt_tm);
    SELF.ms_pub_lsrc_agt_tm_Invalid := Fields.InValid_ms_pub_lsrc_agt_tm((SALT311.StrType)le.ms_pub_lsrc_agt_tm);
    SELF.ms_pub_osrc_agt_Invalid := Fields.InValid_ms_pub_osrc_agt((SALT311.StrType)le.ms_pub_osrc_agt);
    SELF.ms_pub_lsrc_agt_Invalid := Fields.InValid_ms_pub_lsrc_agt((SALT311.StrType)le.ms_pub_lsrc_agt);
    SELF.ms_pub_osrc_tm_Invalid := Fields.InValid_ms_pub_osrc_tm((SALT311.StrType)le.ms_pub_osrc_tm);
    SELF.ms_pub_lsrc_tm_Invalid := Fields.InValid_ms_pub_lsrc_tm((SALT311.StrType)le.ms_pub_lsrc_tm);
    SELF.ms_pub_osrc_ins_Invalid := Fields.InValid_ms_pub_osrc_ins((SALT311.StrType)le.ms_pub_osrc_ins);
    SELF.ms_pub_lsrc_ins_Invalid := Fields.InValid_ms_pub_lsrc_ins((SALT311.StrType)le.ms_pub_lsrc_ins);
    SELF.ms_pub_osrc_net_Invalid := Fields.InValid_ms_pub_osrc_net((SALT311.StrType)le.ms_pub_osrc_net);
    SELF.ms_pub_lsrc_net_Invalid := Fields.InValid_ms_pub_lsrc_net((SALT311.StrType)le.ms_pub_lsrc_net);
    SELF.ms_pub_osrc_print_Invalid := Fields.InValid_ms_pub_osrc_print((SALT311.StrType)le.ms_pub_osrc_print);
    SELF.ms_pub_lsrc_print_Invalid := Fields.InValid_ms_pub_lsrc_print((SALT311.StrType)le.ms_pub_lsrc_print);
    SELF.ms_pub_osrc_trans_Invalid := Fields.InValid_ms_pub_osrc_trans((SALT311.StrType)le.ms_pub_osrc_trans);
    SELF.ms_pub_lsrc_trans_Invalid := Fields.InValid_ms_pub_lsrc_trans((SALT311.StrType)le.ms_pub_lsrc_trans);
    SELF.ms_pub_osrc_tv_Invalid := Fields.InValid_ms_pub_osrc_tv((SALT311.StrType)le.ms_pub_osrc_tv);
    SELF.ms_pub_lsrc_tv_Invalid := Fields.InValid_ms_pub_lsrc_tv((SALT311.StrType)le.ms_pub_lsrc_tv);
    SELF.ms_pub_osrc_dtp_Invalid := Fields.InValid_ms_pub_osrc_dtp((SALT311.StrType)le.ms_pub_osrc_dtp);
    SELF.ms_pub_lsrc_dtp_Invalid := Fields.InValid_ms_pub_lsrc_dtp((SALT311.StrType)le.ms_pub_lsrc_dtp);
    SELF.ms_pub_giftgivr_Invalid := Fields.InValid_ms_pub_giftgivr((SALT311.StrType)le.ms_pub_giftgivr);
    SELF.ms_pub_giftee_Invalid := Fields.InValid_ms_pub_giftee((SALT311.StrType)le.ms_pub_giftee);
    SELF.ms_catalog_Invalid := Fields.InValid_ms_catalog((SALT311.StrType)le.ms_catalog);
    SELF.ms_cat_lmos_Invalid := Fields.InValid_ms_cat_lmos((SALT311.StrType)le.ms_cat_lmos);
    SELF.ms_cat_omos_Invalid := Fields.InValid_ms_cat_omos((SALT311.StrType)le.ms_cat_omos);
    SELF.ms_cat_pmos_Invalid := Fields.InValid_ms_cat_pmos((SALT311.StrType)le.ms_cat_pmos);
    SELF.ms_cat_totords_Invalid := Fields.InValid_ms_cat_totords((SALT311.StrType)le.ms_cat_totords);
    SELF.ms_cat_totitems_Invalid := Fields.InValid_ms_cat_totitems((SALT311.StrType)le.ms_cat_totitems);
    SELF.ms_cat_totdlrs_Invalid := Fields.InValid_ms_cat_totdlrs((SALT311.StrType)le.ms_cat_totdlrs);
    SELF.ms_cat_avgdlrs_Invalid := Fields.InValid_ms_cat_avgdlrs((SALT311.StrType)le.ms_cat_avgdlrs);
    SELF.ms_cat_lastdlrs_Invalid := Fields.InValid_ms_cat_lastdlrs((SALT311.StrType)le.ms_cat_lastdlrs);
    SELF.ms_cat_paystat_paid_Invalid := Fields.InValid_ms_cat_paystat_paid((SALT311.StrType)le.ms_cat_paystat_paid);
    SELF.ms_cat_paymeth_cc_Invalid := Fields.InValid_ms_cat_paymeth_cc((SALT311.StrType)le.ms_cat_paymeth_cc);
    SELF.ms_cat_paymeth_cash_Invalid := Fields.InValid_ms_cat_paymeth_cash((SALT311.StrType)le.ms_cat_paymeth_cash);
    SELF.ms_cat_osrc_dm_Invalid := Fields.InValid_ms_cat_osrc_dm((SALT311.StrType)le.ms_cat_osrc_dm);
    SELF.ms_cat_lsrc_dm_Invalid := Fields.InValid_ms_cat_lsrc_dm((SALT311.StrType)le.ms_cat_lsrc_dm);
    SELF.ms_cat_osrc_net_Invalid := Fields.InValid_ms_cat_osrc_net((SALT311.StrType)le.ms_cat_osrc_net);
    SELF.ms_cat_lsrc_net_Invalid := Fields.InValid_ms_cat_lsrc_net((SALT311.StrType)le.ms_cat_lsrc_net);
    SELF.ms_cat_giftgivr_Invalid := Fields.InValid_ms_cat_giftgivr((SALT311.StrType)le.ms_cat_giftgivr);
    SELF.pkpubs_corrected_Invalid := Fields.InValid_pkpubs_corrected((SALT311.StrType)le.pkpubs_corrected);
    SELF.pkcatg_corrected_Invalid := Fields.InValid_pkcatg_corrected((SALT311.StrType)le.pkcatg_corrected);
    SELF.ms_fundraising_Invalid := Fields.InValid_ms_fundraising((SALT311.StrType)le.ms_fundraising);
    SELF.ms_fund_lmos_Invalid := Fields.InValid_ms_fund_lmos((SALT311.StrType)le.ms_fund_lmos);
    SELF.ms_fund_omos_Invalid := Fields.InValid_ms_fund_omos((SALT311.StrType)le.ms_fund_omos);
    SELF.ms_fund_pmos_Invalid := Fields.InValid_ms_fund_pmos((SALT311.StrType)le.ms_fund_pmos);
    SELF.ms_fund_totords_Invalid := Fields.InValid_ms_fund_totords((SALT311.StrType)le.ms_fund_totords);
    SELF.ms_fund_totdlrs_Invalid := Fields.InValid_ms_fund_totdlrs((SALT311.StrType)le.ms_fund_totdlrs);
    SELF.ms_fund_avgdlrs_Invalid := Fields.InValid_ms_fund_avgdlrs((SALT311.StrType)le.ms_fund_avgdlrs);
    SELF.ms_fund_lastdlrs_Invalid := Fields.InValid_ms_fund_lastdlrs((SALT311.StrType)le.ms_fund_lastdlrs);
    SELF.ms_fund_paystat_paid_Invalid := Fields.InValid_ms_fund_paystat_paid((SALT311.StrType)le.ms_fund_paystat_paid);
    SELF.ms_other_Invalid := Fields.InValid_ms_other((SALT311.StrType)le.ms_other);
    SELF.ms_continuity_Invalid := Fields.InValid_ms_continuity((SALT311.StrType)le.ms_continuity);
    SELF.ms_cont_status_active_Invalid := Fields.InValid_ms_cont_status_active((SALT311.StrType)le.ms_cont_status_active);
    SELF.ms_cont_status_cancel_Invalid := Fields.InValid_ms_cont_status_cancel((SALT311.StrType)le.ms_cont_status_cancel);
    SELF.ms_cont_omos_Invalid := Fields.InValid_ms_cont_omos((SALT311.StrType)le.ms_cont_omos);
    SELF.ms_cont_lmos_Invalid := Fields.InValid_ms_cont_lmos((SALT311.StrType)le.ms_cont_lmos);
    SELF.ms_cont_pmos_Invalid := Fields.InValid_ms_cont_pmos((SALT311.StrType)le.ms_cont_pmos);
    SELF.ms_cont_totords_Invalid := Fields.InValid_ms_cont_totords((SALT311.StrType)le.ms_cont_totords);
    SELF.ms_cont_totdlrs_Invalid := Fields.InValid_ms_cont_totdlrs((SALT311.StrType)le.ms_cont_totdlrs);
    SELF.ms_cont_avgdlrs_Invalid := Fields.InValid_ms_cont_avgdlrs((SALT311.StrType)le.ms_cont_avgdlrs);
    SELF.ms_cont_lastdlrs_Invalid := Fields.InValid_ms_cont_lastdlrs((SALT311.StrType)le.ms_cont_lastdlrs);
    SELF.ms_cont_paystat_paid_Invalid := Fields.InValid_ms_cont_paystat_paid((SALT311.StrType)le.ms_cont_paystat_paid);
    SELF.ms_cont_paymeth_cc_Invalid := Fields.InValid_ms_cont_paymeth_cc((SALT311.StrType)le.ms_cont_paymeth_cc);
    SELF.ms_cont_paymeth_cash_Invalid := Fields.InValid_ms_cont_paymeth_cash((SALT311.StrType)le.ms_cont_paymeth_cash);
    SELF.ms_totords_Invalid := Fields.InValid_ms_totords((SALT311.StrType)le.ms_totords);
    SELF.ms_totitems_Invalid := Fields.InValid_ms_totitems((SALT311.StrType)le.ms_totitems);
    SELF.ms_totdlrs_Invalid := Fields.InValid_ms_totdlrs((SALT311.StrType)le.ms_totdlrs);
    SELF.ms_avgdlrs_Invalid := Fields.InValid_ms_avgdlrs((SALT311.StrType)le.ms_avgdlrs);
    SELF.ms_lastdlrs_Invalid := Fields.InValid_ms_lastdlrs((SALT311.StrType)le.ms_lastdlrs);
    SELF.ms_paystat_paid_Invalid := Fields.InValid_ms_paystat_paid((SALT311.StrType)le.ms_paystat_paid);
    SELF.ms_paymeth_cc_Invalid := Fields.InValid_ms_paymeth_cc((SALT311.StrType)le.ms_paymeth_cc);
    SELF.ms_paymeth_cash_Invalid := Fields.InValid_ms_paymeth_cash((SALT311.StrType)le.ms_paymeth_cash);
    SELF.ms_osrc_dm_Invalid := Fields.InValid_ms_osrc_dm((SALT311.StrType)le.ms_osrc_dm);
    SELF.ms_lsrc_dm_Invalid := Fields.InValid_ms_lsrc_dm((SALT311.StrType)le.ms_lsrc_dm);
    SELF.ms_osrc_tm_Invalid := Fields.InValid_ms_osrc_tm((SALT311.StrType)le.ms_osrc_tm);
    SELF.ms_lsrc_tm_Invalid := Fields.InValid_ms_lsrc_tm((SALT311.StrType)le.ms_lsrc_tm);
    SELF.ms_osrc_ins_Invalid := Fields.InValid_ms_osrc_ins((SALT311.StrType)le.ms_osrc_ins);
    SELF.ms_lsrc_ins_Invalid := Fields.InValid_ms_lsrc_ins((SALT311.StrType)le.ms_lsrc_ins);
    SELF.ms_osrc_net_Invalid := Fields.InValid_ms_osrc_net((SALT311.StrType)le.ms_osrc_net);
    SELF.ms_lsrc_net_Invalid := Fields.InValid_ms_lsrc_net((SALT311.StrType)le.ms_lsrc_net);
    SELF.ms_osrc_tv_Invalid := Fields.InValid_ms_osrc_tv((SALT311.StrType)le.ms_osrc_tv);
    SELF.ms_lsrc_tv_Invalid := Fields.InValid_ms_lsrc_tv((SALT311.StrType)le.ms_lsrc_tv);
    SELF.ms_osrc_retail_Invalid := Fields.InValid_ms_osrc_retail((SALT311.StrType)le.ms_osrc_retail);
    SELF.ms_lsrc_retail_Invalid := Fields.InValid_ms_lsrc_retail((SALT311.StrType)le.ms_lsrc_retail);
    SELF.ms_giftgivr_Invalid := Fields.InValid_ms_giftgivr((SALT311.StrType)le.ms_giftgivr);
    SELF.ms_giftee_Invalid := Fields.InValid_ms_giftee((SALT311.StrType)le.ms_giftee);
    SELF.ms_adult_Invalid := Fields.InValid_ms_adult((SALT311.StrType)le.ms_adult);
    SELF.ms_womapp_Invalid := Fields.InValid_ms_womapp((SALT311.StrType)le.ms_womapp);
    SELF.ms_menapp_Invalid := Fields.InValid_ms_menapp((SALT311.StrType)le.ms_menapp);
    SELF.ms_kidapp_Invalid := Fields.InValid_ms_kidapp((SALT311.StrType)le.ms_kidapp);
    SELF.ms_accessory_Invalid := Fields.InValid_ms_accessory((SALT311.StrType)le.ms_accessory);
    SELF.ms_apparel_Invalid := Fields.InValid_ms_apparel((SALT311.StrType)le.ms_apparel);
    SELF.ms_app_lmos_Invalid := Fields.InValid_ms_app_lmos((SALT311.StrType)le.ms_app_lmos);
    SELF.ms_app_omos_Invalid := Fields.InValid_ms_app_omos((SALT311.StrType)le.ms_app_omos);
    SELF.ms_app_pmos_Invalid := Fields.InValid_ms_app_pmos((SALT311.StrType)le.ms_app_pmos);
    SELF.ms_app_totords_Invalid := Fields.InValid_ms_app_totords((SALT311.StrType)le.ms_app_totords);
    SELF.ms_app_totitems_Invalid := Fields.InValid_ms_app_totitems((SALT311.StrType)le.ms_app_totitems);
    SELF.ms_app_totdlrs_Invalid := Fields.InValid_ms_app_totdlrs((SALT311.StrType)le.ms_app_totdlrs);
    SELF.ms_app_avgdlrs_Invalid := Fields.InValid_ms_app_avgdlrs((SALT311.StrType)le.ms_app_avgdlrs);
    SELF.ms_app_lastdlrs_Invalid := Fields.InValid_ms_app_lastdlrs((SALT311.StrType)le.ms_app_lastdlrs);
    SELF.ms_app_paystat_paid_Invalid := Fields.InValid_ms_app_paystat_paid((SALT311.StrType)le.ms_app_paystat_paid);
    SELF.ms_app_paymeth_cc_Invalid := Fields.InValid_ms_app_paymeth_cc((SALT311.StrType)le.ms_app_paymeth_cc);
    SELF.ms_app_paymeth_cash_Invalid := Fields.InValid_ms_app_paymeth_cash((SALT311.StrType)le.ms_app_paymeth_cash);
    SELF.ms_menfash_Invalid := Fields.InValid_ms_menfash((SALT311.StrType)le.ms_menfash);
    SELF.ms_womfash_Invalid := Fields.InValid_ms_womfash((SALT311.StrType)le.ms_womfash);
    SELF.ms_wfsh_lmos_Invalid := Fields.InValid_ms_wfsh_lmos((SALT311.StrType)le.ms_wfsh_lmos);
    SELF.ms_wfsh_omos_Invalid := Fields.InValid_ms_wfsh_omos((SALT311.StrType)le.ms_wfsh_omos);
    SELF.ms_wfsh_pmos_Invalid := Fields.InValid_ms_wfsh_pmos((SALT311.StrType)le.ms_wfsh_pmos);
    SELF.ms_wfsh_totords_Invalid := Fields.InValid_ms_wfsh_totords((SALT311.StrType)le.ms_wfsh_totords);
    SELF.ms_wfsh_totdlrs_Invalid := Fields.InValid_ms_wfsh_totdlrs((SALT311.StrType)le.ms_wfsh_totdlrs);
    SELF.ms_wfsh_avgdlrs_Invalid := Fields.InValid_ms_wfsh_avgdlrs((SALT311.StrType)le.ms_wfsh_avgdlrs);
    SELF.ms_wfsh_lastdlrs_Invalid := Fields.InValid_ms_wfsh_lastdlrs((SALT311.StrType)le.ms_wfsh_lastdlrs);
    SELF.ms_wfsh_paystat_paid_Invalid := Fields.InValid_ms_wfsh_paystat_paid((SALT311.StrType)le.ms_wfsh_paystat_paid);
    SELF.ms_wfsh_osrc_dm_Invalid := Fields.InValid_ms_wfsh_osrc_dm((SALT311.StrType)le.ms_wfsh_osrc_dm);
    SELF.ms_wfsh_lsrc_dm_Invalid := Fields.InValid_ms_wfsh_lsrc_dm((SALT311.StrType)le.ms_wfsh_lsrc_dm);
    SELF.ms_wfsh_osrc_agt_Invalid := Fields.InValid_ms_wfsh_osrc_agt((SALT311.StrType)le.ms_wfsh_osrc_agt);
    SELF.ms_wfsh_lsrc_agt_Invalid := Fields.InValid_ms_wfsh_lsrc_agt((SALT311.StrType)le.ms_wfsh_lsrc_agt);
    SELF.ms_audio_Invalid := Fields.InValid_ms_audio((SALT311.StrType)le.ms_audio);
    SELF.ms_auto_Invalid := Fields.InValid_ms_auto((SALT311.StrType)le.ms_auto);
    SELF.ms_aviation_Invalid := Fields.InValid_ms_aviation((SALT311.StrType)le.ms_aviation);
    SELF.ms_bargains_Invalid := Fields.InValid_ms_bargains((SALT311.StrType)le.ms_bargains);
    SELF.ms_beauty_Invalid := Fields.InValid_ms_beauty((SALT311.StrType)le.ms_beauty);
    SELF.ms_bible_Invalid := Fields.InValid_ms_bible((SALT311.StrType)le.ms_bible);
    SELF.ms_bible_lmos_Invalid := Fields.InValid_ms_bible_lmos((SALT311.StrType)le.ms_bible_lmos);
    SELF.ms_bible_omos_Invalid := Fields.InValid_ms_bible_omos((SALT311.StrType)le.ms_bible_omos);
    SELF.ms_bible_pmos_Invalid := Fields.InValid_ms_bible_pmos((SALT311.StrType)le.ms_bible_pmos);
    SELF.ms_bible_totords_Invalid := Fields.InValid_ms_bible_totords((SALT311.StrType)le.ms_bible_totords);
    SELF.ms_bible_totitems_Invalid := Fields.InValid_ms_bible_totitems((SALT311.StrType)le.ms_bible_totitems);
    SELF.ms_bible_totdlrs_Invalid := Fields.InValid_ms_bible_totdlrs((SALT311.StrType)le.ms_bible_totdlrs);
    SELF.ms_bible_avgdlrs_Invalid := Fields.InValid_ms_bible_avgdlrs((SALT311.StrType)le.ms_bible_avgdlrs);
    SELF.ms_bible_lastdlrs_Invalid := Fields.InValid_ms_bible_lastdlrs((SALT311.StrType)le.ms_bible_lastdlrs);
    SELF.ms_bible_paystat_paid_Invalid := Fields.InValid_ms_bible_paystat_paid((SALT311.StrType)le.ms_bible_paystat_paid);
    SELF.ms_bible_paymeth_cc_Invalid := Fields.InValid_ms_bible_paymeth_cc((SALT311.StrType)le.ms_bible_paymeth_cc);
    SELF.ms_bible_paymeth_cash_Invalid := Fields.InValid_ms_bible_paymeth_cash((SALT311.StrType)le.ms_bible_paymeth_cash);
    SELF.ms_business_Invalid := Fields.InValid_ms_business((SALT311.StrType)le.ms_business);
    SELF.ms_collectibles_Invalid := Fields.InValid_ms_collectibles((SALT311.StrType)le.ms_collectibles);
    SELF.ms_computers_Invalid := Fields.InValid_ms_computers((SALT311.StrType)le.ms_computers);
    SELF.ms_crafts_Invalid := Fields.InValid_ms_crafts((SALT311.StrType)le.ms_crafts);
    SELF.ms_culturearts_Invalid := Fields.InValid_ms_culturearts((SALT311.StrType)le.ms_culturearts);
    SELF.ms_currevent_Invalid := Fields.InValid_ms_currevent((SALT311.StrType)le.ms_currevent);
    SELF.ms_diy_Invalid := Fields.InValid_ms_diy((SALT311.StrType)le.ms_diy);
    SELF.ms_electronics_Invalid := Fields.InValid_ms_electronics((SALT311.StrType)le.ms_electronics);
    SELF.ms_equestrian_Invalid := Fields.InValid_ms_equestrian((SALT311.StrType)le.ms_equestrian);
    SELF.ms_pub_family_Invalid := Fields.InValid_ms_pub_family((SALT311.StrType)le.ms_pub_family);
    SELF.ms_cat_family_Invalid := Fields.InValid_ms_cat_family((SALT311.StrType)le.ms_cat_family);
    SELF.ms_family_Invalid := Fields.InValid_ms_family((SALT311.StrType)le.ms_family);
    SELF.ms_family_lmos_Invalid := Fields.InValid_ms_family_lmos((SALT311.StrType)le.ms_family_lmos);
    SELF.ms_family_omos_Invalid := Fields.InValid_ms_family_omos((SALT311.StrType)le.ms_family_omos);
    SELF.ms_family_pmos_Invalid := Fields.InValid_ms_family_pmos((SALT311.StrType)le.ms_family_pmos);
    SELF.ms_family_totords_Invalid := Fields.InValid_ms_family_totords((SALT311.StrType)le.ms_family_totords);
    SELF.ms_family_totitems_Invalid := Fields.InValid_ms_family_totitems((SALT311.StrType)le.ms_family_totitems);
    SELF.ms_family_totdlrs_Invalid := Fields.InValid_ms_family_totdlrs((SALT311.StrType)le.ms_family_totdlrs);
    SELF.ms_family_avgdlrs_Invalid := Fields.InValid_ms_family_avgdlrs((SALT311.StrType)le.ms_family_avgdlrs);
    SELF.ms_family_lastdlrs_Invalid := Fields.InValid_ms_family_lastdlrs((SALT311.StrType)le.ms_family_lastdlrs);
    SELF.ms_family_paystat_paid_Invalid := Fields.InValid_ms_family_paystat_paid((SALT311.StrType)le.ms_family_paystat_paid);
    SELF.ms_family_paymeth_cc_Invalid := Fields.InValid_ms_family_paymeth_cc((SALT311.StrType)le.ms_family_paymeth_cc);
    SELF.ms_family_paymeth_cash_Invalid := Fields.InValid_ms_family_paymeth_cash((SALT311.StrType)le.ms_family_paymeth_cash);
    SELF.ms_family_osrc_dm_Invalid := Fields.InValid_ms_family_osrc_dm((SALT311.StrType)le.ms_family_osrc_dm);
    SELF.ms_family_lsrc_dm_Invalid := Fields.InValid_ms_family_lsrc_dm((SALT311.StrType)le.ms_family_lsrc_dm);
    SELF.ms_fiction_Invalid := Fields.InValid_ms_fiction((SALT311.StrType)le.ms_fiction);
    SELF.ms_food_Invalid := Fields.InValid_ms_food((SALT311.StrType)le.ms_food);
    SELF.ms_games_Invalid := Fields.InValid_ms_games((SALT311.StrType)le.ms_games);
    SELF.ms_gifts_Invalid := Fields.InValid_ms_gifts((SALT311.StrType)le.ms_gifts);
    SELF.ms_gourmet_Invalid := Fields.InValid_ms_gourmet((SALT311.StrType)le.ms_gourmet);
    SELF.ms_fitness_Invalid := Fields.InValid_ms_fitness((SALT311.StrType)le.ms_fitness);
    SELF.ms_health_Invalid := Fields.InValid_ms_health((SALT311.StrType)le.ms_health);
    SELF.ms_hlth_lmos_Invalid := Fields.InValid_ms_hlth_lmos((SALT311.StrType)le.ms_hlth_lmos);
    SELF.ms_hlth_omos_Invalid := Fields.InValid_ms_hlth_omos((SALT311.StrType)le.ms_hlth_omos);
    SELF.ms_hlth_pmos_Invalid := Fields.InValid_ms_hlth_pmos((SALT311.StrType)le.ms_hlth_pmos);
    SELF.ms_hlth_totords_Invalid := Fields.InValid_ms_hlth_totords((SALT311.StrType)le.ms_hlth_totords);
    SELF.ms_hlth_totdlrs_Invalid := Fields.InValid_ms_hlth_totdlrs((SALT311.StrType)le.ms_hlth_totdlrs);
    SELF.ms_hlth_avgdlrs_Invalid := Fields.InValid_ms_hlth_avgdlrs((SALT311.StrType)le.ms_hlth_avgdlrs);
    SELF.ms_hlth_lastdlrs_Invalid := Fields.InValid_ms_hlth_lastdlrs((SALT311.StrType)le.ms_hlth_lastdlrs);
    SELF.ms_hlth_paystat_paid_Invalid := Fields.InValid_ms_hlth_paystat_paid((SALT311.StrType)le.ms_hlth_paystat_paid);
    SELF.ms_hlth_paymeth_cc_Invalid := Fields.InValid_ms_hlth_paymeth_cc((SALT311.StrType)le.ms_hlth_paymeth_cc);
    SELF.ms_hlth_osrc_dm_Invalid := Fields.InValid_ms_hlth_osrc_dm((SALT311.StrType)le.ms_hlth_osrc_dm);
    SELF.ms_hlth_lsrc_dm_Invalid := Fields.InValid_ms_hlth_lsrc_dm((SALT311.StrType)le.ms_hlth_lsrc_dm);
    SELF.ms_hlth_osrc_agt_Invalid := Fields.InValid_ms_hlth_osrc_agt((SALT311.StrType)le.ms_hlth_osrc_agt);
    SELF.ms_hlth_lsrc_agt_Invalid := Fields.InValid_ms_hlth_lsrc_agt((SALT311.StrType)le.ms_hlth_lsrc_agt);
    SELF.ms_hlth_osrc_tv_Invalid := Fields.InValid_ms_hlth_osrc_tv((SALT311.StrType)le.ms_hlth_osrc_tv);
    SELF.ms_hlth_lsrc_tv_Invalid := Fields.InValid_ms_hlth_lsrc_tv((SALT311.StrType)le.ms_hlth_lsrc_tv);
    SELF.ms_holiday_Invalid := Fields.InValid_ms_holiday((SALT311.StrType)le.ms_holiday);
    SELF.ms_history_Invalid := Fields.InValid_ms_history((SALT311.StrType)le.ms_history);
    SELF.ms_pub_cooking_Invalid := Fields.InValid_ms_pub_cooking((SALT311.StrType)le.ms_pub_cooking);
    SELF.ms_cooking_Invalid := Fields.InValid_ms_cooking((SALT311.StrType)le.ms_cooking);
    SELF.ms_pub_homedecr_Invalid := Fields.InValid_ms_pub_homedecr((SALT311.StrType)le.ms_pub_homedecr);
    SELF.ms_cat_homedecr_Invalid := Fields.InValid_ms_cat_homedecr((SALT311.StrType)le.ms_cat_homedecr);
    SELF.ms_homedecr_Invalid := Fields.InValid_ms_homedecr((SALT311.StrType)le.ms_homedecr);
    SELF.ms_housewares_Invalid := Fields.InValid_ms_housewares((SALT311.StrType)le.ms_housewares);
    SELF.ms_pub_garden_Invalid := Fields.InValid_ms_pub_garden((SALT311.StrType)le.ms_pub_garden);
    SELF.ms_cat_garden_Invalid := Fields.InValid_ms_cat_garden((SALT311.StrType)le.ms_cat_garden);
    SELF.ms_garden_Invalid := Fields.InValid_ms_garden((SALT311.StrType)le.ms_garden);
    SELF.ms_pub_homeliv_Invalid := Fields.InValid_ms_pub_homeliv((SALT311.StrType)le.ms_pub_homeliv);
    SELF.ms_cat_homeliv_Invalid := Fields.InValid_ms_cat_homeliv((SALT311.StrType)le.ms_cat_homeliv);
    SELF.ms_homeliv_Invalid := Fields.InValid_ms_homeliv((SALT311.StrType)le.ms_homeliv);
    SELF.ms_pub_home_status_active_Invalid := Fields.InValid_ms_pub_home_status_active((SALT311.StrType)le.ms_pub_home_status_active);
    SELF.ms_home_lmos_Invalid := Fields.InValid_ms_home_lmos((SALT311.StrType)le.ms_home_lmos);
    SELF.ms_home_omos_Invalid := Fields.InValid_ms_home_omos((SALT311.StrType)le.ms_home_omos);
    SELF.ms_home_pmos_Invalid := Fields.InValid_ms_home_pmos((SALT311.StrType)le.ms_home_pmos);
    SELF.ms_home_totords_Invalid := Fields.InValid_ms_home_totords((SALT311.StrType)le.ms_home_totords);
    SELF.ms_home_totitems_Invalid := Fields.InValid_ms_home_totitems((SALT311.StrType)le.ms_home_totitems);
    SELF.ms_home_totdlrs_Invalid := Fields.InValid_ms_home_totdlrs((SALT311.StrType)le.ms_home_totdlrs);
    SELF.ms_home_avgdlrs_Invalid := Fields.InValid_ms_home_avgdlrs((SALT311.StrType)le.ms_home_avgdlrs);
    SELF.ms_home_lastdlrs_Invalid := Fields.InValid_ms_home_lastdlrs((SALT311.StrType)le.ms_home_lastdlrs);
    SELF.ms_home_paystat_paid_Invalid := Fields.InValid_ms_home_paystat_paid((SALT311.StrType)le.ms_home_paystat_paid);
    SELF.ms_home_paymeth_cc_Invalid := Fields.InValid_ms_home_paymeth_cc((SALT311.StrType)le.ms_home_paymeth_cc);
    SELF.ms_home_paymeth_cash_Invalid := Fields.InValid_ms_home_paymeth_cash((SALT311.StrType)le.ms_home_paymeth_cash);
    SELF.ms_home_osrc_dm_Invalid := Fields.InValid_ms_home_osrc_dm((SALT311.StrType)le.ms_home_osrc_dm);
    SELF.ms_home_lsrc_dm_Invalid := Fields.InValid_ms_home_lsrc_dm((SALT311.StrType)le.ms_home_lsrc_dm);
    SELF.ms_home_osrc_agt_Invalid := Fields.InValid_ms_home_osrc_agt((SALT311.StrType)le.ms_home_osrc_agt);
    SELF.ms_home_lsrc_agt_Invalid := Fields.InValid_ms_home_lsrc_agt((SALT311.StrType)le.ms_home_lsrc_agt);
    SELF.ms_home_osrc_net_Invalid := Fields.InValid_ms_home_osrc_net((SALT311.StrType)le.ms_home_osrc_net);
    SELF.ms_home_lsrc_net_Invalid := Fields.InValid_ms_home_lsrc_net((SALT311.StrType)le.ms_home_lsrc_net);
    SELF.ms_home_osrc_tv_Invalid := Fields.InValid_ms_home_osrc_tv((SALT311.StrType)le.ms_home_osrc_tv);
    SELF.ms_home_lsrc_tv_Invalid := Fields.InValid_ms_home_lsrc_tv((SALT311.StrType)le.ms_home_lsrc_tv);
    SELF.ms_humor_Invalid := Fields.InValid_ms_humor((SALT311.StrType)le.ms_humor);
    SELF.ms_inspiration_Invalid := Fields.InValid_ms_inspiration((SALT311.StrType)le.ms_inspiration);
    SELF.ms_merchandise_Invalid := Fields.InValid_ms_merchandise((SALT311.StrType)le.ms_merchandise);
    SELF.ms_moneymaking_Invalid := Fields.InValid_ms_moneymaking((SALT311.StrType)le.ms_moneymaking);
    SELF.ms_moneymaking_lmos_Invalid := Fields.InValid_ms_moneymaking_lmos((SALT311.StrType)le.ms_moneymaking_lmos);
    SELF.ms_motorcycles_Invalid := Fields.InValid_ms_motorcycles((SALT311.StrType)le.ms_motorcycles);
    SELF.ms_music_Invalid := Fields.InValid_ms_music((SALT311.StrType)le.ms_music);
    SELF.ms_fishing_Invalid := Fields.InValid_ms_fishing((SALT311.StrType)le.ms_fishing);
    SELF.ms_hunting_Invalid := Fields.InValid_ms_hunting((SALT311.StrType)le.ms_hunting);
    SELF.ms_boatsail_Invalid := Fields.InValid_ms_boatsail((SALT311.StrType)le.ms_boatsail);
    SELF.ms_camp_Invalid := Fields.InValid_ms_camp((SALT311.StrType)le.ms_camp);
    SELF.ms_pub_outdoors_Invalid := Fields.InValid_ms_pub_outdoors((SALT311.StrType)le.ms_pub_outdoors);
    SELF.ms_cat_outdoors_Invalid := Fields.InValid_ms_cat_outdoors((SALT311.StrType)le.ms_cat_outdoors);
    SELF.ms_outdoors_Invalid := Fields.InValid_ms_outdoors((SALT311.StrType)le.ms_outdoors);
    SELF.ms_pub_out_status_active_Invalid := Fields.InValid_ms_pub_out_status_active((SALT311.StrType)le.ms_pub_out_status_active);
    SELF.ms_out_lmos_Invalid := Fields.InValid_ms_out_lmos((SALT311.StrType)le.ms_out_lmos);
    SELF.ms_out_omos_Invalid := Fields.InValid_ms_out_omos((SALT311.StrType)le.ms_out_omos);
    SELF.ms_out_pmos_Invalid := Fields.InValid_ms_out_pmos((SALT311.StrType)le.ms_out_pmos);
    SELF.ms_out_totords_Invalid := Fields.InValid_ms_out_totords((SALT311.StrType)le.ms_out_totords);
    SELF.ms_out_totitems_Invalid := Fields.InValid_ms_out_totitems((SALT311.StrType)le.ms_out_totitems);
    SELF.ms_out_totdlrs_Invalid := Fields.InValid_ms_out_totdlrs((SALT311.StrType)le.ms_out_totdlrs);
    SELF.ms_out_avgdlrs_Invalid := Fields.InValid_ms_out_avgdlrs((SALT311.StrType)le.ms_out_avgdlrs);
    SELF.ms_out_lastdlrs_Invalid := Fields.InValid_ms_out_lastdlrs((SALT311.StrType)le.ms_out_lastdlrs);
    SELF.ms_out_paystat_paid_Invalid := Fields.InValid_ms_out_paystat_paid((SALT311.StrType)le.ms_out_paystat_paid);
    SELF.ms_out_paymeth_cc_Invalid := Fields.InValid_ms_out_paymeth_cc((SALT311.StrType)le.ms_out_paymeth_cc);
    SELF.ms_out_paymeth_cash_Invalid := Fields.InValid_ms_out_paymeth_cash((SALT311.StrType)le.ms_out_paymeth_cash);
    SELF.ms_out_osrc_dm_Invalid := Fields.InValid_ms_out_osrc_dm((SALT311.StrType)le.ms_out_osrc_dm);
    SELF.ms_out_lsrc_dm_Invalid := Fields.InValid_ms_out_lsrc_dm((SALT311.StrType)le.ms_out_lsrc_dm);
    SELF.ms_out_osrc_agt_Invalid := Fields.InValid_ms_out_osrc_agt((SALT311.StrType)le.ms_out_osrc_agt);
    SELF.ms_out_lsrc_agt_Invalid := Fields.InValid_ms_out_lsrc_agt((SALT311.StrType)le.ms_out_lsrc_agt);
    SELF.ms_pets_Invalid := Fields.InValid_ms_pets((SALT311.StrType)le.ms_pets);
    SELF.ms_pfin_Invalid := Fields.InValid_ms_pfin((SALT311.StrType)le.ms_pfin);
    SELF.ms_photo_Invalid := Fields.InValid_ms_photo((SALT311.StrType)le.ms_photo);
    SELF.ms_photoproc_Invalid := Fields.InValid_ms_photoproc((SALT311.StrType)le.ms_photoproc);
    SELF.ms_rural_Invalid := Fields.InValid_ms_rural((SALT311.StrType)le.ms_rural);
    SELF.ms_science_Invalid := Fields.InValid_ms_science((SALT311.StrType)le.ms_science);
    SELF.ms_sports_Invalid := Fields.InValid_ms_sports((SALT311.StrType)le.ms_sports);
    SELF.ms_sports_lmos_Invalid := Fields.InValid_ms_sports_lmos((SALT311.StrType)le.ms_sports_lmos);
    SELF.ms_travel_Invalid := Fields.InValid_ms_travel((SALT311.StrType)le.ms_travel);
    SELF.ms_tvmovies_Invalid := Fields.InValid_ms_tvmovies((SALT311.StrType)le.ms_tvmovies);
    SELF.ms_wildlife_Invalid := Fields.InValid_ms_wildlife((SALT311.StrType)le.ms_wildlife);
    SELF.ms_woman_Invalid := Fields.InValid_ms_woman((SALT311.StrType)le.ms_woman);
    SELF.ms_woman_lmos_Invalid := Fields.InValid_ms_woman_lmos((SALT311.StrType)le.ms_woman_lmos);
    SELF.ms_ringtones_apps_Invalid := Fields.InValid_ms_ringtones_apps((SALT311.StrType)le.ms_ringtones_apps);
    SELF.cpi_mobile_apps_index_Invalid := Fields.InValid_cpi_mobile_apps_index((SALT311.StrType)le.cpi_mobile_apps_index);
    SELF.cpi_credit_repair_index_Invalid := Fields.InValid_cpi_credit_repair_index((SALT311.StrType)le.cpi_credit_repair_index);
    SELF.cpi_credit_report_index_Invalid := Fields.InValid_cpi_credit_report_index((SALT311.StrType)le.cpi_credit_report_index);
    SELF.cpi_education_seekers_index_Invalid := Fields.InValid_cpi_education_seekers_index((SALT311.StrType)le.cpi_education_seekers_index);
    SELF.cpi_insurance_index_Invalid := Fields.InValid_cpi_insurance_index((SALT311.StrType)le.cpi_insurance_index);
    SELF.cpi_insurance_health_index_Invalid := Fields.InValid_cpi_insurance_health_index((SALT311.StrType)le.cpi_insurance_health_index);
    SELF.cpi_insurance_auto_index_Invalid := Fields.InValid_cpi_insurance_auto_index((SALT311.StrType)le.cpi_insurance_auto_index);
    SELF.cpi_job_seekers_index_Invalid := Fields.InValid_cpi_job_seekers_index((SALT311.StrType)le.cpi_job_seekers_index);
    SELF.cpi_social_networking_index_Invalid := Fields.InValid_cpi_social_networking_index((SALT311.StrType)le.cpi_social_networking_index);
    SELF.cpi_adult_index_Invalid := Fields.InValid_cpi_adult_index((SALT311.StrType)le.cpi_adult_index);
    SELF.cpi_africanamerican_index_Invalid := Fields.InValid_cpi_africanamerican_index((SALT311.StrType)le.cpi_africanamerican_index);
    SELF.cpi_apparel_index_Invalid := Fields.InValid_cpi_apparel_index((SALT311.StrType)le.cpi_apparel_index);
    SELF.cpi_apparel_accessory_index_Invalid := Fields.InValid_cpi_apparel_accessory_index((SALT311.StrType)le.cpi_apparel_accessory_index);
    SELF.cpi_apparel_kids_index_Invalid := Fields.InValid_cpi_apparel_kids_index((SALT311.StrType)le.cpi_apparel_kids_index);
    SELF.cpi_apparel_men_index_Invalid := Fields.InValid_cpi_apparel_men_index((SALT311.StrType)le.cpi_apparel_men_index);
    SELF.cpi_apparel_menfash_index_Invalid := Fields.InValid_cpi_apparel_menfash_index((SALT311.StrType)le.cpi_apparel_menfash_index);
    SELF.cpi_apparel_women_index_Invalid := Fields.InValid_cpi_apparel_women_index((SALT311.StrType)le.cpi_apparel_women_index);
    SELF.cpi_apparel_womfash_index_Invalid := Fields.InValid_cpi_apparel_womfash_index((SALT311.StrType)le.cpi_apparel_womfash_index);
    SELF.cpi_asian_index_Invalid := Fields.InValid_cpi_asian_index((SALT311.StrType)le.cpi_asian_index);
    SELF.cpi_auto_index_Invalid := Fields.InValid_cpi_auto_index((SALT311.StrType)le.cpi_auto_index);
    SELF.cpi_auto_racing_index_Invalid := Fields.InValid_cpi_auto_racing_index((SALT311.StrType)le.cpi_auto_racing_index);
    SELF.cpi_auto_trucks_index_Invalid := Fields.InValid_cpi_auto_trucks_index((SALT311.StrType)le.cpi_auto_trucks_index);
    SELF.cpi_aviation_index_Invalid := Fields.InValid_cpi_aviation_index((SALT311.StrType)le.cpi_aviation_index);
    SELF.cpi_bargains_index_Invalid := Fields.InValid_cpi_bargains_index((SALT311.StrType)le.cpi_bargains_index);
    SELF.cpi_beauty_index_Invalid := Fields.InValid_cpi_beauty_index((SALT311.StrType)le.cpi_beauty_index);
    SELF.cpi_bible_index_Invalid := Fields.InValid_cpi_bible_index((SALT311.StrType)le.cpi_bible_index);
    SELF.cpi_birds_index_Invalid := Fields.InValid_cpi_birds_index((SALT311.StrType)le.cpi_birds_index);
    SELF.cpi_business_index_Invalid := Fields.InValid_cpi_business_index((SALT311.StrType)le.cpi_business_index);
    SELF.cpi_business_homeoffice_index_Invalid := Fields.InValid_cpi_business_homeoffice_index((SALT311.StrType)le.cpi_business_homeoffice_index);
    SELF.cpi_catalog_index_Invalid := Fields.InValid_cpi_catalog_index((SALT311.StrType)le.cpi_catalog_index);
    SELF.cpi_cc_index_Invalid := Fields.InValid_cpi_cc_index((SALT311.StrType)le.cpi_cc_index);
    SELF.cpi_collectibles_index_Invalid := Fields.InValid_cpi_collectibles_index((SALT311.StrType)le.cpi_collectibles_index);
    SELF.cpi_college_index_Invalid := Fields.InValid_cpi_college_index((SALT311.StrType)le.cpi_college_index);
    SELF.cpi_computers_index_Invalid := Fields.InValid_cpi_computers_index((SALT311.StrType)le.cpi_computers_index);
    SELF.cpi_conservative_index_Invalid := Fields.InValid_cpi_conservative_index((SALT311.StrType)le.cpi_conservative_index);
    SELF.cpi_continuity_index_Invalid := Fields.InValid_cpi_continuity_index((SALT311.StrType)le.cpi_continuity_index);
    SELF.cpi_cooking_index_Invalid := Fields.InValid_cpi_cooking_index((SALT311.StrType)le.cpi_cooking_index);
    SELF.cpi_crafts_index_Invalid := Fields.InValid_cpi_crafts_index((SALT311.StrType)le.cpi_crafts_index);
    SELF.cpi_crafts_crochet_index_Invalid := Fields.InValid_cpi_crafts_crochet_index((SALT311.StrType)le.cpi_crafts_crochet_index);
    SELF.cpi_crafts_knit_index_Invalid := Fields.InValid_cpi_crafts_knit_index((SALT311.StrType)le.cpi_crafts_knit_index);
    SELF.cpi_crafts_needlepoint_index_Invalid := Fields.InValid_cpi_crafts_needlepoint_index((SALT311.StrType)le.cpi_crafts_needlepoint_index);
    SELF.cpi_crafts_quilt_index_Invalid := Fields.InValid_cpi_crafts_quilt_index((SALT311.StrType)le.cpi_crafts_quilt_index);
    SELF.cpi_crafts_sew_index_Invalid := Fields.InValid_cpi_crafts_sew_index((SALT311.StrType)le.cpi_crafts_sew_index);
    SELF.cpi_culturearts_index_Invalid := Fields.InValid_cpi_culturearts_index((SALT311.StrType)le.cpi_culturearts_index);
    SELF.cpi_currevent_index_Invalid := Fields.InValid_cpi_currevent_index((SALT311.StrType)le.cpi_currevent_index);
    SELF.cpi_diy_index_Invalid := Fields.InValid_cpi_diy_index((SALT311.StrType)le.cpi_diy_index);
    SELF.cpi_donor_index_Invalid := Fields.InValid_cpi_donor_index((SALT311.StrType)le.cpi_donor_index);
    SELF.cpi_ego_index_Invalid := Fields.InValid_cpi_ego_index((SALT311.StrType)le.cpi_ego_index);
    SELF.cpi_electronics_index_Invalid := Fields.InValid_cpi_electronics_index((SALT311.StrType)le.cpi_electronics_index);
    SELF.cpi_equestrian_index_Invalid := Fields.InValid_cpi_equestrian_index((SALT311.StrType)le.cpi_equestrian_index);
    SELF.cpi_family_index_Invalid := Fields.InValid_cpi_family_index((SALT311.StrType)le.cpi_family_index);
    SELF.cpi_family_teen_index_Invalid := Fields.InValid_cpi_family_teen_index((SALT311.StrType)le.cpi_family_teen_index);
    SELF.cpi_family_young_index_Invalid := Fields.InValid_cpi_family_young_index((SALT311.StrType)le.cpi_family_young_index);
    SELF.cpi_fiction_index_Invalid := Fields.InValid_cpi_fiction_index((SALT311.StrType)le.cpi_fiction_index);
    SELF.cpi_gambling_index_Invalid := Fields.InValid_cpi_gambling_index((SALT311.StrType)le.cpi_gambling_index);
    SELF.cpi_games_index_Invalid := Fields.InValid_cpi_games_index((SALT311.StrType)le.cpi_games_index);
    SELF.cpi_gardening_index_Invalid := Fields.InValid_cpi_gardening_index((SALT311.StrType)le.cpi_gardening_index);
    SELF.cpi_gay_index_Invalid := Fields.InValid_cpi_gay_index((SALT311.StrType)le.cpi_gay_index);
    SELF.cpi_giftgivr_index_Invalid := Fields.InValid_cpi_giftgivr_index((SALT311.StrType)le.cpi_giftgivr_index);
    SELF.cpi_gourmet_index_Invalid := Fields.InValid_cpi_gourmet_index((SALT311.StrType)le.cpi_gourmet_index);
    SELF.cpi_grandparents_index_Invalid := Fields.InValid_cpi_grandparents_index((SALT311.StrType)le.cpi_grandparents_index);
    SELF.cpi_health_index_Invalid := Fields.InValid_cpi_health_index((SALT311.StrType)le.cpi_health_index);
    SELF.cpi_health_diet_index_Invalid := Fields.InValid_cpi_health_diet_index((SALT311.StrType)le.cpi_health_diet_index);
    SELF.cpi_health_fitness_index_Invalid := Fields.InValid_cpi_health_fitness_index((SALT311.StrType)le.cpi_health_fitness_index);
    SELF.cpi_hightech_index_Invalid := Fields.InValid_cpi_hightech_index((SALT311.StrType)le.cpi_hightech_index);
    SELF.cpi_hispanic_index_Invalid := Fields.InValid_cpi_hispanic_index((SALT311.StrType)le.cpi_hispanic_index);
    SELF.cpi_history_index_Invalid := Fields.InValid_cpi_history_index((SALT311.StrType)le.cpi_history_index);
    SELF.cpi_history_american_index_Invalid := Fields.InValid_cpi_history_american_index((SALT311.StrType)le.cpi_history_american_index);
    SELF.cpi_hobbies_index_Invalid := Fields.InValid_cpi_hobbies_index((SALT311.StrType)le.cpi_hobbies_index);
    SELF.cpi_homedecr_index_Invalid := Fields.InValid_cpi_homedecr_index((SALT311.StrType)le.cpi_homedecr_index);
    SELF.cpi_homeliv_index_Invalid := Fields.InValid_cpi_homeliv_index((SALT311.StrType)le.cpi_homeliv_index);
    SELF.cpi_humor_index_Invalid := Fields.InValid_cpi_humor_index((SALT311.StrType)le.cpi_humor_index);
    SELF.cpi_inspiration_index_Invalid := Fields.InValid_cpi_inspiration_index((SALT311.StrType)le.cpi_inspiration_index);
    SELF.cpi_internet_index_Invalid := Fields.InValid_cpi_internet_index((SALT311.StrType)le.cpi_internet_index);
    SELF.cpi_internet_access_index_Invalid := Fields.InValid_cpi_internet_access_index((SALT311.StrType)le.cpi_internet_access_index);
    SELF.cpi_internet_buy_index_Invalid := Fields.InValid_cpi_internet_buy_index((SALT311.StrType)le.cpi_internet_buy_index);
    SELF.cpi_liberal_index_Invalid := Fields.InValid_cpi_liberal_index((SALT311.StrType)le.cpi_liberal_index);
    SELF.cpi_moneymaking_index_Invalid := Fields.InValid_cpi_moneymaking_index((SALT311.StrType)le.cpi_moneymaking_index);
    SELF.cpi_motorcycles_index_Invalid := Fields.InValid_cpi_motorcycles_index((SALT311.StrType)le.cpi_motorcycles_index);
    SELF.cpi_music_index_Invalid := Fields.InValid_cpi_music_index((SALT311.StrType)le.cpi_music_index);
    SELF.cpi_nonfiction_index_Invalid := Fields.InValid_cpi_nonfiction_index((SALT311.StrType)le.cpi_nonfiction_index);
    SELF.cpi_ocean_index_Invalid := Fields.InValid_cpi_ocean_index((SALT311.StrType)le.cpi_ocean_index);
    SELF.cpi_outdoors_index_Invalid := Fields.InValid_cpi_outdoors_index((SALT311.StrType)le.cpi_outdoors_index);
    SELF.cpi_outdoors_boatsail_index_Invalid := Fields.InValid_cpi_outdoors_boatsail_index((SALT311.StrType)le.cpi_outdoors_boatsail_index);
    SELF.cpi_outdoors_camp_index_Invalid := Fields.InValid_cpi_outdoors_camp_index((SALT311.StrType)le.cpi_outdoors_camp_index);
    SELF.cpi_outdoors_fishing_index_Invalid := Fields.InValid_cpi_outdoors_fishing_index((SALT311.StrType)le.cpi_outdoors_fishing_index);
    SELF.cpi_outdoors_huntfish_index_Invalid := Fields.InValid_cpi_outdoors_huntfish_index((SALT311.StrType)le.cpi_outdoors_huntfish_index);
    SELF.cpi_outdoors_hunting_index_Invalid := Fields.InValid_cpi_outdoors_hunting_index((SALT311.StrType)le.cpi_outdoors_hunting_index);
    SELF.cpi_pets_index_Invalid := Fields.InValid_cpi_pets_index((SALT311.StrType)le.cpi_pets_index);
    SELF.cpi_pets_cats_index_Invalid := Fields.InValid_cpi_pets_cats_index((SALT311.StrType)le.cpi_pets_cats_index);
    SELF.cpi_pets_dogs_index_Invalid := Fields.InValid_cpi_pets_dogs_index((SALT311.StrType)le.cpi_pets_dogs_index);
    SELF.cpi_pfin_index_Invalid := Fields.InValid_cpi_pfin_index((SALT311.StrType)le.cpi_pfin_index);
    SELF.cpi_photog_index_Invalid := Fields.InValid_cpi_photog_index((SALT311.StrType)le.cpi_photog_index);
    SELF.cpi_photoproc_index_Invalid := Fields.InValid_cpi_photoproc_index((SALT311.StrType)le.cpi_photoproc_index);
    SELF.cpi_publish_index_Invalid := Fields.InValid_cpi_publish_index((SALT311.StrType)le.cpi_publish_index);
    SELF.cpi_publish_books_index_Invalid := Fields.InValid_cpi_publish_books_index((SALT311.StrType)le.cpi_publish_books_index);
    SELF.cpi_publish_mags_index_Invalid := Fields.InValid_cpi_publish_mags_index((SALT311.StrType)le.cpi_publish_mags_index);
    SELF.cpi_rural_index_Invalid := Fields.InValid_cpi_rural_index((SALT311.StrType)le.cpi_rural_index);
    SELF.cpi_science_index_Invalid := Fields.InValid_cpi_science_index((SALT311.StrType)le.cpi_science_index);
    SELF.cpi_scifi_index_Invalid := Fields.InValid_cpi_scifi_index((SALT311.StrType)le.cpi_scifi_index);
    SELF.cpi_seniors_index_Invalid := Fields.InValid_cpi_seniors_index((SALT311.StrType)le.cpi_seniors_index);
    SELF.cpi_sports_index_Invalid := Fields.InValid_cpi_sports_index((SALT311.StrType)le.cpi_sports_index);
    SELF.cpi_sports_baseball_index_Invalid := Fields.InValid_cpi_sports_baseball_index((SALT311.StrType)le.cpi_sports_baseball_index);
    SELF.cpi_sports_basketball_index_Invalid := Fields.InValid_cpi_sports_basketball_index((SALT311.StrType)le.cpi_sports_basketball_index);
    SELF.cpi_sports_biking_index_Invalid := Fields.InValid_cpi_sports_biking_index((SALT311.StrType)le.cpi_sports_biking_index);
    SELF.cpi_sports_football_index_Invalid := Fields.InValid_cpi_sports_football_index((SALT311.StrType)le.cpi_sports_football_index);
    SELF.cpi_sports_golf_index_Invalid := Fields.InValid_cpi_sports_golf_index((SALT311.StrType)le.cpi_sports_golf_index);
    SELF.cpi_sports_hockey_index_Invalid := Fields.InValid_cpi_sports_hockey_index((SALT311.StrType)le.cpi_sports_hockey_index);
    SELF.cpi_sports_running_index_Invalid := Fields.InValid_cpi_sports_running_index((SALT311.StrType)le.cpi_sports_running_index);
    SELF.cpi_sports_ski_index_Invalid := Fields.InValid_cpi_sports_ski_index((SALT311.StrType)le.cpi_sports_ski_index);
    SELF.cpi_sports_soccer_index_Invalid := Fields.InValid_cpi_sports_soccer_index((SALT311.StrType)le.cpi_sports_soccer_index);
    SELF.cpi_sports_swimming_index_Invalid := Fields.InValid_cpi_sports_swimming_index((SALT311.StrType)le.cpi_sports_swimming_index);
    SELF.cpi_sports_tennis_index_Invalid := Fields.InValid_cpi_sports_tennis_index((SALT311.StrType)le.cpi_sports_tennis_index);
    SELF.cpi_stationery_index_Invalid := Fields.InValid_cpi_stationery_index((SALT311.StrType)le.cpi_stationery_index);
    SELF.cpi_sweeps_index_Invalid := Fields.InValid_cpi_sweeps_index((SALT311.StrType)le.cpi_sweeps_index);
    SELF.cpi_tobacco_index_Invalid := Fields.InValid_cpi_tobacco_index((SALT311.StrType)le.cpi_tobacco_index);
    SELF.cpi_travel_index_Invalid := Fields.InValid_cpi_travel_index((SALT311.StrType)le.cpi_travel_index);
    SELF.cpi_travel_cruise_index_Invalid := Fields.InValid_cpi_travel_cruise_index((SALT311.StrType)le.cpi_travel_cruise_index);
    SELF.cpi_travel_rv_index_Invalid := Fields.InValid_cpi_travel_rv_index((SALT311.StrType)le.cpi_travel_rv_index);
    SELF.cpi_travel_us_index_Invalid := Fields.InValid_cpi_travel_us_index((SALT311.StrType)le.cpi_travel_us_index);
    SELF.cpi_tvmovies_index_Invalid := Fields.InValid_cpi_tvmovies_index((SALT311.StrType)le.cpi_tvmovies_index);
    SELF.cpi_wildlife_index_Invalid := Fields.InValid_cpi_wildlife_index((SALT311.StrType)le.cpi_wildlife_index);
    SELF.cpi_woman_index_Invalid := Fields.InValid_cpi_woman_index((SALT311.StrType)le.cpi_woman_index);
    SELF.totdlr_index_Invalid := Fields.InValid_totdlr_index((SALT311.StrType)le.totdlr_index);
    SELF.cpi_totdlr_Invalid := Fields.InValid_cpi_totdlr((SALT311.StrType)le.cpi_totdlr);
    SELF.cpi_totords_Invalid := Fields.InValid_cpi_totords((SALT311.StrType)le.cpi_totords);
    SELF.cpi_lastdlr_Invalid := Fields.InValid_cpi_lastdlr((SALT311.StrType)le.cpi_lastdlr);
    SELF.pkcatg_Invalid := Fields.InValid_pkcatg((SALT311.StrType)le.pkcatg);
    SELF.pkpubs_Invalid := Fields.InValid_pkpubs((SALT311.StrType)le.pkpubs);
    SELF.pkcont_Invalid := Fields.InValid_pkcont((SALT311.StrType)le.pkcont);
    SELF.pkca01_Invalid := Fields.InValid_pkca01((SALT311.StrType)le.pkca01);
    SELF.pkca03_Invalid := Fields.InValid_pkca03((SALT311.StrType)le.pkca03);
    SELF.pkca04_Invalid := Fields.InValid_pkca04((SALT311.StrType)le.pkca04);
    SELF.pkca05_Invalid := Fields.InValid_pkca05((SALT311.StrType)le.pkca05);
    SELF.pkca06_Invalid := Fields.InValid_pkca06((SALT311.StrType)le.pkca06);
    SELF.pkca07_Invalid := Fields.InValid_pkca07((SALT311.StrType)le.pkca07);
    SELF.pkca08_Invalid := Fields.InValid_pkca08((SALT311.StrType)le.pkca08);
    SELF.pkca09_Invalid := Fields.InValid_pkca09((SALT311.StrType)le.pkca09);
    SELF.pkca10_Invalid := Fields.InValid_pkca10((SALT311.StrType)le.pkca10);
    SELF.pkca11_Invalid := Fields.InValid_pkca11((SALT311.StrType)le.pkca11);
    SELF.pkca12_Invalid := Fields.InValid_pkca12((SALT311.StrType)le.pkca12);
    SELF.pkca13_Invalid := Fields.InValid_pkca13((SALT311.StrType)le.pkca13);
    SELF.pkca14_Invalid := Fields.InValid_pkca14((SALT311.StrType)le.pkca14);
    SELF.pkca15_Invalid := Fields.InValid_pkca15((SALT311.StrType)le.pkca15);
    SELF.pkca16_Invalid := Fields.InValid_pkca16((SALT311.StrType)le.pkca16);
    SELF.pkca17_Invalid := Fields.InValid_pkca17((SALT311.StrType)le.pkca17);
    SELF.pkca18_Invalid := Fields.InValid_pkca18((SALT311.StrType)le.pkca18);
    SELF.pkca20_Invalid := Fields.InValid_pkca20((SALT311.StrType)le.pkca20);
    SELF.pkca21_Invalid := Fields.InValid_pkca21((SALT311.StrType)le.pkca21);
    SELF.pkca22_Invalid := Fields.InValid_pkca22((SALT311.StrType)le.pkca22);
    SELF.pkca23_Invalid := Fields.InValid_pkca23((SALT311.StrType)le.pkca23);
    SELF.pkca24_Invalid := Fields.InValid_pkca24((SALT311.StrType)le.pkca24);
    SELF.pkca25_Invalid := Fields.InValid_pkca25((SALT311.StrType)le.pkca25);
    SELF.pkca26_Invalid := Fields.InValid_pkca26((SALT311.StrType)le.pkca26);
    SELF.pkca28_Invalid := Fields.InValid_pkca28((SALT311.StrType)le.pkca28);
    SELF.pkca29_Invalid := Fields.InValid_pkca29((SALT311.StrType)le.pkca29);
    SELF.pkca30_Invalid := Fields.InValid_pkca30((SALT311.StrType)le.pkca30);
    SELF.pkca31_Invalid := Fields.InValid_pkca31((SALT311.StrType)le.pkca31);
    SELF.pkca32_Invalid := Fields.InValid_pkca32((SALT311.StrType)le.pkca32);
    SELF.pkca33_Invalid := Fields.InValid_pkca33((SALT311.StrType)le.pkca33);
    SELF.pkca34_Invalid := Fields.InValid_pkca34((SALT311.StrType)le.pkca34);
    SELF.pkca35_Invalid := Fields.InValid_pkca35((SALT311.StrType)le.pkca35);
    SELF.pkca36_Invalid := Fields.InValid_pkca36((SALT311.StrType)le.pkca36);
    SELF.pkca37_Invalid := Fields.InValid_pkca37((SALT311.StrType)le.pkca37);
    SELF.pkca39_Invalid := Fields.InValid_pkca39((SALT311.StrType)le.pkca39);
    SELF.pkca40_Invalid := Fields.InValid_pkca40((SALT311.StrType)le.pkca40);
    SELF.pkca41_Invalid := Fields.InValid_pkca41((SALT311.StrType)le.pkca41);
    SELF.pkca42_Invalid := Fields.InValid_pkca42((SALT311.StrType)le.pkca42);
    SELF.pkca54_Invalid := Fields.InValid_pkca54((SALT311.StrType)le.pkca54);
    SELF.pkca61_Invalid := Fields.InValid_pkca61((SALT311.StrType)le.pkca61);
    SELF.pkca62_Invalid := Fields.InValid_pkca62((SALT311.StrType)le.pkca62);
    SELF.pkca64_Invalid := Fields.InValid_pkca64((SALT311.StrType)le.pkca64);
    SELF.pkpu01_Invalid := Fields.InValid_pkpu01((SALT311.StrType)le.pkpu01);
    SELF.pkpu02_Invalid := Fields.InValid_pkpu02((SALT311.StrType)le.pkpu02);
    SELF.pkpu03_Invalid := Fields.InValid_pkpu03((SALT311.StrType)le.pkpu03);
    SELF.pkpu04_Invalid := Fields.InValid_pkpu04((SALT311.StrType)le.pkpu04);
    SELF.pkpu05_Invalid := Fields.InValid_pkpu05((SALT311.StrType)le.pkpu05);
    SELF.pkpu06_Invalid := Fields.InValid_pkpu06((SALT311.StrType)le.pkpu06);
    SELF.pkpu07_Invalid := Fields.InValid_pkpu07((SALT311.StrType)le.pkpu07);
    SELF.pkpu08_Invalid := Fields.InValid_pkpu08((SALT311.StrType)le.pkpu08);
    SELF.pkpu09_Invalid := Fields.InValid_pkpu09((SALT311.StrType)le.pkpu09);
    SELF.pkpu10_Invalid := Fields.InValid_pkpu10((SALT311.StrType)le.pkpu10);
    SELF.pkpu11_Invalid := Fields.InValid_pkpu11((SALT311.StrType)le.pkpu11);
    SELF.pkpu12_Invalid := Fields.InValid_pkpu12((SALT311.StrType)le.pkpu12);
    SELF.pkpu13_Invalid := Fields.InValid_pkpu13((SALT311.StrType)le.pkpu13);
    SELF.pkpu14_Invalid := Fields.InValid_pkpu14((SALT311.StrType)le.pkpu14);
    SELF.pkpu15_Invalid := Fields.InValid_pkpu15((SALT311.StrType)le.pkpu15);
    SELF.pkpu16_Invalid := Fields.InValid_pkpu16((SALT311.StrType)le.pkpu16);
    SELF.pkpu17_Invalid := Fields.InValid_pkpu17((SALT311.StrType)le.pkpu17);
    SELF.pkpu18_Invalid := Fields.InValid_pkpu18((SALT311.StrType)le.pkpu18);
    SELF.pkpu19_Invalid := Fields.InValid_pkpu19((SALT311.StrType)le.pkpu19);
    SELF.pkpu20_Invalid := Fields.InValid_pkpu20((SALT311.StrType)le.pkpu20);
    SELF.pkpu23_Invalid := Fields.InValid_pkpu23((SALT311.StrType)le.pkpu23);
    SELF.pkpu25_Invalid := Fields.InValid_pkpu25((SALT311.StrType)le.pkpu25);
    SELF.pkpu27_Invalid := Fields.InValid_pkpu27((SALT311.StrType)le.pkpu27);
    SELF.pkpu28_Invalid := Fields.InValid_pkpu28((SALT311.StrType)le.pkpu28);
    SELF.pkpu29_Invalid := Fields.InValid_pkpu29((SALT311.StrType)le.pkpu29);
    SELF.pkpu30_Invalid := Fields.InValid_pkpu30((SALT311.StrType)le.pkpu30);
    SELF.pkpu31_Invalid := Fields.InValid_pkpu31((SALT311.StrType)le.pkpu31);
    SELF.pkpu32_Invalid := Fields.InValid_pkpu32((SALT311.StrType)le.pkpu32);
    SELF.pkpu33_Invalid := Fields.InValid_pkpu33((SALT311.StrType)le.pkpu33);
    SELF.pkpu34_Invalid := Fields.InValid_pkpu34((SALT311.StrType)le.pkpu34);
    SELF.pkpu35_Invalid := Fields.InValid_pkpu35((SALT311.StrType)le.pkpu35);
    SELF.pkpu38_Invalid := Fields.InValid_pkpu38((SALT311.StrType)le.pkpu38);
    SELF.pkpu41_Invalid := Fields.InValid_pkpu41((SALT311.StrType)le.pkpu41);
    SELF.pkpu42_Invalid := Fields.InValid_pkpu42((SALT311.StrType)le.pkpu42);
    SELF.pkpu45_Invalid := Fields.InValid_pkpu45((SALT311.StrType)le.pkpu45);
    SELF.pkpu46_Invalid := Fields.InValid_pkpu46((SALT311.StrType)le.pkpu46);
    SELF.pkpu47_Invalid := Fields.InValid_pkpu47((SALT311.StrType)le.pkpu47);
    SELF.pkpu48_Invalid := Fields.InValid_pkpu48((SALT311.StrType)le.pkpu48);
    SELF.pkpu49_Invalid := Fields.InValid_pkpu49((SALT311.StrType)le.pkpu49);
    SELF.pkpu50_Invalid := Fields.InValid_pkpu50((SALT311.StrType)le.pkpu50);
    SELF.pkpu51_Invalid := Fields.InValid_pkpu51((SALT311.StrType)le.pkpu51);
    SELF.pkpu52_Invalid := Fields.InValid_pkpu52((SALT311.StrType)le.pkpu52);
    SELF.pkpu53_Invalid := Fields.InValid_pkpu53((SALT311.StrType)le.pkpu53);
    SELF.pkpu54_Invalid := Fields.InValid_pkpu54((SALT311.StrType)le.pkpu54);
    SELF.pkpu55_Invalid := Fields.InValid_pkpu55((SALT311.StrType)le.pkpu55);
    SELF.pkpu56_Invalid := Fields.InValid_pkpu56((SALT311.StrType)le.pkpu56);
    SELF.pkpu57_Invalid := Fields.InValid_pkpu57((SALT311.StrType)le.pkpu57);
    SELF.pkpu60_Invalid := Fields.InValid_pkpu60((SALT311.StrType)le.pkpu60);
    SELF.pkpu61_Invalid := Fields.InValid_pkpu61((SALT311.StrType)le.pkpu61);
    SELF.pkpu62_Invalid := Fields.InValid_pkpu62((SALT311.StrType)le.pkpu62);
    SELF.pkpu63_Invalid := Fields.InValid_pkpu63((SALT311.StrType)le.pkpu63);
    SELF.pkpu64_Invalid := Fields.InValid_pkpu64((SALT311.StrType)le.pkpu64);
    SELF.pkpu65_Invalid := Fields.InValid_pkpu65((SALT311.StrType)le.pkpu65);
    SELF.pkpu66_Invalid := Fields.InValid_pkpu66((SALT311.StrType)le.pkpu66);
    SELF.pkpu67_Invalid := Fields.InValid_pkpu67((SALT311.StrType)le.pkpu67);
    SELF.pkpu68_Invalid := Fields.InValid_pkpu68((SALT311.StrType)le.pkpu68);
    SELF.pkpu69_Invalid := Fields.InValid_pkpu69((SALT311.StrType)le.pkpu69);
    SELF.pkpu70_Invalid := Fields.InValid_pkpu70((SALT311.StrType)le.pkpu70);
    SELF.censpct_water_Invalid := Fields.InValid_censpct_water((SALT311.StrType)le.censpct_water);
    SELF.cens_pop_density_Invalid := Fields.InValid_cens_pop_density((SALT311.StrType)le.cens_pop_density);
    SELF.cens_hu_density_Invalid := Fields.InValid_cens_hu_density((SALT311.StrType)le.cens_hu_density);
    SELF.censpct_pop_white_Invalid := Fields.InValid_censpct_pop_white((SALT311.StrType)le.censpct_pop_white);
    SELF.censpct_pop_black_Invalid := Fields.InValid_censpct_pop_black((SALT311.StrType)le.censpct_pop_black);
    SELF.censpct_pop_amerind_Invalid := Fields.InValid_censpct_pop_amerind((SALT311.StrType)le.censpct_pop_amerind);
    SELF.censpct_pop_asian_Invalid := Fields.InValid_censpct_pop_asian((SALT311.StrType)le.censpct_pop_asian);
    SELF.censpct_pop_pacisl_Invalid := Fields.InValid_censpct_pop_pacisl((SALT311.StrType)le.censpct_pop_pacisl);
    SELF.censpct_pop_othrace_Invalid := Fields.InValid_censpct_pop_othrace((SALT311.StrType)le.censpct_pop_othrace);
    SELF.censpct_pop_multirace_Invalid := Fields.InValid_censpct_pop_multirace((SALT311.StrType)le.censpct_pop_multirace);
    SELF.censpct_pop_hispanic_Invalid := Fields.InValid_censpct_pop_hispanic((SALT311.StrType)le.censpct_pop_hispanic);
    SELF.censpct_pop_agelt18_Invalid := Fields.InValid_censpct_pop_agelt18((SALT311.StrType)le.censpct_pop_agelt18);
    SELF.censpct_pop_males_Invalid := Fields.InValid_censpct_pop_males((SALT311.StrType)le.censpct_pop_males);
    SELF.censpct_adult_age1824_Invalid := Fields.InValid_censpct_adult_age1824((SALT311.StrType)le.censpct_adult_age1824);
    SELF.censpct_adult_age2534_Invalid := Fields.InValid_censpct_adult_age2534((SALT311.StrType)le.censpct_adult_age2534);
    SELF.censpct_adult_age3544_Invalid := Fields.InValid_censpct_adult_age3544((SALT311.StrType)le.censpct_adult_age3544);
    SELF.censpct_adult_age4554_Invalid := Fields.InValid_censpct_adult_age4554((SALT311.StrType)le.censpct_adult_age4554);
    SELF.censpct_adult_age5564_Invalid := Fields.InValid_censpct_adult_age5564((SALT311.StrType)le.censpct_adult_age5564);
    SELF.censpct_adult_agege65_Invalid := Fields.InValid_censpct_adult_agege65((SALT311.StrType)le.censpct_adult_agege65);
    SELF.cens_pop_medage_Invalid := Fields.InValid_cens_pop_medage((SALT311.StrType)le.cens_pop_medage);
    SELF.cens_hh_avgsize_Invalid := Fields.InValid_cens_hh_avgsize((SALT311.StrType)le.cens_hh_avgsize);
    SELF.censpct_hh_family_Invalid := Fields.InValid_censpct_hh_family((SALT311.StrType)le.censpct_hh_family);
    SELF.censpct_hh_family_husbwife_Invalid := Fields.InValid_censpct_hh_family_husbwife((SALT311.StrType)le.censpct_hh_family_husbwife);
    SELF.censpct_hu_occupied_Invalid := Fields.InValid_censpct_hu_occupied((SALT311.StrType)le.censpct_hu_occupied);
    SELF.censpct_hu_owned_Invalid := Fields.InValid_censpct_hu_owned((SALT311.StrType)le.censpct_hu_owned);
    SELF.censpct_hu_rented_Invalid := Fields.InValid_censpct_hu_rented((SALT311.StrType)le.censpct_hu_rented);
    SELF.censpct_hu_vacantseasonal_Invalid := Fields.InValid_censpct_hu_vacantseasonal((SALT311.StrType)le.censpct_hu_vacantseasonal);
    SELF.zip_medinc_Invalid := Fields.InValid_zip_medinc((SALT311.StrType)le.zip_medinc);
    SELF.zip_apparel_Invalid := Fields.InValid_zip_apparel((SALT311.StrType)le.zip_apparel);
    SELF.zip_apparel_women_Invalid := Fields.InValid_zip_apparel_women((SALT311.StrType)le.zip_apparel_women);
    SELF.zip_apparel_womfash_Invalid := Fields.InValid_zip_apparel_womfash((SALT311.StrType)le.zip_apparel_womfash);
    SELF.zip_auto_Invalid := Fields.InValid_zip_auto((SALT311.StrType)le.zip_auto);
    SELF.zip_beauty_Invalid := Fields.InValid_zip_beauty((SALT311.StrType)le.zip_beauty);
    SELF.zip_booksmusicmovies_Invalid := Fields.InValid_zip_booksmusicmovies((SALT311.StrType)le.zip_booksmusicmovies);
    SELF.zip_business_Invalid := Fields.InValid_zip_business((SALT311.StrType)le.zip_business);
    SELF.zip_catalog_Invalid := Fields.InValid_zip_catalog((SALT311.StrType)le.zip_catalog);
    SELF.zip_cc_Invalid := Fields.InValid_zip_cc((SALT311.StrType)le.zip_cc);
    SELF.zip_collectibles_Invalid := Fields.InValid_zip_collectibles((SALT311.StrType)le.zip_collectibles);
    SELF.zip_computers_Invalid := Fields.InValid_zip_computers((SALT311.StrType)le.zip_computers);
    SELF.zip_continuity_Invalid := Fields.InValid_zip_continuity((SALT311.StrType)le.zip_continuity);
    SELF.zip_cooking_Invalid := Fields.InValid_zip_cooking((SALT311.StrType)le.zip_cooking);
    SELF.zip_crafts_Invalid := Fields.InValid_zip_crafts((SALT311.StrType)le.zip_crafts);
    SELF.zip_culturearts_Invalid := Fields.InValid_zip_culturearts((SALT311.StrType)le.zip_culturearts);
    SELF.zip_dm_sold_Invalid := Fields.InValid_zip_dm_sold((SALT311.StrType)le.zip_dm_sold);
    SELF.zip_donor_Invalid := Fields.InValid_zip_donor((SALT311.StrType)le.zip_donor);
    SELF.zip_family_Invalid := Fields.InValid_zip_family((SALT311.StrType)le.zip_family);
    SELF.zip_gardening_Invalid := Fields.InValid_zip_gardening((SALT311.StrType)le.zip_gardening);
    SELF.zip_giftgivr_Invalid := Fields.InValid_zip_giftgivr((SALT311.StrType)le.zip_giftgivr);
    SELF.zip_gourmet_Invalid := Fields.InValid_zip_gourmet((SALT311.StrType)le.zip_gourmet);
    SELF.zip_health_Invalid := Fields.InValid_zip_health((SALT311.StrType)le.zip_health);
    SELF.zip_health_diet_Invalid := Fields.InValid_zip_health_diet((SALT311.StrType)le.zip_health_diet);
    SELF.zip_health_fitness_Invalid := Fields.InValid_zip_health_fitness((SALT311.StrType)le.zip_health_fitness);
    SELF.zip_hobbies_Invalid := Fields.InValid_zip_hobbies((SALT311.StrType)le.zip_hobbies);
    SELF.zip_homedecr_Invalid := Fields.InValid_zip_homedecr((SALT311.StrType)le.zip_homedecr);
    SELF.zip_homeliv_Invalid := Fields.InValid_zip_homeliv((SALT311.StrType)le.zip_homeliv);
    SELF.zip_internet_Invalid := Fields.InValid_zip_internet((SALT311.StrType)le.zip_internet);
    SELF.zip_internet_access_Invalid := Fields.InValid_zip_internet_access((SALT311.StrType)le.zip_internet_access);
    SELF.zip_internet_buy_Invalid := Fields.InValid_zip_internet_buy((SALT311.StrType)le.zip_internet_buy);
    SELF.zip_music_Invalid := Fields.InValid_zip_music((SALT311.StrType)le.zip_music);
    SELF.zip_outdoors_Invalid := Fields.InValid_zip_outdoors((SALT311.StrType)le.zip_outdoors);
    SELF.zip_pets_Invalid := Fields.InValid_zip_pets((SALT311.StrType)le.zip_pets);
    SELF.zip_pfin_Invalid := Fields.InValid_zip_pfin((SALT311.StrType)le.zip_pfin);
    SELF.zip_publish_Invalid := Fields.InValid_zip_publish((SALT311.StrType)le.zip_publish);
    SELF.zip_publish_books_Invalid := Fields.InValid_zip_publish_books((SALT311.StrType)le.zip_publish_books);
    SELF.zip_publish_mags_Invalid := Fields.InValid_zip_publish_mags((SALT311.StrType)le.zip_publish_mags);
    SELF.zip_sports_Invalid := Fields.InValid_zip_sports((SALT311.StrType)le.zip_sports);
    SELF.zip_sports_biking_Invalid := Fields.InValid_zip_sports_biking((SALT311.StrType)le.zip_sports_biking);
    SELF.zip_sports_golf_Invalid := Fields.InValid_zip_sports_golf((SALT311.StrType)le.zip_sports_golf);
    SELF.zip_travel_Invalid := Fields.InValid_zip_travel((SALT311.StrType)le.zip_travel);
    SELF.zip_travel_us_Invalid := Fields.InValid_zip_travel_us((SALT311.StrType)le.zip_travel_us);
    SELF.zip_tvmovies_Invalid := Fields.InValid_zip_tvmovies((SALT311.StrType)le.zip_tvmovies);
    SELF.zip_woman_Invalid := Fields.InValid_zip_woman((SALT311.StrType)le.zip_woman);
    SELF.zip_proftech_Invalid := Fields.InValid_zip_proftech((SALT311.StrType)le.zip_proftech);
    SELF.zip_retired_Invalid := Fields.InValid_zip_retired((SALT311.StrType)le.zip_retired);
    SELF.zip_inc100_Invalid := Fields.InValid_zip_inc100((SALT311.StrType)le.zip_inc100);
    SELF.zip_inc75_Invalid := Fields.InValid_zip_inc75((SALT311.StrType)le.zip_inc75);
    SELF.zip_inc50_Invalid := Fields.InValid_zip_inc50((SALT311.StrType)le.zip_inc50);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_Dunndata_Consumer);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.dtmatch_Invalid << 0 ) + ( le.msname_Invalid << 2 ) + ( le.msaddr1_Invalid << 3 ) + ( le.msaddr2_Invalid << 4 ) + ( le.mscity_Invalid << 5 ) + ( le.msstate_Invalid << 7 ) + ( le.mszip5_Invalid << 9 ) + ( le.mszip4_Invalid << 11 ) + ( le.dthh_Invalid << 13 ) + ( le.mscrrt_Invalid << 15 ) + ( le.msdpbc_Invalid << 17 ) + ( le.msdpv_Invalid << 19 ) + ( le.ms_addrtype_Invalid << 21 ) + ( le.ctysize_Invalid << 23 ) + ( le.lmos_Invalid << 25 ) + ( le.omos_Invalid << 26 ) + ( le.pmos_Invalid << 27 ) + ( le.gen_Invalid << 28 ) + ( le.dob_Invalid << 30 ) + ( le.age_Invalid << 31 ) + ( le.inc_Invalid << 32 ) + ( le.marital_status_Invalid << 34 ) + ( le.poc_Invalid << 35 ) + ( le.noc_Invalid << 36 ) + ( le.ocp_Invalid << 38 ) + ( le.edu_Invalid << 40 ) + ( le.lang_Invalid << 42 ) + ( le.relig_Invalid << 44 ) + ( le.dwell_Invalid << 46 ) + ( le.ownr_Invalid << 48 ) + ( le.eth1_Invalid << 49 ) + ( le.eth2_Invalid << 51 ) + ( le.lor_Invalid << 53 ) + ( le.pool_Invalid << 55 ) + ( le.speak_span_Invalid << 57 ) + ( le.soho_Invalid << 59 ) + ( le.vet_in_hh_Invalid << 61 ) + ( le.ms_mags_Invalid << 63 );
    SELF.ScrubsBits2 := ( le.ms_books_Invalid << 0 ) + ( le.ms_publish_Invalid << 1 ) + ( le.ms_pub_status_active_Invalid << 2 ) + ( le.ms_pub_status_expire_Invalid << 3 ) + ( le.ms_pub_premsold_Invalid << 4 ) + ( le.ms_pub_autornwl_Invalid << 5 ) + ( le.ms_pub_avgterm_Invalid << 6 ) + ( le.ms_pub_lmos_Invalid << 7 ) + ( le.ms_pub_omos_Invalid << 8 ) + ( le.ms_pub_pmos_Invalid << 9 ) + ( le.ms_pub_cemos_Invalid << 10 ) + ( le.ms_pub_femos_Invalid << 11 ) + ( le.ms_pub_totords_Invalid << 12 ) + ( le.ms_pub_totdlrs_Invalid << 13 ) + ( le.ms_pub_avgdlrs_Invalid << 14 ) + ( le.ms_pub_lastdlrs_Invalid << 15 ) + ( le.ms_pub_paystat_paid_Invalid << 16 ) + ( le.ms_pub_paystat_ub_Invalid << 17 ) + ( le.ms_pub_paymeth_cc_Invalid << 18 ) + ( le.ms_pub_paymeth_cash_Invalid << 19 ) + ( le.ms_pub_payspeed_Invalid << 20 ) + ( le.ms_pub_osrc_dm_Invalid << 21 ) + ( le.ms_pub_lsrc_dm_Invalid << 22 ) + ( le.ms_pub_osrc_agt_cashf_Invalid << 23 ) + ( le.ms_pub_lsrc_agt_cashf_Invalid << 24 ) + ( le.ms_pub_osrc_agt_pds_Invalid << 25 ) + ( le.ms_pub_lsrc_agt_pds_Invalid << 26 ) + ( le.ms_pub_osrc_agt_schplan_Invalid << 27 ) + ( le.ms_pub_lsrc_agt_schplan_Invalid << 28 ) + ( le.ms_pub_osrc_agt_sponsor_Invalid << 29 ) + ( le.ms_pub_lsrc_agt_sponsor_Invalid << 30 ) + ( le.ms_pub_osrc_agt_tm_Invalid << 31 ) + ( le.ms_pub_lsrc_agt_tm_Invalid << 32 ) + ( le.ms_pub_osrc_agt_Invalid << 33 ) + ( le.ms_pub_lsrc_agt_Invalid << 34 ) + ( le.ms_pub_osrc_tm_Invalid << 35 ) + ( le.ms_pub_lsrc_tm_Invalid << 36 ) + ( le.ms_pub_osrc_ins_Invalid << 37 ) + ( le.ms_pub_lsrc_ins_Invalid << 38 ) + ( le.ms_pub_osrc_net_Invalid << 39 ) + ( le.ms_pub_lsrc_net_Invalid << 40 ) + ( le.ms_pub_osrc_print_Invalid << 41 ) + ( le.ms_pub_lsrc_print_Invalid << 42 ) + ( le.ms_pub_osrc_trans_Invalid << 43 ) + ( le.ms_pub_lsrc_trans_Invalid << 44 ) + ( le.ms_pub_osrc_tv_Invalid << 45 ) + ( le.ms_pub_lsrc_tv_Invalid << 46 ) + ( le.ms_pub_osrc_dtp_Invalid << 47 ) + ( le.ms_pub_lsrc_dtp_Invalid << 48 ) + ( le.ms_pub_giftgivr_Invalid << 49 ) + ( le.ms_pub_giftee_Invalid << 50 ) + ( le.ms_catalog_Invalid << 51 ) + ( le.ms_cat_lmos_Invalid << 52 ) + ( le.ms_cat_omos_Invalid << 53 ) + ( le.ms_cat_pmos_Invalid << 54 ) + ( le.ms_cat_totords_Invalid << 55 ) + ( le.ms_cat_totitems_Invalid << 56 ) + ( le.ms_cat_totdlrs_Invalid << 57 ) + ( le.ms_cat_avgdlrs_Invalid << 58 ) + ( le.ms_cat_lastdlrs_Invalid << 59 ) + ( le.ms_cat_paystat_paid_Invalid << 60 ) + ( le.ms_cat_paymeth_cc_Invalid << 61 ) + ( le.ms_cat_paymeth_cash_Invalid << 62 ) + ( le.ms_cat_osrc_dm_Invalid << 63 );
    SELF.ScrubsBits3 := ( le.ms_cat_lsrc_dm_Invalid << 0 ) + ( le.ms_cat_osrc_net_Invalid << 1 ) + ( le.ms_cat_lsrc_net_Invalid << 2 ) + ( le.ms_cat_giftgivr_Invalid << 3 ) + ( le.pkpubs_corrected_Invalid << 4 ) + ( le.pkcatg_corrected_Invalid << 5 ) + ( le.ms_fundraising_Invalid << 6 ) + ( le.ms_fund_lmos_Invalid << 7 ) + ( le.ms_fund_omos_Invalid << 8 ) + ( le.ms_fund_pmos_Invalid << 9 ) + ( le.ms_fund_totords_Invalid << 10 ) + ( le.ms_fund_totdlrs_Invalid << 11 ) + ( le.ms_fund_avgdlrs_Invalid << 12 ) + ( le.ms_fund_lastdlrs_Invalid << 13 ) + ( le.ms_fund_paystat_paid_Invalid << 14 ) + ( le.ms_other_Invalid << 15 ) + ( le.ms_continuity_Invalid << 16 ) + ( le.ms_cont_status_active_Invalid << 17 ) + ( le.ms_cont_status_cancel_Invalid << 18 ) + ( le.ms_cont_omos_Invalid << 19 ) + ( le.ms_cont_lmos_Invalid << 20 ) + ( le.ms_cont_pmos_Invalid << 21 ) + ( le.ms_cont_totords_Invalid << 22 ) + ( le.ms_cont_totdlrs_Invalid << 23 ) + ( le.ms_cont_avgdlrs_Invalid << 24 ) + ( le.ms_cont_lastdlrs_Invalid << 25 ) + ( le.ms_cont_paystat_paid_Invalid << 26 ) + ( le.ms_cont_paymeth_cc_Invalid << 27 ) + ( le.ms_cont_paymeth_cash_Invalid << 28 ) + ( le.ms_totords_Invalid << 29 ) + ( le.ms_totitems_Invalid << 30 ) + ( le.ms_totdlrs_Invalid << 31 ) + ( le.ms_avgdlrs_Invalid << 32 ) + ( le.ms_lastdlrs_Invalid << 33 ) + ( le.ms_paystat_paid_Invalid << 34 ) + ( le.ms_paymeth_cc_Invalid << 35 ) + ( le.ms_paymeth_cash_Invalid << 36 ) + ( le.ms_osrc_dm_Invalid << 37 ) + ( le.ms_lsrc_dm_Invalid << 38 ) + ( le.ms_osrc_tm_Invalid << 39 ) + ( le.ms_lsrc_tm_Invalid << 40 ) + ( le.ms_osrc_ins_Invalid << 41 ) + ( le.ms_lsrc_ins_Invalid << 42 ) + ( le.ms_osrc_net_Invalid << 43 ) + ( le.ms_lsrc_net_Invalid << 44 ) + ( le.ms_osrc_tv_Invalid << 45 ) + ( le.ms_lsrc_tv_Invalid << 46 ) + ( le.ms_osrc_retail_Invalid << 47 ) + ( le.ms_lsrc_retail_Invalid << 48 ) + ( le.ms_giftgivr_Invalid << 49 ) + ( le.ms_giftee_Invalid << 50 ) + ( le.ms_adult_Invalid << 51 ) + ( le.ms_womapp_Invalid << 52 ) + ( le.ms_menapp_Invalid << 53 ) + ( le.ms_kidapp_Invalid << 54 ) + ( le.ms_accessory_Invalid << 55 ) + ( le.ms_apparel_Invalid << 56 ) + ( le.ms_app_lmos_Invalid << 57 ) + ( le.ms_app_omos_Invalid << 58 ) + ( le.ms_app_pmos_Invalid << 59 ) + ( le.ms_app_totords_Invalid << 60 ) + ( le.ms_app_totitems_Invalid << 61 ) + ( le.ms_app_totdlrs_Invalid << 62 ) + ( le.ms_app_avgdlrs_Invalid << 63 );
    SELF.ScrubsBits4 := ( le.ms_app_lastdlrs_Invalid << 0 ) + ( le.ms_app_paystat_paid_Invalid << 1 ) + ( le.ms_app_paymeth_cc_Invalid << 2 ) + ( le.ms_app_paymeth_cash_Invalid << 3 ) + ( le.ms_menfash_Invalid << 4 ) + ( le.ms_womfash_Invalid << 5 ) + ( le.ms_wfsh_lmos_Invalid << 6 ) + ( le.ms_wfsh_omos_Invalid << 7 ) + ( le.ms_wfsh_pmos_Invalid << 8 ) + ( le.ms_wfsh_totords_Invalid << 9 ) + ( le.ms_wfsh_totdlrs_Invalid << 10 ) + ( le.ms_wfsh_avgdlrs_Invalid << 11 ) + ( le.ms_wfsh_lastdlrs_Invalid << 12 ) + ( le.ms_wfsh_paystat_paid_Invalid << 13 ) + ( le.ms_wfsh_osrc_dm_Invalid << 14 ) + ( le.ms_wfsh_lsrc_dm_Invalid << 15 ) + ( le.ms_wfsh_osrc_agt_Invalid << 16 ) + ( le.ms_wfsh_lsrc_agt_Invalid << 17 ) + ( le.ms_audio_Invalid << 18 ) + ( le.ms_auto_Invalid << 19 ) + ( le.ms_aviation_Invalid << 20 ) + ( le.ms_bargains_Invalid << 21 ) + ( le.ms_beauty_Invalid << 22 ) + ( le.ms_bible_Invalid << 23 ) + ( le.ms_bible_lmos_Invalid << 24 ) + ( le.ms_bible_omos_Invalid << 25 ) + ( le.ms_bible_pmos_Invalid << 26 ) + ( le.ms_bible_totords_Invalid << 27 ) + ( le.ms_bible_totitems_Invalid << 28 ) + ( le.ms_bible_totdlrs_Invalid << 29 ) + ( le.ms_bible_avgdlrs_Invalid << 30 ) + ( le.ms_bible_lastdlrs_Invalid << 31 ) + ( le.ms_bible_paystat_paid_Invalid << 32 ) + ( le.ms_bible_paymeth_cc_Invalid << 33 ) + ( le.ms_bible_paymeth_cash_Invalid << 34 ) + ( le.ms_business_Invalid << 35 ) + ( le.ms_collectibles_Invalid << 36 ) + ( le.ms_computers_Invalid << 37 ) + ( le.ms_crafts_Invalid << 38 ) + ( le.ms_culturearts_Invalid << 39 ) + ( le.ms_currevent_Invalid << 40 ) + ( le.ms_diy_Invalid << 41 ) + ( le.ms_electronics_Invalid << 42 ) + ( le.ms_equestrian_Invalid << 43 ) + ( le.ms_pub_family_Invalid << 44 ) + ( le.ms_cat_family_Invalid << 45 ) + ( le.ms_family_Invalid << 46 ) + ( le.ms_family_lmos_Invalid << 47 ) + ( le.ms_family_omos_Invalid << 48 ) + ( le.ms_family_pmos_Invalid << 49 ) + ( le.ms_family_totords_Invalid << 50 ) + ( le.ms_family_totitems_Invalid << 51 ) + ( le.ms_family_totdlrs_Invalid << 52 ) + ( le.ms_family_avgdlrs_Invalid << 53 ) + ( le.ms_family_lastdlrs_Invalid << 54 ) + ( le.ms_family_paystat_paid_Invalid << 55 ) + ( le.ms_family_paymeth_cc_Invalid << 56 ) + ( le.ms_family_paymeth_cash_Invalid << 57 ) + ( le.ms_family_osrc_dm_Invalid << 58 ) + ( le.ms_family_lsrc_dm_Invalid << 59 ) + ( le.ms_fiction_Invalid << 60 ) + ( le.ms_food_Invalid << 61 ) + ( le.ms_games_Invalid << 62 ) + ( le.ms_gifts_Invalid << 63 );
    SELF.ScrubsBits5 := ( le.ms_gourmet_Invalid << 0 ) + ( le.ms_fitness_Invalid << 1 ) + ( le.ms_health_Invalid << 2 ) + ( le.ms_hlth_lmos_Invalid << 3 ) + ( le.ms_hlth_omos_Invalid << 4 ) + ( le.ms_hlth_pmos_Invalid << 5 ) + ( le.ms_hlth_totords_Invalid << 6 ) + ( le.ms_hlth_totdlrs_Invalid << 7 ) + ( le.ms_hlth_avgdlrs_Invalid << 8 ) + ( le.ms_hlth_lastdlrs_Invalid << 9 ) + ( le.ms_hlth_paystat_paid_Invalid << 10 ) + ( le.ms_hlth_paymeth_cc_Invalid << 11 ) + ( le.ms_hlth_osrc_dm_Invalid << 12 ) + ( le.ms_hlth_lsrc_dm_Invalid << 13 ) + ( le.ms_hlth_osrc_agt_Invalid << 14 ) + ( le.ms_hlth_lsrc_agt_Invalid << 15 ) + ( le.ms_hlth_osrc_tv_Invalid << 16 ) + ( le.ms_hlth_lsrc_tv_Invalid << 17 ) + ( le.ms_holiday_Invalid << 18 ) + ( le.ms_history_Invalid << 19 ) + ( le.ms_pub_cooking_Invalid << 20 ) + ( le.ms_cooking_Invalid << 21 ) + ( le.ms_pub_homedecr_Invalid << 22 ) + ( le.ms_cat_homedecr_Invalid << 23 ) + ( le.ms_homedecr_Invalid << 24 ) + ( le.ms_housewares_Invalid << 25 ) + ( le.ms_pub_garden_Invalid << 26 ) + ( le.ms_cat_garden_Invalid << 27 ) + ( le.ms_garden_Invalid << 28 ) + ( le.ms_pub_homeliv_Invalid << 29 ) + ( le.ms_cat_homeliv_Invalid << 30 ) + ( le.ms_homeliv_Invalid << 31 ) + ( le.ms_pub_home_status_active_Invalid << 32 ) + ( le.ms_home_lmos_Invalid << 33 ) + ( le.ms_home_omos_Invalid << 34 ) + ( le.ms_home_pmos_Invalid << 35 ) + ( le.ms_home_totords_Invalid << 36 ) + ( le.ms_home_totitems_Invalid << 37 ) + ( le.ms_home_totdlrs_Invalid << 38 ) + ( le.ms_home_avgdlrs_Invalid << 39 ) + ( le.ms_home_lastdlrs_Invalid << 40 ) + ( le.ms_home_paystat_paid_Invalid << 41 ) + ( le.ms_home_paymeth_cc_Invalid << 42 ) + ( le.ms_home_paymeth_cash_Invalid << 43 ) + ( le.ms_home_osrc_dm_Invalid << 44 ) + ( le.ms_home_lsrc_dm_Invalid << 45 ) + ( le.ms_home_osrc_agt_Invalid << 46 ) + ( le.ms_home_lsrc_agt_Invalid << 47 ) + ( le.ms_home_osrc_net_Invalid << 48 ) + ( le.ms_home_lsrc_net_Invalid << 49 ) + ( le.ms_home_osrc_tv_Invalid << 50 ) + ( le.ms_home_lsrc_tv_Invalid << 51 ) + ( le.ms_humor_Invalid << 52 ) + ( le.ms_inspiration_Invalid << 53 ) + ( le.ms_merchandise_Invalid << 54 ) + ( le.ms_moneymaking_Invalid << 55 ) + ( le.ms_moneymaking_lmos_Invalid << 56 ) + ( le.ms_motorcycles_Invalid << 57 ) + ( le.ms_music_Invalid << 58 ) + ( le.ms_fishing_Invalid << 59 ) + ( le.ms_hunting_Invalid << 60 ) + ( le.ms_boatsail_Invalid << 61 ) + ( le.ms_camp_Invalid << 62 ) + ( le.ms_pub_outdoors_Invalid << 63 );
    SELF.ScrubsBits6 := ( le.ms_cat_outdoors_Invalid << 0 ) + ( le.ms_outdoors_Invalid << 1 ) + ( le.ms_pub_out_status_active_Invalid << 2 ) + ( le.ms_out_lmos_Invalid << 3 ) + ( le.ms_out_omos_Invalid << 4 ) + ( le.ms_out_pmos_Invalid << 5 ) + ( le.ms_out_totords_Invalid << 6 ) + ( le.ms_out_totitems_Invalid << 7 ) + ( le.ms_out_totdlrs_Invalid << 8 ) + ( le.ms_out_avgdlrs_Invalid << 9 ) + ( le.ms_out_lastdlrs_Invalid << 10 ) + ( le.ms_out_paystat_paid_Invalid << 11 ) + ( le.ms_out_paymeth_cc_Invalid << 12 ) + ( le.ms_out_paymeth_cash_Invalid << 13 ) + ( le.ms_out_osrc_dm_Invalid << 14 ) + ( le.ms_out_lsrc_dm_Invalid << 15 ) + ( le.ms_out_osrc_agt_Invalid << 16 ) + ( le.ms_out_lsrc_agt_Invalid << 17 ) + ( le.ms_pets_Invalid << 18 ) + ( le.ms_pfin_Invalid << 19 ) + ( le.ms_photo_Invalid << 20 ) + ( le.ms_photoproc_Invalid << 21 ) + ( le.ms_rural_Invalid << 22 ) + ( le.ms_science_Invalid << 23 ) + ( le.ms_sports_Invalid << 24 ) + ( le.ms_sports_lmos_Invalid << 25 ) + ( le.ms_travel_Invalid << 26 ) + ( le.ms_tvmovies_Invalid << 27 ) + ( le.ms_wildlife_Invalid << 28 ) + ( le.ms_woman_Invalid << 29 ) + ( le.ms_woman_lmos_Invalid << 30 ) + ( le.ms_ringtones_apps_Invalid << 31 ) + ( le.cpi_mobile_apps_index_Invalid << 32 ) + ( le.cpi_credit_repair_index_Invalid << 33 ) + ( le.cpi_credit_report_index_Invalid << 34 ) + ( le.cpi_education_seekers_index_Invalid << 35 ) + ( le.cpi_insurance_index_Invalid << 36 ) + ( le.cpi_insurance_health_index_Invalid << 37 ) + ( le.cpi_insurance_auto_index_Invalid << 38 ) + ( le.cpi_job_seekers_index_Invalid << 39 ) + ( le.cpi_social_networking_index_Invalid << 40 ) + ( le.cpi_adult_index_Invalid << 41 ) + ( le.cpi_africanamerican_index_Invalid << 42 ) + ( le.cpi_apparel_index_Invalid << 43 ) + ( le.cpi_apparel_accessory_index_Invalid << 44 ) + ( le.cpi_apparel_kids_index_Invalid << 45 ) + ( le.cpi_apparel_men_index_Invalid << 46 ) + ( le.cpi_apparel_menfash_index_Invalid << 47 ) + ( le.cpi_apparel_women_index_Invalid << 48 ) + ( le.cpi_apparel_womfash_index_Invalid << 49 ) + ( le.cpi_asian_index_Invalid << 50 ) + ( le.cpi_auto_index_Invalid << 51 ) + ( le.cpi_auto_racing_index_Invalid << 52 ) + ( le.cpi_auto_trucks_index_Invalid << 53 ) + ( le.cpi_aviation_index_Invalid << 54 ) + ( le.cpi_bargains_index_Invalid << 55 ) + ( le.cpi_beauty_index_Invalid << 56 ) + ( le.cpi_bible_index_Invalid << 57 ) + ( le.cpi_birds_index_Invalid << 58 ) + ( le.cpi_business_index_Invalid << 59 ) + ( le.cpi_business_homeoffice_index_Invalid << 60 ) + ( le.cpi_catalog_index_Invalid << 61 ) + ( le.cpi_cc_index_Invalid << 62 ) + ( le.cpi_collectibles_index_Invalid << 63 );
    SELF.ScrubsBits7 := ( le.cpi_college_index_Invalid << 0 ) + ( le.cpi_computers_index_Invalid << 1 ) + ( le.cpi_conservative_index_Invalid << 2 ) + ( le.cpi_continuity_index_Invalid << 3 ) + ( le.cpi_cooking_index_Invalid << 4 ) + ( le.cpi_crafts_index_Invalid << 5 ) + ( le.cpi_crafts_crochet_index_Invalid << 6 ) + ( le.cpi_crafts_knit_index_Invalid << 7 ) + ( le.cpi_crafts_needlepoint_index_Invalid << 8 ) + ( le.cpi_crafts_quilt_index_Invalid << 9 ) + ( le.cpi_crafts_sew_index_Invalid << 10 ) + ( le.cpi_culturearts_index_Invalid << 11 ) + ( le.cpi_currevent_index_Invalid << 12 ) + ( le.cpi_diy_index_Invalid << 13 ) + ( le.cpi_donor_index_Invalid << 14 ) + ( le.cpi_ego_index_Invalid << 15 ) + ( le.cpi_electronics_index_Invalid << 16 ) + ( le.cpi_equestrian_index_Invalid << 17 ) + ( le.cpi_family_index_Invalid << 18 ) + ( le.cpi_family_teen_index_Invalid << 19 ) + ( le.cpi_family_young_index_Invalid << 20 ) + ( le.cpi_fiction_index_Invalid << 21 ) + ( le.cpi_gambling_index_Invalid << 22 ) + ( le.cpi_games_index_Invalid << 23 ) + ( le.cpi_gardening_index_Invalid << 24 ) + ( le.cpi_gay_index_Invalid << 25 ) + ( le.cpi_giftgivr_index_Invalid << 26 ) + ( le.cpi_gourmet_index_Invalid << 27 ) + ( le.cpi_grandparents_index_Invalid << 28 ) + ( le.cpi_health_index_Invalid << 29 ) + ( le.cpi_health_diet_index_Invalid << 30 ) + ( le.cpi_health_fitness_index_Invalid << 31 ) + ( le.cpi_hightech_index_Invalid << 32 ) + ( le.cpi_hispanic_index_Invalid << 33 ) + ( le.cpi_history_index_Invalid << 34 ) + ( le.cpi_history_american_index_Invalid << 35 ) + ( le.cpi_hobbies_index_Invalid << 36 ) + ( le.cpi_homedecr_index_Invalid << 37 ) + ( le.cpi_homeliv_index_Invalid << 38 ) + ( le.cpi_humor_index_Invalid << 39 ) + ( le.cpi_inspiration_index_Invalid << 40 ) + ( le.cpi_internet_index_Invalid << 41 ) + ( le.cpi_internet_access_index_Invalid << 42 ) + ( le.cpi_internet_buy_index_Invalid << 43 ) + ( le.cpi_liberal_index_Invalid << 44 ) + ( le.cpi_moneymaking_index_Invalid << 45 ) + ( le.cpi_motorcycles_index_Invalid << 46 ) + ( le.cpi_music_index_Invalid << 47 ) + ( le.cpi_nonfiction_index_Invalid << 48 ) + ( le.cpi_ocean_index_Invalid << 49 ) + ( le.cpi_outdoors_index_Invalid << 50 ) + ( le.cpi_outdoors_boatsail_index_Invalid << 51 ) + ( le.cpi_outdoors_camp_index_Invalid << 52 ) + ( le.cpi_outdoors_fishing_index_Invalid << 53 ) + ( le.cpi_outdoors_huntfish_index_Invalid << 54 ) + ( le.cpi_outdoors_hunting_index_Invalid << 55 ) + ( le.cpi_pets_index_Invalid << 56 ) + ( le.cpi_pets_cats_index_Invalid << 57 ) + ( le.cpi_pets_dogs_index_Invalid << 58 ) + ( le.cpi_pfin_index_Invalid << 59 ) + ( le.cpi_photog_index_Invalid << 60 ) + ( le.cpi_photoproc_index_Invalid << 61 ) + ( le.cpi_publish_index_Invalid << 62 ) + ( le.cpi_publish_books_index_Invalid << 63 );
    SELF.ScrubsBits8 := ( le.cpi_publish_mags_index_Invalid << 0 ) + ( le.cpi_rural_index_Invalid << 1 ) + ( le.cpi_science_index_Invalid << 2 ) + ( le.cpi_scifi_index_Invalid << 3 ) + ( le.cpi_seniors_index_Invalid << 4 ) + ( le.cpi_sports_index_Invalid << 5 ) + ( le.cpi_sports_baseball_index_Invalid << 6 ) + ( le.cpi_sports_basketball_index_Invalid << 7 ) + ( le.cpi_sports_biking_index_Invalid << 8 ) + ( le.cpi_sports_football_index_Invalid << 9 ) + ( le.cpi_sports_golf_index_Invalid << 10 ) + ( le.cpi_sports_hockey_index_Invalid << 11 ) + ( le.cpi_sports_running_index_Invalid << 12 ) + ( le.cpi_sports_ski_index_Invalid << 13 ) + ( le.cpi_sports_soccer_index_Invalid << 14 ) + ( le.cpi_sports_swimming_index_Invalid << 15 ) + ( le.cpi_sports_tennis_index_Invalid << 16 ) + ( le.cpi_stationery_index_Invalid << 17 ) + ( le.cpi_sweeps_index_Invalid << 18 ) + ( le.cpi_tobacco_index_Invalid << 19 ) + ( le.cpi_travel_index_Invalid << 20 ) + ( le.cpi_travel_cruise_index_Invalid << 21 ) + ( le.cpi_travel_rv_index_Invalid << 22 ) + ( le.cpi_travel_us_index_Invalid << 23 ) + ( le.cpi_tvmovies_index_Invalid << 24 ) + ( le.cpi_wildlife_index_Invalid << 25 ) + ( le.cpi_woman_index_Invalid << 26 ) + ( le.totdlr_index_Invalid << 27 ) + ( le.cpi_totdlr_Invalid << 28 ) + ( le.cpi_totords_Invalid << 29 ) + ( le.cpi_lastdlr_Invalid << 30 ) + ( le.pkcatg_Invalid << 31 ) + ( le.pkpubs_Invalid << 32 ) + ( le.pkcont_Invalid << 33 ) + ( le.pkca01_Invalid << 34 ) + ( le.pkca03_Invalid << 35 ) + ( le.pkca04_Invalid << 36 ) + ( le.pkca05_Invalid << 37 ) + ( le.pkca06_Invalid << 38 ) + ( le.pkca07_Invalid << 39 ) + ( le.pkca08_Invalid << 40 ) + ( le.pkca09_Invalid << 41 ) + ( le.pkca10_Invalid << 42 ) + ( le.pkca11_Invalid << 43 ) + ( le.pkca12_Invalid << 44 ) + ( le.pkca13_Invalid << 45 ) + ( le.pkca14_Invalid << 46 ) + ( le.pkca15_Invalid << 47 ) + ( le.pkca16_Invalid << 48 ) + ( le.pkca17_Invalid << 49 ) + ( le.pkca18_Invalid << 50 ) + ( le.pkca20_Invalid << 51 ) + ( le.pkca21_Invalid << 52 ) + ( le.pkca22_Invalid << 53 ) + ( le.pkca23_Invalid << 54 ) + ( le.pkca24_Invalid << 55 ) + ( le.pkca25_Invalid << 56 ) + ( le.pkca26_Invalid << 57 ) + ( le.pkca28_Invalid << 58 ) + ( le.pkca29_Invalid << 59 ) + ( le.pkca30_Invalid << 60 ) + ( le.pkca31_Invalid << 61 ) + ( le.pkca32_Invalid << 62 ) + ( le.pkca33_Invalid << 63 );
    SELF.ScrubsBits9 := ( le.pkca34_Invalid << 0 ) + ( le.pkca35_Invalid << 1 ) + ( le.pkca36_Invalid << 2 ) + ( le.pkca37_Invalid << 3 ) + ( le.pkca39_Invalid << 4 ) + ( le.pkca40_Invalid << 5 ) + ( le.pkca41_Invalid << 6 ) + ( le.pkca42_Invalid << 7 ) + ( le.pkca54_Invalid << 8 ) + ( le.pkca61_Invalid << 9 ) + ( le.pkca62_Invalid << 10 ) + ( le.pkca64_Invalid << 11 ) + ( le.pkpu01_Invalid << 12 ) + ( le.pkpu02_Invalid << 13 ) + ( le.pkpu03_Invalid << 14 ) + ( le.pkpu04_Invalid << 15 ) + ( le.pkpu05_Invalid << 16 ) + ( le.pkpu06_Invalid << 17 ) + ( le.pkpu07_Invalid << 18 ) + ( le.pkpu08_Invalid << 19 ) + ( le.pkpu09_Invalid << 20 ) + ( le.pkpu10_Invalid << 21 ) + ( le.pkpu11_Invalid << 22 ) + ( le.pkpu12_Invalid << 23 ) + ( le.pkpu13_Invalid << 24 ) + ( le.pkpu14_Invalid << 25 ) + ( le.pkpu15_Invalid << 26 ) + ( le.pkpu16_Invalid << 27 ) + ( le.pkpu17_Invalid << 28 ) + ( le.pkpu18_Invalid << 29 ) + ( le.pkpu19_Invalid << 30 ) + ( le.pkpu20_Invalid << 31 ) + ( le.pkpu23_Invalid << 32 ) + ( le.pkpu25_Invalid << 33 ) + ( le.pkpu27_Invalid << 34 ) + ( le.pkpu28_Invalid << 35 ) + ( le.pkpu29_Invalid << 36 ) + ( le.pkpu30_Invalid << 37 ) + ( le.pkpu31_Invalid << 38 ) + ( le.pkpu32_Invalid << 39 ) + ( le.pkpu33_Invalid << 40 ) + ( le.pkpu34_Invalid << 41 ) + ( le.pkpu35_Invalid << 42 ) + ( le.pkpu38_Invalid << 43 ) + ( le.pkpu41_Invalid << 44 ) + ( le.pkpu42_Invalid << 45 ) + ( le.pkpu45_Invalid << 46 ) + ( le.pkpu46_Invalid << 47 ) + ( le.pkpu47_Invalid << 48 ) + ( le.pkpu48_Invalid << 49 ) + ( le.pkpu49_Invalid << 50 ) + ( le.pkpu50_Invalid << 51 ) + ( le.pkpu51_Invalid << 52 ) + ( le.pkpu52_Invalid << 53 ) + ( le.pkpu53_Invalid << 54 ) + ( le.pkpu54_Invalid << 55 ) + ( le.pkpu55_Invalid << 56 ) + ( le.pkpu56_Invalid << 57 ) + ( le.pkpu57_Invalid << 58 ) + ( le.pkpu60_Invalid << 59 ) + ( le.pkpu61_Invalid << 60 ) + ( le.pkpu62_Invalid << 61 ) + ( le.pkpu63_Invalid << 62 ) + ( le.pkpu64_Invalid << 63 );
    SELF.ScrubsBits10 := ( le.pkpu65_Invalid << 0 ) + ( le.pkpu66_Invalid << 1 ) + ( le.pkpu67_Invalid << 2 ) + ( le.pkpu68_Invalid << 3 ) + ( le.pkpu69_Invalid << 4 ) + ( le.pkpu70_Invalid << 5 ) + ( le.censpct_water_Invalid << 6 ) + ( le.cens_pop_density_Invalid << 7 ) + ( le.cens_hu_density_Invalid << 8 ) + ( le.censpct_pop_white_Invalid << 9 ) + ( le.censpct_pop_black_Invalid << 10 ) + ( le.censpct_pop_amerind_Invalid << 11 ) + ( le.censpct_pop_asian_Invalid << 12 ) + ( le.censpct_pop_pacisl_Invalid << 13 ) + ( le.censpct_pop_othrace_Invalid << 14 ) + ( le.censpct_pop_multirace_Invalid << 15 ) + ( le.censpct_pop_hispanic_Invalid << 16 ) + ( le.censpct_pop_agelt18_Invalid << 17 ) + ( le.censpct_pop_males_Invalid << 18 ) + ( le.censpct_adult_age1824_Invalid << 19 ) + ( le.censpct_adult_age2534_Invalid << 20 ) + ( le.censpct_adult_age3544_Invalid << 21 ) + ( le.censpct_adult_age4554_Invalid << 22 ) + ( le.censpct_adult_age5564_Invalid << 23 ) + ( le.censpct_adult_agege65_Invalid << 24 ) + ( le.cens_pop_medage_Invalid << 25 ) + ( le.cens_hh_avgsize_Invalid << 26 ) + ( le.censpct_hh_family_Invalid << 27 ) + ( le.censpct_hh_family_husbwife_Invalid << 28 ) + ( le.censpct_hu_occupied_Invalid << 29 ) + ( le.censpct_hu_owned_Invalid << 30 ) + ( le.censpct_hu_rented_Invalid << 31 ) + ( le.censpct_hu_vacantseasonal_Invalid << 32 ) + ( le.zip_medinc_Invalid << 33 ) + ( le.zip_apparel_Invalid << 34 ) + ( le.zip_apparel_women_Invalid << 35 ) + ( le.zip_apparel_womfash_Invalid << 36 ) + ( le.zip_auto_Invalid << 37 ) + ( le.zip_beauty_Invalid << 38 ) + ( le.zip_booksmusicmovies_Invalid << 39 ) + ( le.zip_business_Invalid << 40 ) + ( le.zip_catalog_Invalid << 41 ) + ( le.zip_cc_Invalid << 42 ) + ( le.zip_collectibles_Invalid << 43 ) + ( le.zip_computers_Invalid << 44 ) + ( le.zip_continuity_Invalid << 45 ) + ( le.zip_cooking_Invalid << 46 ) + ( le.zip_crafts_Invalid << 47 ) + ( le.zip_culturearts_Invalid << 48 ) + ( le.zip_dm_sold_Invalid << 49 ) + ( le.zip_donor_Invalid << 50 ) + ( le.zip_family_Invalid << 51 ) + ( le.zip_gardening_Invalid << 52 ) + ( le.zip_giftgivr_Invalid << 53 ) + ( le.zip_gourmet_Invalid << 54 ) + ( le.zip_health_Invalid << 55 ) + ( le.zip_health_diet_Invalid << 56 ) + ( le.zip_health_fitness_Invalid << 57 ) + ( le.zip_hobbies_Invalid << 58 ) + ( le.zip_homedecr_Invalid << 59 ) + ( le.zip_homeliv_Invalid << 60 ) + ( le.zip_internet_Invalid << 61 ) + ( le.zip_internet_access_Invalid << 62 ) + ( le.zip_internet_buy_Invalid << 63 );
    SELF.ScrubsBits11 := ( le.zip_music_Invalid << 0 ) + ( le.zip_outdoors_Invalid << 1 ) + ( le.zip_pets_Invalid << 2 ) + ( le.zip_pfin_Invalid << 3 ) + ( le.zip_publish_Invalid << 4 ) + ( le.zip_publish_books_Invalid << 5 ) + ( le.zip_publish_mags_Invalid << 6 ) + ( le.zip_sports_Invalid << 7 ) + ( le.zip_sports_biking_Invalid << 8 ) + ( le.zip_sports_golf_Invalid << 9 ) + ( le.zip_travel_Invalid << 10 ) + ( le.zip_travel_us_Invalid << 11 ) + ( le.zip_tvmovies_Invalid << 12 ) + ( le.zip_woman_Invalid << 13 ) + ( le.zip_proftech_Invalid << 14 ) + ( le.zip_retired_Invalid << 15 ) + ( le.zip_inc100_Invalid << 16 ) + ( le.zip_inc75_Invalid << 17 ) + ( le.zip_inc50_Invalid << 18 );
    SELF.ScrubsCleanBits1 := ( IF(le.dtmatch_wouldClean, 1, 0) << 0 ) + ( IF(le.msname_wouldClean, 1, 0) << 1 ) + ( IF(le.msaddr1_wouldClean, 1, 0) << 2 ) + ( IF(le.msaddr2_wouldClean, 1, 0) << 3 ) + ( IF(le.mscity_wouldClean, 1, 0) << 4 ) + ( IF(le.msstate_wouldClean, 1, 0) << 5 ) + ( IF(le.mszip5_wouldClean, 1, 0) << 6 ) + ( IF(le.mszip4_wouldClean, 1, 0) << 7 ) + ( IF(le.dthh_wouldClean, 1, 0) << 8 ) + ( IF(le.mscrrt_wouldClean, 1, 0) << 9 ) + ( IF(le.msdpbc_wouldClean, 1, 0) << 10 ) + ( IF(le.msdpv_wouldClean, 1, 0) << 11 ) + ( IF(le.ms_addrtype_wouldClean, 1, 0) << 12 ) + ( IF(le.ctysize_wouldClean, 1, 0) << 13 ) + ( IF(le.noc_wouldClean, 1, 0) << 14 ) + ( IF(le.lang_wouldClean, 1, 0) << 15 ) + ( IF(le.eth1_wouldClean, 1, 0) << 16 ) + ( IF(le.eth2_wouldClean, 1, 0) << 17 ) + ( IF(le.lor_wouldClean, 1, 0) << 18 ) + ( IF(le.pool_wouldClean, 1, 0) << 19 ) + ( IF(le.speak_span_wouldClean, 1, 0) << 20 ) + ( IF(le.soho_wouldClean, 1, 0) << 21 ) + ( IF(le.vet_in_hh_wouldClean, 1, 0) << 22 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_Dunndata_Consumer);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.dtmatch_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.msname_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.msaddr1_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.msaddr2_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.mscity_Invalid := (le.ScrubsBits1 >> 5) & 3;
    SELF.msstate_Invalid := (le.ScrubsBits1 >> 7) & 3;
    SELF.mszip5_Invalid := (le.ScrubsBits1 >> 9) & 3;
    SELF.mszip4_Invalid := (le.ScrubsBits1 >> 11) & 3;
    SELF.dthh_Invalid := (le.ScrubsBits1 >> 13) & 3;
    SELF.mscrrt_Invalid := (le.ScrubsBits1 >> 15) & 3;
    SELF.msdpbc_Invalid := (le.ScrubsBits1 >> 17) & 3;
    SELF.msdpv_Invalid := (le.ScrubsBits1 >> 19) & 3;
    SELF.ms_addrtype_Invalid := (le.ScrubsBits1 >> 21) & 3;
    SELF.ctysize_Invalid := (le.ScrubsBits1 >> 23) & 3;
    SELF.lmos_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.omos_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.pmos_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.gen_Invalid := (le.ScrubsBits1 >> 28) & 3;
    SELF.dob_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.age_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.inc_Invalid := (le.ScrubsBits1 >> 32) & 3;
    SELF.marital_status_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.poc_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.noc_Invalid := (le.ScrubsBits1 >> 36) & 3;
    SELF.ocp_Invalid := (le.ScrubsBits1 >> 38) & 3;
    SELF.edu_Invalid := (le.ScrubsBits1 >> 40) & 3;
    SELF.lang_Invalid := (le.ScrubsBits1 >> 42) & 3;
    SELF.relig_Invalid := (le.ScrubsBits1 >> 44) & 3;
    SELF.dwell_Invalid := (le.ScrubsBits1 >> 46) & 3;
    SELF.ownr_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.eth1_Invalid := (le.ScrubsBits1 >> 49) & 3;
    SELF.eth2_Invalid := (le.ScrubsBits1 >> 51) & 3;
    SELF.lor_Invalid := (le.ScrubsBits1 >> 53) & 3;
    SELF.pool_Invalid := (le.ScrubsBits1 >> 55) & 3;
    SELF.speak_span_Invalid := (le.ScrubsBits1 >> 57) & 3;
    SELF.soho_Invalid := (le.ScrubsBits1 >> 59) & 3;
    SELF.vet_in_hh_Invalid := (le.ScrubsBits1 >> 61) & 3;
    SELF.ms_mags_Invalid := (le.ScrubsBits1 >> 63) & 1;
    SELF.ms_books_Invalid := (le.ScrubsBits2 >> 0) & 1;
    SELF.ms_publish_Invalid := (le.ScrubsBits2 >> 1) & 1;
    SELF.ms_pub_status_active_Invalid := (le.ScrubsBits2 >> 2) & 1;
    SELF.ms_pub_status_expire_Invalid := (le.ScrubsBits2 >> 3) & 1;
    SELF.ms_pub_premsold_Invalid := (le.ScrubsBits2 >> 4) & 1;
    SELF.ms_pub_autornwl_Invalid := (le.ScrubsBits2 >> 5) & 1;
    SELF.ms_pub_avgterm_Invalid := (le.ScrubsBits2 >> 6) & 1;
    SELF.ms_pub_lmos_Invalid := (le.ScrubsBits2 >> 7) & 1;
    SELF.ms_pub_omos_Invalid := (le.ScrubsBits2 >> 8) & 1;
    SELF.ms_pub_pmos_Invalid := (le.ScrubsBits2 >> 9) & 1;
    SELF.ms_pub_cemos_Invalid := (le.ScrubsBits2 >> 10) & 1;
    SELF.ms_pub_femos_Invalid := (le.ScrubsBits2 >> 11) & 1;
    SELF.ms_pub_totords_Invalid := (le.ScrubsBits2 >> 12) & 1;
    SELF.ms_pub_totdlrs_Invalid := (le.ScrubsBits2 >> 13) & 1;
    SELF.ms_pub_avgdlrs_Invalid := (le.ScrubsBits2 >> 14) & 1;
    SELF.ms_pub_lastdlrs_Invalid := (le.ScrubsBits2 >> 15) & 1;
    SELF.ms_pub_paystat_paid_Invalid := (le.ScrubsBits2 >> 16) & 1;
    SELF.ms_pub_paystat_ub_Invalid := (le.ScrubsBits2 >> 17) & 1;
    SELF.ms_pub_paymeth_cc_Invalid := (le.ScrubsBits2 >> 18) & 1;
    SELF.ms_pub_paymeth_cash_Invalid := (le.ScrubsBits2 >> 19) & 1;
    SELF.ms_pub_payspeed_Invalid := (le.ScrubsBits2 >> 20) & 1;
    SELF.ms_pub_osrc_dm_Invalid := (le.ScrubsBits2 >> 21) & 1;
    SELF.ms_pub_lsrc_dm_Invalid := (le.ScrubsBits2 >> 22) & 1;
    SELF.ms_pub_osrc_agt_cashf_Invalid := (le.ScrubsBits2 >> 23) & 1;
    SELF.ms_pub_lsrc_agt_cashf_Invalid := (le.ScrubsBits2 >> 24) & 1;
    SELF.ms_pub_osrc_agt_pds_Invalid := (le.ScrubsBits2 >> 25) & 1;
    SELF.ms_pub_lsrc_agt_pds_Invalid := (le.ScrubsBits2 >> 26) & 1;
    SELF.ms_pub_osrc_agt_schplan_Invalid := (le.ScrubsBits2 >> 27) & 1;
    SELF.ms_pub_lsrc_agt_schplan_Invalid := (le.ScrubsBits2 >> 28) & 1;
    SELF.ms_pub_osrc_agt_sponsor_Invalid := (le.ScrubsBits2 >> 29) & 1;
    SELF.ms_pub_lsrc_agt_sponsor_Invalid := (le.ScrubsBits2 >> 30) & 1;
    SELF.ms_pub_osrc_agt_tm_Invalid := (le.ScrubsBits2 >> 31) & 1;
    SELF.ms_pub_lsrc_agt_tm_Invalid := (le.ScrubsBits2 >> 32) & 1;
    SELF.ms_pub_osrc_agt_Invalid := (le.ScrubsBits2 >> 33) & 1;
    SELF.ms_pub_lsrc_agt_Invalid := (le.ScrubsBits2 >> 34) & 1;
    SELF.ms_pub_osrc_tm_Invalid := (le.ScrubsBits2 >> 35) & 1;
    SELF.ms_pub_lsrc_tm_Invalid := (le.ScrubsBits2 >> 36) & 1;
    SELF.ms_pub_osrc_ins_Invalid := (le.ScrubsBits2 >> 37) & 1;
    SELF.ms_pub_lsrc_ins_Invalid := (le.ScrubsBits2 >> 38) & 1;
    SELF.ms_pub_osrc_net_Invalid := (le.ScrubsBits2 >> 39) & 1;
    SELF.ms_pub_lsrc_net_Invalid := (le.ScrubsBits2 >> 40) & 1;
    SELF.ms_pub_osrc_print_Invalid := (le.ScrubsBits2 >> 41) & 1;
    SELF.ms_pub_lsrc_print_Invalid := (le.ScrubsBits2 >> 42) & 1;
    SELF.ms_pub_osrc_trans_Invalid := (le.ScrubsBits2 >> 43) & 1;
    SELF.ms_pub_lsrc_trans_Invalid := (le.ScrubsBits2 >> 44) & 1;
    SELF.ms_pub_osrc_tv_Invalid := (le.ScrubsBits2 >> 45) & 1;
    SELF.ms_pub_lsrc_tv_Invalid := (le.ScrubsBits2 >> 46) & 1;
    SELF.ms_pub_osrc_dtp_Invalid := (le.ScrubsBits2 >> 47) & 1;
    SELF.ms_pub_lsrc_dtp_Invalid := (le.ScrubsBits2 >> 48) & 1;
    SELF.ms_pub_giftgivr_Invalid := (le.ScrubsBits2 >> 49) & 1;
    SELF.ms_pub_giftee_Invalid := (le.ScrubsBits2 >> 50) & 1;
    SELF.ms_catalog_Invalid := (le.ScrubsBits2 >> 51) & 1;
    SELF.ms_cat_lmos_Invalid := (le.ScrubsBits2 >> 52) & 1;
    SELF.ms_cat_omos_Invalid := (le.ScrubsBits2 >> 53) & 1;
    SELF.ms_cat_pmos_Invalid := (le.ScrubsBits2 >> 54) & 1;
    SELF.ms_cat_totords_Invalid := (le.ScrubsBits2 >> 55) & 1;
    SELF.ms_cat_totitems_Invalid := (le.ScrubsBits2 >> 56) & 1;
    SELF.ms_cat_totdlrs_Invalid := (le.ScrubsBits2 >> 57) & 1;
    SELF.ms_cat_avgdlrs_Invalid := (le.ScrubsBits2 >> 58) & 1;
    SELF.ms_cat_lastdlrs_Invalid := (le.ScrubsBits2 >> 59) & 1;
    SELF.ms_cat_paystat_paid_Invalid := (le.ScrubsBits2 >> 60) & 1;
    SELF.ms_cat_paymeth_cc_Invalid := (le.ScrubsBits2 >> 61) & 1;
    SELF.ms_cat_paymeth_cash_Invalid := (le.ScrubsBits2 >> 62) & 1;
    SELF.ms_cat_osrc_dm_Invalid := (le.ScrubsBits2 >> 63) & 1;
    SELF.ms_cat_lsrc_dm_Invalid := (le.ScrubsBits3 >> 0) & 1;
    SELF.ms_cat_osrc_net_Invalid := (le.ScrubsBits3 >> 1) & 1;
    SELF.ms_cat_lsrc_net_Invalid := (le.ScrubsBits3 >> 2) & 1;
    SELF.ms_cat_giftgivr_Invalid := (le.ScrubsBits3 >> 3) & 1;
    SELF.pkpubs_corrected_Invalid := (le.ScrubsBits3 >> 4) & 1;
    SELF.pkcatg_corrected_Invalid := (le.ScrubsBits3 >> 5) & 1;
    SELF.ms_fundraising_Invalid := (le.ScrubsBits3 >> 6) & 1;
    SELF.ms_fund_lmos_Invalid := (le.ScrubsBits3 >> 7) & 1;
    SELF.ms_fund_omos_Invalid := (le.ScrubsBits3 >> 8) & 1;
    SELF.ms_fund_pmos_Invalid := (le.ScrubsBits3 >> 9) & 1;
    SELF.ms_fund_totords_Invalid := (le.ScrubsBits3 >> 10) & 1;
    SELF.ms_fund_totdlrs_Invalid := (le.ScrubsBits3 >> 11) & 1;
    SELF.ms_fund_avgdlrs_Invalid := (le.ScrubsBits3 >> 12) & 1;
    SELF.ms_fund_lastdlrs_Invalid := (le.ScrubsBits3 >> 13) & 1;
    SELF.ms_fund_paystat_paid_Invalid := (le.ScrubsBits3 >> 14) & 1;
    SELF.ms_other_Invalid := (le.ScrubsBits3 >> 15) & 1;
    SELF.ms_continuity_Invalid := (le.ScrubsBits3 >> 16) & 1;
    SELF.ms_cont_status_active_Invalid := (le.ScrubsBits3 >> 17) & 1;
    SELF.ms_cont_status_cancel_Invalid := (le.ScrubsBits3 >> 18) & 1;
    SELF.ms_cont_omos_Invalid := (le.ScrubsBits3 >> 19) & 1;
    SELF.ms_cont_lmos_Invalid := (le.ScrubsBits3 >> 20) & 1;
    SELF.ms_cont_pmos_Invalid := (le.ScrubsBits3 >> 21) & 1;
    SELF.ms_cont_totords_Invalid := (le.ScrubsBits3 >> 22) & 1;
    SELF.ms_cont_totdlrs_Invalid := (le.ScrubsBits3 >> 23) & 1;
    SELF.ms_cont_avgdlrs_Invalid := (le.ScrubsBits3 >> 24) & 1;
    SELF.ms_cont_lastdlrs_Invalid := (le.ScrubsBits3 >> 25) & 1;
    SELF.ms_cont_paystat_paid_Invalid := (le.ScrubsBits3 >> 26) & 1;
    SELF.ms_cont_paymeth_cc_Invalid := (le.ScrubsBits3 >> 27) & 1;
    SELF.ms_cont_paymeth_cash_Invalid := (le.ScrubsBits3 >> 28) & 1;
    SELF.ms_totords_Invalid := (le.ScrubsBits3 >> 29) & 1;
    SELF.ms_totitems_Invalid := (le.ScrubsBits3 >> 30) & 1;
    SELF.ms_totdlrs_Invalid := (le.ScrubsBits3 >> 31) & 1;
    SELF.ms_avgdlrs_Invalid := (le.ScrubsBits3 >> 32) & 1;
    SELF.ms_lastdlrs_Invalid := (le.ScrubsBits3 >> 33) & 1;
    SELF.ms_paystat_paid_Invalid := (le.ScrubsBits3 >> 34) & 1;
    SELF.ms_paymeth_cc_Invalid := (le.ScrubsBits3 >> 35) & 1;
    SELF.ms_paymeth_cash_Invalid := (le.ScrubsBits3 >> 36) & 1;
    SELF.ms_osrc_dm_Invalid := (le.ScrubsBits3 >> 37) & 1;
    SELF.ms_lsrc_dm_Invalid := (le.ScrubsBits3 >> 38) & 1;
    SELF.ms_osrc_tm_Invalid := (le.ScrubsBits3 >> 39) & 1;
    SELF.ms_lsrc_tm_Invalid := (le.ScrubsBits3 >> 40) & 1;
    SELF.ms_osrc_ins_Invalid := (le.ScrubsBits3 >> 41) & 1;
    SELF.ms_lsrc_ins_Invalid := (le.ScrubsBits3 >> 42) & 1;
    SELF.ms_osrc_net_Invalid := (le.ScrubsBits3 >> 43) & 1;
    SELF.ms_lsrc_net_Invalid := (le.ScrubsBits3 >> 44) & 1;
    SELF.ms_osrc_tv_Invalid := (le.ScrubsBits3 >> 45) & 1;
    SELF.ms_lsrc_tv_Invalid := (le.ScrubsBits3 >> 46) & 1;
    SELF.ms_osrc_retail_Invalid := (le.ScrubsBits3 >> 47) & 1;
    SELF.ms_lsrc_retail_Invalid := (le.ScrubsBits3 >> 48) & 1;
    SELF.ms_giftgivr_Invalid := (le.ScrubsBits3 >> 49) & 1;
    SELF.ms_giftee_Invalid := (le.ScrubsBits3 >> 50) & 1;
    SELF.ms_adult_Invalid := (le.ScrubsBits3 >> 51) & 1;
    SELF.ms_womapp_Invalid := (le.ScrubsBits3 >> 52) & 1;
    SELF.ms_menapp_Invalid := (le.ScrubsBits3 >> 53) & 1;
    SELF.ms_kidapp_Invalid := (le.ScrubsBits3 >> 54) & 1;
    SELF.ms_accessory_Invalid := (le.ScrubsBits3 >> 55) & 1;
    SELF.ms_apparel_Invalid := (le.ScrubsBits3 >> 56) & 1;
    SELF.ms_app_lmos_Invalid := (le.ScrubsBits3 >> 57) & 1;
    SELF.ms_app_omos_Invalid := (le.ScrubsBits3 >> 58) & 1;
    SELF.ms_app_pmos_Invalid := (le.ScrubsBits3 >> 59) & 1;
    SELF.ms_app_totords_Invalid := (le.ScrubsBits3 >> 60) & 1;
    SELF.ms_app_totitems_Invalid := (le.ScrubsBits3 >> 61) & 1;
    SELF.ms_app_totdlrs_Invalid := (le.ScrubsBits3 >> 62) & 1;
    SELF.ms_app_avgdlrs_Invalid := (le.ScrubsBits3 >> 63) & 1;
    SELF.ms_app_lastdlrs_Invalid := (le.ScrubsBits4 >> 0) & 1;
    SELF.ms_app_paystat_paid_Invalid := (le.ScrubsBits4 >> 1) & 1;
    SELF.ms_app_paymeth_cc_Invalid := (le.ScrubsBits4 >> 2) & 1;
    SELF.ms_app_paymeth_cash_Invalid := (le.ScrubsBits4 >> 3) & 1;
    SELF.ms_menfash_Invalid := (le.ScrubsBits4 >> 4) & 1;
    SELF.ms_womfash_Invalid := (le.ScrubsBits4 >> 5) & 1;
    SELF.ms_wfsh_lmos_Invalid := (le.ScrubsBits4 >> 6) & 1;
    SELF.ms_wfsh_omos_Invalid := (le.ScrubsBits4 >> 7) & 1;
    SELF.ms_wfsh_pmos_Invalid := (le.ScrubsBits4 >> 8) & 1;
    SELF.ms_wfsh_totords_Invalid := (le.ScrubsBits4 >> 9) & 1;
    SELF.ms_wfsh_totdlrs_Invalid := (le.ScrubsBits4 >> 10) & 1;
    SELF.ms_wfsh_avgdlrs_Invalid := (le.ScrubsBits4 >> 11) & 1;
    SELF.ms_wfsh_lastdlrs_Invalid := (le.ScrubsBits4 >> 12) & 1;
    SELF.ms_wfsh_paystat_paid_Invalid := (le.ScrubsBits4 >> 13) & 1;
    SELF.ms_wfsh_osrc_dm_Invalid := (le.ScrubsBits4 >> 14) & 1;
    SELF.ms_wfsh_lsrc_dm_Invalid := (le.ScrubsBits4 >> 15) & 1;
    SELF.ms_wfsh_osrc_agt_Invalid := (le.ScrubsBits4 >> 16) & 1;
    SELF.ms_wfsh_lsrc_agt_Invalid := (le.ScrubsBits4 >> 17) & 1;
    SELF.ms_audio_Invalid := (le.ScrubsBits4 >> 18) & 1;
    SELF.ms_auto_Invalid := (le.ScrubsBits4 >> 19) & 1;
    SELF.ms_aviation_Invalid := (le.ScrubsBits4 >> 20) & 1;
    SELF.ms_bargains_Invalid := (le.ScrubsBits4 >> 21) & 1;
    SELF.ms_beauty_Invalid := (le.ScrubsBits4 >> 22) & 1;
    SELF.ms_bible_Invalid := (le.ScrubsBits4 >> 23) & 1;
    SELF.ms_bible_lmos_Invalid := (le.ScrubsBits4 >> 24) & 1;
    SELF.ms_bible_omos_Invalid := (le.ScrubsBits4 >> 25) & 1;
    SELF.ms_bible_pmos_Invalid := (le.ScrubsBits4 >> 26) & 1;
    SELF.ms_bible_totords_Invalid := (le.ScrubsBits4 >> 27) & 1;
    SELF.ms_bible_totitems_Invalid := (le.ScrubsBits4 >> 28) & 1;
    SELF.ms_bible_totdlrs_Invalid := (le.ScrubsBits4 >> 29) & 1;
    SELF.ms_bible_avgdlrs_Invalid := (le.ScrubsBits4 >> 30) & 1;
    SELF.ms_bible_lastdlrs_Invalid := (le.ScrubsBits4 >> 31) & 1;
    SELF.ms_bible_paystat_paid_Invalid := (le.ScrubsBits4 >> 32) & 1;
    SELF.ms_bible_paymeth_cc_Invalid := (le.ScrubsBits4 >> 33) & 1;
    SELF.ms_bible_paymeth_cash_Invalid := (le.ScrubsBits4 >> 34) & 1;
    SELF.ms_business_Invalid := (le.ScrubsBits4 >> 35) & 1;
    SELF.ms_collectibles_Invalid := (le.ScrubsBits4 >> 36) & 1;
    SELF.ms_computers_Invalid := (le.ScrubsBits4 >> 37) & 1;
    SELF.ms_crafts_Invalid := (le.ScrubsBits4 >> 38) & 1;
    SELF.ms_culturearts_Invalid := (le.ScrubsBits4 >> 39) & 1;
    SELF.ms_currevent_Invalid := (le.ScrubsBits4 >> 40) & 1;
    SELF.ms_diy_Invalid := (le.ScrubsBits4 >> 41) & 1;
    SELF.ms_electronics_Invalid := (le.ScrubsBits4 >> 42) & 1;
    SELF.ms_equestrian_Invalid := (le.ScrubsBits4 >> 43) & 1;
    SELF.ms_pub_family_Invalid := (le.ScrubsBits4 >> 44) & 1;
    SELF.ms_cat_family_Invalid := (le.ScrubsBits4 >> 45) & 1;
    SELF.ms_family_Invalid := (le.ScrubsBits4 >> 46) & 1;
    SELF.ms_family_lmos_Invalid := (le.ScrubsBits4 >> 47) & 1;
    SELF.ms_family_omos_Invalid := (le.ScrubsBits4 >> 48) & 1;
    SELF.ms_family_pmos_Invalid := (le.ScrubsBits4 >> 49) & 1;
    SELF.ms_family_totords_Invalid := (le.ScrubsBits4 >> 50) & 1;
    SELF.ms_family_totitems_Invalid := (le.ScrubsBits4 >> 51) & 1;
    SELF.ms_family_totdlrs_Invalid := (le.ScrubsBits4 >> 52) & 1;
    SELF.ms_family_avgdlrs_Invalid := (le.ScrubsBits4 >> 53) & 1;
    SELF.ms_family_lastdlrs_Invalid := (le.ScrubsBits4 >> 54) & 1;
    SELF.ms_family_paystat_paid_Invalid := (le.ScrubsBits4 >> 55) & 1;
    SELF.ms_family_paymeth_cc_Invalid := (le.ScrubsBits4 >> 56) & 1;
    SELF.ms_family_paymeth_cash_Invalid := (le.ScrubsBits4 >> 57) & 1;
    SELF.ms_family_osrc_dm_Invalid := (le.ScrubsBits4 >> 58) & 1;
    SELF.ms_family_lsrc_dm_Invalid := (le.ScrubsBits4 >> 59) & 1;
    SELF.ms_fiction_Invalid := (le.ScrubsBits4 >> 60) & 1;
    SELF.ms_food_Invalid := (le.ScrubsBits4 >> 61) & 1;
    SELF.ms_games_Invalid := (le.ScrubsBits4 >> 62) & 1;
    SELF.ms_gifts_Invalid := (le.ScrubsBits4 >> 63) & 1;
    SELF.ms_gourmet_Invalid := (le.ScrubsBits5 >> 0) & 1;
    SELF.ms_fitness_Invalid := (le.ScrubsBits5 >> 1) & 1;
    SELF.ms_health_Invalid := (le.ScrubsBits5 >> 2) & 1;
    SELF.ms_hlth_lmos_Invalid := (le.ScrubsBits5 >> 3) & 1;
    SELF.ms_hlth_omos_Invalid := (le.ScrubsBits5 >> 4) & 1;
    SELF.ms_hlth_pmos_Invalid := (le.ScrubsBits5 >> 5) & 1;
    SELF.ms_hlth_totords_Invalid := (le.ScrubsBits5 >> 6) & 1;
    SELF.ms_hlth_totdlrs_Invalid := (le.ScrubsBits5 >> 7) & 1;
    SELF.ms_hlth_avgdlrs_Invalid := (le.ScrubsBits5 >> 8) & 1;
    SELF.ms_hlth_lastdlrs_Invalid := (le.ScrubsBits5 >> 9) & 1;
    SELF.ms_hlth_paystat_paid_Invalid := (le.ScrubsBits5 >> 10) & 1;
    SELF.ms_hlth_paymeth_cc_Invalid := (le.ScrubsBits5 >> 11) & 1;
    SELF.ms_hlth_osrc_dm_Invalid := (le.ScrubsBits5 >> 12) & 1;
    SELF.ms_hlth_lsrc_dm_Invalid := (le.ScrubsBits5 >> 13) & 1;
    SELF.ms_hlth_osrc_agt_Invalid := (le.ScrubsBits5 >> 14) & 1;
    SELF.ms_hlth_lsrc_agt_Invalid := (le.ScrubsBits5 >> 15) & 1;
    SELF.ms_hlth_osrc_tv_Invalid := (le.ScrubsBits5 >> 16) & 1;
    SELF.ms_hlth_lsrc_tv_Invalid := (le.ScrubsBits5 >> 17) & 1;
    SELF.ms_holiday_Invalid := (le.ScrubsBits5 >> 18) & 1;
    SELF.ms_history_Invalid := (le.ScrubsBits5 >> 19) & 1;
    SELF.ms_pub_cooking_Invalid := (le.ScrubsBits5 >> 20) & 1;
    SELF.ms_cooking_Invalid := (le.ScrubsBits5 >> 21) & 1;
    SELF.ms_pub_homedecr_Invalid := (le.ScrubsBits5 >> 22) & 1;
    SELF.ms_cat_homedecr_Invalid := (le.ScrubsBits5 >> 23) & 1;
    SELF.ms_homedecr_Invalid := (le.ScrubsBits5 >> 24) & 1;
    SELF.ms_housewares_Invalid := (le.ScrubsBits5 >> 25) & 1;
    SELF.ms_pub_garden_Invalid := (le.ScrubsBits5 >> 26) & 1;
    SELF.ms_cat_garden_Invalid := (le.ScrubsBits5 >> 27) & 1;
    SELF.ms_garden_Invalid := (le.ScrubsBits5 >> 28) & 1;
    SELF.ms_pub_homeliv_Invalid := (le.ScrubsBits5 >> 29) & 1;
    SELF.ms_cat_homeliv_Invalid := (le.ScrubsBits5 >> 30) & 1;
    SELF.ms_homeliv_Invalid := (le.ScrubsBits5 >> 31) & 1;
    SELF.ms_pub_home_status_active_Invalid := (le.ScrubsBits5 >> 32) & 1;
    SELF.ms_home_lmos_Invalid := (le.ScrubsBits5 >> 33) & 1;
    SELF.ms_home_omos_Invalid := (le.ScrubsBits5 >> 34) & 1;
    SELF.ms_home_pmos_Invalid := (le.ScrubsBits5 >> 35) & 1;
    SELF.ms_home_totords_Invalid := (le.ScrubsBits5 >> 36) & 1;
    SELF.ms_home_totitems_Invalid := (le.ScrubsBits5 >> 37) & 1;
    SELF.ms_home_totdlrs_Invalid := (le.ScrubsBits5 >> 38) & 1;
    SELF.ms_home_avgdlrs_Invalid := (le.ScrubsBits5 >> 39) & 1;
    SELF.ms_home_lastdlrs_Invalid := (le.ScrubsBits5 >> 40) & 1;
    SELF.ms_home_paystat_paid_Invalid := (le.ScrubsBits5 >> 41) & 1;
    SELF.ms_home_paymeth_cc_Invalid := (le.ScrubsBits5 >> 42) & 1;
    SELF.ms_home_paymeth_cash_Invalid := (le.ScrubsBits5 >> 43) & 1;
    SELF.ms_home_osrc_dm_Invalid := (le.ScrubsBits5 >> 44) & 1;
    SELF.ms_home_lsrc_dm_Invalid := (le.ScrubsBits5 >> 45) & 1;
    SELF.ms_home_osrc_agt_Invalid := (le.ScrubsBits5 >> 46) & 1;
    SELF.ms_home_lsrc_agt_Invalid := (le.ScrubsBits5 >> 47) & 1;
    SELF.ms_home_osrc_net_Invalid := (le.ScrubsBits5 >> 48) & 1;
    SELF.ms_home_lsrc_net_Invalid := (le.ScrubsBits5 >> 49) & 1;
    SELF.ms_home_osrc_tv_Invalid := (le.ScrubsBits5 >> 50) & 1;
    SELF.ms_home_lsrc_tv_Invalid := (le.ScrubsBits5 >> 51) & 1;
    SELF.ms_humor_Invalid := (le.ScrubsBits5 >> 52) & 1;
    SELF.ms_inspiration_Invalid := (le.ScrubsBits5 >> 53) & 1;
    SELF.ms_merchandise_Invalid := (le.ScrubsBits5 >> 54) & 1;
    SELF.ms_moneymaking_Invalid := (le.ScrubsBits5 >> 55) & 1;
    SELF.ms_moneymaking_lmos_Invalid := (le.ScrubsBits5 >> 56) & 1;
    SELF.ms_motorcycles_Invalid := (le.ScrubsBits5 >> 57) & 1;
    SELF.ms_music_Invalid := (le.ScrubsBits5 >> 58) & 1;
    SELF.ms_fishing_Invalid := (le.ScrubsBits5 >> 59) & 1;
    SELF.ms_hunting_Invalid := (le.ScrubsBits5 >> 60) & 1;
    SELF.ms_boatsail_Invalid := (le.ScrubsBits5 >> 61) & 1;
    SELF.ms_camp_Invalid := (le.ScrubsBits5 >> 62) & 1;
    SELF.ms_pub_outdoors_Invalid := (le.ScrubsBits5 >> 63) & 1;
    SELF.ms_cat_outdoors_Invalid := (le.ScrubsBits6 >> 0) & 1;
    SELF.ms_outdoors_Invalid := (le.ScrubsBits6 >> 1) & 1;
    SELF.ms_pub_out_status_active_Invalid := (le.ScrubsBits6 >> 2) & 1;
    SELF.ms_out_lmos_Invalid := (le.ScrubsBits6 >> 3) & 1;
    SELF.ms_out_omos_Invalid := (le.ScrubsBits6 >> 4) & 1;
    SELF.ms_out_pmos_Invalid := (le.ScrubsBits6 >> 5) & 1;
    SELF.ms_out_totords_Invalid := (le.ScrubsBits6 >> 6) & 1;
    SELF.ms_out_totitems_Invalid := (le.ScrubsBits6 >> 7) & 1;
    SELF.ms_out_totdlrs_Invalid := (le.ScrubsBits6 >> 8) & 1;
    SELF.ms_out_avgdlrs_Invalid := (le.ScrubsBits6 >> 9) & 1;
    SELF.ms_out_lastdlrs_Invalid := (le.ScrubsBits6 >> 10) & 1;
    SELF.ms_out_paystat_paid_Invalid := (le.ScrubsBits6 >> 11) & 1;
    SELF.ms_out_paymeth_cc_Invalid := (le.ScrubsBits6 >> 12) & 1;
    SELF.ms_out_paymeth_cash_Invalid := (le.ScrubsBits6 >> 13) & 1;
    SELF.ms_out_osrc_dm_Invalid := (le.ScrubsBits6 >> 14) & 1;
    SELF.ms_out_lsrc_dm_Invalid := (le.ScrubsBits6 >> 15) & 1;
    SELF.ms_out_osrc_agt_Invalid := (le.ScrubsBits6 >> 16) & 1;
    SELF.ms_out_lsrc_agt_Invalid := (le.ScrubsBits6 >> 17) & 1;
    SELF.ms_pets_Invalid := (le.ScrubsBits6 >> 18) & 1;
    SELF.ms_pfin_Invalid := (le.ScrubsBits6 >> 19) & 1;
    SELF.ms_photo_Invalid := (le.ScrubsBits6 >> 20) & 1;
    SELF.ms_photoproc_Invalid := (le.ScrubsBits6 >> 21) & 1;
    SELF.ms_rural_Invalid := (le.ScrubsBits6 >> 22) & 1;
    SELF.ms_science_Invalid := (le.ScrubsBits6 >> 23) & 1;
    SELF.ms_sports_Invalid := (le.ScrubsBits6 >> 24) & 1;
    SELF.ms_sports_lmos_Invalid := (le.ScrubsBits6 >> 25) & 1;
    SELF.ms_travel_Invalid := (le.ScrubsBits6 >> 26) & 1;
    SELF.ms_tvmovies_Invalid := (le.ScrubsBits6 >> 27) & 1;
    SELF.ms_wildlife_Invalid := (le.ScrubsBits6 >> 28) & 1;
    SELF.ms_woman_Invalid := (le.ScrubsBits6 >> 29) & 1;
    SELF.ms_woman_lmos_Invalid := (le.ScrubsBits6 >> 30) & 1;
    SELF.ms_ringtones_apps_Invalid := (le.ScrubsBits6 >> 31) & 1;
    SELF.cpi_mobile_apps_index_Invalid := (le.ScrubsBits6 >> 32) & 1;
    SELF.cpi_credit_repair_index_Invalid := (le.ScrubsBits6 >> 33) & 1;
    SELF.cpi_credit_report_index_Invalid := (le.ScrubsBits6 >> 34) & 1;
    SELF.cpi_education_seekers_index_Invalid := (le.ScrubsBits6 >> 35) & 1;
    SELF.cpi_insurance_index_Invalid := (le.ScrubsBits6 >> 36) & 1;
    SELF.cpi_insurance_health_index_Invalid := (le.ScrubsBits6 >> 37) & 1;
    SELF.cpi_insurance_auto_index_Invalid := (le.ScrubsBits6 >> 38) & 1;
    SELF.cpi_job_seekers_index_Invalid := (le.ScrubsBits6 >> 39) & 1;
    SELF.cpi_social_networking_index_Invalid := (le.ScrubsBits6 >> 40) & 1;
    SELF.cpi_adult_index_Invalid := (le.ScrubsBits6 >> 41) & 1;
    SELF.cpi_africanamerican_index_Invalid := (le.ScrubsBits6 >> 42) & 1;
    SELF.cpi_apparel_index_Invalid := (le.ScrubsBits6 >> 43) & 1;
    SELF.cpi_apparel_accessory_index_Invalid := (le.ScrubsBits6 >> 44) & 1;
    SELF.cpi_apparel_kids_index_Invalid := (le.ScrubsBits6 >> 45) & 1;
    SELF.cpi_apparel_men_index_Invalid := (le.ScrubsBits6 >> 46) & 1;
    SELF.cpi_apparel_menfash_index_Invalid := (le.ScrubsBits6 >> 47) & 1;
    SELF.cpi_apparel_women_index_Invalid := (le.ScrubsBits6 >> 48) & 1;
    SELF.cpi_apparel_womfash_index_Invalid := (le.ScrubsBits6 >> 49) & 1;
    SELF.cpi_asian_index_Invalid := (le.ScrubsBits6 >> 50) & 1;
    SELF.cpi_auto_index_Invalid := (le.ScrubsBits6 >> 51) & 1;
    SELF.cpi_auto_racing_index_Invalid := (le.ScrubsBits6 >> 52) & 1;
    SELF.cpi_auto_trucks_index_Invalid := (le.ScrubsBits6 >> 53) & 1;
    SELF.cpi_aviation_index_Invalid := (le.ScrubsBits6 >> 54) & 1;
    SELF.cpi_bargains_index_Invalid := (le.ScrubsBits6 >> 55) & 1;
    SELF.cpi_beauty_index_Invalid := (le.ScrubsBits6 >> 56) & 1;
    SELF.cpi_bible_index_Invalid := (le.ScrubsBits6 >> 57) & 1;
    SELF.cpi_birds_index_Invalid := (le.ScrubsBits6 >> 58) & 1;
    SELF.cpi_business_index_Invalid := (le.ScrubsBits6 >> 59) & 1;
    SELF.cpi_business_homeoffice_index_Invalid := (le.ScrubsBits6 >> 60) & 1;
    SELF.cpi_catalog_index_Invalid := (le.ScrubsBits6 >> 61) & 1;
    SELF.cpi_cc_index_Invalid := (le.ScrubsBits6 >> 62) & 1;
    SELF.cpi_collectibles_index_Invalid := (le.ScrubsBits6 >> 63) & 1;
    SELF.cpi_college_index_Invalid := (le.ScrubsBits7 >> 0) & 1;
    SELF.cpi_computers_index_Invalid := (le.ScrubsBits7 >> 1) & 1;
    SELF.cpi_conservative_index_Invalid := (le.ScrubsBits7 >> 2) & 1;
    SELF.cpi_continuity_index_Invalid := (le.ScrubsBits7 >> 3) & 1;
    SELF.cpi_cooking_index_Invalid := (le.ScrubsBits7 >> 4) & 1;
    SELF.cpi_crafts_index_Invalid := (le.ScrubsBits7 >> 5) & 1;
    SELF.cpi_crafts_crochet_index_Invalid := (le.ScrubsBits7 >> 6) & 1;
    SELF.cpi_crafts_knit_index_Invalid := (le.ScrubsBits7 >> 7) & 1;
    SELF.cpi_crafts_needlepoint_index_Invalid := (le.ScrubsBits7 >> 8) & 1;
    SELF.cpi_crafts_quilt_index_Invalid := (le.ScrubsBits7 >> 9) & 1;
    SELF.cpi_crafts_sew_index_Invalid := (le.ScrubsBits7 >> 10) & 1;
    SELF.cpi_culturearts_index_Invalid := (le.ScrubsBits7 >> 11) & 1;
    SELF.cpi_currevent_index_Invalid := (le.ScrubsBits7 >> 12) & 1;
    SELF.cpi_diy_index_Invalid := (le.ScrubsBits7 >> 13) & 1;
    SELF.cpi_donor_index_Invalid := (le.ScrubsBits7 >> 14) & 1;
    SELF.cpi_ego_index_Invalid := (le.ScrubsBits7 >> 15) & 1;
    SELF.cpi_electronics_index_Invalid := (le.ScrubsBits7 >> 16) & 1;
    SELF.cpi_equestrian_index_Invalid := (le.ScrubsBits7 >> 17) & 1;
    SELF.cpi_family_index_Invalid := (le.ScrubsBits7 >> 18) & 1;
    SELF.cpi_family_teen_index_Invalid := (le.ScrubsBits7 >> 19) & 1;
    SELF.cpi_family_young_index_Invalid := (le.ScrubsBits7 >> 20) & 1;
    SELF.cpi_fiction_index_Invalid := (le.ScrubsBits7 >> 21) & 1;
    SELF.cpi_gambling_index_Invalid := (le.ScrubsBits7 >> 22) & 1;
    SELF.cpi_games_index_Invalid := (le.ScrubsBits7 >> 23) & 1;
    SELF.cpi_gardening_index_Invalid := (le.ScrubsBits7 >> 24) & 1;
    SELF.cpi_gay_index_Invalid := (le.ScrubsBits7 >> 25) & 1;
    SELF.cpi_giftgivr_index_Invalid := (le.ScrubsBits7 >> 26) & 1;
    SELF.cpi_gourmet_index_Invalid := (le.ScrubsBits7 >> 27) & 1;
    SELF.cpi_grandparents_index_Invalid := (le.ScrubsBits7 >> 28) & 1;
    SELF.cpi_health_index_Invalid := (le.ScrubsBits7 >> 29) & 1;
    SELF.cpi_health_diet_index_Invalid := (le.ScrubsBits7 >> 30) & 1;
    SELF.cpi_health_fitness_index_Invalid := (le.ScrubsBits7 >> 31) & 1;
    SELF.cpi_hightech_index_Invalid := (le.ScrubsBits7 >> 32) & 1;
    SELF.cpi_hispanic_index_Invalid := (le.ScrubsBits7 >> 33) & 1;
    SELF.cpi_history_index_Invalid := (le.ScrubsBits7 >> 34) & 1;
    SELF.cpi_history_american_index_Invalid := (le.ScrubsBits7 >> 35) & 1;
    SELF.cpi_hobbies_index_Invalid := (le.ScrubsBits7 >> 36) & 1;
    SELF.cpi_homedecr_index_Invalid := (le.ScrubsBits7 >> 37) & 1;
    SELF.cpi_homeliv_index_Invalid := (le.ScrubsBits7 >> 38) & 1;
    SELF.cpi_humor_index_Invalid := (le.ScrubsBits7 >> 39) & 1;
    SELF.cpi_inspiration_index_Invalid := (le.ScrubsBits7 >> 40) & 1;
    SELF.cpi_internet_index_Invalid := (le.ScrubsBits7 >> 41) & 1;
    SELF.cpi_internet_access_index_Invalid := (le.ScrubsBits7 >> 42) & 1;
    SELF.cpi_internet_buy_index_Invalid := (le.ScrubsBits7 >> 43) & 1;
    SELF.cpi_liberal_index_Invalid := (le.ScrubsBits7 >> 44) & 1;
    SELF.cpi_moneymaking_index_Invalid := (le.ScrubsBits7 >> 45) & 1;
    SELF.cpi_motorcycles_index_Invalid := (le.ScrubsBits7 >> 46) & 1;
    SELF.cpi_music_index_Invalid := (le.ScrubsBits7 >> 47) & 1;
    SELF.cpi_nonfiction_index_Invalid := (le.ScrubsBits7 >> 48) & 1;
    SELF.cpi_ocean_index_Invalid := (le.ScrubsBits7 >> 49) & 1;
    SELF.cpi_outdoors_index_Invalid := (le.ScrubsBits7 >> 50) & 1;
    SELF.cpi_outdoors_boatsail_index_Invalid := (le.ScrubsBits7 >> 51) & 1;
    SELF.cpi_outdoors_camp_index_Invalid := (le.ScrubsBits7 >> 52) & 1;
    SELF.cpi_outdoors_fishing_index_Invalid := (le.ScrubsBits7 >> 53) & 1;
    SELF.cpi_outdoors_huntfish_index_Invalid := (le.ScrubsBits7 >> 54) & 1;
    SELF.cpi_outdoors_hunting_index_Invalid := (le.ScrubsBits7 >> 55) & 1;
    SELF.cpi_pets_index_Invalid := (le.ScrubsBits7 >> 56) & 1;
    SELF.cpi_pets_cats_index_Invalid := (le.ScrubsBits7 >> 57) & 1;
    SELF.cpi_pets_dogs_index_Invalid := (le.ScrubsBits7 >> 58) & 1;
    SELF.cpi_pfin_index_Invalid := (le.ScrubsBits7 >> 59) & 1;
    SELF.cpi_photog_index_Invalid := (le.ScrubsBits7 >> 60) & 1;
    SELF.cpi_photoproc_index_Invalid := (le.ScrubsBits7 >> 61) & 1;
    SELF.cpi_publish_index_Invalid := (le.ScrubsBits7 >> 62) & 1;
    SELF.cpi_publish_books_index_Invalid := (le.ScrubsBits7 >> 63) & 1;
    SELF.cpi_publish_mags_index_Invalid := (le.ScrubsBits8 >> 0) & 1;
    SELF.cpi_rural_index_Invalid := (le.ScrubsBits8 >> 1) & 1;
    SELF.cpi_science_index_Invalid := (le.ScrubsBits8 >> 2) & 1;
    SELF.cpi_scifi_index_Invalid := (le.ScrubsBits8 >> 3) & 1;
    SELF.cpi_seniors_index_Invalid := (le.ScrubsBits8 >> 4) & 1;
    SELF.cpi_sports_index_Invalid := (le.ScrubsBits8 >> 5) & 1;
    SELF.cpi_sports_baseball_index_Invalid := (le.ScrubsBits8 >> 6) & 1;
    SELF.cpi_sports_basketball_index_Invalid := (le.ScrubsBits8 >> 7) & 1;
    SELF.cpi_sports_biking_index_Invalid := (le.ScrubsBits8 >> 8) & 1;
    SELF.cpi_sports_football_index_Invalid := (le.ScrubsBits8 >> 9) & 1;
    SELF.cpi_sports_golf_index_Invalid := (le.ScrubsBits8 >> 10) & 1;
    SELF.cpi_sports_hockey_index_Invalid := (le.ScrubsBits8 >> 11) & 1;
    SELF.cpi_sports_running_index_Invalid := (le.ScrubsBits8 >> 12) & 1;
    SELF.cpi_sports_ski_index_Invalid := (le.ScrubsBits8 >> 13) & 1;
    SELF.cpi_sports_soccer_index_Invalid := (le.ScrubsBits8 >> 14) & 1;
    SELF.cpi_sports_swimming_index_Invalid := (le.ScrubsBits8 >> 15) & 1;
    SELF.cpi_sports_tennis_index_Invalid := (le.ScrubsBits8 >> 16) & 1;
    SELF.cpi_stationery_index_Invalid := (le.ScrubsBits8 >> 17) & 1;
    SELF.cpi_sweeps_index_Invalid := (le.ScrubsBits8 >> 18) & 1;
    SELF.cpi_tobacco_index_Invalid := (le.ScrubsBits8 >> 19) & 1;
    SELF.cpi_travel_index_Invalid := (le.ScrubsBits8 >> 20) & 1;
    SELF.cpi_travel_cruise_index_Invalid := (le.ScrubsBits8 >> 21) & 1;
    SELF.cpi_travel_rv_index_Invalid := (le.ScrubsBits8 >> 22) & 1;
    SELF.cpi_travel_us_index_Invalid := (le.ScrubsBits8 >> 23) & 1;
    SELF.cpi_tvmovies_index_Invalid := (le.ScrubsBits8 >> 24) & 1;
    SELF.cpi_wildlife_index_Invalid := (le.ScrubsBits8 >> 25) & 1;
    SELF.cpi_woman_index_Invalid := (le.ScrubsBits8 >> 26) & 1;
    SELF.totdlr_index_Invalid := (le.ScrubsBits8 >> 27) & 1;
    SELF.cpi_totdlr_Invalid := (le.ScrubsBits8 >> 28) & 1;
    SELF.cpi_totords_Invalid := (le.ScrubsBits8 >> 29) & 1;
    SELF.cpi_lastdlr_Invalid := (le.ScrubsBits8 >> 30) & 1;
    SELF.pkcatg_Invalid := (le.ScrubsBits8 >> 31) & 1;
    SELF.pkpubs_Invalid := (le.ScrubsBits8 >> 32) & 1;
    SELF.pkcont_Invalid := (le.ScrubsBits8 >> 33) & 1;
    SELF.pkca01_Invalid := (le.ScrubsBits8 >> 34) & 1;
    SELF.pkca03_Invalid := (le.ScrubsBits8 >> 35) & 1;
    SELF.pkca04_Invalid := (le.ScrubsBits8 >> 36) & 1;
    SELF.pkca05_Invalid := (le.ScrubsBits8 >> 37) & 1;
    SELF.pkca06_Invalid := (le.ScrubsBits8 >> 38) & 1;
    SELF.pkca07_Invalid := (le.ScrubsBits8 >> 39) & 1;
    SELF.pkca08_Invalid := (le.ScrubsBits8 >> 40) & 1;
    SELF.pkca09_Invalid := (le.ScrubsBits8 >> 41) & 1;
    SELF.pkca10_Invalid := (le.ScrubsBits8 >> 42) & 1;
    SELF.pkca11_Invalid := (le.ScrubsBits8 >> 43) & 1;
    SELF.pkca12_Invalid := (le.ScrubsBits8 >> 44) & 1;
    SELF.pkca13_Invalid := (le.ScrubsBits8 >> 45) & 1;
    SELF.pkca14_Invalid := (le.ScrubsBits8 >> 46) & 1;
    SELF.pkca15_Invalid := (le.ScrubsBits8 >> 47) & 1;
    SELF.pkca16_Invalid := (le.ScrubsBits8 >> 48) & 1;
    SELF.pkca17_Invalid := (le.ScrubsBits8 >> 49) & 1;
    SELF.pkca18_Invalid := (le.ScrubsBits8 >> 50) & 1;
    SELF.pkca20_Invalid := (le.ScrubsBits8 >> 51) & 1;
    SELF.pkca21_Invalid := (le.ScrubsBits8 >> 52) & 1;
    SELF.pkca22_Invalid := (le.ScrubsBits8 >> 53) & 1;
    SELF.pkca23_Invalid := (le.ScrubsBits8 >> 54) & 1;
    SELF.pkca24_Invalid := (le.ScrubsBits8 >> 55) & 1;
    SELF.pkca25_Invalid := (le.ScrubsBits8 >> 56) & 1;
    SELF.pkca26_Invalid := (le.ScrubsBits8 >> 57) & 1;
    SELF.pkca28_Invalid := (le.ScrubsBits8 >> 58) & 1;
    SELF.pkca29_Invalid := (le.ScrubsBits8 >> 59) & 1;
    SELF.pkca30_Invalid := (le.ScrubsBits8 >> 60) & 1;
    SELF.pkca31_Invalid := (le.ScrubsBits8 >> 61) & 1;
    SELF.pkca32_Invalid := (le.ScrubsBits8 >> 62) & 1;
    SELF.pkca33_Invalid := (le.ScrubsBits8 >> 63) & 1;
    SELF.pkca34_Invalid := (le.ScrubsBits9 >> 0) & 1;
    SELF.pkca35_Invalid := (le.ScrubsBits9 >> 1) & 1;
    SELF.pkca36_Invalid := (le.ScrubsBits9 >> 2) & 1;
    SELF.pkca37_Invalid := (le.ScrubsBits9 >> 3) & 1;
    SELF.pkca39_Invalid := (le.ScrubsBits9 >> 4) & 1;
    SELF.pkca40_Invalid := (le.ScrubsBits9 >> 5) & 1;
    SELF.pkca41_Invalid := (le.ScrubsBits9 >> 6) & 1;
    SELF.pkca42_Invalid := (le.ScrubsBits9 >> 7) & 1;
    SELF.pkca54_Invalid := (le.ScrubsBits9 >> 8) & 1;
    SELF.pkca61_Invalid := (le.ScrubsBits9 >> 9) & 1;
    SELF.pkca62_Invalid := (le.ScrubsBits9 >> 10) & 1;
    SELF.pkca64_Invalid := (le.ScrubsBits9 >> 11) & 1;
    SELF.pkpu01_Invalid := (le.ScrubsBits9 >> 12) & 1;
    SELF.pkpu02_Invalid := (le.ScrubsBits9 >> 13) & 1;
    SELF.pkpu03_Invalid := (le.ScrubsBits9 >> 14) & 1;
    SELF.pkpu04_Invalid := (le.ScrubsBits9 >> 15) & 1;
    SELF.pkpu05_Invalid := (le.ScrubsBits9 >> 16) & 1;
    SELF.pkpu06_Invalid := (le.ScrubsBits9 >> 17) & 1;
    SELF.pkpu07_Invalid := (le.ScrubsBits9 >> 18) & 1;
    SELF.pkpu08_Invalid := (le.ScrubsBits9 >> 19) & 1;
    SELF.pkpu09_Invalid := (le.ScrubsBits9 >> 20) & 1;
    SELF.pkpu10_Invalid := (le.ScrubsBits9 >> 21) & 1;
    SELF.pkpu11_Invalid := (le.ScrubsBits9 >> 22) & 1;
    SELF.pkpu12_Invalid := (le.ScrubsBits9 >> 23) & 1;
    SELF.pkpu13_Invalid := (le.ScrubsBits9 >> 24) & 1;
    SELF.pkpu14_Invalid := (le.ScrubsBits9 >> 25) & 1;
    SELF.pkpu15_Invalid := (le.ScrubsBits9 >> 26) & 1;
    SELF.pkpu16_Invalid := (le.ScrubsBits9 >> 27) & 1;
    SELF.pkpu17_Invalid := (le.ScrubsBits9 >> 28) & 1;
    SELF.pkpu18_Invalid := (le.ScrubsBits9 >> 29) & 1;
    SELF.pkpu19_Invalid := (le.ScrubsBits9 >> 30) & 1;
    SELF.pkpu20_Invalid := (le.ScrubsBits9 >> 31) & 1;
    SELF.pkpu23_Invalid := (le.ScrubsBits9 >> 32) & 1;
    SELF.pkpu25_Invalid := (le.ScrubsBits9 >> 33) & 1;
    SELF.pkpu27_Invalid := (le.ScrubsBits9 >> 34) & 1;
    SELF.pkpu28_Invalid := (le.ScrubsBits9 >> 35) & 1;
    SELF.pkpu29_Invalid := (le.ScrubsBits9 >> 36) & 1;
    SELF.pkpu30_Invalid := (le.ScrubsBits9 >> 37) & 1;
    SELF.pkpu31_Invalid := (le.ScrubsBits9 >> 38) & 1;
    SELF.pkpu32_Invalid := (le.ScrubsBits9 >> 39) & 1;
    SELF.pkpu33_Invalid := (le.ScrubsBits9 >> 40) & 1;
    SELF.pkpu34_Invalid := (le.ScrubsBits9 >> 41) & 1;
    SELF.pkpu35_Invalid := (le.ScrubsBits9 >> 42) & 1;
    SELF.pkpu38_Invalid := (le.ScrubsBits9 >> 43) & 1;
    SELF.pkpu41_Invalid := (le.ScrubsBits9 >> 44) & 1;
    SELF.pkpu42_Invalid := (le.ScrubsBits9 >> 45) & 1;
    SELF.pkpu45_Invalid := (le.ScrubsBits9 >> 46) & 1;
    SELF.pkpu46_Invalid := (le.ScrubsBits9 >> 47) & 1;
    SELF.pkpu47_Invalid := (le.ScrubsBits9 >> 48) & 1;
    SELF.pkpu48_Invalid := (le.ScrubsBits9 >> 49) & 1;
    SELF.pkpu49_Invalid := (le.ScrubsBits9 >> 50) & 1;
    SELF.pkpu50_Invalid := (le.ScrubsBits9 >> 51) & 1;
    SELF.pkpu51_Invalid := (le.ScrubsBits9 >> 52) & 1;
    SELF.pkpu52_Invalid := (le.ScrubsBits9 >> 53) & 1;
    SELF.pkpu53_Invalid := (le.ScrubsBits9 >> 54) & 1;
    SELF.pkpu54_Invalid := (le.ScrubsBits9 >> 55) & 1;
    SELF.pkpu55_Invalid := (le.ScrubsBits9 >> 56) & 1;
    SELF.pkpu56_Invalid := (le.ScrubsBits9 >> 57) & 1;
    SELF.pkpu57_Invalid := (le.ScrubsBits9 >> 58) & 1;
    SELF.pkpu60_Invalid := (le.ScrubsBits9 >> 59) & 1;
    SELF.pkpu61_Invalid := (le.ScrubsBits9 >> 60) & 1;
    SELF.pkpu62_Invalid := (le.ScrubsBits9 >> 61) & 1;
    SELF.pkpu63_Invalid := (le.ScrubsBits9 >> 62) & 1;
    SELF.pkpu64_Invalid := (le.ScrubsBits9 >> 63) & 1;
    SELF.pkpu65_Invalid := (le.ScrubsBits10 >> 0) & 1;
    SELF.pkpu66_Invalid := (le.ScrubsBits10 >> 1) & 1;
    SELF.pkpu67_Invalid := (le.ScrubsBits10 >> 2) & 1;
    SELF.pkpu68_Invalid := (le.ScrubsBits10 >> 3) & 1;
    SELF.pkpu69_Invalid := (le.ScrubsBits10 >> 4) & 1;
    SELF.pkpu70_Invalid := (le.ScrubsBits10 >> 5) & 1;
    SELF.censpct_water_Invalid := (le.ScrubsBits10 >> 6) & 1;
    SELF.cens_pop_density_Invalid := (le.ScrubsBits10 >> 7) & 1;
    SELF.cens_hu_density_Invalid := (le.ScrubsBits10 >> 8) & 1;
    SELF.censpct_pop_white_Invalid := (le.ScrubsBits10 >> 9) & 1;
    SELF.censpct_pop_black_Invalid := (le.ScrubsBits10 >> 10) & 1;
    SELF.censpct_pop_amerind_Invalid := (le.ScrubsBits10 >> 11) & 1;
    SELF.censpct_pop_asian_Invalid := (le.ScrubsBits10 >> 12) & 1;
    SELF.censpct_pop_pacisl_Invalid := (le.ScrubsBits10 >> 13) & 1;
    SELF.censpct_pop_othrace_Invalid := (le.ScrubsBits10 >> 14) & 1;
    SELF.censpct_pop_multirace_Invalid := (le.ScrubsBits10 >> 15) & 1;
    SELF.censpct_pop_hispanic_Invalid := (le.ScrubsBits10 >> 16) & 1;
    SELF.censpct_pop_agelt18_Invalid := (le.ScrubsBits10 >> 17) & 1;
    SELF.censpct_pop_males_Invalid := (le.ScrubsBits10 >> 18) & 1;
    SELF.censpct_adult_age1824_Invalid := (le.ScrubsBits10 >> 19) & 1;
    SELF.censpct_adult_age2534_Invalid := (le.ScrubsBits10 >> 20) & 1;
    SELF.censpct_adult_age3544_Invalid := (le.ScrubsBits10 >> 21) & 1;
    SELF.censpct_adult_age4554_Invalid := (le.ScrubsBits10 >> 22) & 1;
    SELF.censpct_adult_age5564_Invalid := (le.ScrubsBits10 >> 23) & 1;
    SELF.censpct_adult_agege65_Invalid := (le.ScrubsBits10 >> 24) & 1;
    SELF.cens_pop_medage_Invalid := (le.ScrubsBits10 >> 25) & 1;
    SELF.cens_hh_avgsize_Invalid := (le.ScrubsBits10 >> 26) & 1;
    SELF.censpct_hh_family_Invalid := (le.ScrubsBits10 >> 27) & 1;
    SELF.censpct_hh_family_husbwife_Invalid := (le.ScrubsBits10 >> 28) & 1;
    SELF.censpct_hu_occupied_Invalid := (le.ScrubsBits10 >> 29) & 1;
    SELF.censpct_hu_owned_Invalid := (le.ScrubsBits10 >> 30) & 1;
    SELF.censpct_hu_rented_Invalid := (le.ScrubsBits10 >> 31) & 1;
    SELF.censpct_hu_vacantseasonal_Invalid := (le.ScrubsBits10 >> 32) & 1;
    SELF.zip_medinc_Invalid := (le.ScrubsBits10 >> 33) & 1;
    SELF.zip_apparel_Invalid := (le.ScrubsBits10 >> 34) & 1;
    SELF.zip_apparel_women_Invalid := (le.ScrubsBits10 >> 35) & 1;
    SELF.zip_apparel_womfash_Invalid := (le.ScrubsBits10 >> 36) & 1;
    SELF.zip_auto_Invalid := (le.ScrubsBits10 >> 37) & 1;
    SELF.zip_beauty_Invalid := (le.ScrubsBits10 >> 38) & 1;
    SELF.zip_booksmusicmovies_Invalid := (le.ScrubsBits10 >> 39) & 1;
    SELF.zip_business_Invalid := (le.ScrubsBits10 >> 40) & 1;
    SELF.zip_catalog_Invalid := (le.ScrubsBits10 >> 41) & 1;
    SELF.zip_cc_Invalid := (le.ScrubsBits10 >> 42) & 1;
    SELF.zip_collectibles_Invalid := (le.ScrubsBits10 >> 43) & 1;
    SELF.zip_computers_Invalid := (le.ScrubsBits10 >> 44) & 1;
    SELF.zip_continuity_Invalid := (le.ScrubsBits10 >> 45) & 1;
    SELF.zip_cooking_Invalid := (le.ScrubsBits10 >> 46) & 1;
    SELF.zip_crafts_Invalid := (le.ScrubsBits10 >> 47) & 1;
    SELF.zip_culturearts_Invalid := (le.ScrubsBits10 >> 48) & 1;
    SELF.zip_dm_sold_Invalid := (le.ScrubsBits10 >> 49) & 1;
    SELF.zip_donor_Invalid := (le.ScrubsBits10 >> 50) & 1;
    SELF.zip_family_Invalid := (le.ScrubsBits10 >> 51) & 1;
    SELF.zip_gardening_Invalid := (le.ScrubsBits10 >> 52) & 1;
    SELF.zip_giftgivr_Invalid := (le.ScrubsBits10 >> 53) & 1;
    SELF.zip_gourmet_Invalid := (le.ScrubsBits10 >> 54) & 1;
    SELF.zip_health_Invalid := (le.ScrubsBits10 >> 55) & 1;
    SELF.zip_health_diet_Invalid := (le.ScrubsBits10 >> 56) & 1;
    SELF.zip_health_fitness_Invalid := (le.ScrubsBits10 >> 57) & 1;
    SELF.zip_hobbies_Invalid := (le.ScrubsBits10 >> 58) & 1;
    SELF.zip_homedecr_Invalid := (le.ScrubsBits10 >> 59) & 1;
    SELF.zip_homeliv_Invalid := (le.ScrubsBits10 >> 60) & 1;
    SELF.zip_internet_Invalid := (le.ScrubsBits10 >> 61) & 1;
    SELF.zip_internet_access_Invalid := (le.ScrubsBits10 >> 62) & 1;
    SELF.zip_internet_buy_Invalid := (le.ScrubsBits10 >> 63) & 1;
    SELF.zip_music_Invalid := (le.ScrubsBits11 >> 0) & 1;
    SELF.zip_outdoors_Invalid := (le.ScrubsBits11 >> 1) & 1;
    SELF.zip_pets_Invalid := (le.ScrubsBits11 >> 2) & 1;
    SELF.zip_pfin_Invalid := (le.ScrubsBits11 >> 3) & 1;
    SELF.zip_publish_Invalid := (le.ScrubsBits11 >> 4) & 1;
    SELF.zip_publish_books_Invalid := (le.ScrubsBits11 >> 5) & 1;
    SELF.zip_publish_mags_Invalid := (le.ScrubsBits11 >> 6) & 1;
    SELF.zip_sports_Invalid := (le.ScrubsBits11 >> 7) & 1;
    SELF.zip_sports_biking_Invalid := (le.ScrubsBits11 >> 8) & 1;
    SELF.zip_sports_golf_Invalid := (le.ScrubsBits11 >> 9) & 1;
    SELF.zip_travel_Invalid := (le.ScrubsBits11 >> 10) & 1;
    SELF.zip_travel_us_Invalid := (le.ScrubsBits11 >> 11) & 1;
    SELF.zip_tvmovies_Invalid := (le.ScrubsBits11 >> 12) & 1;
    SELF.zip_woman_Invalid := (le.ScrubsBits11 >> 13) & 1;
    SELF.zip_proftech_Invalid := (le.ScrubsBits11 >> 14) & 1;
    SELF.zip_retired_Invalid := (le.ScrubsBits11 >> 15) & 1;
    SELF.zip_inc100_Invalid := (le.ScrubsBits11 >> 16) & 1;
    SELF.zip_inc75_Invalid := (le.ScrubsBits11 >> 17) & 1;
    SELF.zip_inc50_Invalid := (le.ScrubsBits11 >> 18) & 1;
    SELF.dtmatch_wouldClean := le.ScrubsCleanBits1 >> 0;
    SELF.msname_wouldClean := le.ScrubsCleanBits1 >> 1;
    SELF.msaddr1_wouldClean := le.ScrubsCleanBits1 >> 2;
    SELF.msaddr2_wouldClean := le.ScrubsCleanBits1 >> 3;
    SELF.mscity_wouldClean := le.ScrubsCleanBits1 >> 4;
    SELF.msstate_wouldClean := le.ScrubsCleanBits1 >> 5;
    SELF.mszip5_wouldClean := le.ScrubsCleanBits1 >> 6;
    SELF.mszip4_wouldClean := le.ScrubsCleanBits1 >> 7;
    SELF.dthh_wouldClean := le.ScrubsCleanBits1 >> 8;
    SELF.mscrrt_wouldClean := le.ScrubsCleanBits1 >> 9;
    SELF.msdpbc_wouldClean := le.ScrubsCleanBits1 >> 10;
    SELF.msdpv_wouldClean := le.ScrubsCleanBits1 >> 11;
    SELF.ms_addrtype_wouldClean := le.ScrubsCleanBits1 >> 12;
    SELF.ctysize_wouldClean := le.ScrubsCleanBits1 >> 13;
    SELF.noc_wouldClean := le.ScrubsCleanBits1 >> 14;
    SELF.lang_wouldClean := le.ScrubsCleanBits1 >> 15;
    SELF.eth1_wouldClean := le.ScrubsCleanBits1 >> 16;
    SELF.eth2_wouldClean := le.ScrubsCleanBits1 >> 17;
    SELF.lor_wouldClean := le.ScrubsCleanBits1 >> 18;
    SELF.pool_wouldClean := le.ScrubsCleanBits1 >> 19;
    SELF.speak_span_wouldClean := le.ScrubsCleanBits1 >> 20;
    SELF.soho_wouldClean := le.ScrubsCleanBits1 >> 21;
    SELF.vet_in_hh_wouldClean := le.ScrubsCleanBits1 >> 22;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    dtmatch_ALLOW_ErrorCount := COUNT(GROUP,h.dtmatch_Invalid=1);
    dtmatch_ALLOW_WouldModifyCount := COUNT(GROUP,h.dtmatch_Invalid=1 AND h.dtmatch_wouldClean);
    dtmatch_LENGTHS_ErrorCount := COUNT(GROUP,h.dtmatch_Invalid=2);
    dtmatch_LENGTHS_WouldModifyCount := COUNT(GROUP,h.dtmatch_Invalid=2 AND h.dtmatch_wouldClean);
    dtmatch_Total_ErrorCount := COUNT(GROUP,h.dtmatch_Invalid>0);
    msname_ALLOW_ErrorCount := COUNT(GROUP,h.msname_Invalid=1);
    msname_ALLOW_WouldModifyCount := COUNT(GROUP,h.msname_Invalid=1 AND h.msname_wouldClean);
    msaddr1_ALLOW_ErrorCount := COUNT(GROUP,h.msaddr1_Invalid=1);
    msaddr1_ALLOW_WouldModifyCount := COUNT(GROUP,h.msaddr1_Invalid=1 AND h.msaddr1_wouldClean);
    msaddr2_ALLOW_ErrorCount := COUNT(GROUP,h.msaddr2_Invalid=1);
    msaddr2_ALLOW_WouldModifyCount := COUNT(GROUP,h.msaddr2_Invalid=1 AND h.msaddr2_wouldClean);
    mscity_ALLOW_ErrorCount := COUNT(GROUP,h.mscity_Invalid=1);
    mscity_ALLOW_WouldModifyCount := COUNT(GROUP,h.mscity_Invalid=1 AND h.mscity_wouldClean);
    mscity_LENGTHS_ErrorCount := COUNT(GROUP,h.mscity_Invalid=2);
    mscity_LENGTHS_WouldModifyCount := COUNT(GROUP,h.mscity_Invalid=2 AND h.mscity_wouldClean);
    mscity_Total_ErrorCount := COUNT(GROUP,h.mscity_Invalid>0);
    msstate_ALLOW_ErrorCount := COUNT(GROUP,h.msstate_Invalid=1);
    msstate_ALLOW_WouldModifyCount := COUNT(GROUP,h.msstate_Invalid=1 AND h.msstate_wouldClean);
    msstate_LENGTHS_ErrorCount := COUNT(GROUP,h.msstate_Invalid=2);
    msstate_LENGTHS_WouldModifyCount := COUNT(GROUP,h.msstate_Invalid=2 AND h.msstate_wouldClean);
    msstate_WORDS_ErrorCount := COUNT(GROUP,h.msstate_Invalid=3);
    msstate_WORDS_WouldModifyCount := COUNT(GROUP,h.msstate_Invalid=3 AND h.msstate_wouldClean);
    msstate_Total_ErrorCount := COUNT(GROUP,h.msstate_Invalid>0);
    mszip5_ALLOW_ErrorCount := COUNT(GROUP,h.mszip5_Invalid=1);
    mszip5_ALLOW_WouldModifyCount := COUNT(GROUP,h.mszip5_Invalid=1 AND h.mszip5_wouldClean);
    mszip5_LENGTHS_ErrorCount := COUNT(GROUP,h.mszip5_Invalid=2);
    mszip5_LENGTHS_WouldModifyCount := COUNT(GROUP,h.mszip5_Invalid=2 AND h.mszip5_wouldClean);
    mszip5_Total_ErrorCount := COUNT(GROUP,h.mszip5_Invalid>0);
    mszip4_ALLOW_ErrorCount := COUNT(GROUP,h.mszip4_Invalid=1);
    mszip4_ALLOW_WouldModifyCount := COUNT(GROUP,h.mszip4_Invalid=1 AND h.mszip4_wouldClean);
    mszip4_LENGTHS_ErrorCount := COUNT(GROUP,h.mszip4_Invalid=2);
    mszip4_LENGTHS_WouldModifyCount := COUNT(GROUP,h.mszip4_Invalid=2 AND h.mszip4_wouldClean);
    mszip4_Total_ErrorCount := COUNT(GROUP,h.mszip4_Invalid>0);
    dthh_ALLOW_ErrorCount := COUNT(GROUP,h.dthh_Invalid=1);
    dthh_ALLOW_WouldModifyCount := COUNT(GROUP,h.dthh_Invalid=1 AND h.dthh_wouldClean);
    dthh_LENGTHS_ErrorCount := COUNT(GROUP,h.dthh_Invalid=2);
    dthh_LENGTHS_WouldModifyCount := COUNT(GROUP,h.dthh_Invalid=2 AND h.dthh_wouldClean);
    dthh_Total_ErrorCount := COUNT(GROUP,h.dthh_Invalid>0);
    mscrrt_ALLOW_ErrorCount := COUNT(GROUP,h.mscrrt_Invalid=1);
    mscrrt_ALLOW_WouldModifyCount := COUNT(GROUP,h.mscrrt_Invalid=1 AND h.mscrrt_wouldClean);
    mscrrt_LENGTHS_ErrorCount := COUNT(GROUP,h.mscrrt_Invalid=2);
    mscrrt_LENGTHS_WouldModifyCount := COUNT(GROUP,h.mscrrt_Invalid=2 AND h.mscrrt_wouldClean);
    mscrrt_Total_ErrorCount := COUNT(GROUP,h.mscrrt_Invalid>0);
    msdpbc_ALLOW_ErrorCount := COUNT(GROUP,h.msdpbc_Invalid=1);
    msdpbc_ALLOW_WouldModifyCount := COUNT(GROUP,h.msdpbc_Invalid=1 AND h.msdpbc_wouldClean);
    msdpbc_LENGTHS_ErrorCount := COUNT(GROUP,h.msdpbc_Invalid=2);
    msdpbc_LENGTHS_WouldModifyCount := COUNT(GROUP,h.msdpbc_Invalid=2 AND h.msdpbc_wouldClean);
    msdpbc_Total_ErrorCount := COUNT(GROUP,h.msdpbc_Invalid>0);
    msdpv_ALLOW_ErrorCount := COUNT(GROUP,h.msdpv_Invalid=1);
    msdpv_ALLOW_WouldModifyCount := COUNT(GROUP,h.msdpv_Invalid=1 AND h.msdpv_wouldClean);
    msdpv_LENGTHS_ErrorCount := COUNT(GROUP,h.msdpv_Invalid=2);
    msdpv_LENGTHS_WouldModifyCount := COUNT(GROUP,h.msdpv_Invalid=2 AND h.msdpv_wouldClean);
    msdpv_Total_ErrorCount := COUNT(GROUP,h.msdpv_Invalid>0);
    ms_addrtype_ALLOW_ErrorCount := COUNT(GROUP,h.ms_addrtype_Invalid=1);
    ms_addrtype_ALLOW_WouldModifyCount := COUNT(GROUP,h.ms_addrtype_Invalid=1 AND h.ms_addrtype_wouldClean);
    ms_addrtype_LENGTHS_ErrorCount := COUNT(GROUP,h.ms_addrtype_Invalid=2);
    ms_addrtype_LENGTHS_WouldModifyCount := COUNT(GROUP,h.ms_addrtype_Invalid=2 AND h.ms_addrtype_wouldClean);
    ms_addrtype_Total_ErrorCount := COUNT(GROUP,h.ms_addrtype_Invalid>0);
    ctysize_ALLOW_ErrorCount := COUNT(GROUP,h.ctysize_Invalid=1);
    ctysize_ALLOW_WouldModifyCount := COUNT(GROUP,h.ctysize_Invalid=1 AND h.ctysize_wouldClean);
    ctysize_LENGTHS_ErrorCount := COUNT(GROUP,h.ctysize_Invalid=2);
    ctysize_LENGTHS_WouldModifyCount := COUNT(GROUP,h.ctysize_Invalid=2 AND h.ctysize_wouldClean);
    ctysize_Total_ErrorCount := COUNT(GROUP,h.ctysize_Invalid>0);
    lmos_ALLOW_ErrorCount := COUNT(GROUP,h.lmos_Invalid=1);
    omos_ALLOW_ErrorCount := COUNT(GROUP,h.omos_Invalid=1);
    pmos_ALLOW_ErrorCount := COUNT(GROUP,h.pmos_Invalid=1);
    gen_ENUM_ErrorCount := COUNT(GROUP,h.gen_Invalid=1);
    gen_LENGTHS_ErrorCount := COUNT(GROUP,h.gen_Invalid=2);
    gen_Total_ErrorCount := COUNT(GROUP,h.gen_Invalid>0);
    dob_CUSTOM_ErrorCount := COUNT(GROUP,h.dob_Invalid=1);
    age_ALLOW_ErrorCount := COUNT(GROUP,h.age_Invalid=1);
    inc_ENUM_ErrorCount := COUNT(GROUP,h.inc_Invalid=1);
    inc_LENGTHS_ErrorCount := COUNT(GROUP,h.inc_Invalid=2);
    inc_Total_ErrorCount := COUNT(GROUP,h.inc_Invalid>0);
    marital_status_ALLOW_ErrorCount := COUNT(GROUP,h.marital_status_Invalid=1);
    poc_ALLOW_ErrorCount := COUNT(GROUP,h.poc_Invalid=1);
    noc_ALLOW_ErrorCount := COUNT(GROUP,h.noc_Invalid=1);
    noc_ALLOW_WouldModifyCount := COUNT(GROUP,h.noc_Invalid=1 AND h.noc_wouldClean);
    noc_LENGTHS_ErrorCount := COUNT(GROUP,h.noc_Invalid=2);
    noc_LENGTHS_WouldModifyCount := COUNT(GROUP,h.noc_Invalid=2 AND h.noc_wouldClean);
    noc_Total_ErrorCount := COUNT(GROUP,h.noc_Invalid>0);
    ocp_ENUM_ErrorCount := COUNT(GROUP,h.ocp_Invalid=1);
    ocp_LENGTHS_ErrorCount := COUNT(GROUP,h.ocp_Invalid=2);
    ocp_Total_ErrorCount := COUNT(GROUP,h.ocp_Invalid>0);
    edu_ENUM_ErrorCount := COUNT(GROUP,h.edu_Invalid=1);
    edu_LENGTHS_ErrorCount := COUNT(GROUP,h.edu_Invalid=2);
    edu_Total_ErrorCount := COUNT(GROUP,h.edu_Invalid>0);
    lang_ALLOW_ErrorCount := COUNT(GROUP,h.lang_Invalid=1);
    lang_ALLOW_WouldModifyCount := COUNT(GROUP,h.lang_Invalid=1 AND h.lang_wouldClean);
    lang_LENGTHS_ErrorCount := COUNT(GROUP,h.lang_Invalid=2);
    lang_LENGTHS_WouldModifyCount := COUNT(GROUP,h.lang_Invalid=2 AND h.lang_wouldClean);
    lang_Total_ErrorCount := COUNT(GROUP,h.lang_Invalid>0);
    relig_ENUM_ErrorCount := COUNT(GROUP,h.relig_Invalid=1);
    relig_LENGTHS_ErrorCount := COUNT(GROUP,h.relig_Invalid=2);
    relig_Total_ErrorCount := COUNT(GROUP,h.relig_Invalid>0);
    dwell_ENUM_ErrorCount := COUNT(GROUP,h.dwell_Invalid=1);
    dwell_LENGTHS_ErrorCount := COUNT(GROUP,h.dwell_Invalid=2);
    dwell_Total_ErrorCount := COUNT(GROUP,h.dwell_Invalid>0);
    ownr_ALLOW_ErrorCount := COUNT(GROUP,h.ownr_Invalid=1);
    eth1_ALLOW_ErrorCount := COUNT(GROUP,h.eth1_Invalid=1);
    eth1_ALLOW_WouldModifyCount := COUNT(GROUP,h.eth1_Invalid=1 AND h.eth1_wouldClean);
    eth1_LENGTHS_ErrorCount := COUNT(GROUP,h.eth1_Invalid=2);
    eth1_LENGTHS_WouldModifyCount := COUNT(GROUP,h.eth1_Invalid=2 AND h.eth1_wouldClean);
    eth1_Total_ErrorCount := COUNT(GROUP,h.eth1_Invalid>0);
    eth2_ALLOW_ErrorCount := COUNT(GROUP,h.eth2_Invalid=1);
    eth2_ALLOW_WouldModifyCount := COUNT(GROUP,h.eth2_Invalid=1 AND h.eth2_wouldClean);
    eth2_LENGTHS_ErrorCount := COUNT(GROUP,h.eth2_Invalid=2);
    eth2_LENGTHS_WouldModifyCount := COUNT(GROUP,h.eth2_Invalid=2 AND h.eth2_wouldClean);
    eth2_Total_ErrorCount := COUNT(GROUP,h.eth2_Invalid>0);
    lor_ALLOW_ErrorCount := COUNT(GROUP,h.lor_Invalid=1);
    lor_ALLOW_WouldModifyCount := COUNT(GROUP,h.lor_Invalid=1 AND h.lor_wouldClean);
    lor_LENGTHS_ErrorCount := COUNT(GROUP,h.lor_Invalid=2);
    lor_LENGTHS_WouldModifyCount := COUNT(GROUP,h.lor_Invalid=2 AND h.lor_wouldClean);
    lor_Total_ErrorCount := COUNT(GROUP,h.lor_Invalid>0);
    pool_ALLOW_ErrorCount := COUNT(GROUP,h.pool_Invalid=1);
    pool_ALLOW_WouldModifyCount := COUNT(GROUP,h.pool_Invalid=1 AND h.pool_wouldClean);
    pool_LENGTHS_ErrorCount := COUNT(GROUP,h.pool_Invalid=2);
    pool_LENGTHS_WouldModifyCount := COUNT(GROUP,h.pool_Invalid=2 AND h.pool_wouldClean);
    pool_Total_ErrorCount := COUNT(GROUP,h.pool_Invalid>0);
    speak_span_ALLOW_ErrorCount := COUNT(GROUP,h.speak_span_Invalid=1);
    speak_span_ALLOW_WouldModifyCount := COUNT(GROUP,h.speak_span_Invalid=1 AND h.speak_span_wouldClean);
    speak_span_LENGTHS_ErrorCount := COUNT(GROUP,h.speak_span_Invalid=2);
    speak_span_LENGTHS_WouldModifyCount := COUNT(GROUP,h.speak_span_Invalid=2 AND h.speak_span_wouldClean);
    speak_span_Total_ErrorCount := COUNT(GROUP,h.speak_span_Invalid>0);
    soho_ALLOW_ErrorCount := COUNT(GROUP,h.soho_Invalid=1);
    soho_ALLOW_WouldModifyCount := COUNT(GROUP,h.soho_Invalid=1 AND h.soho_wouldClean);
    soho_LENGTHS_ErrorCount := COUNT(GROUP,h.soho_Invalid=2);
    soho_LENGTHS_WouldModifyCount := COUNT(GROUP,h.soho_Invalid=2 AND h.soho_wouldClean);
    soho_Total_ErrorCount := COUNT(GROUP,h.soho_Invalid>0);
    vet_in_hh_ALLOW_ErrorCount := COUNT(GROUP,h.vet_in_hh_Invalid=1);
    vet_in_hh_ALLOW_WouldModifyCount := COUNT(GROUP,h.vet_in_hh_Invalid=1 AND h.vet_in_hh_wouldClean);
    vet_in_hh_LENGTHS_ErrorCount := COUNT(GROUP,h.vet_in_hh_Invalid=2);
    vet_in_hh_LENGTHS_WouldModifyCount := COUNT(GROUP,h.vet_in_hh_Invalid=2 AND h.vet_in_hh_wouldClean);
    vet_in_hh_Total_ErrorCount := COUNT(GROUP,h.vet_in_hh_Invalid>0);
    ms_mags_ALLOW_ErrorCount := COUNT(GROUP,h.ms_mags_Invalid=1);
    ms_books_ALLOW_ErrorCount := COUNT(GROUP,h.ms_books_Invalid=1);
    ms_publish_ALLOW_ErrorCount := COUNT(GROUP,h.ms_publish_Invalid=1);
    ms_pub_status_active_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_status_active_Invalid=1);
    ms_pub_status_expire_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_status_expire_Invalid=1);
    ms_pub_premsold_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_premsold_Invalid=1);
    ms_pub_autornwl_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_autornwl_Invalid=1);
    ms_pub_avgterm_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_avgterm_Invalid=1);
    ms_pub_lmos_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_lmos_Invalid=1);
    ms_pub_omos_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_omos_Invalid=1);
    ms_pub_pmos_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_pmos_Invalid=1);
    ms_pub_cemos_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_cemos_Invalid=1);
    ms_pub_femos_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_femos_Invalid=1);
    ms_pub_totords_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_totords_Invalid=1);
    ms_pub_totdlrs_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_totdlrs_Invalid=1);
    ms_pub_avgdlrs_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_avgdlrs_Invalid=1);
    ms_pub_lastdlrs_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_lastdlrs_Invalid=1);
    ms_pub_paystat_paid_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_paystat_paid_Invalid=1);
    ms_pub_paystat_ub_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_paystat_ub_Invalid=1);
    ms_pub_paymeth_cc_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_paymeth_cc_Invalid=1);
    ms_pub_paymeth_cash_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_paymeth_cash_Invalid=1);
    ms_pub_payspeed_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_payspeed_Invalid=1);
    ms_pub_osrc_dm_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_osrc_dm_Invalid=1);
    ms_pub_lsrc_dm_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_lsrc_dm_Invalid=1);
    ms_pub_osrc_agt_cashf_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_osrc_agt_cashf_Invalid=1);
    ms_pub_lsrc_agt_cashf_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_lsrc_agt_cashf_Invalid=1);
    ms_pub_osrc_agt_pds_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_osrc_agt_pds_Invalid=1);
    ms_pub_lsrc_agt_pds_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_lsrc_agt_pds_Invalid=1);
    ms_pub_osrc_agt_schplan_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_osrc_agt_schplan_Invalid=1);
    ms_pub_lsrc_agt_schplan_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_lsrc_agt_schplan_Invalid=1);
    ms_pub_osrc_agt_sponsor_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_osrc_agt_sponsor_Invalid=1);
    ms_pub_lsrc_agt_sponsor_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_lsrc_agt_sponsor_Invalid=1);
    ms_pub_osrc_agt_tm_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_osrc_agt_tm_Invalid=1);
    ms_pub_lsrc_agt_tm_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_lsrc_agt_tm_Invalid=1);
    ms_pub_osrc_agt_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_osrc_agt_Invalid=1);
    ms_pub_lsrc_agt_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_lsrc_agt_Invalid=1);
    ms_pub_osrc_tm_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_osrc_tm_Invalid=1);
    ms_pub_lsrc_tm_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_lsrc_tm_Invalid=1);
    ms_pub_osrc_ins_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_osrc_ins_Invalid=1);
    ms_pub_lsrc_ins_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_lsrc_ins_Invalid=1);
    ms_pub_osrc_net_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_osrc_net_Invalid=1);
    ms_pub_lsrc_net_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_lsrc_net_Invalid=1);
    ms_pub_osrc_print_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_osrc_print_Invalid=1);
    ms_pub_lsrc_print_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_lsrc_print_Invalid=1);
    ms_pub_osrc_trans_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_osrc_trans_Invalid=1);
    ms_pub_lsrc_trans_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_lsrc_trans_Invalid=1);
    ms_pub_osrc_tv_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_osrc_tv_Invalid=1);
    ms_pub_lsrc_tv_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_lsrc_tv_Invalid=1);
    ms_pub_osrc_dtp_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_osrc_dtp_Invalid=1);
    ms_pub_lsrc_dtp_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_lsrc_dtp_Invalid=1);
    ms_pub_giftgivr_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_giftgivr_Invalid=1);
    ms_pub_giftee_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_giftee_Invalid=1);
    ms_catalog_ALLOW_ErrorCount := COUNT(GROUP,h.ms_catalog_Invalid=1);
    ms_cat_lmos_ALLOW_ErrorCount := COUNT(GROUP,h.ms_cat_lmos_Invalid=1);
    ms_cat_omos_ALLOW_ErrorCount := COUNT(GROUP,h.ms_cat_omos_Invalid=1);
    ms_cat_pmos_ALLOW_ErrorCount := COUNT(GROUP,h.ms_cat_pmos_Invalid=1);
    ms_cat_totords_ALLOW_ErrorCount := COUNT(GROUP,h.ms_cat_totords_Invalid=1);
    ms_cat_totitems_ALLOW_ErrorCount := COUNT(GROUP,h.ms_cat_totitems_Invalid=1);
    ms_cat_totdlrs_ALLOW_ErrorCount := COUNT(GROUP,h.ms_cat_totdlrs_Invalid=1);
    ms_cat_avgdlrs_ALLOW_ErrorCount := COUNT(GROUP,h.ms_cat_avgdlrs_Invalid=1);
    ms_cat_lastdlrs_ALLOW_ErrorCount := COUNT(GROUP,h.ms_cat_lastdlrs_Invalid=1);
    ms_cat_paystat_paid_ALLOW_ErrorCount := COUNT(GROUP,h.ms_cat_paystat_paid_Invalid=1);
    ms_cat_paymeth_cc_ALLOW_ErrorCount := COUNT(GROUP,h.ms_cat_paymeth_cc_Invalid=1);
    ms_cat_paymeth_cash_ALLOW_ErrorCount := COUNT(GROUP,h.ms_cat_paymeth_cash_Invalid=1);
    ms_cat_osrc_dm_ALLOW_ErrorCount := COUNT(GROUP,h.ms_cat_osrc_dm_Invalid=1);
    ms_cat_lsrc_dm_ALLOW_ErrorCount := COUNT(GROUP,h.ms_cat_lsrc_dm_Invalid=1);
    ms_cat_osrc_net_ALLOW_ErrorCount := COUNT(GROUP,h.ms_cat_osrc_net_Invalid=1);
    ms_cat_lsrc_net_ALLOW_ErrorCount := COUNT(GROUP,h.ms_cat_lsrc_net_Invalid=1);
    ms_cat_giftgivr_ALLOW_ErrorCount := COUNT(GROUP,h.ms_cat_giftgivr_Invalid=1);
    pkpubs_corrected_ALLOW_ErrorCount := COUNT(GROUP,h.pkpubs_corrected_Invalid=1);
    pkcatg_corrected_ALLOW_ErrorCount := COUNT(GROUP,h.pkcatg_corrected_Invalid=1);
    ms_fundraising_ALLOW_ErrorCount := COUNT(GROUP,h.ms_fundraising_Invalid=1);
    ms_fund_lmos_ALLOW_ErrorCount := COUNT(GROUP,h.ms_fund_lmos_Invalid=1);
    ms_fund_omos_ALLOW_ErrorCount := COUNT(GROUP,h.ms_fund_omos_Invalid=1);
    ms_fund_pmos_ALLOW_ErrorCount := COUNT(GROUP,h.ms_fund_pmos_Invalid=1);
    ms_fund_totords_ALLOW_ErrorCount := COUNT(GROUP,h.ms_fund_totords_Invalid=1);
    ms_fund_totdlrs_ALLOW_ErrorCount := COUNT(GROUP,h.ms_fund_totdlrs_Invalid=1);
    ms_fund_avgdlrs_ALLOW_ErrorCount := COUNT(GROUP,h.ms_fund_avgdlrs_Invalid=1);
    ms_fund_lastdlrs_ALLOW_ErrorCount := COUNT(GROUP,h.ms_fund_lastdlrs_Invalid=1);
    ms_fund_paystat_paid_ALLOW_ErrorCount := COUNT(GROUP,h.ms_fund_paystat_paid_Invalid=1);
    ms_other_ALLOW_ErrorCount := COUNT(GROUP,h.ms_other_Invalid=1);
    ms_continuity_ALLOW_ErrorCount := COUNT(GROUP,h.ms_continuity_Invalid=1);
    ms_cont_status_active_ALLOW_ErrorCount := COUNT(GROUP,h.ms_cont_status_active_Invalid=1);
    ms_cont_status_cancel_ALLOW_ErrorCount := COUNT(GROUP,h.ms_cont_status_cancel_Invalid=1);
    ms_cont_omos_ALLOW_ErrorCount := COUNT(GROUP,h.ms_cont_omos_Invalid=1);
    ms_cont_lmos_ALLOW_ErrorCount := COUNT(GROUP,h.ms_cont_lmos_Invalid=1);
    ms_cont_pmos_ALLOW_ErrorCount := COUNT(GROUP,h.ms_cont_pmos_Invalid=1);
    ms_cont_totords_ALLOW_ErrorCount := COUNT(GROUP,h.ms_cont_totords_Invalid=1);
    ms_cont_totdlrs_ALLOW_ErrorCount := COUNT(GROUP,h.ms_cont_totdlrs_Invalid=1);
    ms_cont_avgdlrs_ALLOW_ErrorCount := COUNT(GROUP,h.ms_cont_avgdlrs_Invalid=1);
    ms_cont_lastdlrs_ALLOW_ErrorCount := COUNT(GROUP,h.ms_cont_lastdlrs_Invalid=1);
    ms_cont_paystat_paid_ALLOW_ErrorCount := COUNT(GROUP,h.ms_cont_paystat_paid_Invalid=1);
    ms_cont_paymeth_cc_ALLOW_ErrorCount := COUNT(GROUP,h.ms_cont_paymeth_cc_Invalid=1);
    ms_cont_paymeth_cash_ALLOW_ErrorCount := COUNT(GROUP,h.ms_cont_paymeth_cash_Invalid=1);
    ms_totords_ALLOW_ErrorCount := COUNT(GROUP,h.ms_totords_Invalid=1);
    ms_totitems_ALLOW_ErrorCount := COUNT(GROUP,h.ms_totitems_Invalid=1);
    ms_totdlrs_ALLOW_ErrorCount := COUNT(GROUP,h.ms_totdlrs_Invalid=1);
    ms_avgdlrs_ALLOW_ErrorCount := COUNT(GROUP,h.ms_avgdlrs_Invalid=1);
    ms_lastdlrs_ALLOW_ErrorCount := COUNT(GROUP,h.ms_lastdlrs_Invalid=1);
    ms_paystat_paid_ALLOW_ErrorCount := COUNT(GROUP,h.ms_paystat_paid_Invalid=1);
    ms_paymeth_cc_ALLOW_ErrorCount := COUNT(GROUP,h.ms_paymeth_cc_Invalid=1);
    ms_paymeth_cash_ALLOW_ErrorCount := COUNT(GROUP,h.ms_paymeth_cash_Invalid=1);
    ms_osrc_dm_ALLOW_ErrorCount := COUNT(GROUP,h.ms_osrc_dm_Invalid=1);
    ms_lsrc_dm_ALLOW_ErrorCount := COUNT(GROUP,h.ms_lsrc_dm_Invalid=1);
    ms_osrc_tm_ALLOW_ErrorCount := COUNT(GROUP,h.ms_osrc_tm_Invalid=1);
    ms_lsrc_tm_ALLOW_ErrorCount := COUNT(GROUP,h.ms_lsrc_tm_Invalid=1);
    ms_osrc_ins_ALLOW_ErrorCount := COUNT(GROUP,h.ms_osrc_ins_Invalid=1);
    ms_lsrc_ins_ALLOW_ErrorCount := COUNT(GROUP,h.ms_lsrc_ins_Invalid=1);
    ms_osrc_net_ALLOW_ErrorCount := COUNT(GROUP,h.ms_osrc_net_Invalid=1);
    ms_lsrc_net_ALLOW_ErrorCount := COUNT(GROUP,h.ms_lsrc_net_Invalid=1);
    ms_osrc_tv_ALLOW_ErrorCount := COUNT(GROUP,h.ms_osrc_tv_Invalid=1);
    ms_lsrc_tv_ALLOW_ErrorCount := COUNT(GROUP,h.ms_lsrc_tv_Invalid=1);
    ms_osrc_retail_ALLOW_ErrorCount := COUNT(GROUP,h.ms_osrc_retail_Invalid=1);
    ms_lsrc_retail_ALLOW_ErrorCount := COUNT(GROUP,h.ms_lsrc_retail_Invalid=1);
    ms_giftgivr_ALLOW_ErrorCount := COUNT(GROUP,h.ms_giftgivr_Invalid=1);
    ms_giftee_ALLOW_ErrorCount := COUNT(GROUP,h.ms_giftee_Invalid=1);
    ms_adult_ALLOW_ErrorCount := COUNT(GROUP,h.ms_adult_Invalid=1);
    ms_womapp_ALLOW_ErrorCount := COUNT(GROUP,h.ms_womapp_Invalid=1);
    ms_menapp_ALLOW_ErrorCount := COUNT(GROUP,h.ms_menapp_Invalid=1);
    ms_kidapp_ALLOW_ErrorCount := COUNT(GROUP,h.ms_kidapp_Invalid=1);
    ms_accessory_ALLOW_ErrorCount := COUNT(GROUP,h.ms_accessory_Invalid=1);
    ms_apparel_ALLOW_ErrorCount := COUNT(GROUP,h.ms_apparel_Invalid=1);
    ms_app_lmos_ALLOW_ErrorCount := COUNT(GROUP,h.ms_app_lmos_Invalid=1);
    ms_app_omos_ALLOW_ErrorCount := COUNT(GROUP,h.ms_app_omos_Invalid=1);
    ms_app_pmos_ALLOW_ErrorCount := COUNT(GROUP,h.ms_app_pmos_Invalid=1);
    ms_app_totords_ALLOW_ErrorCount := COUNT(GROUP,h.ms_app_totords_Invalid=1);
    ms_app_totitems_ALLOW_ErrorCount := COUNT(GROUP,h.ms_app_totitems_Invalid=1);
    ms_app_totdlrs_ALLOW_ErrorCount := COUNT(GROUP,h.ms_app_totdlrs_Invalid=1);
    ms_app_avgdlrs_ALLOW_ErrorCount := COUNT(GROUP,h.ms_app_avgdlrs_Invalid=1);
    ms_app_lastdlrs_ALLOW_ErrorCount := COUNT(GROUP,h.ms_app_lastdlrs_Invalid=1);
    ms_app_paystat_paid_ALLOW_ErrorCount := COUNT(GROUP,h.ms_app_paystat_paid_Invalid=1);
    ms_app_paymeth_cc_ALLOW_ErrorCount := COUNT(GROUP,h.ms_app_paymeth_cc_Invalid=1);
    ms_app_paymeth_cash_ALLOW_ErrorCount := COUNT(GROUP,h.ms_app_paymeth_cash_Invalid=1);
    ms_menfash_ALLOW_ErrorCount := COUNT(GROUP,h.ms_menfash_Invalid=1);
    ms_womfash_ALLOW_ErrorCount := COUNT(GROUP,h.ms_womfash_Invalid=1);
    ms_wfsh_lmos_ALLOW_ErrorCount := COUNT(GROUP,h.ms_wfsh_lmos_Invalid=1);
    ms_wfsh_omos_ALLOW_ErrorCount := COUNT(GROUP,h.ms_wfsh_omos_Invalid=1);
    ms_wfsh_pmos_ALLOW_ErrorCount := COUNT(GROUP,h.ms_wfsh_pmos_Invalid=1);
    ms_wfsh_totords_ALLOW_ErrorCount := COUNT(GROUP,h.ms_wfsh_totords_Invalid=1);
    ms_wfsh_totdlrs_ALLOW_ErrorCount := COUNT(GROUP,h.ms_wfsh_totdlrs_Invalid=1);
    ms_wfsh_avgdlrs_ALLOW_ErrorCount := COUNT(GROUP,h.ms_wfsh_avgdlrs_Invalid=1);
    ms_wfsh_lastdlrs_ALLOW_ErrorCount := COUNT(GROUP,h.ms_wfsh_lastdlrs_Invalid=1);
    ms_wfsh_paystat_paid_ALLOW_ErrorCount := COUNT(GROUP,h.ms_wfsh_paystat_paid_Invalid=1);
    ms_wfsh_osrc_dm_ALLOW_ErrorCount := COUNT(GROUP,h.ms_wfsh_osrc_dm_Invalid=1);
    ms_wfsh_lsrc_dm_ALLOW_ErrorCount := COUNT(GROUP,h.ms_wfsh_lsrc_dm_Invalid=1);
    ms_wfsh_osrc_agt_ALLOW_ErrorCount := COUNT(GROUP,h.ms_wfsh_osrc_agt_Invalid=1);
    ms_wfsh_lsrc_agt_ALLOW_ErrorCount := COUNT(GROUP,h.ms_wfsh_lsrc_agt_Invalid=1);
    ms_audio_ALLOW_ErrorCount := COUNT(GROUP,h.ms_audio_Invalid=1);
    ms_auto_ALLOW_ErrorCount := COUNT(GROUP,h.ms_auto_Invalid=1);
    ms_aviation_ALLOW_ErrorCount := COUNT(GROUP,h.ms_aviation_Invalid=1);
    ms_bargains_ALLOW_ErrorCount := COUNT(GROUP,h.ms_bargains_Invalid=1);
    ms_beauty_ALLOW_ErrorCount := COUNT(GROUP,h.ms_beauty_Invalid=1);
    ms_bible_ALLOW_ErrorCount := COUNT(GROUP,h.ms_bible_Invalid=1);
    ms_bible_lmos_ALLOW_ErrorCount := COUNT(GROUP,h.ms_bible_lmos_Invalid=1);
    ms_bible_omos_ALLOW_ErrorCount := COUNT(GROUP,h.ms_bible_omos_Invalid=1);
    ms_bible_pmos_ALLOW_ErrorCount := COUNT(GROUP,h.ms_bible_pmos_Invalid=1);
    ms_bible_totords_ALLOW_ErrorCount := COUNT(GROUP,h.ms_bible_totords_Invalid=1);
    ms_bible_totitems_ALLOW_ErrorCount := COUNT(GROUP,h.ms_bible_totitems_Invalid=1);
    ms_bible_totdlrs_ALLOW_ErrorCount := COUNT(GROUP,h.ms_bible_totdlrs_Invalid=1);
    ms_bible_avgdlrs_ALLOW_ErrorCount := COUNT(GROUP,h.ms_bible_avgdlrs_Invalid=1);
    ms_bible_lastdlrs_ALLOW_ErrorCount := COUNT(GROUP,h.ms_bible_lastdlrs_Invalid=1);
    ms_bible_paystat_paid_ALLOW_ErrorCount := COUNT(GROUP,h.ms_bible_paystat_paid_Invalid=1);
    ms_bible_paymeth_cc_ALLOW_ErrorCount := COUNT(GROUP,h.ms_bible_paymeth_cc_Invalid=1);
    ms_bible_paymeth_cash_ALLOW_ErrorCount := COUNT(GROUP,h.ms_bible_paymeth_cash_Invalid=1);
    ms_business_ALLOW_ErrorCount := COUNT(GROUP,h.ms_business_Invalid=1);
    ms_collectibles_ALLOW_ErrorCount := COUNT(GROUP,h.ms_collectibles_Invalid=1);
    ms_computers_ALLOW_ErrorCount := COUNT(GROUP,h.ms_computers_Invalid=1);
    ms_crafts_ALLOW_ErrorCount := COUNT(GROUP,h.ms_crafts_Invalid=1);
    ms_culturearts_ALLOW_ErrorCount := COUNT(GROUP,h.ms_culturearts_Invalid=1);
    ms_currevent_ALLOW_ErrorCount := COUNT(GROUP,h.ms_currevent_Invalid=1);
    ms_diy_ALLOW_ErrorCount := COUNT(GROUP,h.ms_diy_Invalid=1);
    ms_electronics_ALLOW_ErrorCount := COUNT(GROUP,h.ms_electronics_Invalid=1);
    ms_equestrian_ALLOW_ErrorCount := COUNT(GROUP,h.ms_equestrian_Invalid=1);
    ms_pub_family_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_family_Invalid=1);
    ms_cat_family_ALLOW_ErrorCount := COUNT(GROUP,h.ms_cat_family_Invalid=1);
    ms_family_ALLOW_ErrorCount := COUNT(GROUP,h.ms_family_Invalid=1);
    ms_family_lmos_ALLOW_ErrorCount := COUNT(GROUP,h.ms_family_lmos_Invalid=1);
    ms_family_omos_ALLOW_ErrorCount := COUNT(GROUP,h.ms_family_omos_Invalid=1);
    ms_family_pmos_ALLOW_ErrorCount := COUNT(GROUP,h.ms_family_pmos_Invalid=1);
    ms_family_totords_ALLOW_ErrorCount := COUNT(GROUP,h.ms_family_totords_Invalid=1);
    ms_family_totitems_ALLOW_ErrorCount := COUNT(GROUP,h.ms_family_totitems_Invalid=1);
    ms_family_totdlrs_ALLOW_ErrorCount := COUNT(GROUP,h.ms_family_totdlrs_Invalid=1);
    ms_family_avgdlrs_ALLOW_ErrorCount := COUNT(GROUP,h.ms_family_avgdlrs_Invalid=1);
    ms_family_lastdlrs_ALLOW_ErrorCount := COUNT(GROUP,h.ms_family_lastdlrs_Invalid=1);
    ms_family_paystat_paid_ALLOW_ErrorCount := COUNT(GROUP,h.ms_family_paystat_paid_Invalid=1);
    ms_family_paymeth_cc_ALLOW_ErrorCount := COUNT(GROUP,h.ms_family_paymeth_cc_Invalid=1);
    ms_family_paymeth_cash_ALLOW_ErrorCount := COUNT(GROUP,h.ms_family_paymeth_cash_Invalid=1);
    ms_family_osrc_dm_ALLOW_ErrorCount := COUNT(GROUP,h.ms_family_osrc_dm_Invalid=1);
    ms_family_lsrc_dm_ALLOW_ErrorCount := COUNT(GROUP,h.ms_family_lsrc_dm_Invalid=1);
    ms_fiction_ALLOW_ErrorCount := COUNT(GROUP,h.ms_fiction_Invalid=1);
    ms_food_ALLOW_ErrorCount := COUNT(GROUP,h.ms_food_Invalid=1);
    ms_games_ALLOW_ErrorCount := COUNT(GROUP,h.ms_games_Invalid=1);
    ms_gifts_ALLOW_ErrorCount := COUNT(GROUP,h.ms_gifts_Invalid=1);
    ms_gourmet_ALLOW_ErrorCount := COUNT(GROUP,h.ms_gourmet_Invalid=1);
    ms_fitness_ALLOW_ErrorCount := COUNT(GROUP,h.ms_fitness_Invalid=1);
    ms_health_ALLOW_ErrorCount := COUNT(GROUP,h.ms_health_Invalid=1);
    ms_hlth_lmos_ALLOW_ErrorCount := COUNT(GROUP,h.ms_hlth_lmos_Invalid=1);
    ms_hlth_omos_ALLOW_ErrorCount := COUNT(GROUP,h.ms_hlth_omos_Invalid=1);
    ms_hlth_pmos_ALLOW_ErrorCount := COUNT(GROUP,h.ms_hlth_pmos_Invalid=1);
    ms_hlth_totords_ALLOW_ErrorCount := COUNT(GROUP,h.ms_hlth_totords_Invalid=1);
    ms_hlth_totdlrs_ALLOW_ErrorCount := COUNT(GROUP,h.ms_hlth_totdlrs_Invalid=1);
    ms_hlth_avgdlrs_ALLOW_ErrorCount := COUNT(GROUP,h.ms_hlth_avgdlrs_Invalid=1);
    ms_hlth_lastdlrs_ALLOW_ErrorCount := COUNT(GROUP,h.ms_hlth_lastdlrs_Invalid=1);
    ms_hlth_paystat_paid_ALLOW_ErrorCount := COUNT(GROUP,h.ms_hlth_paystat_paid_Invalid=1);
    ms_hlth_paymeth_cc_ALLOW_ErrorCount := COUNT(GROUP,h.ms_hlth_paymeth_cc_Invalid=1);
    ms_hlth_osrc_dm_ALLOW_ErrorCount := COUNT(GROUP,h.ms_hlth_osrc_dm_Invalid=1);
    ms_hlth_lsrc_dm_ALLOW_ErrorCount := COUNT(GROUP,h.ms_hlth_lsrc_dm_Invalid=1);
    ms_hlth_osrc_agt_ALLOW_ErrorCount := COUNT(GROUP,h.ms_hlth_osrc_agt_Invalid=1);
    ms_hlth_lsrc_agt_ALLOW_ErrorCount := COUNT(GROUP,h.ms_hlth_lsrc_agt_Invalid=1);
    ms_hlth_osrc_tv_ALLOW_ErrorCount := COUNT(GROUP,h.ms_hlth_osrc_tv_Invalid=1);
    ms_hlth_lsrc_tv_ALLOW_ErrorCount := COUNT(GROUP,h.ms_hlth_lsrc_tv_Invalid=1);
    ms_holiday_ALLOW_ErrorCount := COUNT(GROUP,h.ms_holiday_Invalid=1);
    ms_history_ALLOW_ErrorCount := COUNT(GROUP,h.ms_history_Invalid=1);
    ms_pub_cooking_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_cooking_Invalid=1);
    ms_cooking_ALLOW_ErrorCount := COUNT(GROUP,h.ms_cooking_Invalid=1);
    ms_pub_homedecr_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_homedecr_Invalid=1);
    ms_cat_homedecr_ALLOW_ErrorCount := COUNT(GROUP,h.ms_cat_homedecr_Invalid=1);
    ms_homedecr_ALLOW_ErrorCount := COUNT(GROUP,h.ms_homedecr_Invalid=1);
    ms_housewares_ALLOW_ErrorCount := COUNT(GROUP,h.ms_housewares_Invalid=1);
    ms_pub_garden_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_garden_Invalid=1);
    ms_cat_garden_ALLOW_ErrorCount := COUNT(GROUP,h.ms_cat_garden_Invalid=1);
    ms_garden_ALLOW_ErrorCount := COUNT(GROUP,h.ms_garden_Invalid=1);
    ms_pub_homeliv_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_homeliv_Invalid=1);
    ms_cat_homeliv_ALLOW_ErrorCount := COUNT(GROUP,h.ms_cat_homeliv_Invalid=1);
    ms_homeliv_ALLOW_ErrorCount := COUNT(GROUP,h.ms_homeliv_Invalid=1);
    ms_pub_home_status_active_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_home_status_active_Invalid=1);
    ms_home_lmos_ALLOW_ErrorCount := COUNT(GROUP,h.ms_home_lmos_Invalid=1);
    ms_home_omos_ALLOW_ErrorCount := COUNT(GROUP,h.ms_home_omos_Invalid=1);
    ms_home_pmos_ALLOW_ErrorCount := COUNT(GROUP,h.ms_home_pmos_Invalid=1);
    ms_home_totords_ALLOW_ErrorCount := COUNT(GROUP,h.ms_home_totords_Invalid=1);
    ms_home_totitems_ALLOW_ErrorCount := COUNT(GROUP,h.ms_home_totitems_Invalid=1);
    ms_home_totdlrs_ALLOW_ErrorCount := COUNT(GROUP,h.ms_home_totdlrs_Invalid=1);
    ms_home_avgdlrs_ALLOW_ErrorCount := COUNT(GROUP,h.ms_home_avgdlrs_Invalid=1);
    ms_home_lastdlrs_ALLOW_ErrorCount := COUNT(GROUP,h.ms_home_lastdlrs_Invalid=1);
    ms_home_paystat_paid_ALLOW_ErrorCount := COUNT(GROUP,h.ms_home_paystat_paid_Invalid=1);
    ms_home_paymeth_cc_ALLOW_ErrorCount := COUNT(GROUP,h.ms_home_paymeth_cc_Invalid=1);
    ms_home_paymeth_cash_ALLOW_ErrorCount := COUNT(GROUP,h.ms_home_paymeth_cash_Invalid=1);
    ms_home_osrc_dm_ALLOW_ErrorCount := COUNT(GROUP,h.ms_home_osrc_dm_Invalid=1);
    ms_home_lsrc_dm_ALLOW_ErrorCount := COUNT(GROUP,h.ms_home_lsrc_dm_Invalid=1);
    ms_home_osrc_agt_ALLOW_ErrorCount := COUNT(GROUP,h.ms_home_osrc_agt_Invalid=1);
    ms_home_lsrc_agt_ALLOW_ErrorCount := COUNT(GROUP,h.ms_home_lsrc_agt_Invalid=1);
    ms_home_osrc_net_ALLOW_ErrorCount := COUNT(GROUP,h.ms_home_osrc_net_Invalid=1);
    ms_home_lsrc_net_ALLOW_ErrorCount := COUNT(GROUP,h.ms_home_lsrc_net_Invalid=1);
    ms_home_osrc_tv_ALLOW_ErrorCount := COUNT(GROUP,h.ms_home_osrc_tv_Invalid=1);
    ms_home_lsrc_tv_ALLOW_ErrorCount := COUNT(GROUP,h.ms_home_lsrc_tv_Invalid=1);
    ms_humor_ALLOW_ErrorCount := COUNT(GROUP,h.ms_humor_Invalid=1);
    ms_inspiration_ALLOW_ErrorCount := COUNT(GROUP,h.ms_inspiration_Invalid=1);
    ms_merchandise_ALLOW_ErrorCount := COUNT(GROUP,h.ms_merchandise_Invalid=1);
    ms_moneymaking_ALLOW_ErrorCount := COUNT(GROUP,h.ms_moneymaking_Invalid=1);
    ms_moneymaking_lmos_ALLOW_ErrorCount := COUNT(GROUP,h.ms_moneymaking_lmos_Invalid=1);
    ms_motorcycles_ALLOW_ErrorCount := COUNT(GROUP,h.ms_motorcycles_Invalid=1);
    ms_music_ALLOW_ErrorCount := COUNT(GROUP,h.ms_music_Invalid=1);
    ms_fishing_ALLOW_ErrorCount := COUNT(GROUP,h.ms_fishing_Invalid=1);
    ms_hunting_ALLOW_ErrorCount := COUNT(GROUP,h.ms_hunting_Invalid=1);
    ms_boatsail_ALLOW_ErrorCount := COUNT(GROUP,h.ms_boatsail_Invalid=1);
    ms_camp_ALLOW_ErrorCount := COUNT(GROUP,h.ms_camp_Invalid=1);
    ms_pub_outdoors_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_outdoors_Invalid=1);
    ms_cat_outdoors_ALLOW_ErrorCount := COUNT(GROUP,h.ms_cat_outdoors_Invalid=1);
    ms_outdoors_ALLOW_ErrorCount := COUNT(GROUP,h.ms_outdoors_Invalid=1);
    ms_pub_out_status_active_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pub_out_status_active_Invalid=1);
    ms_out_lmos_ALLOW_ErrorCount := COUNT(GROUP,h.ms_out_lmos_Invalid=1);
    ms_out_omos_ALLOW_ErrorCount := COUNT(GROUP,h.ms_out_omos_Invalid=1);
    ms_out_pmos_ALLOW_ErrorCount := COUNT(GROUP,h.ms_out_pmos_Invalid=1);
    ms_out_totords_ALLOW_ErrorCount := COUNT(GROUP,h.ms_out_totords_Invalid=1);
    ms_out_totitems_ALLOW_ErrorCount := COUNT(GROUP,h.ms_out_totitems_Invalid=1);
    ms_out_totdlrs_ALLOW_ErrorCount := COUNT(GROUP,h.ms_out_totdlrs_Invalid=1);
    ms_out_avgdlrs_ALLOW_ErrorCount := COUNT(GROUP,h.ms_out_avgdlrs_Invalid=1);
    ms_out_lastdlrs_ALLOW_ErrorCount := COUNT(GROUP,h.ms_out_lastdlrs_Invalid=1);
    ms_out_paystat_paid_ALLOW_ErrorCount := COUNT(GROUP,h.ms_out_paystat_paid_Invalid=1);
    ms_out_paymeth_cc_ALLOW_ErrorCount := COUNT(GROUP,h.ms_out_paymeth_cc_Invalid=1);
    ms_out_paymeth_cash_ALLOW_ErrorCount := COUNT(GROUP,h.ms_out_paymeth_cash_Invalid=1);
    ms_out_osrc_dm_ALLOW_ErrorCount := COUNT(GROUP,h.ms_out_osrc_dm_Invalid=1);
    ms_out_lsrc_dm_ALLOW_ErrorCount := COUNT(GROUP,h.ms_out_lsrc_dm_Invalid=1);
    ms_out_osrc_agt_ALLOW_ErrorCount := COUNT(GROUP,h.ms_out_osrc_agt_Invalid=1);
    ms_out_lsrc_agt_ALLOW_ErrorCount := COUNT(GROUP,h.ms_out_lsrc_agt_Invalid=1);
    ms_pets_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pets_Invalid=1);
    ms_pfin_ALLOW_ErrorCount := COUNT(GROUP,h.ms_pfin_Invalid=1);
    ms_photo_ALLOW_ErrorCount := COUNT(GROUP,h.ms_photo_Invalid=1);
    ms_photoproc_ALLOW_ErrorCount := COUNT(GROUP,h.ms_photoproc_Invalid=1);
    ms_rural_ALLOW_ErrorCount := COUNT(GROUP,h.ms_rural_Invalid=1);
    ms_science_ALLOW_ErrorCount := COUNT(GROUP,h.ms_science_Invalid=1);
    ms_sports_ALLOW_ErrorCount := COUNT(GROUP,h.ms_sports_Invalid=1);
    ms_sports_lmos_ALLOW_ErrorCount := COUNT(GROUP,h.ms_sports_lmos_Invalid=1);
    ms_travel_ALLOW_ErrorCount := COUNT(GROUP,h.ms_travel_Invalid=1);
    ms_tvmovies_ALLOW_ErrorCount := COUNT(GROUP,h.ms_tvmovies_Invalid=1);
    ms_wildlife_ALLOW_ErrorCount := COUNT(GROUP,h.ms_wildlife_Invalid=1);
    ms_woman_ALLOW_ErrorCount := COUNT(GROUP,h.ms_woman_Invalid=1);
    ms_woman_lmos_ALLOW_ErrorCount := COUNT(GROUP,h.ms_woman_lmos_Invalid=1);
    ms_ringtones_apps_ALLOW_ErrorCount := COUNT(GROUP,h.ms_ringtones_apps_Invalid=1);
    cpi_mobile_apps_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_mobile_apps_index_Invalid=1);
    cpi_credit_repair_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_credit_repair_index_Invalid=1);
    cpi_credit_report_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_credit_report_index_Invalid=1);
    cpi_education_seekers_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_education_seekers_index_Invalid=1);
    cpi_insurance_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_insurance_index_Invalid=1);
    cpi_insurance_health_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_insurance_health_index_Invalid=1);
    cpi_insurance_auto_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_insurance_auto_index_Invalid=1);
    cpi_job_seekers_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_job_seekers_index_Invalid=1);
    cpi_social_networking_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_social_networking_index_Invalid=1);
    cpi_adult_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_adult_index_Invalid=1);
    cpi_africanamerican_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_africanamerican_index_Invalid=1);
    cpi_apparel_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_apparel_index_Invalid=1);
    cpi_apparel_accessory_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_apparel_accessory_index_Invalid=1);
    cpi_apparel_kids_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_apparel_kids_index_Invalid=1);
    cpi_apparel_men_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_apparel_men_index_Invalid=1);
    cpi_apparel_menfash_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_apparel_menfash_index_Invalid=1);
    cpi_apparel_women_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_apparel_women_index_Invalid=1);
    cpi_apparel_womfash_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_apparel_womfash_index_Invalid=1);
    cpi_asian_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_asian_index_Invalid=1);
    cpi_auto_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_auto_index_Invalid=1);
    cpi_auto_racing_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_auto_racing_index_Invalid=1);
    cpi_auto_trucks_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_auto_trucks_index_Invalid=1);
    cpi_aviation_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_aviation_index_Invalid=1);
    cpi_bargains_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_bargains_index_Invalid=1);
    cpi_beauty_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_beauty_index_Invalid=1);
    cpi_bible_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_bible_index_Invalid=1);
    cpi_birds_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_birds_index_Invalid=1);
    cpi_business_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_business_index_Invalid=1);
    cpi_business_homeoffice_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_business_homeoffice_index_Invalid=1);
    cpi_catalog_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_catalog_index_Invalid=1);
    cpi_cc_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_cc_index_Invalid=1);
    cpi_collectibles_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_collectibles_index_Invalid=1);
    cpi_college_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_college_index_Invalid=1);
    cpi_computers_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_computers_index_Invalid=1);
    cpi_conservative_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_conservative_index_Invalid=1);
    cpi_continuity_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_continuity_index_Invalid=1);
    cpi_cooking_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_cooking_index_Invalid=1);
    cpi_crafts_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_crafts_index_Invalid=1);
    cpi_crafts_crochet_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_crafts_crochet_index_Invalid=1);
    cpi_crafts_knit_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_crafts_knit_index_Invalid=1);
    cpi_crafts_needlepoint_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_crafts_needlepoint_index_Invalid=1);
    cpi_crafts_quilt_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_crafts_quilt_index_Invalid=1);
    cpi_crafts_sew_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_crafts_sew_index_Invalid=1);
    cpi_culturearts_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_culturearts_index_Invalid=1);
    cpi_currevent_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_currevent_index_Invalid=1);
    cpi_diy_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_diy_index_Invalid=1);
    cpi_donor_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_donor_index_Invalid=1);
    cpi_ego_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_ego_index_Invalid=1);
    cpi_electronics_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_electronics_index_Invalid=1);
    cpi_equestrian_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_equestrian_index_Invalid=1);
    cpi_family_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_family_index_Invalid=1);
    cpi_family_teen_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_family_teen_index_Invalid=1);
    cpi_family_young_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_family_young_index_Invalid=1);
    cpi_fiction_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_fiction_index_Invalid=1);
    cpi_gambling_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_gambling_index_Invalid=1);
    cpi_games_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_games_index_Invalid=1);
    cpi_gardening_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_gardening_index_Invalid=1);
    cpi_gay_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_gay_index_Invalid=1);
    cpi_giftgivr_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_giftgivr_index_Invalid=1);
    cpi_gourmet_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_gourmet_index_Invalid=1);
    cpi_grandparents_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_grandparents_index_Invalid=1);
    cpi_health_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_health_index_Invalid=1);
    cpi_health_diet_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_health_diet_index_Invalid=1);
    cpi_health_fitness_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_health_fitness_index_Invalid=1);
    cpi_hightech_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_hightech_index_Invalid=1);
    cpi_hispanic_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_hispanic_index_Invalid=1);
    cpi_history_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_history_index_Invalid=1);
    cpi_history_american_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_history_american_index_Invalid=1);
    cpi_hobbies_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_hobbies_index_Invalid=1);
    cpi_homedecr_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_homedecr_index_Invalid=1);
    cpi_homeliv_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_homeliv_index_Invalid=1);
    cpi_humor_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_humor_index_Invalid=1);
    cpi_inspiration_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_inspiration_index_Invalid=1);
    cpi_internet_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_internet_index_Invalid=1);
    cpi_internet_access_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_internet_access_index_Invalid=1);
    cpi_internet_buy_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_internet_buy_index_Invalid=1);
    cpi_liberal_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_liberal_index_Invalid=1);
    cpi_moneymaking_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_moneymaking_index_Invalid=1);
    cpi_motorcycles_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_motorcycles_index_Invalid=1);
    cpi_music_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_music_index_Invalid=1);
    cpi_nonfiction_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_nonfiction_index_Invalid=1);
    cpi_ocean_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_ocean_index_Invalid=1);
    cpi_outdoors_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_outdoors_index_Invalid=1);
    cpi_outdoors_boatsail_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_outdoors_boatsail_index_Invalid=1);
    cpi_outdoors_camp_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_outdoors_camp_index_Invalid=1);
    cpi_outdoors_fishing_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_outdoors_fishing_index_Invalid=1);
    cpi_outdoors_huntfish_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_outdoors_huntfish_index_Invalid=1);
    cpi_outdoors_hunting_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_outdoors_hunting_index_Invalid=1);
    cpi_pets_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_pets_index_Invalid=1);
    cpi_pets_cats_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_pets_cats_index_Invalid=1);
    cpi_pets_dogs_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_pets_dogs_index_Invalid=1);
    cpi_pfin_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_pfin_index_Invalid=1);
    cpi_photog_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_photog_index_Invalid=1);
    cpi_photoproc_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_photoproc_index_Invalid=1);
    cpi_publish_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_publish_index_Invalid=1);
    cpi_publish_books_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_publish_books_index_Invalid=1);
    cpi_publish_mags_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_publish_mags_index_Invalid=1);
    cpi_rural_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_rural_index_Invalid=1);
    cpi_science_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_science_index_Invalid=1);
    cpi_scifi_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_scifi_index_Invalid=1);
    cpi_seniors_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_seniors_index_Invalid=1);
    cpi_sports_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_sports_index_Invalid=1);
    cpi_sports_baseball_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_sports_baseball_index_Invalid=1);
    cpi_sports_basketball_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_sports_basketball_index_Invalid=1);
    cpi_sports_biking_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_sports_biking_index_Invalid=1);
    cpi_sports_football_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_sports_football_index_Invalid=1);
    cpi_sports_golf_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_sports_golf_index_Invalid=1);
    cpi_sports_hockey_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_sports_hockey_index_Invalid=1);
    cpi_sports_running_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_sports_running_index_Invalid=1);
    cpi_sports_ski_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_sports_ski_index_Invalid=1);
    cpi_sports_soccer_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_sports_soccer_index_Invalid=1);
    cpi_sports_swimming_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_sports_swimming_index_Invalid=1);
    cpi_sports_tennis_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_sports_tennis_index_Invalid=1);
    cpi_stationery_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_stationery_index_Invalid=1);
    cpi_sweeps_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_sweeps_index_Invalid=1);
    cpi_tobacco_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_tobacco_index_Invalid=1);
    cpi_travel_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_travel_index_Invalid=1);
    cpi_travel_cruise_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_travel_cruise_index_Invalid=1);
    cpi_travel_rv_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_travel_rv_index_Invalid=1);
    cpi_travel_us_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_travel_us_index_Invalid=1);
    cpi_tvmovies_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_tvmovies_index_Invalid=1);
    cpi_wildlife_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_wildlife_index_Invalid=1);
    cpi_woman_index_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_woman_index_Invalid=1);
    totdlr_index_ALLOW_ErrorCount := COUNT(GROUP,h.totdlr_index_Invalid=1);
    cpi_totdlr_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_totdlr_Invalid=1);
    cpi_totords_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_totords_Invalid=1);
    cpi_lastdlr_ALLOW_ErrorCount := COUNT(GROUP,h.cpi_lastdlr_Invalid=1);
    pkcatg_ALLOW_ErrorCount := COUNT(GROUP,h.pkcatg_Invalid=1);
    pkpubs_ALLOW_ErrorCount := COUNT(GROUP,h.pkpubs_Invalid=1);
    pkcont_ALLOW_ErrorCount := COUNT(GROUP,h.pkcont_Invalid=1);
    pkca01_ALLOW_ErrorCount := COUNT(GROUP,h.pkca01_Invalid=1);
    pkca03_ALLOW_ErrorCount := COUNT(GROUP,h.pkca03_Invalid=1);
    pkca04_ALLOW_ErrorCount := COUNT(GROUP,h.pkca04_Invalid=1);
    pkca05_ALLOW_ErrorCount := COUNT(GROUP,h.pkca05_Invalid=1);
    pkca06_ALLOW_ErrorCount := COUNT(GROUP,h.pkca06_Invalid=1);
    pkca07_ALLOW_ErrorCount := COUNT(GROUP,h.pkca07_Invalid=1);
    pkca08_ALLOW_ErrorCount := COUNT(GROUP,h.pkca08_Invalid=1);
    pkca09_ALLOW_ErrorCount := COUNT(GROUP,h.pkca09_Invalid=1);
    pkca10_ALLOW_ErrorCount := COUNT(GROUP,h.pkca10_Invalid=1);
    pkca11_ALLOW_ErrorCount := COUNT(GROUP,h.pkca11_Invalid=1);
    pkca12_ALLOW_ErrorCount := COUNT(GROUP,h.pkca12_Invalid=1);
    pkca13_ALLOW_ErrorCount := COUNT(GROUP,h.pkca13_Invalid=1);
    pkca14_ALLOW_ErrorCount := COUNT(GROUP,h.pkca14_Invalid=1);
    pkca15_ALLOW_ErrorCount := COUNT(GROUP,h.pkca15_Invalid=1);
    pkca16_ALLOW_ErrorCount := COUNT(GROUP,h.pkca16_Invalid=1);
    pkca17_ALLOW_ErrorCount := COUNT(GROUP,h.pkca17_Invalid=1);
    pkca18_ALLOW_ErrorCount := COUNT(GROUP,h.pkca18_Invalid=1);
    pkca20_ALLOW_ErrorCount := COUNT(GROUP,h.pkca20_Invalid=1);
    pkca21_ALLOW_ErrorCount := COUNT(GROUP,h.pkca21_Invalid=1);
    pkca22_ALLOW_ErrorCount := COUNT(GROUP,h.pkca22_Invalid=1);
    pkca23_ALLOW_ErrorCount := COUNT(GROUP,h.pkca23_Invalid=1);
    pkca24_ALLOW_ErrorCount := COUNT(GROUP,h.pkca24_Invalid=1);
    pkca25_ALLOW_ErrorCount := COUNT(GROUP,h.pkca25_Invalid=1);
    pkca26_ALLOW_ErrorCount := COUNT(GROUP,h.pkca26_Invalid=1);
    pkca28_ALLOW_ErrorCount := COUNT(GROUP,h.pkca28_Invalid=1);
    pkca29_ALLOW_ErrorCount := COUNT(GROUP,h.pkca29_Invalid=1);
    pkca30_ALLOW_ErrorCount := COUNT(GROUP,h.pkca30_Invalid=1);
    pkca31_ALLOW_ErrorCount := COUNT(GROUP,h.pkca31_Invalid=1);
    pkca32_ALLOW_ErrorCount := COUNT(GROUP,h.pkca32_Invalid=1);
    pkca33_ALLOW_ErrorCount := COUNT(GROUP,h.pkca33_Invalid=1);
    pkca34_ALLOW_ErrorCount := COUNT(GROUP,h.pkca34_Invalid=1);
    pkca35_ALLOW_ErrorCount := COUNT(GROUP,h.pkca35_Invalid=1);
    pkca36_ALLOW_ErrorCount := COUNT(GROUP,h.pkca36_Invalid=1);
    pkca37_ALLOW_ErrorCount := COUNT(GROUP,h.pkca37_Invalid=1);
    pkca39_ALLOW_ErrorCount := COUNT(GROUP,h.pkca39_Invalid=1);
    pkca40_ALLOW_ErrorCount := COUNT(GROUP,h.pkca40_Invalid=1);
    pkca41_ALLOW_ErrorCount := COUNT(GROUP,h.pkca41_Invalid=1);
    pkca42_ALLOW_ErrorCount := COUNT(GROUP,h.pkca42_Invalid=1);
    pkca54_ALLOW_ErrorCount := COUNT(GROUP,h.pkca54_Invalid=1);
    pkca61_ALLOW_ErrorCount := COUNT(GROUP,h.pkca61_Invalid=1);
    pkca62_ALLOW_ErrorCount := COUNT(GROUP,h.pkca62_Invalid=1);
    pkca64_ALLOW_ErrorCount := COUNT(GROUP,h.pkca64_Invalid=1);
    pkpu01_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu01_Invalid=1);
    pkpu02_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu02_Invalid=1);
    pkpu03_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu03_Invalid=1);
    pkpu04_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu04_Invalid=1);
    pkpu05_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu05_Invalid=1);
    pkpu06_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu06_Invalid=1);
    pkpu07_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu07_Invalid=1);
    pkpu08_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu08_Invalid=1);
    pkpu09_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu09_Invalid=1);
    pkpu10_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu10_Invalid=1);
    pkpu11_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu11_Invalid=1);
    pkpu12_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu12_Invalid=1);
    pkpu13_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu13_Invalid=1);
    pkpu14_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu14_Invalid=1);
    pkpu15_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu15_Invalid=1);
    pkpu16_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu16_Invalid=1);
    pkpu17_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu17_Invalid=1);
    pkpu18_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu18_Invalid=1);
    pkpu19_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu19_Invalid=1);
    pkpu20_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu20_Invalid=1);
    pkpu23_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu23_Invalid=1);
    pkpu25_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu25_Invalid=1);
    pkpu27_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu27_Invalid=1);
    pkpu28_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu28_Invalid=1);
    pkpu29_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu29_Invalid=1);
    pkpu30_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu30_Invalid=1);
    pkpu31_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu31_Invalid=1);
    pkpu32_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu32_Invalid=1);
    pkpu33_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu33_Invalid=1);
    pkpu34_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu34_Invalid=1);
    pkpu35_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu35_Invalid=1);
    pkpu38_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu38_Invalid=1);
    pkpu41_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu41_Invalid=1);
    pkpu42_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu42_Invalid=1);
    pkpu45_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu45_Invalid=1);
    pkpu46_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu46_Invalid=1);
    pkpu47_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu47_Invalid=1);
    pkpu48_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu48_Invalid=1);
    pkpu49_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu49_Invalid=1);
    pkpu50_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu50_Invalid=1);
    pkpu51_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu51_Invalid=1);
    pkpu52_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu52_Invalid=1);
    pkpu53_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu53_Invalid=1);
    pkpu54_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu54_Invalid=1);
    pkpu55_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu55_Invalid=1);
    pkpu56_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu56_Invalid=1);
    pkpu57_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu57_Invalid=1);
    pkpu60_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu60_Invalid=1);
    pkpu61_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu61_Invalid=1);
    pkpu62_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu62_Invalid=1);
    pkpu63_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu63_Invalid=1);
    pkpu64_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu64_Invalid=1);
    pkpu65_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu65_Invalid=1);
    pkpu66_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu66_Invalid=1);
    pkpu67_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu67_Invalid=1);
    pkpu68_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu68_Invalid=1);
    pkpu69_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu69_Invalid=1);
    pkpu70_ALLOW_ErrorCount := COUNT(GROUP,h.pkpu70_Invalid=1);
    censpct_water_ALLOW_ErrorCount := COUNT(GROUP,h.censpct_water_Invalid=1);
    cens_pop_density_ALLOW_ErrorCount := COUNT(GROUP,h.cens_pop_density_Invalid=1);
    cens_hu_density_ALLOW_ErrorCount := COUNT(GROUP,h.cens_hu_density_Invalid=1);
    censpct_pop_white_ALLOW_ErrorCount := COUNT(GROUP,h.censpct_pop_white_Invalid=1);
    censpct_pop_black_ALLOW_ErrorCount := COUNT(GROUP,h.censpct_pop_black_Invalid=1);
    censpct_pop_amerind_ALLOW_ErrorCount := COUNT(GROUP,h.censpct_pop_amerind_Invalid=1);
    censpct_pop_asian_ALLOW_ErrorCount := COUNT(GROUP,h.censpct_pop_asian_Invalid=1);
    censpct_pop_pacisl_ALLOW_ErrorCount := COUNT(GROUP,h.censpct_pop_pacisl_Invalid=1);
    censpct_pop_othrace_ALLOW_ErrorCount := COUNT(GROUP,h.censpct_pop_othrace_Invalid=1);
    censpct_pop_multirace_ALLOW_ErrorCount := COUNT(GROUP,h.censpct_pop_multirace_Invalid=1);
    censpct_pop_hispanic_ALLOW_ErrorCount := COUNT(GROUP,h.censpct_pop_hispanic_Invalid=1);
    censpct_pop_agelt18_ALLOW_ErrorCount := COUNT(GROUP,h.censpct_pop_agelt18_Invalid=1);
    censpct_pop_males_ALLOW_ErrorCount := COUNT(GROUP,h.censpct_pop_males_Invalid=1);
    censpct_adult_age1824_ALLOW_ErrorCount := COUNT(GROUP,h.censpct_adult_age1824_Invalid=1);
    censpct_adult_age2534_ALLOW_ErrorCount := COUNT(GROUP,h.censpct_adult_age2534_Invalid=1);
    censpct_adult_age3544_ALLOW_ErrorCount := COUNT(GROUP,h.censpct_adult_age3544_Invalid=1);
    censpct_adult_age4554_ALLOW_ErrorCount := COUNT(GROUP,h.censpct_adult_age4554_Invalid=1);
    censpct_adult_age5564_ALLOW_ErrorCount := COUNT(GROUP,h.censpct_adult_age5564_Invalid=1);
    censpct_adult_agege65_ALLOW_ErrorCount := COUNT(GROUP,h.censpct_adult_agege65_Invalid=1);
    cens_pop_medage_ALLOW_ErrorCount := COUNT(GROUP,h.cens_pop_medage_Invalid=1);
    cens_hh_avgsize_ALLOW_ErrorCount := COUNT(GROUP,h.cens_hh_avgsize_Invalid=1);
    censpct_hh_family_ALLOW_ErrorCount := COUNT(GROUP,h.censpct_hh_family_Invalid=1);
    censpct_hh_family_husbwife_ALLOW_ErrorCount := COUNT(GROUP,h.censpct_hh_family_husbwife_Invalid=1);
    censpct_hu_occupied_ALLOW_ErrorCount := COUNT(GROUP,h.censpct_hu_occupied_Invalid=1);
    censpct_hu_owned_ALLOW_ErrorCount := COUNT(GROUP,h.censpct_hu_owned_Invalid=1);
    censpct_hu_rented_ALLOW_ErrorCount := COUNT(GROUP,h.censpct_hu_rented_Invalid=1);
    censpct_hu_vacantseasonal_ALLOW_ErrorCount := COUNT(GROUP,h.censpct_hu_vacantseasonal_Invalid=1);
    zip_medinc_ALLOW_ErrorCount := COUNT(GROUP,h.zip_medinc_Invalid=1);
    zip_apparel_ALLOW_ErrorCount := COUNT(GROUP,h.zip_apparel_Invalid=1);
    zip_apparel_women_ALLOW_ErrorCount := COUNT(GROUP,h.zip_apparel_women_Invalid=1);
    zip_apparel_womfash_ALLOW_ErrorCount := COUNT(GROUP,h.zip_apparel_womfash_Invalid=1);
    zip_auto_ALLOW_ErrorCount := COUNT(GROUP,h.zip_auto_Invalid=1);
    zip_beauty_ALLOW_ErrorCount := COUNT(GROUP,h.zip_beauty_Invalid=1);
    zip_booksmusicmovies_ALLOW_ErrorCount := COUNT(GROUP,h.zip_booksmusicmovies_Invalid=1);
    zip_business_ALLOW_ErrorCount := COUNT(GROUP,h.zip_business_Invalid=1);
    zip_catalog_ALLOW_ErrorCount := COUNT(GROUP,h.zip_catalog_Invalid=1);
    zip_cc_ALLOW_ErrorCount := COUNT(GROUP,h.zip_cc_Invalid=1);
    zip_collectibles_ALLOW_ErrorCount := COUNT(GROUP,h.zip_collectibles_Invalid=1);
    zip_computers_ALLOW_ErrorCount := COUNT(GROUP,h.zip_computers_Invalid=1);
    zip_continuity_ALLOW_ErrorCount := COUNT(GROUP,h.zip_continuity_Invalid=1);
    zip_cooking_ALLOW_ErrorCount := COUNT(GROUP,h.zip_cooking_Invalid=1);
    zip_crafts_ALLOW_ErrorCount := COUNT(GROUP,h.zip_crafts_Invalid=1);
    zip_culturearts_ALLOW_ErrorCount := COUNT(GROUP,h.zip_culturearts_Invalid=1);
    zip_dm_sold_ALLOW_ErrorCount := COUNT(GROUP,h.zip_dm_sold_Invalid=1);
    zip_donor_ALLOW_ErrorCount := COUNT(GROUP,h.zip_donor_Invalid=1);
    zip_family_ALLOW_ErrorCount := COUNT(GROUP,h.zip_family_Invalid=1);
    zip_gardening_ALLOW_ErrorCount := COUNT(GROUP,h.zip_gardening_Invalid=1);
    zip_giftgivr_ALLOW_ErrorCount := COUNT(GROUP,h.zip_giftgivr_Invalid=1);
    zip_gourmet_ALLOW_ErrorCount := COUNT(GROUP,h.zip_gourmet_Invalid=1);
    zip_health_ALLOW_ErrorCount := COUNT(GROUP,h.zip_health_Invalid=1);
    zip_health_diet_ALLOW_ErrorCount := COUNT(GROUP,h.zip_health_diet_Invalid=1);
    zip_health_fitness_ALLOW_ErrorCount := COUNT(GROUP,h.zip_health_fitness_Invalid=1);
    zip_hobbies_ALLOW_ErrorCount := COUNT(GROUP,h.zip_hobbies_Invalid=1);
    zip_homedecr_ALLOW_ErrorCount := COUNT(GROUP,h.zip_homedecr_Invalid=1);
    zip_homeliv_ALLOW_ErrorCount := COUNT(GROUP,h.zip_homeliv_Invalid=1);
    zip_internet_ALLOW_ErrorCount := COUNT(GROUP,h.zip_internet_Invalid=1);
    zip_internet_access_ALLOW_ErrorCount := COUNT(GROUP,h.zip_internet_access_Invalid=1);
    zip_internet_buy_ALLOW_ErrorCount := COUNT(GROUP,h.zip_internet_buy_Invalid=1);
    zip_music_ALLOW_ErrorCount := COUNT(GROUP,h.zip_music_Invalid=1);
    zip_outdoors_ALLOW_ErrorCount := COUNT(GROUP,h.zip_outdoors_Invalid=1);
    zip_pets_ALLOW_ErrorCount := COUNT(GROUP,h.zip_pets_Invalid=1);
    zip_pfin_ALLOW_ErrorCount := COUNT(GROUP,h.zip_pfin_Invalid=1);
    zip_publish_ALLOW_ErrorCount := COUNT(GROUP,h.zip_publish_Invalid=1);
    zip_publish_books_ALLOW_ErrorCount := COUNT(GROUP,h.zip_publish_books_Invalid=1);
    zip_publish_mags_ALLOW_ErrorCount := COUNT(GROUP,h.zip_publish_mags_Invalid=1);
    zip_sports_ALLOW_ErrorCount := COUNT(GROUP,h.zip_sports_Invalid=1);
    zip_sports_biking_ALLOW_ErrorCount := COUNT(GROUP,h.zip_sports_biking_Invalid=1);
    zip_sports_golf_ALLOW_ErrorCount := COUNT(GROUP,h.zip_sports_golf_Invalid=1);
    zip_travel_ALLOW_ErrorCount := COUNT(GROUP,h.zip_travel_Invalid=1);
    zip_travel_us_ALLOW_ErrorCount := COUNT(GROUP,h.zip_travel_us_Invalid=1);
    zip_tvmovies_ALLOW_ErrorCount := COUNT(GROUP,h.zip_tvmovies_Invalid=1);
    zip_woman_ALLOW_ErrorCount := COUNT(GROUP,h.zip_woman_Invalid=1);
    zip_proftech_ALLOW_ErrorCount := COUNT(GROUP,h.zip_proftech_Invalid=1);
    zip_retired_ALLOW_ErrorCount := COUNT(GROUP,h.zip_retired_Invalid=1);
    zip_inc100_ALLOW_ErrorCount := COUNT(GROUP,h.zip_inc100_Invalid=1);
    zip_inc75_ALLOW_ErrorCount := COUNT(GROUP,h.zip_inc75_Invalid=1);
    zip_inc50_ALLOW_ErrorCount := COUNT(GROUP,h.zip_inc50_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.dtmatch_Invalid > 0 OR h.msname_Invalid > 0 OR h.msaddr1_Invalid > 0 OR h.msaddr2_Invalid > 0 OR h.mscity_Invalid > 0 OR h.msstate_Invalid > 0 OR h.mszip5_Invalid > 0 OR h.mszip4_Invalid > 0 OR h.dthh_Invalid > 0 OR h.mscrrt_Invalid > 0 OR h.msdpbc_Invalid > 0 OR h.msdpv_Invalid > 0 OR h.ms_addrtype_Invalid > 0 OR h.ctysize_Invalid > 0 OR h.lmos_Invalid > 0 OR h.omos_Invalid > 0 OR h.pmos_Invalid > 0 OR h.gen_Invalid > 0 OR h.dob_Invalid > 0 OR h.age_Invalid > 0 OR h.inc_Invalid > 0 OR h.marital_status_Invalid > 0 OR h.poc_Invalid > 0 OR h.noc_Invalid > 0 OR h.ocp_Invalid > 0 OR h.edu_Invalid > 0 OR h.lang_Invalid > 0 OR h.relig_Invalid > 0 OR h.dwell_Invalid > 0 OR h.ownr_Invalid > 0 OR h.eth1_Invalid > 0 OR h.eth2_Invalid > 0 OR h.lor_Invalid > 0 OR h.pool_Invalid > 0 OR h.speak_span_Invalid > 0 OR h.soho_Invalid > 0 OR h.vet_in_hh_Invalid > 0 OR h.ms_mags_Invalid > 0 OR h.ms_books_Invalid > 0 OR h.ms_publish_Invalid > 0 OR h.ms_pub_status_active_Invalid > 0 OR h.ms_pub_status_expire_Invalid > 0 OR h.ms_pub_premsold_Invalid > 0 OR h.ms_pub_autornwl_Invalid > 0 OR h.ms_pub_avgterm_Invalid > 0 OR h.ms_pub_lmos_Invalid > 0 OR h.ms_pub_omos_Invalid > 0 OR h.ms_pub_pmos_Invalid > 0 OR h.ms_pub_cemos_Invalid > 0 OR h.ms_pub_femos_Invalid > 0 OR h.ms_pub_totords_Invalid > 0 OR h.ms_pub_totdlrs_Invalid > 0 OR h.ms_pub_avgdlrs_Invalid > 0 OR h.ms_pub_lastdlrs_Invalid > 0 OR h.ms_pub_paystat_paid_Invalid > 0 OR h.ms_pub_paystat_ub_Invalid > 0 OR h.ms_pub_paymeth_cc_Invalid > 0 OR h.ms_pub_paymeth_cash_Invalid > 0 OR h.ms_pub_payspeed_Invalid > 0 OR h.ms_pub_osrc_dm_Invalid > 0 OR h.ms_pub_lsrc_dm_Invalid > 0 OR h.ms_pub_osrc_agt_cashf_Invalid > 0 OR h.ms_pub_lsrc_agt_cashf_Invalid > 0 OR h.ms_pub_osrc_agt_pds_Invalid > 0 OR h.ms_pub_lsrc_agt_pds_Invalid > 0 OR h.ms_pub_osrc_agt_schplan_Invalid > 0 OR h.ms_pub_lsrc_agt_schplan_Invalid > 0 OR h.ms_pub_osrc_agt_sponsor_Invalid > 0 OR h.ms_pub_lsrc_agt_sponsor_Invalid > 0 OR h.ms_pub_osrc_agt_tm_Invalid > 0 OR h.ms_pub_lsrc_agt_tm_Invalid > 0 OR h.ms_pub_osrc_agt_Invalid > 0 OR h.ms_pub_lsrc_agt_Invalid > 0 OR h.ms_pub_osrc_tm_Invalid > 0 OR h.ms_pub_lsrc_tm_Invalid > 0 OR h.ms_pub_osrc_ins_Invalid > 0 OR h.ms_pub_lsrc_ins_Invalid > 0 OR h.ms_pub_osrc_net_Invalid > 0 OR h.ms_pub_lsrc_net_Invalid > 0 OR h.ms_pub_osrc_print_Invalid > 0 OR h.ms_pub_lsrc_print_Invalid > 0 OR h.ms_pub_osrc_trans_Invalid > 0 OR h.ms_pub_lsrc_trans_Invalid > 0 OR h.ms_pub_osrc_tv_Invalid > 0 OR h.ms_pub_lsrc_tv_Invalid > 0 OR h.ms_pub_osrc_dtp_Invalid > 0 OR h.ms_pub_lsrc_dtp_Invalid > 0 OR h.ms_pub_giftgivr_Invalid > 0 OR h.ms_pub_giftee_Invalid > 0 OR h.ms_catalog_Invalid > 0 OR h.ms_cat_lmos_Invalid > 0 OR h.ms_cat_omos_Invalid > 0 OR h.ms_cat_pmos_Invalid > 0 OR h.ms_cat_totords_Invalid > 0 OR h.ms_cat_totitems_Invalid > 0 OR h.ms_cat_totdlrs_Invalid > 0 OR h.ms_cat_avgdlrs_Invalid > 0 OR h.ms_cat_lastdlrs_Invalid > 0 OR h.ms_cat_paystat_paid_Invalid > 0 OR h.ms_cat_paymeth_cc_Invalid > 0 OR h.ms_cat_paymeth_cash_Invalid > 0 OR h.ms_cat_osrc_dm_Invalid > 0 OR h.ms_cat_lsrc_dm_Invalid > 0 OR h.ms_cat_osrc_net_Invalid > 0 OR h.ms_cat_lsrc_net_Invalid > 0 OR h.ms_cat_giftgivr_Invalid > 0 OR h.pkpubs_corrected_Invalid > 0 OR h.pkcatg_corrected_Invalid > 0 OR h.ms_fundraising_Invalid > 0 OR h.ms_fund_lmos_Invalid > 0 OR h.ms_fund_omos_Invalid > 0 OR h.ms_fund_pmos_Invalid > 0 OR h.ms_fund_totords_Invalid > 0 OR h.ms_fund_totdlrs_Invalid > 0 OR h.ms_fund_avgdlrs_Invalid > 0 OR h.ms_fund_lastdlrs_Invalid > 0 OR h.ms_fund_paystat_paid_Invalid > 0 OR h.ms_other_Invalid > 0 OR h.ms_continuity_Invalid > 0 OR h.ms_cont_status_active_Invalid > 0 OR h.ms_cont_status_cancel_Invalid > 0 OR h.ms_cont_omos_Invalid > 0 OR h.ms_cont_lmos_Invalid > 0 OR h.ms_cont_pmos_Invalid > 0 OR h.ms_cont_totords_Invalid > 0 OR h.ms_cont_totdlrs_Invalid > 0 OR h.ms_cont_avgdlrs_Invalid > 0 OR h.ms_cont_lastdlrs_Invalid > 0 OR h.ms_cont_paystat_paid_Invalid > 0 OR h.ms_cont_paymeth_cc_Invalid > 0 OR h.ms_cont_paymeth_cash_Invalid > 0 OR h.ms_totords_Invalid > 0 OR h.ms_totitems_Invalid > 0 OR h.ms_totdlrs_Invalid > 0 OR h.ms_avgdlrs_Invalid > 0 OR h.ms_lastdlrs_Invalid > 0 OR h.ms_paystat_paid_Invalid > 0 OR h.ms_paymeth_cc_Invalid > 0 OR h.ms_paymeth_cash_Invalid > 0 OR h.ms_osrc_dm_Invalid > 0 OR h.ms_lsrc_dm_Invalid > 0 OR h.ms_osrc_tm_Invalid > 0 OR h.ms_lsrc_tm_Invalid > 0 OR h.ms_osrc_ins_Invalid > 0 OR h.ms_lsrc_ins_Invalid > 0 OR h.ms_osrc_net_Invalid > 0 OR h.ms_lsrc_net_Invalid > 0 OR h.ms_osrc_tv_Invalid > 0 OR h.ms_lsrc_tv_Invalid > 0 OR h.ms_osrc_retail_Invalid > 0 OR h.ms_lsrc_retail_Invalid > 0 OR h.ms_giftgivr_Invalid > 0 OR h.ms_giftee_Invalid > 0 OR h.ms_adult_Invalid > 0 OR h.ms_womapp_Invalid > 0 OR h.ms_menapp_Invalid > 0 OR h.ms_kidapp_Invalid > 0 OR h.ms_accessory_Invalid > 0 OR h.ms_apparel_Invalid > 0 OR h.ms_app_lmos_Invalid > 0 OR h.ms_app_omos_Invalid > 0 OR h.ms_app_pmos_Invalid > 0 OR h.ms_app_totords_Invalid > 0 OR h.ms_app_totitems_Invalid > 0 OR h.ms_app_totdlrs_Invalid > 0 OR h.ms_app_avgdlrs_Invalid > 0 OR h.ms_app_lastdlrs_Invalid > 0 OR h.ms_app_paystat_paid_Invalid > 0 OR h.ms_app_paymeth_cc_Invalid > 0 OR h.ms_app_paymeth_cash_Invalid > 0 OR h.ms_menfash_Invalid > 0 OR h.ms_womfash_Invalid > 0 OR h.ms_wfsh_lmos_Invalid > 0 OR h.ms_wfsh_omos_Invalid > 0 OR h.ms_wfsh_pmos_Invalid > 0 OR h.ms_wfsh_totords_Invalid > 0 OR h.ms_wfsh_totdlrs_Invalid > 0 OR h.ms_wfsh_avgdlrs_Invalid > 0 OR h.ms_wfsh_lastdlrs_Invalid > 0 OR h.ms_wfsh_paystat_paid_Invalid > 0 OR h.ms_wfsh_osrc_dm_Invalid > 0 OR h.ms_wfsh_lsrc_dm_Invalid > 0 OR h.ms_wfsh_osrc_agt_Invalid > 0 OR h.ms_wfsh_lsrc_agt_Invalid > 0 OR h.ms_audio_Invalid > 0 OR h.ms_auto_Invalid > 0 OR h.ms_aviation_Invalid > 0 OR h.ms_bargains_Invalid > 0 OR h.ms_beauty_Invalid > 0 OR h.ms_bible_Invalid > 0 OR h.ms_bible_lmos_Invalid > 0 OR h.ms_bible_omos_Invalid > 0 OR h.ms_bible_pmos_Invalid > 0 OR h.ms_bible_totords_Invalid > 0 OR h.ms_bible_totitems_Invalid > 0 OR h.ms_bible_totdlrs_Invalid > 0 OR h.ms_bible_avgdlrs_Invalid > 0 OR h.ms_bible_lastdlrs_Invalid > 0 OR h.ms_bible_paystat_paid_Invalid > 0 OR h.ms_bible_paymeth_cc_Invalid > 0 OR h.ms_bible_paymeth_cash_Invalid > 0 OR h.ms_business_Invalid > 0 OR h.ms_collectibles_Invalid > 0 OR h.ms_computers_Invalid > 0 OR h.ms_crafts_Invalid > 0 OR h.ms_culturearts_Invalid > 0 OR h.ms_currevent_Invalid > 0 OR h.ms_diy_Invalid > 0 OR h.ms_electronics_Invalid > 0 OR h.ms_equestrian_Invalid > 0 OR h.ms_pub_family_Invalid > 0 OR h.ms_cat_family_Invalid > 0 OR h.ms_family_Invalid > 0 OR h.ms_family_lmos_Invalid > 0 OR h.ms_family_omos_Invalid > 0 OR h.ms_family_pmos_Invalid > 0 OR h.ms_family_totords_Invalid > 0 OR h.ms_family_totitems_Invalid > 0 OR h.ms_family_totdlrs_Invalid > 0 OR h.ms_family_avgdlrs_Invalid > 0 OR h.ms_family_lastdlrs_Invalid > 0 OR h.ms_family_paystat_paid_Invalid > 0 OR h.ms_family_paymeth_cc_Invalid > 0 OR h.ms_family_paymeth_cash_Invalid > 0 OR h.ms_family_osrc_dm_Invalid > 0 OR h.ms_family_lsrc_dm_Invalid > 0 OR h.ms_fiction_Invalid > 0 OR h.ms_food_Invalid > 0 OR h.ms_games_Invalid > 0 OR h.ms_gifts_Invalid > 0 OR h.ms_gourmet_Invalid > 0 OR h.ms_fitness_Invalid > 0 OR h.ms_health_Invalid > 0 OR h.ms_hlth_lmos_Invalid > 0 OR h.ms_hlth_omos_Invalid > 0 OR h.ms_hlth_pmos_Invalid > 0 OR h.ms_hlth_totords_Invalid > 0 OR h.ms_hlth_totdlrs_Invalid > 0 OR h.ms_hlth_avgdlrs_Invalid > 0 OR h.ms_hlth_lastdlrs_Invalid > 0 OR h.ms_hlth_paystat_paid_Invalid > 0 OR h.ms_hlth_paymeth_cc_Invalid > 0 OR h.ms_hlth_osrc_dm_Invalid > 0 OR h.ms_hlth_lsrc_dm_Invalid > 0 OR h.ms_hlth_osrc_agt_Invalid > 0 OR h.ms_hlth_lsrc_agt_Invalid > 0 OR h.ms_hlth_osrc_tv_Invalid > 0 OR h.ms_hlth_lsrc_tv_Invalid > 0 OR h.ms_holiday_Invalid > 0 OR h.ms_history_Invalid > 0 OR h.ms_pub_cooking_Invalid > 0 OR h.ms_cooking_Invalid > 0 OR h.ms_pub_homedecr_Invalid > 0 OR h.ms_cat_homedecr_Invalid > 0 OR h.ms_homedecr_Invalid > 0 OR h.ms_housewares_Invalid > 0 OR h.ms_pub_garden_Invalid > 0 OR h.ms_cat_garden_Invalid > 0 OR h.ms_garden_Invalid > 0 OR h.ms_pub_homeliv_Invalid > 0 OR h.ms_cat_homeliv_Invalid > 0 OR h.ms_homeliv_Invalid > 0 OR h.ms_pub_home_status_active_Invalid > 0 OR h.ms_home_lmos_Invalid > 0 OR h.ms_home_omos_Invalid > 0 OR h.ms_home_pmos_Invalid > 0 OR h.ms_home_totords_Invalid > 0 OR h.ms_home_totitems_Invalid > 0 OR h.ms_home_totdlrs_Invalid > 0 OR h.ms_home_avgdlrs_Invalid > 0 OR h.ms_home_lastdlrs_Invalid > 0 OR h.ms_home_paystat_paid_Invalid > 0 OR h.ms_home_paymeth_cc_Invalid > 0 OR h.ms_home_paymeth_cash_Invalid > 0 OR h.ms_home_osrc_dm_Invalid > 0 OR h.ms_home_lsrc_dm_Invalid > 0 OR h.ms_home_osrc_agt_Invalid > 0 OR h.ms_home_lsrc_agt_Invalid > 0 OR h.ms_home_osrc_net_Invalid > 0 OR h.ms_home_lsrc_net_Invalid > 0 OR h.ms_home_osrc_tv_Invalid > 0 OR h.ms_home_lsrc_tv_Invalid > 0 OR h.ms_humor_Invalid > 0 OR h.ms_inspiration_Invalid > 0 OR h.ms_merchandise_Invalid > 0 OR h.ms_moneymaking_Invalid > 0 OR h.ms_moneymaking_lmos_Invalid > 0 OR h.ms_motorcycles_Invalid > 0 OR h.ms_music_Invalid > 0 OR h.ms_fishing_Invalid > 0 OR h.ms_hunting_Invalid > 0 OR h.ms_boatsail_Invalid > 0 OR h.ms_camp_Invalid > 0 OR h.ms_pub_outdoors_Invalid > 0 OR h.ms_cat_outdoors_Invalid > 0 OR h.ms_outdoors_Invalid > 0 OR h.ms_pub_out_status_active_Invalid > 0 OR h.ms_out_lmos_Invalid > 0 OR h.ms_out_omos_Invalid > 0 OR h.ms_out_pmos_Invalid > 0 OR h.ms_out_totords_Invalid > 0 OR h.ms_out_totitems_Invalid > 0 OR h.ms_out_totdlrs_Invalid > 0 OR h.ms_out_avgdlrs_Invalid > 0 OR h.ms_out_lastdlrs_Invalid > 0 OR h.ms_out_paystat_paid_Invalid > 0 OR h.ms_out_paymeth_cc_Invalid > 0 OR h.ms_out_paymeth_cash_Invalid > 0 OR h.ms_out_osrc_dm_Invalid > 0 OR h.ms_out_lsrc_dm_Invalid > 0 OR h.ms_out_osrc_agt_Invalid > 0 OR h.ms_out_lsrc_agt_Invalid > 0 OR h.ms_pets_Invalid > 0 OR h.ms_pfin_Invalid > 0 OR h.ms_photo_Invalid > 0 OR h.ms_photoproc_Invalid > 0 OR h.ms_rural_Invalid > 0 OR h.ms_science_Invalid > 0 OR h.ms_sports_Invalid > 0 OR h.ms_sports_lmos_Invalid > 0 OR h.ms_travel_Invalid > 0 OR h.ms_tvmovies_Invalid > 0 OR h.ms_wildlife_Invalid > 0 OR h.ms_woman_Invalid > 0 OR h.ms_woman_lmos_Invalid > 0 OR h.ms_ringtones_apps_Invalid > 0 OR h.cpi_mobile_apps_index_Invalid > 0 OR h.cpi_credit_repair_index_Invalid > 0 OR h.cpi_credit_report_index_Invalid > 0 OR h.cpi_education_seekers_index_Invalid > 0 OR h.cpi_insurance_index_Invalid > 0 OR h.cpi_insurance_health_index_Invalid > 0 OR h.cpi_insurance_auto_index_Invalid > 0 OR h.cpi_job_seekers_index_Invalid > 0 OR h.cpi_social_networking_index_Invalid > 0 OR h.cpi_adult_index_Invalid > 0 OR h.cpi_africanamerican_index_Invalid > 0 OR h.cpi_apparel_index_Invalid > 0 OR h.cpi_apparel_accessory_index_Invalid > 0 OR h.cpi_apparel_kids_index_Invalid > 0 OR h.cpi_apparel_men_index_Invalid > 0 OR h.cpi_apparel_menfash_index_Invalid > 0 OR h.cpi_apparel_women_index_Invalid > 0 OR h.cpi_apparel_womfash_index_Invalid > 0 OR h.cpi_asian_index_Invalid > 0 OR h.cpi_auto_index_Invalid > 0 OR h.cpi_auto_racing_index_Invalid > 0 OR h.cpi_auto_trucks_index_Invalid > 0 OR h.cpi_aviation_index_Invalid > 0 OR h.cpi_bargains_index_Invalid > 0 OR h.cpi_beauty_index_Invalid > 0 OR h.cpi_bible_index_Invalid > 0 OR h.cpi_birds_index_Invalid > 0 OR h.cpi_business_index_Invalid > 0 OR h.cpi_business_homeoffice_index_Invalid > 0 OR h.cpi_catalog_index_Invalid > 0 OR h.cpi_cc_index_Invalid > 0 OR h.cpi_collectibles_index_Invalid > 0 OR h.cpi_college_index_Invalid > 0 OR h.cpi_computers_index_Invalid > 0 OR h.cpi_conservative_index_Invalid > 0 OR h.cpi_continuity_index_Invalid > 0 OR h.cpi_cooking_index_Invalid > 0 OR h.cpi_crafts_index_Invalid > 0 OR h.cpi_crafts_crochet_index_Invalid > 0 OR h.cpi_crafts_knit_index_Invalid > 0 OR h.cpi_crafts_needlepoint_index_Invalid > 0 OR h.cpi_crafts_quilt_index_Invalid > 0 OR h.cpi_crafts_sew_index_Invalid > 0 OR h.cpi_culturearts_index_Invalid > 0 OR h.cpi_currevent_index_Invalid > 0 OR h.cpi_diy_index_Invalid > 0 OR h.cpi_donor_index_Invalid > 0 OR h.cpi_ego_index_Invalid > 0 OR h.cpi_electronics_index_Invalid > 0 OR h.cpi_equestrian_index_Invalid > 0 OR h.cpi_family_index_Invalid > 0 OR h.cpi_family_teen_index_Invalid > 0 OR h.cpi_family_young_index_Invalid > 0 OR h.cpi_fiction_index_Invalid > 0 OR h.cpi_gambling_index_Invalid > 0 OR h.cpi_games_index_Invalid > 0 OR h.cpi_gardening_index_Invalid > 0 OR h.cpi_gay_index_Invalid > 0 OR h.cpi_giftgivr_index_Invalid > 0 OR h.cpi_gourmet_index_Invalid > 0 OR h.cpi_grandparents_index_Invalid > 0 OR h.cpi_health_index_Invalid > 0 OR h.cpi_health_diet_index_Invalid > 0 OR h.cpi_health_fitness_index_Invalid > 0 OR h.cpi_hightech_index_Invalid > 0 OR h.cpi_hispanic_index_Invalid > 0 OR h.cpi_history_index_Invalid > 0 OR h.cpi_history_american_index_Invalid > 0 OR h.cpi_hobbies_index_Invalid > 0 OR h.cpi_homedecr_index_Invalid > 0 OR h.cpi_homeliv_index_Invalid > 0 OR h.cpi_humor_index_Invalid > 0 OR h.cpi_inspiration_index_Invalid > 0 OR h.cpi_internet_index_Invalid > 0 OR h.cpi_internet_access_index_Invalid > 0 OR h.cpi_internet_buy_index_Invalid > 0 OR h.cpi_liberal_index_Invalid > 0 OR h.cpi_moneymaking_index_Invalid > 0 OR h.cpi_motorcycles_index_Invalid > 0 OR h.cpi_music_index_Invalid > 0 OR h.cpi_nonfiction_index_Invalid > 0 OR h.cpi_ocean_index_Invalid > 0 OR h.cpi_outdoors_index_Invalid > 0 OR h.cpi_outdoors_boatsail_index_Invalid > 0 OR h.cpi_outdoors_camp_index_Invalid > 0 OR h.cpi_outdoors_fishing_index_Invalid > 0 OR h.cpi_outdoors_huntfish_index_Invalid > 0 OR h.cpi_outdoors_hunting_index_Invalid > 0 OR h.cpi_pets_index_Invalid > 0 OR h.cpi_pets_cats_index_Invalid > 0 OR h.cpi_pets_dogs_index_Invalid > 0 OR h.cpi_pfin_index_Invalid > 0 OR h.cpi_photog_index_Invalid > 0 OR h.cpi_photoproc_index_Invalid > 0 OR h.cpi_publish_index_Invalid > 0 OR h.cpi_publish_books_index_Invalid > 0 OR h.cpi_publish_mags_index_Invalid > 0 OR h.cpi_rural_index_Invalid > 0 OR h.cpi_science_index_Invalid > 0 OR h.cpi_scifi_index_Invalid > 0 OR h.cpi_seniors_index_Invalid > 0 OR h.cpi_sports_index_Invalid > 0 OR h.cpi_sports_baseball_index_Invalid > 0 OR h.cpi_sports_basketball_index_Invalid > 0 OR h.cpi_sports_biking_index_Invalid > 0 OR h.cpi_sports_football_index_Invalid > 0 OR h.cpi_sports_golf_index_Invalid > 0 OR h.cpi_sports_hockey_index_Invalid > 0 OR h.cpi_sports_running_index_Invalid > 0 OR h.cpi_sports_ski_index_Invalid > 0 OR h.cpi_sports_soccer_index_Invalid > 0 OR h.cpi_sports_swimming_index_Invalid > 0 OR h.cpi_sports_tennis_index_Invalid > 0 OR h.cpi_stationery_index_Invalid > 0 OR h.cpi_sweeps_index_Invalid > 0 OR h.cpi_tobacco_index_Invalid > 0 OR h.cpi_travel_index_Invalid > 0 OR h.cpi_travel_cruise_index_Invalid > 0 OR h.cpi_travel_rv_index_Invalid > 0 OR h.cpi_travel_us_index_Invalid > 0 OR h.cpi_tvmovies_index_Invalid > 0 OR h.cpi_wildlife_index_Invalid > 0 OR h.cpi_woman_index_Invalid > 0 OR h.totdlr_index_Invalid > 0 OR h.cpi_totdlr_Invalid > 0 OR h.cpi_totords_Invalid > 0 OR h.cpi_lastdlr_Invalid > 0 OR h.pkcatg_Invalid > 0 OR h.pkpubs_Invalid > 0 OR h.pkcont_Invalid > 0 OR h.pkca01_Invalid > 0 OR h.pkca03_Invalid > 0 OR h.pkca04_Invalid > 0 OR h.pkca05_Invalid > 0 OR h.pkca06_Invalid > 0 OR h.pkca07_Invalid > 0 OR h.pkca08_Invalid > 0 OR h.pkca09_Invalid > 0 OR h.pkca10_Invalid > 0 OR h.pkca11_Invalid > 0 OR h.pkca12_Invalid > 0 OR h.pkca13_Invalid > 0 OR h.pkca14_Invalid > 0 OR h.pkca15_Invalid > 0 OR h.pkca16_Invalid > 0 OR h.pkca17_Invalid > 0 OR h.pkca18_Invalid > 0 OR h.pkca20_Invalid > 0 OR h.pkca21_Invalid > 0 OR h.pkca22_Invalid > 0 OR h.pkca23_Invalid > 0 OR h.pkca24_Invalid > 0 OR h.pkca25_Invalid > 0 OR h.pkca26_Invalid > 0 OR h.pkca28_Invalid > 0 OR h.pkca29_Invalid > 0 OR h.pkca30_Invalid > 0 OR h.pkca31_Invalid > 0 OR h.pkca32_Invalid > 0 OR h.pkca33_Invalid > 0 OR h.pkca34_Invalid > 0 OR h.pkca35_Invalid > 0 OR h.pkca36_Invalid > 0 OR h.pkca37_Invalid > 0 OR h.pkca39_Invalid > 0 OR h.pkca40_Invalid > 0 OR h.pkca41_Invalid > 0 OR h.pkca42_Invalid > 0 OR h.pkca54_Invalid > 0 OR h.pkca61_Invalid > 0 OR h.pkca62_Invalid > 0 OR h.pkca64_Invalid > 0 OR h.pkpu01_Invalid > 0 OR h.pkpu02_Invalid > 0 OR h.pkpu03_Invalid > 0 OR h.pkpu04_Invalid > 0 OR h.pkpu05_Invalid > 0 OR h.pkpu06_Invalid > 0 OR h.pkpu07_Invalid > 0 OR h.pkpu08_Invalid > 0 OR h.pkpu09_Invalid > 0 OR h.pkpu10_Invalid > 0 OR h.pkpu11_Invalid > 0 OR h.pkpu12_Invalid > 0 OR h.pkpu13_Invalid > 0 OR h.pkpu14_Invalid > 0 OR h.pkpu15_Invalid > 0 OR h.pkpu16_Invalid > 0 OR h.pkpu17_Invalid > 0 OR h.pkpu18_Invalid > 0 OR h.pkpu19_Invalid > 0 OR h.pkpu20_Invalid > 0 OR h.pkpu23_Invalid > 0 OR h.pkpu25_Invalid > 0 OR h.pkpu27_Invalid > 0 OR h.pkpu28_Invalid > 0 OR h.pkpu29_Invalid > 0 OR h.pkpu30_Invalid > 0 OR h.pkpu31_Invalid > 0 OR h.pkpu32_Invalid > 0 OR h.pkpu33_Invalid > 0 OR h.pkpu34_Invalid > 0 OR h.pkpu35_Invalid > 0 OR h.pkpu38_Invalid > 0 OR h.pkpu41_Invalid > 0 OR h.pkpu42_Invalid > 0 OR h.pkpu45_Invalid > 0 OR h.pkpu46_Invalid > 0 OR h.pkpu47_Invalid > 0 OR h.pkpu48_Invalid > 0 OR h.pkpu49_Invalid > 0 OR h.pkpu50_Invalid > 0 OR h.pkpu51_Invalid > 0 OR h.pkpu52_Invalid > 0 OR h.pkpu53_Invalid > 0 OR h.pkpu54_Invalid > 0 OR h.pkpu55_Invalid > 0 OR h.pkpu56_Invalid > 0 OR h.pkpu57_Invalid > 0 OR h.pkpu60_Invalid > 0 OR h.pkpu61_Invalid > 0 OR h.pkpu62_Invalid > 0 OR h.pkpu63_Invalid > 0 OR h.pkpu64_Invalid > 0 OR h.pkpu65_Invalid > 0 OR h.pkpu66_Invalid > 0 OR h.pkpu67_Invalid > 0 OR h.pkpu68_Invalid > 0 OR h.pkpu69_Invalid > 0 OR h.pkpu70_Invalid > 0 OR h.censpct_water_Invalid > 0 OR h.cens_pop_density_Invalid > 0 OR h.cens_hu_density_Invalid > 0 OR h.censpct_pop_white_Invalid > 0 OR h.censpct_pop_black_Invalid > 0 OR h.censpct_pop_amerind_Invalid > 0 OR h.censpct_pop_asian_Invalid > 0 OR h.censpct_pop_pacisl_Invalid > 0 OR h.censpct_pop_othrace_Invalid > 0 OR h.censpct_pop_multirace_Invalid > 0 OR h.censpct_pop_hispanic_Invalid > 0 OR h.censpct_pop_agelt18_Invalid > 0 OR h.censpct_pop_males_Invalid > 0 OR h.censpct_adult_age1824_Invalid > 0 OR h.censpct_adult_age2534_Invalid > 0 OR h.censpct_adult_age3544_Invalid > 0 OR h.censpct_adult_age4554_Invalid > 0 OR h.censpct_adult_age5564_Invalid > 0 OR h.censpct_adult_agege65_Invalid > 0 OR h.cens_pop_medage_Invalid > 0 OR h.cens_hh_avgsize_Invalid > 0 OR h.censpct_hh_family_Invalid > 0 OR h.censpct_hh_family_husbwife_Invalid > 0 OR h.censpct_hu_occupied_Invalid > 0 OR h.censpct_hu_owned_Invalid > 0 OR h.censpct_hu_rented_Invalid > 0 OR h.censpct_hu_vacantseasonal_Invalid > 0 OR h.zip_medinc_Invalid > 0 OR h.zip_apparel_Invalid > 0 OR h.zip_apparel_women_Invalid > 0 OR h.zip_apparel_womfash_Invalid > 0 OR h.zip_auto_Invalid > 0 OR h.zip_beauty_Invalid > 0 OR h.zip_booksmusicmovies_Invalid > 0 OR h.zip_business_Invalid > 0 OR h.zip_catalog_Invalid > 0 OR h.zip_cc_Invalid > 0 OR h.zip_collectibles_Invalid > 0 OR h.zip_computers_Invalid > 0 OR h.zip_continuity_Invalid > 0 OR h.zip_cooking_Invalid > 0 OR h.zip_crafts_Invalid > 0 OR h.zip_culturearts_Invalid > 0 OR h.zip_dm_sold_Invalid > 0 OR h.zip_donor_Invalid > 0 OR h.zip_family_Invalid > 0 OR h.zip_gardening_Invalid > 0 OR h.zip_giftgivr_Invalid > 0 OR h.zip_gourmet_Invalid > 0 OR h.zip_health_Invalid > 0 OR h.zip_health_diet_Invalid > 0 OR h.zip_health_fitness_Invalid > 0 OR h.zip_hobbies_Invalid > 0 OR h.zip_homedecr_Invalid > 0 OR h.zip_homeliv_Invalid > 0 OR h.zip_internet_Invalid > 0 OR h.zip_internet_access_Invalid > 0 OR h.zip_internet_buy_Invalid > 0 OR h.zip_music_Invalid > 0 OR h.zip_outdoors_Invalid > 0 OR h.zip_pets_Invalid > 0 OR h.zip_pfin_Invalid > 0 OR h.zip_publish_Invalid > 0 OR h.zip_publish_books_Invalid > 0 OR h.zip_publish_mags_Invalid > 0 OR h.zip_sports_Invalid > 0 OR h.zip_sports_biking_Invalid > 0 OR h.zip_sports_golf_Invalid > 0 OR h.zip_travel_Invalid > 0 OR h.zip_travel_us_Invalid > 0 OR h.zip_tvmovies_Invalid > 0 OR h.zip_woman_Invalid > 0 OR h.zip_proftech_Invalid > 0 OR h.zip_retired_Invalid > 0 OR h.zip_inc100_Invalid > 0 OR h.zip_inc75_Invalid > 0 OR h.zip_inc50_Invalid > 0);
    AnyRule_WithEditsCount := COUNT(GROUP, h.dtmatch_wouldClean OR h.msname_wouldClean OR h.msaddr1_wouldClean OR h.msaddr2_wouldClean OR h.mscity_wouldClean OR h.msstate_wouldClean OR h.mszip5_wouldClean OR h.mszip4_wouldClean OR h.dthh_wouldClean OR h.mscrrt_wouldClean OR h.msdpbc_wouldClean OR h.msdpv_wouldClean OR h.ms_addrtype_wouldClean OR h.ctysize_wouldClean OR h.noc_wouldClean OR h.lang_wouldClean OR h.eth1_wouldClean OR h.eth2_wouldClean OR h.lor_wouldClean OR h.pool_wouldClean OR h.speak_span_wouldClean OR h.soho_wouldClean OR h.vet_in_hh_wouldClean);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
    Rules_WithEdits := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.dtmatch_Total_ErrorCount > 0, 1, 0) + IF(le.msname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.msaddr1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.msaddr2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mscity_Total_ErrorCount > 0, 1, 0) + IF(le.msstate_Total_ErrorCount > 0, 1, 0) + IF(le.mszip5_Total_ErrorCount > 0, 1, 0) + IF(le.mszip4_Total_ErrorCount > 0, 1, 0) + IF(le.dthh_Total_ErrorCount > 0, 1, 0) + IF(le.mscrrt_Total_ErrorCount > 0, 1, 0) + IF(le.msdpbc_Total_ErrorCount > 0, 1, 0) + IF(le.msdpv_Total_ErrorCount > 0, 1, 0) + IF(le.ms_addrtype_Total_ErrorCount > 0, 1, 0) + IF(le.ctysize_Total_ErrorCount > 0, 1, 0) + IF(le.lmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.omos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.gen_Total_ErrorCount > 0, 1, 0) + IF(le.dob_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.age_ALLOW_ErrorCount > 0, 1, 0) + IF(le.inc_Total_ErrorCount > 0, 1, 0) + IF(le.marital_status_ALLOW_ErrorCount > 0, 1, 0) + IF(le.poc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.noc_Total_ErrorCount > 0, 1, 0) + IF(le.ocp_Total_ErrorCount > 0, 1, 0) + IF(le.edu_Total_ErrorCount > 0, 1, 0) + IF(le.lang_Total_ErrorCount > 0, 1, 0) + IF(le.relig_Total_ErrorCount > 0, 1, 0) + IF(le.dwell_Total_ErrorCount > 0, 1, 0) + IF(le.ownr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.eth1_Total_ErrorCount > 0, 1, 0) + IF(le.eth2_Total_ErrorCount > 0, 1, 0) + IF(le.lor_Total_ErrorCount > 0, 1, 0) + IF(le.pool_Total_ErrorCount > 0, 1, 0) + IF(le.speak_span_Total_ErrorCount > 0, 1, 0) + IF(le.soho_Total_ErrorCount > 0, 1, 0) + IF(le.vet_in_hh_Total_ErrorCount > 0, 1, 0) + IF(le.ms_mags_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_books_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_publish_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_status_active_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_status_expire_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_premsold_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_autornwl_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_avgterm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_lmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_omos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_pmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_cemos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_femos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_totords_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_totdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_avgdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_lastdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_paystat_paid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_paystat_ub_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_paymeth_cc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_paymeth_cash_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_payspeed_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_osrc_dm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_lsrc_dm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_osrc_agt_cashf_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_lsrc_agt_cashf_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_osrc_agt_pds_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_lsrc_agt_pds_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_osrc_agt_schplan_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_lsrc_agt_schplan_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_osrc_agt_sponsor_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_lsrc_agt_sponsor_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_osrc_agt_tm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_lsrc_agt_tm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_osrc_agt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_lsrc_agt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_osrc_tm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_lsrc_tm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_osrc_ins_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_lsrc_ins_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_osrc_net_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_lsrc_net_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_osrc_print_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_lsrc_print_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_osrc_trans_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_lsrc_trans_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_osrc_tv_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_lsrc_tv_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_osrc_dtp_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_lsrc_dtp_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_giftgivr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_giftee_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_catalog_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cat_lmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cat_omos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cat_pmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cat_totords_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cat_totitems_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cat_totdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cat_avgdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cat_lastdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cat_paystat_paid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cat_paymeth_cc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cat_paymeth_cash_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cat_osrc_dm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cat_lsrc_dm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cat_osrc_net_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cat_lsrc_net_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cat_giftgivr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpubs_corrected_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkcatg_corrected_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_fundraising_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_fund_lmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_fund_omos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_fund_pmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_fund_totords_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_fund_totdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_fund_avgdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_fund_lastdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_fund_paystat_paid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_other_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_continuity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cont_status_active_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cont_status_cancel_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cont_omos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cont_lmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cont_pmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cont_totords_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cont_totdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cont_avgdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cont_lastdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cont_paystat_paid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cont_paymeth_cc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cont_paymeth_cash_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_totords_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_totitems_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_totdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_avgdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_lastdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_paystat_paid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_paymeth_cc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_paymeth_cash_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_osrc_dm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_lsrc_dm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_osrc_tm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_lsrc_tm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_osrc_ins_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_lsrc_ins_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_osrc_net_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_lsrc_net_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_osrc_tv_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_lsrc_tv_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_osrc_retail_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_lsrc_retail_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_giftgivr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_giftee_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_adult_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_womapp_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_menapp_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_kidapp_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_accessory_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_apparel_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_app_lmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_app_omos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_app_pmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_app_totords_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_app_totitems_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_app_totdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_app_avgdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_app_lastdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_app_paystat_paid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_app_paymeth_cc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_app_paymeth_cash_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_menfash_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_womfash_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_wfsh_lmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_wfsh_omos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_wfsh_pmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_wfsh_totords_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_wfsh_totdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_wfsh_avgdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_wfsh_lastdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_wfsh_paystat_paid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_wfsh_osrc_dm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_wfsh_lsrc_dm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_wfsh_osrc_agt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_wfsh_lsrc_agt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_audio_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_auto_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_aviation_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_bargains_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_beauty_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_bible_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_bible_lmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_bible_omos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_bible_pmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_bible_totords_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_bible_totitems_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_bible_totdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_bible_avgdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_bible_lastdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_bible_paystat_paid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_bible_paymeth_cc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_bible_paymeth_cash_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_business_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_collectibles_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_computers_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_crafts_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_culturearts_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_currevent_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_diy_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_electronics_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_equestrian_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_family_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cat_family_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_family_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_family_lmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_family_omos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_family_pmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_family_totords_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_family_totitems_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_family_totdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_family_avgdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_family_lastdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_family_paystat_paid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_family_paymeth_cc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_family_paymeth_cash_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_family_osrc_dm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_family_lsrc_dm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_fiction_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_food_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_games_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_gifts_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_gourmet_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_fitness_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_health_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_hlth_lmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_hlth_omos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_hlth_pmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_hlth_totords_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_hlth_totdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_hlth_avgdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_hlth_lastdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_hlth_paystat_paid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_hlth_paymeth_cc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_hlth_osrc_dm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_hlth_lsrc_dm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_hlth_osrc_agt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_hlth_lsrc_agt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_hlth_osrc_tv_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_hlth_lsrc_tv_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_holiday_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_history_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_cooking_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cooking_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_homedecr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cat_homedecr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_homedecr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_housewares_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_garden_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cat_garden_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_garden_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_homeliv_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cat_homeliv_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_homeliv_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_home_status_active_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_home_lmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_home_omos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_home_pmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_home_totords_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_home_totitems_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_home_totdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_home_avgdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_home_lastdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_home_paystat_paid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_home_paymeth_cc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_home_paymeth_cash_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_home_osrc_dm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_home_lsrc_dm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_home_osrc_agt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_home_lsrc_agt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_home_osrc_net_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_home_lsrc_net_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_home_osrc_tv_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_home_lsrc_tv_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_humor_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_inspiration_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_merchandise_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_moneymaking_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_moneymaking_lmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_motorcycles_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_music_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_fishing_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_hunting_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_boatsail_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_camp_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_outdoors_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cat_outdoors_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_outdoors_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_out_status_active_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_out_lmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_out_omos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_out_pmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_out_totords_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_out_totitems_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_out_totdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_out_avgdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_out_lastdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_out_paystat_paid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_out_paymeth_cc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_out_paymeth_cash_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_out_osrc_dm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_out_lsrc_dm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_out_osrc_agt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_out_lsrc_agt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pets_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pfin_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_photo_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_photoproc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_rural_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_science_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_sports_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_sports_lmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_travel_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_tvmovies_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_wildlife_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_woman_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_woman_lmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_ringtones_apps_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_mobile_apps_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_credit_repair_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_credit_report_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_education_seekers_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_insurance_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_insurance_health_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_insurance_auto_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_job_seekers_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_social_networking_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_adult_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_africanamerican_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_apparel_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_apparel_accessory_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_apparel_kids_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_apparel_men_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_apparel_menfash_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_apparel_women_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_apparel_womfash_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_asian_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_auto_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_auto_racing_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_auto_trucks_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_aviation_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_bargains_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_beauty_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_bible_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_birds_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_business_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_business_homeoffice_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_catalog_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_cc_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_collectibles_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_college_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_computers_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_conservative_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_continuity_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_cooking_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_crafts_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_crafts_crochet_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_crafts_knit_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_crafts_needlepoint_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_crafts_quilt_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_crafts_sew_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_culturearts_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_currevent_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_diy_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_donor_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_ego_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_electronics_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_equestrian_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_family_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_family_teen_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_family_young_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_fiction_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_gambling_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_games_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_gardening_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_gay_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_giftgivr_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_gourmet_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_grandparents_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_health_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_health_diet_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_health_fitness_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_hightech_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_hispanic_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_history_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_history_american_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_hobbies_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_homedecr_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_homeliv_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_humor_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_inspiration_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_internet_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_internet_access_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_internet_buy_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_liberal_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_moneymaking_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_motorcycles_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_music_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_nonfiction_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_ocean_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_outdoors_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_outdoors_boatsail_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_outdoors_camp_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_outdoors_fishing_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_outdoors_huntfish_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_outdoors_hunting_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_pets_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_pets_cats_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_pets_dogs_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_pfin_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_photog_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_photoproc_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_publish_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_publish_books_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_publish_mags_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_rural_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_science_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_scifi_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_seniors_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_sports_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_sports_baseball_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_sports_basketball_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_sports_biking_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_sports_football_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_sports_golf_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_sports_hockey_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_sports_running_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_sports_ski_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_sports_soccer_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_sports_swimming_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_sports_tennis_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_stationery_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_sweeps_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_tobacco_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_travel_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_travel_cruise_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_travel_rv_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_travel_us_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_tvmovies_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_wildlife_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_woman_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.totdlr_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_totdlr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_totords_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_lastdlr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkcatg_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpubs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkcont_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca01_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca03_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca04_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca05_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca06_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca07_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca08_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca09_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca10_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca11_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca13_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca14_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca15_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca16_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca17_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca18_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca20_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca21_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca22_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca23_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca25_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca26_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca28_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca29_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca30_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca31_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca32_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca33_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca34_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca35_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca36_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca37_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca39_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca40_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca41_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca42_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca54_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca61_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca62_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca64_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu01_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu02_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu03_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu04_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu05_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu06_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu07_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu08_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu09_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu10_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu11_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu13_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu14_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu15_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu16_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu17_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu18_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu19_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu20_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu23_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu25_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu27_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu28_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu29_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu30_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu31_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu32_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu33_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu34_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu35_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu38_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu41_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu42_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu45_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu46_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu47_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu48_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu49_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu50_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu51_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu52_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu53_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu54_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu55_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu56_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu57_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu60_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu61_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu62_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu63_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu64_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu65_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu66_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu67_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu68_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu69_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu70_ALLOW_ErrorCount > 0, 1, 0) + IF(le.censpct_water_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cens_pop_density_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cens_hu_density_ALLOW_ErrorCount > 0, 1, 0) + IF(le.censpct_pop_white_ALLOW_ErrorCount > 0, 1, 0) + IF(le.censpct_pop_black_ALLOW_ErrorCount > 0, 1, 0) + IF(le.censpct_pop_amerind_ALLOW_ErrorCount > 0, 1, 0) + IF(le.censpct_pop_asian_ALLOW_ErrorCount > 0, 1, 0) + IF(le.censpct_pop_pacisl_ALLOW_ErrorCount > 0, 1, 0) + IF(le.censpct_pop_othrace_ALLOW_ErrorCount > 0, 1, 0) + IF(le.censpct_pop_multirace_ALLOW_ErrorCount > 0, 1, 0) + IF(le.censpct_pop_hispanic_ALLOW_ErrorCount > 0, 1, 0) + IF(le.censpct_pop_agelt18_ALLOW_ErrorCount > 0, 1, 0) + IF(le.censpct_pop_males_ALLOW_ErrorCount > 0, 1, 0) + IF(le.censpct_adult_age1824_ALLOW_ErrorCount > 0, 1, 0) + IF(le.censpct_adult_age2534_ALLOW_ErrorCount > 0, 1, 0) + IF(le.censpct_adult_age3544_ALLOW_ErrorCount > 0, 1, 0) + IF(le.censpct_adult_age4554_ALLOW_ErrorCount > 0, 1, 0) + IF(le.censpct_adult_age5564_ALLOW_ErrorCount > 0, 1, 0) + IF(le.censpct_adult_agege65_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cens_pop_medage_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cens_hh_avgsize_ALLOW_ErrorCount > 0, 1, 0) + IF(le.censpct_hh_family_ALLOW_ErrorCount > 0, 1, 0) + IF(le.censpct_hh_family_husbwife_ALLOW_ErrorCount > 0, 1, 0) + IF(le.censpct_hu_occupied_ALLOW_ErrorCount > 0, 1, 0) + IF(le.censpct_hu_owned_ALLOW_ErrorCount > 0, 1, 0) + IF(le.censpct_hu_rented_ALLOW_ErrorCount > 0, 1, 0) + IF(le.censpct_hu_vacantseasonal_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_medinc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_apparel_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_apparel_women_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_apparel_womfash_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_auto_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_beauty_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_booksmusicmovies_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_business_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_catalog_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_cc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_collectibles_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_computers_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_continuity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_cooking_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_crafts_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_culturearts_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_dm_sold_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_donor_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_family_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_gardening_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_giftgivr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_gourmet_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_health_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_health_diet_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_health_fitness_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_hobbies_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_homedecr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_homeliv_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_internet_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_internet_access_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_internet_buy_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_music_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_outdoors_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_pets_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_pfin_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_publish_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_publish_books_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_publish_mags_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_sports_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_sports_biking_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_sports_golf_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_travel_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_travel_us_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_tvmovies_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_woman_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_proftech_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_retired_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_inc100_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_inc75_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_inc50_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.dtmatch_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dtmatch_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.msname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.msaddr1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.msaddr2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mscity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mscity_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.msstate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.msstate_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.msstate_WORDS_ErrorCount > 0, 1, 0) + IF(le.mszip5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mszip5_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.mszip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mszip4_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.dthh_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dthh_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.mscrrt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mscrrt_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.msdpbc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.msdpbc_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.msdpv_ALLOW_ErrorCount > 0, 1, 0) + IF(le.msdpv_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ms_addrtype_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_addrtype_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ctysize_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ctysize_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.lmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.omos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.gen_ENUM_ErrorCount > 0, 1, 0) + IF(le.gen_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.dob_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.age_ALLOW_ErrorCount > 0, 1, 0) + IF(le.inc_ENUM_ErrorCount > 0, 1, 0) + IF(le.inc_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.marital_status_ALLOW_ErrorCount > 0, 1, 0) + IF(le.poc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.noc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.noc_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ocp_ENUM_ErrorCount > 0, 1, 0) + IF(le.ocp_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.edu_ENUM_ErrorCount > 0, 1, 0) + IF(le.edu_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.lang_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lang_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.relig_ENUM_ErrorCount > 0, 1, 0) + IF(le.relig_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.dwell_ENUM_ErrorCount > 0, 1, 0) + IF(le.dwell_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ownr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.eth1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.eth1_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.eth2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.eth2_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.lor_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lor_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.pool_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pool_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.speak_span_ALLOW_ErrorCount > 0, 1, 0) + IF(le.speak_span_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.soho_ALLOW_ErrorCount > 0, 1, 0) + IF(le.soho_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.vet_in_hh_ALLOW_ErrorCount > 0, 1, 0) + IF(le.vet_in_hh_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ms_mags_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_books_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_publish_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_status_active_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_status_expire_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_premsold_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_autornwl_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_avgterm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_lmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_omos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_pmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_cemos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_femos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_totords_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_totdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_avgdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_lastdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_paystat_paid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_paystat_ub_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_paymeth_cc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_paymeth_cash_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_payspeed_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_osrc_dm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_lsrc_dm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_osrc_agt_cashf_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_lsrc_agt_cashf_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_osrc_agt_pds_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_lsrc_agt_pds_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_osrc_agt_schplan_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_lsrc_agt_schplan_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_osrc_agt_sponsor_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_lsrc_agt_sponsor_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_osrc_agt_tm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_lsrc_agt_tm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_osrc_agt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_lsrc_agt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_osrc_tm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_lsrc_tm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_osrc_ins_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_lsrc_ins_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_osrc_net_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_lsrc_net_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_osrc_print_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_lsrc_print_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_osrc_trans_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_lsrc_trans_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_osrc_tv_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_lsrc_tv_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_osrc_dtp_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_lsrc_dtp_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_giftgivr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_giftee_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_catalog_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cat_lmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cat_omos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cat_pmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cat_totords_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cat_totitems_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cat_totdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cat_avgdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cat_lastdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cat_paystat_paid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cat_paymeth_cc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cat_paymeth_cash_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cat_osrc_dm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cat_lsrc_dm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cat_osrc_net_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cat_lsrc_net_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cat_giftgivr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpubs_corrected_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkcatg_corrected_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_fundraising_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_fund_lmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_fund_omos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_fund_pmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_fund_totords_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_fund_totdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_fund_avgdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_fund_lastdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_fund_paystat_paid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_other_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_continuity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cont_status_active_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cont_status_cancel_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cont_omos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cont_lmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cont_pmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cont_totords_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cont_totdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cont_avgdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cont_lastdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cont_paystat_paid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cont_paymeth_cc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cont_paymeth_cash_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_totords_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_totitems_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_totdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_avgdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_lastdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_paystat_paid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_paymeth_cc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_paymeth_cash_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_osrc_dm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_lsrc_dm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_osrc_tm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_lsrc_tm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_osrc_ins_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_lsrc_ins_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_osrc_net_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_lsrc_net_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_osrc_tv_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_lsrc_tv_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_osrc_retail_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_lsrc_retail_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_giftgivr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_giftee_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_adult_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_womapp_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_menapp_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_kidapp_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_accessory_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_apparel_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_app_lmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_app_omos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_app_pmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_app_totords_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_app_totitems_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_app_totdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_app_avgdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_app_lastdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_app_paystat_paid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_app_paymeth_cc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_app_paymeth_cash_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_menfash_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_womfash_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_wfsh_lmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_wfsh_omos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_wfsh_pmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_wfsh_totords_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_wfsh_totdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_wfsh_avgdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_wfsh_lastdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_wfsh_paystat_paid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_wfsh_osrc_dm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_wfsh_lsrc_dm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_wfsh_osrc_agt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_wfsh_lsrc_agt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_audio_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_auto_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_aviation_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_bargains_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_beauty_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_bible_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_bible_lmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_bible_omos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_bible_pmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_bible_totords_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_bible_totitems_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_bible_totdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_bible_avgdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_bible_lastdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_bible_paystat_paid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_bible_paymeth_cc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_bible_paymeth_cash_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_business_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_collectibles_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_computers_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_crafts_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_culturearts_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_currevent_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_diy_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_electronics_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_equestrian_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_family_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cat_family_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_family_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_family_lmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_family_omos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_family_pmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_family_totords_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_family_totitems_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_family_totdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_family_avgdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_family_lastdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_family_paystat_paid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_family_paymeth_cc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_family_paymeth_cash_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_family_osrc_dm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_family_lsrc_dm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_fiction_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_food_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_games_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_gifts_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_gourmet_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_fitness_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_health_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_hlth_lmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_hlth_omos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_hlth_pmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_hlth_totords_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_hlth_totdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_hlth_avgdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_hlth_lastdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_hlth_paystat_paid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_hlth_paymeth_cc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_hlth_osrc_dm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_hlth_lsrc_dm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_hlth_osrc_agt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_hlth_lsrc_agt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_hlth_osrc_tv_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_hlth_lsrc_tv_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_holiday_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_history_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_cooking_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cooking_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_homedecr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cat_homedecr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_homedecr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_housewares_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_garden_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cat_garden_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_garden_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_homeliv_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cat_homeliv_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_homeliv_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_home_status_active_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_home_lmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_home_omos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_home_pmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_home_totords_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_home_totitems_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_home_totdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_home_avgdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_home_lastdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_home_paystat_paid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_home_paymeth_cc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_home_paymeth_cash_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_home_osrc_dm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_home_lsrc_dm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_home_osrc_agt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_home_lsrc_agt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_home_osrc_net_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_home_lsrc_net_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_home_osrc_tv_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_home_lsrc_tv_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_humor_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_inspiration_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_merchandise_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_moneymaking_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_moneymaking_lmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_motorcycles_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_music_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_fishing_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_hunting_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_boatsail_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_camp_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_outdoors_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_cat_outdoors_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_outdoors_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pub_out_status_active_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_out_lmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_out_omos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_out_pmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_out_totords_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_out_totitems_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_out_totdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_out_avgdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_out_lastdlrs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_out_paystat_paid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_out_paymeth_cc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_out_paymeth_cash_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_out_osrc_dm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_out_lsrc_dm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_out_osrc_agt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_out_lsrc_agt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pets_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_pfin_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_photo_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_photoproc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_rural_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_science_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_sports_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_sports_lmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_travel_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_tvmovies_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_wildlife_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_woman_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_woman_lmos_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ms_ringtones_apps_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_mobile_apps_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_credit_repair_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_credit_report_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_education_seekers_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_insurance_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_insurance_health_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_insurance_auto_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_job_seekers_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_social_networking_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_adult_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_africanamerican_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_apparel_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_apparel_accessory_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_apparel_kids_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_apparel_men_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_apparel_menfash_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_apparel_women_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_apparel_womfash_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_asian_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_auto_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_auto_racing_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_auto_trucks_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_aviation_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_bargains_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_beauty_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_bible_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_birds_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_business_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_business_homeoffice_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_catalog_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_cc_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_collectibles_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_college_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_computers_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_conservative_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_continuity_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_cooking_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_crafts_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_crafts_crochet_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_crafts_knit_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_crafts_needlepoint_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_crafts_quilt_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_crafts_sew_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_culturearts_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_currevent_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_diy_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_donor_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_ego_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_electronics_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_equestrian_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_family_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_family_teen_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_family_young_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_fiction_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_gambling_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_games_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_gardening_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_gay_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_giftgivr_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_gourmet_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_grandparents_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_health_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_health_diet_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_health_fitness_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_hightech_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_hispanic_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_history_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_history_american_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_hobbies_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_homedecr_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_homeliv_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_humor_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_inspiration_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_internet_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_internet_access_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_internet_buy_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_liberal_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_moneymaking_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_motorcycles_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_music_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_nonfiction_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_ocean_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_outdoors_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_outdoors_boatsail_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_outdoors_camp_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_outdoors_fishing_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_outdoors_huntfish_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_outdoors_hunting_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_pets_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_pets_cats_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_pets_dogs_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_pfin_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_photog_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_photoproc_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_publish_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_publish_books_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_publish_mags_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_rural_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_science_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_scifi_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_seniors_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_sports_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_sports_baseball_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_sports_basketball_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_sports_biking_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_sports_football_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_sports_golf_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_sports_hockey_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_sports_running_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_sports_ski_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_sports_soccer_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_sports_swimming_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_sports_tennis_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_stationery_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_sweeps_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_tobacco_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_travel_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_travel_cruise_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_travel_rv_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_travel_us_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_tvmovies_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_wildlife_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_woman_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.totdlr_index_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_totdlr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_totords_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpi_lastdlr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkcatg_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpubs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkcont_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca01_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca03_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca04_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca05_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca06_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca07_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca08_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca09_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca10_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca11_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca13_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca14_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca15_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca16_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca17_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca18_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca20_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca21_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca22_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca23_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca25_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca26_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca28_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca29_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca30_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca31_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca32_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca33_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca34_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca35_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca36_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca37_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca39_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca40_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca41_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca42_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca54_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca61_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca62_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkca64_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu01_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu02_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu03_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu04_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu05_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu06_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu07_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu08_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu09_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu10_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu11_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu13_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu14_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu15_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu16_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu17_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu18_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu19_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu20_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu23_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu25_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu27_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu28_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu29_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu30_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu31_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu32_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu33_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu34_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu35_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu38_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu41_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu42_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu45_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu46_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu47_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu48_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu49_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu50_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu51_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu52_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu53_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu54_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu55_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu56_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu57_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu60_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu61_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu62_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu63_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu64_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu65_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu66_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu67_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu68_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu69_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pkpu70_ALLOW_ErrorCount > 0, 1, 0) + IF(le.censpct_water_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cens_pop_density_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cens_hu_density_ALLOW_ErrorCount > 0, 1, 0) + IF(le.censpct_pop_white_ALLOW_ErrorCount > 0, 1, 0) + IF(le.censpct_pop_black_ALLOW_ErrorCount > 0, 1, 0) + IF(le.censpct_pop_amerind_ALLOW_ErrorCount > 0, 1, 0) + IF(le.censpct_pop_asian_ALLOW_ErrorCount > 0, 1, 0) + IF(le.censpct_pop_pacisl_ALLOW_ErrorCount > 0, 1, 0) + IF(le.censpct_pop_othrace_ALLOW_ErrorCount > 0, 1, 0) + IF(le.censpct_pop_multirace_ALLOW_ErrorCount > 0, 1, 0) + IF(le.censpct_pop_hispanic_ALLOW_ErrorCount > 0, 1, 0) + IF(le.censpct_pop_agelt18_ALLOW_ErrorCount > 0, 1, 0) + IF(le.censpct_pop_males_ALLOW_ErrorCount > 0, 1, 0) + IF(le.censpct_adult_age1824_ALLOW_ErrorCount > 0, 1, 0) + IF(le.censpct_adult_age2534_ALLOW_ErrorCount > 0, 1, 0) + IF(le.censpct_adult_age3544_ALLOW_ErrorCount > 0, 1, 0) + IF(le.censpct_adult_age4554_ALLOW_ErrorCount > 0, 1, 0) + IF(le.censpct_adult_age5564_ALLOW_ErrorCount > 0, 1, 0) + IF(le.censpct_adult_agege65_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cens_pop_medage_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cens_hh_avgsize_ALLOW_ErrorCount > 0, 1, 0) + IF(le.censpct_hh_family_ALLOW_ErrorCount > 0, 1, 0) + IF(le.censpct_hh_family_husbwife_ALLOW_ErrorCount > 0, 1, 0) + IF(le.censpct_hu_occupied_ALLOW_ErrorCount > 0, 1, 0) + IF(le.censpct_hu_owned_ALLOW_ErrorCount > 0, 1, 0) + IF(le.censpct_hu_rented_ALLOW_ErrorCount > 0, 1, 0) + IF(le.censpct_hu_vacantseasonal_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_medinc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_apparel_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_apparel_women_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_apparel_womfash_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_auto_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_beauty_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_booksmusicmovies_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_business_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_catalog_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_cc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_collectibles_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_computers_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_continuity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_cooking_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_crafts_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_culturearts_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_dm_sold_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_donor_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_family_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_gardening_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_giftgivr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_gourmet_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_health_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_health_diet_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_health_fitness_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_hobbies_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_homedecr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_homeliv_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_internet_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_internet_access_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_internet_buy_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_music_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_outdoors_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_pets_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_pfin_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_publish_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_publish_books_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_publish_mags_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_sports_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_sports_biking_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_sports_golf_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_travel_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_travel_us_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_tvmovies_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_woman_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_proftech_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_retired_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_inc100_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_inc75_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_inc50_ALLOW_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF.Rules_WithEdits := IF(le.dtmatch_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.dtmatch_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.msname_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.msaddr1_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.msaddr2_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.mscity_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.mscity_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.msstate_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.msstate_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.msstate_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.mszip5_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.mszip5_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.mszip4_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.mszip4_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.dthh_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.dthh_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.mscrrt_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.mscrrt_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.msdpbc_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.msdpbc_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.msdpv_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.msdpv_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.ms_addrtype_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.ms_addrtype_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.ctysize_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.ctysize_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.noc_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.noc_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.lang_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.lang_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.eth1_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.eth1_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.eth2_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.eth2_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.lor_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.lor_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.pool_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.pool_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.speak_span_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.speak_span_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.soho_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.soho_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.vet_in_hh_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.vet_in_hh_LENGTHS_WouldModifyCount > 0, 1, 0);
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT311.StrType ErrorMessage;
    SALT311.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.dtmatch_Invalid,le.msname_Invalid,le.msaddr1_Invalid,le.msaddr2_Invalid,le.mscity_Invalid,le.msstate_Invalid,le.mszip5_Invalid,le.mszip4_Invalid,le.dthh_Invalid,le.mscrrt_Invalid,le.msdpbc_Invalid,le.msdpv_Invalid,le.ms_addrtype_Invalid,le.ctysize_Invalid,le.lmos_Invalid,le.omos_Invalid,le.pmos_Invalid,le.gen_Invalid,le.dob_Invalid,le.age_Invalid,le.inc_Invalid,le.marital_status_Invalid,le.poc_Invalid,le.noc_Invalid,le.ocp_Invalid,le.edu_Invalid,le.lang_Invalid,le.relig_Invalid,le.dwell_Invalid,le.ownr_Invalid,le.eth1_Invalid,le.eth2_Invalid,le.lor_Invalid,le.pool_Invalid,le.speak_span_Invalid,le.soho_Invalid,le.vet_in_hh_Invalid,le.ms_mags_Invalid,le.ms_books_Invalid,le.ms_publish_Invalid,le.ms_pub_status_active_Invalid,le.ms_pub_status_expire_Invalid,le.ms_pub_premsold_Invalid,le.ms_pub_autornwl_Invalid,le.ms_pub_avgterm_Invalid,le.ms_pub_lmos_Invalid,le.ms_pub_omos_Invalid,le.ms_pub_pmos_Invalid,le.ms_pub_cemos_Invalid,le.ms_pub_femos_Invalid,le.ms_pub_totords_Invalid,le.ms_pub_totdlrs_Invalid,le.ms_pub_avgdlrs_Invalid,le.ms_pub_lastdlrs_Invalid,le.ms_pub_paystat_paid_Invalid,le.ms_pub_paystat_ub_Invalid,le.ms_pub_paymeth_cc_Invalid,le.ms_pub_paymeth_cash_Invalid,le.ms_pub_payspeed_Invalid,le.ms_pub_osrc_dm_Invalid,le.ms_pub_lsrc_dm_Invalid,le.ms_pub_osrc_agt_cashf_Invalid,le.ms_pub_lsrc_agt_cashf_Invalid,le.ms_pub_osrc_agt_pds_Invalid,le.ms_pub_lsrc_agt_pds_Invalid,le.ms_pub_osrc_agt_schplan_Invalid,le.ms_pub_lsrc_agt_schplan_Invalid,le.ms_pub_osrc_agt_sponsor_Invalid,le.ms_pub_lsrc_agt_sponsor_Invalid,le.ms_pub_osrc_agt_tm_Invalid,le.ms_pub_lsrc_agt_tm_Invalid,le.ms_pub_osrc_agt_Invalid,le.ms_pub_lsrc_agt_Invalid,le.ms_pub_osrc_tm_Invalid,le.ms_pub_lsrc_tm_Invalid,le.ms_pub_osrc_ins_Invalid,le.ms_pub_lsrc_ins_Invalid,le.ms_pub_osrc_net_Invalid,le.ms_pub_lsrc_net_Invalid,le.ms_pub_osrc_print_Invalid,le.ms_pub_lsrc_print_Invalid,le.ms_pub_osrc_trans_Invalid,le.ms_pub_lsrc_trans_Invalid,le.ms_pub_osrc_tv_Invalid,le.ms_pub_lsrc_tv_Invalid,le.ms_pub_osrc_dtp_Invalid,le.ms_pub_lsrc_dtp_Invalid,le.ms_pub_giftgivr_Invalid,le.ms_pub_giftee_Invalid,le.ms_catalog_Invalid,le.ms_cat_lmos_Invalid,le.ms_cat_omos_Invalid,le.ms_cat_pmos_Invalid,le.ms_cat_totords_Invalid,le.ms_cat_totitems_Invalid,le.ms_cat_totdlrs_Invalid,le.ms_cat_avgdlrs_Invalid,le.ms_cat_lastdlrs_Invalid,le.ms_cat_paystat_paid_Invalid,le.ms_cat_paymeth_cc_Invalid,le.ms_cat_paymeth_cash_Invalid,le.ms_cat_osrc_dm_Invalid,le.ms_cat_lsrc_dm_Invalid,le.ms_cat_osrc_net_Invalid,le.ms_cat_lsrc_net_Invalid,le.ms_cat_giftgivr_Invalid,le.pkpubs_corrected_Invalid,le.pkcatg_corrected_Invalid,le.ms_fundraising_Invalid,le.ms_fund_lmos_Invalid,le.ms_fund_omos_Invalid,le.ms_fund_pmos_Invalid,le.ms_fund_totords_Invalid,le.ms_fund_totdlrs_Invalid,le.ms_fund_avgdlrs_Invalid,le.ms_fund_lastdlrs_Invalid,le.ms_fund_paystat_paid_Invalid,le.ms_other_Invalid,le.ms_continuity_Invalid,le.ms_cont_status_active_Invalid,le.ms_cont_status_cancel_Invalid,le.ms_cont_omos_Invalid,le.ms_cont_lmos_Invalid,le.ms_cont_pmos_Invalid,le.ms_cont_totords_Invalid,le.ms_cont_totdlrs_Invalid,le.ms_cont_avgdlrs_Invalid,le.ms_cont_lastdlrs_Invalid,le.ms_cont_paystat_paid_Invalid,le.ms_cont_paymeth_cc_Invalid,le.ms_cont_paymeth_cash_Invalid,le.ms_totords_Invalid,le.ms_totitems_Invalid,le.ms_totdlrs_Invalid,le.ms_avgdlrs_Invalid,le.ms_lastdlrs_Invalid,le.ms_paystat_paid_Invalid,le.ms_paymeth_cc_Invalid,le.ms_paymeth_cash_Invalid,le.ms_osrc_dm_Invalid,le.ms_lsrc_dm_Invalid,le.ms_osrc_tm_Invalid,le.ms_lsrc_tm_Invalid,le.ms_osrc_ins_Invalid,le.ms_lsrc_ins_Invalid,le.ms_osrc_net_Invalid,le.ms_lsrc_net_Invalid,le.ms_osrc_tv_Invalid,le.ms_lsrc_tv_Invalid,le.ms_osrc_retail_Invalid,le.ms_lsrc_retail_Invalid,le.ms_giftgivr_Invalid,le.ms_giftee_Invalid,le.ms_adult_Invalid,le.ms_womapp_Invalid,le.ms_menapp_Invalid,le.ms_kidapp_Invalid,le.ms_accessory_Invalid,le.ms_apparel_Invalid,le.ms_app_lmos_Invalid,le.ms_app_omos_Invalid,le.ms_app_pmos_Invalid,le.ms_app_totords_Invalid,le.ms_app_totitems_Invalid,le.ms_app_totdlrs_Invalid,le.ms_app_avgdlrs_Invalid,le.ms_app_lastdlrs_Invalid,le.ms_app_paystat_paid_Invalid,le.ms_app_paymeth_cc_Invalid,le.ms_app_paymeth_cash_Invalid,le.ms_menfash_Invalid,le.ms_womfash_Invalid,le.ms_wfsh_lmos_Invalid,le.ms_wfsh_omos_Invalid,le.ms_wfsh_pmos_Invalid,le.ms_wfsh_totords_Invalid,le.ms_wfsh_totdlrs_Invalid,le.ms_wfsh_avgdlrs_Invalid,le.ms_wfsh_lastdlrs_Invalid,le.ms_wfsh_paystat_paid_Invalid,le.ms_wfsh_osrc_dm_Invalid,le.ms_wfsh_lsrc_dm_Invalid,le.ms_wfsh_osrc_agt_Invalid,le.ms_wfsh_lsrc_agt_Invalid,le.ms_audio_Invalid,le.ms_auto_Invalid,le.ms_aviation_Invalid,le.ms_bargains_Invalid,le.ms_beauty_Invalid,le.ms_bible_Invalid,le.ms_bible_lmos_Invalid,le.ms_bible_omos_Invalid,le.ms_bible_pmos_Invalid,le.ms_bible_totords_Invalid,le.ms_bible_totitems_Invalid,le.ms_bible_totdlrs_Invalid,le.ms_bible_avgdlrs_Invalid,le.ms_bible_lastdlrs_Invalid,le.ms_bible_paystat_paid_Invalid,le.ms_bible_paymeth_cc_Invalid,le.ms_bible_paymeth_cash_Invalid,le.ms_business_Invalid,le.ms_collectibles_Invalid,le.ms_computers_Invalid,le.ms_crafts_Invalid,le.ms_culturearts_Invalid,le.ms_currevent_Invalid,le.ms_diy_Invalid,le.ms_electronics_Invalid,le.ms_equestrian_Invalid,le.ms_pub_family_Invalid,le.ms_cat_family_Invalid,le.ms_family_Invalid,le.ms_family_lmos_Invalid,le.ms_family_omos_Invalid,le.ms_family_pmos_Invalid,le.ms_family_totords_Invalid,le.ms_family_totitems_Invalid,le.ms_family_totdlrs_Invalid,le.ms_family_avgdlrs_Invalid,le.ms_family_lastdlrs_Invalid,le.ms_family_paystat_paid_Invalid,le.ms_family_paymeth_cc_Invalid,le.ms_family_paymeth_cash_Invalid,le.ms_family_osrc_dm_Invalid,le.ms_family_lsrc_dm_Invalid,le.ms_fiction_Invalid,le.ms_food_Invalid,le.ms_games_Invalid,le.ms_gifts_Invalid,le.ms_gourmet_Invalid,le.ms_fitness_Invalid,le.ms_health_Invalid,le.ms_hlth_lmos_Invalid,le.ms_hlth_omos_Invalid,le.ms_hlth_pmos_Invalid,le.ms_hlth_totords_Invalid,le.ms_hlth_totdlrs_Invalid,le.ms_hlth_avgdlrs_Invalid,le.ms_hlth_lastdlrs_Invalid,le.ms_hlth_paystat_paid_Invalid,le.ms_hlth_paymeth_cc_Invalid,le.ms_hlth_osrc_dm_Invalid,le.ms_hlth_lsrc_dm_Invalid,le.ms_hlth_osrc_agt_Invalid,le.ms_hlth_lsrc_agt_Invalid,le.ms_hlth_osrc_tv_Invalid,le.ms_hlth_lsrc_tv_Invalid,le.ms_holiday_Invalid,le.ms_history_Invalid,le.ms_pub_cooking_Invalid,le.ms_cooking_Invalid,le.ms_pub_homedecr_Invalid,le.ms_cat_homedecr_Invalid,le.ms_homedecr_Invalid,le.ms_housewares_Invalid,le.ms_pub_garden_Invalid,le.ms_cat_garden_Invalid,le.ms_garden_Invalid,le.ms_pub_homeliv_Invalid,le.ms_cat_homeliv_Invalid,le.ms_homeliv_Invalid,le.ms_pub_home_status_active_Invalid,le.ms_home_lmos_Invalid,le.ms_home_omos_Invalid,le.ms_home_pmos_Invalid,le.ms_home_totords_Invalid,le.ms_home_totitems_Invalid,le.ms_home_totdlrs_Invalid,le.ms_home_avgdlrs_Invalid,le.ms_home_lastdlrs_Invalid,le.ms_home_paystat_paid_Invalid,le.ms_home_paymeth_cc_Invalid,le.ms_home_paymeth_cash_Invalid,le.ms_home_osrc_dm_Invalid,le.ms_home_lsrc_dm_Invalid,le.ms_home_osrc_agt_Invalid,le.ms_home_lsrc_agt_Invalid,le.ms_home_osrc_net_Invalid,le.ms_home_lsrc_net_Invalid,le.ms_home_osrc_tv_Invalid,le.ms_home_lsrc_tv_Invalid,le.ms_humor_Invalid,le.ms_inspiration_Invalid,le.ms_merchandise_Invalid,le.ms_moneymaking_Invalid,le.ms_moneymaking_lmos_Invalid,le.ms_motorcycles_Invalid,le.ms_music_Invalid,le.ms_fishing_Invalid,le.ms_hunting_Invalid,le.ms_boatsail_Invalid,le.ms_camp_Invalid,le.ms_pub_outdoors_Invalid,le.ms_cat_outdoors_Invalid,le.ms_outdoors_Invalid,le.ms_pub_out_status_active_Invalid,le.ms_out_lmos_Invalid,le.ms_out_omos_Invalid,le.ms_out_pmos_Invalid,le.ms_out_totords_Invalid,le.ms_out_totitems_Invalid,le.ms_out_totdlrs_Invalid,le.ms_out_avgdlrs_Invalid,le.ms_out_lastdlrs_Invalid,le.ms_out_paystat_paid_Invalid,le.ms_out_paymeth_cc_Invalid,le.ms_out_paymeth_cash_Invalid,le.ms_out_osrc_dm_Invalid,le.ms_out_lsrc_dm_Invalid,le.ms_out_osrc_agt_Invalid,le.ms_out_lsrc_agt_Invalid,le.ms_pets_Invalid,le.ms_pfin_Invalid,le.ms_photo_Invalid,le.ms_photoproc_Invalid,le.ms_rural_Invalid,le.ms_science_Invalid,le.ms_sports_Invalid,le.ms_sports_lmos_Invalid,le.ms_travel_Invalid,le.ms_tvmovies_Invalid,le.ms_wildlife_Invalid,le.ms_woman_Invalid,le.ms_woman_lmos_Invalid,le.ms_ringtones_apps_Invalid,le.cpi_mobile_apps_index_Invalid,le.cpi_credit_repair_index_Invalid,le.cpi_credit_report_index_Invalid,le.cpi_education_seekers_index_Invalid,le.cpi_insurance_index_Invalid,le.cpi_insurance_health_index_Invalid,le.cpi_insurance_auto_index_Invalid,le.cpi_job_seekers_index_Invalid,le.cpi_social_networking_index_Invalid,le.cpi_adult_index_Invalid,le.cpi_africanamerican_index_Invalid,le.cpi_apparel_index_Invalid,le.cpi_apparel_accessory_index_Invalid,le.cpi_apparel_kids_index_Invalid,le.cpi_apparel_men_index_Invalid,le.cpi_apparel_menfash_index_Invalid,le.cpi_apparel_women_index_Invalid,le.cpi_apparel_womfash_index_Invalid,le.cpi_asian_index_Invalid,le.cpi_auto_index_Invalid,le.cpi_auto_racing_index_Invalid,le.cpi_auto_trucks_index_Invalid,le.cpi_aviation_index_Invalid,le.cpi_bargains_index_Invalid,le.cpi_beauty_index_Invalid,le.cpi_bible_index_Invalid,le.cpi_birds_index_Invalid,le.cpi_business_index_Invalid,le.cpi_business_homeoffice_index_Invalid,le.cpi_catalog_index_Invalid,le.cpi_cc_index_Invalid,le.cpi_collectibles_index_Invalid,le.cpi_college_index_Invalid,le.cpi_computers_index_Invalid,le.cpi_conservative_index_Invalid,le.cpi_continuity_index_Invalid,le.cpi_cooking_index_Invalid,le.cpi_crafts_index_Invalid,le.cpi_crafts_crochet_index_Invalid,le.cpi_crafts_knit_index_Invalid,le.cpi_crafts_needlepoint_index_Invalid,le.cpi_crafts_quilt_index_Invalid,le.cpi_crafts_sew_index_Invalid,le.cpi_culturearts_index_Invalid,le.cpi_currevent_index_Invalid,le.cpi_diy_index_Invalid,le.cpi_donor_index_Invalid,le.cpi_ego_index_Invalid,le.cpi_electronics_index_Invalid,le.cpi_equestrian_index_Invalid,le.cpi_family_index_Invalid,le.cpi_family_teen_index_Invalid,le.cpi_family_young_index_Invalid,le.cpi_fiction_index_Invalid,le.cpi_gambling_index_Invalid,le.cpi_games_index_Invalid,le.cpi_gardening_index_Invalid,le.cpi_gay_index_Invalid,le.cpi_giftgivr_index_Invalid,le.cpi_gourmet_index_Invalid,le.cpi_grandparents_index_Invalid,le.cpi_health_index_Invalid,le.cpi_health_diet_index_Invalid,le.cpi_health_fitness_index_Invalid,le.cpi_hightech_index_Invalid,le.cpi_hispanic_index_Invalid,le.cpi_history_index_Invalid,le.cpi_history_american_index_Invalid,le.cpi_hobbies_index_Invalid,le.cpi_homedecr_index_Invalid,le.cpi_homeliv_index_Invalid,le.cpi_humor_index_Invalid,le.cpi_inspiration_index_Invalid,le.cpi_internet_index_Invalid,le.cpi_internet_access_index_Invalid,le.cpi_internet_buy_index_Invalid,le.cpi_liberal_index_Invalid,le.cpi_moneymaking_index_Invalid,le.cpi_motorcycles_index_Invalid,le.cpi_music_index_Invalid,le.cpi_nonfiction_index_Invalid,le.cpi_ocean_index_Invalid,le.cpi_outdoors_index_Invalid,le.cpi_outdoors_boatsail_index_Invalid,le.cpi_outdoors_camp_index_Invalid,le.cpi_outdoors_fishing_index_Invalid,le.cpi_outdoors_huntfish_index_Invalid,le.cpi_outdoors_hunting_index_Invalid,le.cpi_pets_index_Invalid,le.cpi_pets_cats_index_Invalid,le.cpi_pets_dogs_index_Invalid,le.cpi_pfin_index_Invalid,le.cpi_photog_index_Invalid,le.cpi_photoproc_index_Invalid,le.cpi_publish_index_Invalid,le.cpi_publish_books_index_Invalid,le.cpi_publish_mags_index_Invalid,le.cpi_rural_index_Invalid,le.cpi_science_index_Invalid,le.cpi_scifi_index_Invalid,le.cpi_seniors_index_Invalid,le.cpi_sports_index_Invalid,le.cpi_sports_baseball_index_Invalid,le.cpi_sports_basketball_index_Invalid,le.cpi_sports_biking_index_Invalid,le.cpi_sports_football_index_Invalid,le.cpi_sports_golf_index_Invalid,le.cpi_sports_hockey_index_Invalid,le.cpi_sports_running_index_Invalid,le.cpi_sports_ski_index_Invalid,le.cpi_sports_soccer_index_Invalid,le.cpi_sports_swimming_index_Invalid,le.cpi_sports_tennis_index_Invalid,le.cpi_stationery_index_Invalid,le.cpi_sweeps_index_Invalid,le.cpi_tobacco_index_Invalid,le.cpi_travel_index_Invalid,le.cpi_travel_cruise_index_Invalid,le.cpi_travel_rv_index_Invalid,le.cpi_travel_us_index_Invalid,le.cpi_tvmovies_index_Invalid,le.cpi_wildlife_index_Invalid,le.cpi_woman_index_Invalid,le.totdlr_index_Invalid,le.cpi_totdlr_Invalid,le.cpi_totords_Invalid,le.cpi_lastdlr_Invalid,le.pkcatg_Invalid,le.pkpubs_Invalid,le.pkcont_Invalid,le.pkca01_Invalid,le.pkca03_Invalid,le.pkca04_Invalid,le.pkca05_Invalid,le.pkca06_Invalid,le.pkca07_Invalid,le.pkca08_Invalid,le.pkca09_Invalid,le.pkca10_Invalid,le.pkca11_Invalid,le.pkca12_Invalid,le.pkca13_Invalid,le.pkca14_Invalid,le.pkca15_Invalid,le.pkca16_Invalid,le.pkca17_Invalid,le.pkca18_Invalid,le.pkca20_Invalid,le.pkca21_Invalid,le.pkca22_Invalid,le.pkca23_Invalid,le.pkca24_Invalid,le.pkca25_Invalid,le.pkca26_Invalid,le.pkca28_Invalid,le.pkca29_Invalid,le.pkca30_Invalid,le.pkca31_Invalid,le.pkca32_Invalid,le.pkca33_Invalid,le.pkca34_Invalid,le.pkca35_Invalid,le.pkca36_Invalid,le.pkca37_Invalid,le.pkca39_Invalid,le.pkca40_Invalid,le.pkca41_Invalid,le.pkca42_Invalid,le.pkca54_Invalid,le.pkca61_Invalid,le.pkca62_Invalid,le.pkca64_Invalid,le.pkpu01_Invalid,le.pkpu02_Invalid,le.pkpu03_Invalid,le.pkpu04_Invalid,le.pkpu05_Invalid,le.pkpu06_Invalid,le.pkpu07_Invalid,le.pkpu08_Invalid,le.pkpu09_Invalid,le.pkpu10_Invalid,le.pkpu11_Invalid,le.pkpu12_Invalid,le.pkpu13_Invalid,le.pkpu14_Invalid,le.pkpu15_Invalid,le.pkpu16_Invalid,le.pkpu17_Invalid,le.pkpu18_Invalid,le.pkpu19_Invalid,le.pkpu20_Invalid,le.pkpu23_Invalid,le.pkpu25_Invalid,le.pkpu27_Invalid,le.pkpu28_Invalid,le.pkpu29_Invalid,le.pkpu30_Invalid,le.pkpu31_Invalid,le.pkpu32_Invalid,le.pkpu33_Invalid,le.pkpu34_Invalid,le.pkpu35_Invalid,le.pkpu38_Invalid,le.pkpu41_Invalid,le.pkpu42_Invalid,le.pkpu45_Invalid,le.pkpu46_Invalid,le.pkpu47_Invalid,le.pkpu48_Invalid,le.pkpu49_Invalid,le.pkpu50_Invalid,le.pkpu51_Invalid,le.pkpu52_Invalid,le.pkpu53_Invalid,le.pkpu54_Invalid,le.pkpu55_Invalid,le.pkpu56_Invalid,le.pkpu57_Invalid,le.pkpu60_Invalid,le.pkpu61_Invalid,le.pkpu62_Invalid,le.pkpu63_Invalid,le.pkpu64_Invalid,le.pkpu65_Invalid,le.pkpu66_Invalid,le.pkpu67_Invalid,le.pkpu68_Invalid,le.pkpu69_Invalid,le.pkpu70_Invalid,le.censpct_water_Invalid,le.cens_pop_density_Invalid,le.cens_hu_density_Invalid,le.censpct_pop_white_Invalid,le.censpct_pop_black_Invalid,le.censpct_pop_amerind_Invalid,le.censpct_pop_asian_Invalid,le.censpct_pop_pacisl_Invalid,le.censpct_pop_othrace_Invalid,le.censpct_pop_multirace_Invalid,le.censpct_pop_hispanic_Invalid,le.censpct_pop_agelt18_Invalid,le.censpct_pop_males_Invalid,le.censpct_adult_age1824_Invalid,le.censpct_adult_age2534_Invalid,le.censpct_adult_age3544_Invalid,le.censpct_adult_age4554_Invalid,le.censpct_adult_age5564_Invalid,le.censpct_adult_agege65_Invalid,le.cens_pop_medage_Invalid,le.cens_hh_avgsize_Invalid,le.censpct_hh_family_Invalid,le.censpct_hh_family_husbwife_Invalid,le.censpct_hu_occupied_Invalid,le.censpct_hu_owned_Invalid,le.censpct_hu_rented_Invalid,le.censpct_hu_vacantseasonal_Invalid,le.zip_medinc_Invalid,le.zip_apparel_Invalid,le.zip_apparel_women_Invalid,le.zip_apparel_womfash_Invalid,le.zip_auto_Invalid,le.zip_beauty_Invalid,le.zip_booksmusicmovies_Invalid,le.zip_business_Invalid,le.zip_catalog_Invalid,le.zip_cc_Invalid,le.zip_collectibles_Invalid,le.zip_computers_Invalid,le.zip_continuity_Invalid,le.zip_cooking_Invalid,le.zip_crafts_Invalid,le.zip_culturearts_Invalid,le.zip_dm_sold_Invalid,le.zip_donor_Invalid,le.zip_family_Invalid,le.zip_gardening_Invalid,le.zip_giftgivr_Invalid,le.zip_gourmet_Invalid,le.zip_health_Invalid,le.zip_health_diet_Invalid,le.zip_health_fitness_Invalid,le.zip_hobbies_Invalid,le.zip_homedecr_Invalid,le.zip_homeliv_Invalid,le.zip_internet_Invalid,le.zip_internet_access_Invalid,le.zip_internet_buy_Invalid,le.zip_music_Invalid,le.zip_outdoors_Invalid,le.zip_pets_Invalid,le.zip_pfin_Invalid,le.zip_publish_Invalid,le.zip_publish_books_Invalid,le.zip_publish_mags_Invalid,le.zip_sports_Invalid,le.zip_sports_biking_Invalid,le.zip_sports_golf_Invalid,le.zip_travel_Invalid,le.zip_travel_us_Invalid,le.zip_tvmovies_Invalid,le.zip_woman_Invalid,le.zip_proftech_Invalid,le.zip_retired_Invalid,le.zip_inc100_Invalid,le.zip_inc75_Invalid,le.zip_inc50_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_dtmatch(le.dtmatch_Invalid),Fields.InvalidMessage_msname(le.msname_Invalid),Fields.InvalidMessage_msaddr1(le.msaddr1_Invalid),Fields.InvalidMessage_msaddr2(le.msaddr2_Invalid),Fields.InvalidMessage_mscity(le.mscity_Invalid),Fields.InvalidMessage_msstate(le.msstate_Invalid),Fields.InvalidMessage_mszip5(le.mszip5_Invalid),Fields.InvalidMessage_mszip4(le.mszip4_Invalid),Fields.InvalidMessage_dthh(le.dthh_Invalid),Fields.InvalidMessage_mscrrt(le.mscrrt_Invalid),Fields.InvalidMessage_msdpbc(le.msdpbc_Invalid),Fields.InvalidMessage_msdpv(le.msdpv_Invalid),Fields.InvalidMessage_ms_addrtype(le.ms_addrtype_Invalid),Fields.InvalidMessage_ctysize(le.ctysize_Invalid),Fields.InvalidMessage_lmos(le.lmos_Invalid),Fields.InvalidMessage_omos(le.omos_Invalid),Fields.InvalidMessage_pmos(le.pmos_Invalid),Fields.InvalidMessage_gen(le.gen_Invalid),Fields.InvalidMessage_dob(le.dob_Invalid),Fields.InvalidMessage_age(le.age_Invalid),Fields.InvalidMessage_inc(le.inc_Invalid),Fields.InvalidMessage_marital_status(le.marital_status_Invalid),Fields.InvalidMessage_poc(le.poc_Invalid),Fields.InvalidMessage_noc(le.noc_Invalid),Fields.InvalidMessage_ocp(le.ocp_Invalid),Fields.InvalidMessage_edu(le.edu_Invalid),Fields.InvalidMessage_lang(le.lang_Invalid),Fields.InvalidMessage_relig(le.relig_Invalid),Fields.InvalidMessage_dwell(le.dwell_Invalid),Fields.InvalidMessage_ownr(le.ownr_Invalid),Fields.InvalidMessage_eth1(le.eth1_Invalid),Fields.InvalidMessage_eth2(le.eth2_Invalid),Fields.InvalidMessage_lor(le.lor_Invalid),Fields.InvalidMessage_pool(le.pool_Invalid),Fields.InvalidMessage_speak_span(le.speak_span_Invalid),Fields.InvalidMessage_soho(le.soho_Invalid),Fields.InvalidMessage_vet_in_hh(le.vet_in_hh_Invalid),Fields.InvalidMessage_ms_mags(le.ms_mags_Invalid),Fields.InvalidMessage_ms_books(le.ms_books_Invalid),Fields.InvalidMessage_ms_publish(le.ms_publish_Invalid),Fields.InvalidMessage_ms_pub_status_active(le.ms_pub_status_active_Invalid),Fields.InvalidMessage_ms_pub_status_expire(le.ms_pub_status_expire_Invalid),Fields.InvalidMessage_ms_pub_premsold(le.ms_pub_premsold_Invalid),Fields.InvalidMessage_ms_pub_autornwl(le.ms_pub_autornwl_Invalid),Fields.InvalidMessage_ms_pub_avgterm(le.ms_pub_avgterm_Invalid),Fields.InvalidMessage_ms_pub_lmos(le.ms_pub_lmos_Invalid),Fields.InvalidMessage_ms_pub_omos(le.ms_pub_omos_Invalid),Fields.InvalidMessage_ms_pub_pmos(le.ms_pub_pmos_Invalid),Fields.InvalidMessage_ms_pub_cemos(le.ms_pub_cemos_Invalid),Fields.InvalidMessage_ms_pub_femos(le.ms_pub_femos_Invalid),Fields.InvalidMessage_ms_pub_totords(le.ms_pub_totords_Invalid),Fields.InvalidMessage_ms_pub_totdlrs(le.ms_pub_totdlrs_Invalid),Fields.InvalidMessage_ms_pub_avgdlrs(le.ms_pub_avgdlrs_Invalid),Fields.InvalidMessage_ms_pub_lastdlrs(le.ms_pub_lastdlrs_Invalid),Fields.InvalidMessage_ms_pub_paystat_paid(le.ms_pub_paystat_paid_Invalid),Fields.InvalidMessage_ms_pub_paystat_ub(le.ms_pub_paystat_ub_Invalid),Fields.InvalidMessage_ms_pub_paymeth_cc(le.ms_pub_paymeth_cc_Invalid),Fields.InvalidMessage_ms_pub_paymeth_cash(le.ms_pub_paymeth_cash_Invalid),Fields.InvalidMessage_ms_pub_payspeed(le.ms_pub_payspeed_Invalid),Fields.InvalidMessage_ms_pub_osrc_dm(le.ms_pub_osrc_dm_Invalid),Fields.InvalidMessage_ms_pub_lsrc_dm(le.ms_pub_lsrc_dm_Invalid),Fields.InvalidMessage_ms_pub_osrc_agt_cashf(le.ms_pub_osrc_agt_cashf_Invalid),Fields.InvalidMessage_ms_pub_lsrc_agt_cashf(le.ms_pub_lsrc_agt_cashf_Invalid),Fields.InvalidMessage_ms_pub_osrc_agt_pds(le.ms_pub_osrc_agt_pds_Invalid),Fields.InvalidMessage_ms_pub_lsrc_agt_pds(le.ms_pub_lsrc_agt_pds_Invalid),Fields.InvalidMessage_ms_pub_osrc_agt_schplan(le.ms_pub_osrc_agt_schplan_Invalid),Fields.InvalidMessage_ms_pub_lsrc_agt_schplan(le.ms_pub_lsrc_agt_schplan_Invalid),Fields.InvalidMessage_ms_pub_osrc_agt_sponsor(le.ms_pub_osrc_agt_sponsor_Invalid),Fields.InvalidMessage_ms_pub_lsrc_agt_sponsor(le.ms_pub_lsrc_agt_sponsor_Invalid),Fields.InvalidMessage_ms_pub_osrc_agt_tm(le.ms_pub_osrc_agt_tm_Invalid),Fields.InvalidMessage_ms_pub_lsrc_agt_tm(le.ms_pub_lsrc_agt_tm_Invalid),Fields.InvalidMessage_ms_pub_osrc_agt(le.ms_pub_osrc_agt_Invalid),Fields.InvalidMessage_ms_pub_lsrc_agt(le.ms_pub_lsrc_agt_Invalid),Fields.InvalidMessage_ms_pub_osrc_tm(le.ms_pub_osrc_tm_Invalid),Fields.InvalidMessage_ms_pub_lsrc_tm(le.ms_pub_lsrc_tm_Invalid),Fields.InvalidMessage_ms_pub_osrc_ins(le.ms_pub_osrc_ins_Invalid),Fields.InvalidMessage_ms_pub_lsrc_ins(le.ms_pub_lsrc_ins_Invalid),Fields.InvalidMessage_ms_pub_osrc_net(le.ms_pub_osrc_net_Invalid),Fields.InvalidMessage_ms_pub_lsrc_net(le.ms_pub_lsrc_net_Invalid),Fields.InvalidMessage_ms_pub_osrc_print(le.ms_pub_osrc_print_Invalid),Fields.InvalidMessage_ms_pub_lsrc_print(le.ms_pub_lsrc_print_Invalid),Fields.InvalidMessage_ms_pub_osrc_trans(le.ms_pub_osrc_trans_Invalid),Fields.InvalidMessage_ms_pub_lsrc_trans(le.ms_pub_lsrc_trans_Invalid),Fields.InvalidMessage_ms_pub_osrc_tv(le.ms_pub_osrc_tv_Invalid),Fields.InvalidMessage_ms_pub_lsrc_tv(le.ms_pub_lsrc_tv_Invalid),Fields.InvalidMessage_ms_pub_osrc_dtp(le.ms_pub_osrc_dtp_Invalid),Fields.InvalidMessage_ms_pub_lsrc_dtp(le.ms_pub_lsrc_dtp_Invalid),Fields.InvalidMessage_ms_pub_giftgivr(le.ms_pub_giftgivr_Invalid),Fields.InvalidMessage_ms_pub_giftee(le.ms_pub_giftee_Invalid),Fields.InvalidMessage_ms_catalog(le.ms_catalog_Invalid),Fields.InvalidMessage_ms_cat_lmos(le.ms_cat_lmos_Invalid),Fields.InvalidMessage_ms_cat_omos(le.ms_cat_omos_Invalid),Fields.InvalidMessage_ms_cat_pmos(le.ms_cat_pmos_Invalid),Fields.InvalidMessage_ms_cat_totords(le.ms_cat_totords_Invalid),Fields.InvalidMessage_ms_cat_totitems(le.ms_cat_totitems_Invalid),Fields.InvalidMessage_ms_cat_totdlrs(le.ms_cat_totdlrs_Invalid),Fields.InvalidMessage_ms_cat_avgdlrs(le.ms_cat_avgdlrs_Invalid),Fields.InvalidMessage_ms_cat_lastdlrs(le.ms_cat_lastdlrs_Invalid),Fields.InvalidMessage_ms_cat_paystat_paid(le.ms_cat_paystat_paid_Invalid),Fields.InvalidMessage_ms_cat_paymeth_cc(le.ms_cat_paymeth_cc_Invalid),Fields.InvalidMessage_ms_cat_paymeth_cash(le.ms_cat_paymeth_cash_Invalid),Fields.InvalidMessage_ms_cat_osrc_dm(le.ms_cat_osrc_dm_Invalid),Fields.InvalidMessage_ms_cat_lsrc_dm(le.ms_cat_lsrc_dm_Invalid),Fields.InvalidMessage_ms_cat_osrc_net(le.ms_cat_osrc_net_Invalid),Fields.InvalidMessage_ms_cat_lsrc_net(le.ms_cat_lsrc_net_Invalid),Fields.InvalidMessage_ms_cat_giftgivr(le.ms_cat_giftgivr_Invalid),Fields.InvalidMessage_pkpubs_corrected(le.pkpubs_corrected_Invalid),Fields.InvalidMessage_pkcatg_corrected(le.pkcatg_corrected_Invalid),Fields.InvalidMessage_ms_fundraising(le.ms_fundraising_Invalid),Fields.InvalidMessage_ms_fund_lmos(le.ms_fund_lmos_Invalid),Fields.InvalidMessage_ms_fund_omos(le.ms_fund_omos_Invalid),Fields.InvalidMessage_ms_fund_pmos(le.ms_fund_pmos_Invalid),Fields.InvalidMessage_ms_fund_totords(le.ms_fund_totords_Invalid),Fields.InvalidMessage_ms_fund_totdlrs(le.ms_fund_totdlrs_Invalid),Fields.InvalidMessage_ms_fund_avgdlrs(le.ms_fund_avgdlrs_Invalid),Fields.InvalidMessage_ms_fund_lastdlrs(le.ms_fund_lastdlrs_Invalid),Fields.InvalidMessage_ms_fund_paystat_paid(le.ms_fund_paystat_paid_Invalid),Fields.InvalidMessage_ms_other(le.ms_other_Invalid),Fields.InvalidMessage_ms_continuity(le.ms_continuity_Invalid),Fields.InvalidMessage_ms_cont_status_active(le.ms_cont_status_active_Invalid),Fields.InvalidMessage_ms_cont_status_cancel(le.ms_cont_status_cancel_Invalid),Fields.InvalidMessage_ms_cont_omos(le.ms_cont_omos_Invalid),Fields.InvalidMessage_ms_cont_lmos(le.ms_cont_lmos_Invalid),Fields.InvalidMessage_ms_cont_pmos(le.ms_cont_pmos_Invalid),Fields.InvalidMessage_ms_cont_totords(le.ms_cont_totords_Invalid),Fields.InvalidMessage_ms_cont_totdlrs(le.ms_cont_totdlrs_Invalid),Fields.InvalidMessage_ms_cont_avgdlrs(le.ms_cont_avgdlrs_Invalid),Fields.InvalidMessage_ms_cont_lastdlrs(le.ms_cont_lastdlrs_Invalid),Fields.InvalidMessage_ms_cont_paystat_paid(le.ms_cont_paystat_paid_Invalid),Fields.InvalidMessage_ms_cont_paymeth_cc(le.ms_cont_paymeth_cc_Invalid),Fields.InvalidMessage_ms_cont_paymeth_cash(le.ms_cont_paymeth_cash_Invalid),Fields.InvalidMessage_ms_totords(le.ms_totords_Invalid),Fields.InvalidMessage_ms_totitems(le.ms_totitems_Invalid),Fields.InvalidMessage_ms_totdlrs(le.ms_totdlrs_Invalid),Fields.InvalidMessage_ms_avgdlrs(le.ms_avgdlrs_Invalid),Fields.InvalidMessage_ms_lastdlrs(le.ms_lastdlrs_Invalid),Fields.InvalidMessage_ms_paystat_paid(le.ms_paystat_paid_Invalid),Fields.InvalidMessage_ms_paymeth_cc(le.ms_paymeth_cc_Invalid),Fields.InvalidMessage_ms_paymeth_cash(le.ms_paymeth_cash_Invalid),Fields.InvalidMessage_ms_osrc_dm(le.ms_osrc_dm_Invalid),Fields.InvalidMessage_ms_lsrc_dm(le.ms_lsrc_dm_Invalid),Fields.InvalidMessage_ms_osrc_tm(le.ms_osrc_tm_Invalid),Fields.InvalidMessage_ms_lsrc_tm(le.ms_lsrc_tm_Invalid),Fields.InvalidMessage_ms_osrc_ins(le.ms_osrc_ins_Invalid),Fields.InvalidMessage_ms_lsrc_ins(le.ms_lsrc_ins_Invalid),Fields.InvalidMessage_ms_osrc_net(le.ms_osrc_net_Invalid),Fields.InvalidMessage_ms_lsrc_net(le.ms_lsrc_net_Invalid),Fields.InvalidMessage_ms_osrc_tv(le.ms_osrc_tv_Invalid),Fields.InvalidMessage_ms_lsrc_tv(le.ms_lsrc_tv_Invalid),Fields.InvalidMessage_ms_osrc_retail(le.ms_osrc_retail_Invalid),Fields.InvalidMessage_ms_lsrc_retail(le.ms_lsrc_retail_Invalid),Fields.InvalidMessage_ms_giftgivr(le.ms_giftgivr_Invalid),Fields.InvalidMessage_ms_giftee(le.ms_giftee_Invalid),Fields.InvalidMessage_ms_adult(le.ms_adult_Invalid),Fields.InvalidMessage_ms_womapp(le.ms_womapp_Invalid),Fields.InvalidMessage_ms_menapp(le.ms_menapp_Invalid),Fields.InvalidMessage_ms_kidapp(le.ms_kidapp_Invalid),Fields.InvalidMessage_ms_accessory(le.ms_accessory_Invalid),Fields.InvalidMessage_ms_apparel(le.ms_apparel_Invalid),Fields.InvalidMessage_ms_app_lmos(le.ms_app_lmos_Invalid),Fields.InvalidMessage_ms_app_omos(le.ms_app_omos_Invalid),Fields.InvalidMessage_ms_app_pmos(le.ms_app_pmos_Invalid),Fields.InvalidMessage_ms_app_totords(le.ms_app_totords_Invalid),Fields.InvalidMessage_ms_app_totitems(le.ms_app_totitems_Invalid),Fields.InvalidMessage_ms_app_totdlrs(le.ms_app_totdlrs_Invalid),Fields.InvalidMessage_ms_app_avgdlrs(le.ms_app_avgdlrs_Invalid),Fields.InvalidMessage_ms_app_lastdlrs(le.ms_app_lastdlrs_Invalid),Fields.InvalidMessage_ms_app_paystat_paid(le.ms_app_paystat_paid_Invalid),Fields.InvalidMessage_ms_app_paymeth_cc(le.ms_app_paymeth_cc_Invalid),Fields.InvalidMessage_ms_app_paymeth_cash(le.ms_app_paymeth_cash_Invalid),Fields.InvalidMessage_ms_menfash(le.ms_menfash_Invalid),Fields.InvalidMessage_ms_womfash(le.ms_womfash_Invalid),Fields.InvalidMessage_ms_wfsh_lmos(le.ms_wfsh_lmos_Invalid),Fields.InvalidMessage_ms_wfsh_omos(le.ms_wfsh_omos_Invalid),Fields.InvalidMessage_ms_wfsh_pmos(le.ms_wfsh_pmos_Invalid),Fields.InvalidMessage_ms_wfsh_totords(le.ms_wfsh_totords_Invalid),Fields.InvalidMessage_ms_wfsh_totdlrs(le.ms_wfsh_totdlrs_Invalid),Fields.InvalidMessage_ms_wfsh_avgdlrs(le.ms_wfsh_avgdlrs_Invalid),Fields.InvalidMessage_ms_wfsh_lastdlrs(le.ms_wfsh_lastdlrs_Invalid),Fields.InvalidMessage_ms_wfsh_paystat_paid(le.ms_wfsh_paystat_paid_Invalid),Fields.InvalidMessage_ms_wfsh_osrc_dm(le.ms_wfsh_osrc_dm_Invalid),Fields.InvalidMessage_ms_wfsh_lsrc_dm(le.ms_wfsh_lsrc_dm_Invalid),Fields.InvalidMessage_ms_wfsh_osrc_agt(le.ms_wfsh_osrc_agt_Invalid),Fields.InvalidMessage_ms_wfsh_lsrc_agt(le.ms_wfsh_lsrc_agt_Invalid),Fields.InvalidMessage_ms_audio(le.ms_audio_Invalid),Fields.InvalidMessage_ms_auto(le.ms_auto_Invalid),Fields.InvalidMessage_ms_aviation(le.ms_aviation_Invalid),Fields.InvalidMessage_ms_bargains(le.ms_bargains_Invalid),Fields.InvalidMessage_ms_beauty(le.ms_beauty_Invalid),Fields.InvalidMessage_ms_bible(le.ms_bible_Invalid),Fields.InvalidMessage_ms_bible_lmos(le.ms_bible_lmos_Invalid),Fields.InvalidMessage_ms_bible_omos(le.ms_bible_omos_Invalid),Fields.InvalidMessage_ms_bible_pmos(le.ms_bible_pmos_Invalid),Fields.InvalidMessage_ms_bible_totords(le.ms_bible_totords_Invalid),Fields.InvalidMessage_ms_bible_totitems(le.ms_bible_totitems_Invalid),Fields.InvalidMessage_ms_bible_totdlrs(le.ms_bible_totdlrs_Invalid),Fields.InvalidMessage_ms_bible_avgdlrs(le.ms_bible_avgdlrs_Invalid),Fields.InvalidMessage_ms_bible_lastdlrs(le.ms_bible_lastdlrs_Invalid),Fields.InvalidMessage_ms_bible_paystat_paid(le.ms_bible_paystat_paid_Invalid),Fields.InvalidMessage_ms_bible_paymeth_cc(le.ms_bible_paymeth_cc_Invalid),Fields.InvalidMessage_ms_bible_paymeth_cash(le.ms_bible_paymeth_cash_Invalid),Fields.InvalidMessage_ms_business(le.ms_business_Invalid),Fields.InvalidMessage_ms_collectibles(le.ms_collectibles_Invalid),Fields.InvalidMessage_ms_computers(le.ms_computers_Invalid),Fields.InvalidMessage_ms_crafts(le.ms_crafts_Invalid),Fields.InvalidMessage_ms_culturearts(le.ms_culturearts_Invalid),Fields.InvalidMessage_ms_currevent(le.ms_currevent_Invalid),Fields.InvalidMessage_ms_diy(le.ms_diy_Invalid),Fields.InvalidMessage_ms_electronics(le.ms_electronics_Invalid),Fields.InvalidMessage_ms_equestrian(le.ms_equestrian_Invalid),Fields.InvalidMessage_ms_pub_family(le.ms_pub_family_Invalid),Fields.InvalidMessage_ms_cat_family(le.ms_cat_family_Invalid),Fields.InvalidMessage_ms_family(le.ms_family_Invalid),Fields.InvalidMessage_ms_family_lmos(le.ms_family_lmos_Invalid),Fields.InvalidMessage_ms_family_omos(le.ms_family_omos_Invalid),Fields.InvalidMessage_ms_family_pmos(le.ms_family_pmos_Invalid),Fields.InvalidMessage_ms_family_totords(le.ms_family_totords_Invalid),Fields.InvalidMessage_ms_family_totitems(le.ms_family_totitems_Invalid),Fields.InvalidMessage_ms_family_totdlrs(le.ms_family_totdlrs_Invalid),Fields.InvalidMessage_ms_family_avgdlrs(le.ms_family_avgdlrs_Invalid),Fields.InvalidMessage_ms_family_lastdlrs(le.ms_family_lastdlrs_Invalid),Fields.InvalidMessage_ms_family_paystat_paid(le.ms_family_paystat_paid_Invalid),Fields.InvalidMessage_ms_family_paymeth_cc(le.ms_family_paymeth_cc_Invalid),Fields.InvalidMessage_ms_family_paymeth_cash(le.ms_family_paymeth_cash_Invalid),Fields.InvalidMessage_ms_family_osrc_dm(le.ms_family_osrc_dm_Invalid),Fields.InvalidMessage_ms_family_lsrc_dm(le.ms_family_lsrc_dm_Invalid),Fields.InvalidMessage_ms_fiction(le.ms_fiction_Invalid),Fields.InvalidMessage_ms_food(le.ms_food_Invalid),Fields.InvalidMessage_ms_games(le.ms_games_Invalid),Fields.InvalidMessage_ms_gifts(le.ms_gifts_Invalid),Fields.InvalidMessage_ms_gourmet(le.ms_gourmet_Invalid),Fields.InvalidMessage_ms_fitness(le.ms_fitness_Invalid),Fields.InvalidMessage_ms_health(le.ms_health_Invalid),Fields.InvalidMessage_ms_hlth_lmos(le.ms_hlth_lmos_Invalid),Fields.InvalidMessage_ms_hlth_omos(le.ms_hlth_omos_Invalid),Fields.InvalidMessage_ms_hlth_pmos(le.ms_hlth_pmos_Invalid),Fields.InvalidMessage_ms_hlth_totords(le.ms_hlth_totords_Invalid),Fields.InvalidMessage_ms_hlth_totdlrs(le.ms_hlth_totdlrs_Invalid),Fields.InvalidMessage_ms_hlth_avgdlrs(le.ms_hlth_avgdlrs_Invalid),Fields.InvalidMessage_ms_hlth_lastdlrs(le.ms_hlth_lastdlrs_Invalid),Fields.InvalidMessage_ms_hlth_paystat_paid(le.ms_hlth_paystat_paid_Invalid),Fields.InvalidMessage_ms_hlth_paymeth_cc(le.ms_hlth_paymeth_cc_Invalid),Fields.InvalidMessage_ms_hlth_osrc_dm(le.ms_hlth_osrc_dm_Invalid),Fields.InvalidMessage_ms_hlth_lsrc_dm(le.ms_hlth_lsrc_dm_Invalid),Fields.InvalidMessage_ms_hlth_osrc_agt(le.ms_hlth_osrc_agt_Invalid),Fields.InvalidMessage_ms_hlth_lsrc_agt(le.ms_hlth_lsrc_agt_Invalid),Fields.InvalidMessage_ms_hlth_osrc_tv(le.ms_hlth_osrc_tv_Invalid),Fields.InvalidMessage_ms_hlth_lsrc_tv(le.ms_hlth_lsrc_tv_Invalid),Fields.InvalidMessage_ms_holiday(le.ms_holiday_Invalid),Fields.InvalidMessage_ms_history(le.ms_history_Invalid),Fields.InvalidMessage_ms_pub_cooking(le.ms_pub_cooking_Invalid),Fields.InvalidMessage_ms_cooking(le.ms_cooking_Invalid),Fields.InvalidMessage_ms_pub_homedecr(le.ms_pub_homedecr_Invalid),Fields.InvalidMessage_ms_cat_homedecr(le.ms_cat_homedecr_Invalid),Fields.InvalidMessage_ms_homedecr(le.ms_homedecr_Invalid),Fields.InvalidMessage_ms_housewares(le.ms_housewares_Invalid),Fields.InvalidMessage_ms_pub_garden(le.ms_pub_garden_Invalid),Fields.InvalidMessage_ms_cat_garden(le.ms_cat_garden_Invalid),Fields.InvalidMessage_ms_garden(le.ms_garden_Invalid),Fields.InvalidMessage_ms_pub_homeliv(le.ms_pub_homeliv_Invalid),Fields.InvalidMessage_ms_cat_homeliv(le.ms_cat_homeliv_Invalid),Fields.InvalidMessage_ms_homeliv(le.ms_homeliv_Invalid),Fields.InvalidMessage_ms_pub_home_status_active(le.ms_pub_home_status_active_Invalid),Fields.InvalidMessage_ms_home_lmos(le.ms_home_lmos_Invalid),Fields.InvalidMessage_ms_home_omos(le.ms_home_omos_Invalid),Fields.InvalidMessage_ms_home_pmos(le.ms_home_pmos_Invalid),Fields.InvalidMessage_ms_home_totords(le.ms_home_totords_Invalid),Fields.InvalidMessage_ms_home_totitems(le.ms_home_totitems_Invalid),Fields.InvalidMessage_ms_home_totdlrs(le.ms_home_totdlrs_Invalid),Fields.InvalidMessage_ms_home_avgdlrs(le.ms_home_avgdlrs_Invalid),Fields.InvalidMessage_ms_home_lastdlrs(le.ms_home_lastdlrs_Invalid),Fields.InvalidMessage_ms_home_paystat_paid(le.ms_home_paystat_paid_Invalid),Fields.InvalidMessage_ms_home_paymeth_cc(le.ms_home_paymeth_cc_Invalid),Fields.InvalidMessage_ms_home_paymeth_cash(le.ms_home_paymeth_cash_Invalid),Fields.InvalidMessage_ms_home_osrc_dm(le.ms_home_osrc_dm_Invalid),Fields.InvalidMessage_ms_home_lsrc_dm(le.ms_home_lsrc_dm_Invalid),Fields.InvalidMessage_ms_home_osrc_agt(le.ms_home_osrc_agt_Invalid),Fields.InvalidMessage_ms_home_lsrc_agt(le.ms_home_lsrc_agt_Invalid),Fields.InvalidMessage_ms_home_osrc_net(le.ms_home_osrc_net_Invalid),Fields.InvalidMessage_ms_home_lsrc_net(le.ms_home_lsrc_net_Invalid),Fields.InvalidMessage_ms_home_osrc_tv(le.ms_home_osrc_tv_Invalid),Fields.InvalidMessage_ms_home_lsrc_tv(le.ms_home_lsrc_tv_Invalid),Fields.InvalidMessage_ms_humor(le.ms_humor_Invalid),Fields.InvalidMessage_ms_inspiration(le.ms_inspiration_Invalid),Fields.InvalidMessage_ms_merchandise(le.ms_merchandise_Invalid),Fields.InvalidMessage_ms_moneymaking(le.ms_moneymaking_Invalid),Fields.InvalidMessage_ms_moneymaking_lmos(le.ms_moneymaking_lmos_Invalid),Fields.InvalidMessage_ms_motorcycles(le.ms_motorcycles_Invalid),Fields.InvalidMessage_ms_music(le.ms_music_Invalid),Fields.InvalidMessage_ms_fishing(le.ms_fishing_Invalid),Fields.InvalidMessage_ms_hunting(le.ms_hunting_Invalid),Fields.InvalidMessage_ms_boatsail(le.ms_boatsail_Invalid),Fields.InvalidMessage_ms_camp(le.ms_camp_Invalid),Fields.InvalidMessage_ms_pub_outdoors(le.ms_pub_outdoors_Invalid),Fields.InvalidMessage_ms_cat_outdoors(le.ms_cat_outdoors_Invalid),Fields.InvalidMessage_ms_outdoors(le.ms_outdoors_Invalid),Fields.InvalidMessage_ms_pub_out_status_active(le.ms_pub_out_status_active_Invalid),Fields.InvalidMessage_ms_out_lmos(le.ms_out_lmos_Invalid),Fields.InvalidMessage_ms_out_omos(le.ms_out_omos_Invalid),Fields.InvalidMessage_ms_out_pmos(le.ms_out_pmos_Invalid),Fields.InvalidMessage_ms_out_totords(le.ms_out_totords_Invalid),Fields.InvalidMessage_ms_out_totitems(le.ms_out_totitems_Invalid),Fields.InvalidMessage_ms_out_totdlrs(le.ms_out_totdlrs_Invalid),Fields.InvalidMessage_ms_out_avgdlrs(le.ms_out_avgdlrs_Invalid),Fields.InvalidMessage_ms_out_lastdlrs(le.ms_out_lastdlrs_Invalid),Fields.InvalidMessage_ms_out_paystat_paid(le.ms_out_paystat_paid_Invalid),Fields.InvalidMessage_ms_out_paymeth_cc(le.ms_out_paymeth_cc_Invalid),Fields.InvalidMessage_ms_out_paymeth_cash(le.ms_out_paymeth_cash_Invalid),Fields.InvalidMessage_ms_out_osrc_dm(le.ms_out_osrc_dm_Invalid),Fields.InvalidMessage_ms_out_lsrc_dm(le.ms_out_lsrc_dm_Invalid),Fields.InvalidMessage_ms_out_osrc_agt(le.ms_out_osrc_agt_Invalid),Fields.InvalidMessage_ms_out_lsrc_agt(le.ms_out_lsrc_agt_Invalid),Fields.InvalidMessage_ms_pets(le.ms_pets_Invalid),Fields.InvalidMessage_ms_pfin(le.ms_pfin_Invalid),Fields.InvalidMessage_ms_photo(le.ms_photo_Invalid),Fields.InvalidMessage_ms_photoproc(le.ms_photoproc_Invalid),Fields.InvalidMessage_ms_rural(le.ms_rural_Invalid),Fields.InvalidMessage_ms_science(le.ms_science_Invalid),Fields.InvalidMessage_ms_sports(le.ms_sports_Invalid),Fields.InvalidMessage_ms_sports_lmos(le.ms_sports_lmos_Invalid),Fields.InvalidMessage_ms_travel(le.ms_travel_Invalid),Fields.InvalidMessage_ms_tvmovies(le.ms_tvmovies_Invalid),Fields.InvalidMessage_ms_wildlife(le.ms_wildlife_Invalid),Fields.InvalidMessage_ms_woman(le.ms_woman_Invalid),Fields.InvalidMessage_ms_woman_lmos(le.ms_woman_lmos_Invalid),Fields.InvalidMessage_ms_ringtones_apps(le.ms_ringtones_apps_Invalid),Fields.InvalidMessage_cpi_mobile_apps_index(le.cpi_mobile_apps_index_Invalid),Fields.InvalidMessage_cpi_credit_repair_index(le.cpi_credit_repair_index_Invalid),Fields.InvalidMessage_cpi_credit_report_index(le.cpi_credit_report_index_Invalid),Fields.InvalidMessage_cpi_education_seekers_index(le.cpi_education_seekers_index_Invalid),Fields.InvalidMessage_cpi_insurance_index(le.cpi_insurance_index_Invalid),Fields.InvalidMessage_cpi_insurance_health_index(le.cpi_insurance_health_index_Invalid),Fields.InvalidMessage_cpi_insurance_auto_index(le.cpi_insurance_auto_index_Invalid),Fields.InvalidMessage_cpi_job_seekers_index(le.cpi_job_seekers_index_Invalid),Fields.InvalidMessage_cpi_social_networking_index(le.cpi_social_networking_index_Invalid),Fields.InvalidMessage_cpi_adult_index(le.cpi_adult_index_Invalid),Fields.InvalidMessage_cpi_africanamerican_index(le.cpi_africanamerican_index_Invalid),Fields.InvalidMessage_cpi_apparel_index(le.cpi_apparel_index_Invalid),Fields.InvalidMessage_cpi_apparel_accessory_index(le.cpi_apparel_accessory_index_Invalid),Fields.InvalidMessage_cpi_apparel_kids_index(le.cpi_apparel_kids_index_Invalid),Fields.InvalidMessage_cpi_apparel_men_index(le.cpi_apparel_men_index_Invalid),Fields.InvalidMessage_cpi_apparel_menfash_index(le.cpi_apparel_menfash_index_Invalid),Fields.InvalidMessage_cpi_apparel_women_index(le.cpi_apparel_women_index_Invalid),Fields.InvalidMessage_cpi_apparel_womfash_index(le.cpi_apparel_womfash_index_Invalid),Fields.InvalidMessage_cpi_asian_index(le.cpi_asian_index_Invalid),Fields.InvalidMessage_cpi_auto_index(le.cpi_auto_index_Invalid),Fields.InvalidMessage_cpi_auto_racing_index(le.cpi_auto_racing_index_Invalid),Fields.InvalidMessage_cpi_auto_trucks_index(le.cpi_auto_trucks_index_Invalid),Fields.InvalidMessage_cpi_aviation_index(le.cpi_aviation_index_Invalid),Fields.InvalidMessage_cpi_bargains_index(le.cpi_bargains_index_Invalid),Fields.InvalidMessage_cpi_beauty_index(le.cpi_beauty_index_Invalid),Fields.InvalidMessage_cpi_bible_index(le.cpi_bible_index_Invalid),Fields.InvalidMessage_cpi_birds_index(le.cpi_birds_index_Invalid),Fields.InvalidMessage_cpi_business_index(le.cpi_business_index_Invalid),Fields.InvalidMessage_cpi_business_homeoffice_index(le.cpi_business_homeoffice_index_Invalid),Fields.InvalidMessage_cpi_catalog_index(le.cpi_catalog_index_Invalid),Fields.InvalidMessage_cpi_cc_index(le.cpi_cc_index_Invalid),Fields.InvalidMessage_cpi_collectibles_index(le.cpi_collectibles_index_Invalid),Fields.InvalidMessage_cpi_college_index(le.cpi_college_index_Invalid),Fields.InvalidMessage_cpi_computers_index(le.cpi_computers_index_Invalid),Fields.InvalidMessage_cpi_conservative_index(le.cpi_conservative_index_Invalid),Fields.InvalidMessage_cpi_continuity_index(le.cpi_continuity_index_Invalid),Fields.InvalidMessage_cpi_cooking_index(le.cpi_cooking_index_Invalid),Fields.InvalidMessage_cpi_crafts_index(le.cpi_crafts_index_Invalid),Fields.InvalidMessage_cpi_crafts_crochet_index(le.cpi_crafts_crochet_index_Invalid),Fields.InvalidMessage_cpi_crafts_knit_index(le.cpi_crafts_knit_index_Invalid),Fields.InvalidMessage_cpi_crafts_needlepoint_index(le.cpi_crafts_needlepoint_index_Invalid),Fields.InvalidMessage_cpi_crafts_quilt_index(le.cpi_crafts_quilt_index_Invalid),Fields.InvalidMessage_cpi_crafts_sew_index(le.cpi_crafts_sew_index_Invalid),Fields.InvalidMessage_cpi_culturearts_index(le.cpi_culturearts_index_Invalid),Fields.InvalidMessage_cpi_currevent_index(le.cpi_currevent_index_Invalid),Fields.InvalidMessage_cpi_diy_index(le.cpi_diy_index_Invalid),Fields.InvalidMessage_cpi_donor_index(le.cpi_donor_index_Invalid),Fields.InvalidMessage_cpi_ego_index(le.cpi_ego_index_Invalid),Fields.InvalidMessage_cpi_electronics_index(le.cpi_electronics_index_Invalid),Fields.InvalidMessage_cpi_equestrian_index(le.cpi_equestrian_index_Invalid),Fields.InvalidMessage_cpi_family_index(le.cpi_family_index_Invalid),Fields.InvalidMessage_cpi_family_teen_index(le.cpi_family_teen_index_Invalid),Fields.InvalidMessage_cpi_family_young_index(le.cpi_family_young_index_Invalid),Fields.InvalidMessage_cpi_fiction_index(le.cpi_fiction_index_Invalid),Fields.InvalidMessage_cpi_gambling_index(le.cpi_gambling_index_Invalid),Fields.InvalidMessage_cpi_games_index(le.cpi_games_index_Invalid),Fields.InvalidMessage_cpi_gardening_index(le.cpi_gardening_index_Invalid),Fields.InvalidMessage_cpi_gay_index(le.cpi_gay_index_Invalid),Fields.InvalidMessage_cpi_giftgivr_index(le.cpi_giftgivr_index_Invalid),Fields.InvalidMessage_cpi_gourmet_index(le.cpi_gourmet_index_Invalid),Fields.InvalidMessage_cpi_grandparents_index(le.cpi_grandparents_index_Invalid),Fields.InvalidMessage_cpi_health_index(le.cpi_health_index_Invalid),Fields.InvalidMessage_cpi_health_diet_index(le.cpi_health_diet_index_Invalid),Fields.InvalidMessage_cpi_health_fitness_index(le.cpi_health_fitness_index_Invalid),Fields.InvalidMessage_cpi_hightech_index(le.cpi_hightech_index_Invalid),Fields.InvalidMessage_cpi_hispanic_index(le.cpi_hispanic_index_Invalid),Fields.InvalidMessage_cpi_history_index(le.cpi_history_index_Invalid),Fields.InvalidMessage_cpi_history_american_index(le.cpi_history_american_index_Invalid),Fields.InvalidMessage_cpi_hobbies_index(le.cpi_hobbies_index_Invalid),Fields.InvalidMessage_cpi_homedecr_index(le.cpi_homedecr_index_Invalid),Fields.InvalidMessage_cpi_homeliv_index(le.cpi_homeliv_index_Invalid),Fields.InvalidMessage_cpi_humor_index(le.cpi_humor_index_Invalid),Fields.InvalidMessage_cpi_inspiration_index(le.cpi_inspiration_index_Invalid),Fields.InvalidMessage_cpi_internet_index(le.cpi_internet_index_Invalid),Fields.InvalidMessage_cpi_internet_access_index(le.cpi_internet_access_index_Invalid),Fields.InvalidMessage_cpi_internet_buy_index(le.cpi_internet_buy_index_Invalid),Fields.InvalidMessage_cpi_liberal_index(le.cpi_liberal_index_Invalid),Fields.InvalidMessage_cpi_moneymaking_index(le.cpi_moneymaking_index_Invalid),Fields.InvalidMessage_cpi_motorcycles_index(le.cpi_motorcycles_index_Invalid),Fields.InvalidMessage_cpi_music_index(le.cpi_music_index_Invalid),Fields.InvalidMessage_cpi_nonfiction_index(le.cpi_nonfiction_index_Invalid),Fields.InvalidMessage_cpi_ocean_index(le.cpi_ocean_index_Invalid),Fields.InvalidMessage_cpi_outdoors_index(le.cpi_outdoors_index_Invalid),Fields.InvalidMessage_cpi_outdoors_boatsail_index(le.cpi_outdoors_boatsail_index_Invalid),Fields.InvalidMessage_cpi_outdoors_camp_index(le.cpi_outdoors_camp_index_Invalid),Fields.InvalidMessage_cpi_outdoors_fishing_index(le.cpi_outdoors_fishing_index_Invalid),Fields.InvalidMessage_cpi_outdoors_huntfish_index(le.cpi_outdoors_huntfish_index_Invalid),Fields.InvalidMessage_cpi_outdoors_hunting_index(le.cpi_outdoors_hunting_index_Invalid),Fields.InvalidMessage_cpi_pets_index(le.cpi_pets_index_Invalid),Fields.InvalidMessage_cpi_pets_cats_index(le.cpi_pets_cats_index_Invalid),Fields.InvalidMessage_cpi_pets_dogs_index(le.cpi_pets_dogs_index_Invalid),Fields.InvalidMessage_cpi_pfin_index(le.cpi_pfin_index_Invalid),Fields.InvalidMessage_cpi_photog_index(le.cpi_photog_index_Invalid),Fields.InvalidMessage_cpi_photoproc_index(le.cpi_photoproc_index_Invalid),Fields.InvalidMessage_cpi_publish_index(le.cpi_publish_index_Invalid),Fields.InvalidMessage_cpi_publish_books_index(le.cpi_publish_books_index_Invalid),Fields.InvalidMessage_cpi_publish_mags_index(le.cpi_publish_mags_index_Invalid),Fields.InvalidMessage_cpi_rural_index(le.cpi_rural_index_Invalid),Fields.InvalidMessage_cpi_science_index(le.cpi_science_index_Invalid),Fields.InvalidMessage_cpi_scifi_index(le.cpi_scifi_index_Invalid),Fields.InvalidMessage_cpi_seniors_index(le.cpi_seniors_index_Invalid),Fields.InvalidMessage_cpi_sports_index(le.cpi_sports_index_Invalid),Fields.InvalidMessage_cpi_sports_baseball_index(le.cpi_sports_baseball_index_Invalid),Fields.InvalidMessage_cpi_sports_basketball_index(le.cpi_sports_basketball_index_Invalid),Fields.InvalidMessage_cpi_sports_biking_index(le.cpi_sports_biking_index_Invalid),Fields.InvalidMessage_cpi_sports_football_index(le.cpi_sports_football_index_Invalid),Fields.InvalidMessage_cpi_sports_golf_index(le.cpi_sports_golf_index_Invalid),Fields.InvalidMessage_cpi_sports_hockey_index(le.cpi_sports_hockey_index_Invalid),Fields.InvalidMessage_cpi_sports_running_index(le.cpi_sports_running_index_Invalid),Fields.InvalidMessage_cpi_sports_ski_index(le.cpi_sports_ski_index_Invalid),Fields.InvalidMessage_cpi_sports_soccer_index(le.cpi_sports_soccer_index_Invalid),Fields.InvalidMessage_cpi_sports_swimming_index(le.cpi_sports_swimming_index_Invalid),Fields.InvalidMessage_cpi_sports_tennis_index(le.cpi_sports_tennis_index_Invalid),Fields.InvalidMessage_cpi_stationery_index(le.cpi_stationery_index_Invalid),Fields.InvalidMessage_cpi_sweeps_index(le.cpi_sweeps_index_Invalid),Fields.InvalidMessage_cpi_tobacco_index(le.cpi_tobacco_index_Invalid),Fields.InvalidMessage_cpi_travel_index(le.cpi_travel_index_Invalid),Fields.InvalidMessage_cpi_travel_cruise_index(le.cpi_travel_cruise_index_Invalid),Fields.InvalidMessage_cpi_travel_rv_index(le.cpi_travel_rv_index_Invalid),Fields.InvalidMessage_cpi_travel_us_index(le.cpi_travel_us_index_Invalid),Fields.InvalidMessage_cpi_tvmovies_index(le.cpi_tvmovies_index_Invalid),Fields.InvalidMessage_cpi_wildlife_index(le.cpi_wildlife_index_Invalid),Fields.InvalidMessage_cpi_woman_index(le.cpi_woman_index_Invalid),Fields.InvalidMessage_totdlr_index(le.totdlr_index_Invalid),Fields.InvalidMessage_cpi_totdlr(le.cpi_totdlr_Invalid),Fields.InvalidMessage_cpi_totords(le.cpi_totords_Invalid),Fields.InvalidMessage_cpi_lastdlr(le.cpi_lastdlr_Invalid),Fields.InvalidMessage_pkcatg(le.pkcatg_Invalid),Fields.InvalidMessage_pkpubs(le.pkpubs_Invalid),Fields.InvalidMessage_pkcont(le.pkcont_Invalid),Fields.InvalidMessage_pkca01(le.pkca01_Invalid),Fields.InvalidMessage_pkca03(le.pkca03_Invalid),Fields.InvalidMessage_pkca04(le.pkca04_Invalid),Fields.InvalidMessage_pkca05(le.pkca05_Invalid),Fields.InvalidMessage_pkca06(le.pkca06_Invalid),Fields.InvalidMessage_pkca07(le.pkca07_Invalid),Fields.InvalidMessage_pkca08(le.pkca08_Invalid),Fields.InvalidMessage_pkca09(le.pkca09_Invalid),Fields.InvalidMessage_pkca10(le.pkca10_Invalid),Fields.InvalidMessage_pkca11(le.pkca11_Invalid),Fields.InvalidMessage_pkca12(le.pkca12_Invalid),Fields.InvalidMessage_pkca13(le.pkca13_Invalid),Fields.InvalidMessage_pkca14(le.pkca14_Invalid),Fields.InvalidMessage_pkca15(le.pkca15_Invalid),Fields.InvalidMessage_pkca16(le.pkca16_Invalid),Fields.InvalidMessage_pkca17(le.pkca17_Invalid),Fields.InvalidMessage_pkca18(le.pkca18_Invalid),Fields.InvalidMessage_pkca20(le.pkca20_Invalid),Fields.InvalidMessage_pkca21(le.pkca21_Invalid),Fields.InvalidMessage_pkca22(le.pkca22_Invalid),Fields.InvalidMessage_pkca23(le.pkca23_Invalid),Fields.InvalidMessage_pkca24(le.pkca24_Invalid),Fields.InvalidMessage_pkca25(le.pkca25_Invalid),Fields.InvalidMessage_pkca26(le.pkca26_Invalid),Fields.InvalidMessage_pkca28(le.pkca28_Invalid),Fields.InvalidMessage_pkca29(le.pkca29_Invalid),Fields.InvalidMessage_pkca30(le.pkca30_Invalid),Fields.InvalidMessage_pkca31(le.pkca31_Invalid),Fields.InvalidMessage_pkca32(le.pkca32_Invalid),Fields.InvalidMessage_pkca33(le.pkca33_Invalid),Fields.InvalidMessage_pkca34(le.pkca34_Invalid),Fields.InvalidMessage_pkca35(le.pkca35_Invalid),Fields.InvalidMessage_pkca36(le.pkca36_Invalid),Fields.InvalidMessage_pkca37(le.pkca37_Invalid),Fields.InvalidMessage_pkca39(le.pkca39_Invalid),Fields.InvalidMessage_pkca40(le.pkca40_Invalid),Fields.InvalidMessage_pkca41(le.pkca41_Invalid),Fields.InvalidMessage_pkca42(le.pkca42_Invalid),Fields.InvalidMessage_pkca54(le.pkca54_Invalid),Fields.InvalidMessage_pkca61(le.pkca61_Invalid),Fields.InvalidMessage_pkca62(le.pkca62_Invalid),Fields.InvalidMessage_pkca64(le.pkca64_Invalid),Fields.InvalidMessage_pkpu01(le.pkpu01_Invalid),Fields.InvalidMessage_pkpu02(le.pkpu02_Invalid),Fields.InvalidMessage_pkpu03(le.pkpu03_Invalid),Fields.InvalidMessage_pkpu04(le.pkpu04_Invalid),Fields.InvalidMessage_pkpu05(le.pkpu05_Invalid),Fields.InvalidMessage_pkpu06(le.pkpu06_Invalid),Fields.InvalidMessage_pkpu07(le.pkpu07_Invalid),Fields.InvalidMessage_pkpu08(le.pkpu08_Invalid),Fields.InvalidMessage_pkpu09(le.pkpu09_Invalid),Fields.InvalidMessage_pkpu10(le.pkpu10_Invalid),Fields.InvalidMessage_pkpu11(le.pkpu11_Invalid),Fields.InvalidMessage_pkpu12(le.pkpu12_Invalid),Fields.InvalidMessage_pkpu13(le.pkpu13_Invalid),Fields.InvalidMessage_pkpu14(le.pkpu14_Invalid),Fields.InvalidMessage_pkpu15(le.pkpu15_Invalid),Fields.InvalidMessage_pkpu16(le.pkpu16_Invalid),Fields.InvalidMessage_pkpu17(le.pkpu17_Invalid),Fields.InvalidMessage_pkpu18(le.pkpu18_Invalid),Fields.InvalidMessage_pkpu19(le.pkpu19_Invalid),Fields.InvalidMessage_pkpu20(le.pkpu20_Invalid),Fields.InvalidMessage_pkpu23(le.pkpu23_Invalid),Fields.InvalidMessage_pkpu25(le.pkpu25_Invalid),Fields.InvalidMessage_pkpu27(le.pkpu27_Invalid),Fields.InvalidMessage_pkpu28(le.pkpu28_Invalid),Fields.InvalidMessage_pkpu29(le.pkpu29_Invalid),Fields.InvalidMessage_pkpu30(le.pkpu30_Invalid),Fields.InvalidMessage_pkpu31(le.pkpu31_Invalid),Fields.InvalidMessage_pkpu32(le.pkpu32_Invalid),Fields.InvalidMessage_pkpu33(le.pkpu33_Invalid),Fields.InvalidMessage_pkpu34(le.pkpu34_Invalid),Fields.InvalidMessage_pkpu35(le.pkpu35_Invalid),Fields.InvalidMessage_pkpu38(le.pkpu38_Invalid),Fields.InvalidMessage_pkpu41(le.pkpu41_Invalid),Fields.InvalidMessage_pkpu42(le.pkpu42_Invalid),Fields.InvalidMessage_pkpu45(le.pkpu45_Invalid),Fields.InvalidMessage_pkpu46(le.pkpu46_Invalid),Fields.InvalidMessage_pkpu47(le.pkpu47_Invalid),Fields.InvalidMessage_pkpu48(le.pkpu48_Invalid),Fields.InvalidMessage_pkpu49(le.pkpu49_Invalid),Fields.InvalidMessage_pkpu50(le.pkpu50_Invalid),Fields.InvalidMessage_pkpu51(le.pkpu51_Invalid),Fields.InvalidMessage_pkpu52(le.pkpu52_Invalid),Fields.InvalidMessage_pkpu53(le.pkpu53_Invalid),Fields.InvalidMessage_pkpu54(le.pkpu54_Invalid),Fields.InvalidMessage_pkpu55(le.pkpu55_Invalid),Fields.InvalidMessage_pkpu56(le.pkpu56_Invalid),Fields.InvalidMessage_pkpu57(le.pkpu57_Invalid),Fields.InvalidMessage_pkpu60(le.pkpu60_Invalid),Fields.InvalidMessage_pkpu61(le.pkpu61_Invalid),Fields.InvalidMessage_pkpu62(le.pkpu62_Invalid),Fields.InvalidMessage_pkpu63(le.pkpu63_Invalid),Fields.InvalidMessage_pkpu64(le.pkpu64_Invalid),Fields.InvalidMessage_pkpu65(le.pkpu65_Invalid),Fields.InvalidMessage_pkpu66(le.pkpu66_Invalid),Fields.InvalidMessage_pkpu67(le.pkpu67_Invalid),Fields.InvalidMessage_pkpu68(le.pkpu68_Invalid),Fields.InvalidMessage_pkpu69(le.pkpu69_Invalid),Fields.InvalidMessage_pkpu70(le.pkpu70_Invalid),Fields.InvalidMessage_censpct_water(le.censpct_water_Invalid),Fields.InvalidMessage_cens_pop_density(le.cens_pop_density_Invalid),Fields.InvalidMessage_cens_hu_density(le.cens_hu_density_Invalid),Fields.InvalidMessage_censpct_pop_white(le.censpct_pop_white_Invalid),Fields.InvalidMessage_censpct_pop_black(le.censpct_pop_black_Invalid),Fields.InvalidMessage_censpct_pop_amerind(le.censpct_pop_amerind_Invalid),Fields.InvalidMessage_censpct_pop_asian(le.censpct_pop_asian_Invalid),Fields.InvalidMessage_censpct_pop_pacisl(le.censpct_pop_pacisl_Invalid),Fields.InvalidMessage_censpct_pop_othrace(le.censpct_pop_othrace_Invalid),Fields.InvalidMessage_censpct_pop_multirace(le.censpct_pop_multirace_Invalid),Fields.InvalidMessage_censpct_pop_hispanic(le.censpct_pop_hispanic_Invalid),Fields.InvalidMessage_censpct_pop_agelt18(le.censpct_pop_agelt18_Invalid),Fields.InvalidMessage_censpct_pop_males(le.censpct_pop_males_Invalid),Fields.InvalidMessage_censpct_adult_age1824(le.censpct_adult_age1824_Invalid),Fields.InvalidMessage_censpct_adult_age2534(le.censpct_adult_age2534_Invalid),Fields.InvalidMessage_censpct_adult_age3544(le.censpct_adult_age3544_Invalid),Fields.InvalidMessage_censpct_adult_age4554(le.censpct_adult_age4554_Invalid),Fields.InvalidMessage_censpct_adult_age5564(le.censpct_adult_age5564_Invalid),Fields.InvalidMessage_censpct_adult_agege65(le.censpct_adult_agege65_Invalid),Fields.InvalidMessage_cens_pop_medage(le.cens_pop_medage_Invalid),Fields.InvalidMessage_cens_hh_avgsize(le.cens_hh_avgsize_Invalid),Fields.InvalidMessage_censpct_hh_family(le.censpct_hh_family_Invalid),Fields.InvalidMessage_censpct_hh_family_husbwife(le.censpct_hh_family_husbwife_Invalid),Fields.InvalidMessage_censpct_hu_occupied(le.censpct_hu_occupied_Invalid),Fields.InvalidMessage_censpct_hu_owned(le.censpct_hu_owned_Invalid),Fields.InvalidMessage_censpct_hu_rented(le.censpct_hu_rented_Invalid),Fields.InvalidMessage_censpct_hu_vacantseasonal(le.censpct_hu_vacantseasonal_Invalid),Fields.InvalidMessage_zip_medinc(le.zip_medinc_Invalid),Fields.InvalidMessage_zip_apparel(le.zip_apparel_Invalid),Fields.InvalidMessage_zip_apparel_women(le.zip_apparel_women_Invalid),Fields.InvalidMessage_zip_apparel_womfash(le.zip_apparel_womfash_Invalid),Fields.InvalidMessage_zip_auto(le.zip_auto_Invalid),Fields.InvalidMessage_zip_beauty(le.zip_beauty_Invalid),Fields.InvalidMessage_zip_booksmusicmovies(le.zip_booksmusicmovies_Invalid),Fields.InvalidMessage_zip_business(le.zip_business_Invalid),Fields.InvalidMessage_zip_catalog(le.zip_catalog_Invalid),Fields.InvalidMessage_zip_cc(le.zip_cc_Invalid),Fields.InvalidMessage_zip_collectibles(le.zip_collectibles_Invalid),Fields.InvalidMessage_zip_computers(le.zip_computers_Invalid),Fields.InvalidMessage_zip_continuity(le.zip_continuity_Invalid),Fields.InvalidMessage_zip_cooking(le.zip_cooking_Invalid),Fields.InvalidMessage_zip_crafts(le.zip_crafts_Invalid),Fields.InvalidMessage_zip_culturearts(le.zip_culturearts_Invalid),Fields.InvalidMessage_zip_dm_sold(le.zip_dm_sold_Invalid),Fields.InvalidMessage_zip_donor(le.zip_donor_Invalid),Fields.InvalidMessage_zip_family(le.zip_family_Invalid),Fields.InvalidMessage_zip_gardening(le.zip_gardening_Invalid),Fields.InvalidMessage_zip_giftgivr(le.zip_giftgivr_Invalid),Fields.InvalidMessage_zip_gourmet(le.zip_gourmet_Invalid),Fields.InvalidMessage_zip_health(le.zip_health_Invalid),Fields.InvalidMessage_zip_health_diet(le.zip_health_diet_Invalid),Fields.InvalidMessage_zip_health_fitness(le.zip_health_fitness_Invalid),Fields.InvalidMessage_zip_hobbies(le.zip_hobbies_Invalid),Fields.InvalidMessage_zip_homedecr(le.zip_homedecr_Invalid),Fields.InvalidMessage_zip_homeliv(le.zip_homeliv_Invalid),Fields.InvalidMessage_zip_internet(le.zip_internet_Invalid),Fields.InvalidMessage_zip_internet_access(le.zip_internet_access_Invalid),Fields.InvalidMessage_zip_internet_buy(le.zip_internet_buy_Invalid),Fields.InvalidMessage_zip_music(le.zip_music_Invalid),Fields.InvalidMessage_zip_outdoors(le.zip_outdoors_Invalid),Fields.InvalidMessage_zip_pets(le.zip_pets_Invalid),Fields.InvalidMessage_zip_pfin(le.zip_pfin_Invalid),Fields.InvalidMessage_zip_publish(le.zip_publish_Invalid),Fields.InvalidMessage_zip_publish_books(le.zip_publish_books_Invalid),Fields.InvalidMessage_zip_publish_mags(le.zip_publish_mags_Invalid),Fields.InvalidMessage_zip_sports(le.zip_sports_Invalid),Fields.InvalidMessage_zip_sports_biking(le.zip_sports_biking_Invalid),Fields.InvalidMessage_zip_sports_golf(le.zip_sports_golf_Invalid),Fields.InvalidMessage_zip_travel(le.zip_travel_Invalid),Fields.InvalidMessage_zip_travel_us(le.zip_travel_us_Invalid),Fields.InvalidMessage_zip_tvmovies(le.zip_tvmovies_Invalid),Fields.InvalidMessage_zip_woman(le.zip_woman_Invalid),Fields.InvalidMessage_zip_proftech(le.zip_proftech_Invalid),Fields.InvalidMessage_zip_retired(le.zip_retired_Invalid),Fields.InvalidMessage_zip_inc100(le.zip_inc100_Invalid),Fields.InvalidMessage_zip_inc75(le.zip_inc75_Invalid),Fields.InvalidMessage_zip_inc50(le.zip_inc50_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.dtmatch_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.msname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.msaddr1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.msaddr2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mscity_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.msstate_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.mszip5_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.mszip4_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.dthh_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.mscrrt_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.msdpbc_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.msdpv_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.ms_addrtype_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.ctysize_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.lmos_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.omos_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pmos_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.gen_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.dob_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.age_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.inc_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.marital_status_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.poc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.noc_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.ocp_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.edu_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.lang_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.relig_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.dwell_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.ownr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.eth1_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.eth2_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.lor_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.pool_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.speak_span_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.soho_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.vet_in_hh_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.ms_mags_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_books_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_publish_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_status_active_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_status_expire_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_premsold_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_autornwl_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_avgterm_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_lmos_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_omos_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_pmos_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_cemos_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_femos_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_totords_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_totdlrs_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_avgdlrs_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_lastdlrs_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_paystat_paid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_paystat_ub_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_paymeth_cc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_paymeth_cash_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_payspeed_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_osrc_dm_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_lsrc_dm_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_osrc_agt_cashf_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_lsrc_agt_cashf_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_osrc_agt_pds_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_lsrc_agt_pds_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_osrc_agt_schplan_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_lsrc_agt_schplan_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_osrc_agt_sponsor_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_lsrc_agt_sponsor_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_osrc_agt_tm_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_lsrc_agt_tm_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_osrc_agt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_lsrc_agt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_osrc_tm_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_lsrc_tm_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_osrc_ins_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_lsrc_ins_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_osrc_net_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_lsrc_net_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_osrc_print_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_lsrc_print_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_osrc_trans_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_lsrc_trans_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_osrc_tv_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_lsrc_tv_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_osrc_dtp_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_lsrc_dtp_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_giftgivr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_giftee_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_catalog_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_cat_lmos_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_cat_omos_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_cat_pmos_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_cat_totords_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_cat_totitems_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_cat_totdlrs_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_cat_avgdlrs_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_cat_lastdlrs_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_cat_paystat_paid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_cat_paymeth_cc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_cat_paymeth_cash_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_cat_osrc_dm_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_cat_lsrc_dm_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_cat_osrc_net_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_cat_lsrc_net_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_cat_giftgivr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpubs_corrected_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkcatg_corrected_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_fundraising_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_fund_lmos_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_fund_omos_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_fund_pmos_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_fund_totords_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_fund_totdlrs_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_fund_avgdlrs_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_fund_lastdlrs_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_fund_paystat_paid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_other_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_continuity_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_cont_status_active_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_cont_status_cancel_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_cont_omos_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_cont_lmos_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_cont_pmos_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_cont_totords_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_cont_totdlrs_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_cont_avgdlrs_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_cont_lastdlrs_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_cont_paystat_paid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_cont_paymeth_cc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_cont_paymeth_cash_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_totords_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_totitems_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_totdlrs_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_avgdlrs_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_lastdlrs_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_paystat_paid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_paymeth_cc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_paymeth_cash_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_osrc_dm_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_lsrc_dm_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_osrc_tm_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_lsrc_tm_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_osrc_ins_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_lsrc_ins_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_osrc_net_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_lsrc_net_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_osrc_tv_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_lsrc_tv_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_osrc_retail_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_lsrc_retail_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_giftgivr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_giftee_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_adult_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_womapp_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_menapp_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_kidapp_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_accessory_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_apparel_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_app_lmos_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_app_omos_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_app_pmos_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_app_totords_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_app_totitems_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_app_totdlrs_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_app_avgdlrs_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_app_lastdlrs_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_app_paystat_paid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_app_paymeth_cc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_app_paymeth_cash_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_menfash_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_womfash_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_wfsh_lmos_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_wfsh_omos_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_wfsh_pmos_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_wfsh_totords_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_wfsh_totdlrs_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_wfsh_avgdlrs_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_wfsh_lastdlrs_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_wfsh_paystat_paid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_wfsh_osrc_dm_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_wfsh_lsrc_dm_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_wfsh_osrc_agt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_wfsh_lsrc_agt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_audio_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_auto_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_aviation_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_bargains_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_beauty_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_bible_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_bible_lmos_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_bible_omos_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_bible_pmos_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_bible_totords_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_bible_totitems_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_bible_totdlrs_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_bible_avgdlrs_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_bible_lastdlrs_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_bible_paystat_paid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_bible_paymeth_cc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_bible_paymeth_cash_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_business_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_collectibles_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_computers_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_crafts_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_culturearts_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_currevent_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_diy_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_electronics_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_equestrian_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_family_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_cat_family_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_family_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_family_lmos_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_family_omos_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_family_pmos_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_family_totords_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_family_totitems_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_family_totdlrs_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_family_avgdlrs_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_family_lastdlrs_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_family_paystat_paid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_family_paymeth_cc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_family_paymeth_cash_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_family_osrc_dm_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_family_lsrc_dm_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_fiction_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_food_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_games_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_gifts_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_gourmet_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_fitness_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_health_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_hlth_lmos_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_hlth_omos_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_hlth_pmos_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_hlth_totords_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_hlth_totdlrs_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_hlth_avgdlrs_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_hlth_lastdlrs_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_hlth_paystat_paid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_hlth_paymeth_cc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_hlth_osrc_dm_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_hlth_lsrc_dm_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_hlth_osrc_agt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_hlth_lsrc_agt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_hlth_osrc_tv_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_hlth_lsrc_tv_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_holiday_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_history_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_cooking_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_cooking_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_homedecr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_cat_homedecr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_homedecr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_housewares_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_garden_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_cat_garden_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_garden_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_homeliv_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_cat_homeliv_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_homeliv_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_home_status_active_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_home_lmos_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_home_omos_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_home_pmos_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_home_totords_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_home_totitems_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_home_totdlrs_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_home_avgdlrs_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_home_lastdlrs_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_home_paystat_paid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_home_paymeth_cc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_home_paymeth_cash_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_home_osrc_dm_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_home_lsrc_dm_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_home_osrc_agt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_home_lsrc_agt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_home_osrc_net_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_home_lsrc_net_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_home_osrc_tv_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_home_lsrc_tv_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_humor_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_inspiration_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_merchandise_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_moneymaking_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_moneymaking_lmos_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_motorcycles_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_music_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_fishing_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_hunting_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_boatsail_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_camp_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_outdoors_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_cat_outdoors_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_outdoors_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pub_out_status_active_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_out_lmos_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_out_omos_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_out_pmos_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_out_totords_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_out_totitems_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_out_totdlrs_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_out_avgdlrs_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_out_lastdlrs_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_out_paystat_paid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_out_paymeth_cc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_out_paymeth_cash_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_out_osrc_dm_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_out_lsrc_dm_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_out_osrc_agt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_out_lsrc_agt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pets_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_pfin_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_photo_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_photoproc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_rural_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_science_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_sports_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_sports_lmos_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_travel_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_tvmovies_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_wildlife_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_woman_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_woman_lmos_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ms_ringtones_apps_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_mobile_apps_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_credit_repair_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_credit_report_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_education_seekers_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_insurance_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_insurance_health_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_insurance_auto_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_job_seekers_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_social_networking_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_adult_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_africanamerican_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_apparel_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_apparel_accessory_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_apparel_kids_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_apparel_men_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_apparel_menfash_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_apparel_women_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_apparel_womfash_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_asian_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_auto_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_auto_racing_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_auto_trucks_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_aviation_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_bargains_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_beauty_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_bible_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_birds_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_business_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_business_homeoffice_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_catalog_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_cc_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_collectibles_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_college_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_computers_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_conservative_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_continuity_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_cooking_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_crafts_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_crafts_crochet_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_crafts_knit_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_crafts_needlepoint_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_crafts_quilt_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_crafts_sew_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_culturearts_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_currevent_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_diy_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_donor_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_ego_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_electronics_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_equestrian_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_family_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_family_teen_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_family_young_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_fiction_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_gambling_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_games_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_gardening_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_gay_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_giftgivr_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_gourmet_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_grandparents_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_health_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_health_diet_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_health_fitness_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_hightech_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_hispanic_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_history_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_history_american_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_hobbies_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_homedecr_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_homeliv_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_humor_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_inspiration_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_internet_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_internet_access_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_internet_buy_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_liberal_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_moneymaking_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_motorcycles_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_music_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_nonfiction_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_ocean_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_outdoors_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_outdoors_boatsail_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_outdoors_camp_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_outdoors_fishing_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_outdoors_huntfish_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_outdoors_hunting_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_pets_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_pets_cats_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_pets_dogs_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_pfin_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_photog_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_photoproc_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_publish_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_publish_books_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_publish_mags_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_rural_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_science_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_scifi_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_seniors_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_sports_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_sports_baseball_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_sports_basketball_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_sports_biking_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_sports_football_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_sports_golf_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_sports_hockey_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_sports_running_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_sports_ski_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_sports_soccer_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_sports_swimming_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_sports_tennis_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_stationery_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_sweeps_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_tobacco_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_travel_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_travel_cruise_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_travel_rv_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_travel_us_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_tvmovies_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_wildlife_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_woman_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.totdlr_index_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_totdlr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_totords_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpi_lastdlr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkcatg_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpubs_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkcont_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkca01_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkca03_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkca04_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkca05_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkca06_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkca07_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkca08_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkca09_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkca10_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkca11_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkca12_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkca13_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkca14_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkca15_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkca16_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkca17_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkca18_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkca20_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkca21_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkca22_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkca23_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkca24_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkca25_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkca26_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkca28_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkca29_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkca30_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkca31_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkca32_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkca33_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkca34_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkca35_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkca36_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkca37_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkca39_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkca40_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkca41_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkca42_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkca54_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkca61_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkca62_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkca64_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu01_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu02_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu03_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu04_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu05_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu06_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu07_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu08_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu09_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu10_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu11_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu12_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu13_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu14_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu15_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu16_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu17_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu18_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu19_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu20_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu23_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu25_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu27_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu28_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu29_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu30_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu31_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu32_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu33_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu34_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu35_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu38_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu41_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu42_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu45_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu46_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu47_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu48_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu49_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu50_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu51_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu52_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu53_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu54_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu55_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu56_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu57_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu60_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu61_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu62_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu63_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu64_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu65_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu66_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu67_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu68_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu69_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pkpu70_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.censpct_water_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cens_pop_density_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cens_hu_density_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.censpct_pop_white_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.censpct_pop_black_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.censpct_pop_amerind_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.censpct_pop_asian_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.censpct_pop_pacisl_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.censpct_pop_othrace_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.censpct_pop_multirace_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.censpct_pop_hispanic_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.censpct_pop_agelt18_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.censpct_pop_males_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.censpct_adult_age1824_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.censpct_adult_age2534_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.censpct_adult_age3544_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.censpct_adult_age4554_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.censpct_adult_age5564_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.censpct_adult_agege65_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cens_pop_medage_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cens_hh_avgsize_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.censpct_hh_family_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.censpct_hh_family_husbwife_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.censpct_hu_occupied_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.censpct_hu_owned_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.censpct_hu_rented_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.censpct_hu_vacantseasonal_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_medinc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_apparel_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_apparel_women_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_apparel_womfash_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_auto_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_beauty_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_booksmusicmovies_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_business_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_catalog_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_cc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_collectibles_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_computers_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_continuity_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_cooking_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_crafts_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_culturearts_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_dm_sold_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_donor_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_family_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_gardening_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_giftgivr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_gourmet_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_health_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_health_diet_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_health_fitness_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_hobbies_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_homedecr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_homeliv_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_internet_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_internet_access_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_internet_buy_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_music_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_outdoors_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_pets_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_pfin_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_publish_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_publish_books_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_publish_mags_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_sports_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_sports_biking_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_sports_golf_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_travel_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_travel_us_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_tvmovies_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_woman_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_proftech_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_retired_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_inc100_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_inc75_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_inc50_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'dtmatch','msname','msaddr1','msaddr2','mscity','msstate','mszip5','mszip4','dthh','mscrrt','msdpbc','msdpv','ms_addrtype','ctysize','lmos','omos','pmos','gen','dob','age','inc','marital_status','poc','noc','ocp','edu','lang','relig','dwell','ownr','eth1','eth2','lor','pool','speak_span','soho','vet_in_hh','ms_mags','ms_books','ms_publish','ms_pub_status_active','ms_pub_status_expire','ms_pub_premsold','ms_pub_autornwl','ms_pub_avgterm','ms_pub_lmos','ms_pub_omos','ms_pub_pmos','ms_pub_cemos','ms_pub_femos','ms_pub_totords','ms_pub_totdlrs','ms_pub_avgdlrs','ms_pub_lastdlrs','ms_pub_paystat_paid','ms_pub_paystat_ub','ms_pub_paymeth_cc','ms_pub_paymeth_cash','ms_pub_payspeed','ms_pub_osrc_dm','ms_pub_lsrc_dm','ms_pub_osrc_agt_cashf','ms_pub_lsrc_agt_cashf','ms_pub_osrc_agt_pds','ms_pub_lsrc_agt_pds','ms_pub_osrc_agt_schplan','ms_pub_lsrc_agt_schplan','ms_pub_osrc_agt_sponsor','ms_pub_lsrc_agt_sponsor','ms_pub_osrc_agt_tm','ms_pub_lsrc_agt_tm','ms_pub_osrc_agt','ms_pub_lsrc_agt','ms_pub_osrc_tm','ms_pub_lsrc_tm','ms_pub_osrc_ins','ms_pub_lsrc_ins','ms_pub_osrc_net','ms_pub_lsrc_net','ms_pub_osrc_print','ms_pub_lsrc_print','ms_pub_osrc_trans','ms_pub_lsrc_trans','ms_pub_osrc_tv','ms_pub_lsrc_tv','ms_pub_osrc_dtp','ms_pub_lsrc_dtp','ms_pub_giftgivr','ms_pub_giftee','ms_catalog','ms_cat_lmos','ms_cat_omos','ms_cat_pmos','ms_cat_totords','ms_cat_totitems','ms_cat_totdlrs','ms_cat_avgdlrs','ms_cat_lastdlrs','ms_cat_paystat_paid','ms_cat_paymeth_cc','ms_cat_paymeth_cash','ms_cat_osrc_dm','ms_cat_lsrc_dm','ms_cat_osrc_net','ms_cat_lsrc_net','ms_cat_giftgivr','pkpubs_corrected','pkcatg_corrected','ms_fundraising','ms_fund_lmos','ms_fund_omos','ms_fund_pmos','ms_fund_totords','ms_fund_totdlrs','ms_fund_avgdlrs','ms_fund_lastdlrs','ms_fund_paystat_paid','ms_other','ms_continuity','ms_cont_status_active','ms_cont_status_cancel','ms_cont_omos','ms_cont_lmos','ms_cont_pmos','ms_cont_totords','ms_cont_totdlrs','ms_cont_avgdlrs','ms_cont_lastdlrs','ms_cont_paystat_paid','ms_cont_paymeth_cc','ms_cont_paymeth_cash','ms_totords','ms_totitems','ms_totdlrs','ms_avgdlrs','ms_lastdlrs','ms_paystat_paid','ms_paymeth_cc','ms_paymeth_cash','ms_osrc_dm','ms_lsrc_dm','ms_osrc_tm','ms_lsrc_tm','ms_osrc_ins','ms_lsrc_ins','ms_osrc_net','ms_lsrc_net','ms_osrc_tv','ms_lsrc_tv','ms_osrc_retail','ms_lsrc_retail','ms_giftgivr','ms_giftee','ms_adult','ms_womapp','ms_menapp','ms_kidapp','ms_accessory','ms_apparel','ms_app_lmos','ms_app_omos','ms_app_pmos','ms_app_totords','ms_app_totitems','ms_app_totdlrs','ms_app_avgdlrs','ms_app_lastdlrs','ms_app_paystat_paid','ms_app_paymeth_cc','ms_app_paymeth_cash','ms_menfash','ms_womfash','ms_wfsh_lmos','ms_wfsh_omos','ms_wfsh_pmos','ms_wfsh_totords','ms_wfsh_totdlrs','ms_wfsh_avgdlrs','ms_wfsh_lastdlrs','ms_wfsh_paystat_paid','ms_wfsh_osrc_dm','ms_wfsh_lsrc_dm','ms_wfsh_osrc_agt','ms_wfsh_lsrc_agt','ms_audio','ms_auto','ms_aviation','ms_bargains','ms_beauty','ms_bible','ms_bible_lmos','ms_bible_omos','ms_bible_pmos','ms_bible_totords','ms_bible_totitems','ms_bible_totdlrs','ms_bible_avgdlrs','ms_bible_lastdlrs','ms_bible_paystat_paid','ms_bible_paymeth_cc','ms_bible_paymeth_cash','ms_business','ms_collectibles','ms_computers','ms_crafts','ms_culturearts','ms_currevent','ms_diy','ms_electronics','ms_equestrian','ms_pub_family','ms_cat_family','ms_family','ms_family_lmos','ms_family_omos','ms_family_pmos','ms_family_totords','ms_family_totitems','ms_family_totdlrs','ms_family_avgdlrs','ms_family_lastdlrs','ms_family_paystat_paid','ms_family_paymeth_cc','ms_family_paymeth_cash','ms_family_osrc_dm','ms_family_lsrc_dm','ms_fiction','ms_food','ms_games','ms_gifts','ms_gourmet','ms_fitness','ms_health','ms_hlth_lmos','ms_hlth_omos','ms_hlth_pmos','ms_hlth_totords','ms_hlth_totdlrs','ms_hlth_avgdlrs','ms_hlth_lastdlrs','ms_hlth_paystat_paid','ms_hlth_paymeth_cc','ms_hlth_osrc_dm','ms_hlth_lsrc_dm','ms_hlth_osrc_agt','ms_hlth_lsrc_agt','ms_hlth_osrc_tv','ms_hlth_lsrc_tv','ms_holiday','ms_history','ms_pub_cooking','ms_cooking','ms_pub_homedecr','ms_cat_homedecr','ms_homedecr','ms_housewares','ms_pub_garden','ms_cat_garden','ms_garden','ms_pub_homeliv','ms_cat_homeliv','ms_homeliv','ms_pub_home_status_active','ms_home_lmos','ms_home_omos','ms_home_pmos','ms_home_totords','ms_home_totitems','ms_home_totdlrs','ms_home_avgdlrs','ms_home_lastdlrs','ms_home_paystat_paid','ms_home_paymeth_cc','ms_home_paymeth_cash','ms_home_osrc_dm','ms_home_lsrc_dm','ms_home_osrc_agt','ms_home_lsrc_agt','ms_home_osrc_net','ms_home_lsrc_net','ms_home_osrc_tv','ms_home_lsrc_tv','ms_humor','ms_inspiration','ms_merchandise','ms_moneymaking','ms_moneymaking_lmos','ms_motorcycles','ms_music','ms_fishing','ms_hunting','ms_boatsail','ms_camp','ms_pub_outdoors','ms_cat_outdoors','ms_outdoors','ms_pub_out_status_active','ms_out_lmos','ms_out_omos','ms_out_pmos','ms_out_totords','ms_out_totitems','ms_out_totdlrs','ms_out_avgdlrs','ms_out_lastdlrs','ms_out_paystat_paid','ms_out_paymeth_cc','ms_out_paymeth_cash','ms_out_osrc_dm','ms_out_lsrc_dm','ms_out_osrc_agt','ms_out_lsrc_agt','ms_pets','ms_pfin','ms_photo','ms_photoproc','ms_rural','ms_science','ms_sports','ms_sports_lmos','ms_travel','ms_tvmovies','ms_wildlife','ms_woman','ms_woman_lmos','ms_ringtones_apps','cpi_mobile_apps_index','cpi_credit_repair_index','cpi_credit_report_index','cpi_education_seekers_index','cpi_insurance_index','cpi_insurance_health_index','cpi_insurance_auto_index','cpi_job_seekers_index','cpi_social_networking_index','cpi_adult_index','cpi_africanamerican_index','cpi_apparel_index','cpi_apparel_accessory_index','cpi_apparel_kids_index','cpi_apparel_men_index','cpi_apparel_menfash_index','cpi_apparel_women_index','cpi_apparel_womfash_index','cpi_asian_index','cpi_auto_index','cpi_auto_racing_index','cpi_auto_trucks_index','cpi_aviation_index','cpi_bargains_index','cpi_beauty_index','cpi_bible_index','cpi_birds_index','cpi_business_index','cpi_business_homeoffice_index','cpi_catalog_index','cpi_cc_index','cpi_collectibles_index','cpi_college_index','cpi_computers_index','cpi_conservative_index','cpi_continuity_index','cpi_cooking_index','cpi_crafts_index','cpi_crafts_crochet_index','cpi_crafts_knit_index','cpi_crafts_needlepoint_index','cpi_crafts_quilt_index','cpi_crafts_sew_index','cpi_culturearts_index','cpi_currevent_index','cpi_diy_index','cpi_donor_index','cpi_ego_index','cpi_electronics_index','cpi_equestrian_index','cpi_family_index','cpi_family_teen_index','cpi_family_young_index','cpi_fiction_index','cpi_gambling_index','cpi_games_index','cpi_gardening_index','cpi_gay_index','cpi_giftgivr_index','cpi_gourmet_index','cpi_grandparents_index','cpi_health_index','cpi_health_diet_index','cpi_health_fitness_index','cpi_hightech_index','cpi_hispanic_index','cpi_history_index','cpi_history_american_index','cpi_hobbies_index','cpi_homedecr_index','cpi_homeliv_index','cpi_humor_index','cpi_inspiration_index','cpi_internet_index','cpi_internet_access_index','cpi_internet_buy_index','cpi_liberal_index','cpi_moneymaking_index','cpi_motorcycles_index','cpi_music_index','cpi_nonfiction_index','cpi_ocean_index','cpi_outdoors_index','cpi_outdoors_boatsail_index','cpi_outdoors_camp_index','cpi_outdoors_fishing_index','cpi_outdoors_huntfish_index','cpi_outdoors_hunting_index','cpi_pets_index','cpi_pets_cats_index','cpi_pets_dogs_index','cpi_pfin_index','cpi_photog_index','cpi_photoproc_index','cpi_publish_index','cpi_publish_books_index','cpi_publish_mags_index','cpi_rural_index','cpi_science_index','cpi_scifi_index','cpi_seniors_index','cpi_sports_index','cpi_sports_baseball_index','cpi_sports_basketball_index','cpi_sports_biking_index','cpi_sports_football_index','cpi_sports_golf_index','cpi_sports_hockey_index','cpi_sports_running_index','cpi_sports_ski_index','cpi_sports_soccer_index','cpi_sports_swimming_index','cpi_sports_tennis_index','cpi_stationery_index','cpi_sweeps_index','cpi_tobacco_index','cpi_travel_index','cpi_travel_cruise_index','cpi_travel_rv_index','cpi_travel_us_index','cpi_tvmovies_index','cpi_wildlife_index','cpi_woman_index','totdlr_index','cpi_totdlr','cpi_totords','cpi_lastdlr','pkcatg','pkpubs','pkcont','pkca01','pkca03','pkca04','pkca05','pkca06','pkca07','pkca08','pkca09','pkca10','pkca11','pkca12','pkca13','pkca14','pkca15','pkca16','pkca17','pkca18','pkca20','pkca21','pkca22','pkca23','pkca24','pkca25','pkca26','pkca28','pkca29','pkca30','pkca31','pkca32','pkca33','pkca34','pkca35','pkca36','pkca37','pkca39','pkca40','pkca41','pkca42','pkca54','pkca61','pkca62','pkca64','pkpu01','pkpu02','pkpu03','pkpu04','pkpu05','pkpu06','pkpu07','pkpu08','pkpu09','pkpu10','pkpu11','pkpu12','pkpu13','pkpu14','pkpu15','pkpu16','pkpu17','pkpu18','pkpu19','pkpu20','pkpu23','pkpu25','pkpu27','pkpu28','pkpu29','pkpu30','pkpu31','pkpu32','pkpu33','pkpu34','pkpu35','pkpu38','pkpu41','pkpu42','pkpu45','pkpu46','pkpu47','pkpu48','pkpu49','pkpu50','pkpu51','pkpu52','pkpu53','pkpu54','pkpu55','pkpu56','pkpu57','pkpu60','pkpu61','pkpu62','pkpu63','pkpu64','pkpu65','pkpu66','pkpu67','pkpu68','pkpu69','pkpu70','censpct_water','cens_pop_density','cens_hu_density','censpct_pop_white','censpct_pop_black','censpct_pop_amerind','censpct_pop_asian','censpct_pop_pacisl','censpct_pop_othrace','censpct_pop_multirace','censpct_pop_hispanic','censpct_pop_agelt18','censpct_pop_males','censpct_adult_age1824','censpct_adult_age2534','censpct_adult_age3544','censpct_adult_age4554','censpct_adult_age5564','censpct_adult_agege65','cens_pop_medage','cens_hh_avgsize','censpct_hh_family','censpct_hh_family_husbwife','censpct_hu_occupied','censpct_hu_owned','censpct_hu_rented','censpct_hu_vacantseasonal','zip_medinc','zip_apparel','zip_apparel_women','zip_apparel_womfash','zip_auto','zip_beauty','zip_booksmusicmovies','zip_business','zip_catalog','zip_cc','zip_collectibles','zip_computers','zip_continuity','zip_cooking','zip_crafts','zip_culturearts','zip_dm_sold','zip_donor','zip_family','zip_gardening','zip_giftgivr','zip_gourmet','zip_health','zip_health_diet','zip_health_fitness','zip_hobbies','zip_homedecr','zip_homeliv','zip_internet','zip_internet_access','zip_internet_buy','zip_music','zip_outdoors','zip_pets','zip_pfin','zip_publish','zip_publish_books','zip_publish_mags','zip_sports','zip_sports_biking','zip_sports_golf','zip_travel','zip_travel_us','zip_tvmovies','zip_woman','zip_proftech','zip_retired','zip_inc100','zip_inc75','zip_inc50','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'ALPHANUMERIC','FULLNAME','FULL_ADDRESS','FULL_ADDRESS','CITY','ST','ZIP5','HASZIP4','ALPHANUMERIC','ALPHANUMERIC','ALPHANUMERIC','ALPHANUMERIC','ALPHANUMERIC','ALPHANUMERIC','NUMBER','NUMBER','NUMBER','GENDER_CODE','invalid_date','NUMBER','INC_CODE','ALPHA','ALPHA','ALPHANUMERIC','OPC_CODE','EDU_CODE','GENERAL_CODE','RELIG_CODE','DWELL_CODE','ALPHA','GENERAL_CODE','GENERAL_CODE','ALPHANUMERIC','ALPHANUMERIC','ALPHANUMERIC','ALPHANUMERIC','ALPHANUMERIC','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','NUMBER','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.dtmatch,(SALT311.StrType)le.msname,(SALT311.StrType)le.msaddr1,(SALT311.StrType)le.msaddr2,(SALT311.StrType)le.mscity,(SALT311.StrType)le.msstate,(SALT311.StrType)le.mszip5,(SALT311.StrType)le.mszip4,(SALT311.StrType)le.dthh,(SALT311.StrType)le.mscrrt,(SALT311.StrType)le.msdpbc,(SALT311.StrType)le.msdpv,(SALT311.StrType)le.ms_addrtype,(SALT311.StrType)le.ctysize,(SALT311.StrType)le.lmos,(SALT311.StrType)le.omos,(SALT311.StrType)le.pmos,(SALT311.StrType)le.gen,(SALT311.StrType)le.dob,(SALT311.StrType)le.age,(SALT311.StrType)le.inc,(SALT311.StrType)le.marital_status,(SALT311.StrType)le.poc,(SALT311.StrType)le.noc,(SALT311.StrType)le.ocp,(SALT311.StrType)le.edu,(SALT311.StrType)le.lang,(SALT311.StrType)le.relig,(SALT311.StrType)le.dwell,(SALT311.StrType)le.ownr,(SALT311.StrType)le.eth1,(SALT311.StrType)le.eth2,(SALT311.StrType)le.lor,(SALT311.StrType)le.pool,(SALT311.StrType)le.speak_span,(SALT311.StrType)le.soho,(SALT311.StrType)le.vet_in_hh,(SALT311.StrType)le.ms_mags,(SALT311.StrType)le.ms_books,(SALT311.StrType)le.ms_publish,(SALT311.StrType)le.ms_pub_status_active,(SALT311.StrType)le.ms_pub_status_expire,(SALT311.StrType)le.ms_pub_premsold,(SALT311.StrType)le.ms_pub_autornwl,(SALT311.StrType)le.ms_pub_avgterm,(SALT311.StrType)le.ms_pub_lmos,(SALT311.StrType)le.ms_pub_omos,(SALT311.StrType)le.ms_pub_pmos,(SALT311.StrType)le.ms_pub_cemos,(SALT311.StrType)le.ms_pub_femos,(SALT311.StrType)le.ms_pub_totords,(SALT311.StrType)le.ms_pub_totdlrs,(SALT311.StrType)le.ms_pub_avgdlrs,(SALT311.StrType)le.ms_pub_lastdlrs,(SALT311.StrType)le.ms_pub_paystat_paid,(SALT311.StrType)le.ms_pub_paystat_ub,(SALT311.StrType)le.ms_pub_paymeth_cc,(SALT311.StrType)le.ms_pub_paymeth_cash,(SALT311.StrType)le.ms_pub_payspeed,(SALT311.StrType)le.ms_pub_osrc_dm,(SALT311.StrType)le.ms_pub_lsrc_dm,(SALT311.StrType)le.ms_pub_osrc_agt_cashf,(SALT311.StrType)le.ms_pub_lsrc_agt_cashf,(SALT311.StrType)le.ms_pub_osrc_agt_pds,(SALT311.StrType)le.ms_pub_lsrc_agt_pds,(SALT311.StrType)le.ms_pub_osrc_agt_schplan,(SALT311.StrType)le.ms_pub_lsrc_agt_schplan,(SALT311.StrType)le.ms_pub_osrc_agt_sponsor,(SALT311.StrType)le.ms_pub_lsrc_agt_sponsor,(SALT311.StrType)le.ms_pub_osrc_agt_tm,(SALT311.StrType)le.ms_pub_lsrc_agt_tm,(SALT311.StrType)le.ms_pub_osrc_agt,(SALT311.StrType)le.ms_pub_lsrc_agt,(SALT311.StrType)le.ms_pub_osrc_tm,(SALT311.StrType)le.ms_pub_lsrc_tm,(SALT311.StrType)le.ms_pub_osrc_ins,(SALT311.StrType)le.ms_pub_lsrc_ins,(SALT311.StrType)le.ms_pub_osrc_net,(SALT311.StrType)le.ms_pub_lsrc_net,(SALT311.StrType)le.ms_pub_osrc_print,(SALT311.StrType)le.ms_pub_lsrc_print,(SALT311.StrType)le.ms_pub_osrc_trans,(SALT311.StrType)le.ms_pub_lsrc_trans,(SALT311.StrType)le.ms_pub_osrc_tv,(SALT311.StrType)le.ms_pub_lsrc_tv,(SALT311.StrType)le.ms_pub_osrc_dtp,(SALT311.StrType)le.ms_pub_lsrc_dtp,(SALT311.StrType)le.ms_pub_giftgivr,(SALT311.StrType)le.ms_pub_giftee,(SALT311.StrType)le.ms_catalog,(SALT311.StrType)le.ms_cat_lmos,(SALT311.StrType)le.ms_cat_omos,(SALT311.StrType)le.ms_cat_pmos,(SALT311.StrType)le.ms_cat_totords,(SALT311.StrType)le.ms_cat_totitems,(SALT311.StrType)le.ms_cat_totdlrs,(SALT311.StrType)le.ms_cat_avgdlrs,(SALT311.StrType)le.ms_cat_lastdlrs,(SALT311.StrType)le.ms_cat_paystat_paid,(SALT311.StrType)le.ms_cat_paymeth_cc,(SALT311.StrType)le.ms_cat_paymeth_cash,(SALT311.StrType)le.ms_cat_osrc_dm,(SALT311.StrType)le.ms_cat_lsrc_dm,(SALT311.StrType)le.ms_cat_osrc_net,(SALT311.StrType)le.ms_cat_lsrc_net,(SALT311.StrType)le.ms_cat_giftgivr,(SALT311.StrType)le.pkpubs_corrected,(SALT311.StrType)le.pkcatg_corrected,(SALT311.StrType)le.ms_fundraising,(SALT311.StrType)le.ms_fund_lmos,(SALT311.StrType)le.ms_fund_omos,(SALT311.StrType)le.ms_fund_pmos,(SALT311.StrType)le.ms_fund_totords,(SALT311.StrType)le.ms_fund_totdlrs,(SALT311.StrType)le.ms_fund_avgdlrs,(SALT311.StrType)le.ms_fund_lastdlrs,(SALT311.StrType)le.ms_fund_paystat_paid,(SALT311.StrType)le.ms_other,(SALT311.StrType)le.ms_continuity,(SALT311.StrType)le.ms_cont_status_active,(SALT311.StrType)le.ms_cont_status_cancel,(SALT311.StrType)le.ms_cont_omos,(SALT311.StrType)le.ms_cont_lmos,(SALT311.StrType)le.ms_cont_pmos,(SALT311.StrType)le.ms_cont_totords,(SALT311.StrType)le.ms_cont_totdlrs,(SALT311.StrType)le.ms_cont_avgdlrs,(SALT311.StrType)le.ms_cont_lastdlrs,(SALT311.StrType)le.ms_cont_paystat_paid,(SALT311.StrType)le.ms_cont_paymeth_cc,(SALT311.StrType)le.ms_cont_paymeth_cash,(SALT311.StrType)le.ms_totords,(SALT311.StrType)le.ms_totitems,(SALT311.StrType)le.ms_totdlrs,(SALT311.StrType)le.ms_avgdlrs,(SALT311.StrType)le.ms_lastdlrs,(SALT311.StrType)le.ms_paystat_paid,(SALT311.StrType)le.ms_paymeth_cc,(SALT311.StrType)le.ms_paymeth_cash,(SALT311.StrType)le.ms_osrc_dm,(SALT311.StrType)le.ms_lsrc_dm,(SALT311.StrType)le.ms_osrc_tm,(SALT311.StrType)le.ms_lsrc_tm,(SALT311.StrType)le.ms_osrc_ins,(SALT311.StrType)le.ms_lsrc_ins,(SALT311.StrType)le.ms_osrc_net,(SALT311.StrType)le.ms_lsrc_net,(SALT311.StrType)le.ms_osrc_tv,(SALT311.StrType)le.ms_lsrc_tv,(SALT311.StrType)le.ms_osrc_retail,(SALT311.StrType)le.ms_lsrc_retail,(SALT311.StrType)le.ms_giftgivr,(SALT311.StrType)le.ms_giftee,(SALT311.StrType)le.ms_adult,(SALT311.StrType)le.ms_womapp,(SALT311.StrType)le.ms_menapp,(SALT311.StrType)le.ms_kidapp,(SALT311.StrType)le.ms_accessory,(SALT311.StrType)le.ms_apparel,(SALT311.StrType)le.ms_app_lmos,(SALT311.StrType)le.ms_app_omos,(SALT311.StrType)le.ms_app_pmos,(SALT311.StrType)le.ms_app_totords,(SALT311.StrType)le.ms_app_totitems,(SALT311.StrType)le.ms_app_totdlrs,(SALT311.StrType)le.ms_app_avgdlrs,(SALT311.StrType)le.ms_app_lastdlrs,(SALT311.StrType)le.ms_app_paystat_paid,(SALT311.StrType)le.ms_app_paymeth_cc,(SALT311.StrType)le.ms_app_paymeth_cash,(SALT311.StrType)le.ms_menfash,(SALT311.StrType)le.ms_womfash,(SALT311.StrType)le.ms_wfsh_lmos,(SALT311.StrType)le.ms_wfsh_omos,(SALT311.StrType)le.ms_wfsh_pmos,(SALT311.StrType)le.ms_wfsh_totords,(SALT311.StrType)le.ms_wfsh_totdlrs,(SALT311.StrType)le.ms_wfsh_avgdlrs,(SALT311.StrType)le.ms_wfsh_lastdlrs,(SALT311.StrType)le.ms_wfsh_paystat_paid,(SALT311.StrType)le.ms_wfsh_osrc_dm,(SALT311.StrType)le.ms_wfsh_lsrc_dm,(SALT311.StrType)le.ms_wfsh_osrc_agt,(SALT311.StrType)le.ms_wfsh_lsrc_agt,(SALT311.StrType)le.ms_audio,(SALT311.StrType)le.ms_auto,(SALT311.StrType)le.ms_aviation,(SALT311.StrType)le.ms_bargains,(SALT311.StrType)le.ms_beauty,(SALT311.StrType)le.ms_bible,(SALT311.StrType)le.ms_bible_lmos,(SALT311.StrType)le.ms_bible_omos,(SALT311.StrType)le.ms_bible_pmos,(SALT311.StrType)le.ms_bible_totords,(SALT311.StrType)le.ms_bible_totitems,(SALT311.StrType)le.ms_bible_totdlrs,(SALT311.StrType)le.ms_bible_avgdlrs,(SALT311.StrType)le.ms_bible_lastdlrs,(SALT311.StrType)le.ms_bible_paystat_paid,(SALT311.StrType)le.ms_bible_paymeth_cc,(SALT311.StrType)le.ms_bible_paymeth_cash,(SALT311.StrType)le.ms_business,(SALT311.StrType)le.ms_collectibles,(SALT311.StrType)le.ms_computers,(SALT311.StrType)le.ms_crafts,(SALT311.StrType)le.ms_culturearts,(SALT311.StrType)le.ms_currevent,(SALT311.StrType)le.ms_diy,(SALT311.StrType)le.ms_electronics,(SALT311.StrType)le.ms_equestrian,(SALT311.StrType)le.ms_pub_family,(SALT311.StrType)le.ms_cat_family,(SALT311.StrType)le.ms_family,(SALT311.StrType)le.ms_family_lmos,(SALT311.StrType)le.ms_family_omos,(SALT311.StrType)le.ms_family_pmos,(SALT311.StrType)le.ms_family_totords,(SALT311.StrType)le.ms_family_totitems,(SALT311.StrType)le.ms_family_totdlrs,(SALT311.StrType)le.ms_family_avgdlrs,(SALT311.StrType)le.ms_family_lastdlrs,(SALT311.StrType)le.ms_family_paystat_paid,(SALT311.StrType)le.ms_family_paymeth_cc,(SALT311.StrType)le.ms_family_paymeth_cash,(SALT311.StrType)le.ms_family_osrc_dm,(SALT311.StrType)le.ms_family_lsrc_dm,(SALT311.StrType)le.ms_fiction,(SALT311.StrType)le.ms_food,(SALT311.StrType)le.ms_games,(SALT311.StrType)le.ms_gifts,(SALT311.StrType)le.ms_gourmet,(SALT311.StrType)le.ms_fitness,(SALT311.StrType)le.ms_health,(SALT311.StrType)le.ms_hlth_lmos,(SALT311.StrType)le.ms_hlth_omos,(SALT311.StrType)le.ms_hlth_pmos,(SALT311.StrType)le.ms_hlth_totords,(SALT311.StrType)le.ms_hlth_totdlrs,(SALT311.StrType)le.ms_hlth_avgdlrs,(SALT311.StrType)le.ms_hlth_lastdlrs,(SALT311.StrType)le.ms_hlth_paystat_paid,(SALT311.StrType)le.ms_hlth_paymeth_cc,(SALT311.StrType)le.ms_hlth_osrc_dm,(SALT311.StrType)le.ms_hlth_lsrc_dm,(SALT311.StrType)le.ms_hlth_osrc_agt,(SALT311.StrType)le.ms_hlth_lsrc_agt,(SALT311.StrType)le.ms_hlth_osrc_tv,(SALT311.StrType)le.ms_hlth_lsrc_tv,(SALT311.StrType)le.ms_holiday,(SALT311.StrType)le.ms_history,(SALT311.StrType)le.ms_pub_cooking,(SALT311.StrType)le.ms_cooking,(SALT311.StrType)le.ms_pub_homedecr,(SALT311.StrType)le.ms_cat_homedecr,(SALT311.StrType)le.ms_homedecr,(SALT311.StrType)le.ms_housewares,(SALT311.StrType)le.ms_pub_garden,(SALT311.StrType)le.ms_cat_garden,(SALT311.StrType)le.ms_garden,(SALT311.StrType)le.ms_pub_homeliv,(SALT311.StrType)le.ms_cat_homeliv,(SALT311.StrType)le.ms_homeliv,(SALT311.StrType)le.ms_pub_home_status_active,(SALT311.StrType)le.ms_home_lmos,(SALT311.StrType)le.ms_home_omos,(SALT311.StrType)le.ms_home_pmos,(SALT311.StrType)le.ms_home_totords,(SALT311.StrType)le.ms_home_totitems,(SALT311.StrType)le.ms_home_totdlrs,(SALT311.StrType)le.ms_home_avgdlrs,(SALT311.StrType)le.ms_home_lastdlrs,(SALT311.StrType)le.ms_home_paystat_paid,(SALT311.StrType)le.ms_home_paymeth_cc,(SALT311.StrType)le.ms_home_paymeth_cash,(SALT311.StrType)le.ms_home_osrc_dm,(SALT311.StrType)le.ms_home_lsrc_dm,(SALT311.StrType)le.ms_home_osrc_agt,(SALT311.StrType)le.ms_home_lsrc_agt,(SALT311.StrType)le.ms_home_osrc_net,(SALT311.StrType)le.ms_home_lsrc_net,(SALT311.StrType)le.ms_home_osrc_tv,(SALT311.StrType)le.ms_home_lsrc_tv,(SALT311.StrType)le.ms_humor,(SALT311.StrType)le.ms_inspiration,(SALT311.StrType)le.ms_merchandise,(SALT311.StrType)le.ms_moneymaking,(SALT311.StrType)le.ms_moneymaking_lmos,(SALT311.StrType)le.ms_motorcycles,(SALT311.StrType)le.ms_music,(SALT311.StrType)le.ms_fishing,(SALT311.StrType)le.ms_hunting,(SALT311.StrType)le.ms_boatsail,(SALT311.StrType)le.ms_camp,(SALT311.StrType)le.ms_pub_outdoors,(SALT311.StrType)le.ms_cat_outdoors,(SALT311.StrType)le.ms_outdoors,(SALT311.StrType)le.ms_pub_out_status_active,(SALT311.StrType)le.ms_out_lmos,(SALT311.StrType)le.ms_out_omos,(SALT311.StrType)le.ms_out_pmos,(SALT311.StrType)le.ms_out_totords,(SALT311.StrType)le.ms_out_totitems,(SALT311.StrType)le.ms_out_totdlrs,(SALT311.StrType)le.ms_out_avgdlrs,(SALT311.StrType)le.ms_out_lastdlrs,(SALT311.StrType)le.ms_out_paystat_paid,(SALT311.StrType)le.ms_out_paymeth_cc,(SALT311.StrType)le.ms_out_paymeth_cash,(SALT311.StrType)le.ms_out_osrc_dm,(SALT311.StrType)le.ms_out_lsrc_dm,(SALT311.StrType)le.ms_out_osrc_agt,(SALT311.StrType)le.ms_out_lsrc_agt,(SALT311.StrType)le.ms_pets,(SALT311.StrType)le.ms_pfin,(SALT311.StrType)le.ms_photo,(SALT311.StrType)le.ms_photoproc,(SALT311.StrType)le.ms_rural,(SALT311.StrType)le.ms_science,(SALT311.StrType)le.ms_sports,(SALT311.StrType)le.ms_sports_lmos,(SALT311.StrType)le.ms_travel,(SALT311.StrType)le.ms_tvmovies,(SALT311.StrType)le.ms_wildlife,(SALT311.StrType)le.ms_woman,(SALT311.StrType)le.ms_woman_lmos,(SALT311.StrType)le.ms_ringtones_apps,(SALT311.StrType)le.cpi_mobile_apps_index,(SALT311.StrType)le.cpi_credit_repair_index,(SALT311.StrType)le.cpi_credit_report_index,(SALT311.StrType)le.cpi_education_seekers_index,(SALT311.StrType)le.cpi_insurance_index,(SALT311.StrType)le.cpi_insurance_health_index,(SALT311.StrType)le.cpi_insurance_auto_index,(SALT311.StrType)le.cpi_job_seekers_index,(SALT311.StrType)le.cpi_social_networking_index,(SALT311.StrType)le.cpi_adult_index,(SALT311.StrType)le.cpi_africanamerican_index,(SALT311.StrType)le.cpi_apparel_index,(SALT311.StrType)le.cpi_apparel_accessory_index,(SALT311.StrType)le.cpi_apparel_kids_index,(SALT311.StrType)le.cpi_apparel_men_index,(SALT311.StrType)le.cpi_apparel_menfash_index,(SALT311.StrType)le.cpi_apparel_women_index,(SALT311.StrType)le.cpi_apparel_womfash_index,(SALT311.StrType)le.cpi_asian_index,(SALT311.StrType)le.cpi_auto_index,(SALT311.StrType)le.cpi_auto_racing_index,(SALT311.StrType)le.cpi_auto_trucks_index,(SALT311.StrType)le.cpi_aviation_index,(SALT311.StrType)le.cpi_bargains_index,(SALT311.StrType)le.cpi_beauty_index,(SALT311.StrType)le.cpi_bible_index,(SALT311.StrType)le.cpi_birds_index,(SALT311.StrType)le.cpi_business_index,(SALT311.StrType)le.cpi_business_homeoffice_index,(SALT311.StrType)le.cpi_catalog_index,(SALT311.StrType)le.cpi_cc_index,(SALT311.StrType)le.cpi_collectibles_index,(SALT311.StrType)le.cpi_college_index,(SALT311.StrType)le.cpi_computers_index,(SALT311.StrType)le.cpi_conservative_index,(SALT311.StrType)le.cpi_continuity_index,(SALT311.StrType)le.cpi_cooking_index,(SALT311.StrType)le.cpi_crafts_index,(SALT311.StrType)le.cpi_crafts_crochet_index,(SALT311.StrType)le.cpi_crafts_knit_index,(SALT311.StrType)le.cpi_crafts_needlepoint_index,(SALT311.StrType)le.cpi_crafts_quilt_index,(SALT311.StrType)le.cpi_crafts_sew_index,(SALT311.StrType)le.cpi_culturearts_index,(SALT311.StrType)le.cpi_currevent_index,(SALT311.StrType)le.cpi_diy_index,(SALT311.StrType)le.cpi_donor_index,(SALT311.StrType)le.cpi_ego_index,(SALT311.StrType)le.cpi_electronics_index,(SALT311.StrType)le.cpi_equestrian_index,(SALT311.StrType)le.cpi_family_index,(SALT311.StrType)le.cpi_family_teen_index,(SALT311.StrType)le.cpi_family_young_index,(SALT311.StrType)le.cpi_fiction_index,(SALT311.StrType)le.cpi_gambling_index,(SALT311.StrType)le.cpi_games_index,(SALT311.StrType)le.cpi_gardening_index,(SALT311.StrType)le.cpi_gay_index,(SALT311.StrType)le.cpi_giftgivr_index,(SALT311.StrType)le.cpi_gourmet_index,(SALT311.StrType)le.cpi_grandparents_index,(SALT311.StrType)le.cpi_health_index,(SALT311.StrType)le.cpi_health_diet_index,(SALT311.StrType)le.cpi_health_fitness_index,(SALT311.StrType)le.cpi_hightech_index,(SALT311.StrType)le.cpi_hispanic_index,(SALT311.StrType)le.cpi_history_index,(SALT311.StrType)le.cpi_history_american_index,(SALT311.StrType)le.cpi_hobbies_index,(SALT311.StrType)le.cpi_homedecr_index,(SALT311.StrType)le.cpi_homeliv_index,(SALT311.StrType)le.cpi_humor_index,(SALT311.StrType)le.cpi_inspiration_index,(SALT311.StrType)le.cpi_internet_index,(SALT311.StrType)le.cpi_internet_access_index,(SALT311.StrType)le.cpi_internet_buy_index,(SALT311.StrType)le.cpi_liberal_index,(SALT311.StrType)le.cpi_moneymaking_index,(SALT311.StrType)le.cpi_motorcycles_index,(SALT311.StrType)le.cpi_music_index,(SALT311.StrType)le.cpi_nonfiction_index,(SALT311.StrType)le.cpi_ocean_index,(SALT311.StrType)le.cpi_outdoors_index,(SALT311.StrType)le.cpi_outdoors_boatsail_index,(SALT311.StrType)le.cpi_outdoors_camp_index,(SALT311.StrType)le.cpi_outdoors_fishing_index,(SALT311.StrType)le.cpi_outdoors_huntfish_index,(SALT311.StrType)le.cpi_outdoors_hunting_index,(SALT311.StrType)le.cpi_pets_index,(SALT311.StrType)le.cpi_pets_cats_index,(SALT311.StrType)le.cpi_pets_dogs_index,(SALT311.StrType)le.cpi_pfin_index,(SALT311.StrType)le.cpi_photog_index,(SALT311.StrType)le.cpi_photoproc_index,(SALT311.StrType)le.cpi_publish_index,(SALT311.StrType)le.cpi_publish_books_index,(SALT311.StrType)le.cpi_publish_mags_index,(SALT311.StrType)le.cpi_rural_index,(SALT311.StrType)le.cpi_science_index,(SALT311.StrType)le.cpi_scifi_index,(SALT311.StrType)le.cpi_seniors_index,(SALT311.StrType)le.cpi_sports_index,(SALT311.StrType)le.cpi_sports_baseball_index,(SALT311.StrType)le.cpi_sports_basketball_index,(SALT311.StrType)le.cpi_sports_biking_index,(SALT311.StrType)le.cpi_sports_football_index,(SALT311.StrType)le.cpi_sports_golf_index,(SALT311.StrType)le.cpi_sports_hockey_index,(SALT311.StrType)le.cpi_sports_running_index,(SALT311.StrType)le.cpi_sports_ski_index,(SALT311.StrType)le.cpi_sports_soccer_index,(SALT311.StrType)le.cpi_sports_swimming_index,(SALT311.StrType)le.cpi_sports_tennis_index,(SALT311.StrType)le.cpi_stationery_index,(SALT311.StrType)le.cpi_sweeps_index,(SALT311.StrType)le.cpi_tobacco_index,(SALT311.StrType)le.cpi_travel_index,(SALT311.StrType)le.cpi_travel_cruise_index,(SALT311.StrType)le.cpi_travel_rv_index,(SALT311.StrType)le.cpi_travel_us_index,(SALT311.StrType)le.cpi_tvmovies_index,(SALT311.StrType)le.cpi_wildlife_index,(SALT311.StrType)le.cpi_woman_index,(SALT311.StrType)le.totdlr_index,(SALT311.StrType)le.cpi_totdlr,(SALT311.StrType)le.cpi_totords,(SALT311.StrType)le.cpi_lastdlr,(SALT311.StrType)le.pkcatg,(SALT311.StrType)le.pkpubs,(SALT311.StrType)le.pkcont,(SALT311.StrType)le.pkca01,(SALT311.StrType)le.pkca03,(SALT311.StrType)le.pkca04,(SALT311.StrType)le.pkca05,(SALT311.StrType)le.pkca06,(SALT311.StrType)le.pkca07,(SALT311.StrType)le.pkca08,(SALT311.StrType)le.pkca09,(SALT311.StrType)le.pkca10,(SALT311.StrType)le.pkca11,(SALT311.StrType)le.pkca12,(SALT311.StrType)le.pkca13,(SALT311.StrType)le.pkca14,(SALT311.StrType)le.pkca15,(SALT311.StrType)le.pkca16,(SALT311.StrType)le.pkca17,(SALT311.StrType)le.pkca18,(SALT311.StrType)le.pkca20,(SALT311.StrType)le.pkca21,(SALT311.StrType)le.pkca22,(SALT311.StrType)le.pkca23,(SALT311.StrType)le.pkca24,(SALT311.StrType)le.pkca25,(SALT311.StrType)le.pkca26,(SALT311.StrType)le.pkca28,(SALT311.StrType)le.pkca29,(SALT311.StrType)le.pkca30,(SALT311.StrType)le.pkca31,(SALT311.StrType)le.pkca32,(SALT311.StrType)le.pkca33,(SALT311.StrType)le.pkca34,(SALT311.StrType)le.pkca35,(SALT311.StrType)le.pkca36,(SALT311.StrType)le.pkca37,(SALT311.StrType)le.pkca39,(SALT311.StrType)le.pkca40,(SALT311.StrType)le.pkca41,(SALT311.StrType)le.pkca42,(SALT311.StrType)le.pkca54,(SALT311.StrType)le.pkca61,(SALT311.StrType)le.pkca62,(SALT311.StrType)le.pkca64,(SALT311.StrType)le.pkpu01,(SALT311.StrType)le.pkpu02,(SALT311.StrType)le.pkpu03,(SALT311.StrType)le.pkpu04,(SALT311.StrType)le.pkpu05,(SALT311.StrType)le.pkpu06,(SALT311.StrType)le.pkpu07,(SALT311.StrType)le.pkpu08,(SALT311.StrType)le.pkpu09,(SALT311.StrType)le.pkpu10,(SALT311.StrType)le.pkpu11,(SALT311.StrType)le.pkpu12,(SALT311.StrType)le.pkpu13,(SALT311.StrType)le.pkpu14,(SALT311.StrType)le.pkpu15,(SALT311.StrType)le.pkpu16,(SALT311.StrType)le.pkpu17,(SALT311.StrType)le.pkpu18,(SALT311.StrType)le.pkpu19,(SALT311.StrType)le.pkpu20,(SALT311.StrType)le.pkpu23,(SALT311.StrType)le.pkpu25,(SALT311.StrType)le.pkpu27,(SALT311.StrType)le.pkpu28,(SALT311.StrType)le.pkpu29,(SALT311.StrType)le.pkpu30,(SALT311.StrType)le.pkpu31,(SALT311.StrType)le.pkpu32,(SALT311.StrType)le.pkpu33,(SALT311.StrType)le.pkpu34,(SALT311.StrType)le.pkpu35,(SALT311.StrType)le.pkpu38,(SALT311.StrType)le.pkpu41,(SALT311.StrType)le.pkpu42,(SALT311.StrType)le.pkpu45,(SALT311.StrType)le.pkpu46,(SALT311.StrType)le.pkpu47,(SALT311.StrType)le.pkpu48,(SALT311.StrType)le.pkpu49,(SALT311.StrType)le.pkpu50,(SALT311.StrType)le.pkpu51,(SALT311.StrType)le.pkpu52,(SALT311.StrType)le.pkpu53,(SALT311.StrType)le.pkpu54,(SALT311.StrType)le.pkpu55,(SALT311.StrType)le.pkpu56,(SALT311.StrType)le.pkpu57,(SALT311.StrType)le.pkpu60,(SALT311.StrType)le.pkpu61,(SALT311.StrType)le.pkpu62,(SALT311.StrType)le.pkpu63,(SALT311.StrType)le.pkpu64,(SALT311.StrType)le.pkpu65,(SALT311.StrType)le.pkpu66,(SALT311.StrType)le.pkpu67,(SALT311.StrType)le.pkpu68,(SALT311.StrType)le.pkpu69,(SALT311.StrType)le.pkpu70,(SALT311.StrType)le.censpct_water,(SALT311.StrType)le.cens_pop_density,(SALT311.StrType)le.cens_hu_density,(SALT311.StrType)le.censpct_pop_white,(SALT311.StrType)le.censpct_pop_black,(SALT311.StrType)le.censpct_pop_amerind,(SALT311.StrType)le.censpct_pop_asian,(SALT311.StrType)le.censpct_pop_pacisl,(SALT311.StrType)le.censpct_pop_othrace,(SALT311.StrType)le.censpct_pop_multirace,(SALT311.StrType)le.censpct_pop_hispanic,(SALT311.StrType)le.censpct_pop_agelt18,(SALT311.StrType)le.censpct_pop_males,(SALT311.StrType)le.censpct_adult_age1824,(SALT311.StrType)le.censpct_adult_age2534,(SALT311.StrType)le.censpct_adult_age3544,(SALT311.StrType)le.censpct_adult_age4554,(SALT311.StrType)le.censpct_adult_age5564,(SALT311.StrType)le.censpct_adult_agege65,(SALT311.StrType)le.cens_pop_medage,(SALT311.StrType)le.cens_hh_avgsize,(SALT311.StrType)le.censpct_hh_family,(SALT311.StrType)le.censpct_hh_family_husbwife,(SALT311.StrType)le.censpct_hu_occupied,(SALT311.StrType)le.censpct_hu_owned,(SALT311.StrType)le.censpct_hu_rented,(SALT311.StrType)le.censpct_hu_vacantseasonal,(SALT311.StrType)le.zip_medinc,(SALT311.StrType)le.zip_apparel,(SALT311.StrType)le.zip_apparel_women,(SALT311.StrType)le.zip_apparel_womfash,(SALT311.StrType)le.zip_auto,(SALT311.StrType)le.zip_beauty,(SALT311.StrType)le.zip_booksmusicmovies,(SALT311.StrType)le.zip_business,(SALT311.StrType)le.zip_catalog,(SALT311.StrType)le.zip_cc,(SALT311.StrType)le.zip_collectibles,(SALT311.StrType)le.zip_computers,(SALT311.StrType)le.zip_continuity,(SALT311.StrType)le.zip_cooking,(SALT311.StrType)le.zip_crafts,(SALT311.StrType)le.zip_culturearts,(SALT311.StrType)le.zip_dm_sold,(SALT311.StrType)le.zip_donor,(SALT311.StrType)le.zip_family,(SALT311.StrType)le.zip_gardening,(SALT311.StrType)le.zip_giftgivr,(SALT311.StrType)le.zip_gourmet,(SALT311.StrType)le.zip_health,(SALT311.StrType)le.zip_health_diet,(SALT311.StrType)le.zip_health_fitness,(SALT311.StrType)le.zip_hobbies,(SALT311.StrType)le.zip_homedecr,(SALT311.StrType)le.zip_homeliv,(SALT311.StrType)le.zip_internet,(SALT311.StrType)le.zip_internet_access,(SALT311.StrType)le.zip_internet_buy,(SALT311.StrType)le.zip_music,(SALT311.StrType)le.zip_outdoors,(SALT311.StrType)le.zip_pets,(SALT311.StrType)le.zip_pfin,(SALT311.StrType)le.zip_publish,(SALT311.StrType)le.zip_publish_books,(SALT311.StrType)le.zip_publish_mags,(SALT311.StrType)le.zip_sports,(SALT311.StrType)le.zip_sports_biking,(SALT311.StrType)le.zip_sports_golf,(SALT311.StrType)le.zip_travel,(SALT311.StrType)le.zip_travel_us,(SALT311.StrType)le.zip_tvmovies,(SALT311.StrType)le.zip_woman,(SALT311.StrType)le.zip_proftech,(SALT311.StrType)le.zip_retired,(SALT311.StrType)le.zip_inc100,(SALT311.StrType)le.zip_inc75,(SALT311.StrType)le.zip_inc50,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,633,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_Dunndata_Consumer) prevDS = DATASET([], Layout_Dunndata_Consumer), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'dtmatch:ALPHANUMERIC:ALLOW','dtmatch:ALPHANUMERIC:LENGTHS'
          ,'msname:FULLNAME:ALLOW'
          ,'msaddr1:FULL_ADDRESS:ALLOW'
          ,'msaddr2:FULL_ADDRESS:ALLOW'
          ,'mscity:CITY:ALLOW','mscity:CITY:LENGTHS'
          ,'msstate:ST:ALLOW','msstate:ST:LENGTHS','msstate:ST:WORDS'
          ,'mszip5:ZIP5:ALLOW','mszip5:ZIP5:LENGTHS'
          ,'mszip4:HASZIP4:ALLOW','mszip4:HASZIP4:LENGTHS'
          ,'dthh:ALPHANUMERIC:ALLOW','dthh:ALPHANUMERIC:LENGTHS'
          ,'mscrrt:ALPHANUMERIC:ALLOW','mscrrt:ALPHANUMERIC:LENGTHS'
          ,'msdpbc:ALPHANUMERIC:ALLOW','msdpbc:ALPHANUMERIC:LENGTHS'
          ,'msdpv:ALPHANUMERIC:ALLOW','msdpv:ALPHANUMERIC:LENGTHS'
          ,'ms_addrtype:ALPHANUMERIC:ALLOW','ms_addrtype:ALPHANUMERIC:LENGTHS'
          ,'ctysize:ALPHANUMERIC:ALLOW','ctysize:ALPHANUMERIC:LENGTHS'
          ,'lmos:NUMBER:ALLOW'
          ,'omos:NUMBER:ALLOW'
          ,'pmos:NUMBER:ALLOW'
          ,'gen:GENDER_CODE:ENUM','gen:GENDER_CODE:LENGTHS'
          ,'dob:invalid_date:CUSTOM'
          ,'age:NUMBER:ALLOW'
          ,'inc:INC_CODE:ENUM','inc:INC_CODE:LENGTHS'
          ,'marital_status:ALPHA:ALLOW'
          ,'poc:ALPHA:ALLOW'
          ,'noc:ALPHANUMERIC:ALLOW','noc:ALPHANUMERIC:LENGTHS'
          ,'ocp:OPC_CODE:ENUM','ocp:OPC_CODE:LENGTHS'
          ,'edu:EDU_CODE:ENUM','edu:EDU_CODE:LENGTHS'
          ,'lang:GENERAL_CODE:ALLOW','lang:GENERAL_CODE:LENGTHS'
          ,'relig:RELIG_CODE:ENUM','relig:RELIG_CODE:LENGTHS'
          ,'dwell:DWELL_CODE:ENUM','dwell:DWELL_CODE:LENGTHS'
          ,'ownr:ALPHA:ALLOW'
          ,'eth1:GENERAL_CODE:ALLOW','eth1:GENERAL_CODE:LENGTHS'
          ,'eth2:GENERAL_CODE:ALLOW','eth2:GENERAL_CODE:LENGTHS'
          ,'lor:ALPHANUMERIC:ALLOW','lor:ALPHANUMERIC:LENGTHS'
          ,'pool:ALPHANUMERIC:ALLOW','pool:ALPHANUMERIC:LENGTHS'
          ,'speak_span:ALPHANUMERIC:ALLOW','speak_span:ALPHANUMERIC:LENGTHS'
          ,'soho:ALPHANUMERIC:ALLOW','soho:ALPHANUMERIC:LENGTHS'
          ,'vet_in_hh:ALPHANUMERIC:ALLOW','vet_in_hh:ALPHANUMERIC:LENGTHS'
          ,'ms_mags:NUMBER:ALLOW'
          ,'ms_books:NUMBER:ALLOW'
          ,'ms_publish:NUMBER:ALLOW'
          ,'ms_pub_status_active:NUMBER:ALLOW'
          ,'ms_pub_status_expire:NUMBER:ALLOW'
          ,'ms_pub_premsold:NUMBER:ALLOW'
          ,'ms_pub_autornwl:NUMBER:ALLOW'
          ,'ms_pub_avgterm:NUMBER:ALLOW'
          ,'ms_pub_lmos:NUMBER:ALLOW'
          ,'ms_pub_omos:NUMBER:ALLOW'
          ,'ms_pub_pmos:NUMBER:ALLOW'
          ,'ms_pub_cemos:NUMBER:ALLOW'
          ,'ms_pub_femos:NUMBER:ALLOW'
          ,'ms_pub_totords:NUMBER:ALLOW'
          ,'ms_pub_totdlrs:NUMBER:ALLOW'
          ,'ms_pub_avgdlrs:NUMBER:ALLOW'
          ,'ms_pub_lastdlrs:NUMBER:ALLOW'
          ,'ms_pub_paystat_paid:NUMBER:ALLOW'
          ,'ms_pub_paystat_ub:NUMBER:ALLOW'
          ,'ms_pub_paymeth_cc:NUMBER:ALLOW'
          ,'ms_pub_paymeth_cash:NUMBER:ALLOW'
          ,'ms_pub_payspeed:NUMBER:ALLOW'
          ,'ms_pub_osrc_dm:NUMBER:ALLOW'
          ,'ms_pub_lsrc_dm:NUMBER:ALLOW'
          ,'ms_pub_osrc_agt_cashf:NUMBER:ALLOW'
          ,'ms_pub_lsrc_agt_cashf:NUMBER:ALLOW'
          ,'ms_pub_osrc_agt_pds:NUMBER:ALLOW'
          ,'ms_pub_lsrc_agt_pds:NUMBER:ALLOW'
          ,'ms_pub_osrc_agt_schplan:NUMBER:ALLOW'
          ,'ms_pub_lsrc_agt_schplan:NUMBER:ALLOW'
          ,'ms_pub_osrc_agt_sponsor:NUMBER:ALLOW'
          ,'ms_pub_lsrc_agt_sponsor:NUMBER:ALLOW'
          ,'ms_pub_osrc_agt_tm:NUMBER:ALLOW'
          ,'ms_pub_lsrc_agt_tm:NUMBER:ALLOW'
          ,'ms_pub_osrc_agt:NUMBER:ALLOW'
          ,'ms_pub_lsrc_agt:NUMBER:ALLOW'
          ,'ms_pub_osrc_tm:NUMBER:ALLOW'
          ,'ms_pub_lsrc_tm:NUMBER:ALLOW'
          ,'ms_pub_osrc_ins:NUMBER:ALLOW'
          ,'ms_pub_lsrc_ins:NUMBER:ALLOW'
          ,'ms_pub_osrc_net:NUMBER:ALLOW'
          ,'ms_pub_lsrc_net:NUMBER:ALLOW'
          ,'ms_pub_osrc_print:NUMBER:ALLOW'
          ,'ms_pub_lsrc_print:NUMBER:ALLOW'
          ,'ms_pub_osrc_trans:NUMBER:ALLOW'
          ,'ms_pub_lsrc_trans:NUMBER:ALLOW'
          ,'ms_pub_osrc_tv:NUMBER:ALLOW'
          ,'ms_pub_lsrc_tv:NUMBER:ALLOW'
          ,'ms_pub_osrc_dtp:NUMBER:ALLOW'
          ,'ms_pub_lsrc_dtp:NUMBER:ALLOW'
          ,'ms_pub_giftgivr:NUMBER:ALLOW'
          ,'ms_pub_giftee:NUMBER:ALLOW'
          ,'ms_catalog:NUMBER:ALLOW'
          ,'ms_cat_lmos:NUMBER:ALLOW'
          ,'ms_cat_omos:NUMBER:ALLOW'
          ,'ms_cat_pmos:NUMBER:ALLOW'
          ,'ms_cat_totords:NUMBER:ALLOW'
          ,'ms_cat_totitems:NUMBER:ALLOW'
          ,'ms_cat_totdlrs:NUMBER:ALLOW'
          ,'ms_cat_avgdlrs:NUMBER:ALLOW'
          ,'ms_cat_lastdlrs:NUMBER:ALLOW'
          ,'ms_cat_paystat_paid:NUMBER:ALLOW'
          ,'ms_cat_paymeth_cc:NUMBER:ALLOW'
          ,'ms_cat_paymeth_cash:NUMBER:ALLOW'
          ,'ms_cat_osrc_dm:NUMBER:ALLOW'
          ,'ms_cat_lsrc_dm:NUMBER:ALLOW'
          ,'ms_cat_osrc_net:NUMBER:ALLOW'
          ,'ms_cat_lsrc_net:NUMBER:ALLOW'
          ,'ms_cat_giftgivr:NUMBER:ALLOW'
          ,'pkpubs_corrected:NUMBER:ALLOW'
          ,'pkcatg_corrected:NUMBER:ALLOW'
          ,'ms_fundraising:NUMBER:ALLOW'
          ,'ms_fund_lmos:NUMBER:ALLOW'
          ,'ms_fund_omos:NUMBER:ALLOW'
          ,'ms_fund_pmos:NUMBER:ALLOW'
          ,'ms_fund_totords:NUMBER:ALLOW'
          ,'ms_fund_totdlrs:NUMBER:ALLOW'
          ,'ms_fund_avgdlrs:NUMBER:ALLOW'
          ,'ms_fund_lastdlrs:NUMBER:ALLOW'
          ,'ms_fund_paystat_paid:NUMBER:ALLOW'
          ,'ms_other:NUMBER:ALLOW'
          ,'ms_continuity:NUMBER:ALLOW'
          ,'ms_cont_status_active:NUMBER:ALLOW'
          ,'ms_cont_status_cancel:NUMBER:ALLOW'
          ,'ms_cont_omos:NUMBER:ALLOW'
          ,'ms_cont_lmos:NUMBER:ALLOW'
          ,'ms_cont_pmos:NUMBER:ALLOW'
          ,'ms_cont_totords:NUMBER:ALLOW'
          ,'ms_cont_totdlrs:NUMBER:ALLOW'
          ,'ms_cont_avgdlrs:NUMBER:ALLOW'
          ,'ms_cont_lastdlrs:NUMBER:ALLOW'
          ,'ms_cont_paystat_paid:NUMBER:ALLOW'
          ,'ms_cont_paymeth_cc:NUMBER:ALLOW'
          ,'ms_cont_paymeth_cash:NUMBER:ALLOW'
          ,'ms_totords:NUMBER:ALLOW'
          ,'ms_totitems:NUMBER:ALLOW'
          ,'ms_totdlrs:NUMBER:ALLOW'
          ,'ms_avgdlrs:NUMBER:ALLOW'
          ,'ms_lastdlrs:NUMBER:ALLOW'
          ,'ms_paystat_paid:NUMBER:ALLOW'
          ,'ms_paymeth_cc:NUMBER:ALLOW'
          ,'ms_paymeth_cash:NUMBER:ALLOW'
          ,'ms_osrc_dm:NUMBER:ALLOW'
          ,'ms_lsrc_dm:NUMBER:ALLOW'
          ,'ms_osrc_tm:NUMBER:ALLOW'
          ,'ms_lsrc_tm:NUMBER:ALLOW'
          ,'ms_osrc_ins:NUMBER:ALLOW'
          ,'ms_lsrc_ins:NUMBER:ALLOW'
          ,'ms_osrc_net:NUMBER:ALLOW'
          ,'ms_lsrc_net:NUMBER:ALLOW'
          ,'ms_osrc_tv:NUMBER:ALLOW'
          ,'ms_lsrc_tv:NUMBER:ALLOW'
          ,'ms_osrc_retail:NUMBER:ALLOW'
          ,'ms_lsrc_retail:NUMBER:ALLOW'
          ,'ms_giftgivr:NUMBER:ALLOW'
          ,'ms_giftee:NUMBER:ALLOW'
          ,'ms_adult:NUMBER:ALLOW'
          ,'ms_womapp:NUMBER:ALLOW'
          ,'ms_menapp:NUMBER:ALLOW'
          ,'ms_kidapp:NUMBER:ALLOW'
          ,'ms_accessory:NUMBER:ALLOW'
          ,'ms_apparel:NUMBER:ALLOW'
          ,'ms_app_lmos:NUMBER:ALLOW'
          ,'ms_app_omos:NUMBER:ALLOW'
          ,'ms_app_pmos:NUMBER:ALLOW'
          ,'ms_app_totords:NUMBER:ALLOW'
          ,'ms_app_totitems:NUMBER:ALLOW'
          ,'ms_app_totdlrs:NUMBER:ALLOW'
          ,'ms_app_avgdlrs:NUMBER:ALLOW'
          ,'ms_app_lastdlrs:NUMBER:ALLOW'
          ,'ms_app_paystat_paid:NUMBER:ALLOW'
          ,'ms_app_paymeth_cc:NUMBER:ALLOW'
          ,'ms_app_paymeth_cash:NUMBER:ALLOW'
          ,'ms_menfash:NUMBER:ALLOW'
          ,'ms_womfash:NUMBER:ALLOW'
          ,'ms_wfsh_lmos:NUMBER:ALLOW'
          ,'ms_wfsh_omos:NUMBER:ALLOW'
          ,'ms_wfsh_pmos:NUMBER:ALLOW'
          ,'ms_wfsh_totords:NUMBER:ALLOW'
          ,'ms_wfsh_totdlrs:NUMBER:ALLOW'
          ,'ms_wfsh_avgdlrs:NUMBER:ALLOW'
          ,'ms_wfsh_lastdlrs:NUMBER:ALLOW'
          ,'ms_wfsh_paystat_paid:NUMBER:ALLOW'
          ,'ms_wfsh_osrc_dm:NUMBER:ALLOW'
          ,'ms_wfsh_lsrc_dm:NUMBER:ALLOW'
          ,'ms_wfsh_osrc_agt:NUMBER:ALLOW'
          ,'ms_wfsh_lsrc_agt:NUMBER:ALLOW'
          ,'ms_audio:NUMBER:ALLOW'
          ,'ms_auto:NUMBER:ALLOW'
          ,'ms_aviation:NUMBER:ALLOW'
          ,'ms_bargains:NUMBER:ALLOW'
          ,'ms_beauty:NUMBER:ALLOW'
          ,'ms_bible:NUMBER:ALLOW'
          ,'ms_bible_lmos:NUMBER:ALLOW'
          ,'ms_bible_omos:NUMBER:ALLOW'
          ,'ms_bible_pmos:NUMBER:ALLOW'
          ,'ms_bible_totords:NUMBER:ALLOW'
          ,'ms_bible_totitems:NUMBER:ALLOW'
          ,'ms_bible_totdlrs:NUMBER:ALLOW'
          ,'ms_bible_avgdlrs:NUMBER:ALLOW'
          ,'ms_bible_lastdlrs:NUMBER:ALLOW'
          ,'ms_bible_paystat_paid:NUMBER:ALLOW'
          ,'ms_bible_paymeth_cc:NUMBER:ALLOW'
          ,'ms_bible_paymeth_cash:NUMBER:ALLOW'
          ,'ms_business:NUMBER:ALLOW'
          ,'ms_collectibles:NUMBER:ALLOW'
          ,'ms_computers:NUMBER:ALLOW'
          ,'ms_crafts:NUMBER:ALLOW'
          ,'ms_culturearts:NUMBER:ALLOW'
          ,'ms_currevent:NUMBER:ALLOW'
          ,'ms_diy:NUMBER:ALLOW'
          ,'ms_electronics:NUMBER:ALLOW'
          ,'ms_equestrian:NUMBER:ALLOW'
          ,'ms_pub_family:NUMBER:ALLOW'
          ,'ms_cat_family:NUMBER:ALLOW'
          ,'ms_family:NUMBER:ALLOW'
          ,'ms_family_lmos:NUMBER:ALLOW'
          ,'ms_family_omos:NUMBER:ALLOW'
          ,'ms_family_pmos:NUMBER:ALLOW'
          ,'ms_family_totords:NUMBER:ALLOW'
          ,'ms_family_totitems:NUMBER:ALLOW'
          ,'ms_family_totdlrs:NUMBER:ALLOW'
          ,'ms_family_avgdlrs:NUMBER:ALLOW'
          ,'ms_family_lastdlrs:NUMBER:ALLOW'
          ,'ms_family_paystat_paid:NUMBER:ALLOW'
          ,'ms_family_paymeth_cc:NUMBER:ALLOW'
          ,'ms_family_paymeth_cash:NUMBER:ALLOW'
          ,'ms_family_osrc_dm:NUMBER:ALLOW'
          ,'ms_family_lsrc_dm:NUMBER:ALLOW'
          ,'ms_fiction:NUMBER:ALLOW'
          ,'ms_food:NUMBER:ALLOW'
          ,'ms_games:NUMBER:ALLOW'
          ,'ms_gifts:NUMBER:ALLOW'
          ,'ms_gourmet:NUMBER:ALLOW'
          ,'ms_fitness:NUMBER:ALLOW'
          ,'ms_health:NUMBER:ALLOW'
          ,'ms_hlth_lmos:NUMBER:ALLOW'
          ,'ms_hlth_omos:NUMBER:ALLOW'
          ,'ms_hlth_pmos:NUMBER:ALLOW'
          ,'ms_hlth_totords:NUMBER:ALLOW'
          ,'ms_hlth_totdlrs:NUMBER:ALLOW'
          ,'ms_hlth_avgdlrs:NUMBER:ALLOW'
          ,'ms_hlth_lastdlrs:NUMBER:ALLOW'
          ,'ms_hlth_paystat_paid:NUMBER:ALLOW'
          ,'ms_hlth_paymeth_cc:NUMBER:ALLOW'
          ,'ms_hlth_osrc_dm:NUMBER:ALLOW'
          ,'ms_hlth_lsrc_dm:NUMBER:ALLOW'
          ,'ms_hlth_osrc_agt:NUMBER:ALLOW'
          ,'ms_hlth_lsrc_agt:NUMBER:ALLOW'
          ,'ms_hlth_osrc_tv:NUMBER:ALLOW'
          ,'ms_hlth_lsrc_tv:NUMBER:ALLOW'
          ,'ms_holiday:NUMBER:ALLOW'
          ,'ms_history:NUMBER:ALLOW'
          ,'ms_pub_cooking:NUMBER:ALLOW'
          ,'ms_cooking:NUMBER:ALLOW'
          ,'ms_pub_homedecr:NUMBER:ALLOW'
          ,'ms_cat_homedecr:NUMBER:ALLOW'
          ,'ms_homedecr:NUMBER:ALLOW'
          ,'ms_housewares:NUMBER:ALLOW'
          ,'ms_pub_garden:NUMBER:ALLOW'
          ,'ms_cat_garden:NUMBER:ALLOW'
          ,'ms_garden:NUMBER:ALLOW'
          ,'ms_pub_homeliv:NUMBER:ALLOW'
          ,'ms_cat_homeliv:NUMBER:ALLOW'
          ,'ms_homeliv:NUMBER:ALLOW'
          ,'ms_pub_home_status_active:NUMBER:ALLOW'
          ,'ms_home_lmos:NUMBER:ALLOW'
          ,'ms_home_omos:NUMBER:ALLOW'
          ,'ms_home_pmos:NUMBER:ALLOW'
          ,'ms_home_totords:NUMBER:ALLOW'
          ,'ms_home_totitems:NUMBER:ALLOW'
          ,'ms_home_totdlrs:NUMBER:ALLOW'
          ,'ms_home_avgdlrs:NUMBER:ALLOW'
          ,'ms_home_lastdlrs:NUMBER:ALLOW'
          ,'ms_home_paystat_paid:NUMBER:ALLOW'
          ,'ms_home_paymeth_cc:NUMBER:ALLOW'
          ,'ms_home_paymeth_cash:NUMBER:ALLOW'
          ,'ms_home_osrc_dm:NUMBER:ALLOW'
          ,'ms_home_lsrc_dm:NUMBER:ALLOW'
          ,'ms_home_osrc_agt:NUMBER:ALLOW'
          ,'ms_home_lsrc_agt:NUMBER:ALLOW'
          ,'ms_home_osrc_net:NUMBER:ALLOW'
          ,'ms_home_lsrc_net:NUMBER:ALLOW'
          ,'ms_home_osrc_tv:NUMBER:ALLOW'
          ,'ms_home_lsrc_tv:NUMBER:ALLOW'
          ,'ms_humor:NUMBER:ALLOW'
          ,'ms_inspiration:NUMBER:ALLOW'
          ,'ms_merchandise:NUMBER:ALLOW'
          ,'ms_moneymaking:NUMBER:ALLOW'
          ,'ms_moneymaking_lmos:NUMBER:ALLOW'
          ,'ms_motorcycles:NUMBER:ALLOW'
          ,'ms_music:NUMBER:ALLOW'
          ,'ms_fishing:NUMBER:ALLOW'
          ,'ms_hunting:NUMBER:ALLOW'
          ,'ms_boatsail:NUMBER:ALLOW'
          ,'ms_camp:NUMBER:ALLOW'
          ,'ms_pub_outdoors:NUMBER:ALLOW'
          ,'ms_cat_outdoors:NUMBER:ALLOW'
          ,'ms_outdoors:NUMBER:ALLOW'
          ,'ms_pub_out_status_active:NUMBER:ALLOW'
          ,'ms_out_lmos:NUMBER:ALLOW'
          ,'ms_out_omos:NUMBER:ALLOW'
          ,'ms_out_pmos:NUMBER:ALLOW'
          ,'ms_out_totords:NUMBER:ALLOW'
          ,'ms_out_totitems:NUMBER:ALLOW'
          ,'ms_out_totdlrs:NUMBER:ALLOW'
          ,'ms_out_avgdlrs:NUMBER:ALLOW'
          ,'ms_out_lastdlrs:NUMBER:ALLOW'
          ,'ms_out_paystat_paid:NUMBER:ALLOW'
          ,'ms_out_paymeth_cc:NUMBER:ALLOW'
          ,'ms_out_paymeth_cash:NUMBER:ALLOW'
          ,'ms_out_osrc_dm:NUMBER:ALLOW'
          ,'ms_out_lsrc_dm:NUMBER:ALLOW'
          ,'ms_out_osrc_agt:NUMBER:ALLOW'
          ,'ms_out_lsrc_agt:NUMBER:ALLOW'
          ,'ms_pets:NUMBER:ALLOW'
          ,'ms_pfin:NUMBER:ALLOW'
          ,'ms_photo:NUMBER:ALLOW'
          ,'ms_photoproc:NUMBER:ALLOW'
          ,'ms_rural:NUMBER:ALLOW'
          ,'ms_science:NUMBER:ALLOW'
          ,'ms_sports:NUMBER:ALLOW'
          ,'ms_sports_lmos:NUMBER:ALLOW'
          ,'ms_travel:NUMBER:ALLOW'
          ,'ms_tvmovies:NUMBER:ALLOW'
          ,'ms_wildlife:NUMBER:ALLOW'
          ,'ms_woman:NUMBER:ALLOW'
          ,'ms_woman_lmos:NUMBER:ALLOW'
          ,'ms_ringtones_apps:NUMBER:ALLOW'
          ,'cpi_mobile_apps_index:NUMBER:ALLOW'
          ,'cpi_credit_repair_index:NUMBER:ALLOW'
          ,'cpi_credit_report_index:NUMBER:ALLOW'
          ,'cpi_education_seekers_index:NUMBER:ALLOW'
          ,'cpi_insurance_index:NUMBER:ALLOW'
          ,'cpi_insurance_health_index:NUMBER:ALLOW'
          ,'cpi_insurance_auto_index:NUMBER:ALLOW'
          ,'cpi_job_seekers_index:NUMBER:ALLOW'
          ,'cpi_social_networking_index:NUMBER:ALLOW'
          ,'cpi_adult_index:NUMBER:ALLOW'
          ,'cpi_africanamerican_index:NUMBER:ALLOW'
          ,'cpi_apparel_index:NUMBER:ALLOW'
          ,'cpi_apparel_accessory_index:NUMBER:ALLOW'
          ,'cpi_apparel_kids_index:NUMBER:ALLOW'
          ,'cpi_apparel_men_index:NUMBER:ALLOW'
          ,'cpi_apparel_menfash_index:NUMBER:ALLOW'
          ,'cpi_apparel_women_index:NUMBER:ALLOW'
          ,'cpi_apparel_womfash_index:NUMBER:ALLOW'
          ,'cpi_asian_index:NUMBER:ALLOW'
          ,'cpi_auto_index:NUMBER:ALLOW'
          ,'cpi_auto_racing_index:NUMBER:ALLOW'
          ,'cpi_auto_trucks_index:NUMBER:ALLOW'
          ,'cpi_aviation_index:NUMBER:ALLOW'
          ,'cpi_bargains_index:NUMBER:ALLOW'
          ,'cpi_beauty_index:NUMBER:ALLOW'
          ,'cpi_bible_index:NUMBER:ALLOW'
          ,'cpi_birds_index:NUMBER:ALLOW'
          ,'cpi_business_index:NUMBER:ALLOW'
          ,'cpi_business_homeoffice_index:NUMBER:ALLOW'
          ,'cpi_catalog_index:NUMBER:ALLOW'
          ,'cpi_cc_index:NUMBER:ALLOW'
          ,'cpi_collectibles_index:NUMBER:ALLOW'
          ,'cpi_college_index:NUMBER:ALLOW'
          ,'cpi_computers_index:NUMBER:ALLOW'
          ,'cpi_conservative_index:NUMBER:ALLOW'
          ,'cpi_continuity_index:NUMBER:ALLOW'
          ,'cpi_cooking_index:NUMBER:ALLOW'
          ,'cpi_crafts_index:NUMBER:ALLOW'
          ,'cpi_crafts_crochet_index:NUMBER:ALLOW'
          ,'cpi_crafts_knit_index:NUMBER:ALLOW'
          ,'cpi_crafts_needlepoint_index:NUMBER:ALLOW'
          ,'cpi_crafts_quilt_index:NUMBER:ALLOW'
          ,'cpi_crafts_sew_index:NUMBER:ALLOW'
          ,'cpi_culturearts_index:NUMBER:ALLOW'
          ,'cpi_currevent_index:NUMBER:ALLOW'
          ,'cpi_diy_index:NUMBER:ALLOW'
          ,'cpi_donor_index:NUMBER:ALLOW'
          ,'cpi_ego_index:NUMBER:ALLOW'
          ,'cpi_electronics_index:NUMBER:ALLOW'
          ,'cpi_equestrian_index:NUMBER:ALLOW'
          ,'cpi_family_index:NUMBER:ALLOW'
          ,'cpi_family_teen_index:NUMBER:ALLOW'
          ,'cpi_family_young_index:NUMBER:ALLOW'
          ,'cpi_fiction_index:NUMBER:ALLOW'
          ,'cpi_gambling_index:NUMBER:ALLOW'
          ,'cpi_games_index:NUMBER:ALLOW'
          ,'cpi_gardening_index:NUMBER:ALLOW'
          ,'cpi_gay_index:NUMBER:ALLOW'
          ,'cpi_giftgivr_index:NUMBER:ALLOW'
          ,'cpi_gourmet_index:NUMBER:ALLOW'
          ,'cpi_grandparents_index:NUMBER:ALLOW'
          ,'cpi_health_index:NUMBER:ALLOW'
          ,'cpi_health_diet_index:NUMBER:ALLOW'
          ,'cpi_health_fitness_index:NUMBER:ALLOW'
          ,'cpi_hightech_index:NUMBER:ALLOW'
          ,'cpi_hispanic_index:NUMBER:ALLOW'
          ,'cpi_history_index:NUMBER:ALLOW'
          ,'cpi_history_american_index:NUMBER:ALLOW'
          ,'cpi_hobbies_index:NUMBER:ALLOW'
          ,'cpi_homedecr_index:NUMBER:ALLOW'
          ,'cpi_homeliv_index:NUMBER:ALLOW'
          ,'cpi_humor_index:NUMBER:ALLOW'
          ,'cpi_inspiration_index:NUMBER:ALLOW'
          ,'cpi_internet_index:NUMBER:ALLOW'
          ,'cpi_internet_access_index:NUMBER:ALLOW'
          ,'cpi_internet_buy_index:NUMBER:ALLOW'
          ,'cpi_liberal_index:NUMBER:ALLOW'
          ,'cpi_moneymaking_index:NUMBER:ALLOW'
          ,'cpi_motorcycles_index:NUMBER:ALLOW'
          ,'cpi_music_index:NUMBER:ALLOW'
          ,'cpi_nonfiction_index:NUMBER:ALLOW'
          ,'cpi_ocean_index:NUMBER:ALLOW'
          ,'cpi_outdoors_index:NUMBER:ALLOW'
          ,'cpi_outdoors_boatsail_index:NUMBER:ALLOW'
          ,'cpi_outdoors_camp_index:NUMBER:ALLOW'
          ,'cpi_outdoors_fishing_index:NUMBER:ALLOW'
          ,'cpi_outdoors_huntfish_index:NUMBER:ALLOW'
          ,'cpi_outdoors_hunting_index:NUMBER:ALLOW'
          ,'cpi_pets_index:NUMBER:ALLOW'
          ,'cpi_pets_cats_index:NUMBER:ALLOW'
          ,'cpi_pets_dogs_index:NUMBER:ALLOW'
          ,'cpi_pfin_index:NUMBER:ALLOW'
          ,'cpi_photog_index:NUMBER:ALLOW'
          ,'cpi_photoproc_index:NUMBER:ALLOW'
          ,'cpi_publish_index:NUMBER:ALLOW'
          ,'cpi_publish_books_index:NUMBER:ALLOW'
          ,'cpi_publish_mags_index:NUMBER:ALLOW'
          ,'cpi_rural_index:NUMBER:ALLOW'
          ,'cpi_science_index:NUMBER:ALLOW'
          ,'cpi_scifi_index:NUMBER:ALLOW'
          ,'cpi_seniors_index:NUMBER:ALLOW'
          ,'cpi_sports_index:NUMBER:ALLOW'
          ,'cpi_sports_baseball_index:NUMBER:ALLOW'
          ,'cpi_sports_basketball_index:NUMBER:ALLOW'
          ,'cpi_sports_biking_index:NUMBER:ALLOW'
          ,'cpi_sports_football_index:NUMBER:ALLOW'
          ,'cpi_sports_golf_index:NUMBER:ALLOW'
          ,'cpi_sports_hockey_index:NUMBER:ALLOW'
          ,'cpi_sports_running_index:NUMBER:ALLOW'
          ,'cpi_sports_ski_index:NUMBER:ALLOW'
          ,'cpi_sports_soccer_index:NUMBER:ALLOW'
          ,'cpi_sports_swimming_index:NUMBER:ALLOW'
          ,'cpi_sports_tennis_index:NUMBER:ALLOW'
          ,'cpi_stationery_index:NUMBER:ALLOW'
          ,'cpi_sweeps_index:NUMBER:ALLOW'
          ,'cpi_tobacco_index:NUMBER:ALLOW'
          ,'cpi_travel_index:NUMBER:ALLOW'
          ,'cpi_travel_cruise_index:NUMBER:ALLOW'
          ,'cpi_travel_rv_index:NUMBER:ALLOW'
          ,'cpi_travel_us_index:NUMBER:ALLOW'
          ,'cpi_tvmovies_index:NUMBER:ALLOW'
          ,'cpi_wildlife_index:NUMBER:ALLOW'
          ,'cpi_woman_index:NUMBER:ALLOW'
          ,'totdlr_index:NUMBER:ALLOW'
          ,'cpi_totdlr:NUMBER:ALLOW'
          ,'cpi_totords:NUMBER:ALLOW'
          ,'cpi_lastdlr:NUMBER:ALLOW'
          ,'pkcatg:NUMBER:ALLOW'
          ,'pkpubs:NUMBER:ALLOW'
          ,'pkcont:NUMBER:ALLOW'
          ,'pkca01:NUMBER:ALLOW'
          ,'pkca03:NUMBER:ALLOW'
          ,'pkca04:NUMBER:ALLOW'
          ,'pkca05:NUMBER:ALLOW'
          ,'pkca06:NUMBER:ALLOW'
          ,'pkca07:NUMBER:ALLOW'
          ,'pkca08:NUMBER:ALLOW'
          ,'pkca09:NUMBER:ALLOW'
          ,'pkca10:NUMBER:ALLOW'
          ,'pkca11:NUMBER:ALLOW'
          ,'pkca12:NUMBER:ALLOW'
          ,'pkca13:NUMBER:ALLOW'
          ,'pkca14:NUMBER:ALLOW'
          ,'pkca15:NUMBER:ALLOW'
          ,'pkca16:NUMBER:ALLOW'
          ,'pkca17:NUMBER:ALLOW'
          ,'pkca18:NUMBER:ALLOW'
          ,'pkca20:NUMBER:ALLOW'
          ,'pkca21:NUMBER:ALLOW'
          ,'pkca22:NUMBER:ALLOW'
          ,'pkca23:NUMBER:ALLOW'
          ,'pkca24:NUMBER:ALLOW'
          ,'pkca25:NUMBER:ALLOW'
          ,'pkca26:NUMBER:ALLOW'
          ,'pkca28:NUMBER:ALLOW'
          ,'pkca29:NUMBER:ALLOW'
          ,'pkca30:NUMBER:ALLOW'
          ,'pkca31:NUMBER:ALLOW'
          ,'pkca32:NUMBER:ALLOW'
          ,'pkca33:NUMBER:ALLOW'
          ,'pkca34:NUMBER:ALLOW'
          ,'pkca35:NUMBER:ALLOW'
          ,'pkca36:NUMBER:ALLOW'
          ,'pkca37:NUMBER:ALLOW'
          ,'pkca39:NUMBER:ALLOW'
          ,'pkca40:NUMBER:ALLOW'
          ,'pkca41:NUMBER:ALLOW'
          ,'pkca42:NUMBER:ALLOW'
          ,'pkca54:NUMBER:ALLOW'
          ,'pkca61:NUMBER:ALLOW'
          ,'pkca62:NUMBER:ALLOW'
          ,'pkca64:NUMBER:ALLOW'
          ,'pkpu01:NUMBER:ALLOW'
          ,'pkpu02:NUMBER:ALLOW'
          ,'pkpu03:NUMBER:ALLOW'
          ,'pkpu04:NUMBER:ALLOW'
          ,'pkpu05:NUMBER:ALLOW'
          ,'pkpu06:NUMBER:ALLOW'
          ,'pkpu07:NUMBER:ALLOW'
          ,'pkpu08:NUMBER:ALLOW'
          ,'pkpu09:NUMBER:ALLOW'
          ,'pkpu10:NUMBER:ALLOW'
          ,'pkpu11:NUMBER:ALLOW'
          ,'pkpu12:NUMBER:ALLOW'
          ,'pkpu13:NUMBER:ALLOW'
          ,'pkpu14:NUMBER:ALLOW'
          ,'pkpu15:NUMBER:ALLOW'
          ,'pkpu16:NUMBER:ALLOW'
          ,'pkpu17:NUMBER:ALLOW'
          ,'pkpu18:NUMBER:ALLOW'
          ,'pkpu19:NUMBER:ALLOW'
          ,'pkpu20:NUMBER:ALLOW'
          ,'pkpu23:NUMBER:ALLOW'
          ,'pkpu25:NUMBER:ALLOW'
          ,'pkpu27:NUMBER:ALLOW'
          ,'pkpu28:NUMBER:ALLOW'
          ,'pkpu29:NUMBER:ALLOW'
          ,'pkpu30:NUMBER:ALLOW'
          ,'pkpu31:NUMBER:ALLOW'
          ,'pkpu32:NUMBER:ALLOW'
          ,'pkpu33:NUMBER:ALLOW'
          ,'pkpu34:NUMBER:ALLOW'
          ,'pkpu35:NUMBER:ALLOW'
          ,'pkpu38:NUMBER:ALLOW'
          ,'pkpu41:NUMBER:ALLOW'
          ,'pkpu42:NUMBER:ALLOW'
          ,'pkpu45:NUMBER:ALLOW'
          ,'pkpu46:NUMBER:ALLOW'
          ,'pkpu47:NUMBER:ALLOW'
          ,'pkpu48:NUMBER:ALLOW'
          ,'pkpu49:NUMBER:ALLOW'
          ,'pkpu50:NUMBER:ALLOW'
          ,'pkpu51:NUMBER:ALLOW'
          ,'pkpu52:NUMBER:ALLOW'
          ,'pkpu53:NUMBER:ALLOW'
          ,'pkpu54:NUMBER:ALLOW'
          ,'pkpu55:NUMBER:ALLOW'
          ,'pkpu56:NUMBER:ALLOW'
          ,'pkpu57:NUMBER:ALLOW'
          ,'pkpu60:NUMBER:ALLOW'
          ,'pkpu61:NUMBER:ALLOW'
          ,'pkpu62:NUMBER:ALLOW'
          ,'pkpu63:NUMBER:ALLOW'
          ,'pkpu64:NUMBER:ALLOW'
          ,'pkpu65:NUMBER:ALLOW'
          ,'pkpu66:NUMBER:ALLOW'
          ,'pkpu67:NUMBER:ALLOW'
          ,'pkpu68:NUMBER:ALLOW'
          ,'pkpu69:NUMBER:ALLOW'
          ,'pkpu70:NUMBER:ALLOW'
          ,'censpct_water:NUMBER:ALLOW'
          ,'cens_pop_density:NUMBER:ALLOW'
          ,'cens_hu_density:NUMBER:ALLOW'
          ,'censpct_pop_white:NUMBER:ALLOW'
          ,'censpct_pop_black:NUMBER:ALLOW'
          ,'censpct_pop_amerind:NUMBER:ALLOW'
          ,'censpct_pop_asian:NUMBER:ALLOW'
          ,'censpct_pop_pacisl:NUMBER:ALLOW'
          ,'censpct_pop_othrace:NUMBER:ALLOW'
          ,'censpct_pop_multirace:NUMBER:ALLOW'
          ,'censpct_pop_hispanic:NUMBER:ALLOW'
          ,'censpct_pop_agelt18:NUMBER:ALLOW'
          ,'censpct_pop_males:NUMBER:ALLOW'
          ,'censpct_adult_age1824:NUMBER:ALLOW'
          ,'censpct_adult_age2534:NUMBER:ALLOW'
          ,'censpct_adult_age3544:NUMBER:ALLOW'
          ,'censpct_adult_age4554:NUMBER:ALLOW'
          ,'censpct_adult_age5564:NUMBER:ALLOW'
          ,'censpct_adult_agege65:NUMBER:ALLOW'
          ,'cens_pop_medage:NUMBER:ALLOW'
          ,'cens_hh_avgsize:NUMBER:ALLOW'
          ,'censpct_hh_family:NUMBER:ALLOW'
          ,'censpct_hh_family_husbwife:NUMBER:ALLOW'
          ,'censpct_hu_occupied:NUMBER:ALLOW'
          ,'censpct_hu_owned:NUMBER:ALLOW'
          ,'censpct_hu_rented:NUMBER:ALLOW'
          ,'censpct_hu_vacantseasonal:NUMBER:ALLOW'
          ,'zip_medinc:NUMBER:ALLOW'
          ,'zip_apparel:NUMBER:ALLOW'
          ,'zip_apparel_women:NUMBER:ALLOW'
          ,'zip_apparel_womfash:NUMBER:ALLOW'
          ,'zip_auto:NUMBER:ALLOW'
          ,'zip_beauty:NUMBER:ALLOW'
          ,'zip_booksmusicmovies:NUMBER:ALLOW'
          ,'zip_business:NUMBER:ALLOW'
          ,'zip_catalog:NUMBER:ALLOW'
          ,'zip_cc:NUMBER:ALLOW'
          ,'zip_collectibles:NUMBER:ALLOW'
          ,'zip_computers:NUMBER:ALLOW'
          ,'zip_continuity:NUMBER:ALLOW'
          ,'zip_cooking:NUMBER:ALLOW'
          ,'zip_crafts:NUMBER:ALLOW'
          ,'zip_culturearts:NUMBER:ALLOW'
          ,'zip_dm_sold:NUMBER:ALLOW'
          ,'zip_donor:NUMBER:ALLOW'
          ,'zip_family:NUMBER:ALLOW'
          ,'zip_gardening:NUMBER:ALLOW'
          ,'zip_giftgivr:NUMBER:ALLOW'
          ,'zip_gourmet:NUMBER:ALLOW'
          ,'zip_health:NUMBER:ALLOW'
          ,'zip_health_diet:NUMBER:ALLOW'
          ,'zip_health_fitness:NUMBER:ALLOW'
          ,'zip_hobbies:NUMBER:ALLOW'
          ,'zip_homedecr:NUMBER:ALLOW'
          ,'zip_homeliv:NUMBER:ALLOW'
          ,'zip_internet:NUMBER:ALLOW'
          ,'zip_internet_access:NUMBER:ALLOW'
          ,'zip_internet_buy:NUMBER:ALLOW'
          ,'zip_music:NUMBER:ALLOW'
          ,'zip_outdoors:NUMBER:ALLOW'
          ,'zip_pets:NUMBER:ALLOW'
          ,'zip_pfin:NUMBER:ALLOW'
          ,'zip_publish:NUMBER:ALLOW'
          ,'zip_publish_books:NUMBER:ALLOW'
          ,'zip_publish_mags:NUMBER:ALLOW'
          ,'zip_sports:NUMBER:ALLOW'
          ,'zip_sports_biking:NUMBER:ALLOW'
          ,'zip_sports_golf:NUMBER:ALLOW'
          ,'zip_travel:NUMBER:ALLOW'
          ,'zip_travel_us:NUMBER:ALLOW'
          ,'zip_tvmovies:NUMBER:ALLOW'
          ,'zip_woman:NUMBER:ALLOW'
          ,'zip_proftech:NUMBER:ALLOW'
          ,'zip_retired:NUMBER:ALLOW'
          ,'zip_inc100:NUMBER:ALLOW'
          ,'zip_inc75:NUMBER:ALLOW'
          ,'zip_inc50:NUMBER:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY'
          ,'record:Number_Edited_Records:SUMMARY'
          ,'rule:Number_Edited_Rules:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_dtmatch(1),Fields.InvalidMessage_dtmatch(2)
          ,Fields.InvalidMessage_msname(1)
          ,Fields.InvalidMessage_msaddr1(1)
          ,Fields.InvalidMessage_msaddr2(1)
          ,Fields.InvalidMessage_mscity(1),Fields.InvalidMessage_mscity(2)
          ,Fields.InvalidMessage_msstate(1),Fields.InvalidMessage_msstate(2),Fields.InvalidMessage_msstate(3)
          ,Fields.InvalidMessage_mszip5(1),Fields.InvalidMessage_mszip5(2)
          ,Fields.InvalidMessage_mszip4(1),Fields.InvalidMessage_mszip4(2)
          ,Fields.InvalidMessage_dthh(1),Fields.InvalidMessage_dthh(2)
          ,Fields.InvalidMessage_mscrrt(1),Fields.InvalidMessage_mscrrt(2)
          ,Fields.InvalidMessage_msdpbc(1),Fields.InvalidMessage_msdpbc(2)
          ,Fields.InvalidMessage_msdpv(1),Fields.InvalidMessage_msdpv(2)
          ,Fields.InvalidMessage_ms_addrtype(1),Fields.InvalidMessage_ms_addrtype(2)
          ,Fields.InvalidMessage_ctysize(1),Fields.InvalidMessage_ctysize(2)
          ,Fields.InvalidMessage_lmos(1)
          ,Fields.InvalidMessage_omos(1)
          ,Fields.InvalidMessage_pmos(1)
          ,Fields.InvalidMessage_gen(1),Fields.InvalidMessage_gen(2)
          ,Fields.InvalidMessage_dob(1)
          ,Fields.InvalidMessage_age(1)
          ,Fields.InvalidMessage_inc(1),Fields.InvalidMessage_inc(2)
          ,Fields.InvalidMessage_marital_status(1)
          ,Fields.InvalidMessage_poc(1)
          ,Fields.InvalidMessage_noc(1),Fields.InvalidMessage_noc(2)
          ,Fields.InvalidMessage_ocp(1),Fields.InvalidMessage_ocp(2)
          ,Fields.InvalidMessage_edu(1),Fields.InvalidMessage_edu(2)
          ,Fields.InvalidMessage_lang(1),Fields.InvalidMessage_lang(2)
          ,Fields.InvalidMessage_relig(1),Fields.InvalidMessage_relig(2)
          ,Fields.InvalidMessage_dwell(1),Fields.InvalidMessage_dwell(2)
          ,Fields.InvalidMessage_ownr(1)
          ,Fields.InvalidMessage_eth1(1),Fields.InvalidMessage_eth1(2)
          ,Fields.InvalidMessage_eth2(1),Fields.InvalidMessage_eth2(2)
          ,Fields.InvalidMessage_lor(1),Fields.InvalidMessage_lor(2)
          ,Fields.InvalidMessage_pool(1),Fields.InvalidMessage_pool(2)
          ,Fields.InvalidMessage_speak_span(1),Fields.InvalidMessage_speak_span(2)
          ,Fields.InvalidMessage_soho(1),Fields.InvalidMessage_soho(2)
          ,Fields.InvalidMessage_vet_in_hh(1),Fields.InvalidMessage_vet_in_hh(2)
          ,Fields.InvalidMessage_ms_mags(1)
          ,Fields.InvalidMessage_ms_books(1)
          ,Fields.InvalidMessage_ms_publish(1)
          ,Fields.InvalidMessage_ms_pub_status_active(1)
          ,Fields.InvalidMessage_ms_pub_status_expire(1)
          ,Fields.InvalidMessage_ms_pub_premsold(1)
          ,Fields.InvalidMessage_ms_pub_autornwl(1)
          ,Fields.InvalidMessage_ms_pub_avgterm(1)
          ,Fields.InvalidMessage_ms_pub_lmos(1)
          ,Fields.InvalidMessage_ms_pub_omos(1)
          ,Fields.InvalidMessage_ms_pub_pmos(1)
          ,Fields.InvalidMessage_ms_pub_cemos(1)
          ,Fields.InvalidMessage_ms_pub_femos(1)
          ,Fields.InvalidMessage_ms_pub_totords(1)
          ,Fields.InvalidMessage_ms_pub_totdlrs(1)
          ,Fields.InvalidMessage_ms_pub_avgdlrs(1)
          ,Fields.InvalidMessage_ms_pub_lastdlrs(1)
          ,Fields.InvalidMessage_ms_pub_paystat_paid(1)
          ,Fields.InvalidMessage_ms_pub_paystat_ub(1)
          ,Fields.InvalidMessage_ms_pub_paymeth_cc(1)
          ,Fields.InvalidMessage_ms_pub_paymeth_cash(1)
          ,Fields.InvalidMessage_ms_pub_payspeed(1)
          ,Fields.InvalidMessage_ms_pub_osrc_dm(1)
          ,Fields.InvalidMessage_ms_pub_lsrc_dm(1)
          ,Fields.InvalidMessage_ms_pub_osrc_agt_cashf(1)
          ,Fields.InvalidMessage_ms_pub_lsrc_agt_cashf(1)
          ,Fields.InvalidMessage_ms_pub_osrc_agt_pds(1)
          ,Fields.InvalidMessage_ms_pub_lsrc_agt_pds(1)
          ,Fields.InvalidMessage_ms_pub_osrc_agt_schplan(1)
          ,Fields.InvalidMessage_ms_pub_lsrc_agt_schplan(1)
          ,Fields.InvalidMessage_ms_pub_osrc_agt_sponsor(1)
          ,Fields.InvalidMessage_ms_pub_lsrc_agt_sponsor(1)
          ,Fields.InvalidMessage_ms_pub_osrc_agt_tm(1)
          ,Fields.InvalidMessage_ms_pub_lsrc_agt_tm(1)
          ,Fields.InvalidMessage_ms_pub_osrc_agt(1)
          ,Fields.InvalidMessage_ms_pub_lsrc_agt(1)
          ,Fields.InvalidMessage_ms_pub_osrc_tm(1)
          ,Fields.InvalidMessage_ms_pub_lsrc_tm(1)
          ,Fields.InvalidMessage_ms_pub_osrc_ins(1)
          ,Fields.InvalidMessage_ms_pub_lsrc_ins(1)
          ,Fields.InvalidMessage_ms_pub_osrc_net(1)
          ,Fields.InvalidMessage_ms_pub_lsrc_net(1)
          ,Fields.InvalidMessage_ms_pub_osrc_print(1)
          ,Fields.InvalidMessage_ms_pub_lsrc_print(1)
          ,Fields.InvalidMessage_ms_pub_osrc_trans(1)
          ,Fields.InvalidMessage_ms_pub_lsrc_trans(1)
          ,Fields.InvalidMessage_ms_pub_osrc_tv(1)
          ,Fields.InvalidMessage_ms_pub_lsrc_tv(1)
          ,Fields.InvalidMessage_ms_pub_osrc_dtp(1)
          ,Fields.InvalidMessage_ms_pub_lsrc_dtp(1)
          ,Fields.InvalidMessage_ms_pub_giftgivr(1)
          ,Fields.InvalidMessage_ms_pub_giftee(1)
          ,Fields.InvalidMessage_ms_catalog(1)
          ,Fields.InvalidMessage_ms_cat_lmos(1)
          ,Fields.InvalidMessage_ms_cat_omos(1)
          ,Fields.InvalidMessage_ms_cat_pmos(1)
          ,Fields.InvalidMessage_ms_cat_totords(1)
          ,Fields.InvalidMessage_ms_cat_totitems(1)
          ,Fields.InvalidMessage_ms_cat_totdlrs(1)
          ,Fields.InvalidMessage_ms_cat_avgdlrs(1)
          ,Fields.InvalidMessage_ms_cat_lastdlrs(1)
          ,Fields.InvalidMessage_ms_cat_paystat_paid(1)
          ,Fields.InvalidMessage_ms_cat_paymeth_cc(1)
          ,Fields.InvalidMessage_ms_cat_paymeth_cash(1)
          ,Fields.InvalidMessage_ms_cat_osrc_dm(1)
          ,Fields.InvalidMessage_ms_cat_lsrc_dm(1)
          ,Fields.InvalidMessage_ms_cat_osrc_net(1)
          ,Fields.InvalidMessage_ms_cat_lsrc_net(1)
          ,Fields.InvalidMessage_ms_cat_giftgivr(1)
          ,Fields.InvalidMessage_pkpubs_corrected(1)
          ,Fields.InvalidMessage_pkcatg_corrected(1)
          ,Fields.InvalidMessage_ms_fundraising(1)
          ,Fields.InvalidMessage_ms_fund_lmos(1)
          ,Fields.InvalidMessage_ms_fund_omos(1)
          ,Fields.InvalidMessage_ms_fund_pmos(1)
          ,Fields.InvalidMessage_ms_fund_totords(1)
          ,Fields.InvalidMessage_ms_fund_totdlrs(1)
          ,Fields.InvalidMessage_ms_fund_avgdlrs(1)
          ,Fields.InvalidMessage_ms_fund_lastdlrs(1)
          ,Fields.InvalidMessage_ms_fund_paystat_paid(1)
          ,Fields.InvalidMessage_ms_other(1)
          ,Fields.InvalidMessage_ms_continuity(1)
          ,Fields.InvalidMessage_ms_cont_status_active(1)
          ,Fields.InvalidMessage_ms_cont_status_cancel(1)
          ,Fields.InvalidMessage_ms_cont_omos(1)
          ,Fields.InvalidMessage_ms_cont_lmos(1)
          ,Fields.InvalidMessage_ms_cont_pmos(1)
          ,Fields.InvalidMessage_ms_cont_totords(1)
          ,Fields.InvalidMessage_ms_cont_totdlrs(1)
          ,Fields.InvalidMessage_ms_cont_avgdlrs(1)
          ,Fields.InvalidMessage_ms_cont_lastdlrs(1)
          ,Fields.InvalidMessage_ms_cont_paystat_paid(1)
          ,Fields.InvalidMessage_ms_cont_paymeth_cc(1)
          ,Fields.InvalidMessage_ms_cont_paymeth_cash(1)
          ,Fields.InvalidMessage_ms_totords(1)
          ,Fields.InvalidMessage_ms_totitems(1)
          ,Fields.InvalidMessage_ms_totdlrs(1)
          ,Fields.InvalidMessage_ms_avgdlrs(1)
          ,Fields.InvalidMessage_ms_lastdlrs(1)
          ,Fields.InvalidMessage_ms_paystat_paid(1)
          ,Fields.InvalidMessage_ms_paymeth_cc(1)
          ,Fields.InvalidMessage_ms_paymeth_cash(1)
          ,Fields.InvalidMessage_ms_osrc_dm(1)
          ,Fields.InvalidMessage_ms_lsrc_dm(1)
          ,Fields.InvalidMessage_ms_osrc_tm(1)
          ,Fields.InvalidMessage_ms_lsrc_tm(1)
          ,Fields.InvalidMessage_ms_osrc_ins(1)
          ,Fields.InvalidMessage_ms_lsrc_ins(1)
          ,Fields.InvalidMessage_ms_osrc_net(1)
          ,Fields.InvalidMessage_ms_lsrc_net(1)
          ,Fields.InvalidMessage_ms_osrc_tv(1)
          ,Fields.InvalidMessage_ms_lsrc_tv(1)
          ,Fields.InvalidMessage_ms_osrc_retail(1)
          ,Fields.InvalidMessage_ms_lsrc_retail(1)
          ,Fields.InvalidMessage_ms_giftgivr(1)
          ,Fields.InvalidMessage_ms_giftee(1)
          ,Fields.InvalidMessage_ms_adult(1)
          ,Fields.InvalidMessage_ms_womapp(1)
          ,Fields.InvalidMessage_ms_menapp(1)
          ,Fields.InvalidMessage_ms_kidapp(1)
          ,Fields.InvalidMessage_ms_accessory(1)
          ,Fields.InvalidMessage_ms_apparel(1)
          ,Fields.InvalidMessage_ms_app_lmos(1)
          ,Fields.InvalidMessage_ms_app_omos(1)
          ,Fields.InvalidMessage_ms_app_pmos(1)
          ,Fields.InvalidMessage_ms_app_totords(1)
          ,Fields.InvalidMessage_ms_app_totitems(1)
          ,Fields.InvalidMessage_ms_app_totdlrs(1)
          ,Fields.InvalidMessage_ms_app_avgdlrs(1)
          ,Fields.InvalidMessage_ms_app_lastdlrs(1)
          ,Fields.InvalidMessage_ms_app_paystat_paid(1)
          ,Fields.InvalidMessage_ms_app_paymeth_cc(1)
          ,Fields.InvalidMessage_ms_app_paymeth_cash(1)
          ,Fields.InvalidMessage_ms_menfash(1)
          ,Fields.InvalidMessage_ms_womfash(1)
          ,Fields.InvalidMessage_ms_wfsh_lmos(1)
          ,Fields.InvalidMessage_ms_wfsh_omos(1)
          ,Fields.InvalidMessage_ms_wfsh_pmos(1)
          ,Fields.InvalidMessage_ms_wfsh_totords(1)
          ,Fields.InvalidMessage_ms_wfsh_totdlrs(1)
          ,Fields.InvalidMessage_ms_wfsh_avgdlrs(1)
          ,Fields.InvalidMessage_ms_wfsh_lastdlrs(1)
          ,Fields.InvalidMessage_ms_wfsh_paystat_paid(1)
          ,Fields.InvalidMessage_ms_wfsh_osrc_dm(1)
          ,Fields.InvalidMessage_ms_wfsh_lsrc_dm(1)
          ,Fields.InvalidMessage_ms_wfsh_osrc_agt(1)
          ,Fields.InvalidMessage_ms_wfsh_lsrc_agt(1)
          ,Fields.InvalidMessage_ms_audio(1)
          ,Fields.InvalidMessage_ms_auto(1)
          ,Fields.InvalidMessage_ms_aviation(1)
          ,Fields.InvalidMessage_ms_bargains(1)
          ,Fields.InvalidMessage_ms_beauty(1)
          ,Fields.InvalidMessage_ms_bible(1)
          ,Fields.InvalidMessage_ms_bible_lmos(1)
          ,Fields.InvalidMessage_ms_bible_omos(1)
          ,Fields.InvalidMessage_ms_bible_pmos(1)
          ,Fields.InvalidMessage_ms_bible_totords(1)
          ,Fields.InvalidMessage_ms_bible_totitems(1)
          ,Fields.InvalidMessage_ms_bible_totdlrs(1)
          ,Fields.InvalidMessage_ms_bible_avgdlrs(1)
          ,Fields.InvalidMessage_ms_bible_lastdlrs(1)
          ,Fields.InvalidMessage_ms_bible_paystat_paid(1)
          ,Fields.InvalidMessage_ms_bible_paymeth_cc(1)
          ,Fields.InvalidMessage_ms_bible_paymeth_cash(1)
          ,Fields.InvalidMessage_ms_business(1)
          ,Fields.InvalidMessage_ms_collectibles(1)
          ,Fields.InvalidMessage_ms_computers(1)
          ,Fields.InvalidMessage_ms_crafts(1)
          ,Fields.InvalidMessage_ms_culturearts(1)
          ,Fields.InvalidMessage_ms_currevent(1)
          ,Fields.InvalidMessage_ms_diy(1)
          ,Fields.InvalidMessage_ms_electronics(1)
          ,Fields.InvalidMessage_ms_equestrian(1)
          ,Fields.InvalidMessage_ms_pub_family(1)
          ,Fields.InvalidMessage_ms_cat_family(1)
          ,Fields.InvalidMessage_ms_family(1)
          ,Fields.InvalidMessage_ms_family_lmos(1)
          ,Fields.InvalidMessage_ms_family_omos(1)
          ,Fields.InvalidMessage_ms_family_pmos(1)
          ,Fields.InvalidMessage_ms_family_totords(1)
          ,Fields.InvalidMessage_ms_family_totitems(1)
          ,Fields.InvalidMessage_ms_family_totdlrs(1)
          ,Fields.InvalidMessage_ms_family_avgdlrs(1)
          ,Fields.InvalidMessage_ms_family_lastdlrs(1)
          ,Fields.InvalidMessage_ms_family_paystat_paid(1)
          ,Fields.InvalidMessage_ms_family_paymeth_cc(1)
          ,Fields.InvalidMessage_ms_family_paymeth_cash(1)
          ,Fields.InvalidMessage_ms_family_osrc_dm(1)
          ,Fields.InvalidMessage_ms_family_lsrc_dm(1)
          ,Fields.InvalidMessage_ms_fiction(1)
          ,Fields.InvalidMessage_ms_food(1)
          ,Fields.InvalidMessage_ms_games(1)
          ,Fields.InvalidMessage_ms_gifts(1)
          ,Fields.InvalidMessage_ms_gourmet(1)
          ,Fields.InvalidMessage_ms_fitness(1)
          ,Fields.InvalidMessage_ms_health(1)
          ,Fields.InvalidMessage_ms_hlth_lmos(1)
          ,Fields.InvalidMessage_ms_hlth_omos(1)
          ,Fields.InvalidMessage_ms_hlth_pmos(1)
          ,Fields.InvalidMessage_ms_hlth_totords(1)
          ,Fields.InvalidMessage_ms_hlth_totdlrs(1)
          ,Fields.InvalidMessage_ms_hlth_avgdlrs(1)
          ,Fields.InvalidMessage_ms_hlth_lastdlrs(1)
          ,Fields.InvalidMessage_ms_hlth_paystat_paid(1)
          ,Fields.InvalidMessage_ms_hlth_paymeth_cc(1)
          ,Fields.InvalidMessage_ms_hlth_osrc_dm(1)
          ,Fields.InvalidMessage_ms_hlth_lsrc_dm(1)
          ,Fields.InvalidMessage_ms_hlth_osrc_agt(1)
          ,Fields.InvalidMessage_ms_hlth_lsrc_agt(1)
          ,Fields.InvalidMessage_ms_hlth_osrc_tv(1)
          ,Fields.InvalidMessage_ms_hlth_lsrc_tv(1)
          ,Fields.InvalidMessage_ms_holiday(1)
          ,Fields.InvalidMessage_ms_history(1)
          ,Fields.InvalidMessage_ms_pub_cooking(1)
          ,Fields.InvalidMessage_ms_cooking(1)
          ,Fields.InvalidMessage_ms_pub_homedecr(1)
          ,Fields.InvalidMessage_ms_cat_homedecr(1)
          ,Fields.InvalidMessage_ms_homedecr(1)
          ,Fields.InvalidMessage_ms_housewares(1)
          ,Fields.InvalidMessage_ms_pub_garden(1)
          ,Fields.InvalidMessage_ms_cat_garden(1)
          ,Fields.InvalidMessage_ms_garden(1)
          ,Fields.InvalidMessage_ms_pub_homeliv(1)
          ,Fields.InvalidMessage_ms_cat_homeliv(1)
          ,Fields.InvalidMessage_ms_homeliv(1)
          ,Fields.InvalidMessage_ms_pub_home_status_active(1)
          ,Fields.InvalidMessage_ms_home_lmos(1)
          ,Fields.InvalidMessage_ms_home_omos(1)
          ,Fields.InvalidMessage_ms_home_pmos(1)
          ,Fields.InvalidMessage_ms_home_totords(1)
          ,Fields.InvalidMessage_ms_home_totitems(1)
          ,Fields.InvalidMessage_ms_home_totdlrs(1)
          ,Fields.InvalidMessage_ms_home_avgdlrs(1)
          ,Fields.InvalidMessage_ms_home_lastdlrs(1)
          ,Fields.InvalidMessage_ms_home_paystat_paid(1)
          ,Fields.InvalidMessage_ms_home_paymeth_cc(1)
          ,Fields.InvalidMessage_ms_home_paymeth_cash(1)
          ,Fields.InvalidMessage_ms_home_osrc_dm(1)
          ,Fields.InvalidMessage_ms_home_lsrc_dm(1)
          ,Fields.InvalidMessage_ms_home_osrc_agt(1)
          ,Fields.InvalidMessage_ms_home_lsrc_agt(1)
          ,Fields.InvalidMessage_ms_home_osrc_net(1)
          ,Fields.InvalidMessage_ms_home_lsrc_net(1)
          ,Fields.InvalidMessage_ms_home_osrc_tv(1)
          ,Fields.InvalidMessage_ms_home_lsrc_tv(1)
          ,Fields.InvalidMessage_ms_humor(1)
          ,Fields.InvalidMessage_ms_inspiration(1)
          ,Fields.InvalidMessage_ms_merchandise(1)
          ,Fields.InvalidMessage_ms_moneymaking(1)
          ,Fields.InvalidMessage_ms_moneymaking_lmos(1)
          ,Fields.InvalidMessage_ms_motorcycles(1)
          ,Fields.InvalidMessage_ms_music(1)
          ,Fields.InvalidMessage_ms_fishing(1)
          ,Fields.InvalidMessage_ms_hunting(1)
          ,Fields.InvalidMessage_ms_boatsail(1)
          ,Fields.InvalidMessage_ms_camp(1)
          ,Fields.InvalidMessage_ms_pub_outdoors(1)
          ,Fields.InvalidMessage_ms_cat_outdoors(1)
          ,Fields.InvalidMessage_ms_outdoors(1)
          ,Fields.InvalidMessage_ms_pub_out_status_active(1)
          ,Fields.InvalidMessage_ms_out_lmos(1)
          ,Fields.InvalidMessage_ms_out_omos(1)
          ,Fields.InvalidMessage_ms_out_pmos(1)
          ,Fields.InvalidMessage_ms_out_totords(1)
          ,Fields.InvalidMessage_ms_out_totitems(1)
          ,Fields.InvalidMessage_ms_out_totdlrs(1)
          ,Fields.InvalidMessage_ms_out_avgdlrs(1)
          ,Fields.InvalidMessage_ms_out_lastdlrs(1)
          ,Fields.InvalidMessage_ms_out_paystat_paid(1)
          ,Fields.InvalidMessage_ms_out_paymeth_cc(1)
          ,Fields.InvalidMessage_ms_out_paymeth_cash(1)
          ,Fields.InvalidMessage_ms_out_osrc_dm(1)
          ,Fields.InvalidMessage_ms_out_lsrc_dm(1)
          ,Fields.InvalidMessage_ms_out_osrc_agt(1)
          ,Fields.InvalidMessage_ms_out_lsrc_agt(1)
          ,Fields.InvalidMessage_ms_pets(1)
          ,Fields.InvalidMessage_ms_pfin(1)
          ,Fields.InvalidMessage_ms_photo(1)
          ,Fields.InvalidMessage_ms_photoproc(1)
          ,Fields.InvalidMessage_ms_rural(1)
          ,Fields.InvalidMessage_ms_science(1)
          ,Fields.InvalidMessage_ms_sports(1)
          ,Fields.InvalidMessage_ms_sports_lmos(1)
          ,Fields.InvalidMessage_ms_travel(1)
          ,Fields.InvalidMessage_ms_tvmovies(1)
          ,Fields.InvalidMessage_ms_wildlife(1)
          ,Fields.InvalidMessage_ms_woman(1)
          ,Fields.InvalidMessage_ms_woman_lmos(1)
          ,Fields.InvalidMessage_ms_ringtones_apps(1)
          ,Fields.InvalidMessage_cpi_mobile_apps_index(1)
          ,Fields.InvalidMessage_cpi_credit_repair_index(1)
          ,Fields.InvalidMessage_cpi_credit_report_index(1)
          ,Fields.InvalidMessage_cpi_education_seekers_index(1)
          ,Fields.InvalidMessage_cpi_insurance_index(1)
          ,Fields.InvalidMessage_cpi_insurance_health_index(1)
          ,Fields.InvalidMessage_cpi_insurance_auto_index(1)
          ,Fields.InvalidMessage_cpi_job_seekers_index(1)
          ,Fields.InvalidMessage_cpi_social_networking_index(1)
          ,Fields.InvalidMessage_cpi_adult_index(1)
          ,Fields.InvalidMessage_cpi_africanamerican_index(1)
          ,Fields.InvalidMessage_cpi_apparel_index(1)
          ,Fields.InvalidMessage_cpi_apparel_accessory_index(1)
          ,Fields.InvalidMessage_cpi_apparel_kids_index(1)
          ,Fields.InvalidMessage_cpi_apparel_men_index(1)
          ,Fields.InvalidMessage_cpi_apparel_menfash_index(1)
          ,Fields.InvalidMessage_cpi_apparel_women_index(1)
          ,Fields.InvalidMessage_cpi_apparel_womfash_index(1)
          ,Fields.InvalidMessage_cpi_asian_index(1)
          ,Fields.InvalidMessage_cpi_auto_index(1)
          ,Fields.InvalidMessage_cpi_auto_racing_index(1)
          ,Fields.InvalidMessage_cpi_auto_trucks_index(1)
          ,Fields.InvalidMessage_cpi_aviation_index(1)
          ,Fields.InvalidMessage_cpi_bargains_index(1)
          ,Fields.InvalidMessage_cpi_beauty_index(1)
          ,Fields.InvalidMessage_cpi_bible_index(1)
          ,Fields.InvalidMessage_cpi_birds_index(1)
          ,Fields.InvalidMessage_cpi_business_index(1)
          ,Fields.InvalidMessage_cpi_business_homeoffice_index(1)
          ,Fields.InvalidMessage_cpi_catalog_index(1)
          ,Fields.InvalidMessage_cpi_cc_index(1)
          ,Fields.InvalidMessage_cpi_collectibles_index(1)
          ,Fields.InvalidMessage_cpi_college_index(1)
          ,Fields.InvalidMessage_cpi_computers_index(1)
          ,Fields.InvalidMessage_cpi_conservative_index(1)
          ,Fields.InvalidMessage_cpi_continuity_index(1)
          ,Fields.InvalidMessage_cpi_cooking_index(1)
          ,Fields.InvalidMessage_cpi_crafts_index(1)
          ,Fields.InvalidMessage_cpi_crafts_crochet_index(1)
          ,Fields.InvalidMessage_cpi_crafts_knit_index(1)
          ,Fields.InvalidMessage_cpi_crafts_needlepoint_index(1)
          ,Fields.InvalidMessage_cpi_crafts_quilt_index(1)
          ,Fields.InvalidMessage_cpi_crafts_sew_index(1)
          ,Fields.InvalidMessage_cpi_culturearts_index(1)
          ,Fields.InvalidMessage_cpi_currevent_index(1)
          ,Fields.InvalidMessage_cpi_diy_index(1)
          ,Fields.InvalidMessage_cpi_donor_index(1)
          ,Fields.InvalidMessage_cpi_ego_index(1)
          ,Fields.InvalidMessage_cpi_electronics_index(1)
          ,Fields.InvalidMessage_cpi_equestrian_index(1)
          ,Fields.InvalidMessage_cpi_family_index(1)
          ,Fields.InvalidMessage_cpi_family_teen_index(1)
          ,Fields.InvalidMessage_cpi_family_young_index(1)
          ,Fields.InvalidMessage_cpi_fiction_index(1)
          ,Fields.InvalidMessage_cpi_gambling_index(1)
          ,Fields.InvalidMessage_cpi_games_index(1)
          ,Fields.InvalidMessage_cpi_gardening_index(1)
          ,Fields.InvalidMessage_cpi_gay_index(1)
          ,Fields.InvalidMessage_cpi_giftgivr_index(1)
          ,Fields.InvalidMessage_cpi_gourmet_index(1)
          ,Fields.InvalidMessage_cpi_grandparents_index(1)
          ,Fields.InvalidMessage_cpi_health_index(1)
          ,Fields.InvalidMessage_cpi_health_diet_index(1)
          ,Fields.InvalidMessage_cpi_health_fitness_index(1)
          ,Fields.InvalidMessage_cpi_hightech_index(1)
          ,Fields.InvalidMessage_cpi_hispanic_index(1)
          ,Fields.InvalidMessage_cpi_history_index(1)
          ,Fields.InvalidMessage_cpi_history_american_index(1)
          ,Fields.InvalidMessage_cpi_hobbies_index(1)
          ,Fields.InvalidMessage_cpi_homedecr_index(1)
          ,Fields.InvalidMessage_cpi_homeliv_index(1)
          ,Fields.InvalidMessage_cpi_humor_index(1)
          ,Fields.InvalidMessage_cpi_inspiration_index(1)
          ,Fields.InvalidMessage_cpi_internet_index(1)
          ,Fields.InvalidMessage_cpi_internet_access_index(1)
          ,Fields.InvalidMessage_cpi_internet_buy_index(1)
          ,Fields.InvalidMessage_cpi_liberal_index(1)
          ,Fields.InvalidMessage_cpi_moneymaking_index(1)
          ,Fields.InvalidMessage_cpi_motorcycles_index(1)
          ,Fields.InvalidMessage_cpi_music_index(1)
          ,Fields.InvalidMessage_cpi_nonfiction_index(1)
          ,Fields.InvalidMessage_cpi_ocean_index(1)
          ,Fields.InvalidMessage_cpi_outdoors_index(1)
          ,Fields.InvalidMessage_cpi_outdoors_boatsail_index(1)
          ,Fields.InvalidMessage_cpi_outdoors_camp_index(1)
          ,Fields.InvalidMessage_cpi_outdoors_fishing_index(1)
          ,Fields.InvalidMessage_cpi_outdoors_huntfish_index(1)
          ,Fields.InvalidMessage_cpi_outdoors_hunting_index(1)
          ,Fields.InvalidMessage_cpi_pets_index(1)
          ,Fields.InvalidMessage_cpi_pets_cats_index(1)
          ,Fields.InvalidMessage_cpi_pets_dogs_index(1)
          ,Fields.InvalidMessage_cpi_pfin_index(1)
          ,Fields.InvalidMessage_cpi_photog_index(1)
          ,Fields.InvalidMessage_cpi_photoproc_index(1)
          ,Fields.InvalidMessage_cpi_publish_index(1)
          ,Fields.InvalidMessage_cpi_publish_books_index(1)
          ,Fields.InvalidMessage_cpi_publish_mags_index(1)
          ,Fields.InvalidMessage_cpi_rural_index(1)
          ,Fields.InvalidMessage_cpi_science_index(1)
          ,Fields.InvalidMessage_cpi_scifi_index(1)
          ,Fields.InvalidMessage_cpi_seniors_index(1)
          ,Fields.InvalidMessage_cpi_sports_index(1)
          ,Fields.InvalidMessage_cpi_sports_baseball_index(1)
          ,Fields.InvalidMessage_cpi_sports_basketball_index(1)
          ,Fields.InvalidMessage_cpi_sports_biking_index(1)
          ,Fields.InvalidMessage_cpi_sports_football_index(1)
          ,Fields.InvalidMessage_cpi_sports_golf_index(1)
          ,Fields.InvalidMessage_cpi_sports_hockey_index(1)
          ,Fields.InvalidMessage_cpi_sports_running_index(1)
          ,Fields.InvalidMessage_cpi_sports_ski_index(1)
          ,Fields.InvalidMessage_cpi_sports_soccer_index(1)
          ,Fields.InvalidMessage_cpi_sports_swimming_index(1)
          ,Fields.InvalidMessage_cpi_sports_tennis_index(1)
          ,Fields.InvalidMessage_cpi_stationery_index(1)
          ,Fields.InvalidMessage_cpi_sweeps_index(1)
          ,Fields.InvalidMessage_cpi_tobacco_index(1)
          ,Fields.InvalidMessage_cpi_travel_index(1)
          ,Fields.InvalidMessage_cpi_travel_cruise_index(1)
          ,Fields.InvalidMessage_cpi_travel_rv_index(1)
          ,Fields.InvalidMessage_cpi_travel_us_index(1)
          ,Fields.InvalidMessage_cpi_tvmovies_index(1)
          ,Fields.InvalidMessage_cpi_wildlife_index(1)
          ,Fields.InvalidMessage_cpi_woman_index(1)
          ,Fields.InvalidMessage_totdlr_index(1)
          ,Fields.InvalidMessage_cpi_totdlr(1)
          ,Fields.InvalidMessage_cpi_totords(1)
          ,Fields.InvalidMessage_cpi_lastdlr(1)
          ,Fields.InvalidMessage_pkcatg(1)
          ,Fields.InvalidMessage_pkpubs(1)
          ,Fields.InvalidMessage_pkcont(1)
          ,Fields.InvalidMessage_pkca01(1)
          ,Fields.InvalidMessage_pkca03(1)
          ,Fields.InvalidMessage_pkca04(1)
          ,Fields.InvalidMessage_pkca05(1)
          ,Fields.InvalidMessage_pkca06(1)
          ,Fields.InvalidMessage_pkca07(1)
          ,Fields.InvalidMessage_pkca08(1)
          ,Fields.InvalidMessage_pkca09(1)
          ,Fields.InvalidMessage_pkca10(1)
          ,Fields.InvalidMessage_pkca11(1)
          ,Fields.InvalidMessage_pkca12(1)
          ,Fields.InvalidMessage_pkca13(1)
          ,Fields.InvalidMessage_pkca14(1)
          ,Fields.InvalidMessage_pkca15(1)
          ,Fields.InvalidMessage_pkca16(1)
          ,Fields.InvalidMessage_pkca17(1)
          ,Fields.InvalidMessage_pkca18(1)
          ,Fields.InvalidMessage_pkca20(1)
          ,Fields.InvalidMessage_pkca21(1)
          ,Fields.InvalidMessage_pkca22(1)
          ,Fields.InvalidMessage_pkca23(1)
          ,Fields.InvalidMessage_pkca24(1)
          ,Fields.InvalidMessage_pkca25(1)
          ,Fields.InvalidMessage_pkca26(1)
          ,Fields.InvalidMessage_pkca28(1)
          ,Fields.InvalidMessage_pkca29(1)
          ,Fields.InvalidMessage_pkca30(1)
          ,Fields.InvalidMessage_pkca31(1)
          ,Fields.InvalidMessage_pkca32(1)
          ,Fields.InvalidMessage_pkca33(1)
          ,Fields.InvalidMessage_pkca34(1)
          ,Fields.InvalidMessage_pkca35(1)
          ,Fields.InvalidMessage_pkca36(1)
          ,Fields.InvalidMessage_pkca37(1)
          ,Fields.InvalidMessage_pkca39(1)
          ,Fields.InvalidMessage_pkca40(1)
          ,Fields.InvalidMessage_pkca41(1)
          ,Fields.InvalidMessage_pkca42(1)
          ,Fields.InvalidMessage_pkca54(1)
          ,Fields.InvalidMessage_pkca61(1)
          ,Fields.InvalidMessage_pkca62(1)
          ,Fields.InvalidMessage_pkca64(1)
          ,Fields.InvalidMessage_pkpu01(1)
          ,Fields.InvalidMessage_pkpu02(1)
          ,Fields.InvalidMessage_pkpu03(1)
          ,Fields.InvalidMessage_pkpu04(1)
          ,Fields.InvalidMessage_pkpu05(1)
          ,Fields.InvalidMessage_pkpu06(1)
          ,Fields.InvalidMessage_pkpu07(1)
          ,Fields.InvalidMessage_pkpu08(1)
          ,Fields.InvalidMessage_pkpu09(1)
          ,Fields.InvalidMessage_pkpu10(1)
          ,Fields.InvalidMessage_pkpu11(1)
          ,Fields.InvalidMessage_pkpu12(1)
          ,Fields.InvalidMessage_pkpu13(1)
          ,Fields.InvalidMessage_pkpu14(1)
          ,Fields.InvalidMessage_pkpu15(1)
          ,Fields.InvalidMessage_pkpu16(1)
          ,Fields.InvalidMessage_pkpu17(1)
          ,Fields.InvalidMessage_pkpu18(1)
          ,Fields.InvalidMessage_pkpu19(1)
          ,Fields.InvalidMessage_pkpu20(1)
          ,Fields.InvalidMessage_pkpu23(1)
          ,Fields.InvalidMessage_pkpu25(1)
          ,Fields.InvalidMessage_pkpu27(1)
          ,Fields.InvalidMessage_pkpu28(1)
          ,Fields.InvalidMessage_pkpu29(1)
          ,Fields.InvalidMessage_pkpu30(1)
          ,Fields.InvalidMessage_pkpu31(1)
          ,Fields.InvalidMessage_pkpu32(1)
          ,Fields.InvalidMessage_pkpu33(1)
          ,Fields.InvalidMessage_pkpu34(1)
          ,Fields.InvalidMessage_pkpu35(1)
          ,Fields.InvalidMessage_pkpu38(1)
          ,Fields.InvalidMessage_pkpu41(1)
          ,Fields.InvalidMessage_pkpu42(1)
          ,Fields.InvalidMessage_pkpu45(1)
          ,Fields.InvalidMessage_pkpu46(1)
          ,Fields.InvalidMessage_pkpu47(1)
          ,Fields.InvalidMessage_pkpu48(1)
          ,Fields.InvalidMessage_pkpu49(1)
          ,Fields.InvalidMessage_pkpu50(1)
          ,Fields.InvalidMessage_pkpu51(1)
          ,Fields.InvalidMessage_pkpu52(1)
          ,Fields.InvalidMessage_pkpu53(1)
          ,Fields.InvalidMessage_pkpu54(1)
          ,Fields.InvalidMessage_pkpu55(1)
          ,Fields.InvalidMessage_pkpu56(1)
          ,Fields.InvalidMessage_pkpu57(1)
          ,Fields.InvalidMessage_pkpu60(1)
          ,Fields.InvalidMessage_pkpu61(1)
          ,Fields.InvalidMessage_pkpu62(1)
          ,Fields.InvalidMessage_pkpu63(1)
          ,Fields.InvalidMessage_pkpu64(1)
          ,Fields.InvalidMessage_pkpu65(1)
          ,Fields.InvalidMessage_pkpu66(1)
          ,Fields.InvalidMessage_pkpu67(1)
          ,Fields.InvalidMessage_pkpu68(1)
          ,Fields.InvalidMessage_pkpu69(1)
          ,Fields.InvalidMessage_pkpu70(1)
          ,Fields.InvalidMessage_censpct_water(1)
          ,Fields.InvalidMessage_cens_pop_density(1)
          ,Fields.InvalidMessage_cens_hu_density(1)
          ,Fields.InvalidMessage_censpct_pop_white(1)
          ,Fields.InvalidMessage_censpct_pop_black(1)
          ,Fields.InvalidMessage_censpct_pop_amerind(1)
          ,Fields.InvalidMessage_censpct_pop_asian(1)
          ,Fields.InvalidMessage_censpct_pop_pacisl(1)
          ,Fields.InvalidMessage_censpct_pop_othrace(1)
          ,Fields.InvalidMessage_censpct_pop_multirace(1)
          ,Fields.InvalidMessage_censpct_pop_hispanic(1)
          ,Fields.InvalidMessage_censpct_pop_agelt18(1)
          ,Fields.InvalidMessage_censpct_pop_males(1)
          ,Fields.InvalidMessage_censpct_adult_age1824(1)
          ,Fields.InvalidMessage_censpct_adult_age2534(1)
          ,Fields.InvalidMessage_censpct_adult_age3544(1)
          ,Fields.InvalidMessage_censpct_adult_age4554(1)
          ,Fields.InvalidMessage_censpct_adult_age5564(1)
          ,Fields.InvalidMessage_censpct_adult_agege65(1)
          ,Fields.InvalidMessage_cens_pop_medage(1)
          ,Fields.InvalidMessage_cens_hh_avgsize(1)
          ,Fields.InvalidMessage_censpct_hh_family(1)
          ,Fields.InvalidMessage_censpct_hh_family_husbwife(1)
          ,Fields.InvalidMessage_censpct_hu_occupied(1)
          ,Fields.InvalidMessage_censpct_hu_owned(1)
          ,Fields.InvalidMessage_censpct_hu_rented(1)
          ,Fields.InvalidMessage_censpct_hu_vacantseasonal(1)
          ,Fields.InvalidMessage_zip_medinc(1)
          ,Fields.InvalidMessage_zip_apparel(1)
          ,Fields.InvalidMessage_zip_apparel_women(1)
          ,Fields.InvalidMessage_zip_apparel_womfash(1)
          ,Fields.InvalidMessage_zip_auto(1)
          ,Fields.InvalidMessage_zip_beauty(1)
          ,Fields.InvalidMessage_zip_booksmusicmovies(1)
          ,Fields.InvalidMessage_zip_business(1)
          ,Fields.InvalidMessage_zip_catalog(1)
          ,Fields.InvalidMessage_zip_cc(1)
          ,Fields.InvalidMessage_zip_collectibles(1)
          ,Fields.InvalidMessage_zip_computers(1)
          ,Fields.InvalidMessage_zip_continuity(1)
          ,Fields.InvalidMessage_zip_cooking(1)
          ,Fields.InvalidMessage_zip_crafts(1)
          ,Fields.InvalidMessage_zip_culturearts(1)
          ,Fields.InvalidMessage_zip_dm_sold(1)
          ,Fields.InvalidMessage_zip_donor(1)
          ,Fields.InvalidMessage_zip_family(1)
          ,Fields.InvalidMessage_zip_gardening(1)
          ,Fields.InvalidMessage_zip_giftgivr(1)
          ,Fields.InvalidMessage_zip_gourmet(1)
          ,Fields.InvalidMessage_zip_health(1)
          ,Fields.InvalidMessage_zip_health_diet(1)
          ,Fields.InvalidMessage_zip_health_fitness(1)
          ,Fields.InvalidMessage_zip_hobbies(1)
          ,Fields.InvalidMessage_zip_homedecr(1)
          ,Fields.InvalidMessage_zip_homeliv(1)
          ,Fields.InvalidMessage_zip_internet(1)
          ,Fields.InvalidMessage_zip_internet_access(1)
          ,Fields.InvalidMessage_zip_internet_buy(1)
          ,Fields.InvalidMessage_zip_music(1)
          ,Fields.InvalidMessage_zip_outdoors(1)
          ,Fields.InvalidMessage_zip_pets(1)
          ,Fields.InvalidMessage_zip_pfin(1)
          ,Fields.InvalidMessage_zip_publish(1)
          ,Fields.InvalidMessage_zip_publish_books(1)
          ,Fields.InvalidMessage_zip_publish_mags(1)
          ,Fields.InvalidMessage_zip_sports(1)
          ,Fields.InvalidMessage_zip_sports_biking(1)
          ,Fields.InvalidMessage_zip_sports_golf(1)
          ,Fields.InvalidMessage_zip_travel(1)
          ,Fields.InvalidMessage_zip_travel_us(1)
          ,Fields.InvalidMessage_zip_tvmovies(1)
          ,Fields.InvalidMessage_zip_woman(1)
          ,Fields.InvalidMessage_zip_proftech(1)
          ,Fields.InvalidMessage_zip_retired(1)
          ,Fields.InvalidMessage_zip_inc100(1)
          ,Fields.InvalidMessage_zip_inc75(1)
          ,Fields.InvalidMessage_zip_inc50(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors'
          ,'Edited records'
          ,'Rules leading to edits','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.dtmatch_ALLOW_ErrorCount,le.dtmatch_LENGTHS_ErrorCount
          ,le.msname_ALLOW_ErrorCount
          ,le.msaddr1_ALLOW_ErrorCount
          ,le.msaddr2_ALLOW_ErrorCount
          ,le.mscity_ALLOW_ErrorCount,le.mscity_LENGTHS_ErrorCount
          ,le.msstate_ALLOW_ErrorCount,le.msstate_LENGTHS_ErrorCount,le.msstate_WORDS_ErrorCount
          ,le.mszip5_ALLOW_ErrorCount,le.mszip5_LENGTHS_ErrorCount
          ,le.mszip4_ALLOW_ErrorCount,le.mszip4_LENGTHS_ErrorCount
          ,le.dthh_ALLOW_ErrorCount,le.dthh_LENGTHS_ErrorCount
          ,le.mscrrt_ALLOW_ErrorCount,le.mscrrt_LENGTHS_ErrorCount
          ,le.msdpbc_ALLOW_ErrorCount,le.msdpbc_LENGTHS_ErrorCount
          ,le.msdpv_ALLOW_ErrorCount,le.msdpv_LENGTHS_ErrorCount
          ,le.ms_addrtype_ALLOW_ErrorCount,le.ms_addrtype_LENGTHS_ErrorCount
          ,le.ctysize_ALLOW_ErrorCount,le.ctysize_LENGTHS_ErrorCount
          ,le.lmos_ALLOW_ErrorCount
          ,le.omos_ALLOW_ErrorCount
          ,le.pmos_ALLOW_ErrorCount
          ,le.gen_ENUM_ErrorCount,le.gen_LENGTHS_ErrorCount
          ,le.dob_CUSTOM_ErrorCount
          ,le.age_ALLOW_ErrorCount
          ,le.inc_ENUM_ErrorCount,le.inc_LENGTHS_ErrorCount
          ,le.marital_status_ALLOW_ErrorCount
          ,le.poc_ALLOW_ErrorCount
          ,le.noc_ALLOW_ErrorCount,le.noc_LENGTHS_ErrorCount
          ,le.ocp_ENUM_ErrorCount,le.ocp_LENGTHS_ErrorCount
          ,le.edu_ENUM_ErrorCount,le.edu_LENGTHS_ErrorCount
          ,le.lang_ALLOW_ErrorCount,le.lang_LENGTHS_ErrorCount
          ,le.relig_ENUM_ErrorCount,le.relig_LENGTHS_ErrorCount
          ,le.dwell_ENUM_ErrorCount,le.dwell_LENGTHS_ErrorCount
          ,le.ownr_ALLOW_ErrorCount
          ,le.eth1_ALLOW_ErrorCount,le.eth1_LENGTHS_ErrorCount
          ,le.eth2_ALLOW_ErrorCount,le.eth2_LENGTHS_ErrorCount
          ,le.lor_ALLOW_ErrorCount,le.lor_LENGTHS_ErrorCount
          ,le.pool_ALLOW_ErrorCount,le.pool_LENGTHS_ErrorCount
          ,le.speak_span_ALLOW_ErrorCount,le.speak_span_LENGTHS_ErrorCount
          ,le.soho_ALLOW_ErrorCount,le.soho_LENGTHS_ErrorCount
          ,le.vet_in_hh_ALLOW_ErrorCount,le.vet_in_hh_LENGTHS_ErrorCount
          ,le.ms_mags_ALLOW_ErrorCount
          ,le.ms_books_ALLOW_ErrorCount
          ,le.ms_publish_ALLOW_ErrorCount
          ,le.ms_pub_status_active_ALLOW_ErrorCount
          ,le.ms_pub_status_expire_ALLOW_ErrorCount
          ,le.ms_pub_premsold_ALLOW_ErrorCount
          ,le.ms_pub_autornwl_ALLOW_ErrorCount
          ,le.ms_pub_avgterm_ALLOW_ErrorCount
          ,le.ms_pub_lmos_ALLOW_ErrorCount
          ,le.ms_pub_omos_ALLOW_ErrorCount
          ,le.ms_pub_pmos_ALLOW_ErrorCount
          ,le.ms_pub_cemos_ALLOW_ErrorCount
          ,le.ms_pub_femos_ALLOW_ErrorCount
          ,le.ms_pub_totords_ALLOW_ErrorCount
          ,le.ms_pub_totdlrs_ALLOW_ErrorCount
          ,le.ms_pub_avgdlrs_ALLOW_ErrorCount
          ,le.ms_pub_lastdlrs_ALLOW_ErrorCount
          ,le.ms_pub_paystat_paid_ALLOW_ErrorCount
          ,le.ms_pub_paystat_ub_ALLOW_ErrorCount
          ,le.ms_pub_paymeth_cc_ALLOW_ErrorCount
          ,le.ms_pub_paymeth_cash_ALLOW_ErrorCount
          ,le.ms_pub_payspeed_ALLOW_ErrorCount
          ,le.ms_pub_osrc_dm_ALLOW_ErrorCount
          ,le.ms_pub_lsrc_dm_ALLOW_ErrorCount
          ,le.ms_pub_osrc_agt_cashf_ALLOW_ErrorCount
          ,le.ms_pub_lsrc_agt_cashf_ALLOW_ErrorCount
          ,le.ms_pub_osrc_agt_pds_ALLOW_ErrorCount
          ,le.ms_pub_lsrc_agt_pds_ALLOW_ErrorCount
          ,le.ms_pub_osrc_agt_schplan_ALLOW_ErrorCount
          ,le.ms_pub_lsrc_agt_schplan_ALLOW_ErrorCount
          ,le.ms_pub_osrc_agt_sponsor_ALLOW_ErrorCount
          ,le.ms_pub_lsrc_agt_sponsor_ALLOW_ErrorCount
          ,le.ms_pub_osrc_agt_tm_ALLOW_ErrorCount
          ,le.ms_pub_lsrc_agt_tm_ALLOW_ErrorCount
          ,le.ms_pub_osrc_agt_ALLOW_ErrorCount
          ,le.ms_pub_lsrc_agt_ALLOW_ErrorCount
          ,le.ms_pub_osrc_tm_ALLOW_ErrorCount
          ,le.ms_pub_lsrc_tm_ALLOW_ErrorCount
          ,le.ms_pub_osrc_ins_ALLOW_ErrorCount
          ,le.ms_pub_lsrc_ins_ALLOW_ErrorCount
          ,le.ms_pub_osrc_net_ALLOW_ErrorCount
          ,le.ms_pub_lsrc_net_ALLOW_ErrorCount
          ,le.ms_pub_osrc_print_ALLOW_ErrorCount
          ,le.ms_pub_lsrc_print_ALLOW_ErrorCount
          ,le.ms_pub_osrc_trans_ALLOW_ErrorCount
          ,le.ms_pub_lsrc_trans_ALLOW_ErrorCount
          ,le.ms_pub_osrc_tv_ALLOW_ErrorCount
          ,le.ms_pub_lsrc_tv_ALLOW_ErrorCount
          ,le.ms_pub_osrc_dtp_ALLOW_ErrorCount
          ,le.ms_pub_lsrc_dtp_ALLOW_ErrorCount
          ,le.ms_pub_giftgivr_ALLOW_ErrorCount
          ,le.ms_pub_giftee_ALLOW_ErrorCount
          ,le.ms_catalog_ALLOW_ErrorCount
          ,le.ms_cat_lmos_ALLOW_ErrorCount
          ,le.ms_cat_omos_ALLOW_ErrorCount
          ,le.ms_cat_pmos_ALLOW_ErrorCount
          ,le.ms_cat_totords_ALLOW_ErrorCount
          ,le.ms_cat_totitems_ALLOW_ErrorCount
          ,le.ms_cat_totdlrs_ALLOW_ErrorCount
          ,le.ms_cat_avgdlrs_ALLOW_ErrorCount
          ,le.ms_cat_lastdlrs_ALLOW_ErrorCount
          ,le.ms_cat_paystat_paid_ALLOW_ErrorCount
          ,le.ms_cat_paymeth_cc_ALLOW_ErrorCount
          ,le.ms_cat_paymeth_cash_ALLOW_ErrorCount
          ,le.ms_cat_osrc_dm_ALLOW_ErrorCount
          ,le.ms_cat_lsrc_dm_ALLOW_ErrorCount
          ,le.ms_cat_osrc_net_ALLOW_ErrorCount
          ,le.ms_cat_lsrc_net_ALLOW_ErrorCount
          ,le.ms_cat_giftgivr_ALLOW_ErrorCount
          ,le.pkpubs_corrected_ALLOW_ErrorCount
          ,le.pkcatg_corrected_ALLOW_ErrorCount
          ,le.ms_fundraising_ALLOW_ErrorCount
          ,le.ms_fund_lmos_ALLOW_ErrorCount
          ,le.ms_fund_omos_ALLOW_ErrorCount
          ,le.ms_fund_pmos_ALLOW_ErrorCount
          ,le.ms_fund_totords_ALLOW_ErrorCount
          ,le.ms_fund_totdlrs_ALLOW_ErrorCount
          ,le.ms_fund_avgdlrs_ALLOW_ErrorCount
          ,le.ms_fund_lastdlrs_ALLOW_ErrorCount
          ,le.ms_fund_paystat_paid_ALLOW_ErrorCount
          ,le.ms_other_ALLOW_ErrorCount
          ,le.ms_continuity_ALLOW_ErrorCount
          ,le.ms_cont_status_active_ALLOW_ErrorCount
          ,le.ms_cont_status_cancel_ALLOW_ErrorCount
          ,le.ms_cont_omos_ALLOW_ErrorCount
          ,le.ms_cont_lmos_ALLOW_ErrorCount
          ,le.ms_cont_pmos_ALLOW_ErrorCount
          ,le.ms_cont_totords_ALLOW_ErrorCount
          ,le.ms_cont_totdlrs_ALLOW_ErrorCount
          ,le.ms_cont_avgdlrs_ALLOW_ErrorCount
          ,le.ms_cont_lastdlrs_ALLOW_ErrorCount
          ,le.ms_cont_paystat_paid_ALLOW_ErrorCount
          ,le.ms_cont_paymeth_cc_ALLOW_ErrorCount
          ,le.ms_cont_paymeth_cash_ALLOW_ErrorCount
          ,le.ms_totords_ALLOW_ErrorCount
          ,le.ms_totitems_ALLOW_ErrorCount
          ,le.ms_totdlrs_ALLOW_ErrorCount
          ,le.ms_avgdlrs_ALLOW_ErrorCount
          ,le.ms_lastdlrs_ALLOW_ErrorCount
          ,le.ms_paystat_paid_ALLOW_ErrorCount
          ,le.ms_paymeth_cc_ALLOW_ErrorCount
          ,le.ms_paymeth_cash_ALLOW_ErrorCount
          ,le.ms_osrc_dm_ALLOW_ErrorCount
          ,le.ms_lsrc_dm_ALLOW_ErrorCount
          ,le.ms_osrc_tm_ALLOW_ErrorCount
          ,le.ms_lsrc_tm_ALLOW_ErrorCount
          ,le.ms_osrc_ins_ALLOW_ErrorCount
          ,le.ms_lsrc_ins_ALLOW_ErrorCount
          ,le.ms_osrc_net_ALLOW_ErrorCount
          ,le.ms_lsrc_net_ALLOW_ErrorCount
          ,le.ms_osrc_tv_ALLOW_ErrorCount
          ,le.ms_lsrc_tv_ALLOW_ErrorCount
          ,le.ms_osrc_retail_ALLOW_ErrorCount
          ,le.ms_lsrc_retail_ALLOW_ErrorCount
          ,le.ms_giftgivr_ALLOW_ErrorCount
          ,le.ms_giftee_ALLOW_ErrorCount
          ,le.ms_adult_ALLOW_ErrorCount
          ,le.ms_womapp_ALLOW_ErrorCount
          ,le.ms_menapp_ALLOW_ErrorCount
          ,le.ms_kidapp_ALLOW_ErrorCount
          ,le.ms_accessory_ALLOW_ErrorCount
          ,le.ms_apparel_ALLOW_ErrorCount
          ,le.ms_app_lmos_ALLOW_ErrorCount
          ,le.ms_app_omos_ALLOW_ErrorCount
          ,le.ms_app_pmos_ALLOW_ErrorCount
          ,le.ms_app_totords_ALLOW_ErrorCount
          ,le.ms_app_totitems_ALLOW_ErrorCount
          ,le.ms_app_totdlrs_ALLOW_ErrorCount
          ,le.ms_app_avgdlrs_ALLOW_ErrorCount
          ,le.ms_app_lastdlrs_ALLOW_ErrorCount
          ,le.ms_app_paystat_paid_ALLOW_ErrorCount
          ,le.ms_app_paymeth_cc_ALLOW_ErrorCount
          ,le.ms_app_paymeth_cash_ALLOW_ErrorCount
          ,le.ms_menfash_ALLOW_ErrorCount
          ,le.ms_womfash_ALLOW_ErrorCount
          ,le.ms_wfsh_lmos_ALLOW_ErrorCount
          ,le.ms_wfsh_omos_ALLOW_ErrorCount
          ,le.ms_wfsh_pmos_ALLOW_ErrorCount
          ,le.ms_wfsh_totords_ALLOW_ErrorCount
          ,le.ms_wfsh_totdlrs_ALLOW_ErrorCount
          ,le.ms_wfsh_avgdlrs_ALLOW_ErrorCount
          ,le.ms_wfsh_lastdlrs_ALLOW_ErrorCount
          ,le.ms_wfsh_paystat_paid_ALLOW_ErrorCount
          ,le.ms_wfsh_osrc_dm_ALLOW_ErrorCount
          ,le.ms_wfsh_lsrc_dm_ALLOW_ErrorCount
          ,le.ms_wfsh_osrc_agt_ALLOW_ErrorCount
          ,le.ms_wfsh_lsrc_agt_ALLOW_ErrorCount
          ,le.ms_audio_ALLOW_ErrorCount
          ,le.ms_auto_ALLOW_ErrorCount
          ,le.ms_aviation_ALLOW_ErrorCount
          ,le.ms_bargains_ALLOW_ErrorCount
          ,le.ms_beauty_ALLOW_ErrorCount
          ,le.ms_bible_ALLOW_ErrorCount
          ,le.ms_bible_lmos_ALLOW_ErrorCount
          ,le.ms_bible_omos_ALLOW_ErrorCount
          ,le.ms_bible_pmos_ALLOW_ErrorCount
          ,le.ms_bible_totords_ALLOW_ErrorCount
          ,le.ms_bible_totitems_ALLOW_ErrorCount
          ,le.ms_bible_totdlrs_ALLOW_ErrorCount
          ,le.ms_bible_avgdlrs_ALLOW_ErrorCount
          ,le.ms_bible_lastdlrs_ALLOW_ErrorCount
          ,le.ms_bible_paystat_paid_ALLOW_ErrorCount
          ,le.ms_bible_paymeth_cc_ALLOW_ErrorCount
          ,le.ms_bible_paymeth_cash_ALLOW_ErrorCount
          ,le.ms_business_ALLOW_ErrorCount
          ,le.ms_collectibles_ALLOW_ErrorCount
          ,le.ms_computers_ALLOW_ErrorCount
          ,le.ms_crafts_ALLOW_ErrorCount
          ,le.ms_culturearts_ALLOW_ErrorCount
          ,le.ms_currevent_ALLOW_ErrorCount
          ,le.ms_diy_ALLOW_ErrorCount
          ,le.ms_electronics_ALLOW_ErrorCount
          ,le.ms_equestrian_ALLOW_ErrorCount
          ,le.ms_pub_family_ALLOW_ErrorCount
          ,le.ms_cat_family_ALLOW_ErrorCount
          ,le.ms_family_ALLOW_ErrorCount
          ,le.ms_family_lmos_ALLOW_ErrorCount
          ,le.ms_family_omos_ALLOW_ErrorCount
          ,le.ms_family_pmos_ALLOW_ErrorCount
          ,le.ms_family_totords_ALLOW_ErrorCount
          ,le.ms_family_totitems_ALLOW_ErrorCount
          ,le.ms_family_totdlrs_ALLOW_ErrorCount
          ,le.ms_family_avgdlrs_ALLOW_ErrorCount
          ,le.ms_family_lastdlrs_ALLOW_ErrorCount
          ,le.ms_family_paystat_paid_ALLOW_ErrorCount
          ,le.ms_family_paymeth_cc_ALLOW_ErrorCount
          ,le.ms_family_paymeth_cash_ALLOW_ErrorCount
          ,le.ms_family_osrc_dm_ALLOW_ErrorCount
          ,le.ms_family_lsrc_dm_ALLOW_ErrorCount
          ,le.ms_fiction_ALLOW_ErrorCount
          ,le.ms_food_ALLOW_ErrorCount
          ,le.ms_games_ALLOW_ErrorCount
          ,le.ms_gifts_ALLOW_ErrorCount
          ,le.ms_gourmet_ALLOW_ErrorCount
          ,le.ms_fitness_ALLOW_ErrorCount
          ,le.ms_health_ALLOW_ErrorCount
          ,le.ms_hlth_lmos_ALLOW_ErrorCount
          ,le.ms_hlth_omos_ALLOW_ErrorCount
          ,le.ms_hlth_pmos_ALLOW_ErrorCount
          ,le.ms_hlth_totords_ALLOW_ErrorCount
          ,le.ms_hlth_totdlrs_ALLOW_ErrorCount
          ,le.ms_hlth_avgdlrs_ALLOW_ErrorCount
          ,le.ms_hlth_lastdlrs_ALLOW_ErrorCount
          ,le.ms_hlth_paystat_paid_ALLOW_ErrorCount
          ,le.ms_hlth_paymeth_cc_ALLOW_ErrorCount
          ,le.ms_hlth_osrc_dm_ALLOW_ErrorCount
          ,le.ms_hlth_lsrc_dm_ALLOW_ErrorCount
          ,le.ms_hlth_osrc_agt_ALLOW_ErrorCount
          ,le.ms_hlth_lsrc_agt_ALLOW_ErrorCount
          ,le.ms_hlth_osrc_tv_ALLOW_ErrorCount
          ,le.ms_hlth_lsrc_tv_ALLOW_ErrorCount
          ,le.ms_holiday_ALLOW_ErrorCount
          ,le.ms_history_ALLOW_ErrorCount
          ,le.ms_pub_cooking_ALLOW_ErrorCount
          ,le.ms_cooking_ALLOW_ErrorCount
          ,le.ms_pub_homedecr_ALLOW_ErrorCount
          ,le.ms_cat_homedecr_ALLOW_ErrorCount
          ,le.ms_homedecr_ALLOW_ErrorCount
          ,le.ms_housewares_ALLOW_ErrorCount
          ,le.ms_pub_garden_ALLOW_ErrorCount
          ,le.ms_cat_garden_ALLOW_ErrorCount
          ,le.ms_garden_ALLOW_ErrorCount
          ,le.ms_pub_homeliv_ALLOW_ErrorCount
          ,le.ms_cat_homeliv_ALLOW_ErrorCount
          ,le.ms_homeliv_ALLOW_ErrorCount
          ,le.ms_pub_home_status_active_ALLOW_ErrorCount
          ,le.ms_home_lmos_ALLOW_ErrorCount
          ,le.ms_home_omos_ALLOW_ErrorCount
          ,le.ms_home_pmos_ALLOW_ErrorCount
          ,le.ms_home_totords_ALLOW_ErrorCount
          ,le.ms_home_totitems_ALLOW_ErrorCount
          ,le.ms_home_totdlrs_ALLOW_ErrorCount
          ,le.ms_home_avgdlrs_ALLOW_ErrorCount
          ,le.ms_home_lastdlrs_ALLOW_ErrorCount
          ,le.ms_home_paystat_paid_ALLOW_ErrorCount
          ,le.ms_home_paymeth_cc_ALLOW_ErrorCount
          ,le.ms_home_paymeth_cash_ALLOW_ErrorCount
          ,le.ms_home_osrc_dm_ALLOW_ErrorCount
          ,le.ms_home_lsrc_dm_ALLOW_ErrorCount
          ,le.ms_home_osrc_agt_ALLOW_ErrorCount
          ,le.ms_home_lsrc_agt_ALLOW_ErrorCount
          ,le.ms_home_osrc_net_ALLOW_ErrorCount
          ,le.ms_home_lsrc_net_ALLOW_ErrorCount
          ,le.ms_home_osrc_tv_ALLOW_ErrorCount
          ,le.ms_home_lsrc_tv_ALLOW_ErrorCount
          ,le.ms_humor_ALLOW_ErrorCount
          ,le.ms_inspiration_ALLOW_ErrorCount
          ,le.ms_merchandise_ALLOW_ErrorCount
          ,le.ms_moneymaking_ALLOW_ErrorCount
          ,le.ms_moneymaking_lmos_ALLOW_ErrorCount
          ,le.ms_motorcycles_ALLOW_ErrorCount
          ,le.ms_music_ALLOW_ErrorCount
          ,le.ms_fishing_ALLOW_ErrorCount
          ,le.ms_hunting_ALLOW_ErrorCount
          ,le.ms_boatsail_ALLOW_ErrorCount
          ,le.ms_camp_ALLOW_ErrorCount
          ,le.ms_pub_outdoors_ALLOW_ErrorCount
          ,le.ms_cat_outdoors_ALLOW_ErrorCount
          ,le.ms_outdoors_ALLOW_ErrorCount
          ,le.ms_pub_out_status_active_ALLOW_ErrorCount
          ,le.ms_out_lmos_ALLOW_ErrorCount
          ,le.ms_out_omos_ALLOW_ErrorCount
          ,le.ms_out_pmos_ALLOW_ErrorCount
          ,le.ms_out_totords_ALLOW_ErrorCount
          ,le.ms_out_totitems_ALLOW_ErrorCount
          ,le.ms_out_totdlrs_ALLOW_ErrorCount
          ,le.ms_out_avgdlrs_ALLOW_ErrorCount
          ,le.ms_out_lastdlrs_ALLOW_ErrorCount
          ,le.ms_out_paystat_paid_ALLOW_ErrorCount
          ,le.ms_out_paymeth_cc_ALLOW_ErrorCount
          ,le.ms_out_paymeth_cash_ALLOW_ErrorCount
          ,le.ms_out_osrc_dm_ALLOW_ErrorCount
          ,le.ms_out_lsrc_dm_ALLOW_ErrorCount
          ,le.ms_out_osrc_agt_ALLOW_ErrorCount
          ,le.ms_out_lsrc_agt_ALLOW_ErrorCount
          ,le.ms_pets_ALLOW_ErrorCount
          ,le.ms_pfin_ALLOW_ErrorCount
          ,le.ms_photo_ALLOW_ErrorCount
          ,le.ms_photoproc_ALLOW_ErrorCount
          ,le.ms_rural_ALLOW_ErrorCount
          ,le.ms_science_ALLOW_ErrorCount
          ,le.ms_sports_ALLOW_ErrorCount
          ,le.ms_sports_lmos_ALLOW_ErrorCount
          ,le.ms_travel_ALLOW_ErrorCount
          ,le.ms_tvmovies_ALLOW_ErrorCount
          ,le.ms_wildlife_ALLOW_ErrorCount
          ,le.ms_woman_ALLOW_ErrorCount
          ,le.ms_woman_lmos_ALLOW_ErrorCount
          ,le.ms_ringtones_apps_ALLOW_ErrorCount
          ,le.cpi_mobile_apps_index_ALLOW_ErrorCount
          ,le.cpi_credit_repair_index_ALLOW_ErrorCount
          ,le.cpi_credit_report_index_ALLOW_ErrorCount
          ,le.cpi_education_seekers_index_ALLOW_ErrorCount
          ,le.cpi_insurance_index_ALLOW_ErrorCount
          ,le.cpi_insurance_health_index_ALLOW_ErrorCount
          ,le.cpi_insurance_auto_index_ALLOW_ErrorCount
          ,le.cpi_job_seekers_index_ALLOW_ErrorCount
          ,le.cpi_social_networking_index_ALLOW_ErrorCount
          ,le.cpi_adult_index_ALLOW_ErrorCount
          ,le.cpi_africanamerican_index_ALLOW_ErrorCount
          ,le.cpi_apparel_index_ALLOW_ErrorCount
          ,le.cpi_apparel_accessory_index_ALLOW_ErrorCount
          ,le.cpi_apparel_kids_index_ALLOW_ErrorCount
          ,le.cpi_apparel_men_index_ALLOW_ErrorCount
          ,le.cpi_apparel_menfash_index_ALLOW_ErrorCount
          ,le.cpi_apparel_women_index_ALLOW_ErrorCount
          ,le.cpi_apparel_womfash_index_ALLOW_ErrorCount
          ,le.cpi_asian_index_ALLOW_ErrorCount
          ,le.cpi_auto_index_ALLOW_ErrorCount
          ,le.cpi_auto_racing_index_ALLOW_ErrorCount
          ,le.cpi_auto_trucks_index_ALLOW_ErrorCount
          ,le.cpi_aviation_index_ALLOW_ErrorCount
          ,le.cpi_bargains_index_ALLOW_ErrorCount
          ,le.cpi_beauty_index_ALLOW_ErrorCount
          ,le.cpi_bible_index_ALLOW_ErrorCount
          ,le.cpi_birds_index_ALLOW_ErrorCount
          ,le.cpi_business_index_ALLOW_ErrorCount
          ,le.cpi_business_homeoffice_index_ALLOW_ErrorCount
          ,le.cpi_catalog_index_ALLOW_ErrorCount
          ,le.cpi_cc_index_ALLOW_ErrorCount
          ,le.cpi_collectibles_index_ALLOW_ErrorCount
          ,le.cpi_college_index_ALLOW_ErrorCount
          ,le.cpi_computers_index_ALLOW_ErrorCount
          ,le.cpi_conservative_index_ALLOW_ErrorCount
          ,le.cpi_continuity_index_ALLOW_ErrorCount
          ,le.cpi_cooking_index_ALLOW_ErrorCount
          ,le.cpi_crafts_index_ALLOW_ErrorCount
          ,le.cpi_crafts_crochet_index_ALLOW_ErrorCount
          ,le.cpi_crafts_knit_index_ALLOW_ErrorCount
          ,le.cpi_crafts_needlepoint_index_ALLOW_ErrorCount
          ,le.cpi_crafts_quilt_index_ALLOW_ErrorCount
          ,le.cpi_crafts_sew_index_ALLOW_ErrorCount
          ,le.cpi_culturearts_index_ALLOW_ErrorCount
          ,le.cpi_currevent_index_ALLOW_ErrorCount
          ,le.cpi_diy_index_ALLOW_ErrorCount
          ,le.cpi_donor_index_ALLOW_ErrorCount
          ,le.cpi_ego_index_ALLOW_ErrorCount
          ,le.cpi_electronics_index_ALLOW_ErrorCount
          ,le.cpi_equestrian_index_ALLOW_ErrorCount
          ,le.cpi_family_index_ALLOW_ErrorCount
          ,le.cpi_family_teen_index_ALLOW_ErrorCount
          ,le.cpi_family_young_index_ALLOW_ErrorCount
          ,le.cpi_fiction_index_ALLOW_ErrorCount
          ,le.cpi_gambling_index_ALLOW_ErrorCount
          ,le.cpi_games_index_ALLOW_ErrorCount
          ,le.cpi_gardening_index_ALLOW_ErrorCount
          ,le.cpi_gay_index_ALLOW_ErrorCount
          ,le.cpi_giftgivr_index_ALLOW_ErrorCount
          ,le.cpi_gourmet_index_ALLOW_ErrorCount
          ,le.cpi_grandparents_index_ALLOW_ErrorCount
          ,le.cpi_health_index_ALLOW_ErrorCount
          ,le.cpi_health_diet_index_ALLOW_ErrorCount
          ,le.cpi_health_fitness_index_ALLOW_ErrorCount
          ,le.cpi_hightech_index_ALLOW_ErrorCount
          ,le.cpi_hispanic_index_ALLOW_ErrorCount
          ,le.cpi_history_index_ALLOW_ErrorCount
          ,le.cpi_history_american_index_ALLOW_ErrorCount
          ,le.cpi_hobbies_index_ALLOW_ErrorCount
          ,le.cpi_homedecr_index_ALLOW_ErrorCount
          ,le.cpi_homeliv_index_ALLOW_ErrorCount
          ,le.cpi_humor_index_ALLOW_ErrorCount
          ,le.cpi_inspiration_index_ALLOW_ErrorCount
          ,le.cpi_internet_index_ALLOW_ErrorCount
          ,le.cpi_internet_access_index_ALLOW_ErrorCount
          ,le.cpi_internet_buy_index_ALLOW_ErrorCount
          ,le.cpi_liberal_index_ALLOW_ErrorCount
          ,le.cpi_moneymaking_index_ALLOW_ErrorCount
          ,le.cpi_motorcycles_index_ALLOW_ErrorCount
          ,le.cpi_music_index_ALLOW_ErrorCount
          ,le.cpi_nonfiction_index_ALLOW_ErrorCount
          ,le.cpi_ocean_index_ALLOW_ErrorCount
          ,le.cpi_outdoors_index_ALLOW_ErrorCount
          ,le.cpi_outdoors_boatsail_index_ALLOW_ErrorCount
          ,le.cpi_outdoors_camp_index_ALLOW_ErrorCount
          ,le.cpi_outdoors_fishing_index_ALLOW_ErrorCount
          ,le.cpi_outdoors_huntfish_index_ALLOW_ErrorCount
          ,le.cpi_outdoors_hunting_index_ALLOW_ErrorCount
          ,le.cpi_pets_index_ALLOW_ErrorCount
          ,le.cpi_pets_cats_index_ALLOW_ErrorCount
          ,le.cpi_pets_dogs_index_ALLOW_ErrorCount
          ,le.cpi_pfin_index_ALLOW_ErrorCount
          ,le.cpi_photog_index_ALLOW_ErrorCount
          ,le.cpi_photoproc_index_ALLOW_ErrorCount
          ,le.cpi_publish_index_ALLOW_ErrorCount
          ,le.cpi_publish_books_index_ALLOW_ErrorCount
          ,le.cpi_publish_mags_index_ALLOW_ErrorCount
          ,le.cpi_rural_index_ALLOW_ErrorCount
          ,le.cpi_science_index_ALLOW_ErrorCount
          ,le.cpi_scifi_index_ALLOW_ErrorCount
          ,le.cpi_seniors_index_ALLOW_ErrorCount
          ,le.cpi_sports_index_ALLOW_ErrorCount
          ,le.cpi_sports_baseball_index_ALLOW_ErrorCount
          ,le.cpi_sports_basketball_index_ALLOW_ErrorCount
          ,le.cpi_sports_biking_index_ALLOW_ErrorCount
          ,le.cpi_sports_football_index_ALLOW_ErrorCount
          ,le.cpi_sports_golf_index_ALLOW_ErrorCount
          ,le.cpi_sports_hockey_index_ALLOW_ErrorCount
          ,le.cpi_sports_running_index_ALLOW_ErrorCount
          ,le.cpi_sports_ski_index_ALLOW_ErrorCount
          ,le.cpi_sports_soccer_index_ALLOW_ErrorCount
          ,le.cpi_sports_swimming_index_ALLOW_ErrorCount
          ,le.cpi_sports_tennis_index_ALLOW_ErrorCount
          ,le.cpi_stationery_index_ALLOW_ErrorCount
          ,le.cpi_sweeps_index_ALLOW_ErrorCount
          ,le.cpi_tobacco_index_ALLOW_ErrorCount
          ,le.cpi_travel_index_ALLOW_ErrorCount
          ,le.cpi_travel_cruise_index_ALLOW_ErrorCount
          ,le.cpi_travel_rv_index_ALLOW_ErrorCount
          ,le.cpi_travel_us_index_ALLOW_ErrorCount
          ,le.cpi_tvmovies_index_ALLOW_ErrorCount
          ,le.cpi_wildlife_index_ALLOW_ErrorCount
          ,le.cpi_woman_index_ALLOW_ErrorCount
          ,le.totdlr_index_ALLOW_ErrorCount
          ,le.cpi_totdlr_ALLOW_ErrorCount
          ,le.cpi_totords_ALLOW_ErrorCount
          ,le.cpi_lastdlr_ALLOW_ErrorCount
          ,le.pkcatg_ALLOW_ErrorCount
          ,le.pkpubs_ALLOW_ErrorCount
          ,le.pkcont_ALLOW_ErrorCount
          ,le.pkca01_ALLOW_ErrorCount
          ,le.pkca03_ALLOW_ErrorCount
          ,le.pkca04_ALLOW_ErrorCount
          ,le.pkca05_ALLOW_ErrorCount
          ,le.pkca06_ALLOW_ErrorCount
          ,le.pkca07_ALLOW_ErrorCount
          ,le.pkca08_ALLOW_ErrorCount
          ,le.pkca09_ALLOW_ErrorCount
          ,le.pkca10_ALLOW_ErrorCount
          ,le.pkca11_ALLOW_ErrorCount
          ,le.pkca12_ALLOW_ErrorCount
          ,le.pkca13_ALLOW_ErrorCount
          ,le.pkca14_ALLOW_ErrorCount
          ,le.pkca15_ALLOW_ErrorCount
          ,le.pkca16_ALLOW_ErrorCount
          ,le.pkca17_ALLOW_ErrorCount
          ,le.pkca18_ALLOW_ErrorCount
          ,le.pkca20_ALLOW_ErrorCount
          ,le.pkca21_ALLOW_ErrorCount
          ,le.pkca22_ALLOW_ErrorCount
          ,le.pkca23_ALLOW_ErrorCount
          ,le.pkca24_ALLOW_ErrorCount
          ,le.pkca25_ALLOW_ErrorCount
          ,le.pkca26_ALLOW_ErrorCount
          ,le.pkca28_ALLOW_ErrorCount
          ,le.pkca29_ALLOW_ErrorCount
          ,le.pkca30_ALLOW_ErrorCount
          ,le.pkca31_ALLOW_ErrorCount
          ,le.pkca32_ALLOW_ErrorCount
          ,le.pkca33_ALLOW_ErrorCount
          ,le.pkca34_ALLOW_ErrorCount
          ,le.pkca35_ALLOW_ErrorCount
          ,le.pkca36_ALLOW_ErrorCount
          ,le.pkca37_ALLOW_ErrorCount
          ,le.pkca39_ALLOW_ErrorCount
          ,le.pkca40_ALLOW_ErrorCount
          ,le.pkca41_ALLOW_ErrorCount
          ,le.pkca42_ALLOW_ErrorCount
          ,le.pkca54_ALLOW_ErrorCount
          ,le.pkca61_ALLOW_ErrorCount
          ,le.pkca62_ALLOW_ErrorCount
          ,le.pkca64_ALLOW_ErrorCount
          ,le.pkpu01_ALLOW_ErrorCount
          ,le.pkpu02_ALLOW_ErrorCount
          ,le.pkpu03_ALLOW_ErrorCount
          ,le.pkpu04_ALLOW_ErrorCount
          ,le.pkpu05_ALLOW_ErrorCount
          ,le.pkpu06_ALLOW_ErrorCount
          ,le.pkpu07_ALLOW_ErrorCount
          ,le.pkpu08_ALLOW_ErrorCount
          ,le.pkpu09_ALLOW_ErrorCount
          ,le.pkpu10_ALLOW_ErrorCount
          ,le.pkpu11_ALLOW_ErrorCount
          ,le.pkpu12_ALLOW_ErrorCount
          ,le.pkpu13_ALLOW_ErrorCount
          ,le.pkpu14_ALLOW_ErrorCount
          ,le.pkpu15_ALLOW_ErrorCount
          ,le.pkpu16_ALLOW_ErrorCount
          ,le.pkpu17_ALLOW_ErrorCount
          ,le.pkpu18_ALLOW_ErrorCount
          ,le.pkpu19_ALLOW_ErrorCount
          ,le.pkpu20_ALLOW_ErrorCount
          ,le.pkpu23_ALLOW_ErrorCount
          ,le.pkpu25_ALLOW_ErrorCount
          ,le.pkpu27_ALLOW_ErrorCount
          ,le.pkpu28_ALLOW_ErrorCount
          ,le.pkpu29_ALLOW_ErrorCount
          ,le.pkpu30_ALLOW_ErrorCount
          ,le.pkpu31_ALLOW_ErrorCount
          ,le.pkpu32_ALLOW_ErrorCount
          ,le.pkpu33_ALLOW_ErrorCount
          ,le.pkpu34_ALLOW_ErrorCount
          ,le.pkpu35_ALLOW_ErrorCount
          ,le.pkpu38_ALLOW_ErrorCount
          ,le.pkpu41_ALLOW_ErrorCount
          ,le.pkpu42_ALLOW_ErrorCount
          ,le.pkpu45_ALLOW_ErrorCount
          ,le.pkpu46_ALLOW_ErrorCount
          ,le.pkpu47_ALLOW_ErrorCount
          ,le.pkpu48_ALLOW_ErrorCount
          ,le.pkpu49_ALLOW_ErrorCount
          ,le.pkpu50_ALLOW_ErrorCount
          ,le.pkpu51_ALLOW_ErrorCount
          ,le.pkpu52_ALLOW_ErrorCount
          ,le.pkpu53_ALLOW_ErrorCount
          ,le.pkpu54_ALLOW_ErrorCount
          ,le.pkpu55_ALLOW_ErrorCount
          ,le.pkpu56_ALLOW_ErrorCount
          ,le.pkpu57_ALLOW_ErrorCount
          ,le.pkpu60_ALLOW_ErrorCount
          ,le.pkpu61_ALLOW_ErrorCount
          ,le.pkpu62_ALLOW_ErrorCount
          ,le.pkpu63_ALLOW_ErrorCount
          ,le.pkpu64_ALLOW_ErrorCount
          ,le.pkpu65_ALLOW_ErrorCount
          ,le.pkpu66_ALLOW_ErrorCount
          ,le.pkpu67_ALLOW_ErrorCount
          ,le.pkpu68_ALLOW_ErrorCount
          ,le.pkpu69_ALLOW_ErrorCount
          ,le.pkpu70_ALLOW_ErrorCount
          ,le.censpct_water_ALLOW_ErrorCount
          ,le.cens_pop_density_ALLOW_ErrorCount
          ,le.cens_hu_density_ALLOW_ErrorCount
          ,le.censpct_pop_white_ALLOW_ErrorCount
          ,le.censpct_pop_black_ALLOW_ErrorCount
          ,le.censpct_pop_amerind_ALLOW_ErrorCount
          ,le.censpct_pop_asian_ALLOW_ErrorCount
          ,le.censpct_pop_pacisl_ALLOW_ErrorCount
          ,le.censpct_pop_othrace_ALLOW_ErrorCount
          ,le.censpct_pop_multirace_ALLOW_ErrorCount
          ,le.censpct_pop_hispanic_ALLOW_ErrorCount
          ,le.censpct_pop_agelt18_ALLOW_ErrorCount
          ,le.censpct_pop_males_ALLOW_ErrorCount
          ,le.censpct_adult_age1824_ALLOW_ErrorCount
          ,le.censpct_adult_age2534_ALLOW_ErrorCount
          ,le.censpct_adult_age3544_ALLOW_ErrorCount
          ,le.censpct_adult_age4554_ALLOW_ErrorCount
          ,le.censpct_adult_age5564_ALLOW_ErrorCount
          ,le.censpct_adult_agege65_ALLOW_ErrorCount
          ,le.cens_pop_medage_ALLOW_ErrorCount
          ,le.cens_hh_avgsize_ALLOW_ErrorCount
          ,le.censpct_hh_family_ALLOW_ErrorCount
          ,le.censpct_hh_family_husbwife_ALLOW_ErrorCount
          ,le.censpct_hu_occupied_ALLOW_ErrorCount
          ,le.censpct_hu_owned_ALLOW_ErrorCount
          ,le.censpct_hu_rented_ALLOW_ErrorCount
          ,le.censpct_hu_vacantseasonal_ALLOW_ErrorCount
          ,le.zip_medinc_ALLOW_ErrorCount
          ,le.zip_apparel_ALLOW_ErrorCount
          ,le.zip_apparel_women_ALLOW_ErrorCount
          ,le.zip_apparel_womfash_ALLOW_ErrorCount
          ,le.zip_auto_ALLOW_ErrorCount
          ,le.zip_beauty_ALLOW_ErrorCount
          ,le.zip_booksmusicmovies_ALLOW_ErrorCount
          ,le.zip_business_ALLOW_ErrorCount
          ,le.zip_catalog_ALLOW_ErrorCount
          ,le.zip_cc_ALLOW_ErrorCount
          ,le.zip_collectibles_ALLOW_ErrorCount
          ,le.zip_computers_ALLOW_ErrorCount
          ,le.zip_continuity_ALLOW_ErrorCount
          ,le.zip_cooking_ALLOW_ErrorCount
          ,le.zip_crafts_ALLOW_ErrorCount
          ,le.zip_culturearts_ALLOW_ErrorCount
          ,le.zip_dm_sold_ALLOW_ErrorCount
          ,le.zip_donor_ALLOW_ErrorCount
          ,le.zip_family_ALLOW_ErrorCount
          ,le.zip_gardening_ALLOW_ErrorCount
          ,le.zip_giftgivr_ALLOW_ErrorCount
          ,le.zip_gourmet_ALLOW_ErrorCount
          ,le.zip_health_ALLOW_ErrorCount
          ,le.zip_health_diet_ALLOW_ErrorCount
          ,le.zip_health_fitness_ALLOW_ErrorCount
          ,le.zip_hobbies_ALLOW_ErrorCount
          ,le.zip_homedecr_ALLOW_ErrorCount
          ,le.zip_homeliv_ALLOW_ErrorCount
          ,le.zip_internet_ALLOW_ErrorCount
          ,le.zip_internet_access_ALLOW_ErrorCount
          ,le.zip_internet_buy_ALLOW_ErrorCount
          ,le.zip_music_ALLOW_ErrorCount
          ,le.zip_outdoors_ALLOW_ErrorCount
          ,le.zip_pets_ALLOW_ErrorCount
          ,le.zip_pfin_ALLOW_ErrorCount
          ,le.zip_publish_ALLOW_ErrorCount
          ,le.zip_publish_books_ALLOW_ErrorCount
          ,le.zip_publish_mags_ALLOW_ErrorCount
          ,le.zip_sports_ALLOW_ErrorCount
          ,le.zip_sports_biking_ALLOW_ErrorCount
          ,le.zip_sports_golf_ALLOW_ErrorCount
          ,le.zip_travel_ALLOW_ErrorCount
          ,le.zip_travel_us_ALLOW_ErrorCount
          ,le.zip_tvmovies_ALLOW_ErrorCount
          ,le.zip_woman_ALLOW_ErrorCount
          ,le.zip_proftech_ALLOW_ErrorCount
          ,le.zip_retired_ALLOW_ErrorCount
          ,le.zip_inc100_ALLOW_ErrorCount
          ,le.zip_inc75_ALLOW_ErrorCount
          ,le.zip_inc50_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount
          ,le.AnyRule_WithEditsCount
          ,le.Rules_WithEdits,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.dtmatch_ALLOW_ErrorCount,le.dtmatch_LENGTHS_ErrorCount
          ,le.msname_ALLOW_ErrorCount
          ,le.msaddr1_ALLOW_ErrorCount
          ,le.msaddr2_ALLOW_ErrorCount
          ,le.mscity_ALLOW_ErrorCount,le.mscity_LENGTHS_ErrorCount
          ,le.msstate_ALLOW_ErrorCount,le.msstate_LENGTHS_ErrorCount,le.msstate_WORDS_ErrorCount
          ,le.mszip5_ALLOW_ErrorCount,le.mszip5_LENGTHS_ErrorCount
          ,le.mszip4_ALLOW_ErrorCount,le.mszip4_LENGTHS_ErrorCount
          ,le.dthh_ALLOW_ErrorCount,le.dthh_LENGTHS_ErrorCount
          ,le.mscrrt_ALLOW_ErrorCount,le.mscrrt_LENGTHS_ErrorCount
          ,le.msdpbc_ALLOW_ErrorCount,le.msdpbc_LENGTHS_ErrorCount
          ,le.msdpv_ALLOW_ErrorCount,le.msdpv_LENGTHS_ErrorCount
          ,le.ms_addrtype_ALLOW_ErrorCount,le.ms_addrtype_LENGTHS_ErrorCount
          ,le.ctysize_ALLOW_ErrorCount,le.ctysize_LENGTHS_ErrorCount
          ,le.lmos_ALLOW_ErrorCount
          ,le.omos_ALLOW_ErrorCount
          ,le.pmos_ALLOW_ErrorCount
          ,le.gen_ENUM_ErrorCount,le.gen_LENGTHS_ErrorCount
          ,le.dob_CUSTOM_ErrorCount
          ,le.age_ALLOW_ErrorCount
          ,le.inc_ENUM_ErrorCount,le.inc_LENGTHS_ErrorCount
          ,le.marital_status_ALLOW_ErrorCount
          ,le.poc_ALLOW_ErrorCount
          ,le.noc_ALLOW_ErrorCount,le.noc_LENGTHS_ErrorCount
          ,le.ocp_ENUM_ErrorCount,le.ocp_LENGTHS_ErrorCount
          ,le.edu_ENUM_ErrorCount,le.edu_LENGTHS_ErrorCount
          ,le.lang_ALLOW_ErrorCount,le.lang_LENGTHS_ErrorCount
          ,le.relig_ENUM_ErrorCount,le.relig_LENGTHS_ErrorCount
          ,le.dwell_ENUM_ErrorCount,le.dwell_LENGTHS_ErrorCount
          ,le.ownr_ALLOW_ErrorCount
          ,le.eth1_ALLOW_ErrorCount,le.eth1_LENGTHS_ErrorCount
          ,le.eth2_ALLOW_ErrorCount,le.eth2_LENGTHS_ErrorCount
          ,le.lor_ALLOW_ErrorCount,le.lor_LENGTHS_ErrorCount
          ,le.pool_ALLOW_ErrorCount,le.pool_LENGTHS_ErrorCount
          ,le.speak_span_ALLOW_ErrorCount,le.speak_span_LENGTHS_ErrorCount
          ,le.soho_ALLOW_ErrorCount,le.soho_LENGTHS_ErrorCount
          ,le.vet_in_hh_ALLOW_ErrorCount,le.vet_in_hh_LENGTHS_ErrorCount
          ,le.ms_mags_ALLOW_ErrorCount
          ,le.ms_books_ALLOW_ErrorCount
          ,le.ms_publish_ALLOW_ErrorCount
          ,le.ms_pub_status_active_ALLOW_ErrorCount
          ,le.ms_pub_status_expire_ALLOW_ErrorCount
          ,le.ms_pub_premsold_ALLOW_ErrorCount
          ,le.ms_pub_autornwl_ALLOW_ErrorCount
          ,le.ms_pub_avgterm_ALLOW_ErrorCount
          ,le.ms_pub_lmos_ALLOW_ErrorCount
          ,le.ms_pub_omos_ALLOW_ErrorCount
          ,le.ms_pub_pmos_ALLOW_ErrorCount
          ,le.ms_pub_cemos_ALLOW_ErrorCount
          ,le.ms_pub_femos_ALLOW_ErrorCount
          ,le.ms_pub_totords_ALLOW_ErrorCount
          ,le.ms_pub_totdlrs_ALLOW_ErrorCount
          ,le.ms_pub_avgdlrs_ALLOW_ErrorCount
          ,le.ms_pub_lastdlrs_ALLOW_ErrorCount
          ,le.ms_pub_paystat_paid_ALLOW_ErrorCount
          ,le.ms_pub_paystat_ub_ALLOW_ErrorCount
          ,le.ms_pub_paymeth_cc_ALLOW_ErrorCount
          ,le.ms_pub_paymeth_cash_ALLOW_ErrorCount
          ,le.ms_pub_payspeed_ALLOW_ErrorCount
          ,le.ms_pub_osrc_dm_ALLOW_ErrorCount
          ,le.ms_pub_lsrc_dm_ALLOW_ErrorCount
          ,le.ms_pub_osrc_agt_cashf_ALLOW_ErrorCount
          ,le.ms_pub_lsrc_agt_cashf_ALLOW_ErrorCount
          ,le.ms_pub_osrc_agt_pds_ALLOW_ErrorCount
          ,le.ms_pub_lsrc_agt_pds_ALLOW_ErrorCount
          ,le.ms_pub_osrc_agt_schplan_ALLOW_ErrorCount
          ,le.ms_pub_lsrc_agt_schplan_ALLOW_ErrorCount
          ,le.ms_pub_osrc_agt_sponsor_ALLOW_ErrorCount
          ,le.ms_pub_lsrc_agt_sponsor_ALLOW_ErrorCount
          ,le.ms_pub_osrc_agt_tm_ALLOW_ErrorCount
          ,le.ms_pub_lsrc_agt_tm_ALLOW_ErrorCount
          ,le.ms_pub_osrc_agt_ALLOW_ErrorCount
          ,le.ms_pub_lsrc_agt_ALLOW_ErrorCount
          ,le.ms_pub_osrc_tm_ALLOW_ErrorCount
          ,le.ms_pub_lsrc_tm_ALLOW_ErrorCount
          ,le.ms_pub_osrc_ins_ALLOW_ErrorCount
          ,le.ms_pub_lsrc_ins_ALLOW_ErrorCount
          ,le.ms_pub_osrc_net_ALLOW_ErrorCount
          ,le.ms_pub_lsrc_net_ALLOW_ErrorCount
          ,le.ms_pub_osrc_print_ALLOW_ErrorCount
          ,le.ms_pub_lsrc_print_ALLOW_ErrorCount
          ,le.ms_pub_osrc_trans_ALLOW_ErrorCount
          ,le.ms_pub_lsrc_trans_ALLOW_ErrorCount
          ,le.ms_pub_osrc_tv_ALLOW_ErrorCount
          ,le.ms_pub_lsrc_tv_ALLOW_ErrorCount
          ,le.ms_pub_osrc_dtp_ALLOW_ErrorCount
          ,le.ms_pub_lsrc_dtp_ALLOW_ErrorCount
          ,le.ms_pub_giftgivr_ALLOW_ErrorCount
          ,le.ms_pub_giftee_ALLOW_ErrorCount
          ,le.ms_catalog_ALLOW_ErrorCount
          ,le.ms_cat_lmos_ALLOW_ErrorCount
          ,le.ms_cat_omos_ALLOW_ErrorCount
          ,le.ms_cat_pmos_ALLOW_ErrorCount
          ,le.ms_cat_totords_ALLOW_ErrorCount
          ,le.ms_cat_totitems_ALLOW_ErrorCount
          ,le.ms_cat_totdlrs_ALLOW_ErrorCount
          ,le.ms_cat_avgdlrs_ALLOW_ErrorCount
          ,le.ms_cat_lastdlrs_ALLOW_ErrorCount
          ,le.ms_cat_paystat_paid_ALLOW_ErrorCount
          ,le.ms_cat_paymeth_cc_ALLOW_ErrorCount
          ,le.ms_cat_paymeth_cash_ALLOW_ErrorCount
          ,le.ms_cat_osrc_dm_ALLOW_ErrorCount
          ,le.ms_cat_lsrc_dm_ALLOW_ErrorCount
          ,le.ms_cat_osrc_net_ALLOW_ErrorCount
          ,le.ms_cat_lsrc_net_ALLOW_ErrorCount
          ,le.ms_cat_giftgivr_ALLOW_ErrorCount
          ,le.pkpubs_corrected_ALLOW_ErrorCount
          ,le.pkcatg_corrected_ALLOW_ErrorCount
          ,le.ms_fundraising_ALLOW_ErrorCount
          ,le.ms_fund_lmos_ALLOW_ErrorCount
          ,le.ms_fund_omos_ALLOW_ErrorCount
          ,le.ms_fund_pmos_ALLOW_ErrorCount
          ,le.ms_fund_totords_ALLOW_ErrorCount
          ,le.ms_fund_totdlrs_ALLOW_ErrorCount
          ,le.ms_fund_avgdlrs_ALLOW_ErrorCount
          ,le.ms_fund_lastdlrs_ALLOW_ErrorCount
          ,le.ms_fund_paystat_paid_ALLOW_ErrorCount
          ,le.ms_other_ALLOW_ErrorCount
          ,le.ms_continuity_ALLOW_ErrorCount
          ,le.ms_cont_status_active_ALLOW_ErrorCount
          ,le.ms_cont_status_cancel_ALLOW_ErrorCount
          ,le.ms_cont_omos_ALLOW_ErrorCount
          ,le.ms_cont_lmos_ALLOW_ErrorCount
          ,le.ms_cont_pmos_ALLOW_ErrorCount
          ,le.ms_cont_totords_ALLOW_ErrorCount
          ,le.ms_cont_totdlrs_ALLOW_ErrorCount
          ,le.ms_cont_avgdlrs_ALLOW_ErrorCount
          ,le.ms_cont_lastdlrs_ALLOW_ErrorCount
          ,le.ms_cont_paystat_paid_ALLOW_ErrorCount
          ,le.ms_cont_paymeth_cc_ALLOW_ErrorCount
          ,le.ms_cont_paymeth_cash_ALLOW_ErrorCount
          ,le.ms_totords_ALLOW_ErrorCount
          ,le.ms_totitems_ALLOW_ErrorCount
          ,le.ms_totdlrs_ALLOW_ErrorCount
          ,le.ms_avgdlrs_ALLOW_ErrorCount
          ,le.ms_lastdlrs_ALLOW_ErrorCount
          ,le.ms_paystat_paid_ALLOW_ErrorCount
          ,le.ms_paymeth_cc_ALLOW_ErrorCount
          ,le.ms_paymeth_cash_ALLOW_ErrorCount
          ,le.ms_osrc_dm_ALLOW_ErrorCount
          ,le.ms_lsrc_dm_ALLOW_ErrorCount
          ,le.ms_osrc_tm_ALLOW_ErrorCount
          ,le.ms_lsrc_tm_ALLOW_ErrorCount
          ,le.ms_osrc_ins_ALLOW_ErrorCount
          ,le.ms_lsrc_ins_ALLOW_ErrorCount
          ,le.ms_osrc_net_ALLOW_ErrorCount
          ,le.ms_lsrc_net_ALLOW_ErrorCount
          ,le.ms_osrc_tv_ALLOW_ErrorCount
          ,le.ms_lsrc_tv_ALLOW_ErrorCount
          ,le.ms_osrc_retail_ALLOW_ErrorCount
          ,le.ms_lsrc_retail_ALLOW_ErrorCount
          ,le.ms_giftgivr_ALLOW_ErrorCount
          ,le.ms_giftee_ALLOW_ErrorCount
          ,le.ms_adult_ALLOW_ErrorCount
          ,le.ms_womapp_ALLOW_ErrorCount
          ,le.ms_menapp_ALLOW_ErrorCount
          ,le.ms_kidapp_ALLOW_ErrorCount
          ,le.ms_accessory_ALLOW_ErrorCount
          ,le.ms_apparel_ALLOW_ErrorCount
          ,le.ms_app_lmos_ALLOW_ErrorCount
          ,le.ms_app_omos_ALLOW_ErrorCount
          ,le.ms_app_pmos_ALLOW_ErrorCount
          ,le.ms_app_totords_ALLOW_ErrorCount
          ,le.ms_app_totitems_ALLOW_ErrorCount
          ,le.ms_app_totdlrs_ALLOW_ErrorCount
          ,le.ms_app_avgdlrs_ALLOW_ErrorCount
          ,le.ms_app_lastdlrs_ALLOW_ErrorCount
          ,le.ms_app_paystat_paid_ALLOW_ErrorCount
          ,le.ms_app_paymeth_cc_ALLOW_ErrorCount
          ,le.ms_app_paymeth_cash_ALLOW_ErrorCount
          ,le.ms_menfash_ALLOW_ErrorCount
          ,le.ms_womfash_ALLOW_ErrorCount
          ,le.ms_wfsh_lmos_ALLOW_ErrorCount
          ,le.ms_wfsh_omos_ALLOW_ErrorCount
          ,le.ms_wfsh_pmos_ALLOW_ErrorCount
          ,le.ms_wfsh_totords_ALLOW_ErrorCount
          ,le.ms_wfsh_totdlrs_ALLOW_ErrorCount
          ,le.ms_wfsh_avgdlrs_ALLOW_ErrorCount
          ,le.ms_wfsh_lastdlrs_ALLOW_ErrorCount
          ,le.ms_wfsh_paystat_paid_ALLOW_ErrorCount
          ,le.ms_wfsh_osrc_dm_ALLOW_ErrorCount
          ,le.ms_wfsh_lsrc_dm_ALLOW_ErrorCount
          ,le.ms_wfsh_osrc_agt_ALLOW_ErrorCount
          ,le.ms_wfsh_lsrc_agt_ALLOW_ErrorCount
          ,le.ms_audio_ALLOW_ErrorCount
          ,le.ms_auto_ALLOW_ErrorCount
          ,le.ms_aviation_ALLOW_ErrorCount
          ,le.ms_bargains_ALLOW_ErrorCount
          ,le.ms_beauty_ALLOW_ErrorCount
          ,le.ms_bible_ALLOW_ErrorCount
          ,le.ms_bible_lmos_ALLOW_ErrorCount
          ,le.ms_bible_omos_ALLOW_ErrorCount
          ,le.ms_bible_pmos_ALLOW_ErrorCount
          ,le.ms_bible_totords_ALLOW_ErrorCount
          ,le.ms_bible_totitems_ALLOW_ErrorCount
          ,le.ms_bible_totdlrs_ALLOW_ErrorCount
          ,le.ms_bible_avgdlrs_ALLOW_ErrorCount
          ,le.ms_bible_lastdlrs_ALLOW_ErrorCount
          ,le.ms_bible_paystat_paid_ALLOW_ErrorCount
          ,le.ms_bible_paymeth_cc_ALLOW_ErrorCount
          ,le.ms_bible_paymeth_cash_ALLOW_ErrorCount
          ,le.ms_business_ALLOW_ErrorCount
          ,le.ms_collectibles_ALLOW_ErrorCount
          ,le.ms_computers_ALLOW_ErrorCount
          ,le.ms_crafts_ALLOW_ErrorCount
          ,le.ms_culturearts_ALLOW_ErrorCount
          ,le.ms_currevent_ALLOW_ErrorCount
          ,le.ms_diy_ALLOW_ErrorCount
          ,le.ms_electronics_ALLOW_ErrorCount
          ,le.ms_equestrian_ALLOW_ErrorCount
          ,le.ms_pub_family_ALLOW_ErrorCount
          ,le.ms_cat_family_ALLOW_ErrorCount
          ,le.ms_family_ALLOW_ErrorCount
          ,le.ms_family_lmos_ALLOW_ErrorCount
          ,le.ms_family_omos_ALLOW_ErrorCount
          ,le.ms_family_pmos_ALLOW_ErrorCount
          ,le.ms_family_totords_ALLOW_ErrorCount
          ,le.ms_family_totitems_ALLOW_ErrorCount
          ,le.ms_family_totdlrs_ALLOW_ErrorCount
          ,le.ms_family_avgdlrs_ALLOW_ErrorCount
          ,le.ms_family_lastdlrs_ALLOW_ErrorCount
          ,le.ms_family_paystat_paid_ALLOW_ErrorCount
          ,le.ms_family_paymeth_cc_ALLOW_ErrorCount
          ,le.ms_family_paymeth_cash_ALLOW_ErrorCount
          ,le.ms_family_osrc_dm_ALLOW_ErrorCount
          ,le.ms_family_lsrc_dm_ALLOW_ErrorCount
          ,le.ms_fiction_ALLOW_ErrorCount
          ,le.ms_food_ALLOW_ErrorCount
          ,le.ms_games_ALLOW_ErrorCount
          ,le.ms_gifts_ALLOW_ErrorCount
          ,le.ms_gourmet_ALLOW_ErrorCount
          ,le.ms_fitness_ALLOW_ErrorCount
          ,le.ms_health_ALLOW_ErrorCount
          ,le.ms_hlth_lmos_ALLOW_ErrorCount
          ,le.ms_hlth_omos_ALLOW_ErrorCount
          ,le.ms_hlth_pmos_ALLOW_ErrorCount
          ,le.ms_hlth_totords_ALLOW_ErrorCount
          ,le.ms_hlth_totdlrs_ALLOW_ErrorCount
          ,le.ms_hlth_avgdlrs_ALLOW_ErrorCount
          ,le.ms_hlth_lastdlrs_ALLOW_ErrorCount
          ,le.ms_hlth_paystat_paid_ALLOW_ErrorCount
          ,le.ms_hlth_paymeth_cc_ALLOW_ErrorCount
          ,le.ms_hlth_osrc_dm_ALLOW_ErrorCount
          ,le.ms_hlth_lsrc_dm_ALLOW_ErrorCount
          ,le.ms_hlth_osrc_agt_ALLOW_ErrorCount
          ,le.ms_hlth_lsrc_agt_ALLOW_ErrorCount
          ,le.ms_hlth_osrc_tv_ALLOW_ErrorCount
          ,le.ms_hlth_lsrc_tv_ALLOW_ErrorCount
          ,le.ms_holiday_ALLOW_ErrorCount
          ,le.ms_history_ALLOW_ErrorCount
          ,le.ms_pub_cooking_ALLOW_ErrorCount
          ,le.ms_cooking_ALLOW_ErrorCount
          ,le.ms_pub_homedecr_ALLOW_ErrorCount
          ,le.ms_cat_homedecr_ALLOW_ErrorCount
          ,le.ms_homedecr_ALLOW_ErrorCount
          ,le.ms_housewares_ALLOW_ErrorCount
          ,le.ms_pub_garden_ALLOW_ErrorCount
          ,le.ms_cat_garden_ALLOW_ErrorCount
          ,le.ms_garden_ALLOW_ErrorCount
          ,le.ms_pub_homeliv_ALLOW_ErrorCount
          ,le.ms_cat_homeliv_ALLOW_ErrorCount
          ,le.ms_homeliv_ALLOW_ErrorCount
          ,le.ms_pub_home_status_active_ALLOW_ErrorCount
          ,le.ms_home_lmos_ALLOW_ErrorCount
          ,le.ms_home_omos_ALLOW_ErrorCount
          ,le.ms_home_pmos_ALLOW_ErrorCount
          ,le.ms_home_totords_ALLOW_ErrorCount
          ,le.ms_home_totitems_ALLOW_ErrorCount
          ,le.ms_home_totdlrs_ALLOW_ErrorCount
          ,le.ms_home_avgdlrs_ALLOW_ErrorCount
          ,le.ms_home_lastdlrs_ALLOW_ErrorCount
          ,le.ms_home_paystat_paid_ALLOW_ErrorCount
          ,le.ms_home_paymeth_cc_ALLOW_ErrorCount
          ,le.ms_home_paymeth_cash_ALLOW_ErrorCount
          ,le.ms_home_osrc_dm_ALLOW_ErrorCount
          ,le.ms_home_lsrc_dm_ALLOW_ErrorCount
          ,le.ms_home_osrc_agt_ALLOW_ErrorCount
          ,le.ms_home_lsrc_agt_ALLOW_ErrorCount
          ,le.ms_home_osrc_net_ALLOW_ErrorCount
          ,le.ms_home_lsrc_net_ALLOW_ErrorCount
          ,le.ms_home_osrc_tv_ALLOW_ErrorCount
          ,le.ms_home_lsrc_tv_ALLOW_ErrorCount
          ,le.ms_humor_ALLOW_ErrorCount
          ,le.ms_inspiration_ALLOW_ErrorCount
          ,le.ms_merchandise_ALLOW_ErrorCount
          ,le.ms_moneymaking_ALLOW_ErrorCount
          ,le.ms_moneymaking_lmos_ALLOW_ErrorCount
          ,le.ms_motorcycles_ALLOW_ErrorCount
          ,le.ms_music_ALLOW_ErrorCount
          ,le.ms_fishing_ALLOW_ErrorCount
          ,le.ms_hunting_ALLOW_ErrorCount
          ,le.ms_boatsail_ALLOW_ErrorCount
          ,le.ms_camp_ALLOW_ErrorCount
          ,le.ms_pub_outdoors_ALLOW_ErrorCount
          ,le.ms_cat_outdoors_ALLOW_ErrorCount
          ,le.ms_outdoors_ALLOW_ErrorCount
          ,le.ms_pub_out_status_active_ALLOW_ErrorCount
          ,le.ms_out_lmos_ALLOW_ErrorCount
          ,le.ms_out_omos_ALLOW_ErrorCount
          ,le.ms_out_pmos_ALLOW_ErrorCount
          ,le.ms_out_totords_ALLOW_ErrorCount
          ,le.ms_out_totitems_ALLOW_ErrorCount
          ,le.ms_out_totdlrs_ALLOW_ErrorCount
          ,le.ms_out_avgdlrs_ALLOW_ErrorCount
          ,le.ms_out_lastdlrs_ALLOW_ErrorCount
          ,le.ms_out_paystat_paid_ALLOW_ErrorCount
          ,le.ms_out_paymeth_cc_ALLOW_ErrorCount
          ,le.ms_out_paymeth_cash_ALLOW_ErrorCount
          ,le.ms_out_osrc_dm_ALLOW_ErrorCount
          ,le.ms_out_lsrc_dm_ALLOW_ErrorCount
          ,le.ms_out_osrc_agt_ALLOW_ErrorCount
          ,le.ms_out_lsrc_agt_ALLOW_ErrorCount
          ,le.ms_pets_ALLOW_ErrorCount
          ,le.ms_pfin_ALLOW_ErrorCount
          ,le.ms_photo_ALLOW_ErrorCount
          ,le.ms_photoproc_ALLOW_ErrorCount
          ,le.ms_rural_ALLOW_ErrorCount
          ,le.ms_science_ALLOW_ErrorCount
          ,le.ms_sports_ALLOW_ErrorCount
          ,le.ms_sports_lmos_ALLOW_ErrorCount
          ,le.ms_travel_ALLOW_ErrorCount
          ,le.ms_tvmovies_ALLOW_ErrorCount
          ,le.ms_wildlife_ALLOW_ErrorCount
          ,le.ms_woman_ALLOW_ErrorCount
          ,le.ms_woman_lmos_ALLOW_ErrorCount
          ,le.ms_ringtones_apps_ALLOW_ErrorCount
          ,le.cpi_mobile_apps_index_ALLOW_ErrorCount
          ,le.cpi_credit_repair_index_ALLOW_ErrorCount
          ,le.cpi_credit_report_index_ALLOW_ErrorCount
          ,le.cpi_education_seekers_index_ALLOW_ErrorCount
          ,le.cpi_insurance_index_ALLOW_ErrorCount
          ,le.cpi_insurance_health_index_ALLOW_ErrorCount
          ,le.cpi_insurance_auto_index_ALLOW_ErrorCount
          ,le.cpi_job_seekers_index_ALLOW_ErrorCount
          ,le.cpi_social_networking_index_ALLOW_ErrorCount
          ,le.cpi_adult_index_ALLOW_ErrorCount
          ,le.cpi_africanamerican_index_ALLOW_ErrorCount
          ,le.cpi_apparel_index_ALLOW_ErrorCount
          ,le.cpi_apparel_accessory_index_ALLOW_ErrorCount
          ,le.cpi_apparel_kids_index_ALLOW_ErrorCount
          ,le.cpi_apparel_men_index_ALLOW_ErrorCount
          ,le.cpi_apparel_menfash_index_ALLOW_ErrorCount
          ,le.cpi_apparel_women_index_ALLOW_ErrorCount
          ,le.cpi_apparel_womfash_index_ALLOW_ErrorCount
          ,le.cpi_asian_index_ALLOW_ErrorCount
          ,le.cpi_auto_index_ALLOW_ErrorCount
          ,le.cpi_auto_racing_index_ALLOW_ErrorCount
          ,le.cpi_auto_trucks_index_ALLOW_ErrorCount
          ,le.cpi_aviation_index_ALLOW_ErrorCount
          ,le.cpi_bargains_index_ALLOW_ErrorCount
          ,le.cpi_beauty_index_ALLOW_ErrorCount
          ,le.cpi_bible_index_ALLOW_ErrorCount
          ,le.cpi_birds_index_ALLOW_ErrorCount
          ,le.cpi_business_index_ALLOW_ErrorCount
          ,le.cpi_business_homeoffice_index_ALLOW_ErrorCount
          ,le.cpi_catalog_index_ALLOW_ErrorCount
          ,le.cpi_cc_index_ALLOW_ErrorCount
          ,le.cpi_collectibles_index_ALLOW_ErrorCount
          ,le.cpi_college_index_ALLOW_ErrorCount
          ,le.cpi_computers_index_ALLOW_ErrorCount
          ,le.cpi_conservative_index_ALLOW_ErrorCount
          ,le.cpi_continuity_index_ALLOW_ErrorCount
          ,le.cpi_cooking_index_ALLOW_ErrorCount
          ,le.cpi_crafts_index_ALLOW_ErrorCount
          ,le.cpi_crafts_crochet_index_ALLOW_ErrorCount
          ,le.cpi_crafts_knit_index_ALLOW_ErrorCount
          ,le.cpi_crafts_needlepoint_index_ALLOW_ErrorCount
          ,le.cpi_crafts_quilt_index_ALLOW_ErrorCount
          ,le.cpi_crafts_sew_index_ALLOW_ErrorCount
          ,le.cpi_culturearts_index_ALLOW_ErrorCount
          ,le.cpi_currevent_index_ALLOW_ErrorCount
          ,le.cpi_diy_index_ALLOW_ErrorCount
          ,le.cpi_donor_index_ALLOW_ErrorCount
          ,le.cpi_ego_index_ALLOW_ErrorCount
          ,le.cpi_electronics_index_ALLOW_ErrorCount
          ,le.cpi_equestrian_index_ALLOW_ErrorCount
          ,le.cpi_family_index_ALLOW_ErrorCount
          ,le.cpi_family_teen_index_ALLOW_ErrorCount
          ,le.cpi_family_young_index_ALLOW_ErrorCount
          ,le.cpi_fiction_index_ALLOW_ErrorCount
          ,le.cpi_gambling_index_ALLOW_ErrorCount
          ,le.cpi_games_index_ALLOW_ErrorCount
          ,le.cpi_gardening_index_ALLOW_ErrorCount
          ,le.cpi_gay_index_ALLOW_ErrorCount
          ,le.cpi_giftgivr_index_ALLOW_ErrorCount
          ,le.cpi_gourmet_index_ALLOW_ErrorCount
          ,le.cpi_grandparents_index_ALLOW_ErrorCount
          ,le.cpi_health_index_ALLOW_ErrorCount
          ,le.cpi_health_diet_index_ALLOW_ErrorCount
          ,le.cpi_health_fitness_index_ALLOW_ErrorCount
          ,le.cpi_hightech_index_ALLOW_ErrorCount
          ,le.cpi_hispanic_index_ALLOW_ErrorCount
          ,le.cpi_history_index_ALLOW_ErrorCount
          ,le.cpi_history_american_index_ALLOW_ErrorCount
          ,le.cpi_hobbies_index_ALLOW_ErrorCount
          ,le.cpi_homedecr_index_ALLOW_ErrorCount
          ,le.cpi_homeliv_index_ALLOW_ErrorCount
          ,le.cpi_humor_index_ALLOW_ErrorCount
          ,le.cpi_inspiration_index_ALLOW_ErrorCount
          ,le.cpi_internet_index_ALLOW_ErrorCount
          ,le.cpi_internet_access_index_ALLOW_ErrorCount
          ,le.cpi_internet_buy_index_ALLOW_ErrorCount
          ,le.cpi_liberal_index_ALLOW_ErrorCount
          ,le.cpi_moneymaking_index_ALLOW_ErrorCount
          ,le.cpi_motorcycles_index_ALLOW_ErrorCount
          ,le.cpi_music_index_ALLOW_ErrorCount
          ,le.cpi_nonfiction_index_ALLOW_ErrorCount
          ,le.cpi_ocean_index_ALLOW_ErrorCount
          ,le.cpi_outdoors_index_ALLOW_ErrorCount
          ,le.cpi_outdoors_boatsail_index_ALLOW_ErrorCount
          ,le.cpi_outdoors_camp_index_ALLOW_ErrorCount
          ,le.cpi_outdoors_fishing_index_ALLOW_ErrorCount
          ,le.cpi_outdoors_huntfish_index_ALLOW_ErrorCount
          ,le.cpi_outdoors_hunting_index_ALLOW_ErrorCount
          ,le.cpi_pets_index_ALLOW_ErrorCount
          ,le.cpi_pets_cats_index_ALLOW_ErrorCount
          ,le.cpi_pets_dogs_index_ALLOW_ErrorCount
          ,le.cpi_pfin_index_ALLOW_ErrorCount
          ,le.cpi_photog_index_ALLOW_ErrorCount
          ,le.cpi_photoproc_index_ALLOW_ErrorCount
          ,le.cpi_publish_index_ALLOW_ErrorCount
          ,le.cpi_publish_books_index_ALLOW_ErrorCount
          ,le.cpi_publish_mags_index_ALLOW_ErrorCount
          ,le.cpi_rural_index_ALLOW_ErrorCount
          ,le.cpi_science_index_ALLOW_ErrorCount
          ,le.cpi_scifi_index_ALLOW_ErrorCount
          ,le.cpi_seniors_index_ALLOW_ErrorCount
          ,le.cpi_sports_index_ALLOW_ErrorCount
          ,le.cpi_sports_baseball_index_ALLOW_ErrorCount
          ,le.cpi_sports_basketball_index_ALLOW_ErrorCount
          ,le.cpi_sports_biking_index_ALLOW_ErrorCount
          ,le.cpi_sports_football_index_ALLOW_ErrorCount
          ,le.cpi_sports_golf_index_ALLOW_ErrorCount
          ,le.cpi_sports_hockey_index_ALLOW_ErrorCount
          ,le.cpi_sports_running_index_ALLOW_ErrorCount
          ,le.cpi_sports_ski_index_ALLOW_ErrorCount
          ,le.cpi_sports_soccer_index_ALLOW_ErrorCount
          ,le.cpi_sports_swimming_index_ALLOW_ErrorCount
          ,le.cpi_sports_tennis_index_ALLOW_ErrorCount
          ,le.cpi_stationery_index_ALLOW_ErrorCount
          ,le.cpi_sweeps_index_ALLOW_ErrorCount
          ,le.cpi_tobacco_index_ALLOW_ErrorCount
          ,le.cpi_travel_index_ALLOW_ErrorCount
          ,le.cpi_travel_cruise_index_ALLOW_ErrorCount
          ,le.cpi_travel_rv_index_ALLOW_ErrorCount
          ,le.cpi_travel_us_index_ALLOW_ErrorCount
          ,le.cpi_tvmovies_index_ALLOW_ErrorCount
          ,le.cpi_wildlife_index_ALLOW_ErrorCount
          ,le.cpi_woman_index_ALLOW_ErrorCount
          ,le.totdlr_index_ALLOW_ErrorCount
          ,le.cpi_totdlr_ALLOW_ErrorCount
          ,le.cpi_totords_ALLOW_ErrorCount
          ,le.cpi_lastdlr_ALLOW_ErrorCount
          ,le.pkcatg_ALLOW_ErrorCount
          ,le.pkpubs_ALLOW_ErrorCount
          ,le.pkcont_ALLOW_ErrorCount
          ,le.pkca01_ALLOW_ErrorCount
          ,le.pkca03_ALLOW_ErrorCount
          ,le.pkca04_ALLOW_ErrorCount
          ,le.pkca05_ALLOW_ErrorCount
          ,le.pkca06_ALLOW_ErrorCount
          ,le.pkca07_ALLOW_ErrorCount
          ,le.pkca08_ALLOW_ErrorCount
          ,le.pkca09_ALLOW_ErrorCount
          ,le.pkca10_ALLOW_ErrorCount
          ,le.pkca11_ALLOW_ErrorCount
          ,le.pkca12_ALLOW_ErrorCount
          ,le.pkca13_ALLOW_ErrorCount
          ,le.pkca14_ALLOW_ErrorCount
          ,le.pkca15_ALLOW_ErrorCount
          ,le.pkca16_ALLOW_ErrorCount
          ,le.pkca17_ALLOW_ErrorCount
          ,le.pkca18_ALLOW_ErrorCount
          ,le.pkca20_ALLOW_ErrorCount
          ,le.pkca21_ALLOW_ErrorCount
          ,le.pkca22_ALLOW_ErrorCount
          ,le.pkca23_ALLOW_ErrorCount
          ,le.pkca24_ALLOW_ErrorCount
          ,le.pkca25_ALLOW_ErrorCount
          ,le.pkca26_ALLOW_ErrorCount
          ,le.pkca28_ALLOW_ErrorCount
          ,le.pkca29_ALLOW_ErrorCount
          ,le.pkca30_ALLOW_ErrorCount
          ,le.pkca31_ALLOW_ErrorCount
          ,le.pkca32_ALLOW_ErrorCount
          ,le.pkca33_ALLOW_ErrorCount
          ,le.pkca34_ALLOW_ErrorCount
          ,le.pkca35_ALLOW_ErrorCount
          ,le.pkca36_ALLOW_ErrorCount
          ,le.pkca37_ALLOW_ErrorCount
          ,le.pkca39_ALLOW_ErrorCount
          ,le.pkca40_ALLOW_ErrorCount
          ,le.pkca41_ALLOW_ErrorCount
          ,le.pkca42_ALLOW_ErrorCount
          ,le.pkca54_ALLOW_ErrorCount
          ,le.pkca61_ALLOW_ErrorCount
          ,le.pkca62_ALLOW_ErrorCount
          ,le.pkca64_ALLOW_ErrorCount
          ,le.pkpu01_ALLOW_ErrorCount
          ,le.pkpu02_ALLOW_ErrorCount
          ,le.pkpu03_ALLOW_ErrorCount
          ,le.pkpu04_ALLOW_ErrorCount
          ,le.pkpu05_ALLOW_ErrorCount
          ,le.pkpu06_ALLOW_ErrorCount
          ,le.pkpu07_ALLOW_ErrorCount
          ,le.pkpu08_ALLOW_ErrorCount
          ,le.pkpu09_ALLOW_ErrorCount
          ,le.pkpu10_ALLOW_ErrorCount
          ,le.pkpu11_ALLOW_ErrorCount
          ,le.pkpu12_ALLOW_ErrorCount
          ,le.pkpu13_ALLOW_ErrorCount
          ,le.pkpu14_ALLOW_ErrorCount
          ,le.pkpu15_ALLOW_ErrorCount
          ,le.pkpu16_ALLOW_ErrorCount
          ,le.pkpu17_ALLOW_ErrorCount
          ,le.pkpu18_ALLOW_ErrorCount
          ,le.pkpu19_ALLOW_ErrorCount
          ,le.pkpu20_ALLOW_ErrorCount
          ,le.pkpu23_ALLOW_ErrorCount
          ,le.pkpu25_ALLOW_ErrorCount
          ,le.pkpu27_ALLOW_ErrorCount
          ,le.pkpu28_ALLOW_ErrorCount
          ,le.pkpu29_ALLOW_ErrorCount
          ,le.pkpu30_ALLOW_ErrorCount
          ,le.pkpu31_ALLOW_ErrorCount
          ,le.pkpu32_ALLOW_ErrorCount
          ,le.pkpu33_ALLOW_ErrorCount
          ,le.pkpu34_ALLOW_ErrorCount
          ,le.pkpu35_ALLOW_ErrorCount
          ,le.pkpu38_ALLOW_ErrorCount
          ,le.pkpu41_ALLOW_ErrorCount
          ,le.pkpu42_ALLOW_ErrorCount
          ,le.pkpu45_ALLOW_ErrorCount
          ,le.pkpu46_ALLOW_ErrorCount
          ,le.pkpu47_ALLOW_ErrorCount
          ,le.pkpu48_ALLOW_ErrorCount
          ,le.pkpu49_ALLOW_ErrorCount
          ,le.pkpu50_ALLOW_ErrorCount
          ,le.pkpu51_ALLOW_ErrorCount
          ,le.pkpu52_ALLOW_ErrorCount
          ,le.pkpu53_ALLOW_ErrorCount
          ,le.pkpu54_ALLOW_ErrorCount
          ,le.pkpu55_ALLOW_ErrorCount
          ,le.pkpu56_ALLOW_ErrorCount
          ,le.pkpu57_ALLOW_ErrorCount
          ,le.pkpu60_ALLOW_ErrorCount
          ,le.pkpu61_ALLOW_ErrorCount
          ,le.pkpu62_ALLOW_ErrorCount
          ,le.pkpu63_ALLOW_ErrorCount
          ,le.pkpu64_ALLOW_ErrorCount
          ,le.pkpu65_ALLOW_ErrorCount
          ,le.pkpu66_ALLOW_ErrorCount
          ,le.pkpu67_ALLOW_ErrorCount
          ,le.pkpu68_ALLOW_ErrorCount
          ,le.pkpu69_ALLOW_ErrorCount
          ,le.pkpu70_ALLOW_ErrorCount
          ,le.censpct_water_ALLOW_ErrorCount
          ,le.cens_pop_density_ALLOW_ErrorCount
          ,le.cens_hu_density_ALLOW_ErrorCount
          ,le.censpct_pop_white_ALLOW_ErrorCount
          ,le.censpct_pop_black_ALLOW_ErrorCount
          ,le.censpct_pop_amerind_ALLOW_ErrorCount
          ,le.censpct_pop_asian_ALLOW_ErrorCount
          ,le.censpct_pop_pacisl_ALLOW_ErrorCount
          ,le.censpct_pop_othrace_ALLOW_ErrorCount
          ,le.censpct_pop_multirace_ALLOW_ErrorCount
          ,le.censpct_pop_hispanic_ALLOW_ErrorCount
          ,le.censpct_pop_agelt18_ALLOW_ErrorCount
          ,le.censpct_pop_males_ALLOW_ErrorCount
          ,le.censpct_adult_age1824_ALLOW_ErrorCount
          ,le.censpct_adult_age2534_ALLOW_ErrorCount
          ,le.censpct_adult_age3544_ALLOW_ErrorCount
          ,le.censpct_adult_age4554_ALLOW_ErrorCount
          ,le.censpct_adult_age5564_ALLOW_ErrorCount
          ,le.censpct_adult_agege65_ALLOW_ErrorCount
          ,le.cens_pop_medage_ALLOW_ErrorCount
          ,le.cens_hh_avgsize_ALLOW_ErrorCount
          ,le.censpct_hh_family_ALLOW_ErrorCount
          ,le.censpct_hh_family_husbwife_ALLOW_ErrorCount
          ,le.censpct_hu_occupied_ALLOW_ErrorCount
          ,le.censpct_hu_owned_ALLOW_ErrorCount
          ,le.censpct_hu_rented_ALLOW_ErrorCount
          ,le.censpct_hu_vacantseasonal_ALLOW_ErrorCount
          ,le.zip_medinc_ALLOW_ErrorCount
          ,le.zip_apparel_ALLOW_ErrorCount
          ,le.zip_apparel_women_ALLOW_ErrorCount
          ,le.zip_apparel_womfash_ALLOW_ErrorCount
          ,le.zip_auto_ALLOW_ErrorCount
          ,le.zip_beauty_ALLOW_ErrorCount
          ,le.zip_booksmusicmovies_ALLOW_ErrorCount
          ,le.zip_business_ALLOW_ErrorCount
          ,le.zip_catalog_ALLOW_ErrorCount
          ,le.zip_cc_ALLOW_ErrorCount
          ,le.zip_collectibles_ALLOW_ErrorCount
          ,le.zip_computers_ALLOW_ErrorCount
          ,le.zip_continuity_ALLOW_ErrorCount
          ,le.zip_cooking_ALLOW_ErrorCount
          ,le.zip_crafts_ALLOW_ErrorCount
          ,le.zip_culturearts_ALLOW_ErrorCount
          ,le.zip_dm_sold_ALLOW_ErrorCount
          ,le.zip_donor_ALLOW_ErrorCount
          ,le.zip_family_ALLOW_ErrorCount
          ,le.zip_gardening_ALLOW_ErrorCount
          ,le.zip_giftgivr_ALLOW_ErrorCount
          ,le.zip_gourmet_ALLOW_ErrorCount
          ,le.zip_health_ALLOW_ErrorCount
          ,le.zip_health_diet_ALLOW_ErrorCount
          ,le.zip_health_fitness_ALLOW_ErrorCount
          ,le.zip_hobbies_ALLOW_ErrorCount
          ,le.zip_homedecr_ALLOW_ErrorCount
          ,le.zip_homeliv_ALLOW_ErrorCount
          ,le.zip_internet_ALLOW_ErrorCount
          ,le.zip_internet_access_ALLOW_ErrorCount
          ,le.zip_internet_buy_ALLOW_ErrorCount
          ,le.zip_music_ALLOW_ErrorCount
          ,le.zip_outdoors_ALLOW_ErrorCount
          ,le.zip_pets_ALLOW_ErrorCount
          ,le.zip_pfin_ALLOW_ErrorCount
          ,le.zip_publish_ALLOW_ErrorCount
          ,le.zip_publish_books_ALLOW_ErrorCount
          ,le.zip_publish_mags_ALLOW_ErrorCount
          ,le.zip_sports_ALLOW_ErrorCount
          ,le.zip_sports_biking_ALLOW_ErrorCount
          ,le.zip_sports_golf_ALLOW_ErrorCount
          ,le.zip_travel_ALLOW_ErrorCount
          ,le.zip_travel_us_ALLOW_ErrorCount
          ,le.zip_tvmovies_ALLOW_ErrorCount
          ,le.zip_woman_ALLOW_ErrorCount
          ,le.zip_proftech_ALLOW_ErrorCount
          ,le.zip_retired_ALLOW_ErrorCount
          ,le.zip_inc100_ALLOW_ErrorCount
          ,le.zip_inc75_ALLOW_ErrorCount
          ,le.zip_inc50_ALLOW_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_WithErrors/NumFieldsWithRules * 100)
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_NoErrors/NumFieldsWithRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_WithErrors/NumRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_NoErrors/NumRules * 100)
          ,0
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithErrorsCount/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, (SELF.recordstotal - le.AnyRule_WithErrorsCount)/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithEditsCount/SELF.recordstotal * 100)
          ,IF(NumRulesWithPossibleEdits = 0, 0, le.Rules_WithEdits/NumRulesWithPossibleEdits * 100),0));
    END;
    SummaryInfo := NORMALIZE(SummaryStats,NumRules + 9,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT311.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT311.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);

    // field population stats
    mod_hygiene := hygiene(PROJECT(h, Layout_Dunndata_Consumer));
    hygiene_summaryStats := mod_hygiene.Summary('');
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT311.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'dtmatch:' + getFieldTypeText(h.dtmatch) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'msname:' + getFieldTypeText(h.msname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'msaddr1:' + getFieldTypeText(h.msaddr1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'msaddr2:' + getFieldTypeText(h.msaddr2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mscity:' + getFieldTypeText(h.mscity) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'msstate:' + getFieldTypeText(h.msstate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mszip5:' + getFieldTypeText(h.mszip5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mszip4:' + getFieldTypeText(h.mszip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dthh:' + getFieldTypeText(h.dthh) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mscrrt:' + getFieldTypeText(h.mscrrt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'msdpbc:' + getFieldTypeText(h.msdpbc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'msdpv:' + getFieldTypeText(h.msdpv) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_addrtype:' + getFieldTypeText(h.ms_addrtype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ctysize:' + getFieldTypeText(h.ctysize) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lmos:' + getFieldTypeText(h.lmos) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'omos:' + getFieldTypeText(h.omos) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pmos:' + getFieldTypeText(h.pmos) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'gen:' + getFieldTypeText(h.gen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dob:' + getFieldTypeText(h.dob) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'age:' + getFieldTypeText(h.age) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'inc:' + getFieldTypeText(h.inc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'marital_status:' + getFieldTypeText(h.marital_status) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'poc:' + getFieldTypeText(h.poc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'noc:' + getFieldTypeText(h.noc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ocp:' + getFieldTypeText(h.ocp) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'edu:' + getFieldTypeText(h.edu) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lang:' + getFieldTypeText(h.lang) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'relig:' + getFieldTypeText(h.relig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dwell:' + getFieldTypeText(h.dwell) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ownr:' + getFieldTypeText(h.ownr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'eth1:' + getFieldTypeText(h.eth1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'eth2:' + getFieldTypeText(h.eth2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lor:' + getFieldTypeText(h.lor) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pool:' + getFieldTypeText(h.pool) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'speak_span:' + getFieldTypeText(h.speak_span) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'soho:' + getFieldTypeText(h.soho) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vet_in_hh:' + getFieldTypeText(h.vet_in_hh) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_mags:' + getFieldTypeText(h.ms_mags) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_books:' + getFieldTypeText(h.ms_books) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_publish:' + getFieldTypeText(h.ms_publish) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_status_active:' + getFieldTypeText(h.ms_pub_status_active) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_status_expire:' + getFieldTypeText(h.ms_pub_status_expire) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_premsold:' + getFieldTypeText(h.ms_pub_premsold) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_autornwl:' + getFieldTypeText(h.ms_pub_autornwl) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_avgterm:' + getFieldTypeText(h.ms_pub_avgterm) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_lmos:' + getFieldTypeText(h.ms_pub_lmos) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_omos:' + getFieldTypeText(h.ms_pub_omos) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_pmos:' + getFieldTypeText(h.ms_pub_pmos) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_cemos:' + getFieldTypeText(h.ms_pub_cemos) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_femos:' + getFieldTypeText(h.ms_pub_femos) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_totords:' + getFieldTypeText(h.ms_pub_totords) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_totdlrs:' + getFieldTypeText(h.ms_pub_totdlrs) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_avgdlrs:' + getFieldTypeText(h.ms_pub_avgdlrs) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_lastdlrs:' + getFieldTypeText(h.ms_pub_lastdlrs) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_paystat_paid:' + getFieldTypeText(h.ms_pub_paystat_paid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_paystat_ub:' + getFieldTypeText(h.ms_pub_paystat_ub) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_paymeth_cc:' + getFieldTypeText(h.ms_pub_paymeth_cc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_paymeth_cash:' + getFieldTypeText(h.ms_pub_paymeth_cash) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_payspeed:' + getFieldTypeText(h.ms_pub_payspeed) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_osrc_dm:' + getFieldTypeText(h.ms_pub_osrc_dm) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_lsrc_dm:' + getFieldTypeText(h.ms_pub_lsrc_dm) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_osrc_agt_cashf:' + getFieldTypeText(h.ms_pub_osrc_agt_cashf) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_lsrc_agt_cashf:' + getFieldTypeText(h.ms_pub_lsrc_agt_cashf) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_osrc_agt_pds:' + getFieldTypeText(h.ms_pub_osrc_agt_pds) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_lsrc_agt_pds:' + getFieldTypeText(h.ms_pub_lsrc_agt_pds) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_osrc_agt_schplan:' + getFieldTypeText(h.ms_pub_osrc_agt_schplan) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_lsrc_agt_schplan:' + getFieldTypeText(h.ms_pub_lsrc_agt_schplan) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_osrc_agt_sponsor:' + getFieldTypeText(h.ms_pub_osrc_agt_sponsor) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_lsrc_agt_sponsor:' + getFieldTypeText(h.ms_pub_lsrc_agt_sponsor) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_osrc_agt_tm:' + getFieldTypeText(h.ms_pub_osrc_agt_tm) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_lsrc_agt_tm:' + getFieldTypeText(h.ms_pub_lsrc_agt_tm) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_osrc_agt:' + getFieldTypeText(h.ms_pub_osrc_agt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_lsrc_agt:' + getFieldTypeText(h.ms_pub_lsrc_agt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_osrc_tm:' + getFieldTypeText(h.ms_pub_osrc_tm) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_lsrc_tm:' + getFieldTypeText(h.ms_pub_lsrc_tm) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_osrc_ins:' + getFieldTypeText(h.ms_pub_osrc_ins) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_lsrc_ins:' + getFieldTypeText(h.ms_pub_lsrc_ins) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_osrc_net:' + getFieldTypeText(h.ms_pub_osrc_net) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_lsrc_net:' + getFieldTypeText(h.ms_pub_lsrc_net) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_osrc_print:' + getFieldTypeText(h.ms_pub_osrc_print) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_lsrc_print:' + getFieldTypeText(h.ms_pub_lsrc_print) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_osrc_trans:' + getFieldTypeText(h.ms_pub_osrc_trans) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_lsrc_trans:' + getFieldTypeText(h.ms_pub_lsrc_trans) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_osrc_tv:' + getFieldTypeText(h.ms_pub_osrc_tv) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_lsrc_tv:' + getFieldTypeText(h.ms_pub_lsrc_tv) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_osrc_dtp:' + getFieldTypeText(h.ms_pub_osrc_dtp) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_lsrc_dtp:' + getFieldTypeText(h.ms_pub_lsrc_dtp) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_giftgivr:' + getFieldTypeText(h.ms_pub_giftgivr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_giftee:' + getFieldTypeText(h.ms_pub_giftee) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_catalog:' + getFieldTypeText(h.ms_catalog) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_cat_lmos:' + getFieldTypeText(h.ms_cat_lmos) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_cat_omos:' + getFieldTypeText(h.ms_cat_omos) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_cat_pmos:' + getFieldTypeText(h.ms_cat_pmos) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_cat_totords:' + getFieldTypeText(h.ms_cat_totords) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_cat_totitems:' + getFieldTypeText(h.ms_cat_totitems) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_cat_totdlrs:' + getFieldTypeText(h.ms_cat_totdlrs) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_cat_avgdlrs:' + getFieldTypeText(h.ms_cat_avgdlrs) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_cat_lastdlrs:' + getFieldTypeText(h.ms_cat_lastdlrs) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_cat_paystat_paid:' + getFieldTypeText(h.ms_cat_paystat_paid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_cat_paymeth_cc:' + getFieldTypeText(h.ms_cat_paymeth_cc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_cat_paymeth_cash:' + getFieldTypeText(h.ms_cat_paymeth_cash) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_cat_osrc_dm:' + getFieldTypeText(h.ms_cat_osrc_dm) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_cat_lsrc_dm:' + getFieldTypeText(h.ms_cat_lsrc_dm) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_cat_osrc_net:' + getFieldTypeText(h.ms_cat_osrc_net) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_cat_lsrc_net:' + getFieldTypeText(h.ms_cat_lsrc_net) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_cat_giftgivr:' + getFieldTypeText(h.ms_cat_giftgivr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpubs_corrected:' + getFieldTypeText(h.pkpubs_corrected) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkcatg_corrected:' + getFieldTypeText(h.pkcatg_corrected) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_fundraising:' + getFieldTypeText(h.ms_fundraising) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_fund_lmos:' + getFieldTypeText(h.ms_fund_lmos) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_fund_omos:' + getFieldTypeText(h.ms_fund_omos) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_fund_pmos:' + getFieldTypeText(h.ms_fund_pmos) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_fund_totords:' + getFieldTypeText(h.ms_fund_totords) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_fund_totdlrs:' + getFieldTypeText(h.ms_fund_totdlrs) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_fund_avgdlrs:' + getFieldTypeText(h.ms_fund_avgdlrs) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_fund_lastdlrs:' + getFieldTypeText(h.ms_fund_lastdlrs) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_fund_paystat_paid:' + getFieldTypeText(h.ms_fund_paystat_paid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_other:' + getFieldTypeText(h.ms_other) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_continuity:' + getFieldTypeText(h.ms_continuity) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_cont_status_active:' + getFieldTypeText(h.ms_cont_status_active) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_cont_status_cancel:' + getFieldTypeText(h.ms_cont_status_cancel) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_cont_omos:' + getFieldTypeText(h.ms_cont_omos) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_cont_lmos:' + getFieldTypeText(h.ms_cont_lmos) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_cont_pmos:' + getFieldTypeText(h.ms_cont_pmos) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_cont_totords:' + getFieldTypeText(h.ms_cont_totords) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_cont_totdlrs:' + getFieldTypeText(h.ms_cont_totdlrs) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_cont_avgdlrs:' + getFieldTypeText(h.ms_cont_avgdlrs) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_cont_lastdlrs:' + getFieldTypeText(h.ms_cont_lastdlrs) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_cont_paystat_paid:' + getFieldTypeText(h.ms_cont_paystat_paid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_cont_paymeth_cc:' + getFieldTypeText(h.ms_cont_paymeth_cc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_cont_paymeth_cash:' + getFieldTypeText(h.ms_cont_paymeth_cash) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_totords:' + getFieldTypeText(h.ms_totords) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_totitems:' + getFieldTypeText(h.ms_totitems) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_totdlrs:' + getFieldTypeText(h.ms_totdlrs) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_avgdlrs:' + getFieldTypeText(h.ms_avgdlrs) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_lastdlrs:' + getFieldTypeText(h.ms_lastdlrs) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_paystat_paid:' + getFieldTypeText(h.ms_paystat_paid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_paymeth_cc:' + getFieldTypeText(h.ms_paymeth_cc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_paymeth_cash:' + getFieldTypeText(h.ms_paymeth_cash) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_osrc_dm:' + getFieldTypeText(h.ms_osrc_dm) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_lsrc_dm:' + getFieldTypeText(h.ms_lsrc_dm) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_osrc_tm:' + getFieldTypeText(h.ms_osrc_tm) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_lsrc_tm:' + getFieldTypeText(h.ms_lsrc_tm) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_osrc_ins:' + getFieldTypeText(h.ms_osrc_ins) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_lsrc_ins:' + getFieldTypeText(h.ms_lsrc_ins) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_osrc_net:' + getFieldTypeText(h.ms_osrc_net) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_lsrc_net:' + getFieldTypeText(h.ms_lsrc_net) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_osrc_tv:' + getFieldTypeText(h.ms_osrc_tv) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_lsrc_tv:' + getFieldTypeText(h.ms_lsrc_tv) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_osrc_retail:' + getFieldTypeText(h.ms_osrc_retail) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_lsrc_retail:' + getFieldTypeText(h.ms_lsrc_retail) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_giftgivr:' + getFieldTypeText(h.ms_giftgivr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_giftee:' + getFieldTypeText(h.ms_giftee) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_adult:' + getFieldTypeText(h.ms_adult) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_womapp:' + getFieldTypeText(h.ms_womapp) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_menapp:' + getFieldTypeText(h.ms_menapp) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_kidapp:' + getFieldTypeText(h.ms_kidapp) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_accessory:' + getFieldTypeText(h.ms_accessory) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_apparel:' + getFieldTypeText(h.ms_apparel) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_app_lmos:' + getFieldTypeText(h.ms_app_lmos) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_app_omos:' + getFieldTypeText(h.ms_app_omos) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_app_pmos:' + getFieldTypeText(h.ms_app_pmos) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_app_totords:' + getFieldTypeText(h.ms_app_totords) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_app_totitems:' + getFieldTypeText(h.ms_app_totitems) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_app_totdlrs:' + getFieldTypeText(h.ms_app_totdlrs) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_app_avgdlrs:' + getFieldTypeText(h.ms_app_avgdlrs) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_app_lastdlrs:' + getFieldTypeText(h.ms_app_lastdlrs) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_app_paystat_paid:' + getFieldTypeText(h.ms_app_paystat_paid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_app_paymeth_cc:' + getFieldTypeText(h.ms_app_paymeth_cc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_app_paymeth_cash:' + getFieldTypeText(h.ms_app_paymeth_cash) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_menfash:' + getFieldTypeText(h.ms_menfash) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_womfash:' + getFieldTypeText(h.ms_womfash) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_wfsh_lmos:' + getFieldTypeText(h.ms_wfsh_lmos) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_wfsh_omos:' + getFieldTypeText(h.ms_wfsh_omos) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_wfsh_pmos:' + getFieldTypeText(h.ms_wfsh_pmos) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_wfsh_totords:' + getFieldTypeText(h.ms_wfsh_totords) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_wfsh_totdlrs:' + getFieldTypeText(h.ms_wfsh_totdlrs) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_wfsh_avgdlrs:' + getFieldTypeText(h.ms_wfsh_avgdlrs) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_wfsh_lastdlrs:' + getFieldTypeText(h.ms_wfsh_lastdlrs) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_wfsh_paystat_paid:' + getFieldTypeText(h.ms_wfsh_paystat_paid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_wfsh_osrc_dm:' + getFieldTypeText(h.ms_wfsh_osrc_dm) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_wfsh_lsrc_dm:' + getFieldTypeText(h.ms_wfsh_lsrc_dm) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_wfsh_osrc_agt:' + getFieldTypeText(h.ms_wfsh_osrc_agt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_wfsh_lsrc_agt:' + getFieldTypeText(h.ms_wfsh_lsrc_agt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_audio:' + getFieldTypeText(h.ms_audio) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_auto:' + getFieldTypeText(h.ms_auto) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_aviation:' + getFieldTypeText(h.ms_aviation) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_bargains:' + getFieldTypeText(h.ms_bargains) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_beauty:' + getFieldTypeText(h.ms_beauty) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_bible:' + getFieldTypeText(h.ms_bible) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_bible_lmos:' + getFieldTypeText(h.ms_bible_lmos) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_bible_omos:' + getFieldTypeText(h.ms_bible_omos) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_bible_pmos:' + getFieldTypeText(h.ms_bible_pmos) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_bible_totords:' + getFieldTypeText(h.ms_bible_totords) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_bible_totitems:' + getFieldTypeText(h.ms_bible_totitems) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_bible_totdlrs:' + getFieldTypeText(h.ms_bible_totdlrs) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_bible_avgdlrs:' + getFieldTypeText(h.ms_bible_avgdlrs) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_bible_lastdlrs:' + getFieldTypeText(h.ms_bible_lastdlrs) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_bible_paystat_paid:' + getFieldTypeText(h.ms_bible_paystat_paid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_bible_paymeth_cc:' + getFieldTypeText(h.ms_bible_paymeth_cc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_bible_paymeth_cash:' + getFieldTypeText(h.ms_bible_paymeth_cash) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_business:' + getFieldTypeText(h.ms_business) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_collectibles:' + getFieldTypeText(h.ms_collectibles) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_computers:' + getFieldTypeText(h.ms_computers) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_crafts:' + getFieldTypeText(h.ms_crafts) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_culturearts:' + getFieldTypeText(h.ms_culturearts) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_currevent:' + getFieldTypeText(h.ms_currevent) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_diy:' + getFieldTypeText(h.ms_diy) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_electronics:' + getFieldTypeText(h.ms_electronics) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_equestrian:' + getFieldTypeText(h.ms_equestrian) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_family:' + getFieldTypeText(h.ms_pub_family) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_cat_family:' + getFieldTypeText(h.ms_cat_family) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_family:' + getFieldTypeText(h.ms_family) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_family_lmos:' + getFieldTypeText(h.ms_family_lmos) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_family_omos:' + getFieldTypeText(h.ms_family_omos) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_family_pmos:' + getFieldTypeText(h.ms_family_pmos) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_family_totords:' + getFieldTypeText(h.ms_family_totords) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_family_totitems:' + getFieldTypeText(h.ms_family_totitems) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_family_totdlrs:' + getFieldTypeText(h.ms_family_totdlrs) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_family_avgdlrs:' + getFieldTypeText(h.ms_family_avgdlrs) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_family_lastdlrs:' + getFieldTypeText(h.ms_family_lastdlrs) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_family_paystat_paid:' + getFieldTypeText(h.ms_family_paystat_paid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_family_paymeth_cc:' + getFieldTypeText(h.ms_family_paymeth_cc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_family_paymeth_cash:' + getFieldTypeText(h.ms_family_paymeth_cash) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_family_osrc_dm:' + getFieldTypeText(h.ms_family_osrc_dm) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_family_lsrc_dm:' + getFieldTypeText(h.ms_family_lsrc_dm) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_fiction:' + getFieldTypeText(h.ms_fiction) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_food:' + getFieldTypeText(h.ms_food) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_games:' + getFieldTypeText(h.ms_games) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_gifts:' + getFieldTypeText(h.ms_gifts) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_gourmet:' + getFieldTypeText(h.ms_gourmet) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_fitness:' + getFieldTypeText(h.ms_fitness) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_health:' + getFieldTypeText(h.ms_health) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_hlth_lmos:' + getFieldTypeText(h.ms_hlth_lmos) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_hlth_omos:' + getFieldTypeText(h.ms_hlth_omos) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_hlth_pmos:' + getFieldTypeText(h.ms_hlth_pmos) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_hlth_totords:' + getFieldTypeText(h.ms_hlth_totords) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_hlth_totdlrs:' + getFieldTypeText(h.ms_hlth_totdlrs) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_hlth_avgdlrs:' + getFieldTypeText(h.ms_hlth_avgdlrs) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_hlth_lastdlrs:' + getFieldTypeText(h.ms_hlth_lastdlrs) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_hlth_paystat_paid:' + getFieldTypeText(h.ms_hlth_paystat_paid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_hlth_paymeth_cc:' + getFieldTypeText(h.ms_hlth_paymeth_cc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_hlth_osrc_dm:' + getFieldTypeText(h.ms_hlth_osrc_dm) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_hlth_lsrc_dm:' + getFieldTypeText(h.ms_hlth_lsrc_dm) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_hlth_osrc_agt:' + getFieldTypeText(h.ms_hlth_osrc_agt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_hlth_lsrc_agt:' + getFieldTypeText(h.ms_hlth_lsrc_agt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_hlth_osrc_tv:' + getFieldTypeText(h.ms_hlth_osrc_tv) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_hlth_lsrc_tv:' + getFieldTypeText(h.ms_hlth_lsrc_tv) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_holiday:' + getFieldTypeText(h.ms_holiday) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_history:' + getFieldTypeText(h.ms_history) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_cooking:' + getFieldTypeText(h.ms_pub_cooking) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_cooking:' + getFieldTypeText(h.ms_cooking) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_homedecr:' + getFieldTypeText(h.ms_pub_homedecr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_cat_homedecr:' + getFieldTypeText(h.ms_cat_homedecr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_homedecr:' + getFieldTypeText(h.ms_homedecr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_housewares:' + getFieldTypeText(h.ms_housewares) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_garden:' + getFieldTypeText(h.ms_pub_garden) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_cat_garden:' + getFieldTypeText(h.ms_cat_garden) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_garden:' + getFieldTypeText(h.ms_garden) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_homeliv:' + getFieldTypeText(h.ms_pub_homeliv) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_cat_homeliv:' + getFieldTypeText(h.ms_cat_homeliv) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_homeliv:' + getFieldTypeText(h.ms_homeliv) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_home_status_active:' + getFieldTypeText(h.ms_pub_home_status_active) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_home_lmos:' + getFieldTypeText(h.ms_home_lmos) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_home_omos:' + getFieldTypeText(h.ms_home_omos) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_home_pmos:' + getFieldTypeText(h.ms_home_pmos) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_home_totords:' + getFieldTypeText(h.ms_home_totords) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_home_totitems:' + getFieldTypeText(h.ms_home_totitems) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_home_totdlrs:' + getFieldTypeText(h.ms_home_totdlrs) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_home_avgdlrs:' + getFieldTypeText(h.ms_home_avgdlrs) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_home_lastdlrs:' + getFieldTypeText(h.ms_home_lastdlrs) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_home_paystat_paid:' + getFieldTypeText(h.ms_home_paystat_paid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_home_paymeth_cc:' + getFieldTypeText(h.ms_home_paymeth_cc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_home_paymeth_cash:' + getFieldTypeText(h.ms_home_paymeth_cash) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_home_osrc_dm:' + getFieldTypeText(h.ms_home_osrc_dm) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_home_lsrc_dm:' + getFieldTypeText(h.ms_home_lsrc_dm) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_home_osrc_agt:' + getFieldTypeText(h.ms_home_osrc_agt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_home_lsrc_agt:' + getFieldTypeText(h.ms_home_lsrc_agt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_home_osrc_net:' + getFieldTypeText(h.ms_home_osrc_net) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_home_lsrc_net:' + getFieldTypeText(h.ms_home_lsrc_net) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_home_osrc_tv:' + getFieldTypeText(h.ms_home_osrc_tv) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_home_lsrc_tv:' + getFieldTypeText(h.ms_home_lsrc_tv) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_humor:' + getFieldTypeText(h.ms_humor) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_inspiration:' + getFieldTypeText(h.ms_inspiration) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_merchandise:' + getFieldTypeText(h.ms_merchandise) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_moneymaking:' + getFieldTypeText(h.ms_moneymaking) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_moneymaking_lmos:' + getFieldTypeText(h.ms_moneymaking_lmos) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_motorcycles:' + getFieldTypeText(h.ms_motorcycles) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_music:' + getFieldTypeText(h.ms_music) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_fishing:' + getFieldTypeText(h.ms_fishing) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_hunting:' + getFieldTypeText(h.ms_hunting) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_boatsail:' + getFieldTypeText(h.ms_boatsail) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_camp:' + getFieldTypeText(h.ms_camp) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_outdoors:' + getFieldTypeText(h.ms_pub_outdoors) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_cat_outdoors:' + getFieldTypeText(h.ms_cat_outdoors) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_outdoors:' + getFieldTypeText(h.ms_outdoors) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pub_out_status_active:' + getFieldTypeText(h.ms_pub_out_status_active) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_out_lmos:' + getFieldTypeText(h.ms_out_lmos) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_out_omos:' + getFieldTypeText(h.ms_out_omos) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_out_pmos:' + getFieldTypeText(h.ms_out_pmos) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_out_totords:' + getFieldTypeText(h.ms_out_totords) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_out_totitems:' + getFieldTypeText(h.ms_out_totitems) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_out_totdlrs:' + getFieldTypeText(h.ms_out_totdlrs) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_out_avgdlrs:' + getFieldTypeText(h.ms_out_avgdlrs) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_out_lastdlrs:' + getFieldTypeText(h.ms_out_lastdlrs) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_out_paystat_paid:' + getFieldTypeText(h.ms_out_paystat_paid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_out_paymeth_cc:' + getFieldTypeText(h.ms_out_paymeth_cc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_out_paymeth_cash:' + getFieldTypeText(h.ms_out_paymeth_cash) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_out_osrc_dm:' + getFieldTypeText(h.ms_out_osrc_dm) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_out_lsrc_dm:' + getFieldTypeText(h.ms_out_lsrc_dm) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_out_osrc_agt:' + getFieldTypeText(h.ms_out_osrc_agt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_out_lsrc_agt:' + getFieldTypeText(h.ms_out_lsrc_agt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pets:' + getFieldTypeText(h.ms_pets) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_pfin:' + getFieldTypeText(h.ms_pfin) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_photo:' + getFieldTypeText(h.ms_photo) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_photoproc:' + getFieldTypeText(h.ms_photoproc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_rural:' + getFieldTypeText(h.ms_rural) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_science:' + getFieldTypeText(h.ms_science) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_sports:' + getFieldTypeText(h.ms_sports) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_sports_lmos:' + getFieldTypeText(h.ms_sports_lmos) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_travel:' + getFieldTypeText(h.ms_travel) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_tvmovies:' + getFieldTypeText(h.ms_tvmovies) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_wildlife:' + getFieldTypeText(h.ms_wildlife) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_woman:' + getFieldTypeText(h.ms_woman) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_woman_lmos:' + getFieldTypeText(h.ms_woman_lmos) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ms_ringtones_apps:' + getFieldTypeText(h.ms_ringtones_apps) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_mobile_apps_index:' + getFieldTypeText(h.cpi_mobile_apps_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_credit_repair_index:' + getFieldTypeText(h.cpi_credit_repair_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_credit_report_index:' + getFieldTypeText(h.cpi_credit_report_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_education_seekers_index:' + getFieldTypeText(h.cpi_education_seekers_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_insurance_index:' + getFieldTypeText(h.cpi_insurance_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_insurance_health_index:' + getFieldTypeText(h.cpi_insurance_health_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_insurance_auto_index:' + getFieldTypeText(h.cpi_insurance_auto_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_job_seekers_index:' + getFieldTypeText(h.cpi_job_seekers_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_social_networking_index:' + getFieldTypeText(h.cpi_social_networking_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_adult_index:' + getFieldTypeText(h.cpi_adult_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_africanamerican_index:' + getFieldTypeText(h.cpi_africanamerican_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_apparel_index:' + getFieldTypeText(h.cpi_apparel_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_apparel_accessory_index:' + getFieldTypeText(h.cpi_apparel_accessory_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_apparel_kids_index:' + getFieldTypeText(h.cpi_apparel_kids_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_apparel_men_index:' + getFieldTypeText(h.cpi_apparel_men_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_apparel_menfash_index:' + getFieldTypeText(h.cpi_apparel_menfash_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_apparel_women_index:' + getFieldTypeText(h.cpi_apparel_women_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_apparel_womfash_index:' + getFieldTypeText(h.cpi_apparel_womfash_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_asian_index:' + getFieldTypeText(h.cpi_asian_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_auto_index:' + getFieldTypeText(h.cpi_auto_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_auto_racing_index:' + getFieldTypeText(h.cpi_auto_racing_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_auto_trucks_index:' + getFieldTypeText(h.cpi_auto_trucks_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_aviation_index:' + getFieldTypeText(h.cpi_aviation_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_bargains_index:' + getFieldTypeText(h.cpi_bargains_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_beauty_index:' + getFieldTypeText(h.cpi_beauty_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_bible_index:' + getFieldTypeText(h.cpi_bible_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_birds_index:' + getFieldTypeText(h.cpi_birds_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_business_index:' + getFieldTypeText(h.cpi_business_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_business_homeoffice_index:' + getFieldTypeText(h.cpi_business_homeoffice_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_catalog_index:' + getFieldTypeText(h.cpi_catalog_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_cc_index:' + getFieldTypeText(h.cpi_cc_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_collectibles_index:' + getFieldTypeText(h.cpi_collectibles_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_college_index:' + getFieldTypeText(h.cpi_college_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_computers_index:' + getFieldTypeText(h.cpi_computers_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_conservative_index:' + getFieldTypeText(h.cpi_conservative_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_continuity_index:' + getFieldTypeText(h.cpi_continuity_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_cooking_index:' + getFieldTypeText(h.cpi_cooking_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_crafts_index:' + getFieldTypeText(h.cpi_crafts_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_crafts_crochet_index:' + getFieldTypeText(h.cpi_crafts_crochet_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_crafts_knit_index:' + getFieldTypeText(h.cpi_crafts_knit_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_crafts_needlepoint_index:' + getFieldTypeText(h.cpi_crafts_needlepoint_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_crafts_quilt_index:' + getFieldTypeText(h.cpi_crafts_quilt_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_crafts_sew_index:' + getFieldTypeText(h.cpi_crafts_sew_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_culturearts_index:' + getFieldTypeText(h.cpi_culturearts_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_currevent_index:' + getFieldTypeText(h.cpi_currevent_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_diy_index:' + getFieldTypeText(h.cpi_diy_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_donor_index:' + getFieldTypeText(h.cpi_donor_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_ego_index:' + getFieldTypeText(h.cpi_ego_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_electronics_index:' + getFieldTypeText(h.cpi_electronics_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_equestrian_index:' + getFieldTypeText(h.cpi_equestrian_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_family_index:' + getFieldTypeText(h.cpi_family_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_family_teen_index:' + getFieldTypeText(h.cpi_family_teen_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_family_young_index:' + getFieldTypeText(h.cpi_family_young_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_fiction_index:' + getFieldTypeText(h.cpi_fiction_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_gambling_index:' + getFieldTypeText(h.cpi_gambling_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_games_index:' + getFieldTypeText(h.cpi_games_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_gardening_index:' + getFieldTypeText(h.cpi_gardening_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_gay_index:' + getFieldTypeText(h.cpi_gay_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_giftgivr_index:' + getFieldTypeText(h.cpi_giftgivr_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_gourmet_index:' + getFieldTypeText(h.cpi_gourmet_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_grandparents_index:' + getFieldTypeText(h.cpi_grandparents_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_health_index:' + getFieldTypeText(h.cpi_health_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_health_diet_index:' + getFieldTypeText(h.cpi_health_diet_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_health_fitness_index:' + getFieldTypeText(h.cpi_health_fitness_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_hightech_index:' + getFieldTypeText(h.cpi_hightech_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_hispanic_index:' + getFieldTypeText(h.cpi_hispanic_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_history_index:' + getFieldTypeText(h.cpi_history_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_history_american_index:' + getFieldTypeText(h.cpi_history_american_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_hobbies_index:' + getFieldTypeText(h.cpi_hobbies_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_homedecr_index:' + getFieldTypeText(h.cpi_homedecr_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_homeliv_index:' + getFieldTypeText(h.cpi_homeliv_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_humor_index:' + getFieldTypeText(h.cpi_humor_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_inspiration_index:' + getFieldTypeText(h.cpi_inspiration_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_internet_index:' + getFieldTypeText(h.cpi_internet_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_internet_access_index:' + getFieldTypeText(h.cpi_internet_access_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_internet_buy_index:' + getFieldTypeText(h.cpi_internet_buy_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_liberal_index:' + getFieldTypeText(h.cpi_liberal_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_moneymaking_index:' + getFieldTypeText(h.cpi_moneymaking_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_motorcycles_index:' + getFieldTypeText(h.cpi_motorcycles_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_music_index:' + getFieldTypeText(h.cpi_music_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_nonfiction_index:' + getFieldTypeText(h.cpi_nonfiction_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_ocean_index:' + getFieldTypeText(h.cpi_ocean_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_outdoors_index:' + getFieldTypeText(h.cpi_outdoors_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_outdoors_boatsail_index:' + getFieldTypeText(h.cpi_outdoors_boatsail_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_outdoors_camp_index:' + getFieldTypeText(h.cpi_outdoors_camp_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_outdoors_fishing_index:' + getFieldTypeText(h.cpi_outdoors_fishing_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_outdoors_huntfish_index:' + getFieldTypeText(h.cpi_outdoors_huntfish_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_outdoors_hunting_index:' + getFieldTypeText(h.cpi_outdoors_hunting_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_pets_index:' + getFieldTypeText(h.cpi_pets_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_pets_cats_index:' + getFieldTypeText(h.cpi_pets_cats_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_pets_dogs_index:' + getFieldTypeText(h.cpi_pets_dogs_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_pfin_index:' + getFieldTypeText(h.cpi_pfin_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_photog_index:' + getFieldTypeText(h.cpi_photog_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_photoproc_index:' + getFieldTypeText(h.cpi_photoproc_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_publish_index:' + getFieldTypeText(h.cpi_publish_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_publish_books_index:' + getFieldTypeText(h.cpi_publish_books_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_publish_mags_index:' + getFieldTypeText(h.cpi_publish_mags_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_rural_index:' + getFieldTypeText(h.cpi_rural_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_science_index:' + getFieldTypeText(h.cpi_science_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_scifi_index:' + getFieldTypeText(h.cpi_scifi_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_seniors_index:' + getFieldTypeText(h.cpi_seniors_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_sports_index:' + getFieldTypeText(h.cpi_sports_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_sports_baseball_index:' + getFieldTypeText(h.cpi_sports_baseball_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_sports_basketball_index:' + getFieldTypeText(h.cpi_sports_basketball_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_sports_biking_index:' + getFieldTypeText(h.cpi_sports_biking_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_sports_football_index:' + getFieldTypeText(h.cpi_sports_football_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_sports_golf_index:' + getFieldTypeText(h.cpi_sports_golf_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_sports_hockey_index:' + getFieldTypeText(h.cpi_sports_hockey_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_sports_running_index:' + getFieldTypeText(h.cpi_sports_running_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_sports_ski_index:' + getFieldTypeText(h.cpi_sports_ski_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_sports_soccer_index:' + getFieldTypeText(h.cpi_sports_soccer_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_sports_swimming_index:' + getFieldTypeText(h.cpi_sports_swimming_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_sports_tennis_index:' + getFieldTypeText(h.cpi_sports_tennis_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_stationery_index:' + getFieldTypeText(h.cpi_stationery_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_sweeps_index:' + getFieldTypeText(h.cpi_sweeps_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_tobacco_index:' + getFieldTypeText(h.cpi_tobacco_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_travel_index:' + getFieldTypeText(h.cpi_travel_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_travel_cruise_index:' + getFieldTypeText(h.cpi_travel_cruise_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_travel_rv_index:' + getFieldTypeText(h.cpi_travel_rv_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_travel_us_index:' + getFieldTypeText(h.cpi_travel_us_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_tvmovies_index:' + getFieldTypeText(h.cpi_tvmovies_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_wildlife_index:' + getFieldTypeText(h.cpi_wildlife_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_woman_index:' + getFieldTypeText(h.cpi_woman_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'totdlr_index:' + getFieldTypeText(h.totdlr_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_totdlr:' + getFieldTypeText(h.cpi_totdlr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_totords:' + getFieldTypeText(h.cpi_totords) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpi_lastdlr:' + getFieldTypeText(h.cpi_lastdlr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkcatg:' + getFieldTypeText(h.pkcatg) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpubs:' + getFieldTypeText(h.pkpubs) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkcont:' + getFieldTypeText(h.pkcont) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkca01:' + getFieldTypeText(h.pkca01) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkca03:' + getFieldTypeText(h.pkca03) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkca04:' + getFieldTypeText(h.pkca04) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkca05:' + getFieldTypeText(h.pkca05) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkca06:' + getFieldTypeText(h.pkca06) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkca07:' + getFieldTypeText(h.pkca07) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkca08:' + getFieldTypeText(h.pkca08) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkca09:' + getFieldTypeText(h.pkca09) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkca10:' + getFieldTypeText(h.pkca10) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkca11:' + getFieldTypeText(h.pkca11) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkca12:' + getFieldTypeText(h.pkca12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkca13:' + getFieldTypeText(h.pkca13) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkca14:' + getFieldTypeText(h.pkca14) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkca15:' + getFieldTypeText(h.pkca15) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkca16:' + getFieldTypeText(h.pkca16) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkca17:' + getFieldTypeText(h.pkca17) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkca18:' + getFieldTypeText(h.pkca18) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkca20:' + getFieldTypeText(h.pkca20) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkca21:' + getFieldTypeText(h.pkca21) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkca22:' + getFieldTypeText(h.pkca22) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkca23:' + getFieldTypeText(h.pkca23) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkca24:' + getFieldTypeText(h.pkca24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkca25:' + getFieldTypeText(h.pkca25) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkca26:' + getFieldTypeText(h.pkca26) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkca28:' + getFieldTypeText(h.pkca28) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkca29:' + getFieldTypeText(h.pkca29) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkca30:' + getFieldTypeText(h.pkca30) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkca31:' + getFieldTypeText(h.pkca31) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkca32:' + getFieldTypeText(h.pkca32) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkca33:' + getFieldTypeText(h.pkca33) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkca34:' + getFieldTypeText(h.pkca34) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkca35:' + getFieldTypeText(h.pkca35) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkca36:' + getFieldTypeText(h.pkca36) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkca37:' + getFieldTypeText(h.pkca37) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkca39:' + getFieldTypeText(h.pkca39) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkca40:' + getFieldTypeText(h.pkca40) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkca41:' + getFieldTypeText(h.pkca41) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkca42:' + getFieldTypeText(h.pkca42) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkca54:' + getFieldTypeText(h.pkca54) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkca61:' + getFieldTypeText(h.pkca61) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkca62:' + getFieldTypeText(h.pkca62) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkca64:' + getFieldTypeText(h.pkca64) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu01:' + getFieldTypeText(h.pkpu01) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu02:' + getFieldTypeText(h.pkpu02) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu03:' + getFieldTypeText(h.pkpu03) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu04:' + getFieldTypeText(h.pkpu04) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu05:' + getFieldTypeText(h.pkpu05) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu06:' + getFieldTypeText(h.pkpu06) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu07:' + getFieldTypeText(h.pkpu07) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu08:' + getFieldTypeText(h.pkpu08) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu09:' + getFieldTypeText(h.pkpu09) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu10:' + getFieldTypeText(h.pkpu10) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu11:' + getFieldTypeText(h.pkpu11) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu12:' + getFieldTypeText(h.pkpu12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu13:' + getFieldTypeText(h.pkpu13) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu14:' + getFieldTypeText(h.pkpu14) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu15:' + getFieldTypeText(h.pkpu15) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu16:' + getFieldTypeText(h.pkpu16) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu17:' + getFieldTypeText(h.pkpu17) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu18:' + getFieldTypeText(h.pkpu18) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu19:' + getFieldTypeText(h.pkpu19) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu20:' + getFieldTypeText(h.pkpu20) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu23:' + getFieldTypeText(h.pkpu23) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu25:' + getFieldTypeText(h.pkpu25) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu27:' + getFieldTypeText(h.pkpu27) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu28:' + getFieldTypeText(h.pkpu28) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu29:' + getFieldTypeText(h.pkpu29) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu30:' + getFieldTypeText(h.pkpu30) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu31:' + getFieldTypeText(h.pkpu31) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu32:' + getFieldTypeText(h.pkpu32) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu33:' + getFieldTypeText(h.pkpu33) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu34:' + getFieldTypeText(h.pkpu34) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu35:' + getFieldTypeText(h.pkpu35) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu38:' + getFieldTypeText(h.pkpu38) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu41:' + getFieldTypeText(h.pkpu41) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu42:' + getFieldTypeText(h.pkpu42) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu45:' + getFieldTypeText(h.pkpu45) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu46:' + getFieldTypeText(h.pkpu46) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu47:' + getFieldTypeText(h.pkpu47) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu48:' + getFieldTypeText(h.pkpu48) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu49:' + getFieldTypeText(h.pkpu49) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu50:' + getFieldTypeText(h.pkpu50) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu51:' + getFieldTypeText(h.pkpu51) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu52:' + getFieldTypeText(h.pkpu52) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu53:' + getFieldTypeText(h.pkpu53) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu54:' + getFieldTypeText(h.pkpu54) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu55:' + getFieldTypeText(h.pkpu55) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu56:' + getFieldTypeText(h.pkpu56) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu57:' + getFieldTypeText(h.pkpu57) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu60:' + getFieldTypeText(h.pkpu60) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu61:' + getFieldTypeText(h.pkpu61) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu62:' + getFieldTypeText(h.pkpu62) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu63:' + getFieldTypeText(h.pkpu63) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu64:' + getFieldTypeText(h.pkpu64) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu65:' + getFieldTypeText(h.pkpu65) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu66:' + getFieldTypeText(h.pkpu66) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu67:' + getFieldTypeText(h.pkpu67) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu68:' + getFieldTypeText(h.pkpu68) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu69:' + getFieldTypeText(h.pkpu69) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pkpu70:' + getFieldTypeText(h.pkpu70) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'censpct_water:' + getFieldTypeText(h.censpct_water) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cens_pop_density:' + getFieldTypeText(h.cens_pop_density) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cens_hu_density:' + getFieldTypeText(h.cens_hu_density) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'censpct_pop_white:' + getFieldTypeText(h.censpct_pop_white) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'censpct_pop_black:' + getFieldTypeText(h.censpct_pop_black) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'censpct_pop_amerind:' + getFieldTypeText(h.censpct_pop_amerind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'censpct_pop_asian:' + getFieldTypeText(h.censpct_pop_asian) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'censpct_pop_pacisl:' + getFieldTypeText(h.censpct_pop_pacisl) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'censpct_pop_othrace:' + getFieldTypeText(h.censpct_pop_othrace) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'censpct_pop_multirace:' + getFieldTypeText(h.censpct_pop_multirace) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'censpct_pop_hispanic:' + getFieldTypeText(h.censpct_pop_hispanic) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'censpct_pop_agelt18:' + getFieldTypeText(h.censpct_pop_agelt18) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'censpct_pop_males:' + getFieldTypeText(h.censpct_pop_males) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'censpct_adult_age1824:' + getFieldTypeText(h.censpct_adult_age1824) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'censpct_adult_age2534:' + getFieldTypeText(h.censpct_adult_age2534) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'censpct_adult_age3544:' + getFieldTypeText(h.censpct_adult_age3544) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'censpct_adult_age4554:' + getFieldTypeText(h.censpct_adult_age4554) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'censpct_adult_age5564:' + getFieldTypeText(h.censpct_adult_age5564) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'censpct_adult_agege65:' + getFieldTypeText(h.censpct_adult_agege65) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cens_pop_medage:' + getFieldTypeText(h.cens_pop_medage) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cens_hh_avgsize:' + getFieldTypeText(h.cens_hh_avgsize) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'censpct_hh_family:' + getFieldTypeText(h.censpct_hh_family) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'censpct_hh_family_husbwife:' + getFieldTypeText(h.censpct_hh_family_husbwife) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'censpct_hu_occupied:' + getFieldTypeText(h.censpct_hu_occupied) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'censpct_hu_owned:' + getFieldTypeText(h.censpct_hu_owned) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'censpct_hu_rented:' + getFieldTypeText(h.censpct_hu_rented) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'censpct_hu_vacantseasonal:' + getFieldTypeText(h.censpct_hu_vacantseasonal) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_medinc:' + getFieldTypeText(h.zip_medinc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_apparel:' + getFieldTypeText(h.zip_apparel) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_apparel_women:' + getFieldTypeText(h.zip_apparel_women) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_apparel_womfash:' + getFieldTypeText(h.zip_apparel_womfash) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_auto:' + getFieldTypeText(h.zip_auto) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_beauty:' + getFieldTypeText(h.zip_beauty) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_booksmusicmovies:' + getFieldTypeText(h.zip_booksmusicmovies) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_business:' + getFieldTypeText(h.zip_business) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_catalog:' + getFieldTypeText(h.zip_catalog) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_cc:' + getFieldTypeText(h.zip_cc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_collectibles:' + getFieldTypeText(h.zip_collectibles) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_computers:' + getFieldTypeText(h.zip_computers) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_continuity:' + getFieldTypeText(h.zip_continuity) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_cooking:' + getFieldTypeText(h.zip_cooking) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_crafts:' + getFieldTypeText(h.zip_crafts) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_culturearts:' + getFieldTypeText(h.zip_culturearts) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_dm_sold:' + getFieldTypeText(h.zip_dm_sold) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_donor:' + getFieldTypeText(h.zip_donor) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_family:' + getFieldTypeText(h.zip_family) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_gardening:' + getFieldTypeText(h.zip_gardening) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_giftgivr:' + getFieldTypeText(h.zip_giftgivr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_gourmet:' + getFieldTypeText(h.zip_gourmet) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_health:' + getFieldTypeText(h.zip_health) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_health_diet:' + getFieldTypeText(h.zip_health_diet) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_health_fitness:' + getFieldTypeText(h.zip_health_fitness) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_hobbies:' + getFieldTypeText(h.zip_hobbies) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_homedecr:' + getFieldTypeText(h.zip_homedecr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_homeliv:' + getFieldTypeText(h.zip_homeliv) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_internet:' + getFieldTypeText(h.zip_internet) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_internet_access:' + getFieldTypeText(h.zip_internet_access) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_internet_buy:' + getFieldTypeText(h.zip_internet_buy) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_music:' + getFieldTypeText(h.zip_music) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_outdoors:' + getFieldTypeText(h.zip_outdoors) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_pets:' + getFieldTypeText(h.zip_pets) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_pfin:' + getFieldTypeText(h.zip_pfin) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_publish:' + getFieldTypeText(h.zip_publish) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_publish_books:' + getFieldTypeText(h.zip_publish_books) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_publish_mags:' + getFieldTypeText(h.zip_publish_mags) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_sports:' + getFieldTypeText(h.zip_sports) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_sports_biking:' + getFieldTypeText(h.zip_sports_biking) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_sports_golf:' + getFieldTypeText(h.zip_sports_golf) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_travel:' + getFieldTypeText(h.zip_travel) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_travel_us:' + getFieldTypeText(h.zip_travel_us) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_tvmovies:' + getFieldTypeText(h.zip_tvmovies) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_woman:' + getFieldTypeText(h.zip_woman) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_proftech:' + getFieldTypeText(h.zip_proftech) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_retired:' + getFieldTypeText(h.zip_retired) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_inc100:' + getFieldTypeText(h.zip_inc100) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_inc75:' + getFieldTypeText(h.zip_inc75) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_inc50:' + getFieldTypeText(h.zip_inc50) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_dtmatch_cnt
          ,le.populated_msname_cnt
          ,le.populated_msaddr1_cnt
          ,le.populated_msaddr2_cnt
          ,le.populated_mscity_cnt
          ,le.populated_msstate_cnt
          ,le.populated_mszip5_cnt
          ,le.populated_mszip4_cnt
          ,le.populated_dthh_cnt
          ,le.populated_mscrrt_cnt
          ,le.populated_msdpbc_cnt
          ,le.populated_msdpv_cnt
          ,le.populated_ms_addrtype_cnt
          ,le.populated_ctysize_cnt
          ,le.populated_lmos_cnt
          ,le.populated_omos_cnt
          ,le.populated_pmos_cnt
          ,le.populated_gen_cnt
          ,le.populated_dob_cnt
          ,le.populated_age_cnt
          ,le.populated_inc_cnt
          ,le.populated_marital_status_cnt
          ,le.populated_poc_cnt
          ,le.populated_noc_cnt
          ,le.populated_ocp_cnt
          ,le.populated_edu_cnt
          ,le.populated_lang_cnt
          ,le.populated_relig_cnt
          ,le.populated_dwell_cnt
          ,le.populated_ownr_cnt
          ,le.populated_eth1_cnt
          ,le.populated_eth2_cnt
          ,le.populated_lor_cnt
          ,le.populated_pool_cnt
          ,le.populated_speak_span_cnt
          ,le.populated_soho_cnt
          ,le.populated_vet_in_hh_cnt
          ,le.populated_ms_mags_cnt
          ,le.populated_ms_books_cnt
          ,le.populated_ms_publish_cnt
          ,le.populated_ms_pub_status_active_cnt
          ,le.populated_ms_pub_status_expire_cnt
          ,le.populated_ms_pub_premsold_cnt
          ,le.populated_ms_pub_autornwl_cnt
          ,le.populated_ms_pub_avgterm_cnt
          ,le.populated_ms_pub_lmos_cnt
          ,le.populated_ms_pub_omos_cnt
          ,le.populated_ms_pub_pmos_cnt
          ,le.populated_ms_pub_cemos_cnt
          ,le.populated_ms_pub_femos_cnt
          ,le.populated_ms_pub_totords_cnt
          ,le.populated_ms_pub_totdlrs_cnt
          ,le.populated_ms_pub_avgdlrs_cnt
          ,le.populated_ms_pub_lastdlrs_cnt
          ,le.populated_ms_pub_paystat_paid_cnt
          ,le.populated_ms_pub_paystat_ub_cnt
          ,le.populated_ms_pub_paymeth_cc_cnt
          ,le.populated_ms_pub_paymeth_cash_cnt
          ,le.populated_ms_pub_payspeed_cnt
          ,le.populated_ms_pub_osrc_dm_cnt
          ,le.populated_ms_pub_lsrc_dm_cnt
          ,le.populated_ms_pub_osrc_agt_cashf_cnt
          ,le.populated_ms_pub_lsrc_agt_cashf_cnt
          ,le.populated_ms_pub_osrc_agt_pds_cnt
          ,le.populated_ms_pub_lsrc_agt_pds_cnt
          ,le.populated_ms_pub_osrc_agt_schplan_cnt
          ,le.populated_ms_pub_lsrc_agt_schplan_cnt
          ,le.populated_ms_pub_osrc_agt_sponsor_cnt
          ,le.populated_ms_pub_lsrc_agt_sponsor_cnt
          ,le.populated_ms_pub_osrc_agt_tm_cnt
          ,le.populated_ms_pub_lsrc_agt_tm_cnt
          ,le.populated_ms_pub_osrc_agt_cnt
          ,le.populated_ms_pub_lsrc_agt_cnt
          ,le.populated_ms_pub_osrc_tm_cnt
          ,le.populated_ms_pub_lsrc_tm_cnt
          ,le.populated_ms_pub_osrc_ins_cnt
          ,le.populated_ms_pub_lsrc_ins_cnt
          ,le.populated_ms_pub_osrc_net_cnt
          ,le.populated_ms_pub_lsrc_net_cnt
          ,le.populated_ms_pub_osrc_print_cnt
          ,le.populated_ms_pub_lsrc_print_cnt
          ,le.populated_ms_pub_osrc_trans_cnt
          ,le.populated_ms_pub_lsrc_trans_cnt
          ,le.populated_ms_pub_osrc_tv_cnt
          ,le.populated_ms_pub_lsrc_tv_cnt
          ,le.populated_ms_pub_osrc_dtp_cnt
          ,le.populated_ms_pub_lsrc_dtp_cnt
          ,le.populated_ms_pub_giftgivr_cnt
          ,le.populated_ms_pub_giftee_cnt
          ,le.populated_ms_catalog_cnt
          ,le.populated_ms_cat_lmos_cnt
          ,le.populated_ms_cat_omos_cnt
          ,le.populated_ms_cat_pmos_cnt
          ,le.populated_ms_cat_totords_cnt
          ,le.populated_ms_cat_totitems_cnt
          ,le.populated_ms_cat_totdlrs_cnt
          ,le.populated_ms_cat_avgdlrs_cnt
          ,le.populated_ms_cat_lastdlrs_cnt
          ,le.populated_ms_cat_paystat_paid_cnt
          ,le.populated_ms_cat_paymeth_cc_cnt
          ,le.populated_ms_cat_paymeth_cash_cnt
          ,le.populated_ms_cat_osrc_dm_cnt
          ,le.populated_ms_cat_lsrc_dm_cnt
          ,le.populated_ms_cat_osrc_net_cnt
          ,le.populated_ms_cat_lsrc_net_cnt
          ,le.populated_ms_cat_giftgivr_cnt
          ,le.populated_pkpubs_corrected_cnt
          ,le.populated_pkcatg_corrected_cnt
          ,le.populated_ms_fundraising_cnt
          ,le.populated_ms_fund_lmos_cnt
          ,le.populated_ms_fund_omos_cnt
          ,le.populated_ms_fund_pmos_cnt
          ,le.populated_ms_fund_totords_cnt
          ,le.populated_ms_fund_totdlrs_cnt
          ,le.populated_ms_fund_avgdlrs_cnt
          ,le.populated_ms_fund_lastdlrs_cnt
          ,le.populated_ms_fund_paystat_paid_cnt
          ,le.populated_ms_other_cnt
          ,le.populated_ms_continuity_cnt
          ,le.populated_ms_cont_status_active_cnt
          ,le.populated_ms_cont_status_cancel_cnt
          ,le.populated_ms_cont_omos_cnt
          ,le.populated_ms_cont_lmos_cnt
          ,le.populated_ms_cont_pmos_cnt
          ,le.populated_ms_cont_totords_cnt
          ,le.populated_ms_cont_totdlrs_cnt
          ,le.populated_ms_cont_avgdlrs_cnt
          ,le.populated_ms_cont_lastdlrs_cnt
          ,le.populated_ms_cont_paystat_paid_cnt
          ,le.populated_ms_cont_paymeth_cc_cnt
          ,le.populated_ms_cont_paymeth_cash_cnt
          ,le.populated_ms_totords_cnt
          ,le.populated_ms_totitems_cnt
          ,le.populated_ms_totdlrs_cnt
          ,le.populated_ms_avgdlrs_cnt
          ,le.populated_ms_lastdlrs_cnt
          ,le.populated_ms_paystat_paid_cnt
          ,le.populated_ms_paymeth_cc_cnt
          ,le.populated_ms_paymeth_cash_cnt
          ,le.populated_ms_osrc_dm_cnt
          ,le.populated_ms_lsrc_dm_cnt
          ,le.populated_ms_osrc_tm_cnt
          ,le.populated_ms_lsrc_tm_cnt
          ,le.populated_ms_osrc_ins_cnt
          ,le.populated_ms_lsrc_ins_cnt
          ,le.populated_ms_osrc_net_cnt
          ,le.populated_ms_lsrc_net_cnt
          ,le.populated_ms_osrc_tv_cnt
          ,le.populated_ms_lsrc_tv_cnt
          ,le.populated_ms_osrc_retail_cnt
          ,le.populated_ms_lsrc_retail_cnt
          ,le.populated_ms_giftgivr_cnt
          ,le.populated_ms_giftee_cnt
          ,le.populated_ms_adult_cnt
          ,le.populated_ms_womapp_cnt
          ,le.populated_ms_menapp_cnt
          ,le.populated_ms_kidapp_cnt
          ,le.populated_ms_accessory_cnt
          ,le.populated_ms_apparel_cnt
          ,le.populated_ms_app_lmos_cnt
          ,le.populated_ms_app_omos_cnt
          ,le.populated_ms_app_pmos_cnt
          ,le.populated_ms_app_totords_cnt
          ,le.populated_ms_app_totitems_cnt
          ,le.populated_ms_app_totdlrs_cnt
          ,le.populated_ms_app_avgdlrs_cnt
          ,le.populated_ms_app_lastdlrs_cnt
          ,le.populated_ms_app_paystat_paid_cnt
          ,le.populated_ms_app_paymeth_cc_cnt
          ,le.populated_ms_app_paymeth_cash_cnt
          ,le.populated_ms_menfash_cnt
          ,le.populated_ms_womfash_cnt
          ,le.populated_ms_wfsh_lmos_cnt
          ,le.populated_ms_wfsh_omos_cnt
          ,le.populated_ms_wfsh_pmos_cnt
          ,le.populated_ms_wfsh_totords_cnt
          ,le.populated_ms_wfsh_totdlrs_cnt
          ,le.populated_ms_wfsh_avgdlrs_cnt
          ,le.populated_ms_wfsh_lastdlrs_cnt
          ,le.populated_ms_wfsh_paystat_paid_cnt
          ,le.populated_ms_wfsh_osrc_dm_cnt
          ,le.populated_ms_wfsh_lsrc_dm_cnt
          ,le.populated_ms_wfsh_osrc_agt_cnt
          ,le.populated_ms_wfsh_lsrc_agt_cnt
          ,le.populated_ms_audio_cnt
          ,le.populated_ms_auto_cnt
          ,le.populated_ms_aviation_cnt
          ,le.populated_ms_bargains_cnt
          ,le.populated_ms_beauty_cnt
          ,le.populated_ms_bible_cnt
          ,le.populated_ms_bible_lmos_cnt
          ,le.populated_ms_bible_omos_cnt
          ,le.populated_ms_bible_pmos_cnt
          ,le.populated_ms_bible_totords_cnt
          ,le.populated_ms_bible_totitems_cnt
          ,le.populated_ms_bible_totdlrs_cnt
          ,le.populated_ms_bible_avgdlrs_cnt
          ,le.populated_ms_bible_lastdlrs_cnt
          ,le.populated_ms_bible_paystat_paid_cnt
          ,le.populated_ms_bible_paymeth_cc_cnt
          ,le.populated_ms_bible_paymeth_cash_cnt
          ,le.populated_ms_business_cnt
          ,le.populated_ms_collectibles_cnt
          ,le.populated_ms_computers_cnt
          ,le.populated_ms_crafts_cnt
          ,le.populated_ms_culturearts_cnt
          ,le.populated_ms_currevent_cnt
          ,le.populated_ms_diy_cnt
          ,le.populated_ms_electronics_cnt
          ,le.populated_ms_equestrian_cnt
          ,le.populated_ms_pub_family_cnt
          ,le.populated_ms_cat_family_cnt
          ,le.populated_ms_family_cnt
          ,le.populated_ms_family_lmos_cnt
          ,le.populated_ms_family_omos_cnt
          ,le.populated_ms_family_pmos_cnt
          ,le.populated_ms_family_totords_cnt
          ,le.populated_ms_family_totitems_cnt
          ,le.populated_ms_family_totdlrs_cnt
          ,le.populated_ms_family_avgdlrs_cnt
          ,le.populated_ms_family_lastdlrs_cnt
          ,le.populated_ms_family_paystat_paid_cnt
          ,le.populated_ms_family_paymeth_cc_cnt
          ,le.populated_ms_family_paymeth_cash_cnt
          ,le.populated_ms_family_osrc_dm_cnt
          ,le.populated_ms_family_lsrc_dm_cnt
          ,le.populated_ms_fiction_cnt
          ,le.populated_ms_food_cnt
          ,le.populated_ms_games_cnt
          ,le.populated_ms_gifts_cnt
          ,le.populated_ms_gourmet_cnt
          ,le.populated_ms_fitness_cnt
          ,le.populated_ms_health_cnt
          ,le.populated_ms_hlth_lmos_cnt
          ,le.populated_ms_hlth_omos_cnt
          ,le.populated_ms_hlth_pmos_cnt
          ,le.populated_ms_hlth_totords_cnt
          ,le.populated_ms_hlth_totdlrs_cnt
          ,le.populated_ms_hlth_avgdlrs_cnt
          ,le.populated_ms_hlth_lastdlrs_cnt
          ,le.populated_ms_hlth_paystat_paid_cnt
          ,le.populated_ms_hlth_paymeth_cc_cnt
          ,le.populated_ms_hlth_osrc_dm_cnt
          ,le.populated_ms_hlth_lsrc_dm_cnt
          ,le.populated_ms_hlth_osrc_agt_cnt
          ,le.populated_ms_hlth_lsrc_agt_cnt
          ,le.populated_ms_hlth_osrc_tv_cnt
          ,le.populated_ms_hlth_lsrc_tv_cnt
          ,le.populated_ms_holiday_cnt
          ,le.populated_ms_history_cnt
          ,le.populated_ms_pub_cooking_cnt
          ,le.populated_ms_cooking_cnt
          ,le.populated_ms_pub_homedecr_cnt
          ,le.populated_ms_cat_homedecr_cnt
          ,le.populated_ms_homedecr_cnt
          ,le.populated_ms_housewares_cnt
          ,le.populated_ms_pub_garden_cnt
          ,le.populated_ms_cat_garden_cnt
          ,le.populated_ms_garden_cnt
          ,le.populated_ms_pub_homeliv_cnt
          ,le.populated_ms_cat_homeliv_cnt
          ,le.populated_ms_homeliv_cnt
          ,le.populated_ms_pub_home_status_active_cnt
          ,le.populated_ms_home_lmos_cnt
          ,le.populated_ms_home_omos_cnt
          ,le.populated_ms_home_pmos_cnt
          ,le.populated_ms_home_totords_cnt
          ,le.populated_ms_home_totitems_cnt
          ,le.populated_ms_home_totdlrs_cnt
          ,le.populated_ms_home_avgdlrs_cnt
          ,le.populated_ms_home_lastdlrs_cnt
          ,le.populated_ms_home_paystat_paid_cnt
          ,le.populated_ms_home_paymeth_cc_cnt
          ,le.populated_ms_home_paymeth_cash_cnt
          ,le.populated_ms_home_osrc_dm_cnt
          ,le.populated_ms_home_lsrc_dm_cnt
          ,le.populated_ms_home_osrc_agt_cnt
          ,le.populated_ms_home_lsrc_agt_cnt
          ,le.populated_ms_home_osrc_net_cnt
          ,le.populated_ms_home_lsrc_net_cnt
          ,le.populated_ms_home_osrc_tv_cnt
          ,le.populated_ms_home_lsrc_tv_cnt
          ,le.populated_ms_humor_cnt
          ,le.populated_ms_inspiration_cnt
          ,le.populated_ms_merchandise_cnt
          ,le.populated_ms_moneymaking_cnt
          ,le.populated_ms_moneymaking_lmos_cnt
          ,le.populated_ms_motorcycles_cnt
          ,le.populated_ms_music_cnt
          ,le.populated_ms_fishing_cnt
          ,le.populated_ms_hunting_cnt
          ,le.populated_ms_boatsail_cnt
          ,le.populated_ms_camp_cnt
          ,le.populated_ms_pub_outdoors_cnt
          ,le.populated_ms_cat_outdoors_cnt
          ,le.populated_ms_outdoors_cnt
          ,le.populated_ms_pub_out_status_active_cnt
          ,le.populated_ms_out_lmos_cnt
          ,le.populated_ms_out_omos_cnt
          ,le.populated_ms_out_pmos_cnt
          ,le.populated_ms_out_totords_cnt
          ,le.populated_ms_out_totitems_cnt
          ,le.populated_ms_out_totdlrs_cnt
          ,le.populated_ms_out_avgdlrs_cnt
          ,le.populated_ms_out_lastdlrs_cnt
          ,le.populated_ms_out_paystat_paid_cnt
          ,le.populated_ms_out_paymeth_cc_cnt
          ,le.populated_ms_out_paymeth_cash_cnt
          ,le.populated_ms_out_osrc_dm_cnt
          ,le.populated_ms_out_lsrc_dm_cnt
          ,le.populated_ms_out_osrc_agt_cnt
          ,le.populated_ms_out_lsrc_agt_cnt
          ,le.populated_ms_pets_cnt
          ,le.populated_ms_pfin_cnt
          ,le.populated_ms_photo_cnt
          ,le.populated_ms_photoproc_cnt
          ,le.populated_ms_rural_cnt
          ,le.populated_ms_science_cnt
          ,le.populated_ms_sports_cnt
          ,le.populated_ms_sports_lmos_cnt
          ,le.populated_ms_travel_cnt
          ,le.populated_ms_tvmovies_cnt
          ,le.populated_ms_wildlife_cnt
          ,le.populated_ms_woman_cnt
          ,le.populated_ms_woman_lmos_cnt
          ,le.populated_ms_ringtones_apps_cnt
          ,le.populated_cpi_mobile_apps_index_cnt
          ,le.populated_cpi_credit_repair_index_cnt
          ,le.populated_cpi_credit_report_index_cnt
          ,le.populated_cpi_education_seekers_index_cnt
          ,le.populated_cpi_insurance_index_cnt
          ,le.populated_cpi_insurance_health_index_cnt
          ,le.populated_cpi_insurance_auto_index_cnt
          ,le.populated_cpi_job_seekers_index_cnt
          ,le.populated_cpi_social_networking_index_cnt
          ,le.populated_cpi_adult_index_cnt
          ,le.populated_cpi_africanamerican_index_cnt
          ,le.populated_cpi_apparel_index_cnt
          ,le.populated_cpi_apparel_accessory_index_cnt
          ,le.populated_cpi_apparel_kids_index_cnt
          ,le.populated_cpi_apparel_men_index_cnt
          ,le.populated_cpi_apparel_menfash_index_cnt
          ,le.populated_cpi_apparel_women_index_cnt
          ,le.populated_cpi_apparel_womfash_index_cnt
          ,le.populated_cpi_asian_index_cnt
          ,le.populated_cpi_auto_index_cnt
          ,le.populated_cpi_auto_racing_index_cnt
          ,le.populated_cpi_auto_trucks_index_cnt
          ,le.populated_cpi_aviation_index_cnt
          ,le.populated_cpi_bargains_index_cnt
          ,le.populated_cpi_beauty_index_cnt
          ,le.populated_cpi_bible_index_cnt
          ,le.populated_cpi_birds_index_cnt
          ,le.populated_cpi_business_index_cnt
          ,le.populated_cpi_business_homeoffice_index_cnt
          ,le.populated_cpi_catalog_index_cnt
          ,le.populated_cpi_cc_index_cnt
          ,le.populated_cpi_collectibles_index_cnt
          ,le.populated_cpi_college_index_cnt
          ,le.populated_cpi_computers_index_cnt
          ,le.populated_cpi_conservative_index_cnt
          ,le.populated_cpi_continuity_index_cnt
          ,le.populated_cpi_cooking_index_cnt
          ,le.populated_cpi_crafts_index_cnt
          ,le.populated_cpi_crafts_crochet_index_cnt
          ,le.populated_cpi_crafts_knit_index_cnt
          ,le.populated_cpi_crafts_needlepoint_index_cnt
          ,le.populated_cpi_crafts_quilt_index_cnt
          ,le.populated_cpi_crafts_sew_index_cnt
          ,le.populated_cpi_culturearts_index_cnt
          ,le.populated_cpi_currevent_index_cnt
          ,le.populated_cpi_diy_index_cnt
          ,le.populated_cpi_donor_index_cnt
          ,le.populated_cpi_ego_index_cnt
          ,le.populated_cpi_electronics_index_cnt
          ,le.populated_cpi_equestrian_index_cnt
          ,le.populated_cpi_family_index_cnt
          ,le.populated_cpi_family_teen_index_cnt
          ,le.populated_cpi_family_young_index_cnt
          ,le.populated_cpi_fiction_index_cnt
          ,le.populated_cpi_gambling_index_cnt
          ,le.populated_cpi_games_index_cnt
          ,le.populated_cpi_gardening_index_cnt
          ,le.populated_cpi_gay_index_cnt
          ,le.populated_cpi_giftgivr_index_cnt
          ,le.populated_cpi_gourmet_index_cnt
          ,le.populated_cpi_grandparents_index_cnt
          ,le.populated_cpi_health_index_cnt
          ,le.populated_cpi_health_diet_index_cnt
          ,le.populated_cpi_health_fitness_index_cnt
          ,le.populated_cpi_hightech_index_cnt
          ,le.populated_cpi_hispanic_index_cnt
          ,le.populated_cpi_history_index_cnt
          ,le.populated_cpi_history_american_index_cnt
          ,le.populated_cpi_hobbies_index_cnt
          ,le.populated_cpi_homedecr_index_cnt
          ,le.populated_cpi_homeliv_index_cnt
          ,le.populated_cpi_humor_index_cnt
          ,le.populated_cpi_inspiration_index_cnt
          ,le.populated_cpi_internet_index_cnt
          ,le.populated_cpi_internet_access_index_cnt
          ,le.populated_cpi_internet_buy_index_cnt
          ,le.populated_cpi_liberal_index_cnt
          ,le.populated_cpi_moneymaking_index_cnt
          ,le.populated_cpi_motorcycles_index_cnt
          ,le.populated_cpi_music_index_cnt
          ,le.populated_cpi_nonfiction_index_cnt
          ,le.populated_cpi_ocean_index_cnt
          ,le.populated_cpi_outdoors_index_cnt
          ,le.populated_cpi_outdoors_boatsail_index_cnt
          ,le.populated_cpi_outdoors_camp_index_cnt
          ,le.populated_cpi_outdoors_fishing_index_cnt
          ,le.populated_cpi_outdoors_huntfish_index_cnt
          ,le.populated_cpi_outdoors_hunting_index_cnt
          ,le.populated_cpi_pets_index_cnt
          ,le.populated_cpi_pets_cats_index_cnt
          ,le.populated_cpi_pets_dogs_index_cnt
          ,le.populated_cpi_pfin_index_cnt
          ,le.populated_cpi_photog_index_cnt
          ,le.populated_cpi_photoproc_index_cnt
          ,le.populated_cpi_publish_index_cnt
          ,le.populated_cpi_publish_books_index_cnt
          ,le.populated_cpi_publish_mags_index_cnt
          ,le.populated_cpi_rural_index_cnt
          ,le.populated_cpi_science_index_cnt
          ,le.populated_cpi_scifi_index_cnt
          ,le.populated_cpi_seniors_index_cnt
          ,le.populated_cpi_sports_index_cnt
          ,le.populated_cpi_sports_baseball_index_cnt
          ,le.populated_cpi_sports_basketball_index_cnt
          ,le.populated_cpi_sports_biking_index_cnt
          ,le.populated_cpi_sports_football_index_cnt
          ,le.populated_cpi_sports_golf_index_cnt
          ,le.populated_cpi_sports_hockey_index_cnt
          ,le.populated_cpi_sports_running_index_cnt
          ,le.populated_cpi_sports_ski_index_cnt
          ,le.populated_cpi_sports_soccer_index_cnt
          ,le.populated_cpi_sports_swimming_index_cnt
          ,le.populated_cpi_sports_tennis_index_cnt
          ,le.populated_cpi_stationery_index_cnt
          ,le.populated_cpi_sweeps_index_cnt
          ,le.populated_cpi_tobacco_index_cnt
          ,le.populated_cpi_travel_index_cnt
          ,le.populated_cpi_travel_cruise_index_cnt
          ,le.populated_cpi_travel_rv_index_cnt
          ,le.populated_cpi_travel_us_index_cnt
          ,le.populated_cpi_tvmovies_index_cnt
          ,le.populated_cpi_wildlife_index_cnt
          ,le.populated_cpi_woman_index_cnt
          ,le.populated_totdlr_index_cnt
          ,le.populated_cpi_totdlr_cnt
          ,le.populated_cpi_totords_cnt
          ,le.populated_cpi_lastdlr_cnt
          ,le.populated_pkcatg_cnt
          ,le.populated_pkpubs_cnt
          ,le.populated_pkcont_cnt
          ,le.populated_pkca01_cnt
          ,le.populated_pkca03_cnt
          ,le.populated_pkca04_cnt
          ,le.populated_pkca05_cnt
          ,le.populated_pkca06_cnt
          ,le.populated_pkca07_cnt
          ,le.populated_pkca08_cnt
          ,le.populated_pkca09_cnt
          ,le.populated_pkca10_cnt
          ,le.populated_pkca11_cnt
          ,le.populated_pkca12_cnt
          ,le.populated_pkca13_cnt
          ,le.populated_pkca14_cnt
          ,le.populated_pkca15_cnt
          ,le.populated_pkca16_cnt
          ,le.populated_pkca17_cnt
          ,le.populated_pkca18_cnt
          ,le.populated_pkca20_cnt
          ,le.populated_pkca21_cnt
          ,le.populated_pkca22_cnt
          ,le.populated_pkca23_cnt
          ,le.populated_pkca24_cnt
          ,le.populated_pkca25_cnt
          ,le.populated_pkca26_cnt
          ,le.populated_pkca28_cnt
          ,le.populated_pkca29_cnt
          ,le.populated_pkca30_cnt
          ,le.populated_pkca31_cnt
          ,le.populated_pkca32_cnt
          ,le.populated_pkca33_cnt
          ,le.populated_pkca34_cnt
          ,le.populated_pkca35_cnt
          ,le.populated_pkca36_cnt
          ,le.populated_pkca37_cnt
          ,le.populated_pkca39_cnt
          ,le.populated_pkca40_cnt
          ,le.populated_pkca41_cnt
          ,le.populated_pkca42_cnt
          ,le.populated_pkca54_cnt
          ,le.populated_pkca61_cnt
          ,le.populated_pkca62_cnt
          ,le.populated_pkca64_cnt
          ,le.populated_pkpu01_cnt
          ,le.populated_pkpu02_cnt
          ,le.populated_pkpu03_cnt
          ,le.populated_pkpu04_cnt
          ,le.populated_pkpu05_cnt
          ,le.populated_pkpu06_cnt
          ,le.populated_pkpu07_cnt
          ,le.populated_pkpu08_cnt
          ,le.populated_pkpu09_cnt
          ,le.populated_pkpu10_cnt
          ,le.populated_pkpu11_cnt
          ,le.populated_pkpu12_cnt
          ,le.populated_pkpu13_cnt
          ,le.populated_pkpu14_cnt
          ,le.populated_pkpu15_cnt
          ,le.populated_pkpu16_cnt
          ,le.populated_pkpu17_cnt
          ,le.populated_pkpu18_cnt
          ,le.populated_pkpu19_cnt
          ,le.populated_pkpu20_cnt
          ,le.populated_pkpu23_cnt
          ,le.populated_pkpu25_cnt
          ,le.populated_pkpu27_cnt
          ,le.populated_pkpu28_cnt
          ,le.populated_pkpu29_cnt
          ,le.populated_pkpu30_cnt
          ,le.populated_pkpu31_cnt
          ,le.populated_pkpu32_cnt
          ,le.populated_pkpu33_cnt
          ,le.populated_pkpu34_cnt
          ,le.populated_pkpu35_cnt
          ,le.populated_pkpu38_cnt
          ,le.populated_pkpu41_cnt
          ,le.populated_pkpu42_cnt
          ,le.populated_pkpu45_cnt
          ,le.populated_pkpu46_cnt
          ,le.populated_pkpu47_cnt
          ,le.populated_pkpu48_cnt
          ,le.populated_pkpu49_cnt
          ,le.populated_pkpu50_cnt
          ,le.populated_pkpu51_cnt
          ,le.populated_pkpu52_cnt
          ,le.populated_pkpu53_cnt
          ,le.populated_pkpu54_cnt
          ,le.populated_pkpu55_cnt
          ,le.populated_pkpu56_cnt
          ,le.populated_pkpu57_cnt
          ,le.populated_pkpu60_cnt
          ,le.populated_pkpu61_cnt
          ,le.populated_pkpu62_cnt
          ,le.populated_pkpu63_cnt
          ,le.populated_pkpu64_cnt
          ,le.populated_pkpu65_cnt
          ,le.populated_pkpu66_cnt
          ,le.populated_pkpu67_cnt
          ,le.populated_pkpu68_cnt
          ,le.populated_pkpu69_cnt
          ,le.populated_pkpu70_cnt
          ,le.populated_censpct_water_cnt
          ,le.populated_cens_pop_density_cnt
          ,le.populated_cens_hu_density_cnt
          ,le.populated_censpct_pop_white_cnt
          ,le.populated_censpct_pop_black_cnt
          ,le.populated_censpct_pop_amerind_cnt
          ,le.populated_censpct_pop_asian_cnt
          ,le.populated_censpct_pop_pacisl_cnt
          ,le.populated_censpct_pop_othrace_cnt
          ,le.populated_censpct_pop_multirace_cnt
          ,le.populated_censpct_pop_hispanic_cnt
          ,le.populated_censpct_pop_agelt18_cnt
          ,le.populated_censpct_pop_males_cnt
          ,le.populated_censpct_adult_age1824_cnt
          ,le.populated_censpct_adult_age2534_cnt
          ,le.populated_censpct_adult_age3544_cnt
          ,le.populated_censpct_adult_age4554_cnt
          ,le.populated_censpct_adult_age5564_cnt
          ,le.populated_censpct_adult_agege65_cnt
          ,le.populated_cens_pop_medage_cnt
          ,le.populated_cens_hh_avgsize_cnt
          ,le.populated_censpct_hh_family_cnt
          ,le.populated_censpct_hh_family_husbwife_cnt
          ,le.populated_censpct_hu_occupied_cnt
          ,le.populated_censpct_hu_owned_cnt
          ,le.populated_censpct_hu_rented_cnt
          ,le.populated_censpct_hu_vacantseasonal_cnt
          ,le.populated_zip_medinc_cnt
          ,le.populated_zip_apparel_cnt
          ,le.populated_zip_apparel_women_cnt
          ,le.populated_zip_apparel_womfash_cnt
          ,le.populated_zip_auto_cnt
          ,le.populated_zip_beauty_cnt
          ,le.populated_zip_booksmusicmovies_cnt
          ,le.populated_zip_business_cnt
          ,le.populated_zip_catalog_cnt
          ,le.populated_zip_cc_cnt
          ,le.populated_zip_collectibles_cnt
          ,le.populated_zip_computers_cnt
          ,le.populated_zip_continuity_cnt
          ,le.populated_zip_cooking_cnt
          ,le.populated_zip_crafts_cnt
          ,le.populated_zip_culturearts_cnt
          ,le.populated_zip_dm_sold_cnt
          ,le.populated_zip_donor_cnt
          ,le.populated_zip_family_cnt
          ,le.populated_zip_gardening_cnt
          ,le.populated_zip_giftgivr_cnt
          ,le.populated_zip_gourmet_cnt
          ,le.populated_zip_health_cnt
          ,le.populated_zip_health_diet_cnt
          ,le.populated_zip_health_fitness_cnt
          ,le.populated_zip_hobbies_cnt
          ,le.populated_zip_homedecr_cnt
          ,le.populated_zip_homeliv_cnt
          ,le.populated_zip_internet_cnt
          ,le.populated_zip_internet_access_cnt
          ,le.populated_zip_internet_buy_cnt
          ,le.populated_zip_music_cnt
          ,le.populated_zip_outdoors_cnt
          ,le.populated_zip_pets_cnt
          ,le.populated_zip_pfin_cnt
          ,le.populated_zip_publish_cnt
          ,le.populated_zip_publish_books_cnt
          ,le.populated_zip_publish_mags_cnt
          ,le.populated_zip_sports_cnt
          ,le.populated_zip_sports_biking_cnt
          ,le.populated_zip_sports_golf_cnt
          ,le.populated_zip_travel_cnt
          ,le.populated_zip_travel_us_cnt
          ,le.populated_zip_tvmovies_cnt
          ,le.populated_zip_woman_cnt
          ,le.populated_zip_proftech_cnt
          ,le.populated_zip_retired_cnt
          ,le.populated_zip_inc100_cnt
          ,le.populated_zip_inc75_cnt
          ,le.populated_zip_inc50_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_dtmatch_pcnt
          ,le.populated_msname_pcnt
          ,le.populated_msaddr1_pcnt
          ,le.populated_msaddr2_pcnt
          ,le.populated_mscity_pcnt
          ,le.populated_msstate_pcnt
          ,le.populated_mszip5_pcnt
          ,le.populated_mszip4_pcnt
          ,le.populated_dthh_pcnt
          ,le.populated_mscrrt_pcnt
          ,le.populated_msdpbc_pcnt
          ,le.populated_msdpv_pcnt
          ,le.populated_ms_addrtype_pcnt
          ,le.populated_ctysize_pcnt
          ,le.populated_lmos_pcnt
          ,le.populated_omos_pcnt
          ,le.populated_pmos_pcnt
          ,le.populated_gen_pcnt
          ,le.populated_dob_pcnt
          ,le.populated_age_pcnt
          ,le.populated_inc_pcnt
          ,le.populated_marital_status_pcnt
          ,le.populated_poc_pcnt
          ,le.populated_noc_pcnt
          ,le.populated_ocp_pcnt
          ,le.populated_edu_pcnt
          ,le.populated_lang_pcnt
          ,le.populated_relig_pcnt
          ,le.populated_dwell_pcnt
          ,le.populated_ownr_pcnt
          ,le.populated_eth1_pcnt
          ,le.populated_eth2_pcnt
          ,le.populated_lor_pcnt
          ,le.populated_pool_pcnt
          ,le.populated_speak_span_pcnt
          ,le.populated_soho_pcnt
          ,le.populated_vet_in_hh_pcnt
          ,le.populated_ms_mags_pcnt
          ,le.populated_ms_books_pcnt
          ,le.populated_ms_publish_pcnt
          ,le.populated_ms_pub_status_active_pcnt
          ,le.populated_ms_pub_status_expire_pcnt
          ,le.populated_ms_pub_premsold_pcnt
          ,le.populated_ms_pub_autornwl_pcnt
          ,le.populated_ms_pub_avgterm_pcnt
          ,le.populated_ms_pub_lmos_pcnt
          ,le.populated_ms_pub_omos_pcnt
          ,le.populated_ms_pub_pmos_pcnt
          ,le.populated_ms_pub_cemos_pcnt
          ,le.populated_ms_pub_femos_pcnt
          ,le.populated_ms_pub_totords_pcnt
          ,le.populated_ms_pub_totdlrs_pcnt
          ,le.populated_ms_pub_avgdlrs_pcnt
          ,le.populated_ms_pub_lastdlrs_pcnt
          ,le.populated_ms_pub_paystat_paid_pcnt
          ,le.populated_ms_pub_paystat_ub_pcnt
          ,le.populated_ms_pub_paymeth_cc_pcnt
          ,le.populated_ms_pub_paymeth_cash_pcnt
          ,le.populated_ms_pub_payspeed_pcnt
          ,le.populated_ms_pub_osrc_dm_pcnt
          ,le.populated_ms_pub_lsrc_dm_pcnt
          ,le.populated_ms_pub_osrc_agt_cashf_pcnt
          ,le.populated_ms_pub_lsrc_agt_cashf_pcnt
          ,le.populated_ms_pub_osrc_agt_pds_pcnt
          ,le.populated_ms_pub_lsrc_agt_pds_pcnt
          ,le.populated_ms_pub_osrc_agt_schplan_pcnt
          ,le.populated_ms_pub_lsrc_agt_schplan_pcnt
          ,le.populated_ms_pub_osrc_agt_sponsor_pcnt
          ,le.populated_ms_pub_lsrc_agt_sponsor_pcnt
          ,le.populated_ms_pub_osrc_agt_tm_pcnt
          ,le.populated_ms_pub_lsrc_agt_tm_pcnt
          ,le.populated_ms_pub_osrc_agt_pcnt
          ,le.populated_ms_pub_lsrc_agt_pcnt
          ,le.populated_ms_pub_osrc_tm_pcnt
          ,le.populated_ms_pub_lsrc_tm_pcnt
          ,le.populated_ms_pub_osrc_ins_pcnt
          ,le.populated_ms_pub_lsrc_ins_pcnt
          ,le.populated_ms_pub_osrc_net_pcnt
          ,le.populated_ms_pub_lsrc_net_pcnt
          ,le.populated_ms_pub_osrc_print_pcnt
          ,le.populated_ms_pub_lsrc_print_pcnt
          ,le.populated_ms_pub_osrc_trans_pcnt
          ,le.populated_ms_pub_lsrc_trans_pcnt
          ,le.populated_ms_pub_osrc_tv_pcnt
          ,le.populated_ms_pub_lsrc_tv_pcnt
          ,le.populated_ms_pub_osrc_dtp_pcnt
          ,le.populated_ms_pub_lsrc_dtp_pcnt
          ,le.populated_ms_pub_giftgivr_pcnt
          ,le.populated_ms_pub_giftee_pcnt
          ,le.populated_ms_catalog_pcnt
          ,le.populated_ms_cat_lmos_pcnt
          ,le.populated_ms_cat_omos_pcnt
          ,le.populated_ms_cat_pmos_pcnt
          ,le.populated_ms_cat_totords_pcnt
          ,le.populated_ms_cat_totitems_pcnt
          ,le.populated_ms_cat_totdlrs_pcnt
          ,le.populated_ms_cat_avgdlrs_pcnt
          ,le.populated_ms_cat_lastdlrs_pcnt
          ,le.populated_ms_cat_paystat_paid_pcnt
          ,le.populated_ms_cat_paymeth_cc_pcnt
          ,le.populated_ms_cat_paymeth_cash_pcnt
          ,le.populated_ms_cat_osrc_dm_pcnt
          ,le.populated_ms_cat_lsrc_dm_pcnt
          ,le.populated_ms_cat_osrc_net_pcnt
          ,le.populated_ms_cat_lsrc_net_pcnt
          ,le.populated_ms_cat_giftgivr_pcnt
          ,le.populated_pkpubs_corrected_pcnt
          ,le.populated_pkcatg_corrected_pcnt
          ,le.populated_ms_fundraising_pcnt
          ,le.populated_ms_fund_lmos_pcnt
          ,le.populated_ms_fund_omos_pcnt
          ,le.populated_ms_fund_pmos_pcnt
          ,le.populated_ms_fund_totords_pcnt
          ,le.populated_ms_fund_totdlrs_pcnt
          ,le.populated_ms_fund_avgdlrs_pcnt
          ,le.populated_ms_fund_lastdlrs_pcnt
          ,le.populated_ms_fund_paystat_paid_pcnt
          ,le.populated_ms_other_pcnt
          ,le.populated_ms_continuity_pcnt
          ,le.populated_ms_cont_status_active_pcnt
          ,le.populated_ms_cont_status_cancel_pcnt
          ,le.populated_ms_cont_omos_pcnt
          ,le.populated_ms_cont_lmos_pcnt
          ,le.populated_ms_cont_pmos_pcnt
          ,le.populated_ms_cont_totords_pcnt
          ,le.populated_ms_cont_totdlrs_pcnt
          ,le.populated_ms_cont_avgdlrs_pcnt
          ,le.populated_ms_cont_lastdlrs_pcnt
          ,le.populated_ms_cont_paystat_paid_pcnt
          ,le.populated_ms_cont_paymeth_cc_pcnt
          ,le.populated_ms_cont_paymeth_cash_pcnt
          ,le.populated_ms_totords_pcnt
          ,le.populated_ms_totitems_pcnt
          ,le.populated_ms_totdlrs_pcnt
          ,le.populated_ms_avgdlrs_pcnt
          ,le.populated_ms_lastdlrs_pcnt
          ,le.populated_ms_paystat_paid_pcnt
          ,le.populated_ms_paymeth_cc_pcnt
          ,le.populated_ms_paymeth_cash_pcnt
          ,le.populated_ms_osrc_dm_pcnt
          ,le.populated_ms_lsrc_dm_pcnt
          ,le.populated_ms_osrc_tm_pcnt
          ,le.populated_ms_lsrc_tm_pcnt
          ,le.populated_ms_osrc_ins_pcnt
          ,le.populated_ms_lsrc_ins_pcnt
          ,le.populated_ms_osrc_net_pcnt
          ,le.populated_ms_lsrc_net_pcnt
          ,le.populated_ms_osrc_tv_pcnt
          ,le.populated_ms_lsrc_tv_pcnt
          ,le.populated_ms_osrc_retail_pcnt
          ,le.populated_ms_lsrc_retail_pcnt
          ,le.populated_ms_giftgivr_pcnt
          ,le.populated_ms_giftee_pcnt
          ,le.populated_ms_adult_pcnt
          ,le.populated_ms_womapp_pcnt
          ,le.populated_ms_menapp_pcnt
          ,le.populated_ms_kidapp_pcnt
          ,le.populated_ms_accessory_pcnt
          ,le.populated_ms_apparel_pcnt
          ,le.populated_ms_app_lmos_pcnt
          ,le.populated_ms_app_omos_pcnt
          ,le.populated_ms_app_pmos_pcnt
          ,le.populated_ms_app_totords_pcnt
          ,le.populated_ms_app_totitems_pcnt
          ,le.populated_ms_app_totdlrs_pcnt
          ,le.populated_ms_app_avgdlrs_pcnt
          ,le.populated_ms_app_lastdlrs_pcnt
          ,le.populated_ms_app_paystat_paid_pcnt
          ,le.populated_ms_app_paymeth_cc_pcnt
          ,le.populated_ms_app_paymeth_cash_pcnt
          ,le.populated_ms_menfash_pcnt
          ,le.populated_ms_womfash_pcnt
          ,le.populated_ms_wfsh_lmos_pcnt
          ,le.populated_ms_wfsh_omos_pcnt
          ,le.populated_ms_wfsh_pmos_pcnt
          ,le.populated_ms_wfsh_totords_pcnt
          ,le.populated_ms_wfsh_totdlrs_pcnt
          ,le.populated_ms_wfsh_avgdlrs_pcnt
          ,le.populated_ms_wfsh_lastdlrs_pcnt
          ,le.populated_ms_wfsh_paystat_paid_pcnt
          ,le.populated_ms_wfsh_osrc_dm_pcnt
          ,le.populated_ms_wfsh_lsrc_dm_pcnt
          ,le.populated_ms_wfsh_osrc_agt_pcnt
          ,le.populated_ms_wfsh_lsrc_agt_pcnt
          ,le.populated_ms_audio_pcnt
          ,le.populated_ms_auto_pcnt
          ,le.populated_ms_aviation_pcnt
          ,le.populated_ms_bargains_pcnt
          ,le.populated_ms_beauty_pcnt
          ,le.populated_ms_bible_pcnt
          ,le.populated_ms_bible_lmos_pcnt
          ,le.populated_ms_bible_omos_pcnt
          ,le.populated_ms_bible_pmos_pcnt
          ,le.populated_ms_bible_totords_pcnt
          ,le.populated_ms_bible_totitems_pcnt
          ,le.populated_ms_bible_totdlrs_pcnt
          ,le.populated_ms_bible_avgdlrs_pcnt
          ,le.populated_ms_bible_lastdlrs_pcnt
          ,le.populated_ms_bible_paystat_paid_pcnt
          ,le.populated_ms_bible_paymeth_cc_pcnt
          ,le.populated_ms_bible_paymeth_cash_pcnt
          ,le.populated_ms_business_pcnt
          ,le.populated_ms_collectibles_pcnt
          ,le.populated_ms_computers_pcnt
          ,le.populated_ms_crafts_pcnt
          ,le.populated_ms_culturearts_pcnt
          ,le.populated_ms_currevent_pcnt
          ,le.populated_ms_diy_pcnt
          ,le.populated_ms_electronics_pcnt
          ,le.populated_ms_equestrian_pcnt
          ,le.populated_ms_pub_family_pcnt
          ,le.populated_ms_cat_family_pcnt
          ,le.populated_ms_family_pcnt
          ,le.populated_ms_family_lmos_pcnt
          ,le.populated_ms_family_omos_pcnt
          ,le.populated_ms_family_pmos_pcnt
          ,le.populated_ms_family_totords_pcnt
          ,le.populated_ms_family_totitems_pcnt
          ,le.populated_ms_family_totdlrs_pcnt
          ,le.populated_ms_family_avgdlrs_pcnt
          ,le.populated_ms_family_lastdlrs_pcnt
          ,le.populated_ms_family_paystat_paid_pcnt
          ,le.populated_ms_family_paymeth_cc_pcnt
          ,le.populated_ms_family_paymeth_cash_pcnt
          ,le.populated_ms_family_osrc_dm_pcnt
          ,le.populated_ms_family_lsrc_dm_pcnt
          ,le.populated_ms_fiction_pcnt
          ,le.populated_ms_food_pcnt
          ,le.populated_ms_games_pcnt
          ,le.populated_ms_gifts_pcnt
          ,le.populated_ms_gourmet_pcnt
          ,le.populated_ms_fitness_pcnt
          ,le.populated_ms_health_pcnt
          ,le.populated_ms_hlth_lmos_pcnt
          ,le.populated_ms_hlth_omos_pcnt
          ,le.populated_ms_hlth_pmos_pcnt
          ,le.populated_ms_hlth_totords_pcnt
          ,le.populated_ms_hlth_totdlrs_pcnt
          ,le.populated_ms_hlth_avgdlrs_pcnt
          ,le.populated_ms_hlth_lastdlrs_pcnt
          ,le.populated_ms_hlth_paystat_paid_pcnt
          ,le.populated_ms_hlth_paymeth_cc_pcnt
          ,le.populated_ms_hlth_osrc_dm_pcnt
          ,le.populated_ms_hlth_lsrc_dm_pcnt
          ,le.populated_ms_hlth_osrc_agt_pcnt
          ,le.populated_ms_hlth_lsrc_agt_pcnt
          ,le.populated_ms_hlth_osrc_tv_pcnt
          ,le.populated_ms_hlth_lsrc_tv_pcnt
          ,le.populated_ms_holiday_pcnt
          ,le.populated_ms_history_pcnt
          ,le.populated_ms_pub_cooking_pcnt
          ,le.populated_ms_cooking_pcnt
          ,le.populated_ms_pub_homedecr_pcnt
          ,le.populated_ms_cat_homedecr_pcnt
          ,le.populated_ms_homedecr_pcnt
          ,le.populated_ms_housewares_pcnt
          ,le.populated_ms_pub_garden_pcnt
          ,le.populated_ms_cat_garden_pcnt
          ,le.populated_ms_garden_pcnt
          ,le.populated_ms_pub_homeliv_pcnt
          ,le.populated_ms_cat_homeliv_pcnt
          ,le.populated_ms_homeliv_pcnt
          ,le.populated_ms_pub_home_status_active_pcnt
          ,le.populated_ms_home_lmos_pcnt
          ,le.populated_ms_home_omos_pcnt
          ,le.populated_ms_home_pmos_pcnt
          ,le.populated_ms_home_totords_pcnt
          ,le.populated_ms_home_totitems_pcnt
          ,le.populated_ms_home_totdlrs_pcnt
          ,le.populated_ms_home_avgdlrs_pcnt
          ,le.populated_ms_home_lastdlrs_pcnt
          ,le.populated_ms_home_paystat_paid_pcnt
          ,le.populated_ms_home_paymeth_cc_pcnt
          ,le.populated_ms_home_paymeth_cash_pcnt
          ,le.populated_ms_home_osrc_dm_pcnt
          ,le.populated_ms_home_lsrc_dm_pcnt
          ,le.populated_ms_home_osrc_agt_pcnt
          ,le.populated_ms_home_lsrc_agt_pcnt
          ,le.populated_ms_home_osrc_net_pcnt
          ,le.populated_ms_home_lsrc_net_pcnt
          ,le.populated_ms_home_osrc_tv_pcnt
          ,le.populated_ms_home_lsrc_tv_pcnt
          ,le.populated_ms_humor_pcnt
          ,le.populated_ms_inspiration_pcnt
          ,le.populated_ms_merchandise_pcnt
          ,le.populated_ms_moneymaking_pcnt
          ,le.populated_ms_moneymaking_lmos_pcnt
          ,le.populated_ms_motorcycles_pcnt
          ,le.populated_ms_music_pcnt
          ,le.populated_ms_fishing_pcnt
          ,le.populated_ms_hunting_pcnt
          ,le.populated_ms_boatsail_pcnt
          ,le.populated_ms_camp_pcnt
          ,le.populated_ms_pub_outdoors_pcnt
          ,le.populated_ms_cat_outdoors_pcnt
          ,le.populated_ms_outdoors_pcnt
          ,le.populated_ms_pub_out_status_active_pcnt
          ,le.populated_ms_out_lmos_pcnt
          ,le.populated_ms_out_omos_pcnt
          ,le.populated_ms_out_pmos_pcnt
          ,le.populated_ms_out_totords_pcnt
          ,le.populated_ms_out_totitems_pcnt
          ,le.populated_ms_out_totdlrs_pcnt
          ,le.populated_ms_out_avgdlrs_pcnt
          ,le.populated_ms_out_lastdlrs_pcnt
          ,le.populated_ms_out_paystat_paid_pcnt
          ,le.populated_ms_out_paymeth_cc_pcnt
          ,le.populated_ms_out_paymeth_cash_pcnt
          ,le.populated_ms_out_osrc_dm_pcnt
          ,le.populated_ms_out_lsrc_dm_pcnt
          ,le.populated_ms_out_osrc_agt_pcnt
          ,le.populated_ms_out_lsrc_agt_pcnt
          ,le.populated_ms_pets_pcnt
          ,le.populated_ms_pfin_pcnt
          ,le.populated_ms_photo_pcnt
          ,le.populated_ms_photoproc_pcnt
          ,le.populated_ms_rural_pcnt
          ,le.populated_ms_science_pcnt
          ,le.populated_ms_sports_pcnt
          ,le.populated_ms_sports_lmos_pcnt
          ,le.populated_ms_travel_pcnt
          ,le.populated_ms_tvmovies_pcnt
          ,le.populated_ms_wildlife_pcnt
          ,le.populated_ms_woman_pcnt
          ,le.populated_ms_woman_lmos_pcnt
          ,le.populated_ms_ringtones_apps_pcnt
          ,le.populated_cpi_mobile_apps_index_pcnt
          ,le.populated_cpi_credit_repair_index_pcnt
          ,le.populated_cpi_credit_report_index_pcnt
          ,le.populated_cpi_education_seekers_index_pcnt
          ,le.populated_cpi_insurance_index_pcnt
          ,le.populated_cpi_insurance_health_index_pcnt
          ,le.populated_cpi_insurance_auto_index_pcnt
          ,le.populated_cpi_job_seekers_index_pcnt
          ,le.populated_cpi_social_networking_index_pcnt
          ,le.populated_cpi_adult_index_pcnt
          ,le.populated_cpi_africanamerican_index_pcnt
          ,le.populated_cpi_apparel_index_pcnt
          ,le.populated_cpi_apparel_accessory_index_pcnt
          ,le.populated_cpi_apparel_kids_index_pcnt
          ,le.populated_cpi_apparel_men_index_pcnt
          ,le.populated_cpi_apparel_menfash_index_pcnt
          ,le.populated_cpi_apparel_women_index_pcnt
          ,le.populated_cpi_apparel_womfash_index_pcnt
          ,le.populated_cpi_asian_index_pcnt
          ,le.populated_cpi_auto_index_pcnt
          ,le.populated_cpi_auto_racing_index_pcnt
          ,le.populated_cpi_auto_trucks_index_pcnt
          ,le.populated_cpi_aviation_index_pcnt
          ,le.populated_cpi_bargains_index_pcnt
          ,le.populated_cpi_beauty_index_pcnt
          ,le.populated_cpi_bible_index_pcnt
          ,le.populated_cpi_birds_index_pcnt
          ,le.populated_cpi_business_index_pcnt
          ,le.populated_cpi_business_homeoffice_index_pcnt
          ,le.populated_cpi_catalog_index_pcnt
          ,le.populated_cpi_cc_index_pcnt
          ,le.populated_cpi_collectibles_index_pcnt
          ,le.populated_cpi_college_index_pcnt
          ,le.populated_cpi_computers_index_pcnt
          ,le.populated_cpi_conservative_index_pcnt
          ,le.populated_cpi_continuity_index_pcnt
          ,le.populated_cpi_cooking_index_pcnt
          ,le.populated_cpi_crafts_index_pcnt
          ,le.populated_cpi_crafts_crochet_index_pcnt
          ,le.populated_cpi_crafts_knit_index_pcnt
          ,le.populated_cpi_crafts_needlepoint_index_pcnt
          ,le.populated_cpi_crafts_quilt_index_pcnt
          ,le.populated_cpi_crafts_sew_index_pcnt
          ,le.populated_cpi_culturearts_index_pcnt
          ,le.populated_cpi_currevent_index_pcnt
          ,le.populated_cpi_diy_index_pcnt
          ,le.populated_cpi_donor_index_pcnt
          ,le.populated_cpi_ego_index_pcnt
          ,le.populated_cpi_electronics_index_pcnt
          ,le.populated_cpi_equestrian_index_pcnt
          ,le.populated_cpi_family_index_pcnt
          ,le.populated_cpi_family_teen_index_pcnt
          ,le.populated_cpi_family_young_index_pcnt
          ,le.populated_cpi_fiction_index_pcnt
          ,le.populated_cpi_gambling_index_pcnt
          ,le.populated_cpi_games_index_pcnt
          ,le.populated_cpi_gardening_index_pcnt
          ,le.populated_cpi_gay_index_pcnt
          ,le.populated_cpi_giftgivr_index_pcnt
          ,le.populated_cpi_gourmet_index_pcnt
          ,le.populated_cpi_grandparents_index_pcnt
          ,le.populated_cpi_health_index_pcnt
          ,le.populated_cpi_health_diet_index_pcnt
          ,le.populated_cpi_health_fitness_index_pcnt
          ,le.populated_cpi_hightech_index_pcnt
          ,le.populated_cpi_hispanic_index_pcnt
          ,le.populated_cpi_history_index_pcnt
          ,le.populated_cpi_history_american_index_pcnt
          ,le.populated_cpi_hobbies_index_pcnt
          ,le.populated_cpi_homedecr_index_pcnt
          ,le.populated_cpi_homeliv_index_pcnt
          ,le.populated_cpi_humor_index_pcnt
          ,le.populated_cpi_inspiration_index_pcnt
          ,le.populated_cpi_internet_index_pcnt
          ,le.populated_cpi_internet_access_index_pcnt
          ,le.populated_cpi_internet_buy_index_pcnt
          ,le.populated_cpi_liberal_index_pcnt
          ,le.populated_cpi_moneymaking_index_pcnt
          ,le.populated_cpi_motorcycles_index_pcnt
          ,le.populated_cpi_music_index_pcnt
          ,le.populated_cpi_nonfiction_index_pcnt
          ,le.populated_cpi_ocean_index_pcnt
          ,le.populated_cpi_outdoors_index_pcnt
          ,le.populated_cpi_outdoors_boatsail_index_pcnt
          ,le.populated_cpi_outdoors_camp_index_pcnt
          ,le.populated_cpi_outdoors_fishing_index_pcnt
          ,le.populated_cpi_outdoors_huntfish_index_pcnt
          ,le.populated_cpi_outdoors_hunting_index_pcnt
          ,le.populated_cpi_pets_index_pcnt
          ,le.populated_cpi_pets_cats_index_pcnt
          ,le.populated_cpi_pets_dogs_index_pcnt
          ,le.populated_cpi_pfin_index_pcnt
          ,le.populated_cpi_photog_index_pcnt
          ,le.populated_cpi_photoproc_index_pcnt
          ,le.populated_cpi_publish_index_pcnt
          ,le.populated_cpi_publish_books_index_pcnt
          ,le.populated_cpi_publish_mags_index_pcnt
          ,le.populated_cpi_rural_index_pcnt
          ,le.populated_cpi_science_index_pcnt
          ,le.populated_cpi_scifi_index_pcnt
          ,le.populated_cpi_seniors_index_pcnt
          ,le.populated_cpi_sports_index_pcnt
          ,le.populated_cpi_sports_baseball_index_pcnt
          ,le.populated_cpi_sports_basketball_index_pcnt
          ,le.populated_cpi_sports_biking_index_pcnt
          ,le.populated_cpi_sports_football_index_pcnt
          ,le.populated_cpi_sports_golf_index_pcnt
          ,le.populated_cpi_sports_hockey_index_pcnt
          ,le.populated_cpi_sports_running_index_pcnt
          ,le.populated_cpi_sports_ski_index_pcnt
          ,le.populated_cpi_sports_soccer_index_pcnt
          ,le.populated_cpi_sports_swimming_index_pcnt
          ,le.populated_cpi_sports_tennis_index_pcnt
          ,le.populated_cpi_stationery_index_pcnt
          ,le.populated_cpi_sweeps_index_pcnt
          ,le.populated_cpi_tobacco_index_pcnt
          ,le.populated_cpi_travel_index_pcnt
          ,le.populated_cpi_travel_cruise_index_pcnt
          ,le.populated_cpi_travel_rv_index_pcnt
          ,le.populated_cpi_travel_us_index_pcnt
          ,le.populated_cpi_tvmovies_index_pcnt
          ,le.populated_cpi_wildlife_index_pcnt
          ,le.populated_cpi_woman_index_pcnt
          ,le.populated_totdlr_index_pcnt
          ,le.populated_cpi_totdlr_pcnt
          ,le.populated_cpi_totords_pcnt
          ,le.populated_cpi_lastdlr_pcnt
          ,le.populated_pkcatg_pcnt
          ,le.populated_pkpubs_pcnt
          ,le.populated_pkcont_pcnt
          ,le.populated_pkca01_pcnt
          ,le.populated_pkca03_pcnt
          ,le.populated_pkca04_pcnt
          ,le.populated_pkca05_pcnt
          ,le.populated_pkca06_pcnt
          ,le.populated_pkca07_pcnt
          ,le.populated_pkca08_pcnt
          ,le.populated_pkca09_pcnt
          ,le.populated_pkca10_pcnt
          ,le.populated_pkca11_pcnt
          ,le.populated_pkca12_pcnt
          ,le.populated_pkca13_pcnt
          ,le.populated_pkca14_pcnt
          ,le.populated_pkca15_pcnt
          ,le.populated_pkca16_pcnt
          ,le.populated_pkca17_pcnt
          ,le.populated_pkca18_pcnt
          ,le.populated_pkca20_pcnt
          ,le.populated_pkca21_pcnt
          ,le.populated_pkca22_pcnt
          ,le.populated_pkca23_pcnt
          ,le.populated_pkca24_pcnt
          ,le.populated_pkca25_pcnt
          ,le.populated_pkca26_pcnt
          ,le.populated_pkca28_pcnt
          ,le.populated_pkca29_pcnt
          ,le.populated_pkca30_pcnt
          ,le.populated_pkca31_pcnt
          ,le.populated_pkca32_pcnt
          ,le.populated_pkca33_pcnt
          ,le.populated_pkca34_pcnt
          ,le.populated_pkca35_pcnt
          ,le.populated_pkca36_pcnt
          ,le.populated_pkca37_pcnt
          ,le.populated_pkca39_pcnt
          ,le.populated_pkca40_pcnt
          ,le.populated_pkca41_pcnt
          ,le.populated_pkca42_pcnt
          ,le.populated_pkca54_pcnt
          ,le.populated_pkca61_pcnt
          ,le.populated_pkca62_pcnt
          ,le.populated_pkca64_pcnt
          ,le.populated_pkpu01_pcnt
          ,le.populated_pkpu02_pcnt
          ,le.populated_pkpu03_pcnt
          ,le.populated_pkpu04_pcnt
          ,le.populated_pkpu05_pcnt
          ,le.populated_pkpu06_pcnt
          ,le.populated_pkpu07_pcnt
          ,le.populated_pkpu08_pcnt
          ,le.populated_pkpu09_pcnt
          ,le.populated_pkpu10_pcnt
          ,le.populated_pkpu11_pcnt
          ,le.populated_pkpu12_pcnt
          ,le.populated_pkpu13_pcnt
          ,le.populated_pkpu14_pcnt
          ,le.populated_pkpu15_pcnt
          ,le.populated_pkpu16_pcnt
          ,le.populated_pkpu17_pcnt
          ,le.populated_pkpu18_pcnt
          ,le.populated_pkpu19_pcnt
          ,le.populated_pkpu20_pcnt
          ,le.populated_pkpu23_pcnt
          ,le.populated_pkpu25_pcnt
          ,le.populated_pkpu27_pcnt
          ,le.populated_pkpu28_pcnt
          ,le.populated_pkpu29_pcnt
          ,le.populated_pkpu30_pcnt
          ,le.populated_pkpu31_pcnt
          ,le.populated_pkpu32_pcnt
          ,le.populated_pkpu33_pcnt
          ,le.populated_pkpu34_pcnt
          ,le.populated_pkpu35_pcnt
          ,le.populated_pkpu38_pcnt
          ,le.populated_pkpu41_pcnt
          ,le.populated_pkpu42_pcnt
          ,le.populated_pkpu45_pcnt
          ,le.populated_pkpu46_pcnt
          ,le.populated_pkpu47_pcnt
          ,le.populated_pkpu48_pcnt
          ,le.populated_pkpu49_pcnt
          ,le.populated_pkpu50_pcnt
          ,le.populated_pkpu51_pcnt
          ,le.populated_pkpu52_pcnt
          ,le.populated_pkpu53_pcnt
          ,le.populated_pkpu54_pcnt
          ,le.populated_pkpu55_pcnt
          ,le.populated_pkpu56_pcnt
          ,le.populated_pkpu57_pcnt
          ,le.populated_pkpu60_pcnt
          ,le.populated_pkpu61_pcnt
          ,le.populated_pkpu62_pcnt
          ,le.populated_pkpu63_pcnt
          ,le.populated_pkpu64_pcnt
          ,le.populated_pkpu65_pcnt
          ,le.populated_pkpu66_pcnt
          ,le.populated_pkpu67_pcnt
          ,le.populated_pkpu68_pcnt
          ,le.populated_pkpu69_pcnt
          ,le.populated_pkpu70_pcnt
          ,le.populated_censpct_water_pcnt
          ,le.populated_cens_pop_density_pcnt
          ,le.populated_cens_hu_density_pcnt
          ,le.populated_censpct_pop_white_pcnt
          ,le.populated_censpct_pop_black_pcnt
          ,le.populated_censpct_pop_amerind_pcnt
          ,le.populated_censpct_pop_asian_pcnt
          ,le.populated_censpct_pop_pacisl_pcnt
          ,le.populated_censpct_pop_othrace_pcnt
          ,le.populated_censpct_pop_multirace_pcnt
          ,le.populated_censpct_pop_hispanic_pcnt
          ,le.populated_censpct_pop_agelt18_pcnt
          ,le.populated_censpct_pop_males_pcnt
          ,le.populated_censpct_adult_age1824_pcnt
          ,le.populated_censpct_adult_age2534_pcnt
          ,le.populated_censpct_adult_age3544_pcnt
          ,le.populated_censpct_adult_age4554_pcnt
          ,le.populated_censpct_adult_age5564_pcnt
          ,le.populated_censpct_adult_agege65_pcnt
          ,le.populated_cens_pop_medage_pcnt
          ,le.populated_cens_hh_avgsize_pcnt
          ,le.populated_censpct_hh_family_pcnt
          ,le.populated_censpct_hh_family_husbwife_pcnt
          ,le.populated_censpct_hu_occupied_pcnt
          ,le.populated_censpct_hu_owned_pcnt
          ,le.populated_censpct_hu_rented_pcnt
          ,le.populated_censpct_hu_vacantseasonal_pcnt
          ,le.populated_zip_medinc_pcnt
          ,le.populated_zip_apparel_pcnt
          ,le.populated_zip_apparel_women_pcnt
          ,le.populated_zip_apparel_womfash_pcnt
          ,le.populated_zip_auto_pcnt
          ,le.populated_zip_beauty_pcnt
          ,le.populated_zip_booksmusicmovies_pcnt
          ,le.populated_zip_business_pcnt
          ,le.populated_zip_catalog_pcnt
          ,le.populated_zip_cc_pcnt
          ,le.populated_zip_collectibles_pcnt
          ,le.populated_zip_computers_pcnt
          ,le.populated_zip_continuity_pcnt
          ,le.populated_zip_cooking_pcnt
          ,le.populated_zip_crafts_pcnt
          ,le.populated_zip_culturearts_pcnt
          ,le.populated_zip_dm_sold_pcnt
          ,le.populated_zip_donor_pcnt
          ,le.populated_zip_family_pcnt
          ,le.populated_zip_gardening_pcnt
          ,le.populated_zip_giftgivr_pcnt
          ,le.populated_zip_gourmet_pcnt
          ,le.populated_zip_health_pcnt
          ,le.populated_zip_health_diet_pcnt
          ,le.populated_zip_health_fitness_pcnt
          ,le.populated_zip_hobbies_pcnt
          ,le.populated_zip_homedecr_pcnt
          ,le.populated_zip_homeliv_pcnt
          ,le.populated_zip_internet_pcnt
          ,le.populated_zip_internet_access_pcnt
          ,le.populated_zip_internet_buy_pcnt
          ,le.populated_zip_music_pcnt
          ,le.populated_zip_outdoors_pcnt
          ,le.populated_zip_pets_pcnt
          ,le.populated_zip_pfin_pcnt
          ,le.populated_zip_publish_pcnt
          ,le.populated_zip_publish_books_pcnt
          ,le.populated_zip_publish_mags_pcnt
          ,le.populated_zip_sports_pcnt
          ,le.populated_zip_sports_biking_pcnt
          ,le.populated_zip_sports_golf_pcnt
          ,le.populated_zip_travel_pcnt
          ,le.populated_zip_travel_us_pcnt
          ,le.populated_zip_tvmovies_pcnt
          ,le.populated_zip_woman_pcnt
          ,le.populated_zip_proftech_pcnt
          ,le.populated_zip_retired_pcnt
          ,le.populated_zip_inc100_pcnt
          ,le.populated_zip_inc75_pcnt
          ,le.populated_zip_inc50_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,633,xNormHygieneStats(LEFT,COUNTER,'POP'));

  // record count stats
    SALT311.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));

    mod_Delta := Delta(prevDS, PROJECT(h, Layout_Dunndata_Consumer));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),633,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);

    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;

EXPORT StandardStats(DATASET(Layout_Dunndata_Consumer) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;

  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Dunndata_Consumer, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));

  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);

  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));

  RETURN scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
