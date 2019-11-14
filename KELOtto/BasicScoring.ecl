﻿
EXPORT BasicScoring := MODULE

  IMPORT KELOtto, FraudGovPlatform_Analytics, FraudGovPlatform, Data_services, Std;

/*
	EXPORT WeightingChart := DATASET('~foreign::10.173.14.201::fraudgov::in::sprayed::configrisklevel', {INTEGER8 EntityType, STRING200 Field, STRING Value, DECIMAL Low, DECIMAL High, INTEGER RiskLevel, INTEGER Weight, STRING UiDescription}, CSV(HEADING(1)));
	EXPORT CustomWeightingChart := DATASET('~foreign::10.173.14.201::fraudgov::in::sprayed::customconfigrisklevel', {STRING customer_id, STRING industry_type, INTEGER8 EntityType, STRING200 Field, STRING Value, DECIMAL Low, DECIMAL High, INTEGER RiskLevel, INTEGER Weight, STRING UiDescription}, CSV(HEADING(1)));
*/

	EXPORT WeightingChart := DATASET('~fraudgov::in::sprayed::configrisklevel', {INTEGER8 EntityType, STRING200 Field, STRING Value, DECIMAL Low, DECIMAL High, INTEGER RiskLevel, INTEGER Weight, STRING UiDescription}, CSV(HEADING(1)));
	EXPORT CustomWeightingChart := DATASET('~fraudgov::in::sprayed::customconfigrisklevel', {STRING customer_id, STRING industry_type, INTEGER8 EntityType, STRING200 Field, STRING Value, DECIMAL Low, DECIMAL High, INTEGER RiskLevel, INTEGER Weight, STRING UiDescription}, CSV(HEADING(1)));

// Add a column to tag that have {value} so the str.findreplace is only done for those rows that need it (for speed in the join).
	EXPORT WeightingChartPrepped := PROJECT(WeightingChart, TRANSFORM({RECORDOF(WeightingChart), BOOLEAN HasValue}, SELF.HasValue := Std.Str.Find(LEFT.UiDescription, '{value}') > 0, SELF := LEFT));
	EXPORT CustomWeightingChartPrepped := PROJECT(CustomWeightingChart, TRANSFORM({RECORDOF(CustomWeightingChart), BOOLEAN HasValue}, SELF.HasValue := Std.Str.Find(LEFT.UiDescription, '{value}') > 0, SELF := LEFT));
	
  EXPORT PersonStatsPrep := FraudGovPlatform_Analytics.macPivotOttoOutput(KELOtto.Q__show_Customer_Person.Res0, 'industry_type_,customer_id_,entity_context_uid_', 
                        'score_,cluster_score_,event_count_,' + 
												'dt_first_seen_,dt_last_seen_,deceased_match_date_of_death_,deceased_match_,date_of_birth_,age_,is_minor_,' +
												'vl_event30_active_flag_,address_is_cmra30_count_,address_is_cmra30_flag_,address_invalid30_count_,address_invalid30_flag_,hri14_active30_flag_,hri50_active30_flag_,validation_addr_problems30_count_,validation_addr_problems30_flag_,address_is_out_of_state30_count_,address_is_of_state30_flag_,' +
												'vl_event7_active_flag_,' +
                        'nas9_flag_,_nas__summary_,_nap__summary_,_subjectssncount_,_ssnfoundforlexid_,subject_ssn_count_,stolen_identity_index_,synthetic_identity_index_,manipulated_identity_index_,vulnerable_victim_index_,friendlyfraud_index_,suspicious_activity_index_,all_high_risk_death_prior_to_all_events_,all_max_deceased_to_event_diff_,death_prior_to_all_events_,deceased_,deceased_event_percent_,high_risk_death_prior_to_all_events_,in_customer_population_,max_deceased_to_event_diff_,no_lex_id_,id_ssn_identity_count_max_,no_lex_id_gt22_,' + 
                        '_cvi_,_v2__sourcerisklevel_,_v2__assocsuspicousidentitiescount_,_v2__assoccreditbureauonlycount_,_v2__inputaddrageoldest_,_v2__inputaddrdwelltype_,_v2__divssnidentitycountnew_,' + 
                        'hri03_flag_,hri06_flag_,hri07_flag_,hri08_flag_,hri11_flag_,hri12_flag_,hri14_flag_,hri15_flag_,hri19_flag_,hri25_flag_,hri26_flag_,hri27_flag_,hri28_flag_,hri29_flag_,hri30_flag_,hri31_flag_,hri37_flag_,hri38_flag_,hri41_flag_,hri48_flag_,hri50_flag_,hri51_flag_,hri52_flag_,hri71_flag_,hri83_flag_,hri90_flag_,hri_cl_flag_,hri_co_flag_,hri_dd_flag_,hri_df_flag_,hri_iv_flag_,hri_it_flag_,hri_mi_flag_,hri_mo_flag_,hri_ms_flag_,hri_nf_flag_,hri_pa_flag_,hri_po_flag_,hri_va_flag_,' +
												'vl_event1_all_count_,vl_event1_count_,vl_event30_all_day_count_,vl_event30_count_,vl_event365_all_day_count_,vl_event365_count_,vl_event7_all_count_,vl_event7_count_,' + 
												'kr_last_event_date_,kr_event_after_last_known_risk_count_,kr_event_after_last_known_risk_flag_,kr_has_known_risk_element_flag_,kr_not_known_risk_has_known_risk_element_flag_,' +
												'kr_high_risk_flag_,kr_medium_risk_flag_,kr_high_risk_routing_,currently_incarcerated_flag_,fraud_offenses_flag_,associated_with_incarcerated_flag_,associated_with_fraud_offenses_flag_,safe_flag_,contributor_safe_flag_,' +
                        'kr_id10000_flag_,kr_id10001_flag_,kr_id10002_flag_,kr_id10003_flag_,kr_id10004_flag_,kr_id10005_flag_,kr_id10006_flag_,kr_id10007_flag_,kr_id11000_flag_,kr_id11001_flag_,kr_id11002_flag_,kr_id11003_flag_,kr_id11004_flag_,kr_id11005_flag_,kr_id11006_flag_,kr_id11007_flag_,kr_id11008_flag_,kr_id11009_flag_,kr_id11010_flag_,kr_id11011_flag_,kr_id11012_flag_,kr_id11013_flag_,kr_id11014_flag_,kr_id11015_flag_,kr_id11016_flag_,kr_id11017_flag_,kr_id11018_flag_,kr_id11019_flag_,kr_id12000_flag_,kr_id12001_flag_,kr_id12002_flag_,kr_id12003_flag_,kr_id12004_flag_,kr_id12006_flag_,kr_id12007_flag_,kr_id13000_flag_,kr_id13001_flag_,kr_id13002_flag_,kr_id13003_flag_,kr_id13005_flag_,kr_id13006_flag_,kr_id13007_flag_,kr_id14000_flag_,kr_id14001_flag_,' +
												'cl_email_count_,cl_high_risk_email_count_,' +
												'cl_kr_not_known_risk_known_risk_element_identity_count_,cl_kr_event_after_known_risk_identity_count_,' +												
												'cl_high_kr_identity_top10_,cl_nas9_top10_,cl_nas3_top10_,cl_ip_high_risk_identity_top10_,' +
                        'cl_adjacent_safe_flag_,cl_bank_identity_count_gt2_count_,cl_ip_high_risk_count_,cl_active30_identity_count_,cl_active7_identity_count_,cl_high_kr_identity_count_,cl_high_risk_routing_count_,cl_no_lex_id_gt22_count_,cl_death_prior_to_all_events_identity_count_,cl_high_risk_death_prior_to_all_events_identity_count_,cl_event_count_,cl_identity_count_,cl_nas9_identity_count_,cl_nap3_identity_count_,cl_address_count_,cl_identity_event_avg_,cl_identity_count_percentile_,cl_event_count_percentile_,cl_impact_weight_,' +
                        'cl_ip_high_risk_identity_count_,cl_ip_not_us_identity_count_,cl_ip_vpn_identity_count_,cl_ip_high_risk_city_identity_count_,cl_ip_hosted_identity_count_,cl_ip_tor_identity_count_,cl_ip_not_us_event_count_,cl_ip_vpn_event_count_,cl_ip_high_risk_city_event_count_,cl_ip_hosted_event_count_,cl_ip_tor_event_count_');

  SHARED AddressStatsPrep := FraudGovPlatform_Analytics.macPivotOttoOutput(KELOtto.Q__show_Customer_Address.Res0, 'industry_type_,customer_id_,entity_context_uid_', 
                        'identity_count_,score_,event_count_,not_in_jurisdiction_state_,invalid_address_,address_is_vacant_,address_is_cmra_,address_is_po_box_,' +
												'dt_first_seen_,dt_last_seen_,' +
                        'all_deceased_match_person_count_,all_deceased_match_person_percent_,all_deceased_person_count_,all_deceased_person_percent_,all_high_frequency_flag_,all_high_risk_death_prior_to_all_events_person_count_,all_high_risk_death_prior_to_all_events_person_percent_,all_high_risk_death_prior_to_all_events_person_percent_flag_,all_person_count_,cluster_score_,deceased_match_person_percent_,deceased_person_count_,deceased_person_percent_,high_frequency_flag_,in_customer_population_,kr_high_risk_flag_,kr_medium_risk_flag_,source_customer_count_,_addresscmra_,' + 
												'vl_event1_all_count_,vl_event1_count_,vl_event30_all_day_count_,vl_event30_count_,vl_event365_all_day_count_,vl_event365_count_,vl_event7_all_count_,vl_event7_count_,' + 
												'kr_event_after_last_known_risk_count_,kr_event_after_last_known_risk_flag_,' +
												'kr_addr300_flag_,kr_addr301_flag_,kr_addr302_flag_,kr_addr303_flag_,' +
												'cl_kr_not_known_risk_known_risk_element_identity_count_,cl_kr_event_after_known_risk_identity_count_,' +
												'cl_high_kr_identity_top10_,cl_nas9_top10_,cl_nas3_top10_,cl_ip_high_risk_identity_top10_,' +
												'cl_adjacent_safe_flag_,cl_bank_identity_count_gt2_count_,cl_ip_high_risk_count_,cl_active30_identity_count_,cl_active7_identity_count_,cl_high_kr_identity_count_,cl_high_risk_routing_count_,cl_no_lex_id_gt22_count_,cl_death_prior_to_all_events_identity_count_,cl_high_risk_death_prior_to_all_events_identity_count_,cl_event_count_,cl_identity_count_,cl_nas9_identity_count_,cl_nap3_identity_count_,cl_address_count_,cl_identity_event_avg_,cl_identity_count_percentile_,cl_event_count_percentile_,cl_impact_weight_,' +
                        'cl_ip_high_risk_identity_count_,cl_ip_not_us_identity_count_,cl_ip_vpn_identity_count_,cl_ip_high_risk_city_identity_count_,cl_ip_hosted_identity_count_,cl_ip_tor_identity_count_,cl_ip_not_us_event_count_,cl_ip_vpn_event_count_,cl_ip_high_risk_city_event_count_,cl_ip_hosted_event_count_,cl_ip_tor_event_count_'
                        );// : PERSIST('~temp::deleteme42');
  
  EXPORT SocialSecurityStatsPrep := FraudGovPlatform_Analytics.macPivotOttoOutput(KELOtto.Q__show_Customer_Social_Security_Number.Res0, 'industry_type_,customer_id_,entity_context_uid_', 
                        'cluster_score_,event_count_,identity_count_,score_,source_customer_count_,identity_count_gt2_,' + 
												'dt_first_seen_,dt_last_seen_,' +
	                      'hri06_flag_,hri26_flag_,hri29_flag_,hri38_flag_,hri71_flag_,hri_it_flag_,hri_mi_flag_,kr_high_risk_flag_,kr_medium_risk_flag_,' + 
												'vl_event1_all_count_,vl_event1_count_,vl_event30_all_day_count_,vl_event30_count_,vl_event365_all_day_count_,vl_event365_count_,vl_event7_all_count_,vl_event7_count_,' + 
												'kr_last_event_date_,kr_event_after_last_known_risk_count_,kr_event_after_last_known_risk_flag_,' +
                        'kr_ssn100_flag_,kr_ssn101_flag_,' +
												'safe_flag_,contributor_safe_flag_,' +
  											'cl_kr_not_known_risk_known_risk_element_identity_count_,cl_kr_event_after_known_risk_identity_count_,' +
												'cl_high_kr_identity_top10_,cl_nas9_top10_,cl_nas3_top10_,cl_ip_high_risk_identity_top10_,' +
												'cl_adjacent_safe_flag_,cl_bank_identity_count_gt2_count_,cl_ip_high_risk_count_,cl_active30_identity_count_,cl_active7_identity_count_,cl_high_kr_identity_count_,cl_high_risk_routing_count_,cl_no_lex_id_gt22_count_,cl_death_prior_to_all_events_identity_count_,cl_high_risk_death_prior_to_all_events_identity_count_,cl_event_count_,cl_identity_count_,cl_nas9_identity_count_,cl_nap3_identity_count_,cl_address_count_,cl_identity_event_avg_,cl_identity_count_percentile_,cl_event_count_percentile_,cl_impact_weight_,' +
                        'cl_ip_high_risk_identity_count_,cl_ip_not_us_identity_count_,cl_ip_vpn_identity_count_,cl_ip_high_risk_city_identity_count_,cl_ip_hosted_identity_count_,cl_ip_tor_identity_count_,cl_ip_not_us_event_count_,cl_ip_vpn_event_count_,cl_ip_high_risk_city_event_count_,cl_ip_hosted_event_count_,cl_ip_tor_event_count_'
												);// : PERSIST('~temp::deleteme47');

  EXPORT EmailStatsPrep := FraudGovPlatform_Analytics.macPivotOttoOutput(KELOtto.Q__show_Customer_Email.Res0, 'industry_type_,customer_id_,entity_context_uid_',
                        'cluster_score_,event_count_,identity_count_,identity_count_gt2_,score_,source_customer_count_,kr_high_risk_flag_,_isdisposableemail_,not_safe_last_domain_gt2_,kr_medium_risk_flag_,' + 
												'dt_first_seen_,dt_last_seen_,' +
												'vl_event1_all_count_,vl_event1_count_,vl_event30_all_day_count_,vl_event30_count_,vl_event365_all_day_count_,vl_event365_count_,vl_event7_all_count_,vl_event7_count_,' + 
												'kr_last_event_date_,kr_event_after_last_known_risk_count_,kr_event_after_last_known_risk_flag_,' +
                        'kr_eml500_flag_,kr_eml501_flag_,kr_eml502_flag_,kr_eml590_flag_,kr_eml591_flag_,kr_eml592_flag_,kr_eml593_flag_,' +
												'safe_flag_,contributor_safe_flag_,' +
												'cl_kr_not_known_risk_known_risk_element_identity_count_,cl_kr_event_after_known_risk_identity_count_,' +
												'cl_high_kr_identity_top10_,cl_nas9_top10_,cl_nas3_top10_,cl_ip_high_risk_identity_top10_,' +
                        'cl_adjacent_safe_flag_,cl_bank_identity_count_gt2_count_,cl_ip_high_risk_count_,cl_active30_identity_count_,cl_active7_identity_count_,cl_high_kr_identity_count_,cl_high_risk_routing_count_,cl_no_lex_id_gt22_count_,cl_death_prior_to_all_events_identity_count_,cl_high_risk_death_prior_to_all_events_identity_count_,cl_event_count_,cl_identity_count_,cl_nas9_identity_count_,cl_nap3_identity_count_,cl_address_count_,cl_identity_event_avg_,cl_identity_count_percentile_,cl_event_count_percentile_,cl_impact_weight_,' +
                        'cl_ip_high_risk_identity_count_,cl_ip_not_us_identity_count_,cl_ip_vpn_identity_count_,cl_ip_high_risk_city_identity_count_,cl_ip_hosted_identity_count_,cl_ip_tor_identity_count_,cl_ip_not_us_event_count_,cl_ip_vpn_event_count_,cl_ip_high_risk_city_event_count_,cl_ip_hosted_event_count_,cl_ip_tor_event_count_'
												);// : PERSIST('~temp::deleteme44');
  
  EXPORT PhoneStatsPrep := FraudGovPlatform_Analytics.macPivotOttoOutput(KELOtto.Q__show_Customer_Phone.Res0, 'industry_type_,customer_id_,entity_context_uid_', 
                        'phone_number_,_is_cell_phone_,cluster_score_,event_count_,identity_count_,identity_count_gt2_,score_,source_customer_count_,' + 
												'dt_first_seen_,dt_last_seen_,' +
                        'hri07_flag_,hri08_flag_,hri15_flag_,hri27_flag_,hri31_flag_,kr_high_risk_flag_,kr_medium_risk_flag_,'+ 
												'vl_event1_all_count_,vl_event1_count_,vl_event30_all_day_count_,vl_event30_count_,vl_event365_all_day_count_,vl_event365_count_,vl_event7_all_count_,vl_event7_count_,' + 
												'safe_flag_,contributor_safe_flag_,' +
												'kr_last_event_date_,kr_event_after_last_known_risk_count_,kr_event_after_last_known_risk_flag_,' +
                        'kr_phn400_flag_,kr_phn401_flag_,kr_phn402_flag_,' +
												'cl_kr_not_known_risk_known_risk_element_identity_count_,cl_kr_event_after_known_risk_identity_count_,' +
												'cl_high_kr_identity_top10_,cl_nas9_top10_,cl_nas3_top10_,cl_ip_high_risk_identity_top10_,' +
                        'cl_adjacent_safe_flag_,cl_bank_identity_count_gt2_count_,cl_ip_high_risk_count_,cl_active30_identity_count_,cl_active7_identity_count_,cl_high_kr_identity_count_,cl_high_risk_routing_count_,cl_no_lex_id_gt22_count_,cl_death_prior_to_all_events_identity_count_,cl_high_risk_death_prior_to_all_events_identity_count_,cl_event_count_,cl_identity_count_,cl_nas9_identity_count_,cl_nap3_identity_count_,cl_address_count_,cl_identity_event_avg_,cl_identity_count_percentile_,cl_event_count_percentile_,cl_impact_weight_,' +
                        'cl_ip_high_risk_identity_count_,cl_ip_not_us_identity_count_,cl_ip_vpn_identity_count_,cl_ip_high_risk_city_identity_count_,cl_ip_hosted_identity_count_,cl_ip_tor_identity_count_,cl_ip_not_us_event_count_,cl_ip_vpn_event_count_,cl_ip_high_risk_city_event_count_,cl_ip_hosted_event_count_,cl_ip_tor_event_count_'
                        );// : PERSIST('~temp::deleteme45');

  EXPORT IPAddressStatsPrep := FraudGovPlatform_Analytics.macPivotOttoOutput(KELOtto.Q__show_Customer_Internet_Protocol.Res0, 'industry_type_,customer_id_,entity_context_uid_', 
                        'score_,cluster_score_,event_count_,identity_count_,source_customer_count_,kr_high_risk_flag_,kr_medium_risk_flag_,' +
												'dt_first_seen_,dt_last_seen_,' +
												'vl_event1_all_count_,vl_event1_count_,vl_event30_all_day_count_,vl_event30_count_,vl_event365_all_day_count_,vl_event365_count_,vl_event7_all_count_,vl_event7_count_,' + 
												'safe_flag_,contributor_safe_flag_,' +
                        'ip_not_us_,ip_vpn_,ip_high_risk_city_,ip_hosted_,ip_tor_,' +
												'_iprngbeg_,_iprngend_,_edgecountry_,_edgeregion_,_edgecity_,_edgeconnspeed_,_edgemetrocode_,_edgelatitude_,_edgelongitude_,_edgepostalcode_,_edgecountrycode_,_edgeregioncode_,_edgecitycode_,_edgecontinentcode_,_edgetwolettercountry_,_edgeinternalcode_,_edgeareacodes_,_edgecountryconf_,_edgeregionconf_,_edgecitycong_,_edgepostalconf_,_edgegmtoffset_,_edgeindst_,_siccode_,_domainname_,_ispname_,_homebiztype_,_asn_,_asnname_,_primarylang_,_secondarylang_,_proxytype_,_proxydescription_,_isanisp_,_companyname_,_organizationname_,' +
												'kr_last_event_date_,kr_event_after_last_known_risk_count_,kr_event_after_last_known_risk_flag_,' +
                        'kr_ip600_flag_,kr_ip601_flag_,kr_ip602_flag_,kr_ip603_flag_,kr_ip604_flag_,kr_ip605_flag_,kr_ip1000_flag_,kr_ip1001_flag_,' +
												'cl_kr_not_known_risk_known_risk_element_identity_count_,cl_kr_event_after_known_risk_identity_count_,' +
												'cl_high_kr_identity_top10_,cl_nas9_top10_,cl_nas3_top10_,cl_ip_high_risk_identity_top10_,' +
                        'cl_adjacent_safe_flag_,cl_bank_identity_count_gt2_count_,cl_ip_high_risk_count_,cl_active30_identity_count_,cl_active7_identity_count_,cl_high_kr_identity_count_,cl_high_risk_routing_count_,cl_no_lex_id_gt22_count_,cl_death_prior_to_all_events_identity_count_,cl_high_risk_death_prior_to_all_events_identity_count_,cl_event_count_,cl_identity_count_,cl_nas9_identity_count_,cl_nap3_identity_count_,cl_address_count_,cl_identity_event_avg_,cl_identity_count_percentile_,cl_event_count_percentile_,cl_impact_weight_,' +
                        'cl_ip_high_risk_identity_count_,cl_ip_not_us_identity_count_,cl_ip_vpn_identity_count_,cl_ip_high_risk_city_identity_count_,cl_ip_hosted_identity_count_,cl_ip_tor_identity_count_,cl_ip_not_us_event_count_,cl_ip_vpn_event_count_,cl_ip_high_risk_city_event_count_,cl_ip_hosted_event_count_,cl_ip_tor_event_count_'
												);// : PERSIST('~temp::deleteme48');


  EXPORT BankAccountStatsPrep := FraudGovPlatform_Analytics.macPivotOttoOutput(KELOtto.Q__show_Customer_Bank_Account.Res0, 'industry_type_,customer_id_,entity_context_uid_',
                        'cluster_score_,event_count_,identity_count_,identity_count_gt2_,score_,source_customer_count_,kr_high_risk_flag_,kr_medium_risk_flag_,' + 
												'dt_first_seen_,dt_last_seen_,' +
												'vl_event1_all_count_,vl_event1_count_,vl_event30_all_day_count_,vl_event30_count_,vl_event365_all_day_count_,vl_event365_count_,vl_event7_all_count_,vl_event7_count_,' + 
												'high_risk_routing_,abbreviated_bankname_,' +
												'kr_last_event_date_,kr_event_after_last_known_risk_count_,kr_event_after_last_known_risk_flag_,' +
                        'kr_bnk800_flag_,kr_bnk801_flag_,kr_bnk802_flag_,kr_bnk890_flag_,kr_bnk891_flag_,kr_bnk892_flag_,kr_bnk893_flag_,safe_flag_,contributor_safe_flag_,' +
												'cl_kr_not_known_risk_known_risk_element_identity_count_,cl_kr_event_after_known_risk_identity_count_,' +
												'cl_high_kr_identity_top10_,cl_nas9_top10_,cl_nas3_top10_,cl_ip_high_risk_identity_top10_,' +
                        'cl_adjacent_safe_flag_,cl_bank_identity_count_gt2_count_,cl_ip_high_risk_count_,cl_active30_identity_count_,cl_active7_identity_count_,cl_high_kr_identity_count_,cl_high_risk_routing_count_,cl_no_lex_id_gt22_count_,cl_death_prior_to_all_events_identity_count_,cl_high_risk_death_prior_to_all_events_identity_count_,cl_event_count_,cl_identity_count_,cl_nas9_identity_count_,cl_nap3_identity_count_,cl_address_count_,cl_identity_event_avg_,cl_identity_count_percentile_,cl_event_count_percentile_,cl_impact_weight_,' +
                        'cl_ip_high_risk_identity_count_,cl_ip_not_us_identity_count_,cl_ip_vpn_identity_count_,cl_ip_high_risk_city_identity_count_,cl_ip_hosted_identity_count_,cl_ip_tor_identity_count_,cl_ip_not_us_event_count_,cl_ip_vpn_event_count_,cl_ip_high_risk_city_event_count_,cl_ip_hosted_event_count_,cl_ip_tor_event_count_'												
												);// : PERSIST('~temp::deleteme50');

  EXPORT DriversLicenseStatsPrep := FraudGovPlatform_Analytics.macPivotOttoOutput(KELOtto.Q__show_Customer_Drivers_License.Res0, 'industry_type_,customer_id_,entity_context_uid_',
                        'cluster_score_,event_count_,identity_count_,identity_count_gt2_,score_,source_customer_count_,kr_high_risk_flag_,kr_medium_risk_flag_,' + 
												'dt_first_seen_,dt_last_seen_,' +
												'vl_event1_all_count_,vl_event1_count_,vl_event30_all_day_count_,vl_event30_count_,vl_event365_all_day_count_,vl_event365_count_,vl_event7_all_count_,vl_event7_count_,' + 
                        'hri41_flag_,hri_df_flag_,' + 
												'kr_last_event_date_,kr_event_after_last_known_risk_count_,kr_event_after_last_known_risk_flag_,' +
                        'kr_dl200_flag_,kr_dl201_flag_,kr_dl202_flag_,kr_dl203_flag_,kr_dl204_flag_,kr_dl290_flag_,kr_dl291_flag_,kr_dl292_flag_,kr_dl293_flag_,safe_flag_,contributor_safe_flag_,' +
												'cl_kr_not_known_risk_known_risk_element_identity_count_,cl_kr_event_after_known_risk_identity_count_,' +
												'cl_high_kr_identity_top10_,cl_nas9_top10_,cl_nas3_top10_,cl_ip_high_risk_identity_top10_,' +
                        'cl_adjacent_safe_flag_,cl_bank_identity_count_gt2_count_,cl_ip_high_risk_count_,cl_active30_identity_count_,cl_active7_identity_count_,cl_high_kr_identity_count_,cl_high_risk_routing_count_,cl_no_lex_id_gt22_count_,cl_death_prior_to_all_events_identity_count_,cl_high_risk_death_prior_to_all_events_identity_count_,cl_event_count_,cl_identity_count_,cl_nas9_identity_count_,cl_nap3_identity_count_,cl_address_count_,cl_identity_event_avg_,cl_identity_count_percentile_,cl_event_count_percentile_,cl_impact_weight_,' +
                        'cl_ip_high_risk_identity_count_,cl_ip_not_us_identity_count_,cl_ip_vpn_identity_count_,cl_ip_high_risk_city_identity_count_,cl_ip_hosted_identity_count_,cl_ip_tor_identity_count_,cl_ip_not_us_event_count_,cl_ip_vpn_event_count_,cl_ip_high_risk_city_event_count_,cl_ip_hosted_event_count_,cl_ip_tor_event_count_'
												);// : PERSIST('~temp::deleteme51');
                        
  EXPORT EventStatsPrep := FraudGovPlatform_Analytics.macPivotOttoOutput(KELOtto.Q__show_Customer_Person_Event.Res0, 'industry_type_,customer_id_,entity_context_uid_', 
                        '_nas__summary_,_nap__summary_,_cvi_,_ssnfoundforlexid_,_cvicustomscore_,_subjectssncount_,' + 
                      //  'stolen_identity_index_,synthetic_identity_index_,manipulated_identity_index_,vulnerable_victim_index_,friendlyfraud_index_,suspicious_activity_index_,' + 
                      //  '_v2__sourcerisklevel_,_v2__assocsuspicousidentitiescount_,_v2__assoccreditbureauonlycount_,_v2__validationaddrproblems_,_v2__inputaddrageoldest_,_v2__inputaddrdwelltype_,_v2__divssnidentitycountnew_,' + 
                        'kr_high_risk_address_flag_,kr_high_risk_identity_flag_,kr_medium_risk_address_flag_,kr_medium_risk_identity_flag_,' +
                        /*'deceased_,*/'deceased_prior_to_event_,' + 
                        'hri03_flag_,hri19_flag_,hri28_flag_,hri37_flag_,hri41_flag_,hri48_flag_,hri51_flag_,hri52_flag_,hri83_flag_,hri90_flag_,' + 
                        'hri_cl_flag_,hri_dd_flag_,hri_df_flag_,hri_ms_flag_,hri_nf_flag_,' + 
                        'addr_hri11_flag_,addr_hri12_flag_,addr_hri14_flag_,addr_hri25_flag_,addr_hri30_flag_,addr_hri50_flag_,addr_hri_co_flag_,addr_hri_mo_flag_,addr_hri_pa_flag_,addr_hri_po_flag_,addr_hri_va_flag_,' + 
                        'ph_hri07_flag_,ph_hri08_flag_,ph_hri15_flag_,ph_hri27_flag_,ph_hri31_flag_,' + 
                        'ssn_hri06_flag_,ssn_hri26_flag_,ssn_hri29_flag_,ssn_hri38_flag_,ssn_hri71_flag_,ssn_hri_it_flag_,ssn_hri_mi_flag_,safe_flag_,contributor_safe_flag_'     
												);// : PERSIST('~temp::deleteme49');
                           
  // Original Entity Stats
  EXPORT EntityStatsPrep1 := PersonStatsPrep + AddressStatsPrep + SocialSecurityStatsPrep + PhoneStatsPrep +
                             IPAddressStatsPrep + EmailStatsPrep + DriversLicenseStatsPrep + BankAccountStatsPrep;// EventStatsPrep 
                             
  // Correct unk classifications to be based on the entity type.
  EXPORT FullEntityStatsPrep := PROJECT(DISTRIBUTE(EntityStatsPrep1), TRANSFORM({INTEGER1 EntityType, RECORDOF(LEFT)}, 
	                   SELF.EntityType := (INTEGER1)LEFT.entity_context_uid_[2..3],
  	                 SELF.indicatordescription := MAP(LEFT.indicatordescription != 'unk' => LEFT.indicatordescription, 
                                                   MAP(LEFT.entity_context_uid_[2..3] = '01' => 'Identity',
                                                   MAP(LEFT.entity_context_uid_[2..3] = '15' => 'SSN',
                                                   MAP(LEFT.entity_context_uid_[2..3] = '16' => 'Phone',
                                                   MAP(LEFT.entity_context_uid_[2..3] = '17' => 'Email',
                                                   MAP(LEFT.entity_context_uid_[2..3] = '09' => 'Address',
                                                   MAP(LEFT.entity_context_uid_[2..3] = '18' => 'IP',
                                                   MAP(LEFT.entity_context_uid_[2..3] = '19' => 'Bank Account',
                                                   MAP(LEFT.entity_context_uid_[2..3] = '20' => 'Drivers Licence',
                                                   MAP(LEFT.entity_context_uid_[2..3] = '11' => 'Identity','unk')))))))))),
                    
                    SELF.indicatortype :=        MAP(LEFT.indicatortype != 'unk' => LEFT.indicatortype, 
                                                   MAP(LEFT.entity_context_uid_[2..3] = '01' => 'ID',
                                                   MAP(LEFT.entity_context_uid_[2..3] = '15' => 'SSN',
                                                   MAP(LEFT.entity_context_uid_[2..3] = '16' => 'PH',
                                                   MAP(LEFT.entity_context_uid_[2..3] = '17' => 'EML',
                                                   MAP(LEFT.entity_context_uid_[2..3] = '09' => 'ADDR',
                                                   MAP(LEFT.entity_context_uid_[2..3] = '18' => 'IP',
                                                   MAP(LEFT.entity_context_uid_[2..3] = '19' => 'BNK',
                                                   MAP(LEFT.entity_context_uid_[2..3] = '20' => 'DL',
                                                   MAP(LEFT.entity_context_uid_[2..3] = '11' => 'ID','unk')))))))))),
										SELF := LEFT));
										
  // This is the list of attributes per entity type, indicatortype
  EXPORT FullIndicatorListPrep := TABLE(FullEntityStatsPrep, {customer_id_, industry_type_, entitytype, indicatordescription, Field, ElementCount := COUNT(GROUP) }, customer_id_, industry_type_, entitytype, indicatordescription, Field, MERGE);
	EXPORT FullIndicatorList := JOIN(FullIndicatorListPrep, WeightingChart, 
												 LEFT.Field=RIGHT.Field AND (INTEGER)LEFT.EntityType = RIGHT.EntityType,
												 TRANSFORM({RECORDOF(LEFT), INTEGER1 IsConfigured}, SELF.IsConfigured := MAP(RIGHT.field != '' => 1, 0), SELF := LEFT, SELF := RIGHT), LEFT OUTER, KEEP(1)); 
	
  // This is the final result for entity stats after w
  EXPORT WeightedResultDefault := JOIN(FullEntityStatsPrep(Value != ''), WeightingChartPrepped, 
                         LEFT.Field=RIGHT.Field AND (INTEGER)LEFT.entity_context_uid_[2..3] = RIGHT.EntityType AND
                         (
                           (
                             RIGHT.Value NOT IN ['','0'] AND LEFT.Value = RIGHT.Value
                           )
                           OR
                           (
                             RIGHT.Value IN ['','0'] AND (RIGHT.Low = 0 AND RIGHT.High = 0)
                           )                           
                           OR
                           (
                             (RIGHT.Low > 0 OR RIGHT.High > 0) AND 
                               (
                                 (RIGHT.Low > 0 AND (DECIMAL10_3)LEFT.Value >= RIGHT.Low OR RIGHT.Low = 0) AND
                                 (RIGHT.High > 0 AND (DECIMAL10_3)LEFT.Value <= RIGHT.High OR RIGHT.High = 0) 
                               )
                           )
                         ), TRANSFORM({RECORDOF(LEFT), RIGHT.Weight}, 
                            SELF.Weight := MAP(RIGHT.Field != '' => RIGHT.Weight, 0),
                            SELF.RiskLevel := MAP(RIGHT.Field != '' => RIGHT.RiskLevel, -1), // If there is no specific configuration for a field assign the risk level to -1 so it can be hidden.
                            SELF.Label := MAP(TRIM(RIGHT.UiDescription) != '' => 
														               MAP(RIGHT.HasValue => Std.Str.FindReplace(RIGHT.UiDescription, '{value}', LEFT.Value), RIGHT.UiDescription), 
																					 LEFT.Label);
                            SELF.field := LEFT.field;
														/* commenting this out because if we switch the field value it will MESS UP the custom weighting join.							
                            SELF.field := LEFT.field +
                                          MAP(TRIM(RIGHT.Value) != '' =>  '_' + RIGHT.Value, MAP(RIGHT.Low > 0 => '_' + (STRING)RIGHT.Low, '') + MAP(RIGHT.High > 0 => '_' + (STRING)RIGHT.High, ''));
                            */
                            SELF := LEFT), LOOKUP, LEFT OUTER);
														
  EXPORT WeightedResult := JOIN(WeightedResultDefault(Value != ''), CustomWeightingChartPrepped, 
	                       (UNSIGNED)LEFT.customer_id_ = (UNSIGNED)RIGHT.customer_id AND (UNSIGNED)LEFT.industry_type_= (UNSIGNED)RIGHT.industry_type AND
                         LEFT.Field=RIGHT.Field AND (INTEGER)LEFT.entity_context_uid_[2..3] = (INTEGER)RIGHT.EntityType AND
                         (
                           (
                             RIGHT.Value NOT IN ['','0'] AND LEFT.Value = RIGHT.Value
                           )
                           OR
                           (
                             RIGHT.Value IN ['','0'] AND (RIGHT.Low = 0 AND RIGHT.High = 0)
                           )                           
                           OR
                           (
                             (RIGHT.Low > 0 OR RIGHT.High > 0) AND 
                               (
                                 (RIGHT.Low > 0 AND (DECIMAL10_3)LEFT.Value >= RIGHT.Low OR RIGHT.Low = 0) AND
                                 (RIGHT.High > 0 AND (DECIMAL10_3)LEFT.Value <= RIGHT.High OR RIGHT.High = 0) 
                               )
                           )
                         ), TRANSFORM(RECORDOF(LEFT),
                            SELF.Weight := MAP(RIGHT.Field != '' => RIGHT.Weight, LEFT.Weight),
                            SELF.RiskLevel := MAP(RIGHT.Field != '' => RIGHT.RiskLevel, LEFT.RiskLevel), // If there is no specific configuration for a field assign the risk level to -1 so it can be hidden.
                            SELF.Label := MAP(TRIM(RIGHT.UiDescription) != '' => 
														               MAP(RIGHT.HasValue => Std.Str.FindReplace(RIGHT.UiDescription, '{value}', LEFT.Value), RIGHT.UiDescription), 
																					 LEFT.Label);
                            SELF.field := LEFT.field,
														/*
														              LEFT.field +
                                          MAP(TRIM(RIGHT.Value) != '' =>  '_' + RIGHT.Value, MAP(RIGHT.Low > 0 => '_' + (STRING)RIGHT.Low, '') + MAP(RIGHT.High > 0 => '_' + (STRING)RIGHT.High, ''));
                            */
                            SELF := LEFT), LOOKUP, LEFT OUTER);// : PERSIST('~temp::deleteme92', EXPIRE(7));
														
                         
  EXPORT ScoreBreakdownAggregate := TABLE(WeightedResult(customer_id_>0), 
                        {customer_id_, industry_type_, entity_context_uid_, INTEGER entity_type_ := (INTEGER)entity_context_uid_[2..3], indicatortype, indicatordescription, 
                         INTEGER RiskLevel := 0 /* percentile */, populationtype := 'Element', 
                         INTEGER Value := SUM(GROUP, Weight), ValueCurved := (SUM(GROUP, Weight) * 1000000) + HASH(entity_context_uid_) % 1000000}, customer_id_, industry_type_, entity_context_uid_, entity_context_uid_[2..3], indicatortype, indicatordescription, MERGE);
                         

  EXPORT ScoreBreakdown := 
          PROJECT(
            KELOtto.Functions.CalculatePercentile(ScoreBreakdownAggregate, 'customer_id_, industry_type_, indicatortype, entity_type_, indicatordescription', ValueCurved, 'CustomerPercentile', 'CustomerQuartileRank'), 
            TRANSFORM(RECORDOF(LEFT) AND NOT [hashid], 
            self.RiskLevel := LEFT.CustomerPercentile, // Only set the RiskLevel 
            SELF := LEFT));// : PERSIST('~temp::deleteme43', EXPIRE(7));



  EXPORT CustomerScoreBreakdownAverages := TABLE(ScoreBreakdownAggregate, 
                        {customer_id_, industry_type_, indicatortype, entity_type_, indicatordescription, 
                         INTEGER RiskLevel := 0 /* percentile */, STRING populationtype := 'Average', 
                         INTEGER Value := AVE(GROUP, Value)}, customer_id_, industry_type_, indicatortype, entity_type_, indicatordescription, MERGE);


  SHARED TempAverages := JOIN(ScoreBreakdown, CustomerScoreBreakdownAverages,                         
	                         LEFT.customer_id_=RIGHT.customer_id_ AND LEFT.industry_type_=RIGHT.industry_type_ AND
													 (INTEGER)LEFT.entity_context_uid_[2..3]=RIGHT.entity_type_ AND
													 LEFT.indicatortype = RIGHT.indicatortype,
													 TRANSFORM(RECORDOF(LEFT), 
													   SELF.RiskLevel := Right.RiskLevel, SELF.populationtype := RIGHT.populationtype, SELf.Value := RIGHT.Value, SELF := LEFT),
													 LEFT OUTER, LOOKUP);
													   
  EXPORT FullScoredBreakdown := TempAverages + ScoreBreakdown;//: PERSIST('~temp::deleteme62');

  // The cluster score is the percentile of the "cluster" indicator type..
  
  // This is the entity score (including cluster) it is the aggregate of the score breakdown percentiles.
  // Primarily to support weighting the categories so it can be configured later at a customer level.
  
    
  SHARED ScoresPrep1 := TABLE(ScoreBreakdown,
               {customer_id_, industry_type_, entity_context_uid_, 
                Score := SUM(GROUP, CustomerPercentile * 
								                       MAP(indicatortype='KR' => 8, MAP(indicatortype='VL' => 0.5, MAP(indicatortype='CL' => 0.5, 0.5)))
								                     ), 
                CurveScore := SUM(GROUP, CustomerPercentile * 
								                       MAP(indicatortype='KR' => 8, MAP(indicatortype='VL' => 0.5, MAP(indicatortype='CL' => 0.5, 0.5)))
								                     ) + HASH32(entity_context_uid_) % 1000000,
                TotalWeightValue := SUM(GROUP, Value) // This is the raw value, if none of the indicators have values and this is 0 then we should 0 the score.                
               }, customer_id_, industry_type_, entity_context_uid_, MERGE);
               
  EXPORT Scores := DISTRIBUTE(KELOtto.Functions.CalculatePercentile(ScoresPrep1, 'customer_id_, industry_type_', CurveScore, 'ScorePercentile', 'ScoreQuartileRank'), HASH32(entity_context_uid_));
  
  EXPORT EntityStats := JOIN(WeightedResult(RiskLevel in [0,1,2,3] AND Value != '0'), Scores, LEFT.customer_id_=RIGHT.customer_id_ AND LEFT.industry_type_=RIGHT.industry_type_ AND LEFT.entity_context_uid_=RIGHT.entity_context_uid_ AND LEFT.Field = 'score_',
                        TRANSFORM(RECORDOF(LEFT), SELF.Value := MAP(RIGHT.entity_context_uid_ != '' => (STRING)RIGHT.ScorePercentile, (STRING)LEFT.Value), SELF := LEFT), LEFT OUTER, HASH);

  // Fill in the actual scores on all the entities in the graph
  
  EXPORT ScoredGraphPrep1 := JOIN(DISTRIBUTE(KELOtto.FullGraph, HASH32(entity_context_uid_)), Scores,
                        LEFT.customer_id_=RIGHT.customer_id_ AND LEFT.industry_type_=RIGHT.industry_type_ AND LEFT.entity_context_uid_=RIGHT.entity_context_uid_,
                        TRANSFORM(RECORDOF(LEFT), SELF.Score_ := MAP(RIGHT.entity_context_uid_ != '' AND RIGHT.TotalWeightValue > 0 => RIGHT.ScorePercentile, 0), SELF := LEFT), LEFT OUTER, LOCAL);
       
  EXPORT ScoredGraphPrep2 := JOIN(ScoredGraphPrep1, DISTRIBUTE(ScoreBreakdown, HASH32(entity_context_uid_)),
                        LEFT.customer_id_=RIGHT.customer_id_ AND LEFT.industry_type_=RIGHT.industry_type_ AND LEFT.entity_context_uid_=RIGHT.entity_context_uid_ AND
                        RIGHT.indicatortype = 'CL', 
                        TRANSFORM(RECORDOF(LEFT), SELF.Cluster_Score_ := MAP(RIGHT.entity_context_uid_ != '' AND RIGHT.Value > 0 => RIGHT.CustomerPercentile, 0), SELF := LEFT), LEFT OUTER, LOCAL);

  HighRiskIdentityAggregation := DISTRIBUTE(TABLE(ScoredGraphPrep2, {source_customer_, UNSIGNED cl_hr_identity_count_ := COUNT(GROUP, entity_type_ = 1 AND score_ > 80), UNSIGNED cl_hr_element_count_ := COUNT(GROUP, entity_type_ != 1 AND score_ > 80), tree_uid_}, source_customer_, tree_uid_, MERGE), HASH32(tree_uid_)); 

  EXPORT ScoredGraphPrep3 := JOIN(ScoredGraphPrep2, HighRiskIdentityAggregation, LEFT.source_customer_ = RIGHT.source_customer_ AND LEFT.entity_context_uid_ = RIGHT.tree_uid_, TRANSFORM({RECORDOF(LEFT), UNSIGNED cl_hr_identity_count_, UNSIGNED cl_hr_element_count_}, 
                            SELF.cl_hr_identity_count_ := RIGHT.cl_hr_identity_count_, SELF.cl_hr_element_count_ := RIGHT.cl_hr_element_count_, SELF := LEFT), LEFT OUTER, LOCAL);

  // Flag/Indicator Child dataset.

  FlagsRec := RECORD
    STRING Indicator;
    STRING Value;
  END;

  FinalRec := RECORD
   RECORDOF(ScoredGraphPrep3);// AND NOT [event_count_,identity_count_]; // field exclusion list to keep the layout consistent with previous version for roxie/esp
   DATASET(FlagsRec) Flags;
  END;
       
  EXPORT ScoredGraph := PROJECT(ScoredGraphPrep3, 
                    TRANSFORM(FinalRec, 
										           SELF.Flags := DATASET([
															                        {'high_frequency_flag_', (STRING)LEFT.high_frequency_flag_},
																											{'score_', (STRING)LEFT.Score_},
																											{'cluster_score_', (STRING)LEFT.Cluster_Score_},
																											{'all_high_risk_death_prior_to_all_events_person_percent_flag_', (STRING)LEFT.all_high_risk_death_prior_to_all_events_person_percent_flag_},
																											{'cl_event_count_', (STRING)LEFT.cl_event_count_},
																											{'cl_identity_count_', (STRING)LEFT.cl_identity_count_},
																											{'cl_identity_count_percentile_', (STRING)LEFT.cl_identity_count_percentile_},
																											{'cl_event_count_percentile_', (STRING)LEFT.cl_event_count_percentile_},
																											{'cl_impact_weight_', (STRING)LEFT.cl_impact_weight_},
																											{'cl_element_count_', (STRING)LEFT.cl_element_count_},
																											{'license_state_', (STRING)LEFT.license_state_},
																											{'event_count_', (STRING)LEFT.event_count_},
                                                      {'abbreviated_bankname_', (STRING)LEFT.abbreviated_bankname_},
                                                      {'in_customer_population_', (STRING)LEFT.in_customer_population_},
                                                      {'contributor_safe_flag_', (STRING)LEFT.contributor_safe_flag_},
                                                      {'safe_flag_', (STRING)LEFT.safe_flag_},
                                                      {'identity_count_', (STRING)LEFT.identity_count_}
																											], FlagsRec)(Value <> '');
															 SELF := LEFT));// : PERSIST('~temp::deleteme65');
				
END;
