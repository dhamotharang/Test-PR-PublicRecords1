import KELOtto;



/*
GRAPH PREP 
 Person Trees

*/

PersonTreeEntities1 := DISTRIBUTE(KELOtto.Q__show_Customer_Person_Tree_Entities.Res0, HASH32(source_customer_, tree_uid_));
PersonTreeEntities2 := JOIN(PersonTreeEntities1, PersonTreeEntities1, LEFT.source_customer_=RIGHT.source_customer_ AND LEFT.entity_context_uid_=RIGHT.tree_uid_, 
                            TRANSFORM({RECORDOF(LEFT)}, 
                              SELF.source_customer_ := LEFT.source_customer_, SELF.tree_uid_ := LEFT.tree_uid_,
                              SELF.entity_context_uid_ := RIGHT.entity_context_uid_,
                              SELF := RIGHT), HASH);

// These are the Person Tree -> Person Entities within that tree                            
PersonTreeEntities := DEDUP(SORT(DISTRIBUTE(PersonTreeEntities2, HASH32(tree_uid_)), source_customer_, tree_uid_, entity_context_uid_, LOCAL), source_customer_, tree_uid_, entity_context_uid_, LOCAL);

// Address Entities that are connected to any of the Persons within the Person Trees.
PersonAddressTreeEntities := DEDUP(SORT(JOIN(PersonTreeEntities, KELOtto.Q__show_Customer_Person_Address_Tree_Entities.Res0, 
                              LEFT.source_customer_ = RIGHT.source_customer_ AND 
                              LEFT.entity_context_uid_ = RIGHT.tree_uid_, 
                              TRANSFORM(RECORDOF(RIGHT), 
                                SELF.tree_uid_ := LEFT.tree_uid_,
                                SELF := RIGHT), HASH), tree_uid_, entity_context_uid_), tree_uid_, entity_context_uid_);
// Add the Address flags                                
/*
PersonAddressTreeEntities := JOIN(PersonAddressTreeEntitiesPrep1, KELOtto.Q__show_Customer_Address_Entities.Res0,
                              LEFT.entity_context_uid_ = RIGHT.entity_context_uid_ AND 
                              LEFT.source_customer_ = RIGHT.source_customer_,
                              TRANSFORM({RECORDOF(LEFT),RECORDOF(RIGHT)},
                                SELF.tree_uid_ := LEFT.tree_uid_,
                                SELF := RIGHT, 
                                SELF := LEFT), HASH);
*/
                                
FullPersonTreeEntities := PersonTreeEntities + PersonAddressTreeEntities;// + KELOtto.Q__show_Customer_Person_Address_Tree_Entities.Res0;

AddressTreeEntitiesPrep1 := KELOtto.Q__show_Customer_Address_Person_Tree_Entities.Res0;
// include the address itself as an entity within its own tree.
AddressTreeEntitiesPrep2 := PROJECT(
                              DEDUP(SORT(KELOtto.Q__show_Customer_Address_Person_Tree_Entities.Res0, source_customer_, tree_uid_), source_customer_, tree_uid_), 
                              TRANSFORM(RECORDOF(LEFT), SELF.entity_context_uid_ := LEFT.tree_uid_, SELF := LEFT));

AddressTreeEntities := AddressTreeEntitiesPrep1 + AddressTreeEntitiesPrep2;
                                
FullTreeEntities := FullPersonTreeEntities + AddressTreeEntities;

/*
GRAPH PREP 
 Append the Entity Details for the entities in the tree.

*/

// Consolidate the address child entities into the same child dataset as the person child entities
ConsolidatedPersonEntities := PROJECT(KELOtto.Q__show_Customer_Person_Entities.Res0, TRANSFORM({RECORDOF(LEFT) AND NOT [exp2_,__exp2__flags]}, SELF.exp1_ := LEFT.exp1_ + LEFT.exp2_, SELF := LEFT));


// Join the entity details to the trees (labels, flags etc..)
FullGraphPrep1 := JOIN(FullTreeEntities, ConsolidatedPersonEntities, 
                        LEFT.source_customer_=RIGHT.source_customer_ AND LEFT.entity_context_uid_=RIGHT.entity_context_uid_, 
                           LEFT OUTER, HASH);
                           
FullGraphPrep2 := JOIN(FullGraphPrep1, KELOtto.Q__show_Customer_Address_Entities.Res0, 
                        LEFT.source_customer_=RIGHT.source_customer_ AND LEFT.entity_context_uid_=RIGHT.entity_context_uid_,
                        TRANSFORM({RECORDOF(LEFT), RECORDOF(RIGHT)}, 
                          SELF.Label_ := MAP(RIGHT.Label_ != '' => RIGHT.Label_, LEFT.Label_), 
                          SELF.Entity_Type_ := MAP(RIGHT.Entity_Type_ != 0 => RIGHT.Entity_Type_, LEFT.Entity_Type_), 
                          SELF.person_count_ := RIGHT.person_count_,
                          SELF.high_frequency_flag_ := RIGHT.high_frequency_flag_,
                          SELF.score_ := MAP(LEFT.Score_ > 0 => LEFT.Score_, RIGHT.score_),
                          SELF.cluster_score_ := MAP(LEFT.cluster_Score_ > 0 => LEFT.cluster_Score_, RIGHT.cluster_score_),
                     //     SELF.high_risk_death_prior_to_all_events_percent_flag_ := RIGHT.high_risk_death_prior_to_all_events_percent_flag_,
                   //       SELF.all_high_risk_death_prior_to_all_events_person_percent_flag_ := RIGHT.all_high_risk_death_prior_to_all_events_person_percent_flag_,
                          SELF.latitude_ := RIGHT.latitude_,
                          SELF.longitude_ := RIGHT.longitude_,
                          SELF := LEFT, SELF := []),
                            LEFT OUTER, HASH);
														
// Flag/Indicator Child dataset.

FlagsRec := RECORD
  STRING Indicator;
	STRING Value;
END;

FinalRec := RECORD
 RECORDOF(FullGraphPrep2);
 DATASET(FlagsRec) Flags;
END;

FullGraphPrep3 := PROJECT(FullGraphPrep2, 
                    TRANSFORM(FinalRec, 
										           SELF.Flags := DATASET([
															                        {'high_frequency_flag_', (STRING)LEFT.high_frequency_flag_},
																											{'score_', (STRING)LEFT.Score_},
																											{'cluster_score_', (STRING)LEFT.Cluster_Score_},
																											{'all_high_risk_death_prior_to_all_events_person_percent_flag_', (STRING)LEFT.all_high_risk_death_prior_to_all_events_person_percent_flag_}], FlagsRec);
															 SELF := LEFT));
															 														

EXPORT FullGraph := FullGraphPrep3;