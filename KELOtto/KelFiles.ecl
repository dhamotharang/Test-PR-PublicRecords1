﻿EXPORT KelFiles := MODULE
  //Cluster                               
  EXPORT FullCluster := KELOtto.BasicScoring.ScoredGraph;
 
  //Stats
  EXPORT EntityStats := KELOtto.BasicScoring.EntityStats;
                         
  EXPORT CustomerStats := KELOtto.Q__show_Customer.Res0;
	
	IMPORT FraudGovPlatform_Analytics;
  EXPORT CustomerStatsPivot := FraudGovPlatform_Analytics.macPivotOttoOutput(KELOtto.Q__show_Customer.Res0, 'industry_type_,customer_id_', 'address_count_,all_address_count_,all_deceased_matched_percent_,all_deceased_matched_person_count_,all_deceased_person_count_,all_deceased_person_percent_,all_high_frequency_address_count_,all_high_frequency_address_percent_,all_person_count_,deceased_person_count_,deceased_person_percent_,high_frequency_address_count_,high_frequency_address_percent_,person_count_');
	
	PersonStatsScore := JOIN(KELOtto.Q__show_Customer_Person.Res0, KELOtto.BasicScoring.Scores, 
	                      LEFT.customer_id_=RIGHT.customer_id_ AND LEFT.industry_type_=RIGHT.industry_type_ AND LEFT.entity_context_uid_=RIGHT.entity_context_uid_,
                        TRANSFORM(RECORDOF(LEFT), SELF.Score_ := MAP(RIGHT.entity_context_uid_ != '' AND RIGHT.TotalWeightValue > 0 => RIGHT.ScorePercentile, 0), SELF := LEFT), LEFT OUTER, LOCAL);
												
  EXPORT PersonStats := hipie_ecl.macSlimDataset(PersonStatsScore, 'industry_type_,customer_id_,entity_context_uid_', 
	                      'best_first_name_,best_middle_name_,best_last_name_,best_name_suffix_,best_ssn_,best_email_,best_street_address_,best_city_,best_zip_,best_state_,date_of_birth_,' +
                        'label_,_r_customer_,age_,deceased_ssn_,_nas__summary_,_nap__summary_,_subjectssncount_,_dobmatchlevel_,_ssnfoundforlexid_,subject_ssn_count_,date_of_birth_match_level_,stolen_identity_index_,synthetic_identity_index_,manipulated_identity_index_,vulnerable_victim_index_,friendlyfraud_index_,suspicious_activity_index_,all_death_prior_to_all_events_,all_deceased_event_count_,all_deceased_event_percent_,all_high_risk_death_prior_to_all_events_,all_max_deceased_to_event_diff_,death_prior_to_all_events_,deceased_,deceased_dob_match_,deceased_event_count_,deceased_event_percent_,deceased_match_,deceased_match_description_,deceased_name_match_,entity_type_,high_risk_death_prior_to_all_events_,in_customer_population_,max_deceased_to_event_diff_,no_lex_id_,no_lex_id_gt22_,' + 
												'address_is_cmra30_count_,address_is_cmra30_flag_,address_invalid30_count_,address_invalid30_flag_,hri14_active30_flag_,hri50_active30_flag_,validation_addr_problems30_count_,validation_addr_problems30_flag_,address_is_out_of_state30_count_,address_is_of_state30_flag_,' +
												'dt_last_seen_,score_,' +
                        'id_ssn_identity_count_max_,' + 
                        'nas9_flag_,nap3_flag_,cl_no_lex_id_gt22_count_,cl_death_prior_to_all_events_identity_count_,cl_high_risk_death_prior_to_all_events_identity_count_,cl_event_count_,cl_identity_count_,cl_full_identity_count_,cl_nas9_identity_count_,cl_nap3_identity_count_,' + 
                        'kr_high_risk_flag_,kr_medium_risk_flag_,kr_event_after_last_known_risk_flag_,' +
												'vl_event30_active_flag_,' +
                        'cl_identity_count_decile_,cl_p_r_identity_match_count_,cl_p_r_identity_match_percent_,cl_high_kr_identity_count_,cl_active7_identity_count_,cl_active30_identity_count_,cl_address_count_,cl_identity_event_avg_,cl_high_risk_pattern1_flag_,cl_high_risk_pattern2_flag_,cl_high_risk_pattern3_flag_,cl_high_risk_pattern4_flag_,cl_high_risk_pattern5_flag_,cl_nas9_identity_percent_,cl_nas9_top10_,cl_high_risk_death_prior_to_all_events_identity_percent_,cl_high_risk_death_prior_to_all_events_identity_top10_,cl_ip_high_risk_identity_percent_,cl_ip_high_risk_identity_top10_,cl_high_kr_identity_percent_,cl_high_kr_identity_top10_,cl_ip_not_us_identity_count_,cl_ip_vpn_identity_count_,cl_ip_high_risk_city_identity_count_,cl_ip_hosted_identity_count_,cl_ip_tor_identity_count_,cl_ip_high_risk_identity_count_,cl_ip_not_us_event_count_,cl_ip_vpn_event_count_,cl_ip_high_risk_city_event_count_,cl_ip_hosted_event_count_,cl_ip_tor_event_count_,cl_identity_count_percentile_,cl_event_count_percentile_,cl_active30_identity_count_percentile_,cl_active7_identity_count_percentile_,cl_impact_weight_');
 
  EXPORT IPAddressStats := KELOtto.Q__show_Customer_Internet_Protocol.Res0;

  // Associations
  EXPORT PersonAssociationsStats := JOIN(KELOtto.AddressPersonAssociations.PersonAddressMatchStats, PersonStats, LEFT.associatedcustomerfileinfo = RIGHT._r_customer_ AND LEFT.ToPersonEntityContextUid=RIGHT.entity_context_uid_, 
            TRANSFORM({RECORDOF(LEFT), STRING ToPersonLabel}, 
            SELF.customer_id_ := RIGHT.customer_id_, // Correct the customer id and industry type for the relationship to be based off the associated customer_id and not the source.
            SELF.industry_type_ := RIGHT.industry_type_,
            SELF.ToPersonLabel := RIGHT.Label_, SELF := LEFT, SELF := RIGHT), KEEP(1), ALL, HASH);
  EXPORT PersonAssociationsDetails := KELOtto.AddressPersonAssociations.PersonAddressMatches;

  // Customer ScoreBreakdown
  EXPORT ScoreBreakdown := KELOtto.BasicScoring.FullScoredBreakdown;
  
  //Customer ScoreBreakdown Averages
  EXPORT CustomerScoreBreakdownAverages := KELOtto.BasicScoring.CustomerScoreBreakdownAverages;
	
  //Details
  EXPORT CustomerAddress := KELOtto.Q__show_Customer_Address.Res0;
  EXPORT PersonEvents := KELOtto.Q__show_Customer_Person_Event.Res0;
END;




