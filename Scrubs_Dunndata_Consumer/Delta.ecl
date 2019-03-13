﻿IMPORT SALT311,STD;
EXPORT Delta(DATASET(Layout_Dunndata_Consumer)old_s, DATASET(Layout_Dunndata_Consumer) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['dtmatch','msname','msaddr1','msaddr2','mscity','msstate','mszip5','mszip4','dthh','mscrrt','msdpbc','msdpv','ms_addrtype','ctysize','lmos','omos','pmos','gen','dob','age','inc','marital_status','poc','noc','ocp','edu','lang','relig','dwell','ownr','eth1','eth2','lor','pool','speak_span','soho','vet_in_hh','ms_mags','ms_books','ms_publish','ms_pub_status_active','ms_pub_status_expire','ms_pub_premsold','ms_pub_autornwl','ms_pub_avgterm','ms_pub_lmos','ms_pub_omos','ms_pub_pmos','ms_pub_cemos','ms_pub_femos','ms_pub_totords','ms_pub_totdlrs','ms_pub_avgdlrs','ms_pub_lastdlrs','ms_pub_paystat_paid','ms_pub_paystat_ub','ms_pub_paymeth_cc','ms_pub_paymeth_cash','ms_pub_payspeed','ms_pub_osrc_dm','ms_pub_lsrc_dm','ms_pub_osrc_agt_cashf','ms_pub_lsrc_agt_cashf','ms_pub_osrc_agt_pds','ms_pub_lsrc_agt_pds','ms_pub_osrc_agt_schplan','ms_pub_lsrc_agt_schplan','ms_pub_osrc_agt_sponsor','ms_pub_lsrc_agt_sponsor','ms_pub_osrc_agt_tm','ms_pub_lsrc_agt_tm','ms_pub_osrc_agt','ms_pub_lsrc_agt','ms_pub_osrc_tm','ms_pub_lsrc_tm','ms_pub_osrc_ins','ms_pub_lsrc_ins','ms_pub_osrc_net','ms_pub_lsrc_net','ms_pub_osrc_print','ms_pub_lsrc_print','ms_pub_osrc_trans','ms_pub_lsrc_trans','ms_pub_osrc_tv','ms_pub_lsrc_tv','ms_pub_osrc_dtp','ms_pub_lsrc_dtp','ms_pub_giftgivr','ms_pub_giftee','ms_catalog','ms_cat_lmos','ms_cat_omos','ms_cat_pmos','ms_cat_totords','ms_cat_totitems','ms_cat_totdlrs','ms_cat_avgdlrs','ms_cat_lastdlrs','ms_cat_paystat_paid','ms_cat_paymeth_cc','ms_cat_paymeth_cash','ms_cat_osrc_dm','ms_cat_lsrc_dm','ms_cat_osrc_net','ms_cat_lsrc_net','ms_cat_giftgivr','pkpubs_corrected','pkcatg_corrected','ms_fundraising','ms_fund_lmos','ms_fund_omos','ms_fund_pmos','ms_fund_totords','ms_fund_totdlrs','ms_fund_avgdlrs','ms_fund_lastdlrs','ms_fund_paystat_paid','ms_other','ms_continuity','ms_cont_status_active','ms_cont_status_cancel','ms_cont_omos','ms_cont_lmos','ms_cont_pmos','ms_cont_totords','ms_cont_totdlrs','ms_cont_avgdlrs','ms_cont_lastdlrs','ms_cont_paystat_paid','ms_cont_paymeth_cc','ms_cont_paymeth_cash','ms_totords','ms_totitems','ms_totdlrs','ms_avgdlrs','ms_lastdlrs','ms_paystat_paid','ms_paymeth_cc','ms_paymeth_cash','ms_osrc_dm','ms_lsrc_dm','ms_osrc_tm','ms_lsrc_tm','ms_osrc_ins','ms_lsrc_ins','ms_osrc_net','ms_lsrc_net','ms_osrc_tv','ms_lsrc_tv','ms_osrc_retail','ms_lsrc_retail','ms_giftgivr','ms_giftee','ms_adult','ms_womapp','ms_menapp','ms_kidapp','ms_accessory','ms_apparel','ms_app_lmos','ms_app_omos','ms_app_pmos','ms_app_totords','ms_app_totitems','ms_app_totdlrs','ms_app_avgdlrs','ms_app_lastdlrs','ms_app_paystat_paid','ms_app_paymeth_cc','ms_app_paymeth_cash','ms_menfash','ms_womfash','ms_wfsh_lmos','ms_wfsh_omos','ms_wfsh_pmos','ms_wfsh_totords','ms_wfsh_totdlrs','ms_wfsh_avgdlrs','ms_wfsh_lastdlrs','ms_wfsh_paystat_paid','ms_wfsh_osrc_dm','ms_wfsh_lsrc_dm','ms_wfsh_osrc_agt','ms_wfsh_lsrc_agt','ms_audio','ms_auto','ms_aviation','ms_bargains','ms_beauty','ms_bible','ms_bible_lmos','ms_bible_omos','ms_bible_pmos','ms_bible_totords','ms_bible_totitems','ms_bible_totdlrs','ms_bible_avgdlrs','ms_bible_lastdlrs','ms_bible_paystat_paid','ms_bible_paymeth_cc','ms_bible_paymeth_cash','ms_business','ms_collectibles','ms_computers','ms_crafts','ms_culturearts','ms_currevent','ms_diy','ms_electronics','ms_equestrian','ms_pub_family','ms_cat_family','ms_family','ms_family_lmos','ms_family_omos','ms_family_pmos','ms_family_totords','ms_family_totitems','ms_family_totdlrs','ms_family_avgdlrs','ms_family_lastdlrs','ms_family_paystat_paid','ms_family_paymeth_cc','ms_family_paymeth_cash','ms_family_osrc_dm','ms_family_lsrc_dm','ms_fiction','ms_food','ms_games','ms_gifts','ms_gourmet','ms_fitness','ms_health','ms_hlth_lmos','ms_hlth_omos','ms_hlth_pmos','ms_hlth_totords','ms_hlth_totdlrs','ms_hlth_avgdlrs','ms_hlth_lastdlrs','ms_hlth_paystat_paid','ms_hlth_paymeth_cc','ms_hlth_osrc_dm','ms_hlth_lsrc_dm','ms_hlth_osrc_agt','ms_hlth_lsrc_agt','ms_hlth_osrc_tv','ms_hlth_lsrc_tv','ms_holiday','ms_history','ms_pub_cooking','ms_cooking','ms_pub_homedecr','ms_cat_homedecr','ms_homedecr','ms_housewares','ms_pub_garden','ms_cat_garden','ms_garden','ms_pub_homeliv','ms_cat_homeliv','ms_homeliv','ms_pub_home_status_active','ms_home_lmos','ms_home_omos','ms_home_pmos','ms_home_totords','ms_home_totitems','ms_home_totdlrs','ms_home_avgdlrs','ms_home_lastdlrs','ms_home_paystat_paid','ms_home_paymeth_cc','ms_home_paymeth_cash','ms_home_osrc_dm','ms_home_lsrc_dm','ms_home_osrc_agt','ms_home_lsrc_agt','ms_home_osrc_net','ms_home_lsrc_net','ms_home_osrc_tv','ms_home_lsrc_tv','ms_humor','ms_inspiration','ms_merchandise','ms_moneymaking','ms_moneymaking_lmos','ms_motorcycles','ms_music','ms_fishing','ms_hunting','ms_boatsail','ms_camp','ms_pub_outdoors','ms_cat_outdoors','ms_outdoors','ms_pub_out_status_active','ms_out_lmos','ms_out_omos','ms_out_pmos','ms_out_totords','ms_out_totitems','ms_out_totdlrs','ms_out_avgdlrs','ms_out_lastdlrs','ms_out_paystat_paid','ms_out_paymeth_cc','ms_out_paymeth_cash','ms_out_osrc_dm','ms_out_lsrc_dm','ms_out_osrc_agt','ms_out_lsrc_agt','ms_pets','ms_pfin','ms_photo','ms_photoproc','ms_rural','ms_science','ms_sports','ms_sports_lmos','ms_travel','ms_tvmovies','ms_wildlife','ms_woman','ms_woman_lmos','ms_ringtones_apps','cpi_mobile_apps_index','cpi_credit_repair_index','cpi_credit_report_index','cpi_education_seekers_index','cpi_insurance_index','cpi_insurance_health_index','cpi_insurance_auto_index','cpi_job_seekers_index','cpi_social_networking_index','cpi_adult_index','cpi_africanamerican_index','cpi_apparel_index','cpi_apparel_accessory_index','cpi_apparel_kids_index','cpi_apparel_men_index','cpi_apparel_menfash_index','cpi_apparel_women_index','cpi_apparel_womfash_index','cpi_asian_index','cpi_auto_index','cpi_auto_racing_index','cpi_auto_trucks_index','cpi_aviation_index','cpi_bargains_index','cpi_beauty_index','cpi_bible_index','cpi_birds_index','cpi_business_index','cpi_business_homeoffice_index','cpi_catalog_index','cpi_cc_index','cpi_collectibles_index','cpi_college_index','cpi_computers_index','cpi_conservative_index','cpi_continuity_index','cpi_cooking_index','cpi_crafts_index','cpi_crafts_crochet_index','cpi_crafts_knit_index','cpi_crafts_needlepoint_index','cpi_crafts_quilt_index','cpi_crafts_sew_index','cpi_culturearts_index','cpi_currevent_index','cpi_diy_index','cpi_donor_index','cpi_ego_index','cpi_electronics_index','cpi_equestrian_index','cpi_family_index','cpi_family_teen_index','cpi_family_young_index','cpi_fiction_index','cpi_gambling_index','cpi_games_index','cpi_gardening_index','cpi_gay_index','cpi_giftgivr_index','cpi_gourmet_index','cpi_grandparents_index','cpi_health_index','cpi_health_diet_index','cpi_health_fitness_index','cpi_hightech_index','cpi_hispanic_index','cpi_history_index','cpi_history_american_index','cpi_hobbies_index','cpi_homedecr_index','cpi_homeliv_index','cpi_humor_index','cpi_inspiration_index','cpi_internet_index','cpi_internet_access_index','cpi_internet_buy_index','cpi_liberal_index','cpi_moneymaking_index','cpi_motorcycles_index','cpi_music_index','cpi_nonfiction_index','cpi_ocean_index','cpi_outdoors_index','cpi_outdoors_boatsail_index','cpi_outdoors_camp_index','cpi_outdoors_fishing_index','cpi_outdoors_huntfish_index','cpi_outdoors_hunting_index','cpi_pets_index','cpi_pets_cats_index','cpi_pets_dogs_index','cpi_pfin_index','cpi_photog_index','cpi_photoproc_index','cpi_publish_index','cpi_publish_books_index','cpi_publish_mags_index','cpi_rural_index','cpi_science_index','cpi_scifi_index','cpi_seniors_index','cpi_sports_index','cpi_sports_baseball_index','cpi_sports_basketball_index','cpi_sports_biking_index','cpi_sports_football_index','cpi_sports_golf_index','cpi_sports_hockey_index','cpi_sports_running_index','cpi_sports_ski_index','cpi_sports_soccer_index','cpi_sports_swimming_index','cpi_sports_tennis_index','cpi_stationery_index','cpi_sweeps_index','cpi_tobacco_index','cpi_travel_index','cpi_travel_cruise_index','cpi_travel_rv_index','cpi_travel_us_index','cpi_tvmovies_index','cpi_wildlife_index','cpi_woman_index','totdlr_index','cpi_totdlr','cpi_totords','cpi_lastdlr','pkcatg','pkpubs','pkcont','pkca01','pkca03','pkca04','pkca05','pkca06','pkca07','pkca08','pkca09','pkca10','pkca11','pkca12','pkca13','pkca14','pkca15','pkca16','pkca17','pkca18','pkca20','pkca21','pkca22','pkca23','pkca24','pkca25','pkca26','pkca28','pkca29','pkca30','pkca31','pkca32','pkca33','pkca34','pkca35','pkca36','pkca37','pkca39','pkca40','pkca41','pkca42','pkca54','pkca61','pkca62','pkca64','pkpu01','pkpu02','pkpu03','pkpu04','pkpu05','pkpu06','pkpu07','pkpu08','pkpu09','pkpu10','pkpu11','pkpu12','pkpu13','pkpu14','pkpu15','pkpu16','pkpu17','pkpu18','pkpu19','pkpu20','pkpu23','pkpu25','pkpu27','pkpu28','pkpu29','pkpu30','pkpu31','pkpu32','pkpu33','pkpu34','pkpu35','pkpu38','pkpu41','pkpu42','pkpu45','pkpu46','pkpu47','pkpu48','pkpu49','pkpu50','pkpu51','pkpu52','pkpu53','pkpu54','pkpu55','pkpu56','pkpu57','pkpu60','pkpu61','pkpu62','pkpu63','pkpu64','pkpu65','pkpu66','pkpu67','pkpu68','pkpu69','pkpu70','censpct_water','cens_pop_density','cens_hu_density','censpct_pop_white','censpct_pop_black','censpct_pop_amerind','censpct_pop_asian','censpct_pop_pacisl','censpct_pop_othrace','censpct_pop_multirace','censpct_pop_hispanic','censpct_pop_agelt18','censpct_pop_males','censpct_adult_age1824','censpct_adult_age2534','censpct_adult_age3544','censpct_adult_age4554','censpct_adult_age5564','censpct_adult_agege65','cens_pop_medage','cens_hh_avgsize','censpct_hh_family','censpct_hh_family_husbwife','censpct_hu_occupied','censpct_hu_owned','censpct_hu_rented','censpct_hu_vacantseasonal','zip_medinc','zip_apparel','zip_apparel_women','zip_apparel_womfash','zip_auto','zip_beauty','zip_booksmusicmovies','zip_business','zip_catalog','zip_cc','zip_collectibles','zip_computers','zip_continuity','zip_cooking','zip_crafts','zip_culturearts','zip_dm_sold','zip_donor','zip_family','zip_gardening','zip_giftgivr','zip_gourmet','zip_health','zip_health_diet','zip_health_fitness','zip_hobbies','zip_homedecr','zip_homeliv','zip_internet','zip_internet_access','zip_internet_buy','zip_music','zip_outdoors','zip_pets','zip_pfin','zip_publish','zip_publish_books','zip_publish_mags','zip_sports','zip_sports_biking','zip_sports_golf','zip_travel','zip_travel_us','zip_tvmovies','zip_woman','zip_proftech','zip_retired','zip_inc100','zip_inc75','zip_inc50'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(PROJECT(Differences(deleted), TRANSFORM(Layout_Dunndata_Consumer, SELF := LEFT.old_rec))).Summary('Deletions') + hygiene(PROJECT(Differences(added), TRANSFORM(Layout_Dunndata_Consumer, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Dunndata_Consumer, Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));


    RETURN hygieneDiffOverall_Standard;
  END;
END;
