﻿import KELOtto;
/*

SHAPE output for interactive HIPIE Graph Visualization

*/

/* 
Temporary collection of attributes to add. These should be woven back into the graph kel and added to the joined below after the next build.
*/

  AdditionalAttributesRecord := RECORD
   UNSIGNED customer_id_;
   UNSIGNED industry_type_;
   STRING Entity_Context_uid_;
   UNSIGNED event_count_;
   UNSIGNED identity_count_;
	 UNSIGNED1 cl_adjacent_safe_flag_;
	 UNSIGNED cl_hr_identity_count_ := 0;
	 UNSIGNED cl_hr_element_count_ := 0;
  END;

  AdditionalAttributes := 
    PROJECT(KELOtto.Q__show_Customer_Person.Res0, TRANSFORM(AdditionalAttributesRecord, SELF.identity_count_ := 1, SELF := LEFT)) + 
    PROJECT(KELOtto.Q__show_Customer_Address.Res0, TRANSFORM(AdditionalAttributesRecord, SELF := LEFT)) + 
    PROJECT(KELOtto.Q__show_Customer_Social_Security_Number.Res0, TRANSFORM(AdditionalAttributesRecord, SELF := LEFT)) + 
    PROJECT(KELOtto.Q__show_Customer_Email.Res0, TRANSFORM(AdditionalAttributesRecord, SELF := LEFT)) + 
    PROJECT(KELOtto.Q__show_Customer_Phone.Res0, TRANSFORM(AdditionalAttributesRecord, SELF := LEFT)) + 
    PROJECT(KELOtto.Q__show_Customer_Bank_Account.Res0, TRANSFORM(AdditionalAttributesRecord, SELF := LEFT)) + 
    PROJECT(KELOtto.Q__show_Customer_Drivers_License.Res0, TRANSFORM(AdditionalAttributesRecord, SELF := LEFT)) + 
    PROJECT(KELOtto.Q__show_Customer_Internet_Protocol.Res0, TRANSFORM(AdditionalAttributesRecord, SELF := LEFT));


// NOTE We don't do Person to the various elements back to person because those relationships need to be added in 
//      person to person associations carefully and then they appear. It will allow us to drop out the other elements if we want to.

// Make sure that every person entity has a seed tree_uid_
PersonEntities := PROJECT(KELOtto.Q__show_Customer_Person_Entities.Res0, 
                TRANSFORM(RECORDOF(KELOtto.Q__show_Customer_Person_Tree_Entities.Res0), 
                  SELF.tree_uid_ := LEFT.entity_context_uid_, 
                  SELF := LEFT, SELF := []));

/* NB This is to limit adding hyper connected entities (mostly addresses) Will need to be revisited later to only add the centroid */

PersonToAddress := JOIN(KELOtto.Q__show_Customer_Address_Person_Tree_Entities.Res0, KELOtto.Q__show_Customer_Address.Res0(cl_identity_count_ > 1000), 
                         LEFT.customer_id_ = RIGHT.customer_id_ AND LEFT.industry_type_ = RIGHT.industry_type_ AND LEFT.tree_uid_ = RIGHT.entity_context_uid_, 
                         TRANSFORM(RECORDOF(LEFT), SELF := LEFT), LEFT ONLY, LOOKUP);
                  
FullTreePrep1 := 
  (PersonEntities + // include person entities because people without person to person rows won't show up.
  KELOtto.Q__show_Customer_Person_Tree_Entities.Res0 + // Person to Person 
  PersonToAddress + //KELOtto.Q__show_Customer_Address_Person_Tree_Entities.Res0 +  // Address to Person
  KELOtto.Q__show_Customer_Person_S_S_N_Tree_Entities.Res0 + // SSN to Person
  KELOtto.Q__show_Customer_Person_Phone_Tree_Entities.Res0 + // Phone to Person
  KELOtto.Q__show_Customer_Person_Phone_Tree_Entities.Res0 + // Phone to Person
  KELOtto.Q__show_Customer_Person_Email_Tree_Entities.Res0 +
  KELOtto.Q__show_Customer_Person_Bank_Account_Tree_Entities.Res0 +
  KELOtto.Q__show_Customer_Person_Ip_Tree_Entities.Res0 +
  KELOtto.Q__show_Customer_Person_Drivers_License_Tree_Entities.Res0)(tree_uid_ != '_011' AND entity_context_uid_ != '_011');
  //: persist('~temp::deleteme99');

FullTreePrepExclusions := TABLE(FullTreePrep1, {source_customer_, tree_uid_, recordcount := COUNT(GROUP)}, source_customer_, tree_uid_, MERGE);
FullTreePrep2 := JOIN(FullTreePrep1, FullTreePrepExclusions(recordcount > 300), LEFT.source_customer_=RIGHT.source_customer_ AND LEFT.tree_uid_=RIGHT.tree_uid_, TRANSFORM({RECORDOF(LEFT), BOOLEAN Hf}, SELF.Hf := RIGHT.recordcount > 300, SELF := LEFT), LEFT OUTER);

SelfEntities := PROJECT(DEDUP(SORT(DISTRIBUTE(FullTreePrep2, HASH32(source_customer_, tree_uid_)), source_customer_, tree_uid_, LOCAL), source_customer_, tree_uid_, LOCAL), TRANSFORM(RECORDOF(LEFT), SELF.entity_context_uid_ := LEFT.tree_uid_, SELF := LEFT));

FullTreePrep := DEDUP(SORT(DISTRIBUTE(FullTreePrep2+SelfEntities, HASH32(source_customer_, tree_uid_, entity_context_uid_)), source_customer_, tree_uid_, entity_context_uid_, LOCAL), source_customer_, tree_uid_, entity_context_uid_, LOCAL);

TreeToEntity := DISTRIBUTE(
                FullTreePrep//DISTRIBUTE(FullTreePrep, HASH32(source_customer_, treeuid, entity_context_uid_)), source_customer_, tree_uid_, entity_context_uid_, LOCAL), source_customer_, tree_uid_, entity_context_uid_, LOCAL);
                , HASH32(source_customer_, entity_context_uid_));  

EntityToTree := DISTRIBUTE(
                 PROJECT(FullTreePrep(tree_uid_ != '_011'), TRANSFORM(RECORDOF(LEFT), 
                  // Reverse the non-person associations, this allows to expand from elements (addresses etc..) to people
                  SELF.tree_uid_ := MAP(LEFT.tree_uid_[2..3] != '01' => LEFT.entity_context_uid_, LEFT.tree_uid_),
                  SELF.entity_context_uid_ := MAP(LEFT.tree_uid_[2..3] != '01' => LEFT.tree_uid_, LEFT.entity_context_uid_),
                  SELF := LEFT))
                 , HASH32(source_customer_, tree_uid_))(entity_context_uid_ != ''); // blank entity context uids are coming from somewhere incorrectly.
								 
// This join specifically expands the existing non-people entities to pull in connected people.
FullPersonTreeEntities1 := JOIN(TreeToEntity, EntityToTree,
                            LEFT.source_customer_=RIGHT.source_customer_ AND LEFT.entity_context_uid_=RIGHT.tree_uid_,
                            TRANSFORM(
                              RECORDOF(LEFT), 
                              SELF.tree_uid_ := LEFT.tree_uid_,
                              SELF.entity_context_uid_ := RIGHT.entity_context_uid_, //RIGHT.tree_uid_,
                              SELF := LEFT), LOCAL/*, KEEP(1000)*/);

FullTreeEntities := DEDUP(SORT(DISTRIBUTE(EntityToTree + FullPersonTreeEntities1 + TreeToEntity, HASH32(entity_context_uid_)), source_customer_, tree_uid_, entity_context_uid_, LOCAL), source_customer_, tree_uid_, entity_context_uid_, LOCAL);

/*
GRAPH PREP 
 Append the Entity Details for the entities in the tree.

*/

/* Consolidate the address child entities into the same child dataset as the person child entities
   TODO Add the other element types here into the same childset.
          ONLY PEOPLE draw edges/links to the other entity types.
          Exclude the addition links childdataset whilst consolidating them into a single dataset.
*/          
ConsolidatedPersonEntities := PROJECT(KELOtto.Q__show_Customer_Person_Entities.Res0, TRANSFORM({RECORDOF(LEFT) AND NOT [exp2_,__exp2__flags,exp3_,__exp3__flags,exp4_,__exp4__flags,exp5_,__exp5__flags,exp6_,__exp6__flags,exp7_,__exp7__flags,exp8_,__exp8__flags]}, 
                          SELF.exp1_ := /*LEFT.exp1_ + */LEFT.exp2_ + LEFT.exp3_ + LEFT.exp4_ + LEFT.exp5_ + LEFT.exp6_ + LEFT.exp7_ + LEFT.exp8_, SELF := LEFT));


// IDENTITY Entity DETAILS Join the entity details to the trees (labels, flags etc..)
FullGraphPrep1 := JOIN(DISTRIBUTE(FullTreeEntities, HASH32(entity_context_uid_)), DISTRIBUTE(ConsolidatedPersonEntities, HASH32(entity_context_uid_)), 
                        LEFT.source_customer_=RIGHT.source_customer_ AND LEFT.entity_context_uid_=RIGHT.entity_context_uid_, 
                           LEFT OUTER, LOCAL);

// ADDRESS Entity DETAILS                           
FullGraphPrep2 := JOIN(FullGraphPrep1, DISTRIBUTE(KELOtto.Q__show_Customer_Address_Entities.Res0, HASH32(entity_context_uid_)), 
                        LEFT.source_customer_=RIGHT.source_customer_ AND LEFT.entity_context_uid_=RIGHT.entity_context_uid_,
                        TRANSFORM({RECORDOF(LEFT), RECORDOF(RIGHT)}, 
                          SELF.Label_ := MAP(RIGHT.Label_ != '' => RIGHT.Label_, LEFT.Label_), 
                          SELF.Entity_Type_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.Entity_Type_, LEFT.Entity_Type_), 
                          SELF.person_count_ :=RIGHT.person_count_, 
                          SELF.high_frequency_flag_ := RIGHT.high_frequency_flag_,
                          SELF.score_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.Score_, LEFT.score_),
                          SELF.cluster_score_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cluster_Score_, LEFT.cluster_score_),
                          //SELF.high_risk_death_prior_to_all_events_percent_flag_ := LEFT.high_risk_death_prior_to_all_events_percent_flag_,
                   //       SELF.all_high_risk_death_prior_to_all_events_person_percent_flag_ := RIGHT.all_high_risk_death_prior_to_all_events_person_percent_flag_,

                          SELF.latitude_ := RIGHT.latitude_,
                          SELF.longitude_ := RIGHT.longitude_,
                          SELF.Street_Address_ := RIGHT.Street_Address_,
                          SELF.Vanity_City_ := RIGHT.Vanity_City_,
                          SELF.State_ := RIGHT.State_,
                          SELF.Zip_ := RIGHT.Zip_,
													
                          SELF.In_Customer_Population_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.In_Customer_Population_ , LEFT.In_Customer_Population_),
                          SELF.contributor_safe_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.contributor_safe_flag_ , LEFT.contributor_safe_flag_),
                          SELF.safe_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.safe_flag_ , LEFT.safe_flag_),

                          
                          SELF.cl_event_count_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_event_count_ , LEFT.cl_event_count_),
                          SELF.cl_identity_count_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_identity_count_ , LEFT.cl_identity_count_),
                          SELF.cl_element_count_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_element_count_ , LEFT.cl_element_count_),
                          SELF.cl_identity_count_percentile_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_identity_count_percentile_ , LEFT.cl_identity_count_percentile_),
                          SELF.cl_event_count_percentile_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_event_count_percentile_ , LEFT.cl_event_count_percentile_),
                          SELF.cl_impact_weight_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_impact_weight_ , LEFT.cl_impact_weight_),
                          SELF.cl_high_risk_pattern1_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_high_risk_pattern1_flag_ , LEFT.cl_high_risk_pattern1_flag_),
                          SELF.cl_high_risk_pattern2_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_high_risk_pattern2_flag_ , LEFT.cl_high_risk_pattern2_flag_),
                          SELF.cl_high_risk_pattern3_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_high_risk_pattern3_flag_ , LEFT.cl_high_risk_pattern3_flag_),
                          SELF.cl_high_risk_pattern4_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_high_risk_pattern4_flag_ , LEFT.cl_high_risk_pattern4_flag_),
                          SELF.cl_high_risk_pattern5_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_high_risk_pattern5_flag_ , LEFT.cl_high_risk_pattern5_flag_),
                          SELF.kr_high_risk_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.kr_high_risk_flag_ , LEFT.kr_high_risk_flag_),
                          SELF.kr_medium_risk_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.kr_medium_risk_flag_ , LEFT.kr_medium_risk_flag_),
													
													SELF.dt_first_seen_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.dt_first_seen_, LEFT.dt_first_seen_),
													SELF.dt_last_seen_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.dt_last_seen_, LEFT.dt_last_seen_),
                          SELF.deceased_match_ := LEFT.deceased_match_,
                          SELF.death_prior_to_all_events_ := LEFT.death_prior_to_all_events_,
                       //   SELF.nas9_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.nas9_flag_ , LEFT.nas9_flag_),
                       //   SELF.nap3_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.nap3_flag_ , LEFT.nap3_flag_)
     
                          SELF := LEFT,
                          SELF := RIGHT

                          ),
                            LEFT OUTER, LOCAL);
				
// SSN Entity DETAILS                           
FullGraphPrep3 := JOIN(FullGraphPrep2, DISTRIBUTE(KELOtto.Q__show_Customer_Ssn_Entities.Res0, HASH32(entity_context_uid_)), 
                        LEFT.source_customer_=RIGHT.source_customer_ AND LEFT.entity_context_uid_=RIGHT.entity_context_uid_,
                        TRANSFORM({RECORDOF(LEFT), RECORDOF(RIGHT)}, 
                          SELF.Label_ := MAP(RIGHT.Label_ != '' => RIGHT.Label_, LEFT.Label_), 
                          SELF.Entity_Type_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.Entity_Type_, LEFT.Entity_Type_), 
                          SELF.person_count_ :=RIGHT.person_count_, 
                          SELF.score_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.Score_, LEFT.score_),
                          SELF.cluster_score_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cluster_Score_, LEFT.cluster_score_),
                     //     SELF.high_risk_death_prior_to_all_events_percent_flag_ := RIGHT.high_risk_death_prior_to_all_events_percent_flag_,
                   //       SELF.all_high_risk_death_prior_to_all_events_person_percent_flag_ := RIGHT.all_high_risk_death_prior_to_all_events_person_percent_flag_,

                          SELF.cl_event_count_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_event_count_ , LEFT.cl_event_count_),
                          SELF.cl_identity_count_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_identity_count_ , LEFT.cl_identity_count_),
                          SELF.cl_element_count_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_element_count_ , LEFT.cl_element_count_),
                          SELF.cl_identity_count_percentile_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_identity_count_percentile_ , LEFT.cl_identity_count_percentile_),
                          SELF.cl_event_count_percentile_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_event_count_percentile_ , LEFT.cl_event_count_percentile_),
                          SELF.cl_impact_weight_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_impact_weight_ , LEFT.cl_impact_weight_),

                          SELF.In_Customer_Population_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.In_Customer_Population_ , LEFT.In_Customer_Population_),
                          SELF.contributor_safe_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.contributor_safe_flag_ , LEFT.contributor_safe_flag_),
                          SELF.safe_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.safe_flag_ , LEFT.safe_flag_),

													SELF.dt_first_seen_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.dt_first_seen_, LEFT.dt_first_seen_),
													SELF.dt_last_seen_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.dt_last_seen_, LEFT.dt_last_seen_),
													
                       //   SELF.cl_high_risk_pattern1_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_high_risk_pattern1_flag_ , LEFT.cl_high_risk_pattern1_flag_),
                       //   SELF.cl_high_risk_pattern2_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_high_risk_pattern2_flag_ , LEFT.cl_high_risk_pattern2_flag_),
                       //   SELF.cl_high_risk_pattern3_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_high_risk_pattern3_flag_ , LEFT.cl_high_risk_pattern3_flag_),
                       //   SELF.cl_high_risk_pattern4_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_high_risk_pattern4_flag_ , LEFT.cl_high_risk_pattern4_flag_),
                       //   SELF.cl_high_risk_pattern5_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_high_risk_pattern5_flag_ , LEFT.cl_high_risk_pattern5_flag_),
                       //   SELF.kr_high_risk_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.kr_high_risk_flag_ , LEFT.kr_high_risk_flag_),
                       //   SELF.kr_medium_risk_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.kr_medium_risk_flag_ , LEFT.kr_medium_risk_flag_),
                          SELF.deceased_match_ := LEFT.deceased_match_,
                          SELF.death_prior_to_all_events_ := LEFT.death_prior_to_all_events_,
                       //   SELF.nas9_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.nas9_flag_ , LEFT.nas9_flag_),
                       //   SELF.nap3_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.nap3_flag_ , LEFT.nap3_flag_)
     
                          SELF := LEFT,
                          SELF := RIGHT

                          ),
                            LEFT OUTER, LOCAL);
				
		
// IP DETAILS                           
FullGraphPrep4 := JOIN(FullGraphPrep3, DISTRIBUTE(KELOtto.Q__show_Customer_Ip_Address_Entities.Res0, HASH32(entity_context_uid_)), 
                        LEFT.source_customer_=RIGHT.source_customer_ AND LEFT.entity_context_uid_=RIGHT.entity_context_uid_,
                        TRANSFORM({RECORDOF(LEFT), RECORDOF(RIGHT)}, 
                          SELF.Label_ := MAP(RIGHT.Label_ != '' => RIGHT.Label_, LEFT.Label_), 
                          SELF.Entity_Type_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.Entity_Type_, LEFT.Entity_Type_), 
                          SELF.person_count_ :=RIGHT.person_count_, 
                          SELF.score_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.Score_, LEFT.score_),
                          SELF.cluster_score_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cluster_Score_, LEFT.cluster_score_),
                     //     SELF.high_risk_death_prior_to_all_events_percent_flag_ := RIGHT.high_risk_death_prior_to_all_events_percent_flag_,
                   //       SELF.all_high_risk_death_prior_to_all_events_person_percent_flag_ := RIGHT.all_high_risk_death_prior_to_all_events_person_percent_flag_,

                          SELF.cl_event_count_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_event_count_ , LEFT.cl_event_count_),
                          SELF.cl_identity_count_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_identity_count_ , LEFT.cl_identity_count_),
                          SELF.cl_element_count_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_element_count_ , LEFT.cl_element_count_),
                          SELF.cl_identity_count_percentile_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_identity_count_percentile_ , LEFT.cl_identity_count_percentile_),
                          SELF.cl_event_count_percentile_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_event_count_percentile_ , LEFT.cl_event_count_percentile_),
                          SELF.cl_impact_weight_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_impact_weight_ , LEFT.cl_impact_weight_),

                          SELF.In_Customer_Population_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.In_Customer_Population_ , LEFT.In_Customer_Population_),
                          SELF.contributor_safe_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.contributor_safe_flag_ , LEFT.contributor_safe_flag_),
                          SELF.safe_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.safe_flag_ , LEFT.safe_flag_),

													SELF.dt_first_seen_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.dt_first_seen_, LEFT.dt_first_seen_),
													SELF.dt_last_seen_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.dt_last_seen_, LEFT.dt_last_seen_),
													
                       //   SELF.cl_high_risk_pattern1_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_high_risk_pattern1_flag_ , LEFT.cl_high_risk_pattern1_flag_),
                       //   SELF.cl_high_risk_pattern2_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_high_risk_pattern2_flag_ , LEFT.cl_high_risk_pattern2_flag_),
                       //   SELF.cl_high_risk_pattern3_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_high_risk_pattern3_flag_ , LEFT.cl_high_risk_pattern3_flag_),
                       //   SELF.cl_high_risk_pattern4_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_high_risk_pattern4_flag_ , LEFT.cl_high_risk_pattern4_flag_),
                       //   SELF.cl_high_risk_pattern5_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_high_risk_pattern5_flag_ , LEFT.cl_high_risk_pattern5_flag_),
                       //   SELF.kr_high_risk_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.kr_high_risk_flag_ , LEFT.kr_high_risk_flag_),
                       //   SELF.kr_medium_risk_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.kr_medium_risk_flag_ , LEFT.kr_medium_risk_flag_),
                          SELF.deceased_match_ := LEFT.deceased_match_,
                          SELF.death_prior_to_all_events_ := LEFT.death_prior_to_all_events_,
                       //   SELF.nas9_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.nas9_flag_ , LEFT.nas9_flag_),
                       //   SELF.nap3_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.nap3_flag_ , LEFT.nap3_flag_)
     
                          SELF := LEFT,
                          SELF := RIGHT

                          ),
                            LEFT OUTER, LOCAL);		
				
				
// PHONE DETAILS                           
FullGraphPrep5 := JOIN(FullGraphPrep4, DISTRIBUTE(KELOtto.Q__show_Customer_Phone_Entities.Res0, HASH32(entity_context_uid_)), 
                        LEFT.source_customer_=RIGHT.source_customer_ AND LEFT.entity_context_uid_=RIGHT.entity_context_uid_,
                        TRANSFORM({RECORDOF(LEFT), RECORDOF(RIGHT)}, 
                          SELF.Label_ := MAP(RIGHT.Label_ != '' => RIGHT.Label_, LEFT.Label_), 
                          SELF.Entity_Type_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.Entity_Type_, LEFT.Entity_Type_), 
                          SELF.person_count_ :=RIGHT.person_count_, 
                          SELF.score_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.Score_, LEFT.score_),
                          SELF.cluster_score_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cluster_Score_, LEFT.cluster_score_),
                     //     SELF.high_risk_death_prior_to_all_events_percent_flag_ := RIGHT.high_risk_death_prior_to_all_events_percent_flag_,
                   //       SELF.all_high_risk_death_prior_to_all_events_person_percent_flag_ := RIGHT.all_high_risk_death_prior_to_all_events_person_percent_flag_,

                          SELF.cl_event_count_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_event_count_ , LEFT.cl_event_count_),
                          SELF.cl_identity_count_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_identity_count_ , LEFT.cl_identity_count_),
                          SELF.cl_element_count_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_element_count_ , LEFT.cl_element_count_),
                          SELF.cl_identity_count_percentile_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_identity_count_percentile_ , LEFT.cl_identity_count_percentile_),
                          SELF.cl_event_count_percentile_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_event_count_percentile_ , LEFT.cl_event_count_percentile_),
                          SELF.cl_impact_weight_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_impact_weight_ , LEFT.cl_impact_weight_),
													
                          SELF.In_Customer_Population_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.In_Customer_Population_ , LEFT.In_Customer_Population_),
                          SELF.contributor_safe_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.contributor_safe_flag_ , LEFT.contributor_safe_flag_),
                          SELF.safe_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.safe_flag_ , LEFT.safe_flag_),

													SELF.dt_first_seen_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.dt_first_seen_, LEFT.dt_first_seen_),
													SELF.dt_last_seen_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.dt_last_seen_, LEFT.dt_last_seen_),

                       //   SELF.cl_high_risk_pattern1_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_high_risk_pattern1_flag_ , LEFT.cl_high_risk_pattern1_flag_),
                       //   SELF.cl_high_risk_pattern2_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_high_risk_pattern2_flag_ , LEFT.cl_high_risk_pattern2_flag_),
                       //   SELF.cl_high_risk_pattern3_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_high_risk_pattern3_flag_ , LEFT.cl_high_risk_pattern3_flag_),
                       //   SELF.cl_high_risk_pattern4_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_high_risk_pattern4_flag_ , LEFT.cl_high_risk_pattern4_flag_),
                       //   SELF.cl_high_risk_pattern5_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_high_risk_pattern5_flag_ , LEFT.cl_high_risk_pattern5_flag_),
                       //   SELF.kr_high_risk_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.kr_high_risk_flag_ , LEFT.kr_high_risk_flag_),
                       //   SELF.kr_medium_risk_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.kr_medium_risk_flag_ , LEFT.kr_medium_risk_flag_),
                          SELF.deceased_match_ := LEFT.deceased_match_,
                          SELF.death_prior_to_all_events_ := LEFT.death_prior_to_all_events_,
                       //   SELF.nas9_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.nas9_flag_ , LEFT.nas9_flag_),
                       //   SELF.nap3_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.nap3_flag_ , LEFT.nap3_flag_)
     
                          SELF := LEFT,
                          SELF := RIGHT

                          ),
                            LEFT OUTER, LOCAL);														

// Email DETAILS                           
FullGraphPrep6 := JOIN(FullGraphPrep5, DISTRIBUTE(KELOtto.Q__show_Customer_Email_Entities.Res0, HASH32(entity_context_uid_)), 
                        LEFT.source_customer_=RIGHT.source_customer_ AND LEFT.entity_context_uid_=RIGHT.entity_context_uid_,
                        TRANSFORM({RECORDOF(LEFT), RECORDOF(RIGHT)}, 
                          SELF.Label_ := MAP(RIGHT.Label_ != '' => RIGHT.Label_, LEFT.Label_), 
                          SELF.Entity_Type_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.Entity_Type_, LEFT.Entity_Type_), 
                          SELF.person_count_ :=RIGHT.person_count_, 
                          SELF.score_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.Score_, LEFT.score_),
                          SELF.cluster_score_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cluster_Score_, LEFT.cluster_score_),
                     //     SELF.high_risk_death_prior_to_all_events_percent_flag_ := RIGHT.high_risk_death_prior_to_all_events_percent_flag_,
                   //       SELF.all_high_risk_death_prior_to_all_events_person_percent_flag_ := RIGHT.all_high_risk_death_prior_to_all_events_person_percent_flag_,

                          SELF.cl_event_count_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_event_count_ , LEFT.cl_event_count_),
                          SELF.cl_identity_count_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_identity_count_ , LEFT.cl_identity_count_),
                          SELF.cl_element_count_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_element_count_ , LEFT.cl_element_count_),
                          SELF.cl_identity_count_percentile_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_identity_count_percentile_ , LEFT.cl_identity_count_percentile_),
                          SELF.cl_event_count_percentile_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_event_count_percentile_ , LEFT.cl_event_count_percentile_),
                          SELF.cl_impact_weight_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_impact_weight_ , LEFT.cl_impact_weight_),

                          SELF.In_Customer_Population_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.In_Customer_Population_ , LEFT.In_Customer_Population_),
                          SELF.contributor_safe_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.contributor_safe_flag_ , LEFT.contributor_safe_flag_),
                          SELF.safe_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.safe_flag_ , LEFT.safe_flag_),

													SELF.dt_first_seen_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.dt_first_seen_, LEFT.dt_first_seen_),
													SELF.dt_last_seen_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.dt_last_seen_, LEFT.dt_last_seen_),
													
                       //   SELF.cl_high_risk_pattern1_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_high_risk_pattern1_flag_ , LEFT.cl_high_risk_pattern1_flag_),
                       //   SELF.cl_high_risk_pattern2_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_high_risk_pattern2_flag_ , LEFT.cl_high_risk_pattern2_flag_),
                       //   SELF.cl_high_risk_pattern3_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_high_risk_pattern3_flag_ , LEFT.cl_high_risk_pattern3_flag_),
                       //   SELF.cl_high_risk_pattern4_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_high_risk_pattern4_flag_ , LEFT.cl_high_risk_pattern4_flag_),
                       //   SELF.cl_high_risk_pattern5_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_high_risk_pattern5_flag_ , LEFT.cl_high_risk_pattern5_flag_),
                       //   SELF.kr_high_risk_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.kr_high_risk_flag_ , LEFT.kr_high_risk_flag_),
                       //   SELF.kr_medium_risk_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.kr_medium_risk_flag_ , LEFT.kr_medium_risk_flag_),
                          SELF.deceased_match_ := LEFT.deceased_match_,
                          SELF.death_prior_to_all_events_ := LEFT.death_prior_to_all_events_,
                       //   SELF.nas9_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.nas9_flag_ , LEFT.nas9_flag_),
                       //   SELF.nap3_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.nap3_flag_ , LEFT.nap3_flag_)
     
                          SELF := LEFT,
                          SELF := RIGHT

                          ),
                            LEFT OUTER, LOCAL);	
                            
// Bank Account DETAILS                           
FullGraphPrep7 := JOIN(FullGraphPrep6, DISTRIBUTE(KELOtto.Q__show_Customer_Bank_Account_Entities.Res0, HASH32(entity_context_uid_)), 
                        LEFT.source_customer_=RIGHT.source_customer_ AND LEFT.entity_context_uid_=RIGHT.entity_context_uid_,
                        TRANSFORM({RECORDOF(LEFT), RECORDOF(RIGHT)}, 
                          SELF.Label_ := MAP(RIGHT.Label_ != '' => RIGHT.Label_, LEFT.Label_), 
                          SELF.Entity_Type_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.Entity_Type_, LEFT.Entity_Type_), 
                          SELF.person_count_ :=RIGHT.person_count_, 
                          SELF.score_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.Score_, LEFT.score_),
                          SELF.cluster_score_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cluster_Score_, LEFT.cluster_score_),
                     //     SELF.high_risk_death_prior_to_all_events_percent_flag_ := RIGHT.high_risk_death_prior_to_all_events_percent_flag_,
                   //       SELF.all_high_risk_death_prior_to_all_events_person_percent_flag_ := RIGHT.all_high_risk_death_prior_to_all_events_person_percent_flag_,

                          SELF.cl_event_count_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_event_count_ , LEFT.cl_event_count_),
                          SELF.cl_identity_count_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_identity_count_ , LEFT.cl_identity_count_),
                          SELF.cl_element_count_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_element_count_ , LEFT.cl_element_count_),
                          SELF.cl_identity_count_percentile_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_identity_count_percentile_ , LEFT.cl_identity_count_percentile_),
                          SELF.cl_event_count_percentile_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_event_count_percentile_ , LEFT.cl_event_count_percentile_),
                          SELF.cl_impact_weight_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_impact_weight_ , LEFT.cl_impact_weight_),

                          SELF.In_Customer_Population_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.In_Customer_Population_ , LEFT.In_Customer_Population_),
                          SELF.contributor_safe_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.contributor_safe_flag_ , LEFT.contributor_safe_flag_),
                          SELF.safe_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.safe_flag_ , LEFT.safe_flag_),

													SELF.dt_first_seen_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.dt_first_seen_, LEFT.dt_first_seen_),
													SELF.dt_last_seen_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.dt_last_seen_, LEFT.dt_last_seen_),
													
                       //   SELF.cl_high_risk_pattern1_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_high_risk_pattern1_flag_ , LEFT.cl_high_risk_pattern1_flag_),
                       //   SELF.cl_high_risk_pattern2_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_high_risk_pattern2_flag_ , LEFT.cl_high_risk_pattern2_flag_),
                       //   SELF.cl_high_risk_pattern3_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_high_risk_pattern3_flag_ , LEFT.cl_high_risk_pattern3_flag_),
                       //   SELF.cl_high_risk_pattern4_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_high_risk_pattern4_flag_ , LEFT.cl_high_risk_pattern4_flag_),
                       //   SELF.cl_high_risk_pattern5_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_high_risk_pattern5_flag_ , LEFT.cl_high_risk_pattern5_flag_),
                          SELF.kr_high_risk_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.kr_high_risk_flag_ , LEFT.kr_high_risk_flag_),
                          SELF.kr_medium_risk_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.kr_medium_risk_flag_ , LEFT.kr_medium_risk_flag_),
                       //   SELF.kr_low_risk_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.kr_low_risk_flag_ , LEFT.kr_low_risk_flag_),
                          SELF.deceased_match_ := LEFT.deceased_match_,
                          SELF.death_prior_to_all_events_ := LEFT.death_prior_to_all_events_,
                       //   SELF.nas9_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.nas9_flag_ , LEFT.nas9_flag_),
                       //   SELF.nap3_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.nap3_flag_ , LEFT.nap3_flag_)
     
                          SELF := LEFT,
                          SELF := RIGHT

                          ),
                            LEFT OUTER, LOCAL);	

// Drivers License DETAILS                           
FullGraphPrep8_1 := JOIN(FullGraphPrep7, DISTRIBUTE(KELOtto.Q__show_Customer_Drivers_License_Entities.Res0, HASH32(entity_context_uid_)), 
                        LEFT.source_customer_=RIGHT.source_customer_ AND LEFT.entity_context_uid_=RIGHT.entity_context_uid_,
                        TRANSFORM({RECORDOF(LEFT), RECORDOF(RIGHT)}, 
                          SELF.Label_ := MAP(RIGHT.Label_ != '' => RIGHT.Label_, LEFT.Label_), 
                          SELF.Entity_Type_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.Entity_Type_, LEFT.Entity_Type_), 
                          SELF.person_count_ :=RIGHT.person_count_, 
                          SELF.score_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.Score_, LEFT.score_),
                          SELF.cluster_score_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cluster_Score_, LEFT.cluster_score_),
                     //     SELF.high_risk_death_prior_to_all_events_percent_flag_ := RIGHT.high_risk_death_prior_to_all_events_percent_flag_,
                   //       SELF.all_high_risk_death_prior_to_all_events_person_percent_flag_ := RIGHT.all_high_risk_death_prior_to_all_events_person_percent_flag_,

                          SELF.cl_event_count_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_event_count_ , LEFT.cl_event_count_),
                          SELF.cl_identity_count_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_identity_count_ , LEFT.cl_identity_count_),
                          SELF.cl_element_count_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_element_count_ , LEFT.cl_element_count_),
                          SELF.cl_identity_count_percentile_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_identity_count_percentile_ , LEFT.cl_identity_count_percentile_),
                          SELF.cl_event_count_percentile_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_event_count_percentile_ , LEFT.cl_event_count_percentile_),
                          SELF.cl_impact_weight_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_impact_weight_ , LEFT.cl_impact_weight_),

                          SELF.In_Customer_Population_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.In_Customer_Population_ , LEFT.In_Customer_Population_),
                          SELF.contributor_safe_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.contributor_safe_flag_ , LEFT.contributor_safe_flag_),
                          SELF.safe_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.safe_flag_ , LEFT.safe_flag_),

													SELF.dt_first_seen_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.dt_first_seen_, LEFT.dt_first_seen_),
													SELF.dt_last_seen_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.dt_last_seen_, LEFT.dt_last_seen_),
													
                       //   SELF.cl_high_risk_pattern1_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_high_risk_pattern1_flag_ , LEFT.cl_high_risk_pattern1_flag_),
                       //   SELF.cl_high_risk_pattern2_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_high_risk_pattern2_flag_ , LEFT.cl_high_risk_pattern2_flag_),
                       //   SELF.cl_high_risk_pattern3_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_high_risk_pattern3_flag_ , LEFT.cl_high_risk_pattern3_flag_),
                       //   SELF.cl_high_risk_pattern4_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_high_risk_pattern4_flag_ , LEFT.cl_high_risk_pattern4_flag_),
                       //   SELF.cl_high_risk_pattern5_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.cl_high_risk_pattern5_flag_ , LEFT.cl_high_risk_pattern5_flag_),
                          SELF.kr_high_risk_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.kr_high_risk_flag_ , LEFT.kr_high_risk_flag_),
                          SELF.kr_medium_risk_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.kr_medium_risk_flag_ , LEFT.kr_medium_risk_flag_),
                          SELF.kr_low_risk_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.kr_low_risk_flag_ , LEFT.kr_low_risk_flag_),

                          SELF.deceased_match_ := LEFT.deceased_match_,
                          SELF.death_prior_to_all_events_ := LEFT.death_prior_to_all_events_,
                       //   SELF.nas9_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.nas9_flag_ , LEFT.nas9_flag_),
                       //   SELF.nap3_flag_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.nap3_flag_ , LEFT.nap3_flag_)
     
                          SELF := LEFT,
                          SELF := RIGHT

                          ),
                            LEFT OUTER, LOCAL);	
                  
temprec := RECORDOF(FullGraphPrep8_1) AND NOT [kr_low_risk_flag_]; 
                 
FullGraphPrep8 := PROJECT(FullGraphPrep8_1, TRANSFORM(temprec, SELF := LEFT));
/* HACK to get the Element Count per tree in and deceased persons.... will need to be removed once it is computed in KEL */
// Per Tree Compute how many non-Identity elements 
ElementCountAggregation := DISTRIBUTE(TABLE(FullGraphPrep8, {source_customer_, tree_uid_, UNSIGNED cl_element_count_ := COUNT(GROUP), UNSIGNED cl_deceased_count_ := SUM(GROUP, deceased_match_)}, source_customer_, tree_uid_, MERGE), HASH32(tree_uid_)); 

// Join the element count back to each entity within all the trees.
FullGraphElementCount1 := JOIN(FullGraphPrep8, ElementCountAggregation, LEFT.source_customer_ = RIGHT.source_customer_ AND LEFT.entity_context_uid_ = RIGHT.tree_uid_, TRANSFORM({RECORDOF(LEFT), UNSIGNED cl_deceased_count_}, SELF.cl_element_count_ := RIGHT.cl_element_count_, SELF.cl_deceased_count_ := RIGHT.cl_deceased_count_, SELF := LEFT), LEFT OUTER, LOCAL);

FullGraphElementCount := JOIN(FullGraphElementCount1, AdditionalAttributes, LEFT.customer_id_ = RIGHT.customer_id_ AND LEFT.industry_type_ = RIGHT.industry_type_ AND LEFT.entity_context_uid_ = RIGHT.entity_context_uid_, 
   TRANSFORM({
               RECORDOF(LEFT),
               RIGHT.event_count_,
               RIGHT.identity_count_,
							 RIGHT.cl_adjacent_safe_flag_
             },
              SELF.event_count_ := RIGHT.event_count_, 
							SELF.identity_count_ := RIGHT.identity_count_, 
							SELF.cl_adjacent_safe_flag_ := RIGHT.cl_adjacent_safe_flag_, 
							SELF := LEFT), LEFT OUTER, HASH) : PERSIST('~fraudgov::deleteme101');

EXPORT FullGraph := FullGraphElementCount;
