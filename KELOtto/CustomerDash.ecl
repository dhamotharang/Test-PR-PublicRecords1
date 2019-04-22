EXPORT CustomerDash := MODULE
  IMPORT KELOtto;
  IMPORT Std;

  // Exclusions on frequency

  ExlusionRecord := RECORD
   UNSIGNED customer_id_;
   UNSIGNED industry_type_;
   STRING Entity_Context_uid_;
  END;

  // This is a 
  HighFrequencyExclusionList := 
    PROJECT(KELOtto.Q__show_Customer_Address.Res0(event_count_ > 1000), TRANSFORM(ExlusionRecord, SELF := LEFT)) + 
    PROJECT(KELOtto.Q__show_Customer_Social_Security_Number.Res0(event_count_ > 1000), TRANSFORM(ExlusionRecord, SELF := LEFT)) + 
    PROJECT(KELOtto.Q__show_Customer_Email.Res0(event_count_ > 1000), TRANSFORM(ExlusionRecord, SELF := LEFT)) + 
    PROJECT(KELOtto.Q__show_Customer_Phone.Res0(event_count_ > 1000), TRANSFORM(ExlusionRecord, SELF := LEFT)) + 
    PROJECT(KELOtto.Q__show_Customer_Internet_Protocol.Res0(event_count_ > 1000), TRANSFORM(ExlusionRecord, SELF := LEFT));

  //topclusters
  OttoFullGraph := KELOtto.KelFiles.FullCluster(safe_flag_ = 0); //DATASET('~foreign::10.173.44.105::gov::otto::fullgraph', RECORDOF(KELOtto.KelFiles.FullCluster), THOR); 


  
  //exclude high frequence clusters.
  tempFullCluster := JOIN(OttoFullGraph, HighFrequencyExclusionList, LEFT.customer_id_ = RIGHT.customer_id_ AND LEFT.industry_type_ = RIGHT.industry_type_ AND LEFT.tree_uid_ = RIGHT.entity_context_uid_, LEFT ONLY, LOOKUP);
  
  //KELOtto.KelFiles.FullCluster
  topstuff := tempFullCluster((cl_high_risk_pattern1_flag_ = 1 OR cl_high_risk_pattern2_flag_ = 1 OR cl_high_risk_pattern3_flag_ = 1 OR cl_high_risk_pattern4_flag_ = 1 OR cl_high_risk_pattern5_flag_ = 1) AND cl_identity_count_ < 30 AND tree_uid_=entity_context_uid_);
  //count(topstuff);

  topnormalstuff := topn(GROUP(SORT(tempFullCluster((cl_high_risk_pattern1_flag_ = 0 AND cl_high_risk_pattern2_flag_ = 1 AND cl_high_risk_pattern3_flag_ = 1) AND tree_uid_=entity_context_uid_), customer_id_, industry_type_, SKEW(1)), customer_id_, industry_type_, SKEW(1)), 10000, -cl_impact_weight_, SKEW(1));
  //count(topnormalstuff);

  ts1 := topstuff((cl_high_risk_pattern1_flag_ = 1 AND cl_high_risk_pattern2_flag_ = 1 AND cl_high_risk_pattern3_flag_ = 1 ));
  //count(ts1);

  ts2 := topn(GROUP(SORT(topstuff((cl_high_risk_pattern1_flag_ = 0 AND (cl_high_risk_pattern2_flag_ = 1 OR cl_high_risk_pattern3_flag_ = 1) )), customer_id_, industry_type_, SKEW(1)), customer_id_, industry_type_, SKEW(1)), 10000, -cl_impact_weight_, SKEW(1));
  //count(ts2);

  ts3 := topn(GROUP(SORT(topstuff((cl_high_risk_pattern2_flag_ = 0 AND (cl_high_risk_pattern1_flag_ = 1 OR cl_high_risk_pattern3_flag_ = 1) )), customer_id_, industry_type_, SKEW(1)), customer_id_, industry_type_, SKEW(1)), 10000, -cl_impact_weight_, SKEW(1));
  //count(ts3);

  ts4 := topn(GROUP(SORT(topstuff((cl_high_risk_pattern3_flag_ = 0 AND (cl_high_risk_pattern1_flag_ = 1 OR cl_high_risk_pattern2_flag_ = 1) )), customer_id_, industry_type_, SKEW(1)), customer_id_, industry_type_, SKEW(1)), 10000, -cl_impact_weight_, SKEW(1));
  //count(ts4);

  MainClustersPrep1 := DEDUP(SORT(topnormalstuff + ts1 + ts2 + ts3 + ts4, customer_id_, industry_type_, entity_context_uid_), customer_id_, industry_type_, entity_context_uid_);
  //count(MainClustersPrep1);

  MainClustersPrep2 := JOIN(MainClustersPrep1, tempFullCluster, LEFT.customer_id_=RIGHT.customer_id_ AND LEFT.industry_type_ = RIGHT.industry_type_ AND LEFT.entity_context_uid_ = RIGHT.tree_uid_ and LEFT.entity_context_uid_ != RIGHT.entity_context_uid_, TRANSFORM({RECORDOF(LEFT), STRING RelatedEntityContextUid}, SELF.RelatedEntityContextUid := RIGHT.entity_context_uid_, SELF := LEFT), HASH);
  MainClustersPrep3 := JOIN(MainClustersPrep2, topstuff, LEFT.customer_id_=RIGHT.customer_id_ AND LEFT.industry_type_ = RIGHT.industry_type_ AND LEFT.RelatedEntityContextUid = RIGHT.entity_context_uid_, TRANSFORM({RECORDOF(LEFT), INTEGER1 AssociatedClusterScore, INTEGER IsHigher}, 
                            SELF.IsHigher := MAP(LEFT.cluster_score_ > RIGHT.cluster_score_ OR (left.cluster_score_ = RIGHT.cluster_score_ AND LEFT.entity_context_uid_ > RIGHT.entity_context_uid_) OR RIGHT.entity_context_uid_ = '' => 1, 0),
                            SELF.AssociatedClusterScore := RIGHT.cluster_score_, SELF := LEFT), HASH);

  MainClustersPrep4 := TABLE(MainClustersPrep3, {customer_id_, industry_type_, entity_context_uid_, cluster_score_, HigherPercent := AVE(GROUP, IsHigher)}, customer_id_, industry_type_, entity_context_uid_, cluster_score_, MERGE);
  MainClusters := JOIN(MainClustersPrep1, MainClustersPrep4(HigherPercent=1), LEFT.customer_id_=RIGHT.customer_id_ AND LEFT.industry_type_ = RIGHT.industry_type_ AND LEFT.entity_context_uid_=RIGHT.entity_context_uid_, TRANSFORM(RECORDOF(LEFT), SELF := LEFT), LOOKUP);

  // Top Identities
  
  TopIdentitiesPrep1 := tempFullCluster(tree_uid_=entity_context_uid_ AND entity_type_ = 1 AND score_ > 80  /*cl_event_count_percentile_ > 85*/ AND cl_identity_count_ < 20);
  TopIdentitiesPrep2 := topn(GROUP(SORT(TopIdentitiesPrep1, customer_id_, industry_type_, skew(1)), customer_id_, industry_type_, SKEW(1)), 1000, customer_id_, industry_type_, -cl_impact_weight_, SKEW(1));


  //count(TopIdentitiesPrep2);

  // Top Elements

  TopElementsPrep1 := tempFullCluster(tree_uid_=entity_context_uid_ AND entity_type_ != 1);
  TopElementsPrep2 := topn(GROUP(SORT(TopElementsPrep1, customer_id_, entity_type_, skew(1)), customer_id_, industry_type_, entity_type_), 500, customer_id_, industry_type_, entity_type_, -cl_impact_weight_, -score_, SKEW(1));

  ClustersAndElements := DEDUP(SORT(MainClusters + TopIdentitiesPrep2 + TopElementsPrep2, customer_id_, industry_type_, entity_context_uid_, SKEW(1)), customer_id_, industry_type_, entity_context_uid_)
      : INDEPENDENT;
  
  EXPORT TopClustersAndElements := ClustersAndElements;


  // Only output entity stats for the things in the ClustersAndElements...

  OttoEntityStats := KELOtto.KelFiles.EntityStats; //DATASET('~gov::otto::entitystats', RECORDOF(KELOtto.KelFiles.EntityStats), THOR); //
  EntityStats := JOIN(OttoEntityStats, TopClustersAndElements, LEFT.customer_id_=RIGHT.customer_id_ AND LEFT.industry_type_ = RIGHT.industry_type_ AND LEFT.entity_context_uid_=RIGHT.entity_context_uid_, 
                      TRANSFORM(RECORDOF(LEFT), SELF := LEFT), LOOKUP, HASH) : INDEPENDENT;

  EXPORT TopEntityStats := EntityStats;
                      

END;