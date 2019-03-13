﻿Generated by SALT V3.11.0
Command line options: -gn 
File being processed :-
OPTIONS:-gn
MODULE:Dunndata_Consumer
FILENAME:Basefile
INGESTFILE:dunn_consumer_update:NAMED(Dunndata_Consumer.In_Basefile)
RIDFIELD:rcid

FIELD:dt_first_seen:TYPE(UNSIGNED4):RECORDDATE(FIRST):0,0
FIELD:dt_last_seen:TYPE(UNSIGNED4):RECORDDATE(LAST):0,0
FIELD:dt_vendor_first_reported:TYPE(UNSIGNED4):RECORDDATE(FIRST):0,0
FIELD:dt_vendor_last_reported:TYPE(UNSIGNED4):RECORDDATE(LAST):0,0
FIELD:process_date:TYPE(STRING8):RECORDDATE(LAST):0,0;
FIELD:src:TYPE(STRING2):DERIVED:0,0
FIELD:did:TYPE(UNSIGNED6):DERIVED:0,0
FIELD:did_score:TYPE(UNSIGNED1):DERIVED:0,0
FIELD:bdid:TYPE(UNSIGNED6):DERIVED:0,0
FIELD:bdid_score:TYPE(UNSIGNED1):DERIVED:0,0
FIELD:append_ssn:TYPE(STRING9):DERIVED:0,0
FIELD:append_fein:TYPE(STRING9):DERIVED:0,0
FIELD:append_income:TYPE(STRING15):DERIVED:0,0
FIELD:append_occupation:TYPE(STRING50):DERIVED:0,0
FIELD:append_education:TYPE(STRING40):DERIVED:0,0
FIELD:append_religion:TYPE(STRING40):DERIVED:0,0
FIELD:append_dwell:TYPE(STRING20):DERIVED:0,0
FIELD:append_ethnicity1:TYPE(STRING60):DERIVED:0,0
FIELD:append_ethnicity2:TYPE(STRING30):DERIVED:0,0
FIELD:append_language:TYPE(STRING50):DERIVED:0,0

FIELD:dtmatch:TYPE(STRING32):DERIVED:0,0
FIELD:msname:TYPE(STRING40):0,0
FIELD:msaddr1:TYPE(STRING40):0,0
FIELD:msaddr2:TYPE(STRING40):0,0
FIELD:mscity:TYPE(STRING20):0,0
FIELD:msstate:TYPE(STRING2):0,0
FIELD:mszip5:TYPE(STRING5):0,0
FIELD:mszip4:TYPE(STRING4):0,0
FIELD:dthh:TYPE(STRING29):DERIVED:0,0
FIELD:mscrrt:TYPE(STRING4):DERIVED:0,0
FIELD:msdpbc:TYPE(STRING3):DERIVED:0,0
FIELD:msdpv:TYPE(STRING1):DERIVED:0,0
FIELD:ms_addrtype:TYPE(STRING1):DERIVED:0,0
FIELD:ctysize:TYPE(STRING1):DERIVED:0,0
FIELD:lmos:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:omos:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pmos:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:gen:TYPE(STRING1):DERIVED:0,0
FIELD:dob:TYPE(STRING8):DERIVED:0,0
FIELD:age:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:inc:TYPE(STRING1):DERIVED:0,0
FIELD:marital_status:TYPE(STRING1):DERIVED:0,0
FIELD:poc:TYPE(STRING1):DERIVED:0,0
FIELD:noc:TYPE(STRING1):DERIVED:0,0
FIELD:ocp:TYPE(STRING1):DERIVED:0,0
FIELD:edu:TYPE(STRING1):DERIVED:0,0
FIELD:lang:TYPE(STRING2):DERIVED:0,0
FIELD:relig:TYPE(STRING2):DERIVED:0,0
FIELD:dwell:TYPE(STRING1):DERIVED:0,0
FIELD:ownr:TYPE(STRING1):DERIVED:0,0
FIELD:eth1:TYPE(STRING2):DERIVED:0,0
FIELD:eth2:TYPE(STRING2):DERIVED:0,0
FIELD:lor:TYPE(STRING2):DERIVED:0,0
FIELD:pool:TYPE(STRING1):DERIVED:0,0
FIELD:speak_span:TYPE(STRING1):DERIVED:0,0
FIELD:soho:TYPE(STRING1):DERIVED:0,0
FIELD:vet_in_hh:TYPE(STRING1):DERIVED:0,0
FIELD:ms_mags:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_books:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_publish:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_status_active:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_status_expire:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_premsold:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_autornwl:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_avgterm:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_lmos:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_omos:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_pmos:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_cemos:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_femos:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_totords:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_totdlrs:TYPE(UNSIGNED4):DERIVED:0,0
FIELD:ms_pub_avgdlrs:TYPE(UNSIGNED4):DERIVED:0,0
FIELD:ms_pub_lastdlrs:TYPE(UNSIGNED4):DERIVED:0,0
FIELD:ms_pub_paystat_paid:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_paystat_ub:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_paymeth_cc:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_paymeth_cash:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_payspeed:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_osrc_dm:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_lsrc_dm:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_osrc_agt_cashf:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_lsrc_agt_cashf:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_osrc_agt_pds:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_lsrc_agt_pds:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_osrc_agt_schplan:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_lsrc_agt_schplan:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_osrc_agt_sponsor:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_lsrc_agt_sponsor:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_osrc_agt_tm:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_lsrc_agt_tm:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_osrc_agt:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_lsrc_agt:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_osrc_tm:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_lsrc_tm:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_osrc_ins:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_lsrc_ins:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_osrc_net:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_lsrc_net:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_osrc_print:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_lsrc_print:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_osrc_trans:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_lsrc_trans:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_osrc_tv:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_lsrc_tv:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_osrc_dtp:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_lsrc_dtp:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_giftgivr:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_giftee:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_catalog:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_cat_lmos:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_cat_omos:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_cat_pmos:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_cat_totords:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_cat_totitems:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_cat_totdlrs:TYPE(UNSIGNED4):DERIVED:0,0
FIELD:ms_cat_avgdlrs:TYPE(UNSIGNED4):DERIVED:0,0
FIELD:ms_cat_lastdlrs:TYPE(UNSIGNED4):DERIVED:0,0
FIELD:ms_cat_paystat_paid:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_cat_paymeth_cc:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_cat_paymeth_cash:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_cat_osrc_dm:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_cat_lsrc_dm:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_cat_osrc_net:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_cat_lsrc_net:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_cat_giftgivr:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpubs_corrected:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkcatg_corrected:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_fundraising:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_fund_lmos:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_fund_omos:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_fund_pmos:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_fund_totords:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_fund_totdlrs:TYPE(UNSIGNED4):DERIVED:0,0
FIELD:ms_fund_avgdlrs:TYPE(UNSIGNED4):DERIVED:0,0
FIELD:ms_fund_lastdlrs:TYPE(UNSIGNED4):DERIVED:0,0
FIELD:ms_fund_paystat_paid:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_other:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_continuity:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_cont_status_active:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_cont_status_cancel:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_cont_omos:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_cont_lmos:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_cont_pmos:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_cont_totords:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_cont_totdlrs:TYPE(UNSIGNED4):DERIVED:0,0
FIELD:ms_cont_avgdlrs:TYPE(UNSIGNED4):DERIVED:0,0
FIELD:ms_cont_lastdlrs:TYPE(UNSIGNED4):DERIVED:0,0
FIELD:ms_cont_paystat_paid:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_cont_paymeth_cc:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_cont_paymeth_cash:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_totords:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_totitems:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_totdlrs:TYPE(UNSIGNED4):DERIVED:0,0
FIELD:ms_avgdlrs:TYPE(UNSIGNED4):DERIVED:0,0
FIELD:ms_lastdlrs:TYPE(UNSIGNED4):DERIVED:0,0
FIELD:ms_paystat_paid:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_paymeth_cc:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_paymeth_cash:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_osrc_dm:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_lsrc_dm:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_osrc_tm:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_lsrc_tm:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_osrc_ins:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_lsrc_ins:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_osrc_net:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_lsrc_net:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_osrc_tv:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_lsrc_tv:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_osrc_retail:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_lsrc_retail:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_giftgivr:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_giftee:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_adult:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_womapp:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_menapp:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_kidapp:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_accessory:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_apparel:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_app_lmos:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_app_omos:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_app_pmos:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_app_totords:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_app_totitems:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_app_totdlrs:TYPE(UNSIGNED4):DERIVED:0,0
FIELD:ms_app_avgdlrs:TYPE(UNSIGNED4):DERIVED:0,0
FIELD:ms_app_lastdlrs:TYPE(UNSIGNED4):DERIVED:0,0
FIELD:ms_app_paystat_paid:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_app_paymeth_cc:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_app_paymeth_cash:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_menfash:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_womfash:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_wfsh_lmos:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_wfsh_omos:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_wfsh_pmos:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_wfsh_totords:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_wfsh_totdlrs:TYPE(UNSIGNED4):DERIVED:0,0
FIELD:ms_wfsh_avgdlrs:TYPE(UNSIGNED4):DERIVED:0,0
FIELD:ms_wfsh_lastdlrs:TYPE(UNSIGNED4):DERIVED:0,0
FIELD:ms_wfsh_paystat_paid:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_wfsh_osrc_dm:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_wfsh_lsrc_dm:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_wfsh_osrc_agt:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_wfsh_lsrc_agt:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_audio:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_auto:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_aviation:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_bargains:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_beauty:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_bible:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_bible_lmos:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_bible_omos:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_bible_pmos:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_bible_totords:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_bible_totitems:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_bible_totdlrs:TYPE(UNSIGNED4):DERIVED:0,0
FIELD:ms_bible_avgdlrs:TYPE(UNSIGNED4):DERIVED:0,0
FIELD:ms_bible_lastdlrs:TYPE(UNSIGNED4):DERIVED:0,0
FIELD:ms_bible_paystat_paid:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_bible_paymeth_cc:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_bible_paymeth_cash:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_business:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_collectibles:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_computers:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_crafts:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_culturearts:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_currevent:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_diy:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_electronics:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_equestrian:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_family:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_cat_family:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_family:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_family_lmos:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_family_omos:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_family_pmos:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_family_totords:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_family_totitems:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_family_totdlrs:TYPE(UNSIGNED4):DERIVED:0,0
FIELD:ms_family_avgdlrs:TYPE(UNSIGNED4):DERIVED:0,0
FIELD:ms_family_lastdlrs:TYPE(UNSIGNED4):DERIVED:0,0
FIELD:ms_family_paystat_paid:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_family_paymeth_cc:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_family_paymeth_cash:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_family_osrc_dm:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_family_lsrc_dm:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_fiction:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_food:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_games:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_gifts:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_gourmet:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_fitness:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_health:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_hlth_lmos:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_hlth_omos:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_hlth_pmos:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_hlth_totords:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_hlth_totdlrs:TYPE(UNSIGNED4):DERIVED:0,0
FIELD:ms_hlth_avgdlrs:TYPE(UNSIGNED4):DERIVED:0,0
FIELD:ms_hlth_lastdlrs:TYPE(UNSIGNED4):DERIVED:0,0
FIELD:ms_hlth_paystat_paid:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_hlth_paymeth_cc:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_hlth_osrc_dm:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_hlth_lsrc_dm:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_hlth_osrc_agt:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_hlth_lsrc_agt:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_hlth_osrc_tv:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_hlth_lsrc_tv:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_holiday:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_history:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_cooking:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_cooking:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_homedecr:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_cat_homedecr:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_homedecr:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_housewares:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_garden:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_cat_garden:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_garden:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_homeliv:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_cat_homeliv:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_homeliv:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_home_status_active:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_home_lmos:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_home_omos:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_home_pmos:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_home_totords:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_home_totitems:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_home_totdlrs:TYPE(UNSIGNED4):DERIVED:0,0
FIELD:ms_home_avgdlrs:TYPE(UNSIGNED4):DERIVED:0,0
FIELD:ms_home_lastdlrs:TYPE(UNSIGNED4):DERIVED:0,0
FIELD:ms_home_paystat_paid:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_home_paymeth_cc:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_home_paymeth_cash:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_home_osrc_dm:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_home_lsrc_dm:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_home_osrc_agt:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_home_lsrc_agt:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_home_osrc_net:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_home_lsrc_net:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_home_osrc_tv:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_home_lsrc_tv:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_humor:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_inspiration:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_merchandise:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_moneymaking:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_moneymaking_lmos:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_motorcycles:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_music:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_fishing:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_hunting:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_boatsail:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_camp:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_outdoors:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_cat_outdoors:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_outdoors:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pub_out_status_active:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_out_lmos:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_out_omos:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_out_pmos:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_out_totords:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_out_totitems:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_out_totdlrs:TYPE(UNSIGNED4):DERIVED:0,0
FIELD:ms_out_avgdlrs:TYPE(UNSIGNED4):DERIVED:0,0
FIELD:ms_out_lastdlrs:TYPE(UNSIGNED4):DERIVED:0,0
FIELD:ms_out_paystat_paid:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_out_paymeth_cc:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_out_paymeth_cash:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_out_osrc_dm:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_out_lsrc_dm:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_out_osrc_agt:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_out_lsrc_agt:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pets:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_pfin:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_photo:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_photoproc:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_rural:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_science:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_sports:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_sports_lmos:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_travel:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_tvmovies:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_wildlife:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_woman:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_woman_lmos:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:ms_ringtones_apps:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_mobile_apps_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_credit_repair_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_credit_report_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_education_seekers_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_insurance_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_insurance_health_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_insurance_auto_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_job_seekers_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_social_networking_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_adult_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_africanamerican_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_apparel_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_apparel_accessory_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_apparel_kids_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_apparel_men_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_apparel_menfash_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_apparel_women_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_apparel_womfash_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_asian_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_auto_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_auto_racing_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_auto_trucks_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_aviation_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_bargains_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_beauty_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_bible_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_birds_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_business_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_business_homeoffice_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_catalog_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_cc_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_collectibles_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_college_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_computers_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_conservative_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_continuity_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_cooking_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_crafts_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_crafts_crochet_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_crafts_knit_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_crafts_needlepoint_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_crafts_quilt_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_crafts_sew_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_culturearts_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_currevent_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_diy_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_donor_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_ego_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_electronics_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_equestrian_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_family_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_family_teen_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_family_young_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_fiction_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_gambling_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_games_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_gardening_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_gay_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_giftgivr_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_gourmet_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_grandparents_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_health_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_health_diet_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_health_fitness_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_hightech_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_hispanic_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_history_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_history_american_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_hobbies_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_homedecr_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_homeliv_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_humor_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_inspiration_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_internet_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_internet_access_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_internet_buy_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_liberal_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_moneymaking_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_motorcycles_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_music_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_nonfiction_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_ocean_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_outdoors_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_outdoors_boatsail_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_outdoors_camp_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_outdoors_fishing_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_outdoors_huntfish_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_outdoors_hunting_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_pets_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_pets_cats_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_pets_dogs_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_pfin_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_photog_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_photoproc_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_publish_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_publish_books_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_publish_mags_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_rural_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_science_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_scifi_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_seniors_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_sports_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_sports_baseball_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_sports_basketball_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_sports_biking_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_sports_football_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_sports_golf_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_sports_hockey_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_sports_running_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_sports_ski_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_sports_soccer_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_sports_swimming_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_sports_tennis_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_stationery_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_sweeps_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_tobacco_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_travel_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_travel_cruise_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_travel_rv_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_travel_us_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_tvmovies_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_wildlife_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_woman_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:totdlr_index:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_totdlr:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_totords:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cpi_lastdlr:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkcatg:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpubs:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkcont:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkca01:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkca03:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkca04:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkca05:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkca06:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkca07:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkca08:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkca09:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkca10:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkca11:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkca12:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkca13:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkca14:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkca15:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkca16:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkca17:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkca18:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkca20:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkca21:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkca22:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkca23:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkca24:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkca25:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkca26:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkca28:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkca29:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkca30:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkca31:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkca32:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkca33:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkca34:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkca35:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkca36:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkca37:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkca39:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkca40:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkca41:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkca42:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkca54:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkca61:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkca62:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkca64:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu01:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu02:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu03:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu04:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu05:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu06:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu07:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu08:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu09:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu10:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu11:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu12:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu13:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu14:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu15:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu16:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu17:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu18:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu19:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu20:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu23:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu25:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu27:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu28:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu29:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu30:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu31:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu32:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu33:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu34:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu35:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu38:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu41:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu42:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu45:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu46:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu47:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu48:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu49:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu50:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu51:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu52:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu53:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu54:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu55:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu56:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu57:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu60:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu61:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu62:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu63:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu64:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu65:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu66:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu67:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu68:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu69:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:pkpu70:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:censpct_water:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cens_pop_density:TYPE(UNSIGNED4):DERIVED:0,0
FIELD:cens_hu_density:TYPE(UNSIGNED4):DERIVED:0,0
FIELD:censpct_pop_white:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:censpct_pop_black:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:censpct_pop_amerind:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:censpct_pop_asian:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:censpct_pop_pacisl:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:censpct_pop_othrace:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:censpct_pop_multirace:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:censpct_pop_hispanic:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:censpct_pop_agelt18:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:censpct_pop_males:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:censpct_adult_age1824:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:censpct_adult_age2534:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:censpct_adult_age3544:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:censpct_adult_age4554:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:censpct_adult_age5564:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:censpct_adult_agege65:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cens_pop_medage:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:cens_hh_avgsize:TYPE(UNSIGNED5):DERIVED:0,0
FIELD:censpct_hh_family:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:censpct_hh_family_husbwife:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:censpct_hu_occupied:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:censpct_hu_owned:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:censpct_hu_rented:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:censpct_hu_vacantseasonal:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:zip_medinc:TYPE(UNSIGNED4):DERIVED:0,0
FIELD:zip_apparel:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:zip_apparel_women:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:zip_apparel_womfash:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:zip_auto:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:zip_beauty:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:zip_booksmusicmovies:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:zip_business:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:zip_catalog:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:zip_cc:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:zip_collectibles:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:zip_computers:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:zip_continuity:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:zip_cooking:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:zip_crafts:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:zip_culturearts:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:zip_dm_sold:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:zip_donor:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:zip_family:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:zip_gardening:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:zip_giftgivr:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:zip_gourmet:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:zip_health:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:zip_health_diet:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:zip_health_fitness:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:zip_hobbies:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:zip_homedecr:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:zip_homeliv:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:zip_internet:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:zip_internet_access:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:zip_internet_buy:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:zip_music:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:zip_outdoors:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:zip_pets:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:zip_pfin:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:zip_publish:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:zip_publish_books:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:zip_publish_mags:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:zip_sports:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:zip_sports_biking:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:zip_sports_golf:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:zip_travel:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:zip_travel_us:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:zip_tvmovies:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:zip_woman:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:zip_proftech:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:zip_retired:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:zip_inc100:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:zip_inc75:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:zip_inc50:TYPE(UNSIGNED3):DERIVED:0,0
FIELD:tls70:TYPE(STRING1):DERIVED:0,0
FIELD:tls31:TYPE(STRING1):DERIVED:0,0
FIELD:tls_cruise:TYPE(STRING1):DERIVED:0,0
FIELD:tls50:TYPE(STRING1):DERIVED:0,0
FIELD:tls16:TYPE(STRING1):DERIVED:0,0
FIELD:tls39:TYPE(STRING1):DERIVED:0,0
FIELD:tls40:TYPE(STRING1):DERIVED:0,0
FIELD:tls66:TYPE(STRING1):DERIVED:0,0
FIELD:tls17:TYPE(STRING1):DERIVED:0,0
FIELD:tls72:TYPE(STRING1):DERIVED:0,0
FIELD:tls_cabletv_sub:TYPE(STRING1):DERIVED:0,0
FIELD:tls56:TYPE(STRING1):DERIVED:0,0
FIELD:tls46:TYPE(STRING1):DERIVED:0,0
FIELD:tls67:TYPE(STRING1):DERIVED:0,0
FIELD:tls22:TYPE(STRING1):DERIVED:0,0
FIELD:tls25:TYPE(STRING1):DERIVED:0,0
FIELD:tls_volunteer:TYPE(STRING1):DERIVED:0,0
FIELD:tls49:TYPE(STRING1):DERIVED:0,0
FIELD:tls73:TYPE(STRING1):DERIVED:0,0
FIELD:tls27:TYPE(STRING1):DERIVED:0,0
FIELD:tls28:TYPE(STRING1):DERIVED:0,0
FIELD:tls61:TYPE(STRING1):DERIVED:0,0
FIELD:tls24:TYPE(STRING1):DERIVED:0,0
FIELD:tls74:TYPE(STRING1):DERIVED:0,0
FIELD:tls10:TYPE(STRING1):DERIVED:0,0
FIELD:tls26:TYPE(STRING1):DERIVED:0,0
FIELD:tls54:TYPE(STRING1):DERIVED:0,0
FIELD:tls36:TYPE(STRING1):DERIVED:0,0
FIELD:tls62:TYPE(STRING1):DERIVED:0,0
FIELD:tls71:TYPE(STRING1):DERIVED:0,0
FIELD:tls_improve_health:TYPE(STRING1):DERIVED:0,0
FIELD:tls53:TYPE(STRING1):DERIVED:0,0
FIELD:tls23:TYPE(STRING1):DERIVED:0,0
FIELD:tls21:TYPE(STRING1):DERIVED:0,0
FIELD:tls48:TYPE(STRING1):DERIVED:0,0
FIELD:tls63:TYPE(STRING1):DERIVED:0,0
FIELD:tls65:TYPE(STRING1):DERIVED:0,0
FIELD:tls41:TYPE(STRING1):DERIVED:0,0
FIELD:tls32:TYPE(STRING1):DERIVED:0,0
FIELD:tls11:TYPE(STRING1):DERIVED:0,0
FIELD:tls52:TYPE(STRING1):DERIVED:0,0
FIELD:tls51:TYPE(STRING1):DERIVED:0,0
FIELD:tls42:TYPE(STRING1):DERIVED:0,0
FIELD:tls34:TYPE(STRING1):DERIVED:0,0
FIELD:tls38:TYPE(STRING1):DERIVED:0,0
FIELD:tls43:TYPE(STRING1):DERIVED:0,0
FIELD:tls20:TYPE(STRING1):DERIVED:0,0
FIELD:tls35:TYPE(STRING1):DERIVED:0,0
FIELD:tls68:TYPE(STRING1):DERIVED:0,0
FIELD:tls29:TYPE(STRING1):DERIVED:0,0
FIELD:tls69:TYPE(STRING1):DERIVED:0,0
FIELD:tls33:TYPE(STRING1):DERIVED:0,0
FIELD:tls64:TYPE(STRING1):DERIVED:0,0
FIELD:tls18:TYPE(STRING1):DERIVED:0,0
FIELD:tls44:TYPE(STRING1):DERIVED:0,0
FIELD:tls30:TYPE(STRING1):DERIVED:0,0
FIELD:tls13:TYPE(STRING1):DERIVED:0,0
FIELD:tls14:TYPE(STRING1):DERIVED:0,0
FIELD:tls47:TYPE(STRING1):DERIVED:0,0
FIELD:tls57:TYPE(STRING1):DERIVED:0,0
FIELD:tls58:TYPE(STRING1):DERIVED:0,0
FIELD:tls55:TYPE(STRING1):DERIVED:0,0
FIELD:tls59:TYPE(STRING1):DERIVED:0,0
FIELD:tls12:TYPE(STRING1):DERIVED:0,0
FIELD:tls15:TYPE(STRING1):DERIVED:0,0
FIELD:tls60:TYPE(STRING1):DERIVED:0,0
FIELD:tls09:TYPE(STRING1):DERIVED:0,0
FIELD:tls45:TYPE(STRING1):DERIVED:0,0
FIELD:tls37:TYPE(STRING1):DERIVED:0,0
FIELD:ms_oktorent:TYPE(STRING1):DERIVED:0,0
FIELD:ms_oktomail:TYPE(STRING1):DERIVED:0,0
FIELD:deliv_hh:TYPE(STRING1):DERIVED:0,0
FIELD:msflag:TYPE(STRING1):DERIVED:0,0
FIELD:cpiflag:TYPE(STRING1):DERIVED:0,0
FIELD:srceagt:TYPE(STRING1):DERIVED:0,0
FIELD:srcedm:TYPE(STRING1):DERIVED:0,0
FIELD:srcefax:TYPE(STRING1):DERIVED:0,0
FIELD:srceins:TYPE(STRING1):DERIVED:0,0
FIELD:srcenet:TYPE(STRING1):DERIVED:0,0
FIELD:srceret:TYPE(STRING1):DERIVED:0,0
FIELD:srcetm:TYPE(STRING1):DERIVED:0,0
FIELD:srcetv:TYPE(STRING1):DERIVED:0,0
FIELD:ccpurch:TYPE(STRING1):DERIVED:0,0
FIELD:DotID:TYPE(UNSIGNED6):DERIVED:0,0
FIELD:DotScore:TYPE(UNSIGNED2):DERIVED:0,0
FIELD:DotWeight:TYPE(UNSIGNED2):DERIVED:0,0
FIELD:EmpID:TYPE(UNSIGNED6):DERIVED:0,0
FIELD:EmpScore:TYPE(UNSIGNED2):DERIVED:0,0
FIELD:EmpWeight:TYPE(UNSIGNED2):DERIVED:0,0
FIELD:POWID:TYPE(UNSIGNED6):DERIVED:0,0
FIELD:POWScore:TYPE(UNSIGNED2):DERIVED:0,0
FIELD:POWWeight:TYPE(UNSIGNED2):DERIVED:0,0
FIELD:ProxID:TYPE(UNSIGNED6):DERIVED:0,0
FIELD:ProxScore:TYPE(UNSIGNED2):DERIVED:0,0
FIELD:ProxWeight:TYPE(UNSIGNED2):DERIVED:0,0
FIELD:SELEID:TYPE(UNSIGNED6):DERIVED:0,0
FIELD:SELEScore:TYPE(UNSIGNED2):DERIVED:0,0
FIELD:SELEWeight:TYPE(UNSIGNED2):DERIVED:0,0
FIELD:OrgID:TYPE(UNSIGNED6):DERIVED:0,0
FIELD:OrgScore:TYPE(UNSIGNED2):DERIVED:0,0
FIELD:OrgWeight:TYPE(UNSIGNED2):DERIVED:0,0
FIELD:UltID:TYPE(UNSIGNED6):DERIVED:0,0
FIELD:UltScore:TYPE(UNSIGNED2):DERIVED:0,0
FIELD:UltWeight:TYPE(UNSIGNED2):DERIVED:0,0
FIELD:persistent_record_id:TYPE(STRING100):DERIVED:0,0



Total available specificity:0
Search Threshold set at -4
Use of PERSISTs in code set at:3


__Glossary__
Edit Distance: An edit distance of (say) one implies that one string can be converted into another by doing one of
  - Changing one character
  - Deleting one character
  - Transposing two characters

Forcing Criteria: In addition to the general 'best match' logic it is possible to insist that
one particular field must match to some degree or the whole record is considered a bad match.
The criterial applied to that one field is the forcing criteria.

Cascade: Best Type rules are applied in such a way that the rules are applied one by one UNTIL the first rule succeeds; subsequent rules are then skipped.


__General Notes__
How is it decided how much to subtract for a bad match?
SALT computes for each field the percentage likelihood that a valid cluster will have two or more values for a given field
this value (called the switch value in the SALT literature) is then used to produce the subtraction value from the match value.
The value in this document is the one typed into the SPC file; the code will use a value computed at run-time.


