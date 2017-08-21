import Data_Services;
export Sample_QA := module

//Diff Person cluster

Key_PC_QA := pull(SNA.Key_Person_Cluster);
key_PC_father := INDEX(SNA.File_Person_Cluster,{cluster_id}, {degree, associated_did}, Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::sna::person_cluster_father');

key_PC_father_pull := pull(key_PC_father);

Key_PC_QA trecs(Key_PC_QA L, key_PC_father_pull R) := transform
self := L;
end;

jrecs := join(distribute(Key_PC_QA,HASH(cluster_id)),distribute(key_PC_father_pull,HASH(cluster_id)),LEFT.cluster_id=RIGHT.cluster_id,trecs(LEFT,RIGHT),LEFT ONLY,LOCAL);

pcsample := output(choosen(jrecs,500),named('Person_Cluster_Sample'));

//Diff Person cluster Attributes

Key_PCAtr_QA := pull(SNA.Key_Person_Cluster_Attributes);
cohesivity_table := SNA.file_person_cluster_stats;
Key_PCAtr_father := index( cohesivity_table, {cluster_id}, {cohesivity_table}, Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::sna::person_cluster_attributes_father' );

key_PCAtr_father_pull := pull(Key_PCAtr_father);

Key_PCAtr_QA trecs_atr(Key_PCAtr_QA L, key_PCAtr_father_pull R) := transform
self := L;
end;

jrecs_atr := join(distribute(Key_PCAtr_QA,HASH(cluster_id)),distribute(key_PCAtr_father_pull,HASH(cluster_id)),LEFT.cluster_id=RIGHT.cluster_id,trecs_atr(LEFT,RIGHT),LEFT ONLY,LOCAL);

pcasample := output(choosen(jrecs_atr,500),named('Person_Cluster_Attributes_Sample'));

//Diff Property cluster Stats

Key_PtyStats_QA := pull(SNA.Key_Prop_Cluster_Stats);
dc := SNA.DeedsClustering(cluster_id != 0);

t := record
	
  unsigned8 cluster_id;
  integer8 cluster_sales_count;
  integer8 cluster_flip_count;
  integer8 cluster_flip_count10;
  integer8 cluster_flip_count30;
  integer8 cluster_flip_count60;
  integer8 cluster_flip_count120;
  integer8 cluster_flip_count180;
  integer8 cluster_flip_0_degree;
  integer8 cluster_flip_1_degree;
  integer8 cluster_flip_2_degree;
  integer8 cluster_flip_business_count;
  integer8 cluster_flop_count;
  integer8 cluster_flop_person_count;
  integer8 cluster_flop_person_busines_count;
  integer8 cluster_in_network_count;
  integer8 cluster_in_network_count_0_degree;
  integer8 cluster_in_network_count_1_degree;
  integer8 cluster_in_network_count_2_degree;
  integer8 cluster_in_network_flip_business_count;
  integer8 cluster_in_network_flop;
  integer8 cluster_in_network_flip_count;
  integer8 cluster_in_network_flip_count_0_degree;
  integer8 cluster_in_network_flip_count_1_degree;
  integer8 cluster_in_network_flip_count_2_degree;
  integer8 cluster_high_profit_count;
  integer8 cluster_high_profit_count_0_degree;
  integer8 cluster_high_profit_count_1_degree;
  integer8 cluster_high_profit_count_2_degree;
  integer8 cluster_in_network_high_profit;
  integer8 cluster_in_network_high_profit_0_degree;
  integer8 cluster_in_network_high_profit_1_degree;
  integer8 cluster_in_network_high_profit_2_degree;
  integer8 cluster_in_network_high_profit_flip_count;
  integer8 cluster_default_count;
  integer8 cluster_default_count_0_degree;
  integer8 cluster_foreclosure_count;
  integer8 cluster_foreclosure_count_0_degree;
  integer8 cluster_foreclosure_default_count;
  integer8 cluster_foreclosure_default_count_0_degree;
  real8 prop_network_cohesivity;
  integer8 prop_1st_degrees;
  integer8 prop_2nd_degrees;
  real8 sales_count_stdd;
  integer8 flip_count_actors;
  real8 flip_count_stdd;
  integer8 cluster_ends_in_default_foreclosure;
  integer8 cluster_fha_count;
  integer8 cluster_va_count;
  integer8 prop_people_count;
  integer8 cluster_suspicious_govt_loan_count;
  integer8 distinct_property_count;
  integer8 high_incidence_flip_count;
  integer8 high_incidence_in_network_count;
  integer8 high_incidence_in_network_flip_count;
  integer8 high_incidence_high_profit_count;
  integer8 high_incidence_in_network_high_profit_count;
  integer8 high_incidence_in_network_high_profit_flip_count;
  unsigned2 totalcnt;
  unsigned2 firstdegrees;
  unsigned2 seconddegrees;
  real4 cohesivity;
  string25 p_city_name;
  unsigned8 __internal_fpos__;
 END;



Key_prop_cluster_stats_father := index(dc, {cluster_id}, {t}-{cluster_id}, Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::sna::property_ownership_cluster_stats_father');

Key_PtyStats_father_pull := pull(Key_prop_cluster_stats_father);

Key_PtyStats_QA trecs_stats(Key_PtyStats_QA L, Key_PtyStats_father_pull R) := transform
self := L;
end;

jrecs_stats := join(distribute(Key_PtyStats_QA,HASH(cluster_id)),distribute(Key_PtyStats_father_pull,HASH(cluster_id)),LEFT.cluster_id=RIGHT.cluster_id,trecs_stats(LEFT,RIGHT),LEFT ONLY,LOCAL);

pcssample := output(choosen(jrecs_stats,500),named('Property_Cluster_Stats_Sample'));

export out := Sequential( pcsample,
                          pcasample,
													pcssample ) : success( FileServices.SendEmail ( 'sudhir.kasavajjala@lexisnexis.com; Melanie.Jackson@lexisnexis.com; RISBCTQualityAssurance@lexisnexis.com','SNA -- QA Samples','QA -- Please view the following workunit for SNA Samples'+workunit )),
													              failure( FileServices.SendEmail ( 'sudhir.kasavajjala@lexisnexis.com; Melanie.Jackson@lexisnexis.com' ,'SNA -- QA Sample failure','SNA QA Sample WU failed :'+workunit));

end;

