EXPORT CustomerDashboard := MODULE
  IMPORT KELOtto;
  IMPORT Std;


  ClusterRecord := RECORD
   UNSIGNED customer_id_;
   UNSIGNED industry_type_;
   STRING Entity_Context_uid_;
	 INTEGER1 High_Risk_Centroid;
	 INTEGER1 Known_Risk_Centroid;
	 INTEGER1 High_Scoring_Cluster := 0;
	 INTEGER1 connected_element_count_ := 0;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_High_Risk_Routing_Count_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_No_Lex_Id_Gt22_Count_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_Death_Prior_To_All_Events_Identity_Count_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_High_Risk_Death_Prior_To_All_Events_Identity_Count_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_Event_Count_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_Element_Count_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_Identity_Count_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_Identity_Count_Decile_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_Identity_Count_Percentile_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_Nas9_Identity_Count_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_Nap3_Identity_Count_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_High_Kr_Identity_Count_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_Active7_Identity_Count_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_Active30_Identity_Count_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_Address_Count_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_Identity_Event_Avg_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_High_Risk_Pattern1_Flag_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_High_Risk_Pattern2_Flag_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_High_Risk_Pattern3_Flag_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_High_Risk_Pattern4_Flag_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_High_Risk_Pattern5_Flag_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_P_R_Identity_Match_Count_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_P_R_Identity_Match_Percent_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_P_R_Identity_No_Match_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_Nas9_Identity_Percent_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_Nas9_Top10_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_Nas3_Identity_Percent_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_Nas3_Top10_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_High_Risk_Death_Prior_To_All_Events_Identity_Percent_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_High_Risk_Death_Prior_To_All_Events_Identity_Top10_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_Ip_High_Risk_Identity_Percent_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_Ip_High_Risk_Identity_Top10_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_High_Kr_Identity_Percent_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_High_Kr_Identity_Top10_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_Ip_Not_Us_Identity_Count_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_Ip_Vpn_Identity_Count_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_Ip_High_Risk_City_Identity_Count_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_Ip_Hosted_Identity_Count_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_Ip_Tor_Identity_Count_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_Ip_High_Risk_Identity_Count_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_Ip_Not_Us_Event_Count_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_Ip_Vpn_Event_Count_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_Ip_High_Risk_City_Event_Count_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_Ip_Hosted_Event_Count_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_Ip_Tor_Event_Count_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_Event_Count_Percentile_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_Active30_Identity_Count_Percentile_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_Active7_Identity_Count_Percentile_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_Bank_Identity_Count_Gt2_Count_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_Bank_Identity_Count_Gt2_Top10_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_Adjacent_Safe_Flag_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_Adjacent_No_Safe_Flag_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_high_risk_email_count_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_High_Risk_Email_Top10_;
	 KELOtto.Q__show_Customer_Person.Res0.Cl_Kr_Event_After_Known_Risk_Identity_Count_;
  END;

  EXPORT ClusterPrep1 := 
    PROJECT(KELOtto.Q__show_Customer_Person.Res0(cl_event_count_ < 1000 AND event_count_ < 1000 and cl_identity_count_ < 50), 
		  TRANSFORM(ClusterRecord, SELF := LEFT, 
			 SELF.Known_Risk_Centroid := MAP((LEFT.kr_high_risk_flag_ = 1  OR LEFT.kr_medium_risk_flag_ = 1 OR LEFT.kr_low_risk_flag_ = 1) AND LEFT.Kr_Event_After_Last_Known_Risk_Flag_ = 1 => 1, 0), SELF := [])) + 
    PROJECT(KELOtto.Q__show_Customer_Address.Res0(identity_count_ > 1)/*(cl_event_count_ < 1000 AND event_count_ < 1000 AND identity_count_ < 50)*/, 
		  TRANSFORM(ClusterRecord, 
			 SELF.Known_Risk_Centroid := MAP((LEFT.kr_high_risk_flag_ = 1  OR LEFT.kr_medium_risk_flag_ = 1 OR LEFT.kr_low_risk_flag_ = 1) AND LEFT.Kr_Event_After_Last_Known_Risk_Flag_ = 1 AND LEFT.Identity_Count_ > 1 => 1, 0),
			 SELF.High_Risk_Centroid := MAP(LEFT.Invalid_Address_ + LEFT.Address_Is_Vacant_ + LEFT.Address_Is_Cmra_ + LEFT.Address_Is_Po_Box_ > 0 AND LEFT.Identity_Count_ > 1 => 1, 0), SELF := LEFT)) + 
    PROJECT(KELOtto.Q__show_Customer_Social_Security_Number.Res0(identity_count_ > 1)/*(cl_event_count_ < 1000 AND event_count_ < 1000 AND identity_count_ < 50)*/, 
		  TRANSFORM(ClusterRecord, 
			 SELF.Known_Risk_Centroid := MAP((LEFT.kr_high_risk_flag_ = 1  OR LEFT.kr_medium_risk_flag_ = 1 OR LEFT.kr_low_risk_flag_ = 1) AND LEFT.Kr_Event_After_Last_Known_Risk_Flag_ = 1 AND LEFT.Identity_Count_ > 1 => 1, 0),
			 SELF.High_Risk_Centroid := LEFT.Identity_Count_Gt2_, SELF := LEFT)) + 
    PROJECT(KELOtto.Q__show_Customer_Email.Res0(identity_count_ > 1)/*(cl_event_count_ < 1000 AND event_count_ < 1000 AND identity_count_ < 50)*/, 
		  TRANSFORM(ClusterRecord, 
			 SELF.Known_Risk_Centroid := MAP((LEFT.kr_high_risk_flag_ = 1  OR LEFT.kr_medium_risk_flag_ = 1 OR LEFT.kr_low_risk_flag_ = 1) AND LEFT.Kr_Event_After_Last_Known_Risk_Flag_ = 1 AND LEFT.Identity_Count_ > 1 => 1, 0),
			 SELF.High_Risk_Centroid := MAP(LEFT._isdisposableemail_ + LEFT.Not_Safe_Last_Domain_Gt2_ > 0 AND LEFT.Identity_Count_ > 1=> 1, 0),SELF := LEFT)) + 
    PROJECT(KELOtto.Q__show_Customer_Phone.Res0(identity_count_ > 1)/*(cl_event_count_ < 1000 AND event_count_ < 1000 AND identity_count_ < 50)*/, 
		  TRANSFORM(ClusterRecord, 
			 SELF.Known_Risk_Centroid := MAP((LEFT.kr_high_risk_flag_ = 1  OR LEFT.kr_medium_risk_flag_ = 1 OR LEFT.kr_low_risk_flag_ = 1) AND LEFT.Kr_Event_After_Last_Known_Risk_Flag_ = 1 AND LEFT.Identity_Count_ > 1 => 1, 0),
			 SELF.High_Risk_Centroid := MAP(LEFT.Identity_Count_ > 1 => 1, 0), SELF := LEFT, SELF := [])) + 
    PROJECT(KELOtto.Q__show_Customer_Bank_Account.Res0(identity_count_ > 1)/*(cl_event_count_ < 1000 AND event_count_ < 1000 AND identity_count_ < 50)*/, 
		  TRANSFORM(ClusterRecord, 
			 SELF.Known_Risk_Centroid := MAP((LEFT.kr_high_risk_flag_ = 1  OR LEFT.kr_medium_risk_flag_ = 1 OR LEFT.kr_low_risk_flag_ = 1) AND LEFT.Kr_Event_After_Last_Known_Risk_Flag_ = 1 AND LEFT.Identity_Count_ > 1 => 1, 0),
			 SELF.High_Risk_Centroid := MAP((LEFT.High_Risk_Routing_ = 1 OR LEFT.Identity_Count_Gt2_ > 0 ) AND LEFT.Identity_Count_ > 1 => 1, 0), SELF := LEFT, SELF := [])) + 
    PROJECT(KELOtto.Q__show_Customer_Internet_Protocol.Res0(identity_count_ > 1)/*(cl_event_count_ < 1000 AND event_count_ < 1000 AND identity_count_ < 50)*/, 
		  TRANSFORM(ClusterRecord, 
			 SELF.Known_Risk_Centroid := MAP((LEFT.kr_high_risk_flag_ = 1  OR LEFT.kr_medium_risk_flag_ = 1 OR LEFT.kr_low_risk_flag_ = 1) AND LEFT.Kr_Event_After_Last_Known_Risk_Flag_ = 1 AND LEFT.Identity_Count_ > 1 => 1, 0),
			 SELf.High_Risk_Centroid := MAP((LEFT.Ip_Not_Us_ + LEFT.Ip_Vpn_ + LEFT.Ip_High_Risk_City_ + LEFT.Ip_Hosted_ + LEFT.Ip_Tor_ > 0) AND LEFT.Identity_Count_ > 1 => 1, 0),SELF := LEFT));
		
  EXPORT ClusterPrep := JOIN(KELOtto.KelFiles.FullCluster(entity_context_uid_ = tree_uid_), ClusterPrep1, LEFT.customer_id_=RIGHT.customer_id_ AND LEFT.industry_type_ = RIGHT.industry_type_ AND LEFT.entity_context_uid_ = RIGHT.entity_context_uid_, 
	                 TRANSFORM({RECORDOF(LEFT), RECORDOF(RIGHT)}, SELF.High_Risk_Centroid := MAP(LEFT.entity_type_ = 1 => MAP(LEFT.cl_hr_identity_count_ > 1 => 1, 0), RIGHT.High_Risk_Centroid),
									                                              SELF.High_Scoring_Cluster := MAP(LEFT.cl_hr_element_count_ > 1 and LEFT.cl_hr_identity_count_ > 1 => 1, 0),
																																SELF := LEFT, SELF := RIGHT),
	                 HASH);
	
  EXPORT OttoFullGraphElements := ClusterPrep(safe_flag_ = 0 AND entity_type_ != 1 AND Cl_High_Kr_Identity_Percent_ < 1 );

  EXPORT OttoFullGraphIdentities := ClusterPrep(safe_flag_ = 0 AND entity_type_ = 1 AND Cl_High_Kr_Identity_Percent_ < 1 AND connected_element_count_ > 1);
	
  EXPORT Identities_1 := JOIN(OttoFullGraphIdentities, OttoFullGraphIdentities, LEFT.customer_id_=RIGHT.customer_id_ AND LEFT.industry_type_ = RIGHT.industry_type_ AND LEFT.entity_context_uid_ = RIGHT.tree_uid_ and LEFT.entity_context_uid_ != RIGHT.entity_context_uid_, TRANSFORM({RECORDOF(LEFT), STRING RelatedEntityContextUid}, SELF.RelatedEntityContextUid := RIGHT.entity_context_uid_, SELF := LEFT), HASH);
  EXPORT Identities_2 := JOIN(OttoFullGraphIdentities, OttoFullGraphIdentities, LEFT.customer_id_=RIGHT.customer_id_ AND LEFT.industry_type_ = RIGHT.industry_type_ AND LEFT.entity_context_uid_ = RIGHT.entity_context_uid_ and LEFT.entity_context_uid_ != RIGHT.tree_uid_, TRANSFORM({RECORDOF(LEFT), STRING RelatedEntityContextUid}, SELF.RelatedEntityContextUid := RIGHT.tree_uid_, SELF := LEFT), KEEP(1), HASH);
  EXPORT MainIdentityClustersPrep := Identities_1 + Identities_2;
	EXPORT MainClustersPrep := JOIN(MainIdentityClustersPrep, OttoFullGraphIdentities, LEFT.customer_id_=RIGHT.customer_id_ AND LEFT.industry_type_ = RIGHT.industry_type_ AND LEFT.RelatedEntityContextUid = RIGHT.entity_context_uid_, TRANSFORM({RECORDOF(LEFT), INTEGER1 AssociatedClusterScore, INTEGER IsHigher}, 
                            SELF.IsHigher := MAP(LEFT.cluster_score_ > RIGHT.cluster_score_ OR (left.cluster_score_ = RIGHT.cluster_score_ AND LEFT.entity_context_uid_ > RIGHT.entity_context_uid_) OR RIGHT.entity_context_uid_ = '' => 1, 0),
                            SELF.AssociatedClusterScore := RIGHT.cluster_score_, SELF := LEFT), HASH);


  EXPORT MainClustersPrep4 := TABLE(MainClustersPrep, {customer_id_, industry_type_, entity_context_uid_, cluster_score_, HigherPercent := AVE(GROUP, IsHigher)}, customer_id_, industry_type_, entity_context_uid_, cluster_score_, MERGE);
	// exclude any clusters that are not the higher, leaving clusters that don't have any connected clusters there too.
  EXPORT MainClustersPrep5 := JOIN(OttoFullGraphIdentities, MainClustersPrep4(HigherPercent<1), LEFT.customer_id_=RIGHT.customer_id_ AND LEFT.industry_type_ = RIGHT.industry_type_ AND LEFT.entity_context_uid_=RIGHT.entity_context_uid_, 
	                           TRANSFORM(RECORDOF(LEFT), SELF := LEFT),
														 LEFT ONLY, LOOKUP);

  EXPORT MainClustersPrep6 := PROJECT(MainClustersPrep5 + OttoFullGraphElements, 
	                           TRANSFORM({RECORDOF(LEFT), 
														 UNSIGNED1 Cl_High_Risk_Pattern6_Flag_, 
														 UNSIGNED1 Cl_High_Risk_Pattern7_Flag_, 
														 UNSIGNED1 Cl_High_Risk_Pattern8_Flag_, 
														 UNSIGNED1 Cl_High_Risk_Pattern9_Flag_, 
														 UNSIGNED1 Cl_High_Risk_Pattern10_Flag_,
														 UNSIGNED1 Cl_High_Risk_Pattern11_Flag_,
														 UNSIGNED1 Cl_High_Risk_Pattern12_Flag_,
														 UNSIGNED1 Cl_High_Risk_Pattern13_Flag_,
														 UNSIGNED1 Cl_High_Risk_Pattern14_Flag_,
														 UNSIGNED1 Cl_High_Risk_Pattern15_Flag_
														 }, 
														 //SELF.kr_high_risk_flag_ := 3, // THIS IS A TEMPORARY HACK TO FLAG HIGH RISK CLUSTERS ONLY.
														 SELF.Cl_High_Risk_Pattern1_Flag_ := (INTEGER1)(LEFT.Cl_Active30_Identity_Count_Percentile_ > 90),
														 SELF.Cl_High_Risk_Pattern2_Flag_ := LEFT.Cl_Nas9_Top10_,
														 SELF.Cl_High_Risk_Pattern3_Flag_ := LEFT.Cl_Nas3_Top10_,
														 SELF.Cl_High_Risk_Pattern4_Flag_ := MAP(LEFT.Cl_Ip_High_Risk_Identity_Top10_ = 1 =>1,0),
														 SELF.Cl_High_Risk_Pattern5_Flag_ := MAP(LEFT.Cl_High_Kr_Identity_Percent_ < 1 AND LEFT.Cl_High_Kr_Identity_Percent_ > 0 AND LEFT.Cl_Kr_Event_After_Known_Risk_Identity_Count_ > 1 => 1, 0), //,
														 SELF.Cl_High_Risk_Pattern6_Flag_ := LEFT.Known_Risk_Centroid, 
														 SELF.Cl_High_Risk_Pattern7_Flag_ := MAP(LEFT.cl_deceased_count_>0 => 1, 0),
														 SELF.Cl_High_Risk_Pattern8_Flag_ := LEFT.Cl_Adjacent_No_Safe_Flag_,
														 SELF.Cl_High_Risk_Pattern9_Flag_ := MAP(LEFT.Cl_Bank_Identity_Count_Gt2_Count_ > 0 OR LEFT.Cl_High_Risk_Routing_Count_ > 0 => 1, 0),
														 SELF.Cl_High_Risk_Pattern10_Flag_ := MAP(LEFT.Cl_High_Risk_Email_Top10_=1=>1, 0),// measure of the % of high risk identities and elements in the cluster,
														 SELF.Cl_High_Risk_Pattern11_Flag_ := LEFT.High_Risk_Centroid, 
														 SELF.Cl_High_Risk_Pattern12_Flag_ := LEFT.High_Scoring_Cluster, 
														 SELF := LEFT, SELF := []));
	
  EXPORT MainClusters := MainClustersPrep6;	
  // Keep all the elements separate from identities
	// Only filter adjacent clusters for identities.
	// 
END;