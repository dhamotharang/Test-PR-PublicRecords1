EXPORT BasicScoring := MODULE
  IMPORT KELOtto;


  WeightingChartPrep := DATASET('~foreign::10.241.100.157::gov::otto::configrisklevel_csv', {INTEGER EntityType, STRING Field, STRING Value, DECIMAL Low, DECIMAL High, INTEGER RiskLevel, INTEGER Weight, STRING UiDescription}, CSV(HEADING(1)));
  EXPORT WeightingChartOutput := OUTPUT(WeightingChartPrep,, '~gov::otto::configrisklevel', overwrite);

  EXPORT WeightingChart := DATASET('~gov::otto::configrisklevel', {INTEGER EntityType, STRING Field, STRING Value, DECIMAL Low, DECIMAL High, INTEGER RiskLevel, INTEGER Weight, STRING UiDescription}, THOR);

  EXPORT PersonStatsPrep := KELOtto.macPivotOttoOutput(KELOtto.Q__show_Customer_Person.Res0, 'industry_type_,customer_id_,entity_context_uid_', 
                        'score_,cluster_score_,event_count_,' + 
                        '_nas__summary_,_nap__summary_,_subjectssncount_,_ssnfoundforlexid_,subject_ssn_count_,stolen_identity_index_,synthetic_identity_index_,manipulated_identity_index_,vulnerable_victim_index_,friendlyfraud_index_,suspicious_activity_index_,all_high_risk_death_prior_to_all_events_,all_max_deceased_to_event_diff_,death_prior_to_all_events_,deceased_,deceased_event_percent_,deceased_match_,high_risk_death_prior_to_all_events_,in_customer_population_,max_deceased_to_event_diff_,no_lex_id_,' + 
                        'cl_death_prior_to_all_events_identity_count_,cl_high_risk_death_prior_to_all_events_identity_count_,cl_event_count_,cl_identity_count_,cl_nas9_identity_count_,cl_nap3_identity_count_,cl_address_count_,cl_identity_event_avg_,cl_identity_count_percentile_,cl_event_count_percentile_,cl_impact_weight_,kr_high_risk_flag_,kr_medium_risk_flag_,' +
                        '_cvi_,_v2__sourcerisklevel_,_v2__assocsuspicousidentitiescount_,_v2__assoccreditbureauonlycount_,_v2__inputaddrageoldest_,_v2__inputaddrdwelltype_,_v2__divssnidentitycountnew_,' + 
                        'hri03_flag_,hri06_flag_,hri07_flag_,hri08_flag_,hri11_flag_,hri12_flag_,hri14_flag_,hri15_flag_,hri19_flag_,hri25_flag_,hri26_flag_,hri27_flag_,hri28_flag_,hri29_flag_,hri30_flag_,hri31_flag_,hri37_flag_,hri38_flag_,hri41_flag_,hri48_flag_,hri50_flag_,hri51_flag_,hri52_flag_,hri71_flag_,hri83_flag_,hri90_flag_,hri_cl_flag_,hri_co_flag_,hri_dd_flag_,hri_df_flag_,hri_iv_flag_,hri_it_flag_,hri_mi_flag_,hri_mo_flag_,hri_ms_flag_,hri_nf_flag_,hri_pa_flag_,hri_po_flag_,hri_va_flag_,' +
												'vl_event1_all_count_,vl_event1_count_,vl_event30_all_day_count_,vl_event30_count_,vl_event365_all_day_count_,vl_event365_count_,vl_event7_all_count_,vl_event7_count_,' + 
												'cl_active30_identity_count_,cl_active7_identity_count_'
												);

  SHARED AddressStatsPrep := KELOtto.macPivotOttoOutput(KELOtto.Q__show_Customer_Address.Res0, 'industry_type_,customer_id_,entity_context_uid_', 
                        'identity_count_,score_,event_count_,' +
                        'all_deceased_match_person_count_,all_deceased_match_person_percent_,all_deceased_person_count_,all_deceased_person_percent_,all_high_frequency_flag_,all_high_risk_death_prior_to_all_events_person_count_,all_high_risk_death_prior_to_all_events_person_percent_,all_high_risk_death_prior_to_all_events_person_percent_flag_,all_person_count_,cl_event_count_,cl_event_count_percentile_,cl_identity_count_,cl_identity_count_percentile_,cl_impact_weight_,cluster_score_,deceased_match_person_percent_,deceased_person_count_,deceased_person_percent_,high_frequency_flag_,in_customer_population_,kr_high_risk_flag_,kr_medium_risk_flag_,source_customer_count_,_addresscmra_,' + 
												'vl_event1_all_count_,vl_event1_count_,vl_event30_all_day_count_,vl_event30_count_,vl_event365_all_day_count_,vl_event365_count_,vl_event7_all_count_,vl_event7_count_,' + 
												'cl_active30_identity_count_,cl_active7_identity_count_'
                        ) : PERSIST('~temp::deleteme42');

  EXPORT SocialSecurityStatsPrep := KELOtto.macPivotOttoOutput(KELOtto.Q__show_Customer_Social_Security_Number.Res0, 'industry_type_,customer_id_,entity_context_uid_', 
                        'cluster_score_, event_count_, identity_count_, score_, source_customer_count_,cl_event_count_,cl_identity_count_,' + 
	                      'hri06_flag_,hri26_flag_,hri29_flag_,hri38_flag_,hri71_flag_,hri_it_flag_,hri_mi_flag_,' + 
												'vl_event1_all_count_,vl_event1_count_,vl_event30_all_day_count_,vl_event30_count_,vl_event365_all_day_count_,vl_event365_count_,vl_event7_all_count_,vl_event7_count_,' + 
												'cl_active30_identity_count_,cl_active7_identity_count_'
												) : PERSIST('~temp::deleteme47');

  EXPORT EmailStatsPrep := KELOtto.macPivotOttoOutput(KELOtto.Q__show_Customer_Email.Res0, 'industry_type_,customer_id_,entity_context_uid_',
                        'cluster_score_,event_count_,identity_count_,score_,source_customer_count_,cl_event_count_,cl_identity_count_,' + 
												'vl_event1_all_count_,vl_event1_count_,vl_event30_all_day_count_,vl_event30_count_,vl_event365_all_day_count_,vl_event365_count_,vl_event7_all_count_,vl_event7_count_,' + 
												'cl_active30_identity_count_,cl_active7_identity_count_'
												) : PERSIST('~temp::deleteme44');

  EXPORT PhoneStatsPrep := KELOtto.macPivotOttoOutput(KELOtto.Q__show_Customer_Phone.Res0, 'industry_type_,customer_id_,entity_context_uid_', 
                        'phone_number_,_is_cell_phone_,cluster_score_,event_count_,identity_count_,score_,source_customer_count_,cl_event_count_,cl_identity_count_,' + 
                        'hri07_flag_,hri08_flag_,hri15_flag_,hri27_flag_,hri31_flag_,'+ 
												'vl_event1_all_count_,vl_event1_count_,vl_event30_all_day_count_,vl_event30_count_,vl_event365_all_day_count_,vl_event365_count_,vl_event7_all_count_,vl_event7_count_,' + 
												'cl_active30_identity_count_,cl_active7_identity_count_'
                        ) : PERSIST('~temp::deleteme45');

  EXPORT IPAddressStatsPrep := KELOtto.macPivotOttoOutput(KELOtto.Q__show_Customer_Internet_Protocol.Res0, 'industry_type_,customer_id_,entity_context_uid_', 
                        'score_,cluster_score_,event_count_,' + 
												'vl_event1_all_count_,vl_event1_count_,vl_event30_all_day_count_,vl_event30_count_,vl_event365_all_day_count_,vl_event365_count_,vl_event7_all_count_,vl_event7_count_,' + 
												'cl_active30_identity_count_,cl_active7_identity_count_'
												) : PERSIST('~temp::deleteme48');
                        
                        
  // Original Entity Stats
  EXPORT EntityStatsPrep1 := PersonStatsPrep + AddressStatsPrep + SocialSecurityStatsPrep + PhoneStatsPrep + IPAddressStatsPrep; /*+ EmailStatsPrep */
  // Correct unk classifications to be based on the entity type.
  EXPORT FullEntityStatsPrep := PROJECT(DISTRIBUTE(EntityStatsPrep1), TRANSFORM({INTEGER1 EntityType, RECORDOF(LEFT)}, 
	                   SELF.EntityType := (INTEGER1)LEFT.entity_context_uid_[2..3],
  	                 SELF.indicatordescription := MAP(LEFT.indicatordescription != 'unk' => LEFT.indicatordescription, 
                                                   MAP(LEFT.entity_context_uid_[2..3] = '01' => 'Identity',
                                                   MAP(LEFT.entity_context_uid_[2..3] = '15' => 'SSN',
                                                   MAP(LEFT.entity_context_uid_[2..3] = '16' => 'Phone',
                                                   MAP(LEFT.entity_context_uid_[2..3] = '17' => 'Email',
                                                   MAP(LEFT.entity_context_uid_[2..3] = '09' => 'Address',
                                                   MAP(LEFT.entity_context_uid_[2..3] = '18' => 'IP', 'unk'))))))),
                    
                    SELF.indicatortype :=        MAP(LEFT.indicatortype != 'unk' => LEFT.indicatortype, 
                                                   MAP(LEFT.entity_context_uid_[2..3] = '01' => 'ID',
                                                   MAP(LEFT.entity_context_uid_[2..3] = '15' => 'SSN',
                                                   MAP(LEFT.entity_context_uid_[2..3] = '16' => 'PH',
                                                   MAP(LEFT.entity_context_uid_[2..3] = '17' => 'EML',
                                                   MAP(LEFT.entity_context_uid_[2..3] = '09' => 'ADDR',
                                                   MAP(LEFT.entity_context_uid_[2..3] = '18' => 'IP', 'unk'))))))),
										SELF := LEFT)) : PERSIST('~temp::deleteme46');
										
  // This is the list of attributes per entity type, indicatortype
  EXPORT FullIndicatorListPrep := TABLE(FullEntityStatsPrep, {customer_id_, industry_type_, entitytype, indicatordescription, Field, ElementCount := COUNT(GROUP) }, customer_id_, industry_type_, entitytype, indicatordescription, Field, MERGE);
  EXPORT FullIndicatorList := JOIN(FullIndicatorListPrep, WeightingChart, 
                         LEFT.Field=RIGHT.Field AND LEFT.EntityType = RIGHT.EntityType, 
												 TRANSFORM({RECORDOF(LEFT), INTEGER1 IsConfigured}, SELF.IsConfigured := MAP(RIGHT.field != '' => 1, 0), SELF := LEFT, SELF := RIGHT), LEFT OUTER, KEEP(1)); 
	
  // This is the final result for entity stats after w
  EXPORT WeightedResult := JOIN(FullEntityStatsPrep(Value != ''), WeightingChart, 
                         LEFT.Field=RIGHT.Field AND (INTEGER)LEFT.entity_context_uid_[2..3] = RIGHT.EntityType AND
                         (
                           (
                             RIGHT.Value != '' AND LEFT.Value = RIGHT.Value
                           )
                           OR
                           (
                             RIGHT.Value = '' AND (RIGHT.Low = 0 AND RIGHT.High = 0) 
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
                            SELF.Weight := RIGHT.Weight, 
                            SELF.RiskLevel := MAP(RIGHT.Field != '' => RIGHT.RiskLevel, -1), // If there is no specific configuration for a field assign the risk level to -1 so it can be hidden.
                            SELF.Label := MAP(TRIM(RIGHT.UiDescription) != '' => RIGHT.UiDescription, LEFT.Label);
                            SELF.field := LEFT.field +
                                          MAP(TRIM(RIGHT.Value) != '' =>  '_' + RIGHT.Value, MAP(RIGHT.Low > 0 => '_' + (STRING)RIGHT.Low, '') + MAP(RIGHT.High > 0 => '_' + (STRING)RIGHT.High, ''));
                            SELF := LEFT), LOOKUP, LEFT OUTER);
                         
  EXPORT ScoreBreakdownAggregate := TABLE(WeightedResult(customer_id_>0), 
                        {customer_id_, industry_type_, entity_context_uid_, INTEGER entity_type_ := (INTEGER)entity_context_uid_[2..3], indicatortype, indicatordescription, 
                         INTEGER RiskLevel := 0 /* percentile */, populationtype := 'Element', 
                         INTEGER Value := SUM(GROUP, Weight), ValueCurved := (SUM(GROUP, Weight) * 100000) + RANDOM() % 10000}, customer_id_, industry_type_, entity_context_uid_, entity_context_uid_[2..3], indicatortype, indicatordescription, MERGE);
                         

  EXPORT ScoreBreakdown := 
          PROJECT(
            KELOtto.Functions.CalculatePercentile(ScoreBreakdownAggregate, 'customer_id_, industry_type_, indicatortype, entity_type_, indicatordescription', ValueCurved, 'CustomerPercentile', 'CustomerQuartileRank'), 
            TRANSFORM(RECORDOF(LEFT) AND NOT [hashid], self.RiskLevel := LEFT.CustomerPercentile, SELF := LEFT)) : PERSIST('~temp::deleteme43', EXPIRE(7));



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
													 LOOKUP);
													   
  EXPORT FullScoredBreakdown := TempAverages + ScoreBreakdown : PERSIST('~temp::deleteme62');

  // The cluster score is the percentile of the "cluster" indicator type..
  
  // This is the entity score (including cluster);
  SHARED ScoresPrep := TABLE(ScoreBreakdown,
               {customer_id_, industry_type_, entity_context_uid_, Score := SUM(GROUP, CustomerPercentile), CurveScore := (SUM(GROUP, CustomerPercentile)*1000000)+RANDOM() % 1000000 }, customer_id_, industry_type_, entity_context_uid_, MERGE);
               
  
  EXPORT Scores := DISTRIBUTE(KELOtto.Functions.CalculatePercentile(ScoresPrep, 'customer_id_, industry_type_', CurveScore, 'ScorePercentile', 'ScoreQuartileRank'), HASH32(entity_context_uid_));


  EXPORT EntityStats := JOIN(WeightedResult(RiskLevel in [0,1,2,3]), Scores, LEFT.customer_id_=RIGHT.customer_id_ AND LEFT.industry_type_=RIGHT.industry_type_ AND LEFT.entity_context_uid_=RIGHT.entity_context_uid_ AND LEFT.Field = 'score_',
                        TRANSFORM(RECORDOF(LEFT), SELF.Value := MAP(RIGHT.entity_context_uid_ != '' => (STRING)RIGHT.ScorePercentile, (STRING)LEFT.Value), SELF := LEFT), LEFT OUTER, HASH);

  // Fill in the actual scores on all the entities in the graph
  
  EXPORT ScoredGraphPrep := JOIN(DISTRIBUTE(KELOtto.FullGraph, HASH32(entity_context_uid_)), Scores,
                        LEFT.customer_id_=RIGHT.customer_id_ AND LEFT.industry_type_=RIGHT.industry_type_ AND LEFT.entity_context_uid_=RIGHT.entity_context_uid_,
                        TRANSFORM(RECORDOF(LEFT), SELF.Score_ := MAP(RIGHT.entity_context_uid_ != '' => RIGHT.ScorePercentile, 0), SELF := LEFT), LEFT OUTER, LOCAL);

  EXPORT ScoredGraph := JOIN(ScoredGraphPrep, DISTRIBUTE(ScoreBreakdown, HASH32(entity_context_uid_)),
                        LEFT.customer_id_=RIGHT.customer_id_ AND LEFT.industry_type_=RIGHT.industry_type_ AND LEFT.entity_context_uid_=RIGHT.entity_context_uid_ AND
                        RIGHT.indicatortype = 'CL',
                        TRANSFORM(RECORDOF(LEFT), SELF.Cluster_Score_ := MAP(RIGHT.entity_context_uid_ != '' => RIGHT.CustomerPercentile, 0), SELF := LEFT), LEFT OUTER, LOCAL);

                         
//EXPORT MacEntityWeighting := 'todo';


END;